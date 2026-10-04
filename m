Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3727D64A8D
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 07:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791099429; cv=none; b=NQVhlZFuX0ZSbxz5iHuapPXW8po4/Mr4yIMezJit2MF7eyDsJl9X/+p0njPEb8HG2wE4TslIUCUKPuyLHlq/JD99+46vjntOf2B6t8Yq+GxQefD77DJTTDoPaxOlmMGt4B3rBV6Mq8hN7TzSAmc/RXUBoc/P+BRM0D2jy78RGks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791099429; c=relaxed/simple;
	bh=qb99d9UV38AeLbLWv6+l5TM5D7GA2W0s/CSf7LyW6iI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ggW4NSkzlFAlDzsq8iYDI87B9NWt+gO8wml+xvAlh/2q1vGFsH2ORiG1WD274tAQBSC1dv++vEHgNm2T1Qrx8BsSSzFSJg7JDrnwOSja2GttVa7drvtJQujBFR11pjUfKNgtv+Xn3GPh9+nl65b+yUdz1k+/Z4APodYXI5zTl14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YCNmtMlI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YCNmtMlI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344071F000FF;
	Sun,  4 Oct 2026 07:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791099427;
	bh=rFV6En+zxjAM/g45j5JdUi2rert2oR/pf9fnLf+IR+k=;
	h=Subject:To:Cc:From:Date;
	b=YCNmtMlI3jy2Vbf6eCUHt+jfi73e+tzqBrY8vbbDQBMwBNLnzOPqUleeDvIt+xrio
	 27QcBhQOjtEeRECnKUhHff+OVSu3NXJnuIDJCadBhlIcChpQyGB/CUXoRbQnMRR0QX
	 IyceLgZY3Dx4cytAlYS5Xo/1ca3aKDXtQwZXueMw=
Subject: FAILED: patch "[PATCH] vc_screen: reload vc pointer before if (ret) in vcs_write()" failed to apply to 6.6-stable tree
To: yiyang13@huawei.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 04 Oct 2026 09:36:54 +0200
Message-ID: <2026100454-caloric-pried-9341@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 226bd5603371cd9f6642cbb9e9a677f445de3530
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100454-caloric-pried-9341@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 226bd5603371cd9f6642cbb9e9a677f445de3530 Mon Sep 17 00:00:00 2001
From: Yi Yang <yiyang13@huawei.com>
Date: Tue, 1 Sep 2026 11:31:31 +0000
Subject: [PATCH] vc_screen: reload vc pointer before if (ret) in vcs_write()
 to avoid UAF

The reload of 'vc' added by commit 8fb9ea65c9d1 ("vc_screen: reload load
of struct vc_data pointer in vcs_write() to avoid UAF") sits after the
'if (ret)' block, so the copy-failure break path exits the loop without
reloading vc. If the vc was kfree()'d via vc_port_destruct during the
unlocked copy_from_user() window, the post-loop
'if (written && vc) vcs_scr_updated(vc)' is reached with a stale
non-NULL vc. The '&& vc' guard from commit a287620312dc ("vc_screen:
fix null-ptr-deref in vcs_notifier() during concurrent vcs_write") only
handles the NULL case, not this stale-non-NULL case; vcs_notifier() then
reads param->vc->vc_num from freed memory:

  BUG: KASAN: slab-use-after-free in vcs_notifier+0x7c/0xd0
  Read of size 2 at addr ffff888007149190
  Call Trace:
   vcs_notifier+0x7c/0xd0
   atomic_notifier_call_chain+0x70/0xa0
   vcs_scr_updated+0x77/0xa0
   vcs_write+0x71b/0x7e0
  Allocated by task: vc_allocate -> con_install -> tty_open
  Freed by task: kfree <- vt_ioctl (VT_DISALLOCATE -> vc_port_destruct)

Move the reload to immediately after console_lock(), before 'if (ret)',
so every break path below passes a fresh vc to the post-loop
vcs_scr_updated().

Fixes: a287620312dc ("vc_screen: fix null-ptr-deref in vcs_notifier() during concurrent vcs_write")
Cc: stable@kernel.org
Signed-off-by: Yi Yang <yiyang13@huawei.com>
Link: https://patch.msgid.link/20260901113131.2760010-1-yiyang13@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index bf1502fd5bd4..79453abcf4d9 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -631,6 +631,18 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 		ret = copy_from_user(con_buf, buf, this_round);
 		console_lock();
 
+		/* The vc might have been freed or vcs_size might have changed
+		 * while we slept to grab the user buffer; recheck here, before
+		 * if (ret), so every break path below passes a fresh vc to the
+		 * post-loop vcs_scr_updated(). Return data written so far.
+		 */
+		vc = vcs_vc(inode, &viewed);
+		if (!vc) {
+			if (written)
+				break;
+			return -ENXIO;
+		}
+
 		if (ret) {
 			this_round -= ret;
 			if (!this_round) {
@@ -642,17 +654,6 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 				return -EFAULT;
 			}
 		}
-
-		/* The vc might have been freed or vcs_size might have changed
-		 * while we slept to grab the user buffer, so recheck.
-		 * Return data written up to now on failure.
-		 */
-		vc = vcs_vc(inode, &viewed);
-		if (!vc) {
-			if (written)
-				break;
-			return -ENXIO;
-		}
 		size = vcs_size(vc, attr, false);
 		if (size < 0) {
 			if (written)

