Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793930006;
	b=uU5sNmUMdEJ5gp9K03+gQ/Tib1eIPEc4O1CW+GPGootaEWWfbRwPzk7TSxRGPfr9bIee
	 8g0UJBO+AIe3rimIKZ86nUrvJ46ml+zQNx9T2hUWF/8c9DE3wEr4n/yw7me/8ry6yNXo2
	 w/bxSvRYEjUUC4ctDP565BzH+wZ1d5GDAm3vC2JwulX1Gz2jAoSdLUWLKak4eTolvwiQb
	 QMw5ym1bSKXETeIlK82eMFO7HP+7rbad6TJpe5JgQreySMlDEfMdS7f5DA1KiGqLaxdMf
	 KLy/6IFbbRayuMVrpfV/EQR0AZ3Ys8FCao5K+JEltl3SvTjhnHcyWjrkArwXm72Gbuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793930006;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hjHfqbp3YS2UWi21gIgEuexH1r+z1t7YfVeAnWiT4CY=;
	b=Er/dTDTeHGN0JiWOe4IjqESymSpQ0OkvvDeP5QINk3VPxljktLKFEgLH/wjR56Cc6s50
	 JpgJ5pD9sbfkh4z8A2SVscqsGqpxOMyygpeugTs3rhuYNDkCWoxGR2jq2/zuQuDh2NwBf
	 TmGnl/zdpmaU4L2cO8fWkLQo4guroARWb5VXkA1yQ56rBvl6E1sjl6807QDLM2cqxqq7V
	 ppVLskkL8Q8UGK/NTJCrCu5btnwi9frRyRDUQ6v3eAQ3QHhg6lvHVlJtNNLzRJWwEw6zF
	 YuV2F1Qtv+09ln5bi8dj5PysgmegXNiEN3Ksw1zzqWeqZCCBxGKpzB7Xa5k8b2vkbTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="JEOsx/6o";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA679606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 01:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JEOsx/6o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85CE1F008A1;
	Fri,  6 Nov 2026 01:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793930005;
	bh=hjHfqbp3YS2UWi21gIgEuexH1r+z1t7YfVeAnWiT4CY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JEOsx/6o1zkqjP3bGlTiCH2YAtdvMAaVdu4gXSCTyftvXNujjftwEhFXUr2gcvI0r
	 Zf9Tsk1zOt691hWASzYJ8hMxWmXxm2risBO5bnY/T6wlqy7ne+GY+qDrZrtEQ3wp47
	 N/7K3j9LUrTYAlIAwQJRi0Qg2z9iWAOY2Ky8gtFW1czftFUGoq2N2th5WLkLqMlzhM
	 fQQ4HABrXAZSYzy8glBXKI1G71WfddGu6+/XXWkQskTgUpbA9N76ScbHi6Bkfudwo/
	 unTm06p9LJ2KYsJt1Fu67RL5QepwwPcaAOKOt+oxjdXG7Sz/1u+YMq7rAEsShOz/T8
	 Xj2xsm+2K3EGg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Benjamin Coddington <ben.coddington@hammerspace.com>,
	Benjamin Coddington <bcodding@hammerspace.com>,
	Anna Schumaker <anna.schumaker@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] NFSv4/pnfs: bound the CB_NOTIFY_DEVICEID array count before allocating
Date: Thu,  5 Nov 2026 20:53:23 -0500
Message-ID: <20261106015246.3607916-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110458-subsector-balcony-5182@gregkh>
References: <2026110458-subsector-balcony-5182@gregkh>
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

From: Benjamin Coddington <ben.coddington@hammerspace.com>

[ Upstream commit 32f0967ea296d447925465c98e7eec71d4e2f755 ]

decode_devicenotify_args() hands the server's notification count
straight to kmalloc_objs() as the array length, without checking it
against the message that carried it.  Bound it the way nfs4xdr.c bounds
an attribute length, against xdr_stream_remaining().

Fixes: 1be5683b03a7 ("pnfs: CB_NOTIFY_DEVICEID")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5
Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
Signed-off-by: Anna Schumaker <anna.schumaker@hammerspace.com>
[ sashal: adapted allocation context from kmalloc_objs() to kmalloc_array() with an explicit element size and GFP_KERNEL ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/callback_xdr.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
index 1aa6a6e14b057..34fa00f1a1c20 100644
--- a/fs/nfs/callback_xdr.c
+++ b/fs/nfs/callback_xdr.c
@@ -275,6 +275,13 @@ __be32 decode_devicenotify_args(struct svc_rqst *rqstp,
 	if (n == 0)
 		goto out;
 
+	/* sanity check the count against the remaining stream */
+	if (n > xdr_stream_remaining(xdr) /
+		((4 * sizeof(uint32_t)) + NFS4_DEVICEID4_SIZE)) {
+		status = htonl(NFS4ERR_BADXDR);
+		goto out;
+	}
+
 	args->devs = kmalloc_array(n, sizeof(*args->devs), GFP_KERNEL);
 	if (!args->devs) {
 		status = htonl(NFS4ERR_DELAY);
-- 
2.53.0

