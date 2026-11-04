Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818607;
	b=jm7XCNRs2F4oDIY6RXrokFz1JuV75au9kKbNti0RR+Y3z5MkXX5g1ctAT84Dgv7+E7ri
	 4//erjQC1nINyp8sADuWbNkOnXiFWcpVZSchhe+bTFQ6Ac94lu/BSzZh811dweA3Q6OXb
	 lWxnEp0fQb4y85TE/NgmD7+t2IVLpj/vMMsp4oUbnaEJpQHReI5Ji8mZVV0u01fyOcL6B
	 Kus/xotOl6DcPsPOmefmsEW17vKTNBYnvmoutEyR+RljkQPw1+0zRVyYnjapbquFQetOx
	 QpmcVOQ7H31L3kIjz00BYsXnpAdKV7dk05icwq53LK1Xa9jNYy85gsfmnN8ZsDAscMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818607;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=6L0EUVIOo6RaNIt4c8CTtacGnMn9RlBKI9Vgh1xnMwc=;
	b=gm8ddrNuCR93lzsGqIKpM9+I2cXeZPMJeGNFpdrsR6hN4TuwV8hrSWTaRPdzE4Y3NqRl
	 +7o3g6Hy6tpnB993SJc16Pj4r2ENsPConrVIAY8mNdba0y0jOH4GfMiB5gUrGq5RpaeOO
	 lArTJpF9r00hYWJgprNAwNLPeKTO/aWzBP6DSW/JgZoNCNUQBD+2N0tCwjWcpiPmCyYKa
	 zpqYeS+tbAfeOaIzMoC/h4MBO9ObsKu/YWserHh37QG8mh1zWUWy0iL3sRkSKj2/28p44
	 wE+sMZ+GbH6HPWhzeDMg11aSMs4+3OejoYG6oMe/9h57b3Wm0XJ5TT9zfr4bnqAEFeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=tqVARLnO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412FA606A333
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=tqVARLnO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766C01F000C1;
	Wed,  4 Nov 2026 18:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793818606;
	bh=6L0EUVIOo6RaNIt4c8CTtacGnMn9RlBKI9Vgh1xnMwc=;
	h=Subject:To:Cc:From:Date;
	b=tqVARLnOPmNtW+JilkHtDeR1lv4l3SId0Slqj/v/HPASl7X0W/O4yOmRzqateW9PJ
	 4LFnXBsx4Ag8OSWiVZw4Et8QURpBhmplhmUycd7mAFjR/wTtzS3StIrZ1rp6ha7dyc
	 QDcOyJhWpC3KuGcOpvQY1p09tUHr2ttgQyCCSPA8=
Subject: FAILED: patch "[PATCH] NFSD: Complete a cld upcall when copying its reply fails" failed to apply to 6.12-stable tree
To: cel@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:56:44 -0500
Message-ID: <2026110444-revoke-slobbery-ab11@gregkh>
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


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 8cef2b0a01d28647facc57501a3df7ccd8d13ccd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110444-revoke-slobbery-ab11@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

