Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA2F1A680C
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 00:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785285031; cv=none; b=HXjOAzAR1KSLP/59WmUc8JNyMEJxBkxrZwgyR6eoHHhWkXIhRe1LJ1Rl3CyKhheQ2kfT1AwMWaThz/qX0uIQgxRD7xZylYhv1zPAvAqnMTYPPxJQjX8mDnkF661sWDZsay+28jHQU91IvXcf33bT+cDCRqNMirB+BMDex7mjzaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785285031; c=relaxed/simple;
	bh=ASlrI+5RB31x0HIIa6QKH5EtP3nPA+XLmrWKx+XL3KU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qAV0KEM9VfDmfv0JP7PpxTQih+d1Xo+WeaU+WDiB1wDfzNlJtdoynmHVAEb0mjUauGDFPqDkNyWqWppB1ntjz+YNJQ1yLhxev6fNkmaq4ZXvh2wX4/BnraFAgXgrcDgaxq3oouGgjqAFkDUM0ri0Ofcj9wzA7GdtU9Ngl8jYL/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCiYnJgU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCiYnJgU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C131F00A3A;
	Wed, 29 Jul 2026 00:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785285030;
	bh=iYIPu96E0hdzdPvwfZxu6v4zizDkDG6e8i/HHQoMnts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HCiYnJgUspLlUvmR6zXztWt6HRkM56/JwfNsMMypzRlVBmUOpDxH1kFNxjz3ddb9I
	 LgYxu69QSsTK5HaUhsG60EpV9woFFLRtg7SgOpXodCrtoHOOhEwYbwXU5pOQjWF08W
	 NIDnATJCksHlJOz5W1sRwikjWRzaU1xRfBlc9HrgvI2k1yerBhJf7Lr62//EJjx/tM
	 Sp8UA0Xv0qgoJRMTG7PEs1rXhiqfIhjNI4WUfjSvVcBfuYjv7SRJpAy+ilQJo02O9v
	 Ycs10e7ox5TMCvJSaypmlsL+lRyU4+cdDk72TLIOj7Cg+fisIISo2EVjIsJGvfWo/l
	 CZkB8v/ZVEfnQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/3] bootconfig: move xbc_snprint_cmdline() to lib/bootconfig.c
Date: Tue, 28 Jul 2026 20:30:26 -0400
Message-ID: <20260729003027.887848-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729003027.887848-1-sashal@kernel.org>
References: <2026072113-duvet-tattling-a13a@gregkh>
 <20260729003027.887848-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Breno Leitao <leitao@debian.org>

[ Upstream commit 5a643e4623238e14b03d75ca0d4eda0645720cee ]

Move xbc_snprint_cmdline() from init/main.c to lib/bootconfig.c so the
function (and its xbc_namebuf scratch buffer) becomes part of the shared
parser library. tools/bootconfig already compiles lib/bootconfig.c
directly, which lets a follow-up patch reuse the same renderer in the
userspace tool to convert a bootconfig file into a flat cmdline string
at build time.

No functional change.

