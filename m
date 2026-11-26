Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795665292;
	b=PcrBEkUqY4xtdWj0fKG3zfdUzNHnRSjJWx+M73cNxhEZlXxFbua3ezbcB2jTBWModITY
	 CS+AxpqtC3HNtN8cWVHxkvF6zxRdSPCnKA+My1SKPuG2fJBI1W+vCnIpkutKmshPNghrA
	 Lj+xG/HVaENcBRMMyeiE+XSGN1/n/WiDXCfkKpJ0VT32NWgjaUtGZxFrK59eVxEjQYcwb
	 +ZoI1crQXsFBP7W12ZeOuz1Mok/RDfdU0OMF2L3AHjV9GRA3esxLp1FZGxvHyj1sbm75z
	 XvG+JHoFGQ5xz8yeMs6w+7Wq5/NKplmQVry4zT53k+22YOr0o70Mcspva9t5+/5owag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795665292;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uXKPRxhUlG+lr0/HyTj44Fbr8ktmBuHxxO9iaVeVu5k=;
	b=mdN9UJXYGndmO3GWVdYz7mS0QA75R35zvypSHREctG0iiDpbMSt5TuFMSjIRTC2fYqbu
	 93qC5lQGzZgdnReq42mA659Eia2dKoWGI+40BqWlDTwanIzTf7LLEK9CLiO/mRe9wmi9K
	 CYbqdjZYUmHYBsBEnIODDrk6SjZAHEDurBw81vSNfam3+/ZNf0BfiXZIvNOQFn/N9hnrc
	 ODkmh9KXYldNdwZ4AGbXvmXwQ2U4oYB218rTUWCYlOvRbJFxtaOqp78qxiPZ0zAiHCZ1h
	 2QUmUeYeJtxWlYA4RPgDzpseibYqNR/MuNyXUs9I8zSBJTXsDJKUzJcYaCwA7mun5HA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cWg17SoQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85263606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 03:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cWg17SoQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B521F000CF;
	Thu, 26 Nov 2026 03:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795665292;
	bh=uXKPRxhUlG+lr0/HyTj44Fbr8ktmBuHxxO9iaVeVu5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cWg17SoQxLMQNAIoAsQpkgwqKvKULOwSh6C9WlEaFfT+jZ1DY2GIoiCBegvnTufNr
	 MZkhir0vhBfb602aFWSWdc+TygduIcGg9aTpdP25lA+Xmow+LVp5urnQ+qiQDDQ0h9
	 y2OPPkGkzz/yeUYoxjP6KHvpEHbRDAJPad8+YKWW8CX2HEhHvfTJfB13cvfqBzbXEb
	 E9gZCQXvOD0V4O1LQmOmfhWBh3GzxoGgEG/GAC49sqHRUV75L07ypPaHh7lS+MLsUr
	 VyI11SawdvUrkRZumUKf/ARlJO+e0kq42iILl4bjs71Tf8Ooj1o/U0xnLMry2PY7uI
	 Uqw2tfZTLB2LA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] ovl: fix leak of lowerdata redirect on ovl_get_inode() failure
Date: Wed, 25 Nov 2026 22:54:48 -0500
Message-ID: <20261126035423.1749648-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126035423.1749648-1-sashal@kernel.org>
References: <2026112540-grandly-twelve-b524@gregkh>
 <20261126035423.1749648-1-sashal@kernel.org>
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

From: Amir Goldstein <amir73il@gmail.com>

[ Upstream commit f1b7e5534854043077bb72afc8d87ad1e0b283e0 ]

ovl_lookup_layers() moves d->redirect into oip.lowerdata_redirect and
clears d->redirect before calling ovl_get_inode().  When ovl_get_inode()
fails, it does not free oip.lowerdata_redirect, and ovl_lookup() frees
the already cleared d->redirect, so the lowerdata redirect string is
leaked.

Clear d->redirect only after ovl_get_inode() has succeeded, like
d->upperredirect, so that ovl_lookup() frees it on failure.

Fixes: 2b21da920866 ("ovl: prepare to store lowerdata redirect for lazy lowerdata lookup")
Closes: https://sashiko.dev/#/bug/linux-dabbd363-9c71-4915-af72-e2b5e75fa58e
Cc: stable@vger.kernel.org
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/namei.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 2deddbad64d22..24843ba6dfcc5 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -1348,15 +1348,16 @@ static int ovl_lookup_layers(struct ovl_lookup_ctx *ctx, struct ovl_lookup_data
 		};
 
 		/* Store lowerdata redirect for lazy lookup */
-		if (ctx->ctr > 1 && !d->is_dir && !ctx->stack[ctx->ctr - 1].dentry) {
+		if (ctx->ctr > 1 && !d->is_dir && !ctx->stack[ctx->ctr - 1].dentry)
 			oip.lowerdata_redirect = d->redirect;
-			d->redirect = NULL;
-		}
 
 		inode = ovl_get_inode(dentry->d_sb, &oip);
 		if (IS_ERR(inode))
 			return PTR_ERR(inode);
 
+		if (oip.lowerdata_redirect)
+			d->redirect = NULL;
+
 		ctx->inode = inode;
 		if (ctx->upperdentry && !uppermetacopy)
 			ovl_set_flag(OVL_UPPERDATA, ctx->inode);
-- 
2.53.0

