Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AAD5221E1
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 18:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583847; cv=none; b=Yp+Sve1hnphFCxYhIloHlEtEJfgQELkvEtmuplgIMiceX2Kv7PLTfNQLAnF5hG3LM609gZrCVF0unX6zWYW11Zbd+hnbJWtDI+kEfwnnRwq0tJ8DCA8ZRnoLZ40C3i7mNJPqkomYtICAdP1BLpe7ChM+/uvdezHpo70p+dZxyFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583847; c=relaxed/simple;
	bh=A6NdLuM6DbOEyrCvqWtFBJgcG+YKV0sPe7AyYTMkplA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iRn/5IZ1ade/vJk5vy4kP9ziT1DpxoJpRD8QGKO5JJJOsVNVKJb/n9ht2nHyF76qtYjyY5Sg4oXMZteQ+5f7c34JOAl59AW9KXCcAiyDARruDRPDbln4hmLCUJyRHvEvQDmeTuTOfzYqm176BiZiciFUNkz7Ew940tgw7AakY6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AfhkYZ1k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AfhkYZ1k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462C01F008AB;
	Wed, 16 Sep 2026 18:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789583814;
	bh=0NqInHb9vEPULYGgMhpNawzkRbXH4beraQj+bC9bMoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AfhkYZ1k2ChlCMDAk94E5/vdVu1pVUV6sL1maTwpN4L7urYH3zb3zaDOSFTN4+GlQ
	 X2gEV6XXJDHCr/lXn6qcbB6cnVMl2/vUbinRdQB9mpU9uYPEq4hY+BGmxQlv+7h1cu
	 qnqPA0741jBHYsg2JliZwf9Gl9UmExcUUQdxt1f0oopqrrXoq39/AVR6SI8MhOCPJ2
	 vDtG6uNLJO+EUZ3ObxBcTJn1GUmxxsTwO8pSiDb9JVEo6z/pxwZfKWIYDYVyC86e75
	 O6gMYTMfM007fSTLfwWCs5e7lbu0k6EgvoH6F8BICt3JvMaXMGHEM5gij2D2yjGhvK
	 JecdKKdrVq6Rg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	"Steven Rostedt (VMware)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/4] bootconfig: Replace u16 and u32 with uint16_t and uint32_t
Date: Wed, 16 Sep 2026 14:36:50 -0400
Message-ID: <20260916183652.1772436-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916183652.1772436-1-sashal@kernel.org>
References: <2026091616-brisket-appease-387d@gregkh>
 <20260916183652.1772436-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu <mhiramat@kernel.org>

[ Upstream commit 4f292c4886bfdfc2a7191ef4ff3f7aac69d1cc3f ]

Replace u16 and u32 with uint16_t and uint32_t so
that the tools/bootconfig only needs <stdint.h>.

Link: https://lkml.kernel.org/r/163187298835.2366983.9838262576854319669.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Stable-dep-of: 462d0b066b61 ("tools/bootconfig: Fix integer overflow and truncation in size checks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/bootconfig.h              | 12 ++++++------
 lib/bootconfig.c                        | 16 ++++++++--------
 tools/bootconfig/include/linux/kernel.h |  4 +---
 tools/bootconfig/main.c                 | 20 ++++++++++----------
 4 files changed, 25 insertions(+), 27 deletions(-)

diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
index 2105a94294ca6..740482314a1b2 100644
--- a/include/linux/bootconfig.h
+++ b/include/linux/bootconfig.h
@@ -25,10 +25,10 @@
  * The checksum will be used with the BOOTCONFIG_MAGIC and the size for
  * embedding the bootconfig in the initrd image.
  */
