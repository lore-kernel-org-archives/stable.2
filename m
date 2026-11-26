Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795658012;
	b=xS5LGkVioQ3fBFbfSmiGFyVkbyoJDt46GOVhCp742jFdHfNmpoF30O6J8ExVmWO6yR4U
	 IUBVqoVRFEGqhfFqjBBOsha+7rj16xZjroHWnYevumIixK3v/UZwr4/MNZhqqjkmzFcGb
	 +mHBSaXW9JuHNKk7zCdCyn2DS2mk8qHQLCPAPts+mDiZUcCfouqcFezmPyovfGOFzgeOo
	 QpAteCk1bw2t+/nt9itwhEZJC6/fhOcLj24DxahqqwZL+tcIGT7oZS331m7Toof2gGUvN
	 aP0uj4zkkx/idcqnQYRCnMteLXQll9emI2ggEyTLn9bUd01UcoVB91DRwvsnahugN6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795658012;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CfNvs85X0ZqTjR0N7MYYYw3NsETsUmCwsnIQwasmav4=;
	b=Vm0kwvnWDFWZgr+tLt+mNYmTtt7k5JGn6eMdzFArUpStAtMvQW+6FIqVt4JSwsMgNYQU
	 phG/kFwZeJbLRJ8Brymm/8D9uwTw9c5q81nVarIhFE+8ekiW8y/nfr+tbL/2cCQO2kU3L
	 6mcytmX+g6km5+q2EPW55gOtEfVcSI7uWOGanOafuCogZ2ks0wgVnSmkrLGn4CZAmHcSm
	 2+skFTgABb88lUcH9MSh4R1XTi/yqm6sd5ZsGm95v2UxoqwufKnAduEaxEak0ACqUs+hX
	 7Bk1AeEPtSJRNP9zfSJ6U9sWoVGGpy6VxQgMuyB0SBCcXKlkfLt9T1AJD3Z2VjXJitw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D+59EqBv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CB1606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 01:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D+59EqBv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC581F000C0;
	Thu, 26 Nov 2026 01:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795658012;
	bh=CfNvs85X0ZqTjR0N7MYYYw3NsETsUmCwsnIQwasmav4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D+59EqBvsiil0mq8gzdRnjrvpByPAlxOJHM8euIG3xPQ0kaL7x8xvLi2I287uwoNP
	 rRp+bnQeu+EP/r0nD6bHg4fTcUb/qXJiiGu79ZqejLkDUnZJBrMMS7XxT/kgsj3+Ob
	 42omjqyQMyd8a0fTuWUVtewjnhJ32fiyVOFNPFM2jyTZvTdzCvpxu9gzjR3qjsMCU2
	 8P03HdFnmGM20YvenxQamoxvSW4gKAkbun0CV9fH3E8Wq3CyXWjQ472EoNXPR0gIXA
	 PqpmAwT9tAcYqTB3ZlcEemtXu5uJqdodOjKiMNZPxu6mf3Nqjx+x9BXNzmQdA/t/RO
	 FjvZcUnFhKRAg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] ovl: fix leak of lowerdata redirect on ovl_get_inode() failure
Date: Wed, 25 Nov 2026 20:53:30 -0500
Message-ID: <20261126015323.1696322-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112540-carnation-surplus-b95c@gregkh>
References: <2026112540-carnation-surplus-b95c@gregkh>
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
Depends on <20261126014412.1696101-1-sashal@kernel.org>

 fs/overlayfs/namei.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 2c962a53cc59e..2903f17cfdf91 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -1375,15 +1375,16 @@ static int ovl_lookup_layers(struct ovl_lookup_ctx *ctx, struct ovl_lookup_data
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

