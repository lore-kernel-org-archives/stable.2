Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B87A3AFB07
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 16:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785255047; cv=none; b=YgnmTH6flfgEEZ6gD76vBS60NSoFptnJC0+4pFd11mW1iGst7LjxPj87P0BOCWn6EpSjLcX9TDqvC7pC8K8E7PKvsbEb7Qb0XVwRETJ9hIMgnr/HLnFaAJcQvACbCU82mXE5Y6CCBKE+n/5H5uz/zmDsZg7uOiAxCtKWZ2sUT7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785255047; c=relaxed/simple;
	bh=Miza9Lz0Fjqu9BoRtJhWXmELVmZmBgKF7eEDlx+IZDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SpK3rax7ZyxRH8wUZVD03GW++dbDePUO1PgVrFCwe1Jn6CCs213thxJJ4SjZU6u+tAreOpc1Srpi2bu15PgoGhnBfw65UXHc3kakAUS6QloCenI+aeSG53oHkiqS7H5OvCRO0yZO2UkFXhq9hOJgOEA/2zEOF02IZZwnvYGLu0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMYKpXRT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMYKpXRT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BFB31F000E9;
	Tue, 28 Jul 2026 16:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785255046;
	bh=NxdozGiqsEn6/3GZ+0YzoQKlLi1oNjCLBLtwAYhy0fE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WMYKpXRTQCdJEVhSS6hfLNuToblGP8CzfbR6Te+KR50vnmUnoTvAsbCryrn6q1sUh
	 GGE7G+IM3C8pEmgyN4z98NQVlFAQ8xBvJTPZ+ejsSk1fNDOKDPWbpRNmoEr9rKw3WK
	 xaseUOxTrB09/vt0LV24fvcVv9lHofgZ2qyCGnLs5Uf3GzVYm3L7ltrf1l/S1DaSzu
	 84huCy7UKZ5gjZa7e8eSK/I09DIxoG+jEWa0CMjhsK7fv8ZEDaI4hHGUSW+Hwg6O89
	 zOzDlO/72iNSeBfl2iiHj1zMWZKS2BdI+ZAdkS+Z+4W+vnXHe7dfU7p4EL4SNIslHa
	 byed0eqSH/vDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 1/2] bootconfig: move xbc_snprint_cmdline() to lib/bootconfig.c
Date: Tue, 28 Jul 2026 12:10:42 -0400
Message-ID: <20260728161043.36478-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072111-pajamas-livable-c26a@gregkh>
References: <2026072111-pajamas-livable-c26a@gregkh>
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
index 692a5acc2ffc4f..1c7f3b74ffcf38 100644
--- a/include/linux/bootconfig.h
+++ b/include/linux/bootconfig.h
@@ -265,6 +265,9 @@ static inline struct xbc_node * __init xbc_node_get_subkey(struct xbc_node *node
 int __init xbc_node_compose_key_after(struct xbc_node *root,
 			struct xbc_node *node, char *buf, size_t size);
 
+/* Render key/value pairs under @root as a flat cmdline string */
+int __init xbc_snprint_cmdline(char *buf, size_t size, struct xbc_node *root);
+
 /**
  * xbc_node_compose_key() - Compose full key string of the XBC node
  * @node: An XBC node.
diff --git a/init/main.c b/init/main.c
index 96f93bb06c4901..e363232b428b47 100644
--- a/init/main.c
+++ b/init/main.c
@@ -324,51 +324,6 @@ static void * __init get_boot_config_from_initrd(size_t *_size)
 
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
index c470b93d5dbc2a..f445b7703fdd96 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -408,6 +408,62 @@ const char * __init xbc_node_find_next_key_value(struct xbc_node *root,
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
 
 static int __init xbc_init_node(struct xbc_node *node, char *data, uint16_t flag)
-- 
2.53.0

