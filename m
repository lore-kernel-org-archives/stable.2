Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEE9378D70
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 16:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785256190; cv=none; b=O9sz967pWWzKklJXd6heNUBf2h/S7Z7Ob9PIywgjy2ivZYqfxluMUgjaWDOZz3Ta/oHDkJyM02HCU7AGeZ5zcinM61fgbgQ5tWudtdllPbeoJx/BX7Ln91qbPT/7Xubv+F05IBDrpZXzEFusxzHzgog13QVMkQt4NkK3qGTGbUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785256190; c=relaxed/simple;
	bh=aLZL7YK0Z9hHcOHSfpziOF6bTVSyY3r/kKQsmCv8SAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ODNBXNeHC7zGp12CtS+cygh0Elm0EcZJlvWEtOUWidhegWvTu1GoJ8aQrW1QdGJ9gYQHY+hkBEuJ7VGFOb87dzymwA4sbROSI1++u57LbuAVqoKhpQ1dEcQH9hMuLKjoP18CyeJmJPfTBNOfnqLYsrGNnrLd6+eM3c4SeMCuLG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmEx8tyC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmEx8tyC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2A11F000E9;
	Tue, 28 Jul 2026 16:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785256188;
	bh=V5lrKFgzxdu4VmoWQsqk7GiLATYJ+hajzyiSjJR/72s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NmEx8tyCXibf5s52Qqlfps2sgilkpm6xXbQAUsZK+uJzNx2NwhQAveEfGs1aIGZwF
	 a9dpNDcKr+3+njQu6qfsAc5XP16GOs9oCUMY+0J4hHOpC2P4QAHVH2+B9r+VZQCcgb
	 YcrOgK3qPU20yPBC+LCN+hJJqblDPMi9YORSy0RzNQy/neaU6Hwz8RdyiiDG8CrY2v
	 XIqyeuV0dwrHJfUH5M0JJhBci7dPHFDEoHuDGc5naAMZA+a1ZHZbOKxfC+X7kRNnJU
	 UeuhCyzENNmCBvJjekL8d/EZFZk/u90nNrQqgxX5Fx9MwZygNV/qDsTd1Kb6vlWA82
	 bLOWR/JvYWzeQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] bootconfig: move xbc_snprint_cmdline() to lib/bootconfig.c
Date: Tue, 28 Jul 2026 12:29:45 -0400
Message-ID: <20260728162946.99526-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072111-dizzy-spur-667f@gregkh>
References: <2026072111-dizzy-spur-667f@gregkh>
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
index 25df9260d206da..1f6e9c54a2a5ef 100644
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
index 048a6253824297..e3ef1eb34aa3e5 100644
--- a/init/main.c
+++ b/init/main.c
@@ -320,51 +320,6 @@ static void * __init get_boot_config_from_initrd(size_t *_size)
 
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
index 5d3802eba52a3b..c149ee8eb55dfc 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -405,6 +405,62 @@ const char * __init xbc_node_find_next_key_value(struct xbc_node *root,
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
 
 static int __init xbc_init_node(struct xbc_node *node, char *data, uint32_t flag)
-- 
2.53.0

