Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B1937BE6C
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 16:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785256191; cv=none; b=KnwEFhhqbCgq/TEKTWGApazMnrGjMMUQyR9oycVos4nV+JjtILa7L4b77KShr2L1uvP6cNU7WXCHP0EdEId64yI2YYRQakyG3wcJf/UScBjJv/As/KKeCvmFZHPQ1zY8sNmaYzQ/EviDJp70e8ThBjCsuBe21aEP/dPppEyT51I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785256191; c=relaxed/simple;
	bh=tDOy789lAKvxzvnBWfV7jqg7q5cEFH0OYBZElziyUAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I0dMYxzZxRpvGZL4yInMUxjnXw7ysUJ+zirdG7s1Hy4VIHfx32HN3y+UPFLTFYt8mB08BLtFiVgG24s0XyhISXrbJfHwxVwOfXQ3dUHx66LHwKaSXGnSEk6UmqTflnhaY4E4ort26Te2lpL2K1/zEELNb/S5pmBFc+iTX6JyiFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2tqdtPe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2tqdtPe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26EC51F00A3E;
	Tue, 28 Jul 2026 16:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785256189;
	bh=HppW+I++3zBE3FND+ZHwBBxdWTlajuQppY13UBsvc54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H2tqdtPeOkONFDJ8e6OdqgBdVdMxQuivJW0diFauruufmkJKCDvASIhtjtvyKUuU0
	 G3GGkyLKuurKI4NmdXyVvSetTOo0ON7zjKEyWR0Jm2xaAZ2IBVDzq4AHmL+hR6NP0w
	 VE3DaPZ7KOA8SAh2a54vSYE5/+fLAyF6jEOLvK8/T0tAZW3plAhgRB4gdG6ej8Lcy2
	 xOEkte+d5UasbJHdY6hM1aOtDypE/2eUwu7ooXBKaGoDfa96u9Qf+rlJIg6zRKVr7e
	 UtKGWzeJz9zT5o+d6BgrCrlM0FVI9+mBhLagbBU1uBkZRZt77hHg4WbMk9PtGzfufZ
	 7xQtdovS1XfRg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] bootconfig: fix NULL-pointer arithmetic in xbc_snprint_cmdline()
Date: Tue, 28 Jul 2026 12:29:46 -0400
Message-ID: <20260728162946.99526-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728162946.99526-1-sashal@kernel.org>
References: <2026072111-dizzy-spur-667f@gregkh>
 <20260728162946.99526-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Breno Leitao <leitao@debian.org>

[ Upstream commit dec4d8118c179b3d12bca7e609054c6011c4f2ce ]

xbc_snprint_cmdline() is meant to be called twice: first with
buf=NULL, size=0 to probe the rendered length, then with a real
buffer to fill it (the standard snprintf() two-pass pattern). The
probe call makes the function compute "buf + size" (NULL + 0) and,
on every iteration, advance "buf += ret" from that NULL base and
pass the result back into snprintf().

Pointer arithmetic on a NULL pointer is undefined behavior. It is
harmless in the in-kernel callers today, but the follow-up patches
run this same code in the userspace tools/bootconfig parser at kernel
build time, where host UBSan / FORTIFY_SOURCE abort the build.

Track a running written length (size_t) instead of mutating @buf, and
only form "buf + len" when @buf is non-NULL. snprintf(NULL, 0, ...)
is itself well defined and returns the would-be length, so the
two-pass "probe then fill" usage returns identical byte counts.

Link: https://lore.kernel.org/all/20260626-bootconfig_using_tools-v7-1-24ab72139c29@debian.org/

Fixes: 51887d03aca1 ("bootconfig: init: Allow admin to use bootconfig for kernel command line")
Cc: stable@vger.kernel.org
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/bootconfig.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index c149ee8eb55dfc..b4e8e17e29155e 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -424,10 +424,18 @@ static char xbc_namebuf[XBC_KEYLEN_MAX] __initdata;
 int __init xbc_snprint_cmdline(char *buf, size_t size, struct xbc_node *root)
 {
 	struct xbc_node *knode, *vnode;
-	char *end = buf + size;
 	const char *val, *q;
+	size_t len = 0;
 	int ret;
 
+	/*
+	 * Track the running written length rather than advancing @buf, so we
+	 * never form "buf + size" or "buf += ret" while @buf is NULL (the
+	 * size-probe call passes buf=NULL, size=0). NULL pointer arithmetic
+	 * is undefined behavior and trips host UBSan / FORTIFY_SOURCE when
+	 * this renderer runs at kernel build time. snprintf(NULL, 0, ...)
+	 * itself is well defined and returns the would-be length.
+	 */
 	xbc_node_for_each_key_value(root, knode, val) {
 		ret = xbc_node_compose_key_after(root, knode,
 					xbc_namebuf, XBC_KEYLEN_MAX);
@@ -436,10 +444,11 @@ int __init xbc_snprint_cmdline(char *buf, size_t size, struct xbc_node *root)
 
 		vnode = xbc_node_get_child(knode);
 		if (!vnode) {
-			ret = snprintf(buf, rest(buf, end), "%s ", xbc_namebuf);
+			ret = snprintf(buf ? buf + len : NULL, rest(len, size),
+				       "%s ", xbc_namebuf);
 			if (ret < 0)
 				return ret;
-			buf += ret;
+			len += ret;
 			continue;
 		}
 		xbc_array_for_each_value(vnode, val) {
@@ -449,15 +458,15 @@ int __init xbc_snprint_cmdline(char *buf, size_t size, struct xbc_node *root)
 			 * whitespace.
 			 */
 			q = strpbrk(val, " \t\r\n") ? "\"" : "";
-			ret = snprintf(buf, rest(buf, end), "%s=%s%s%s ",
-				       xbc_namebuf, q, val, q);
+			ret = snprintf(buf ? buf + len : NULL, rest(len, size),
+				       "%s=%s%s%s ", xbc_namebuf, q, val, q);
 			if (ret < 0)
 				return ret;
-			buf += ret;
+			len += ret;
 		}
 	}
 
-	return buf - (end - size);
+	return len;
 }
 #undef rest
 
-- 
2.53.0

