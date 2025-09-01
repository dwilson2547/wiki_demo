FROM node:bookworm AS builder

COPY markdown_renderer /app/markdown_renderer
WORKDIR /app/markdown_renderer
RUN npm install && npm run build

FROM nginx:latest
COPY --from=builder /app/markdown_renderer/dist/markdown-renderer/browser /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]