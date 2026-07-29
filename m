Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106E33803CC
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 20:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785357342; cv=none; b=ujcNWIWEBaIFZcLfOp8FjZX/7YbUVdmZ6Z0LD00krCmlDl12c9oWCnXYEBE+jtmHSkMKCoYpg7JHlyreNJtQpoJ/fMtboN2GgcoVCKWTOTah4IPzon+1Br9yeVFfFzvDaUkQZy0M+bBOqFzUeSd+G6A6xvtWOlugHmY6M76TSfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785357342; c=relaxed/simple;
	bh=CU8ZicNCQzIdxb/VOZ8AYOsorNmDMkxv9ffuihoX5xQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lX/+3wBvjegSUbfklYFyfPVG1pm65U5CkFt6akxIfITY/VYSzNmAClUh6mo9NqMTHYcHsyGdTRLgZMpcsdRXZQNwUtSRFOguwiA+VVcOx46mVfTP44aZnF4MdHpR3c89WMmcmep4QQX4W7Fgh8tTqXFapIVNVa0P+h6j6Y+792s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/3I2nk+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/3I2nk+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED211F000E9;
	Wed, 29 Jul 2026 20:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785357340;
	bh=Fg+1ola/1ewgKziitK4uIDfkuvvhACXXqU/3gRj0MOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H/3I2nk+eRSilz/jI5mnxGhq7+E3y+pyHzBJEFj6hv/9G0BeRV/tf/NoQ66BmRMVh
	 wC4dziSV7JVW8shMA6EGKqdhze3zMdRT3JcmXHrxDlzFUHdMuZVTuinBhTCTddO4cp
	 9on7B9Fz9F3YnUVUXKIUP1Lp3Nckh4MZAltP51XYkV66gVqCd+Hn85JoJAiOyFlLPh
	 jUA/jGDcrGFA/IbiXSaExKrD2j+dsAWPc1ZX00EcwIt/zcLMidcZY3GVCsaYimyzO/
	 VFlu+Rp1wuVNtVVbRDjI8YlNC27lJVsRSYDNz3zePVj4v6Zm/9fWaTbjhhsH3QVdp0
	 x4+FP+v+RuKBQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Wayen.Yan" <win847@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] net: airoha: Fix register index for Tx-fwd counter configuration
Date: Wed, 29 Jul 2026 16:35:36 -0400
Message-ID: <20260729203537.447604-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072102-stack-mardi-5c7c@gregkh>
References: <2026072102-stack-mardi-5c7c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Wayen.Yan" <win847@gmail.com>

[ Upstream commit 1402ecccf5630a0b7fa4749d7d2e72abc3f3d73d ]

In airoha_qdma_init_qos_stats(), the Tx-fwd counter configuration
register uses the same index (i << 1) as the Tx-cpu counter, which
overwrites the Tx-cpu configuration. The Tx-fwd counter value register
correctly uses (i << 1) + 1, so the configuration register should use
the same index.

Fix the REG_CNTR_CFG index from (i << 1) to ((i << 1) + 1) so that
the Tx-fwd counter is properly configured instead of clobbering the
Tx-cpu counter config.

Fixes: 20bf7d07c956 ("net: airoha: Add sched ETS offload support")
Signed-off-by: Wayen.Yan <win847@gmail.com>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Link: https://patch.msgid.link/6a2b40e7.4dd82583.3a5c46.e566@mx.google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mediatek/airoha_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index 07f89e08b5faad..273265b003d75f 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -2022,7 +2022,7 @@ static void airoha_qdma_init_qos_stats(struct airoha_qdma *qdma)
 			       FIELD_PREP(CNTR_CHAN_MASK, i));
 		/* Tx-fwd transferred count */
 		airoha_qdma_wr(qdma, REG_CNTR_VAL((i << 1) + 1), 0);
-		airoha_qdma_wr(qdma, REG_CNTR_CFG(i << 1),
+		airoha_qdma_wr(qdma, REG_CNTR_CFG((i << 1) + 1),
 			       CNTR_EN_MASK | CNTR_ALL_QUEUE_EN_MASK |
 			       CNTR_ALL_DSCP_RING_EN_MASK |
 			       FIELD_PREP(CNTR_SRC_MASK, 1) |
-- 
2.53.0

