Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793968637;
	b=F3N4d66GFKeaENhFGodGYDJvppggRKdSdpr5MLS4kdr6tPOQRtZfADiVp/ZNkNckip0e
	 VI+C5C7UF+r6LCsrIeJFDBqpsALl+8Znk5doNJB6/cj4h9eu8p8n3DdpNXyaE4Buch7j/
	 zn8ynmnBWH39wYT7c/p3m++UB8nytQ97P0vjT7lfDdIeX/8wlkOAJ/ermQXCC5UVp7srY
	 xnppwXC448LFF5xhreXodsAX/VRYehrtHwD+k54Pi1Ofb9e5YA4/eZEhs1KibweWCUD7h
	 o4GCa/FYKT3iBWkh5W7K6w0CXRjoYqL4GMRjeGztAB6Ed3tN6daBsOSiFFqaX+mJLwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793968637;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sHmcqnEs5qL6vtF5urTeoRIe0zTl/4AIodrAZ0qHiEk=;
	b=GMNEAUBMjv85LPIl+4bt3NTMpp1yP4S2crlTEbeSFYH21AmDMOC18CklpCO0GpzSOoFy
	 zQlVoTZhHKjzopU4adCUueSZaBGfnLJ0wru4ZUhf7QPCMys0kUxac/HcVAXqPB6yxYJva
	 fdS4ICKIAm+rbN/gbFqE7B83XXpgIPjsBADElAhB1cZvKUe++3gDZyP/uBvPpARHBcRKJ
	 bCG3lKxFlCNh7nkTZjLfis71/h+yc9qRM7FFMWB0kVQEpjAnGH/gNGkFpHldrE4jQ/ba4
	 OZl74viLGoYnTiaWnEgq77N+m1tZaNR+SsqdPzfhofpbn3Om29mUJNVU3w9lI1VB2Tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LTUharlA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D510606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 12:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LTUharlA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B13711F008A1;
	Fri,  6 Nov 2026 12:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793968637;
	bh=sHmcqnEs5qL6vtF5urTeoRIe0zTl/4AIodrAZ0qHiEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LTUharlAdXTLHShfTBPKJNifFtQhcP4rrkxXvsB444odmzauRg9MmAwBwCo5Xc177
	 jZCkFVOk99b64t1i6BGRFAg1qxgQVv2KoFMUvhjQpNFrfB4iGNSIWINaoNx9yzrgAK
	 bGk91UwJlwZlCed73DkMo6E9vlJlesBVJNoXo07shSOf9cd14jv/pNmelLcWvI+3PP
	 wW6l7EeuGS86SACBXuTU3V8AisKGEwnCIPstClXGGBWhKQtQ7J3DWsuHi9p5DXMEsO
	 IJXXoqZA50zDGGQfS97qV96f8pLZvrYk3lJFpJ6MWBo8iz8xamM/PpKgaGH/3JYpoj
	 3tAFoJ2U5NYOQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] NFSD: Set nn->cld_net before registering the cld pipe
Date: Fri,  6 Nov 2026 07:37:15 -0500
Message-ID: <20261106123632.4066642-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110433-catnap-bazooka-1e62@gregkh>
References: <2026110433-catnap-bazooka-1e62@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <cel@kernel.org>

[ Upstream commit 14996e662f3b734427e2d645cacffc27b779f7d1 ]

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
[ sashal: omitted CONFIG_NFSD_LEGACY_CLIENT_TRACKING guards around cn_has_legacy initialization ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4recover.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 742e93f15c8f5..54815ce3da035 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -1014,6 +1014,13 @@ __nfsd4_init_cld_pipe(struct net *net)
 	}
 	spin_lock_init(&cn->cn_lock);
 	INIT_LIST_HEAD(&cn->cn_list);
+	cn->cn_has_legacy = false;
+
+	/*
+	 * The pipe's methods reach @cn through nn->cld_net, so set
+	 * it before the pipe can be opened.
+	 */
+	nn->cld_net = cn;
 
 	dentry = nfsd4_cld_register_net(net, cn->cn_pipe);
 	if (IS_ERR(dentry)) {
@@ -1022,11 +1029,10 @@ __nfsd4_init_cld_pipe(struct net *net)
 	}
 
 	cn->cn_pipe->dentry = dentry;
-	cn->cn_has_legacy = false;
-	nn->cld_net = cn;
 	return 0;
 
 err_destroy_data:
+	nn->cld_net = NULL;
 	rpc_destroy_pipe_data(cn->cn_pipe);
 err:
 	kfree(cn);
-- 
2.53.0

