Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847B63BD63A
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 08:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784624263; cv=none; b=bqRKsTjvKfiLRlLJUK/FB9MmuyTshcZ0m8KVkT5NyDinH1ZXouDe4Eywop6okX7G+gUcgVu4u+LDWUVB0UMtLz4Jj0pGF4qETKb4/RBKch2UeFDZ76WjqBC/L9aij0y3catzoGoFfPH7HR5wJPkxcF2ZGdVuMRSFolIdWRz7BgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784624263; c=relaxed/simple;
	bh=NlZ3SWM5OOhuJYrBftTcn5olmJHBmXg6z1fOTS0FQfE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VRbZpI2dy5FYzsaKwndvPpoqn5krVY5bs5XcNHxugEaYk4hV5OJ7uzyJ7LS1DV6Vny2c653lhmniJmuRmQbFwDnwurD60Djn4Ji/XhMIPsKOUDAu/+yqb6Og1fU9jcDU4CDvsVGXfUClroSLqplpfADk2tXU1jGOeKcqSMqz03Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=09PQvyE2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="09PQvyE2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41FD1F000E9;
	Tue, 21 Jul 2026 08:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784624262;
	bh=4lkfag6yiM1A20Ys7gY3cDLNWP0frZbjNCS4ljGpJ5E=;
	h=Subject:To:Cc:From:Date;
	b=09PQvyE2ZftvtRUQPdPoSDD4PHiKQu+Hbx63XSQXMs2j4vtokAPPDGndfK7rKhDes
	 rhphJfdAhKmKrZcP0qFN0incOehbmSVox4JmPRkHCdsjTLo0GXs7uOxqBVSN0f0Gg2
	 DYj7aIM7wIfAuV9OCeL+oqs2LuyWuJMyMijyB88k=
Subject: FAILED: patch "[PATCH] bootconfig: fix NULL-pointer arithmetic in" failed to apply to 6.1-stable tree
To: leitao@debian.org,mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 21 Jul 2026 10:57:13 +0200
Message-ID: <2026072113-streak-grandma-0f8a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x dec4d8118c179b3d12bca7e609054c6011c4f2ce
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072113-streak-grandma-0f8a@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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
 

