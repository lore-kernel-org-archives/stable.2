Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D965823BCED
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 00:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785285032; cv=none; b=WdHbqiWgw50eg3RqU6506cIcN6X9D/JZjxfr9GZFhc6JO1WdBCcYJtxuDSMQLLhKVhZeeWM0KtZY5blNWcuytueRlI+yJAKe9H72DkPccdKzED0Mhcq/F7fjBrIXMjqSmADy4KGDkUPeYZIUG31NsqynHAgPqL7lItsy/pqp2Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785285032; c=relaxed/simple;
	bh=sIAGvKCuUgi41smO1FmxNjwWwtt2RfMNcd3jHi83tMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ohLezr8oYdTfQkmMYgS9+sfJ6ZxtB3/2eakMbGp+1zxZCmNs3EmlLYvPGIzRYVEN2xJ+m/kGVl8nZLvt/qC9X4cgRWRJgy5D4f++3kGTFV2vhciM3/LclMohbUzaTsqF2J7K5SuAPG1Kn8HDxnW8zXNNkhMGoQhQj3SIx0IdG+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IS3kEmdj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IS3kEmdj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD0F1F00A3E;
	Wed, 29 Jul 2026 00:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785285030;
	bh=mvVnQ3Md/NLIubBZlWd5YIfDD3ru8ksq+JM9f9IRR24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IS3kEmdjOnnBpcfmYzBYbcPjIlUGzXiSR8MIqhwri8CtnXtzygU1mEVp1tAlIa58W
	 j0chdY7Tz5io6FfaKR1LZhgc35phAOf7aPDMVcdpRmqWhzSoL2klghpnC5QZ7bHAaP
	 c/OD/ZWnW7w5oE7wjqeNeZY0Tgu+Y58usuJ7gyxKPg+VB33SN82xt+4ZN/bbdOnJBu
	 g21K44TV27BqY7n0fHIwCuFPvQs2gQEO9Kb2VfNnlAO0c0aqOREGr/OdipjIj6RdOy
	 kFyviWqDV8p8kjNCMBM0gMv86op6ZhwOhDO8qPSV5JwzgYj/voLTU9VVh32G2XWwnF
	 CNf/PJv+JqzQQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/3] bootconfig: fix NULL-pointer arithmetic in xbc_snprint_cmdline()
Date: Tue, 28 Jul 2026 20:30:27 -0400
Message-ID: <20260729003027.887848-3-sashal@kernel.org>
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
index 3b3d666e207618..f6bede03c69265 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -348,10 +348,18 @@ static char xbc_namebuf[XBC_KEYLEN_MAX] __initdata;
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
@@ -360,10 +368,11 @@ int __init xbc_snprint_cmdline(char *buf, size_t size, struct xbc_node *root)
 
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
@@ -373,15 +382,15 @@ int __init xbc_snprint_cmdline(char *buf, size_t size, struct xbc_node *root)
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

