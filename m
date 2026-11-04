Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818417;
	b=CVOYrsrgK4TUtPQQAWHUXbL1utVtC/RayuN6aIK0NlMoNYgwm2C6vdS9PmaxQSjtQ4R/
	 oij43krZzBmiiu9NEg6tDI3DkNk0SVPlojDXd8IXOBttiRIbc27b+p4Oltu7zlap2byiM
	 EVJ116wlm2jXefm/MC6oO5GV+bnps3LRTRyEBph/b52vBNUDercalUXAvRaasIEmo3S7B
	 A0W+f+S/rnY7K6v3P0WJrNE/5JWUIktb4v4vVR1nByPo+ed2kju8c+0h09NDe/1vLeiL4
	 O0unxTWj+CtzFFAWODxdti+ypPI4+XRzc2bMK+j6EN7YLSimouswd2/xksStXHVH5XA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818417;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=fTFa5tjzgE4zGkn73srDHCFk786w6Pf4qBrXit8GrKs=;
	b=q0ejM8Hq+D+j3noLa5U8lWzGnIKPvygIXcxvLkQXGaiNPpwq8XJ7m2Vxns475zF5doNu
	 k3GeGbi1fX8J+cC0OhDbXR5ShVcq34ZTMmAVzS3LbL4l1D8Abss/1LDYageHDEAE+czRZ
	 A1NCLk3xkheKijdEG2hqaxzC7TVOMdKVkJZbRW5PQ/QDRnBzdf1HOz8ufHovk+4CDW8Q6
	 88bujqfSakuzcO7ehsCrkHtx3P2Hl6XtNpB/caxs4vBQ+1wYREA/D890hks/8CNO56o1B
	 nZPPlPxJKrsBUPbExi/JtSJtkwtgTYoqZWECQlRBguCUqwkPvx9Yl3qjWo62CdmXx8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="OHcee/us";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2DA606D835
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=OHcee/us
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66CF61F00919;
	Wed,  4 Nov 2026 18:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793818416;
	bh=fTFa5tjzgE4zGkn73srDHCFk786w6Pf4qBrXit8GrKs=;
	h=Subject:To:Cc:From:Date;
	b=OHcee/us8MHhFJEFJG6HGkki0W1eCq7y0q8FvI/GrVLXDyFkeT5InmxAKyZJzFEjr
	 CU6uzOfG0gPZ857s5IILbUWf4Bjn10WqcPgdqITjNCTnHLxogOQftdXrsLzgZVsQ29
	 e7XpC3jWj0wI6MN7J9aa/ckHg/1/jVY1XmcM1VPo=
Subject: FAILED: patch "[PATCH] NFSD: Set nn->cld_net before registering the cld pipe" failed to apply to 6.1-stable tree
To: cel@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:53:32 -0500
Message-ID: <2026110432-unearth-superjet-be12@gregkh>
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
git cherry-pick -x 14996e662f3b734427e2d645cacffc27b779f7d1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110432-unearth-superjet-be12@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

