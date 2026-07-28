Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95690472F88
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 19:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785267019; cv=none; b=LkLVIpxod58ryV+bhPLZDzToGjv18are3AC8hyJZYtxr3no4Ugp8Q8x+s2/m+uGKJ4/RhCd/dTk2W5eBAfBt6adYtF6EXgs6XepxEbObHDI+z15TRTvsW/AGPV/+i7a0O2/gSds/v6vMGrk6eLZ/ScnuVDovVVW+Llb0KZ/wp8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785267019; c=relaxed/simple;
	bh=QkvlbVntjtkS0WaT9tjsQ4wBrvlsccxO2eE7GNTeKaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OLWePyb8c+CEEDFiHoE8D3JECMgBOh/uNT2KL4DpMoD4HNUI4SHa9W4Le7VrpGRzvqI5/mxFaAaTzhlAtCgbMRelxDQLTdYunk0NDBTL5iVPxDdphw1mx+rqJ5wWDfsCVsdozqxi8gLBqRn9FlQV2YxxycxTDIKY8Q+OxaCeSSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eggwDmtp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eggwDmtp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4F41F00ACA;
	Tue, 28 Jul 2026 19:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785267018;
	bh=DdEkWZA/CIrEj86vpNZIuQRfiHSAMZzKEqEfAPx7o1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eggwDmtpQ+t4X5OPOeRApBELytP7oh1QMksFD7kLwYZ7hNDg5loSNo0ekIMs4qHyy
	 IkRyMpWMHA56vh9AelE1jyeVa/+wUZK+2F8gFsUbDgVXqwsmyzIqmX7Z1KO6QH67vL
	 xmBpeoucar0PZlRJJ2/VPypOSORm90FVXCCE9m6/0gGRHYtUP9iA0Pl1Z8z82NXDNy
	 G1thF8BXB9WmDp4VDtxltM7NJy20cbL4nDkfutRUcRD0OEVppbflVsM5pmtzOVR0z2
	 wU5akBrT0smnEDWY0MykKseffnh6DhfbSvGqEC22lhRnSMwTJwys9NvV3dA2C9ONxc
	 non0gJFYkTo+g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] bootconfig: fix NULL-pointer arithmetic in xbc_snprint_cmdline()
Date: Tue, 28 Jul 2026 15:30:15 -0400
Message-ID: <20260728193015.455727-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728193015.455727-1-sashal@kernel.org>
References: <2026072113-streak-grandma-0f8a@gregkh>
 <20260728193015.455727-1-sashal@kernel.org>
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
index 684464fe44d681..95ce04eb6bf122 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -426,10 +426,18 @@ static char xbc_namebuf[XBC_KEYLEN_MAX] __initdata;
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
@@ -438,10 +446,11 @@ int __init xbc_snprint_cmdline(char *buf, size_t size, struct xbc_node *root)
 
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
@@ -451,15 +460,15 @@ int __init xbc_snprint_cmdline(char *buf, size_t size, struct xbc_node *root)
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

