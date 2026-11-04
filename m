Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818617;
	b=HnO1iRxUdaMOI4dR5642+PaZzGT80e6NjekubmfmIDrNqgo6QaDAriE5ukrWj5WU3wNP
	 IDQBG1Xf135/kcJ+st4/0/jdd0LKSzWo9Ih5FDvGXoN98Lrjl6zHceiSnWWOEi09WlK1c
	 EHtwjeJldMrA+W5vXn1hOjVDlHafQhsPviash5aAPCImqmPz8BNBnT+M/jqjcPv9JAeli
	 9nieGDva0dBkPjQoAmGEmatazUPTNHOTz1GwIb9qbcQwGoRlzbGV7JelxDa+Ig3bsnqzW
	 y/lyqvy7j+5MDIW9gYvZ2Q7TUIzfJ6wdzOb2dwgPo7B8UekS3hT1JZAKRrnqkphHgDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818617;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Pr+YMoimPa/MItoiiuAXgUiHcQzEtX0vg6iz6TK0mFE=;
	b=NTMfryVa/Xka7R6w0zP+myWn/DIteiqXe1T0NRHcNM0Npj9o/mSCRMh62ahc2R3fYesV
	 Z2ZV5528ycbW8sgwmqcxm6HQoJU0c1Y579ykDvft8UBzn/HrcpPoP0xn3SWt5MFOa12ZI
	 vyqH4oLWgA8acx1mjpVpq8c3vDqrK9wwaeiPzhlNVKTpiyrfVPgTp+7NUA5wWUkbvxVpU
	 gjkEgNjWKakKK7LFhuT2DftSueYKws8Tam3finvyg96jzgrYPS4km/KOJQPgNihQRULbF
	 CSguZ0B0p6ePv2c3eqnq3X8UlEDkeL5gfsBXB6Jb3j1h4Fh+0goyLAi3dwYZCUwcdYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=gbvZQcoz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291E7606A337
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=gbvZQcoz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC831F00A2C;
	Wed,  4 Nov 2026 18:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793818616;
	bh=Pr+YMoimPa/MItoiiuAXgUiHcQzEtX0vg6iz6TK0mFE=;
	h=Subject:To:Cc:From:Date;
	b=gbvZQcozD2LmxGuL0rB883W530c7tjA5xjxDnAiP7VvWOdG+MuzFGIfbJ4EIjtHRg
	 lX3VvyMqvOIdQeLR1EVExxrdngpXBNRctIT0EFRJEdcp6+1kH3hTqCut51VYbG7SZ0
	 lNtx+Kx1OJsxTiSZuVHPEu6rRcUEgQhhBIaHGPTg=
Subject: FAILED: patch "[PATCH] NFSD: Complete a cld upcall when copying its reply fails" failed to apply to 5.15-stable tree
To: cel@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:56:46 -0500
Message-ID: <2026110446-unshipped-footing-bcc5@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
git cherry-pick -x 8cef2b0a01d28647facc57501a3df7ccd8d13ccd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110446-unshipped-footing-bcc5@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8cef2b0a01d28647facc57501a3df7ccd8d13ccd Mon Sep 17 00:00:00 2001
From: Chuck Lever <cel@kernel.org>
Date: Tue, 1 Sep 2026 16:19:43 -0400
Subject: [PATCH] NFSD: Complete a cld upcall when copying its reply fails

cld_pipe_downcall() removes the matching upcall from cn_list before
copying the daemon's reply. When that copy_from_user() faults, the
downcall returns -EFAULT without completing the upcall, and a
retried write cannot reach it because its xid is no longer on the
list. __cld_pipe_upcall() waits on cu_done uninterruptibly, so the
nfsd thread that sent the upcall is stuck, and nfsd shutdown hangs
behind it. The pipe is mode 0600, so only a broken or hostile
nfsdcld can trigger the fault.

Record the fault in the upcall's pipe message and complete it, so
the waiter returns the error to its client tracking operation.

Fixes: f3f8014862d8 ("nfsd: add the infrastructure to handle the cld upcall")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260901-alemi-v2-3-e163f94a3a6e@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>

diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 8dff351aa832..999694db9981 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -835,8 +835,11 @@ cld_pipe_downcall(struct file *filp, const char __user *src, size_t mlen)
 	if (status == -EINPROGRESS)
 		return __cld_pipe_inprogress_downcall(cmsg, nn);
 
-	if (copy_from_user(&cup->cu_u.cu_msg_v2, src, mlen) != 0)
+	if (copy_from_user(&cup->cu_u.cu_msg_v2, src, mlen) != 0) {
+		cup->cu_pipe_msg.errno = -EFAULT;
+		complete(&cup->cu_done);
 		return -EFAULT;
+	}
 
 	complete(&cup->cu_done);
 	return mlen;