-static inline __init u32 xbc_calc_checksum(void *data, u32 size)
+static inline __init uint32_t xbc_calc_checksum(void *data, uint32_t size)
 {
 	unsigned char *p = data;
-	u32 ret = 0;
+	uint32_t ret = 0;
 
 	while (size--)
 		ret += *p++;
@@ -38,10 +38,10 @@ static inline __init u32 xbc_calc_checksum(void *data, u32 size)
 
 /* XBC tree node */
 struct xbc_node {
-	u16 next;
-	u16 child;
-	u16 parent;
-	u16 data;
+	uint16_t next;
+	uint16_t child;
+	uint16_t parent;
+	uint16_t data;
 } __attribute__ ((__packed__));
 
 #define XBC_KEY		0
diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index ac878b861c0b9..b4f11884f58b0 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -226,7 +226,7 @@ int __init xbc_node_compose_key_after(struct xbc_node *root,
 				      struct xbc_node *node,
 				      char *buf, size_t size)
 {
-	u16 keys[XBC_DEPTH_MAX];
+	uint16_t keys[XBC_DEPTH_MAX];
 	int depth = 0, ret = 0, total = 0;
 
 	if (!node || node == root)
@@ -406,21 +406,21 @@ int __init xbc_snprint_cmdline(char *buf, size_t size, struct xbc_node *root)
 
 /* XBC parse and tree build */
 
-static int __init xbc_init_node(struct xbc_node *node, char *data, u32 flag)
+static int __init xbc_init_node(struct xbc_node *node, char *data, uint32_t flag)
 {
 	unsigned long offset = data - xbc_data;
 
 	if (WARN_ON(offset >= XBC_DATA_MAX))
 		return -EINVAL;
 
-	node->data = (u16)offset | flag;
+	node->data = (uint16_t)offset | flag;
 	node->child = 0;
 	node->next = 0;
 
 	return 0;
 }
 
-static struct xbc_node * __init xbc_add_node(char *data, u32 flag)
+static struct xbc_node * __init xbc_add_node(char *data, uint32_t flag)
 {
 	struct xbc_node *node;
 
@@ -450,7 +450,7 @@ static inline __init struct xbc_node *xbc_last_child(struct xbc_node *node)
 	return node;
 }
 
-static struct xbc_node * __init __xbc_add_sibling(char *data, u32 flag, bool head)
+static struct xbc_node * __init __xbc_add_sibling(char *data, uint32_t flag, bool head)
 {
 	struct xbc_node *sib, *node = xbc_add_node(data, flag);
 
@@ -477,17 +477,17 @@ static struct xbc_node * __init __xbc_add_sibling(char *data, u32 flag, bool hea
 	return node;
 }
 
-static inline struct xbc_node * __init xbc_add_sibling(char *data, u32 flag)
+static inline struct xbc_node * __init xbc_add_sibling(char *data, uint32_t flag)
 {
 	return __xbc_add_sibling(data, flag, false);
 }
 
-static inline struct xbc_node * __init xbc_add_head_sibling(char *data, u32 flag)
+static inline struct xbc_node * __init xbc_add_head_sibling(char *data, uint32_t flag)
 {
 	return __xbc_add_sibling(data, flag, true);
 }
 
-static inline __init struct xbc_node *xbc_add_child(char *data, u32 flag)
+static inline __init struct xbc_node *xbc_add_child(char *data, uint32_t flag)
 {
 	struct xbc_node *node = xbc_add_sibling(data, flag);
 
diff --git a/tools/bootconfig/include/linux/kernel.h b/tools/bootconfig/include/linux/kernel.h
index c4854b8e70237..39f306c18dd0c 100644
--- a/tools/bootconfig/include/linux/kernel.h
+++ b/tools/bootconfig/include/linux/kernel.h
@@ -3,11 +3,9 @@
 #define _SKC_LINUX_KERNEL_H
 
 #include <stdlib.h>
+#include <stdint.h>
 #include <stdbool.h>
 
-typedef unsigned short u16;
-typedef unsigned int   u32;
-
 #define unlikely(cond)	(cond)
 
 #define __init
diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index dd51ee6f508c4..ba0be1679df3e 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -181,7 +181,7 @@ static int load_xbc_from_initrd(int fd, char **buf)
 {
 	struct stat stat;
 	int ret;
-	u32 size = 0, csum = 0, rcsum;
+	uint32_t size = 0, csum = 0, rcsum;
 	char magic[BOOTCONFIG_MAGIC_LEN];
 	const char *msg;
 
@@ -205,11 +205,11 @@ static int load_xbc_from_initrd(int fd, char **buf)
 	if (lseek(fd, -(8 + BOOTCONFIG_MAGIC_LEN), SEEK_END) < 0)
 		return pr_errno("Failed to lseek for size", -errno);
 
-	if (read(fd, &size, sizeof(u32)) < 0)
+	if (read(fd, &size, sizeof(uint32_t)) < 0)
 		return pr_errno("Failed to read size", -errno);
 	size = le32toh(size);
 
-	if (read(fd, &csum, sizeof(u32)) < 0)
+	if (read(fd, &csum, sizeof(uint32_t)) < 0)
 		return pr_errno("Failed to read checksum", -errno);
 	csum = le32toh(csum);
 
@@ -367,7 +367,7 @@ static int apply_xbc(const char *path, const char *xbc_path)
 	size_t total_size;
 	struct stat stat;
 	const char *msg;
-	u32 size, csum;
+	uint32_t size, csum;
 	int pos, pad;
 	int ret, fd;
 
@@ -381,7 +381,7 @@ static int apply_xbc(const char *path, const char *xbc_path)
 
 	/* Backup the bootconfig data */
 	data = calloc(size + BOOTCONFIG_ALIGN +
-		      sizeof(u32) + sizeof(u32) + BOOTCONFIG_MAGIC_LEN, 1);
+		      sizeof(uint32_t) + sizeof(uint32_t) + BOOTCONFIG_MAGIC_LEN, 1);
 	if (!data)
 		return -ENOMEM;
 	memcpy(data, buf, size);
@@ -428,17 +428,17 @@ static int apply_xbc(const char *path, const char *xbc_path)
 	}
 
 	/* To align up the total size to BOOTCONFIG_ALIGN, get padding size */
-	total_size = stat.st_size + size + sizeof(u32) * 2 + BOOTCONFIG_MAGIC_LEN;
+	total_size = stat.st_size + size + sizeof(uint32_t) * 2 + BOOTCONFIG_MAGIC_LEN;
 	pad = ((total_size + BOOTCONFIG_ALIGN - 1) & (~BOOTCONFIG_ALIGN_MASK)) - total_size;
 	size += pad;
 
 	/* Add a footer */
 	p = data + size;
-	*(u32 *)p = htole32(size);
-	p += sizeof(u32);
+	*(uint32_t *)p = htole32(size);
+	p += sizeof(uint32_t);
 
-	*(u32 *)p = htole32(csum);
-	p += sizeof(u32);
+	*(uint32_t *)p = htole32(csum);
+	p += sizeof(uint32_t);
 
 	memcpy(p, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN);
 	p += BOOTCONFIG_MAGIC_LEN;
-- 
2.53.0

