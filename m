Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE614B5126
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445538; cv=none; b=F/HhhsnMNw0Qhc+ePMaIJZAyngoAcW36m2YM8TJvskK1l88qsfMgUE4/aGxleGTy4FUmGZnsbglBdt/2blM1q5Bz8ywM5LA2QIe0Q7VnDnviRG4Ctmmn9mucJGe+bgYptRTMrWGRHzv7zsWNMdeWRX1gLBGhR69JwTBQ5NG3Usc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445538; c=relaxed/simple;
	bh=XyPBLPHxATn5uMMicRUdFp0N+WOwn5w6AdmetpdWEkY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=t42HLu37ucHKr2L2dFuY6cdjH60/vf8Z4QcbjFpj8FhCBbGGl6WCoK0EliLSTaBlQ2LRbz3Xp0U+50Cnm1n4kbIXfhOXx9kXX6pUwnYqU6/hBf5wwIsS/tXxpPw1tvTVWRf+zTFmuHT+BxTCV+iITYBfEoqSLyez8ZtGfw2VBno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eqSGx/id; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eqSGx/id"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9024C1F00A3D;
	Thu,  3 Sep 2026 14:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788445527;
	bh=0p2nBFxNdgMpopT5Ek7xQZXshNRD9pQCHtfKz8vO5w4=;
	h=Subject:To:Cc:From:Date;
	b=eqSGx/idItPv64jIsiKMXy4JHEZ9TCOuOSJtNlNsXiYTHId8fbrpYWdUq+hv2eXzL
	 1SCF9FIDkYTJP+t3Vt8AjeHIfA+G7Miazx2xSZC6sY2Yu1qawkc55xZ6XuPANnYFan
	 dX6DuWQdwPd4oSRj4hJRcTxs+k00C64WwT/D205c=
Subject: FAILED: patch "[PATCH] params: fix charp corruption on allocation failure" failed to apply to 5.15-stable tree
To: yujiacheng3@huawei.com,petr.pavlu@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:03:32 +0200
Message-ID: <2026090332-lankiness-same-e48c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 3dfaae04243cde460d82dfc2a7dd0bb6664d20ae
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090332-lankiness-same-e48c@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3dfaae04243cde460d82dfc2a7dd0bb6664d20ae Mon Sep 17 00:00:00 2001
From: Jiacheng Yu <yujiacheng3@huawei.com>
Date: Wed, 29 Jul 2026 12:32:43 +0000
Subject: [PATCH] params: fix charp corruption on allocation failure

param_set_charp() stores charp parameters in allocated memory after slab is
available, and releases the previous value when the parameter is updated.

The previous value is released before the replacement allocation succeeds.
If kmalloc_parameter() fails, the setter returns -ENOMEM with the parameter
left as NULL.

Failing zswap's compressor update before zswap is initialized can later
trigger:

  BUG: kernel NULL pointer dereference, address: 0000000000000000
  RIP: 0010:strcmp+0x10/0x30
  Call Trace:
    zswap_setup+0x3b1/0x490
    zswap_enabled_param_set+0x5b/0xa0
    param_attr_store+0x93/0xe0
    module_attr_store+0x1c/0x30
    kernfs_fop_write_iter+0x116/0x1f0

Allocate and copy the replacement first, then replace the parameter value
only after allocation succeeds.

Fixes: e180a6b7759a ("param: fix charp parameters set via sysfs")
Cc: stable@vger.kernel.org
Signed-off-by: Jiacheng Yu <yujiacheng3@huawei.com>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

diff --git a/kernel/params.c b/kernel/params.c
index 3456b104efc9..a1ff4bfc9165 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -261,6 +261,7 @@ EXPORT_SYMBOL_GPL(param_set_uint_minmax);
 
 int param_set_charp(const char *val, const struct kernel_param *kp)
 {
+	char *tmp;
 	size_t len, maxlen = 1024;
 
 	len = strnlen(val, maxlen + 1);
@@ -269,19 +270,20 @@ int param_set_charp(const char *val, const struct kernel_param *kp)
 		return -ENOSPC;
 	}
 
-	maybe_kfree_parameter(*(char **)kp->arg);
-
 	/*
 	 * This is a hack. We can't kmalloc() in early boot, and we
 	 * don't need to; this mangled commandline is preserved.
 	 */
 	if (slab_is_available()) {
-		*(char **)kp->arg = kmalloc_parameter(len + 1);
-		if (!*(char **)kp->arg)
+		tmp = kmalloc_parameter(len + 1);
+		if (!tmp)
 			return -ENOMEM;
-		strcpy(*(char **)kp->arg, val);
+		memcpy(tmp, val, len + 1);
 	} else
-		*(const char **)kp->arg = val;
+		tmp = (char *)val;
+
+	maybe_kfree_parameter(*(char **)kp->arg);
+	*(char **)kp->arg = tmp;
 
 	return 0;
 }

