Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818614;
	b=0ixuTms2oMdbUujICNTXvJjneD7sSTrQ00TIMQY5fLThUtbU95FSQWAqz1xhbXGvfVQu
	 dFDfidg8pzqhYxbgaIDHIZvF0WltEeos6ZzH3CkjwFeVaDcSJBaI850/45YG1erT+O9sk
	 GvjlcKC68OIDcMWtetrg53WRn3TaBqg6ePQSUdlhMF8z4f6uSiOijEo7YGqrkH7K2XJYq
	 NXZiF9pztxBhAXCEvpJ10EHYnJJ/PH/nBirLvYT1FXU0mItHZAlx2sYKyjgFNTmX4kX9h
	 6xvhbkJY+9eK3z343Qx/tvsFBj2coMpV7ue/PZVjEhFrusqiJXnPI0ggbbzhJ66M/Ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818614;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=j975vXgzUm4+QG20E/19LdQZ46DMtdDTVRZh5ImSTW0=;
	b=l0pmOvWG96xTwulDlTtqUfjkbP/Iq66qaJWrlk1Ue5GFtSDkXyP4Xo4PMCpCviB1al/J
	 iW3jBFO7eanWUGTfnavef+tw02e6mHFtxTjYQTnhfv0Tmu0c//8n45bFwhPsPKZOeqYBz
	 T6Eie2jyiAC/6pDqBkrD+7Pz1idziC+6aeyTre4MMW0nhV81iipRpYkeCul6ijuYiLVuT
	 z1KEJjDLPVa7K+UjHQJ9j/zFAlVdvD9VIAGvMD+n2hDECnNdCKXKo8929696DSsI5ThAK
	 /KSvPftuJWxXYlELjuXfDHdo81Goh5jzEzUqcfmJeffFYvBwJKG9qG/+GRB3YE3cugQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=oaknPNJZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CEF6082BDE
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=oaknPNJZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 524BF1F00A1C;
	Wed,  4 Nov 2026 18:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793818613;
	bh=j975vXgzUm4+QG20E/19LdQZ46DMtdDTVRZh5ImSTW0=;
	h=Subject:To:Cc:From:Date;
	b=oaknPNJZgQHJcHLTZW5QMcyFeF8cv5NwwSbXK90uP8qGomztS9hSJ48l3E7fuPoBi
	 YlXKm9W6u43qCGMZZ5K1lwNAKWCKUomw3Ht0KpWRQykHaqR2EeX7MyOktJEvm1pBos
	 9zvJ/Zbr9yDQM+9D+dmVcG6yA7YbDcO21FV0d0WI=
Subject: FAILED: patch "[PATCH] NFSD: Complete a cld upcall when copying its reply fails" failed to apply to 6.1-stable tree
To: cel@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:56:45 -0500
Message-ID: <2026110445-skittle-silenced-49eb@gregkh>
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 8cef2b0a01d28647facc57501a3df7ccd8d13ccd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110445-skittle-silenced-49eb@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

