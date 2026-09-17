Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E77438333A
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 02:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789611547; cv=none; b=Uo4URv8z6Op6Pq0zqAj/mkgdAOddbdTyiVGCOsu75FzERz0rmWKqgnoYcuAy9QHvH7da186KmFhj4JAX6S7f581hXssnwjaI8GV94HrL9iOE68RW1PL8Ctiyjf4CcnS6R2VPqmG7ehEHgCpe3M2yqG92xnttWObrH9p7oSCXqGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789611547; c=relaxed/simple;
	bh=VVSB16shPTJ+8N4zP8Yxi2MIXvXRtGLDsjoZC6v9e98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cuyS9w2bBljxVbvOaX7eE/RpgoMVkxwJEwoWBosJcbl5BPveD/HL+LFeHqpZCO0g1n/byAn1dID8ltM1z4zKF/btb7HEt/de5ciaPS7Ucs6oLTIT6KHuVpBOSfetQbix50mZjEu9gVGPtRsYK+jF0xNMfaJ9gW2eGqM8wxdf/jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNY87Z5q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNY87Z5q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62DAE1F00898;
	Thu, 17 Sep 2026 02:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789611546;
	bh=hjOqSnQ6TZVQm+kTSL+R3WKWtJUkmkdwcHKXRGrLGLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QNY87Z5qUcSugdcSVLybe2GwdUPRTkJEtgD4Ws0nzbRqqo7tJR4CRMMkjdBGQq1fo
	 AMru1XDvTdYrPVx4e3g99aH53lUOaFdW1Iiv4njzh/Nc7SLRfrtB64NNwmIc+WVB5X
	 bpYLOWIEx6RmZl/Qy6UlKly0tDwv0nXXB52F7GqTbZuFYrjD+07MaWB+Gr6/9G+G3b
	 Ij6i+vcVcX6KxcYgRAdw9iF3Rnz5HyxNHt8z2/Mj9kvp4KHT97nzxIof8cT91b+FTz
	 7tdvGu1a1pfbkMEzbUYWuLL9HGLMLYpM51wm1tNPZ7M9FaA0Vi9ig8rFvSmCXXsLq+
	 F1b5ZDkb/PBZg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sun Jian <sun.jian.kdev@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/4] init/main: read bootconfig header with get_unaligned_le32()
Date: Wed, 16 Sep 2026 22:19:01 -0400
Message-ID: <20260917021902.3810750-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917021902.3810750-1-sashal@kernel.org>
References: <2026091618-used-flashbulb-70ef@gregkh>
 <20260917021902.3810750-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sun Jian <sun.jian.kdev@gmail.com>

[ Upstream commit 499f86de4f8c34e19a57daf2b6f0cba848e91994 ]

get_boot_config_from_initrd() scans up to 3 bytes before initrd_end to
handle GRUB 4-byte alignment.  As a result, the bootconfig header
immediately preceding the magic may be unaligned.

Read the size and checksum fields with get_unaligned_le32() instead of
casting to u32 * and using le32_to_cpu(), avoiding potential unaligned
access and silencing sparse "cast to restricted __le32" warnings.

Sparse warnings (gcc + C=1):
  init/main.c:292:16: warning: cast to restricted __le32
  init/main.c:293:16: warning: cast to restricted __le32

No functional change intended.

Link: https://lkml.kernel.org/r/20260113101532.1630770-1-sun.jian.kdev@gmail.com
Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Stable backport notes:
- Use <asm/unaligned.h>, the unaligned-access header provided by 5.10.
- Reuse and relocate the existing boot_config_checksum() implementation as
  xbc_calc_checksum(), and validate the checksum before trimming the initrd,
  as in 765b8552a200. No additional function is introduced.
- Adapt the existing xbc_init() and its callers to the explicit-size,
  internally owned buffer interface from bdac5c2b243f. Use the 5.10
  memblock_free(__pa(...), ...) API, handle partial allocation cleanup, and
  initialize the parser result after removing the strlen() assignment.
