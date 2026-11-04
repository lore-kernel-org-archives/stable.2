Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818415;
	b=0j7qOZIldYGIHLvHh1rdMmZmsjtWFpZajh4+7kYd+ZFSpzYNJiSEuPeURpaIWkRwVqU1
	 aMPQ6Ik6aJFsZLbjXVRKsfJeoWAuHV5zUkUarHE4gQ6ktQNq9Z3DqYT2SWCinDXnbYHXP
	 KGY47/vZN0Es0knCeGF6macjv9CJvmogrOxcTCs+w1ox4zTm5soVjBftDC5RkC7kAGbau
	 dWCCLwgEgxYPf6gIaMEPNXCK/GACQ/7Jo7JtHMcIo7VvbfzZnBdAhdYhZuWNn89spzzl/
	 9LmV1CNjUE1CfLYTaefWGN3PkpQrYjiUrtkDyqqTDqk/livfvoWKXkpuXL4X8KoR31w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818415;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qyjgZVElkhxmNn8MT/L1bkLtwLPYv0DPOtVpq0J4bIE=;
	b=TylR4XJNt/yCd9/RUXlGrFrfRBjS2QesRfkxaTzdxoZiwMA2BAJXJdt8SY7OnJ60g6iQ
	 +FSgl1j31zF3cISTU3MIkVx/PM9PfFFmZztkF3p+Fopwfssg8WMf7hw9jsTjNIRqN9nSl
	 11KirMkthBJQm+lHAkIcwakGozns+vz28B/7cPN3Mx5T8SNndgAL9NdJwdECOFpzfR4kC
	 hKXr3zuYlYJf4By6Stkw+1oYy0+dVkfDsBcYpJm5c7J3vuMzjUp98sl9PfXXCG3tWJ+wF
	 IYG4v9HQRN9T8u5BSHXjzgIbGVhokZjIhZpDHCeaCSIrFpt/bQiwlgZkAkzZCgxF1fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="K5/Id/Ia";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B50F606D835
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=K5/Id/Ia
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE4A1F00919;
	Wed,  4 Nov 2026 18:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793818415;
	bh=qyjgZVElkhxmNn8MT/L1bkLtwLPYv0DPOtVpq0J4bIE=;
	h=Subject:To:Cc:From:Date;
	b=K5/Id/IaRX8CNmpUdrnDQhGtqNK2sCKh3pMWq4ywHnbCMNZAihqqwv5FS8M6FP5tA
	 +uT/Ksimqhoh8wfaiG6NKeNfr7FoLSzIZIVhSa/RMPHs+hWcVAikjyRfkpPATAou0Q
	 jGFacpDRnWVfqnq/MWtD6V9OdmjCZNRxgwvzj1/s=
Subject: FAILED: patch "[PATCH] NFSD: Set nn->cld_net before registering the cld pipe" failed to apply to 5.15-stable tree
To: cel@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:53:32 -0500
Message-ID: <2026110432-spoilage-unseemly-ecac@gregkh>
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
git cherry-pick -x 14996e662f3b734427e2d645cacffc27b779f7d1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110432-spoilage-unseemly-ecac@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

