Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9E1396588
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 02:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789613462; cv=none; b=BP4Yuuic+B0D624jyAp7KYuvOaV2D8BE0am3SCXg+Td+I5se1M/7wHFwvlgfr1ysTSXT6MsX6aFaDC3YKh+kZNiX3GFQ1/5WH7KwvigO89wVFlIn2JF3Ca9yLlou8ihfFmYjhqY5OA7kbkQGD4S/h37Khx6N1Ivpy5zSmvA2GT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789613462; c=relaxed/simple;
	bh=BSw3s/pHlOZApWZIND/hAEc2x73tI3YT2PEirLeQRNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IrCx32/z6uZTawy4iVHL4A6IRcN/s9KD7rdTfQqZkH3cHnPzKiSahjVdXO8/PHj4BeovUVwHSwGkty6n3S7aCHluqjwupv5/opz9HgAekOy+AP7g5bilgT4n37sw7B8E7kIjahvu236bYPI8udc773Mh9FSwhcCmzLL2FryCtfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQnqL+6U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQnqL+6U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB101F008A3;
	Thu, 17 Sep 2026 02:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789613426;
	bh=xeMfAl1hGGBCvoXb6MWes2fLbqGxbMQiO4XGG+8I5cs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JQnqL+6UKjr5CImakkd2MgQphnF0svQQ8BloQndBCeWM8+HJEpCkfkT9kZgY0+mh5
	 EAOdQMrWa2YsppNcgisg4ek38kZRqSAwSDRlm+l6JqisFR7Uj9b0uGSyeMpi1kEOZ1
	 aMIRxQNa/VqcUUG9GRz/SN8crHWp3buJfg0zZLGzUtlg9YHWxIzFsH4Bw1ITS7LGog
	 B0JDjiRfpGWG25FKOt5qJAt1aAzXora/lBBa8p/xgNYsRne1z5ST2euZI22X2zEnRP
	 fmryoVdQ3NLWYGxiqpog5VMvg6golbx1YJmleKC6i4nNqHWBWOofkIRbdA0ycG4h7x
	 UnAkuivn6dC/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Chan <michael.chan@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] bnxt_en: Do not set EOP on RX AGG BDs on 5760X chips
Date: Wed, 16 Sep 2026 22:50:21 -0400
Message-ID: <20260917025024.3917679-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091604-recall-carnivore-5fe5@gregkh>
References: <2026091604-recall-carnivore-5fe5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Chan <michael.chan@broadcom.com>

[ Upstream commit 30f253f8d9a01d532fdb7ec6c8a9d4c15fe29241 ]

With End-of-Packet padding (EOP) set, the chip will disable Relaxed
Ordering (RO) of TPA data packets.  A TPA segment with EOP set will be
padded to the next cache boundary and can potentially overwrite the
beginning bytes of the next TPA segment when RO is enabled on 5760X.
To prevent that, the chip disables RO for TPA when EOP is set.

To take advantge of RO and higher performance, do not set EOP on
5760X chips when TPA is enabled.  Define a proper RX_BD_FLAGS_AGG_EOP
constant to make it clear that we are setting EOP.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Link: https://patch.msgid.link/20251126215648.1885936-6-michael.chan@broadcom.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 5ce7f36c334d ("bnxt_en: Don't free the live ring's TPA state on queue restart failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 9 ++++++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index e14e2a0bf89ce..09306e706997d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4300,7 +4300,14 @@ static void bnxt_init_one_rx_agg_ring_rxbd(struct bnxt *bp,
 	ring->fw_ring_id = INVALID_HW_RING_ID;
 	if ((bp->flags & BNXT_FLAG_AGG_RINGS)) {
 		type = ((u32)BNXT_RX_PAGE_SIZE << RX_BD_LEN_SHIFT) |
-			RX_BD_TYPE_RX_AGG_BD | RX_BD_FLAGS_SOP;
+			RX_BD_TYPE_RX_AGG_BD;
+
+		/* On P7, setting EOP will cause the chip to disable
+		 * Relaxed Ordering (RO) for TPA data.  Disable EOP for
+		 * potentially higher performance with RO.
+		 */
+		if (BNXT_CHIP_P5_AND_MINUS(bp) || !(bp->flags & BNXT_FLAG_TPA))
+			type |= RX_BD_FLAGS_AGG_EOP;
 
 		bnxt_init_rxbd_pages(ring, type);
 	}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 67a82b3262d58..24f777832ed62 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -124,6 +124,7 @@ struct rx_bd {
 	 #define RX_BD_TYPE_48B_BD_SIZE				 (2 << 4)
 	 #define RX_BD_TYPE_64B_BD_SIZE				 (3 << 4)
 	#define RX_BD_FLAGS_SOP					(1 << 6)
+	#define RX_BD_FLAGS_AGG_EOP				(1 << 6)
 	#define RX_BD_FLAGS_EOP					(1 << 7)
 	#define RX_BD_FLAGS_BUFFERS				(3 << 8)
 	 #define RX_BD_FLAGS_1_BUFFER_PACKET			 (0 << 8)
-- 
2.53.0