- Repair the inherited ns_common_init() from b033981390f7: 5.10 has no
  common count field and stashed is atomic_long_t, so initialize it with
  atomic_long_set() and leave per-namespace reference counts alone.
- Match the size-check diagnostic context so target 7812d6dab069 applies
  unchanged. Its overflow and footer-bounds checks remain in the target.

These adaptations bridge the older bootconfig implementation without
pulling in unrelated modern init headers or adding functions.

Stable-dep-of: 7812d6dab069 ("bootconfig: Fix integer overflow in initrd size check")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/bootconfig.h |  2 +-
 include/linux/proc_ns.h    |  3 +-
 init/main.c                | 69 +++++++++++++++++---------------------
 lib/bootconfig.c           | 41 ++++++++++++++--------
 tools/bootconfig/main.c    |  6 ++--
 5 files changed, 62 insertions(+), 59 deletions(-)

diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
index 39d2e2468c237..15c3328ad60cc 100644
--- a/include/linux/bootconfig.h
+++ b/include/linux/bootconfig.h
@@ -222,7 +222,7 @@ static inline int __init xbc_node_compose_key(struct xbc_node *node,
 }
 
 /* XBC node initializer */
-int __init xbc_init(char *buf, const char **emsg, int *epos);
+int __init xbc_init(const char *data, size_t size, const char **emsg, int *epos);
 
 
 /* XBC cleanup data structures */
diff --git a/include/linux/proc_ns.h b/include/linux/proc_ns.h
index 5ea4835550823..b726eafbd2584 100644
--- a/include/linux/proc_ns.h
+++ b/include/linux/proc_ns.h
@@ -80,8 +80,7 @@ static inline int ns_common_init(struct ns_common *ns,
 		if (ret)
 			return ret;
 	}
-	refcount_set(&ns->count, 1);
-	ns->stashed = NULL;
+	atomic_long_set(&ns->stashed, 0);
 	ns->ops = ops;
 	return 0;
 }
diff --git a/init/main.c b/init/main.c
index d23d1a8d5393f..4da396cc3af71 100644
--- a/init/main.c
+++ b/init/main.c
@@ -102,6 +102,7 @@
 #include <asm/setup.h>
 #include <asm/sections.h>
 #include <asm/cacheflush.h>
+#include <asm/unaligned.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/initcall.h>
@@ -262,11 +263,22 @@ static int __init loglevel(char *str)
 early_param("loglevel", loglevel);
 
 #ifdef CONFIG_BLK_DEV_INITRD
-static void * __init get_boot_config_from_initrd(u32 *_size, u32 *_csum)
+static u32 __init xbc_calc_checksum(const void *data, u32 size)
+{
+	const unsigned char *p = data;
+	u32 ret = 0;
+
+	while (size--)
+		ret += *p++;
+
+	return ret;
+}
+
+static void * __init get_boot_config_from_initrd(u32 *_size)
 {
 	u32 size, csum;
 	char *data;
-	u32 *hdr;
+	u8 *hdr;
 	int i;
 
 	if (!initrd_end)
@@ -285,9 +297,9 @@ static void * __init get_boot_config_from_initrd(u32 *_size, u32 *_csum)
 	return NULL;
 
 found:
-	hdr = (u32 *)(data - 8);
-	size = le32_to_cpu(hdr[0]);
-	csum = le32_to_cpu(hdr[1]);
+	hdr = (u8 *)(data - 8);
+	size = get_unaligned_le32(hdr);
+	csum = get_unaligned_le32(hdr + 4);
 
 	data = ((void *)hdr) - size;
 	if ((unsigned long)data < initrd_start) {
@@ -296,17 +308,20 @@ static void * __init get_boot_config_from_initrd(u32 *_size, u32 *_csum)
 		return NULL;
 	}
 
+	if (xbc_calc_checksum(data, size) != csum) {
+		pr_err("bootconfig checksum failed\n");
+		return NULL;
+	}
+
 	/* Remove bootconfig from initramfs/initrd */
 	initrd_end = (unsigned long)data;
 	if (_size)
 		*_size = size;
-	if (_csum)
-		*_csum = csum;
 
 	return data;
 }
 #else
