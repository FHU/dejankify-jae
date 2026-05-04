# # Stage 1: Install dependencies
# FROM node:22-alpine AS deps
# WORKDIR /app
# COPY package.json package-lock.json ./
# COPY prisma ./prisma
# RUN npm ci

# # Stage 2: Build the app
# FROM node:22-alpine AS builder
# WORKDIR /app
# COPY --from=deps /app/node_modules ./node_modules
# COPY . .
# # This step generates the client into /app/generated/prisma
# RUN npm run db:generate 
# RUN npm run build

# # Stage 3: Production image
# FROM node:22-alpine AS runner
# WORKDIR /app

# ENV NODE_ENV=production

# # Create a non-root user
# RUN addgroup --system --gid 1001 nodejs
# RUN adduser --system --uid 1001 nextjs

# COPY --from=builder /app/public ./public
# COPY --from=builder --chown=nextjs:nodejs /app/.next/standalone ./
# COPY --from=builder --chown=nextjs:nodejs /app/.next/static ./.next/static

# # COPY 1: Bring over the Prisma schema (Required for 'db push')
# COPY --from=builder --chown=nextjs:nodejs /app/prisma ./prisma

# # COPY 2: Bring over your custom-generated Prisma Client
# COPY --from=builder --chown=nextjs:nodejs /app/generated ./generated


# #COPY --chown=nextjs:nodejs .env.production .env

# USER nextjs
# EXPOSE 3000
# ENV PORT=3000

# # AUTOMATION: Sync the database, then start the Next.js server
# CMD ["sh", "-c", "until npx prisma db push --config prisma.config.ts; do echo 'Waiting for DB...'; sleep 2; done && node server.js"]



FROM node:22-alpine AS deps
WORKDIR /app
COPY package.json package-lock.json ./
COPY prisma ./prisma
RUN npm ci

# Stage 2: Build the app
FROM node:22-alpine AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
ENV DATABASE_URL="postgresql://dummy:dummy@localhost:5432/dummy"
RUN npx prisma generate
RUN npm run build

# Stage 3: Production image
FROM node:22-alpine AS runner
WORKDIR /app

ENV NODE_ENV=production

# Create a non-root user
RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

COPY --from=builder /app/public ./public
COPY --from=builder --chown=nextjs:nodejs /app/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /app/.next/static ./.next/static

USER nextjs
EXPOSE 3000
ENV PORT=3000

CMD ["node", "server.js"]