Link: https://lore.kernel.org/all/20260508-bootconfig_using_tools-v1-1-1132219aa773@debian.org/

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Stable-dep-of: dec4d8118c17 ("bootconfig: fix NULL-pointer arithmetic in xbc_snprint_cmdline()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/bootconfig.h |  3 ++
 init/main.c                | 45 ------------------------------
 lib/bootconfig.c           | 56 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 45 deletions(-)

diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
index df9cbf02d03031..39d2e2468c237f 100644
--- a/include/linux/bootconfig.h
+++ b/include/linux/bootconfig.h
@@ -202,6 +202,9 @@ static inline struct xbc_node * __init xbc_find_node(const char *key)
 int __init xbc_node_compose_key_after(struct xbc_node *root,
 			struct xbc_node *node, char *buf, size_t size);
 
+/* Render key/value pairs under @root as a flat cmdline string */
+int __init xbc_snprint_cmdline(char *buf, size_t size, struct xbc_node *root);
+
 /**
  * xbc_node_compose_key() - Compose full key string of the XBC node
  * @node: An XBC node.
diff --git a/init/main.c b/init/main.c
index 8aab715535dcad..d23d1a8d5393f8 100644
--- a/init/main.c
+++ b/init/main.c
@@ -314,51 +314,6 @@ static void * __init get_boot_config_from_initrd(u32 *_size, u32 *_csum)
 
 #ifdef CONFIG_BOOT_CONFIG
 
-static char xbc_namebuf[XBC_KEYLEN_MAX] __initdata;
-
-#define rest(dst, end) ((end) > (dst) ? (end) - (dst) : 0)
-
-static int __init xbc_snprint_cmdline(char *buf, size_t size,
-				      struct xbc_node *root)
-{
-	struct xbc_node *knode, *vnode;
-	char *end = buf + size;
-	const char *val, *q;
-	int ret;
-
-	xbc_node_for_each_key_value(root, knode, val) {
-		ret = xbc_node_compose_key_after(root, knode,
-					xbc_namebuf, XBC_KEYLEN_MAX);
-		if (ret < 0)
-			return ret;
-
-		vnode = xbc_node_get_child(knode);
-		if (!vnode) {
-			ret = snprintf(buf, rest(buf, end), "%s ", xbc_namebuf);
-			if (ret < 0)
-				return ret;
-			buf += ret;
-			continue;
-		}
-		xbc_array_for_each_value(vnode, val) {
-			/*
-			 * For prettier and more readable /proc/cmdline, only
-			 * quote the value when necessary, i.e. when it contains
-			 * whitespace.
-			 */
-			q = strpbrk(val, " \t\r\n") ? "\"" : "";
-			ret = snprintf(buf, rest(buf, end), "%s=%s%s%s ",
-				       xbc_namebuf, q, val, q);
-			if (ret < 0)
-				return ret;
-			buf += ret;
-		}
-	}
-
-	return buf - (end - size);
-}
-#undef rest
-
 /* Make an extra command line under given key word */
 static char * __init xbc_make_cmdline(const char *key)
 {
diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index b4c0c34cee13a7..3b3d666e207618 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -329,6 +329,62 @@ const char * __init xbc_node_find_next_key_value(struct xbc_node *root,
 		return "";	/* No value key */
 }
 
+static char xbc_namebuf[XBC_KEYLEN_MAX] __initdata;
+
+#define rest(dst, end) ((end) > (dst) ? (end) - (dst) : 0)
+
+/**
+ * xbc_snprint_cmdline() - Render bootconfig keys under @root as a cmdline string
+ * @buf: Destination buffer (may be NULL when @size is 0 to query the length)
+ * @size: Size of @buf in bytes
+ * @root: Subtree root whose key=value pairs should be rendered
+ *
+ * Walk all key/value pairs under @root and emit them as a space-separated
+ * cmdline string into @buf. Values containing whitespace are quoted with
+ * double quotes. Returns the number of bytes that would be written if @buf
+ * were large enough (matching snprintf semantics), or a negative errno on
+ * failure.
+ */
+int __init xbc_snprint_cmdline(char *buf, size_t size, struct xbc_node *root)
+{
+	struct xbc_node *knode, *vnode;
+	char *end = buf + size;
+	const char *val, *q;
+	int ret;
+
+	xbc_node_for_each_key_value(root, knode, val) {
+		ret = xbc_node_compose_key_after(root, knode,
+					xbc_namebuf, XBC_KEYLEN_MAX);
+		if (ret < 0)
+			return ret;
+
+		vnode = xbc_node_get_child(knode);
+		if (!vnode) {
+			ret = snprintf(buf, rest(buf, end), "%s ", xbc_namebuf);
+			if (ret < 0)
+				return ret;
+			buf += ret;
+			continue;
+		}
+		xbc_array_for_each_value(vnode, val) {
+			/*
+			 * For prettier and more readable /proc/cmdline, only
+			 * quote the value when necessary, i.e. when it contains
+			 * whitespace.
+			 */
+			q = strpbrk(val, " \t\r\n") ? "\"" : "";
+			ret = snprintf(buf, rest(buf, end), "%s=%s%s%s ",
+				       xbc_namebuf, q, val, q);
+			if (ret < 0)
+				return ret;
+			buf += ret;
+		}
+	}
+
+	return buf - (end - size);
+}
+#undef rest
+
 /* XBC parse and tree build */
 
 static int __init xbc_init_node(struct xbc_node *node, char *data, u32 flag)
-- 
2.53.0

