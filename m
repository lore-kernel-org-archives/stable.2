Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818418;
	b=VfU6cmPqOa1n5GZ8qS3pBVIY+nSaNQ8QpdbQ+RSZs3b5np03PxFnLOZGW4y0wO7Oyq1c
	 QnUQRiQkC0yA75Tlo5Jz1WhCxw59PUdcbq97MZlbkMAmtchS4L3rjs3xm9Qnz0q6XghS5
	 vmtKI8kQBQrEqkSTQ+tCEgEAePe0ugNYeKSRbJd43sXYACgOEhxfDnC7/EuXRpN/p+gqj
	 LqCPYwlajSnFeAfSJx1bzJ9QtnJcxLd0FWsjyifY8F62ndZkbbnItzPSo4qWQDJWUEqvI
	 1YDmf+3Iwp5MquSuPEfU2ZWN2xmz3/rxlvj/JG6ph+K8ATiszDV+yotPyNzj+iXOl2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818418;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=mCFUfVeO+iAZFP0F1u3v0XpbL9VAsl7koqwg206ftkA=;
	b=ZgNKIhku31IkkLZHReQPuIwZD9lkK5bVeucahR95PlqM5b5oAZY42QkV82XNH6DVkJx0
	 hFXFTh8srMrjkcmEVfoeySiZehl1g6T3P9AAchRJJazDimjw/4DcEauqlLnTrM6UlFzie
	 XRS9+EJ2ITBiJLqbVhBnvcsOi63ZPufGk36PsKH+MKaF0G7crACf9vyfHPtPu4gw4NcBt
	 CWXAAJqmbCEBUTqf85p9cInJw+1YRbzkReI9JtRlP47bntLGi88cywSIjv/N8pBZ0bLjl
	 ufEqTZiXTRVFf+miUteDeTfy22UwgGoL6dGYETmBntToC2VNsLjXDnCf/rhP7qCqAHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ty8jFez4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED5C606D82D
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ty8jFez4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52781F000C1;
	Wed,  4 Nov 2026 18:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793818418;
	bh=mCFUfVeO+iAZFP0F1u3v0XpbL9VAsl7koqwg206ftkA=;
	h=Subject:To:Cc:From:Date;
	b=ty8jFez4ooLm3/HGjdTDGy7lqmwoFSzhoNt9Njavi3hYTv/kxrZVlBx4lnOwRP1JO
	 Pa7Yz04EBL0GLiCaXJkK0ikW+PWb/e9VUG5ygMPcpK/DVMpi55WhtJZi6wPR2BtUAL
	 AdZU/6xkBoj42xX1TEo65NU3Hkq8ZLfGSDuGwYpc=
Subject: FAILED: patch "[PATCH] NFSD: Set nn->cld_net before registering the cld pipe" failed to apply to 5.10-stable tree
To: cel@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:53:33 -0500
Message-ID: <2026110433-catnap-bazooka-1e62@gregkh>
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
git cherry-pick -x 14996e662f3b734427e2d645cacffc27b779f7d1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110433-catnap-bazooka-1e62@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 14996e662f3b734427e2d645cacffc27b779f7d1 Mon Sep 17 00:00:00 2001
From: Chuck Lever <cel@kernel.org>
Date: Tue, 1 Sep 2026 16:19:46 -0400
Subject: [PATCH] NFSD: Set nn->cld_net before registering the cld pipe

rpc_mkpipe_dentry() instantiates the pipe's dentry before it returns,
so the cld pipe can be opened as soon as nfsd4_cld_register_net() has
run. __nfsd4_init_cld_pipe() does not store the new cld_net in
nn->cld_net until after that call. cld_pipe_downcall() reaches the
cld_net only through that pointer and takes cn_lock without checking
it, so a write() that lands in the window oopses.

Store nn->cld_net once @cn is fully initialized and before the pipe is
registered, and clear it again when registration fails.

Fixes: f3f8014862d8 ("nfsd: add the infrastructure to handle the cld upcall")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260901-alemi-v2-6-e163f94a3a6e@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>

diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 8af935ed0c4e..1a9ea6393740 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -941,18 +941,24 @@ __nfsd4_init_cld_pipe(struct net *net)
 	}
 	spin_lock_init(&cn->cn_lock);
 	INIT_LIST_HEAD(&cn->cn_list);
+#ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
+	cn->cn_has_legacy = false;
+#endif
+
+	/*
+	 * The pipe's methods reach @cn through nn->cld_net, so set
+	 * it before the pipe can be opened.
+	 */
+	nn->cld_net = cn;
 
 	ret = nfsd4_cld_register_net(net, cn->cn_pipe);
 	if (unlikely(ret))
 		goto err_destroy_data;
 
-#ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
-	cn->cn_has_legacy = false;
-#endif
-	nn->cld_net = cn;
 	return 0;
 
 err_destroy_data:
+	nn->cld_net = NULL;
 	rpc_destroy_pipe_data(cn->cn_pipe);
 err:
 	kfree(cn);

