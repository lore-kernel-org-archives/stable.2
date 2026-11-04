Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818605;
	b=vEBb53zYDhPufF8nHC66oiWvQ8LYj5sP0d2OGJluLb70RmZdEYGJMkYbCrzS6WhaOcGw
	 5MK3DbM7UvTHyo5ZQ2l/cd5a1NqLick6SKtmj49aVEnXXQaJop2w5ckPcsKobpI/gFKj0
	 RnSGSfV86c6kSQ6yKZMG3PfCp+oAZGm0e+5EgoPwyjKhW80QW4GQHLfH3IZVhq9geSlcq
	 N4ZjWOOKUXJaD6dFI1vmVbqpRcVgzzV3XwCDPy1TIOBcAthaVVU5cukpW54eKpsPQ11sy
	 v1y9RMz+gw9d5IKrY2/flri2cYeBMY5ThD++sJX8JfgB6cegU6UNCfNnmQb7khQ6Ebw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818605;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Ny4gJZyZdpbcNILrfZRjAxl5fC3aPYBhQZYAanC6YSk=;
	b=oMH360B9wW+UYAsCQoNZdrha8mJjymWd8wdPOnGkjTxHPACGWTQSemsqdqFMK8e0n2ba
	 JpYrBL9W5IsdYUHCe8FLH/IBuGNZPZAhG6NLhH6pPa4lE4iwkkvoG2jkb4DPvjpOZro/H
	 Y9gKLB0fejgUR+/mRgTnqHH+Dhrw4eL1qxBypH2Bbft+z8DLFIghPrNxTI7rkXDLuIbct
	 bJmolp7JfR+dMhuQEQ8g5qT3SGGsHriGa9ZwxwOLyEsnoxNDLzrHyULv2Vx1/8grl6As1
	 gikUF0CbxLNiKz6SE3Y1VpfQXY4ioy9B0g7KL4Bwt9CoKa4kpPekdO+MugcVCfrvUuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=yz0QwTyF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6DC606A32E
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=yz0QwTyF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998C01F000C1;
	Wed,  4 Nov 2026 18:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793818604;
	bh=Ny4gJZyZdpbcNILrfZRjAxl5fC3aPYBhQZYAanC6YSk=;
	h=Subject:To:Cc:From:Date;
	b=yz0QwTyF+TbqO2cRtDgkhE3L7y6fd0lriv0DLOVOmaoHvvdNAqqeZaP6NTUWb+vUP
	 nhRPz8wWhaiQJbcHekTAKTI16kYwzOO5Datq5OT3CoC4TK+fE4THfLl6O2lUyYg8cc
	 fgDF0JqD/vvro2VupyXaxmuK3UAnyQh42q9KoCQo=
Subject: FAILED: patch "[PATCH] NFSD: Complete a cld upcall when copying its reply fails" failed to apply to 7.3-stable tree
To: cel@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:56:43 -0500
Message-ID: <2026110443-cobweb-sloppy-a362@gregkh>
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


The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 8cef2b0a01d28647facc57501a3df7ccd8d13ccd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110443-cobweb-sloppy-a362@gregkh' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

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