-static void * __init get_boot_config_from_initrd(u32 *_size, u32 *_csum)
+static void * __init get_boot_config_from_initrd(u32 *_size)
 {
 	return NULL;
 }
@@ -346,16 +361,6 @@ static char * __init xbc_make_cmdline(const char *key)
 	return new_cmdline;
 }
 
-static u32 boot_config_checksum(unsigned char *p, u32 size)
-{
-	u32 ret = 0;
-
-	while (size--)
-		ret += *p++;
-
-	return ret;
-}
-
 static int __init bootconfig_params(char *param, char *val,
 				    const char *unused, void *arg)
 {
@@ -370,12 +375,12 @@ static void __init setup_boot_config(const char *cmdline)
 	static char tmp_cmdline[COMMAND_LINE_SIZE] __initdata;
 	const char *msg;
 	int pos;
-	u32 size, csum;
-	char *data, *copy, *err;
+	u32 size;
+	char *data, *err;
 	int ret;
 
 	/* Cut out the bootconfig data even if we have no bootconfig option */
-	data = get_boot_config_from_initrd(&size, &csum);
+	data = get_boot_config_from_initrd(&size);
 
 	strlcpy(tmp_cmdline, boot_command_line, COMMAND_LINE_SIZE);
 	err = parse_args("bootconfig", tmp_cmdline, NULL, 0, 0, 0, NULL,
@@ -394,26 +399,12 @@ static void __init setup_boot_config(const char *cmdline)
 	}
 
 	if (size >= XBC_DATA_MAX) {
-		pr_err("bootconfig size %d greater than max size %d\n",
-			size, XBC_DATA_MAX);
+		pr_err("bootconfig size %ld greater than max size %d\n",
+			(long)size, XBC_DATA_MAX);
 		return;
 	}
 
-	if (boot_config_checksum((unsigned char *)data, size) != csum) {
-		pr_err("bootconfig checksum failed\n");
-		return;
-	}
-
-	copy = memblock_alloc(size + 1, SMP_CACHE_BYTES);
-	if (!copy) {
-		pr_err("Failed to allocate memory for bootconfig\n");
-		return;
-	}
-
-	memcpy(copy, data, size);
-	copy[size] = '\0';
-
-	ret = xbc_init(copy, &msg, &pos);
+	ret = xbc_init(data, size, &msg, &pos);
 	if (ret < 0) {
 		if (pos < 0)
 			pr_err("Failed to init bootconfig: %s.\n", msg);
@@ -435,7 +426,7 @@ static void __init setup_boot_config(const char *cmdline)
 static void __init setup_boot_config(const char *cmdline)
 {
 	/* Remove bootconfig data from initrd */
-	get_boot_config_from_initrd(NULL, NULL);
+	get_boot_config_from_initrd(NULL);
 }
 
 static int __init warn_bootconfig(char *str)
diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index f6bede03c6926..5d2fa27de8ce6 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -814,32 +814,37 @@ static int __init xbc_verify_tree(void)
  */
 void __init xbc_destroy_all(void)
 {
+	if (xbc_data)
+		memblock_free(__pa(xbc_data), xbc_data_size);
 	xbc_data = NULL;
 	xbc_data_size = 0;
 	xbc_node_num = 0;
-	memblock_free(__pa(xbc_nodes), sizeof(struct xbc_node) * XBC_NODE_MAX);
+	if (xbc_nodes)
+		memblock_free(__pa(xbc_nodes),
+			      sizeof(struct xbc_node) * XBC_NODE_MAX);
 	xbc_nodes = NULL;
 	brace_index = 0;
 }
 
 /**
  * xbc_init() - Parse given XBC file and build XBC internal tree
- * @buf: boot config text
+ * @data: The boot config text original data
+ * @size: The size of @data
  * @emsg: A pointer of const char * to store the error message
  * @epos: A pointer of int to store the error position
  *
- * This parses the boot config text in @buf. @buf must be a
- * null terminated string and smaller than XBC_DATA_MAX.
+ * This parses the boot config text in @data. @size must not exceed
+ * XBC_DATA_MAX.
  * Return the number of stored nodes (>0) if succeeded, or -errno
  * if there is any error.
  * In error cases, @emsg will be updated with an error message and
  * @epos will be updated with the error position which is the byte offset
- * of @buf. If the error is not a parser error, @epos will be -1.
+ * of @data. If the error is not a parser error, @epos will be -1.
  */
-int __init xbc_init(char *buf, const char **emsg, int *epos)
+int __init xbc_init(const char *data, size_t size, const char **emsg, int *epos)
 {
 	char *p, *q;
-	int ret, c;
+	int ret = 0, c;
 
 	if (epos)
 		*epos = -1;
@@ -850,27 +855,35 @@ int __init xbc_init(char *buf, const char **emsg, int *epos)
 		return -EBUSY;
 	}
 
-	ret = strlen(buf);
-	if (ret > XBC_DATA_MAX - 1 || ret == 0) {
+	if (size > XBC_DATA_MAX || size == 0) {
 		if (emsg)
-			*emsg = ret ? "Config data is too big" :
+			*emsg = size ? "Config data is too big" :
 				"Config data is empty";
 		return -ERANGE;
 	}
 
+	xbc_data = memblock_alloc(size + 1, SMP_CACHE_BYTES);
+	if (!xbc_data) {
+		if (emsg)
+			*emsg = "Failed to allocate bootconfig data";
+		return -ENOMEM;
+	}
+	memcpy(xbc_data, data, size);
+	xbc_data[size] = '\0';
+	xbc_data_size = size + 1;
+
 	xbc_nodes = memblock_alloc(sizeof(struct xbc_node) * XBC_NODE_MAX,
 				   SMP_CACHE_BYTES);
 	if (!xbc_nodes) {
 		if (emsg)
 			*emsg = "Failed to allocate bootconfig nodes";
+		xbc_destroy_all();
 		return -ENOMEM;
 	}
 	memset(xbc_nodes, 0, sizeof(struct xbc_node) * XBC_NODE_MAX);
-	xbc_data = buf;
-	xbc_data_size = ret + 1;
-	last_parent = NULL;
 
-	p = buf;
+	last_parent = NULL;
+	p = xbc_data;
 	do {
 		q = strpbrk(p, "{}=+;:\n#");
 		if (!q) {
diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 387cb91862dfc..39081b2d768f1 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -214,7 +214,7 @@ static int load_xbc_from_initrd(int fd, char **buf)
 		return -EINVAL;
 	}
 
-	ret = xbc_init(*buf, &msg, NULL);
+	ret = xbc_init(*buf, size, &msg, NULL);
 	/* Wrong data */
 	if (ret < 0) {
 		pr_err("parse error: %s.\n", msg);
@@ -254,7 +254,7 @@ static int init_xbc_with_error(char *buf, int len)
 	if (!copy)
 		return -ENOMEM;
 
-	ret = xbc_init(buf, &msg, &pos);
+	ret = xbc_init(buf, len, &msg, &pos);
 	if (ret < 0)
 		show_xbc_error(copy, msg, pos);
 	free(copy);
@@ -367,7 +367,7 @@ static int apply_xbc(const char *path, const char *xbc_path)
 	memcpy(data, buf, size);
 
 	/* Check the data format */
-	ret = xbc_init(buf, &msg, &pos);
+	ret = xbc_init(buf, size, &msg, &pos);
 	if (ret < 0) {
 		show_xbc_error(data, msg, pos);
 		free(data);
-- 
2.53.0

