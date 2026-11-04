Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818615;
	b=pnP7C0M0c6u2yoDyNqyS3Hozh0KKRp9ub55fNlBDWR6V0+jLqq6dffbB6qlMjYR7cwCu
	 fRw9pxiJevoToUcqsnSp4xI85Yt2srb04kamMYoEvPVKjUkHAfqfgwl/DGAZWXCAJfoCE
	 Buz9NbgZQGwlhH+BUhcGTiCBqM1MVcTKO/SoippMi1SeqBb0NbT5XlN5njJ97R2FV7ZHL
	 8BE0JzCRT9l/wk2AnPbYclKcC9LXUJAHeJnkWn08uYnn2AVWgo4Yn3ia3ThpZSFmsv4cR
	 vnvbQYHLb1iyJNvhNw0XPD+9tdIlqrn0o3hRGlMgMOYZiEAe6GcR/kajuuPYPjzA23Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818615;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=DQiT1Epe+oNb9G6qast3Y4k7mYscIw4TpOt12jA+0iA=;
	b=Emje67DKkYIyt97rb30smk5KAOgiPikvD8pDaWx5bPM6GsZqK51pK57NA8yP893OuiXZ
	 2B5WlzBsgyxQREielvMNBq82hRe2Mk9Zl8AHFonf6rlPr+kC3+xuybq+tvrwjSKmLJrVG
	 MwQo+RhnJ4piiwzXXUydTHlRAl5zPqWSRKAAC6d1Ye/g+y144RjfYWeFvm/GsCxHN7uEF
	 k8Scv0zt4BK0GGfhBEvQFO/KTYoeoytYNbMQDe9oqe3zZR3nVoZTI8qrlXlkjMC7TWWQB
	 sxz/GzJCyXdAJRbY4q+4Maj8dFkp14NyChqfItzLiEqKyESWp5RheoFIUIZOUwjYuiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=1PA4ekfI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E15606D81A
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=1PA4ekfI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D678D1F00A02;
	Wed,  4 Nov 2026 18:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793818615;
	bh=DQiT1Epe+oNb9G6qast3Y4k7mYscIw4TpOt12jA+0iA=;
	h=Subject:To:Cc:From:Date;
	b=1PA4ekfI7oaEkmiGljdRXP/WLY8sN3H5Cd5t590Zy7B0rUJG7lwClZpmAsGwO1GKV
	 qVtAUt24D/8ekPPx+ExczYcTezY7sfYO4/GC+m0HxyLlLXgfzNaOOlyNB/4g7pYDze
	 jY4FcZjLLPerKG/5ptjH6t6xAhvkEhWCFot8kd0E=
Subject: FAILED: patch "[PATCH] NFSD: Complete a cld upcall when copying its reply fails" failed to apply to 5.10-stable tree
To: cel@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:56:46 -0500
Message-ID: <2026110446-dubbed-cabana-493a@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 8cef2b0a01d28647facc57501a3df7ccd8d13ccd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110446-dubbed-cabana-493a@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

