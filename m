Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818609;
	b=r2OgHehcs62CqTy9r92+b/WotLSUVr1FTGJT9m9ikIlksmDo8G8axNSgTO/pKVtmpsWO
	 z5OT+INFQ+KVI5tLaMiTBSQHs+Sx+Vrq345nlKpnJgeEALrRE1Em7Go6XGnl4HRh7PTzU
	 Olv+A3I3HCR97Z9vJlMjb4NPi43Eru35ylbOQOXo0wbKE0Fl+1tQAoZfD+PpFjt+sUStb
	 Ct2CBDPpYZkIdx1e2HWRgBgVXMk+nT7nJeBM8TEeKsnJ0mifDxV3YRW4DYVyUFcHBcJWo
	 WtdWYAih5G7AiQlF7thi+xxo5ZXkcghOfexFblGddIbo0oxiHswamceuttk0KAs841g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818609;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=PAJITo8l08yH+qIwdUyYMi463hd7yZIXJE7UjwgtYdE=;
	b=JGTR6tVl6aDoKDBKsrFiyBwgCL30KFlqV+MoD0++vnmOm4plXG6eqidNglT4PzItbQkh
	 eJh9S5GS8cr8QYBaMjR/rZ3JPcDIiEI9nXshLs6GsZq2rP8tC7hb0lrRuGkcW7+hxCwnq
	 eLzIsyG/5WHbviM9t2WuL4jc90CtCWvSM1MdW2KzqCmrvKer09x4O2QdjM+4vhVQNrZ+C
	 2khixcWi5oztvlDA3BV0dTjcDEy7Z+IZZ04AqhsEPzrwu1xivRLBPi9thWGeeyVbRwl/a
	 uW6yPGTf24rHcH/euIuIJWNFrS4Z6wJK17kSHIhhQDG8jORoDhyPxT8xfciTZeA/9ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="pNl7Nd/h";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0BD606A333
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=pNl7Nd/h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC181F000C1;
	Wed,  4 Nov 2026 18:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793818608;
	bh=PAJITo8l08yH+qIwdUyYMi463hd7yZIXJE7UjwgtYdE=;
	h=Subject:To:Cc:From:Date;
	b=pNl7Nd/h+JM4Oy4O3scj5bLCybePkRx9LVCoWYTIr8k8kPTj0BVl0h9uzfNJTtBVw
	 kdn9pVzgJkWxqXCSXEpNA6EmlEdIKmYTzcl/4I9SIZd0NeFKcyfhZpm9JCKpmrSGuS
	 cZAOJ10biM3TY47GtTi5HoD2c4Pv+BC7OVQY9YNo=
Subject: FAILED: patch "[PATCH] NFSD: Complete a cld upcall when copying its reply fails" failed to apply to 6.18-stable tree
To: cel@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:56:44 -0500
Message-ID: <2026110443-fifty-geometric-c564@gregkh>
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


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 8cef2b0a01d28647facc57501a3df7ccd8d13ccd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110443-fifty-geometric-c564@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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

