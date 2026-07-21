Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999CD3BB12F
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 08:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784624256; cv=none; b=cE4bmMlpXAKsHBxGcYFJoD98NT/oKNEYyA+XsbXLIQa7xa5s7yDkXNwoBAgapEZmUs8bBIUeWtAo4X6PnaRyA/UcegmwghjjOc5ZeYhrPX180EI3NqWFh/FHYvmofYN1UeanyGGNoyC8PdKqyIFEHlTKU69GTQSdKKIJ3aUTRnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784624256; c=relaxed/simple;
	bh=aODWs5pCaiw54M99PUtmZ93+H5BOlP7mhBk67Bjq234=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GJa/q746C5NRlfwM4wCeoMkOpjD7D6W8sXDqieBCvRK+IWYkcLKb/8KZKZeqN+cVol59AzjwZ+nG9VuMwIAkqap8/dyf5L3WG4rGidkk8J/rp3HavFTpD9f9PiEzSLB2QqsINSejaP5Dg9YuWnh2jucpMVrj8KkzyoouC4JW4Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pv6f8MCZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pv6f8MCZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21BB1F00A3A;
	Tue, 21 Jul 2026 08:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784624254;
	bh=b+QzOTBXwke+on4Iu2xxM0etNfJECp+HUUiai9agblE=;
	h=Subject:To:Cc:From:Date;
	b=pv6f8MCZtSvDPvFbrYrWZhHlyPJsL4YIDUMxlYPyc14zLgzLjlrM9f7pvGpB+l9jW
	 H4iowLhgIMcKuMgjlSL6uCHpa1ITwLiNhMXodYtgXjdV/tZrXj0MsaNkTP3bvZc2wx
	 a/3md9W5Unz+shrtBWVMb43f6RyHSL0V3lXFrBrE=
Subject: FAILED: patch "[PATCH] bootconfig: fix NULL-pointer arithmetic in" failed to apply to 6.12-stable tree
To: leitao@debian.org,mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 21 Jul 2026 10:57:12 +0200
Message-ID: <2026072112-player-datebook-ddb8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x dec4d8118c179b3d12bca7e609054c6011c4f2ce
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072112-player-datebook-ddb8@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dec4d8118c179b3d12bca7e609054c6011c4f2ce Mon Sep 17 00:00:00 2001
From: Breno Leitao <leitao@debian.org>
Date: Fri, 26 Jun 2026 05:50:10 -0700
Subject: [PATCH] bootconfig: fix NULL-pointer arithmetic in
 xbc_snprint_cmdline()

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

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index f445b7703fdd..2ed9ee3dc81c 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -427,10 +427,18 @@ static char xbc_namebuf[XBC_KEYLEN_MAX] __initdata;
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
@@ -439,10 +447,11 @@ int __init xbc_snprint_cmdline(char *buf, size_t size, struct xbc_node *root)
 
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
@@ -452,15 +461,15 @@ int __init xbc_snprint_cmdline(char *buf, size_t size, struct xbc_node *root)
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
 

