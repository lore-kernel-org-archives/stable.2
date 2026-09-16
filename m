Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714C24A5C33
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 19:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789585693; cv=none; b=pXlH4jyJsYhld26Pqo7pi3ihpx1LQiRcxP7+cd1YzxZHKd5jBZhpP4ACTpYz2ePve6o99Hx1p5odcZZQyO2v2hc7ShU7d7pM+p7SNNB2Dff6a7jTicXPfoZZCWm85gcVI3ry6+bv8yRzSo37uKO3pcYPHj3vOFaejIxvLmogpG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789585693; c=relaxed/simple;
	bh=4oDitDtJALHlp1dM6pNSDn4maWxlt+pyp/HeyYqLP5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CiFnEFTwgPoHBmgkC3+R28gavZOJVytUQYKeKh+7sU0YL5y57GMpMhZ7zUOFEcbU2AJp0Zp8m3LN91leiBlwuAMXEdlzEN5O02sYts5WJ0P2bjW3+6NfIFVbzsuU2ErJGceYjQdjL14jT3KmneDgNpjMTjF0Vu5TXo7cPv+3pbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDokMNfT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDokMNfT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E991F0089D;
	Wed, 16 Sep 2026 19:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789585660;
	bh=Z7AlOhxnorjw700ikxQ3FSGZbqKwghajujC8rPs0xr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aDokMNfT1y+pC77krJDJp1LircLSZ+tSP7KPXlf2aj8OVN4JbsjGnbUQP/3rcRi29
	 gotw8p7/IFXzjP4hI9TKhz505+vQYSZwhn+AeMxkjvW6nFFyjZSyfSXXMSLmtkQLAt
	 6IQ1jY6olMmtVcxXbk8zYEzLJylVTNXL1ntSEzgOykzGIjAB3KPfmVENQmFKXynM8b
	 EPMpdhlAvU+iQb7tbBmAi37Q2JpSo7z8DY+6ATDpVs+er5zKAI0E6rYJz7qOT8XrDv
	 eRHYw9isU60P4Ho7wKFeKLVsys3ezrAzzIyLEXbuWrTWnIuDLrnn6I4rpt+vn4oJ4Y
	 7ggA5UykeoaKg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	"Steven Rostedt (VMware)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 5/7] bootconfig: Replace u16 and u32 with uint16_t and uint32_t
Date: Wed, 16 Sep 2026 15:07:33 -0400
Message-ID: <20260916190735.1968203-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916190735.1968203-1-sashal@kernel.org>
References: <2026091617-cackle-deeply-2ea2@gregkh>
 <20260916190735.1968203-1-sashal@kernel.org>
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

[Stable backport: Convert the existing 5.10 xbc_add_sibling() and
xbc_add_child() argument types without importing the newer sibling-helper
refactor or adding functions. Retain the stable parser implementation.

Restore the tools-only linux/printk.h shim removed by the preceding
stderr-conversion dependency. The older parser still includes it for
xbc_debug_dump(), and it also supplies the stdio declarations used by
xbc_snprint_cmdline(). Without it the bootconfig tool cannot compile.

Define BOOTCONFIG_FOOTER_SIZE and use it in the initrd size check, taking
only the context needed from 26dda5769509 ("tools/bootconfig: Cleanup
bootconfig footer size calculations"). This lets the size-check fix in
462d0b066b61 apply unchanged; leave its new validation to that commit.]

Stable-dep-of: 462d0b066b61 ("tools/bootconfig: Fix integer overflow and truncation in size checks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/bootconfig.h              | 12 ++++++------
 lib/bootconfig.c                        | 12 ++++++------
 tools/bootconfig/include/linux/kernel.h |  4 +---
 tools/bootconfig/include/linux/printk.h | 14 +++++++++++++
 tools/bootconfig/main.c                 | 26 ++++++++++++++-----------
 5 files changed, 42 insertions(+), 26 deletions(-)
 create mode 100644 tools/bootconfig/include/linux/printk.h

diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
index 47d2116883b15..32940f3c7ad33 100644
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
index 36146607912e8..26b4c1dc9e04c 100644
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
@@ -396,21 +396,21 @@ int __init xbc_snprint_cmdline(char *buf, size_t size, struct xbc_node *root)
 
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
 
@@ -440,7 +440,7 @@ static inline __init struct xbc_node *xbc_last_child(struct xbc_node *node)
 	return node;
 }
 
-static struct xbc_node * __init xbc_add_sibling(char *data, u32 flag)
+static struct xbc_node * __init xbc_add_sibling(char *data, uint32_t flag)
 {
 	struct xbc_node *sib, *node = xbc_add_node(data, flag);
 
@@ -465,7 +465,7 @@ static struct xbc_node * __init xbc_add_sibling(char *data, u32 flag)
 	return node;
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
diff --git a/tools/bootconfig/include/linux/printk.h b/tools/bootconfig/include/linux/printk.h
new file mode 100644
index 0000000000000..036e667596eb1
--- /dev/null
+++ b/tools/bootconfig/include/linux/printk.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _SKC_LINUX_PRINTK_H
+#define _SKC_LINUX_PRINTK_H
+
+#include <stdio.h>
+
+#define printk(fmt, ...) printf(fmt, ##__VA_ARGS__)
+
+#define pr_err printk
+#define pr_warn	printk
+#define pr_info	printk
+#define pr_debug printk
+
+#endif
diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 6dd8afb954e48..358c7007dfe8c 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -17,6 +17,10 @@
 
 #define pr_err(fmt, ...) fprintf(stderr, fmt, ##__VA_ARGS__)
 
+/* Bootconfig footer is [size][csum][BOOTCONFIG_MAGIC]. */
+#define BOOTCONFIG_FOOTER_SIZE	\
+	(sizeof(uint32_t) * 2 + BOOTCONFIG_MAGIC_LEN)
+
 static int xbc_show_value(struct xbc_node *node, bool semicolon)
 {
 	const char *val, *eol;
@@ -150,7 +154,7 @@ static int load_xbc_from_initrd(int fd, char **buf)
 {
 	struct stat stat;
 	int ret;
-	u32 size = 0, csum = 0, rcsum;
+	uint32_t size = 0, csum = 0, rcsum;
 	char magic[BOOTCONFIG_MAGIC_LEN];
 	const char *msg;
 
@@ -174,16 +178,16 @@ static int load_xbc_from_initrd(int fd, char **buf)
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
 
 	/* Wrong size error  */
-	if (stat.st_size < size + 8 + BOOTCONFIG_MAGIC_LEN) {
+	if (stat.st_size < size + BOOTCONFIG_FOOTER_SIZE) {
 		pr_err("bootconfig size is too big\n");
 		return -E2BIG;
 	}
@@ -336,7 +340,7 @@ static int apply_xbc(const char *path, const char *xbc_path)
 	size_t total_size;
 	struct stat stat;
 	const char *msg;
-	u32 size, csum;
+	uint32_t size, csum;
 	int pos, pad;
 	int ret, fd;
 
@@ -350,7 +354,7 @@ static int apply_xbc(const char *path, const char *xbc_path)
 
 	/* Backup the bootconfig data */
 	data = calloc(size + BOOTCONFIG_ALIGN +
-		      sizeof(u32) + sizeof(u32) + BOOTCONFIG_MAGIC_LEN, 1);
+		      sizeof(uint32_t) + sizeof(uint32_t) + BOOTCONFIG_MAGIC_LEN, 1);
 	if (!data)
 		return -ENOMEM;
 	memcpy(data, buf, size);
@@ -397,17 +401,17 @@ static int apply_xbc(const char *path, const char *xbc_path)
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

