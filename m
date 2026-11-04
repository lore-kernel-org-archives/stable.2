Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818413;
	b=gCn/CjlTDf/dWjgx7di1/wnvjCjGlYYkVCSsKodZNflIuUtEdQAUlivOxlJuCIpesPDJ
	 Y7JpdQriIDdJ9nvdSxDG3WZrq5ofgMy7+BzDrHofUFbcIx8VBvPAGAiXU4B7pPbHuHE2C
	 BTb5PKlKY/euz0lsBv8paQbEEwpu/xClo5WLxuOj8UECb81FtsA/ImPGuN1daNRy8kZu/
	 vNv3e+ZziSgJh63T+sn65QbBaLyqSuMdKb0gPl8Uv5x0y0WNqWMIWvnZklf2FYcb0CK+F
	 NehmuUqaxo3TMvwTCMwMTKdkuVF5YvFPPdfQ0/9VNz4sOObK97imJLznpK9AoxNHWkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818413;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=oA6B1J6JqblohHPBghAuHGFHKmrzw+K9dB8VmV/4ogI=;
	b=q82JzYYUOi1ksSyCKYLyjlTPO8LtZtYGXlJz7gkxp/10Q6XqGB6eBBk1MmFXS+TE+edr
	 2Zdu8YwpZbp9kJ1N8KN5zQZXgHrCPF4DbCVtKQ20ksOTZTrSdjSnU4GfjpXYy3v/8HFJf
	 OPOa0R+Fvbin3FiHmyiFBU32QI8jszveWiBC5FpxL3MWONihtlaLkVQ4O7qPhyUGYLUJl
	 qwwHMfxcqN13Iow/uz4eV6uyJ884ZKJNz8mDe2Blc+5xg9ExaZYsF33XSB4P7/VogUw1W
	 EPm4RUeFAO+FFAPzBN4sH5exysEZMIh3n1qIFqjjCocqm7CGH+Fo5CAkB4F8tx3jtPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=LrFgix3H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BB4606D837
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=LrFgix3H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01DE31F00919;
	Wed,  4 Nov 2026 18:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793818413;
	bh=oA6B1J6JqblohHPBghAuHGFHKmrzw+K9dB8VmV/4ogI=;
	h=Subject:To:Cc:From:Date;
	b=LrFgix3H5FjbzqW+JplXN0qhoH+KWNGxTZLGNjljdCrpBoVai9T+ghK84gAot7gK3
	 JLDh2i9Ly5zMk7U/Hjn2U31VZ1qo7Qxn2vXrsHnbtCZ7eTY+cuwtY21XFm4Ct+3hsw
	 y8DmA7BmK82meVDoN05u41xZhNAFzZ51jCHypua4=
Subject: FAILED: patch "[PATCH] NFSD: Set nn->cld_net before registering the cld pipe" failed to apply to 6.6-stable tree
To: cel@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:53:31 -0500
Message-ID: <2026110431-crudeness-dreamboat-14d3@gregkh>
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


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 14996e662f3b734427e2d645cacffc27b779f7d1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110431-crudeness-dreamboat-14d3@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

