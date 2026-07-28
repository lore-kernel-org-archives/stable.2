Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2243F8EB9
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 22:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785277075; cv=none; b=eNlWGJYjmx5cCsLKoZE4+TRc6rCrLdkdRkjVIQa/5tB9EFqvg38usfRqezkzC8zmruMRnIFi+xjLyZP9WLSXtXFRRqKNG3i6lbHyh2QPpDwi/RcneFcXyXvOJvRKadmJxqfqBkxNrPSp//DC501MueswaY8TRidncjrwzP5VvCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785277075; c=relaxed/simple;
	bh=Nl5gyPSRpj1wdNaBjf8qi3WlBu4xGA2lc1cQIThp2dM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aBMA6sG3rdwoIClEjJJZHKfqYln3ay+IkVsE5Vpl3Cz30Hzk7XUNlUhUxslo5damV/5ISy1Q72kKVeLss3pTmAKo2sWu2h1ekrMRXOzitgzvSIuESzEgdeaaOUhOZAUgi+kAVqNRM6QPrsm0O8CcDKy8i/SU26kFjpSYtEdRJac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhV9mjsV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhV9mjsV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E011F00A3A;
	Tue, 28 Jul 2026 22:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785277074;
	bh=offOtLLtk1KSsyHxk3fQ6UxyygtK0mmaX++BN0x5IyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lhV9mjsV8aaM4+x50THU4ojgtVpCLKuTg9NuJpcJRRHYZMoH5tEZpcOeu5d3QPcBv
	 4c4HipfxTxzRAMyGq2iD/O2Oei113yKfgdnIcFR9s6FdPISDWHWY2yCn6fQ2hfvY2x
	 MmOcJ40zZ0+Z4Dz6nfQtbHkiAQDhBY+Gso66FbeSyvCEtaCk5SLrMZggWJ82xi0xZQ
	 DYg6AjefDbQP8H5WsGwZBS5Ygf7Qei/I+yMEMmgYczfnbHESjJI4EX51rF1T5wq8f3
	 /84RodSQujDV/yax7HTE+x6BFqSHjymE/0emqJd6kVg/GAuQ9l6RZd4OqA0b7SD2lP
	 98CGlgAAxgvlQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] bootconfig: fix NULL-pointer arithmetic in xbc_snprint_cmdline()
Date: Tue, 28 Jul 2026 18:17:50 -0400
Message-ID: <20260728221750.745951-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728221750.745951-1-sashal@kernel.org>
References: <2026072113-skintight-barometer-812e@gregkh>
 <20260728221750.745951-1-sashal@kernel.org>
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
index f497087e6fb1c9..ac878b861c0b92 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -358,10 +358,18 @@ static char xbc_namebuf[XBC_KEYLEN_MAX] __initdata;
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
@@ -370,10 +378,11 @@ int __init xbc_snprint_cmdline(char *buf, size_t size, struct xbc_node *root)
 
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
@@ -383,15 +392,15 @@ int __init xbc_snprint_cmdline(char *buf, size_t size, struct xbc_node *root)
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

