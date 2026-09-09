Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F24332EAE
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788973633; cv=none; b=IHgy/pmyac0xbXvcfiK6U3NHZXATa4TGDUboWVMebUHskx4MFqgYd+gxYhr4cY1AFSyDg77V6a3NKRu1lTOdDA7rFdR6R/ZfiRpDJTfgq33s3Q7Kg3IrozzfPZEJzfawKITjAD88ns66VRj50cTopOwyoO5kZEXqXhcBHNtXbJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788973633; c=relaxed/simple;
	bh=jF7+SQ+0wRPaDXq3XkxCNO3NWjF+IIdDSitGkBxp9P4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s/G7ElOHK2VYj59V+FwXPBnX3eDy7agSb2g0DUmH3FL2bhNK11K6yPe4u+DGW0qUTVnhL+BHnOeQMWlszThYIVnarF6MC7wCKvMUIPi4KRe3cg2prdxqvD7L7TwoWfprxE3gZQiW6hiQTlOpNnhC08IIfAPB5s1caKJ8HLQ4mOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSBQN8R0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSBQN8R0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 035691F00899;
	Wed,  9 Sep 2026 17:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788973630;
	bh=ZXpbBtGgpLd80xxQG2PevLJhxDkIrF5dxxNySATe8Y8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LSBQN8R0MInhnK7aSZdiCEwXHi/f3IWD4bxJM4fo3Oeo5Fz133+SaMsqdIykFYPnw
	 dnzd+Npg8bi9wqftXXYVhZOYaiI/M2uk8KxEtVDXuZkonQcmUpvbW3vWSZqhGcwxXo
	 Rnr4pAvqoqtGa1+RDmSDFuBL2n01CTChEdNDJI8POCsh9rY4b7RXlMBt3S8pahgd8x
	 Gcej1XZQUXcEfrGXCupZl2yesn/nqpvzEv62aipGETdPYjBHanu1rBTOjrLT1+Kdeq
	 SZAc7PuKhtu3crje6Y32w5DtVMTZGow+LCVf4m/UVeSx9WN5LZ6V4RXvIGmXoU5CSk
	 jkKCVCkRAUoMA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Paul Barker <paul.barker.ct@bp.renesas.com>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] net: ravb: Only advertise Rx/Tx timestamps if hardware supports it
Date: Wed,  9 Sep 2026 13:07:00 -0400
Message-ID: <20260909170701.3189413-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909170701.3189413-1-sashal@kernel.org>
References: <2026090322-boss-emu-7014@gregkh>
 <20260909170701.3189413-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

[ Upstream commit 126e799602f45e9ce1ded03ee9eadda68bf470e0 ]

Recent work moving the reporting of Rx software timestamps to the core
[1] highlighted an issue where hardware time stamping was advertised
for the platforms where it is not supported.

Fix this by covering advertising support for hardware timestamps only if
the hardware supports it. Due to the Tx implementation in RAVB software
Tx timestamping is also only considered if the hardware supports
hardware timestamps. This should be addressed in future, but this fix
only reflects what the driver currently implements.

1. Commit 277901ee3a26 ("ravb: Remove setting of RX software timestamp")

Fixes: 7e09a052dc4e ("ravb: Exclude gPTP feature support for RZ/G2L")
Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Tested-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Link: https://patch.msgid.link/20241014124343.3875285-1-niklas.soderlund+renesas@ragnatech.se
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 1f77af0aaf27 ("net: ravb: avoid dereferencing an invalid PTP clock")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/renesas/ravb_main.c | 25 ++++++++++++------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 578ab58c9fec7..2e36be812945a 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1323,20 +1323,19 @@ static int ravb_get_ts_info(struct net_device *ndev,
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *hw_info = priv->info;
 
-	info->so_timestamping =
-		SOF_TIMESTAMPING_TX_SOFTWARE |
-		SOF_TIMESTAMPING_TX_HARDWARE |
-		SOF_TIMESTAMPING_RX_HARDWARE |
-		SOF_TIMESTAMPING_RAW_HARDWARE;
-	info->tx_types = (1 << HWTSTAMP_TX_OFF) | (1 << HWTSTAMP_TX_ON);
-	info->rx_filters =
-		(1 << HWTSTAMP_FILTER_NONE) |
-		(1 << HWTSTAMP_FILTER_PTP_V2_L2_EVENT) |
-		(1 << HWTSTAMP_FILTER_ALL);
-	if (hw_info->gptp || hw_info->ccc_gac)
+	if (hw_info->gptp || hw_info->ccc_gac) {
+		info->so_timestamping =
+			SOF_TIMESTAMPING_TX_SOFTWARE |
+			SOF_TIMESTAMPING_TX_HARDWARE |
+			SOF_TIMESTAMPING_RX_HARDWARE |
+			SOF_TIMESTAMPING_RAW_HARDWARE;
+		info->tx_types = (1 << HWTSTAMP_TX_OFF) | (1 << HWTSTAMP_TX_ON);
+		info->rx_filters =
+			(1 << HWTSTAMP_FILTER_NONE) |
+			(1 << HWTSTAMP_FILTER_PTP_V2_L2_EVENT) |
+			(1 << HWTSTAMP_FILTER_ALL);
 		info->phc_index = ptp_clock_index(priv->ptp.clock);
-	else
-		info->phc_index = 0;
+	}
 
 	return 0;
 }
-- 
2.53.0

