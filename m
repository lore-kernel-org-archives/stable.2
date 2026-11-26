Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795715615;
	b=yporjuHQ/rbrD9oRpkJMbc3l0A9d1vNAZivNUD6mZK2ZVgNR6bp9x3BzTqiyP4Tv/pHr
	 xb9HBhyFdYgM6WPmky/5xtLwBDm+xdcRyan2gpyQktrceiby4gwaDcDfyefklMNWXlIyn
	 Fh6BIgapL798j6lXH54mTL2q2briB7hHdvOt/jQm0+QcpaOWAIsQbevrJ1ytT67jA3bAH
	 NBCaIGUBQbRb53XDmPO9KAi62F2JaIR40Y58EfnmwSiLnREZlNnCqGuyVxTbrj4VUKyED
	 GsHTNUOg/Lg9nRCJfZrgTiZmVNQ7jSjLX4E5QuQfuEEKIMFFXGNqxbJGanEXXqCdXYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795715615;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0pQ9GEAcc8EGQNOQeS3VNOfksRTSnbgTKVbMBryXtAQ=;
	b=sThGRbppNmI8SrCOStZC0l93A2RLvee43O6BSr1jLzQAe1ZPmwQwG/39xrgNU8+I1jtC
	 wM1q7zmN8cJ2jyOAoeEmhGf76bsQx5RexNU2VCMqdZrj8qjhWlZRA97w2iI9pyVU4QmUY
	 sGsOUoYhjre9GFv6x/VHffPltKGIOH/srQvBcIg533QN0zMik6N/ZSqpTcqlbgVrCazOY
	 3vLMOUz9L2kG7X86eW1CTCwXiC2YmWOTracxKZoCClOLElKs8I22KlvyaJR39IRFy9uGY
	 UNgmbjW3aQWaZy/hUltdV5lwixLyiqTW4JOdfUGZ+TAlyOnonZecBlu0ax3xbWYBRUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UpHC8wJb;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBDD606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 17:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FBDD606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UpHC8wJb
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso73496195e9.1
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 09:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795715613; x=1796320413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0pQ9GEAcc8EGQNOQeS3VNOfksRTSnbgTKVbMBryXtAQ=;
        b=UpHC8wJb50bq0qZ2YFO8xWsMUEQX58CwzJ37600UltwuGNQsEzBvIVCZH08puwAY5n
         9MmDny7QWhBhhnT97QaZF4t6r3d4RwnSp2JUBIy+ZogsF2PeEN1JITlPS7K8pPME7nQu
         aPsGrla3Yo+o3m2ETseb26VJpaCX939F25/UW/1HMTMuyLbJZlw1TK9bCNOvtEIQ8ujd
         VSPBpjwMjTq4B9R4HBHLEu8ypRlVnJeFWJRzcIeHzPocwKqhoVw//B4HVjv/uDWsglSn
         iTU0UP0ksnAU1UWuzpNCMmlAQb05jm75A8qpM9n/AlIX9lW6Telp8o5vqDrHrZ0WNFdP
         mAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795715613; x=1796320413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0pQ9GEAcc8EGQNOQeS3VNOfksRTSnbgTKVbMBryXtAQ=;
        b=dkGf+u3eOIdsSbPKFazd+HlekKqRlFt1hGzPyqTzyRxRGGTHkLCmxkA9SJ3w5TGn//
         8WfX5Wa3tF++mWdxHXb31zcu83wu7DXc8arIB3biYeM36Jc6YPrqtY0emj39dKj3gpUu
         0XyhVHvHkCnj+LnKzcmjFOaO1Vj6JSzQLMkGYy20lwuXNVqwzLfZ2sCgiLpvwP1MXM02
         GYwKsVDq+7aMn1m+RZSOsNKVGN9ZXI1MKylnBNaIXTejUVfZSgUD1RJdaqd6sr+hgN6u
         OGaWM1ekSA237qDHVQurvndgW7DSHOs8y84ULVWdpA400l510AmclDRYl91LxKB+9jgT
         QBig==
X-Forwarded-Encrypted: i=1; AL+hErEmKeZvwmcT9MvUBBsVmAGDyni1uf76CCePisRdi8xE8tspNm+Iz32+6bimkfraUjYqoYoHdWg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8saNT45OmOwiKvaz16YFaKPHffMIjXOwyEBOZfHKl7BBtQLjLD
	uDGQ/SG05QCQLskiDF+TvjxRLpUCTLnc6gXnRppkMUEPs+D/pPcYAEmF
X-Gm-Gg: AZFdTZe9MddGPGH/m5qjq0uMVgLrAjmelaewRYTlMFCyrnlQLh2x0eNKBGwb+nPW4+S
	TWrqxFld/Kef/mkajrqFVGAu5DEqW0/Kn9N6wEYYeoaK51M1BJbpvQaD/sgFhvMwG4+MoXWBSnO
	9G/48aLOmvG8FgRjP3gvpIEKBSvnDyjx2kgokUj0H+F1O4DV1UcRPnIGHgfrUjhegjlyWcX4Ly6
	nP7SrGonmp3Nh1C8U8AYdUwpHJzLpSUeLBJs5QdhDSWMK8sZQajXyG/pW7nx/G+ydY/Mi+bvATz
	Utg7Bth0HElMBTPf1GBPOyG/xq542zOH9tY36Ogjjs+jTa8oR4myLnToVibdpXk0h5Ejfw2+9x4
	TYPD6Jbpmn7gWqYX9TaU7NdSoVuiQZd3ec5gTknZ16uC1mbJ5fOv27WHvcWTsDfl+7tcU5HK18o
	6bfOA3r0P+/P4o04aKIJAJNV5Ym5GX1fSp75c5QehTP9cHNma3iETmlZOnPpqqCuO4Z7+dPYhxe
	jKUWmdQZzKjX27i+NHLh4dIv9FotZPLEx19+voLquBFbstlaX6TdmtgLz2wTP+FJfxvEA+DOM+d
	P42MN+zAN4rcShVu91FTWfpZqdtdenEwS83+2q3kcskjkKkUQrec0ARzpg==
X-Received: by 2002:a05:600c:a088:b0:4a2:1a:a120 with SMTP id 5b1f17b1804b1-4bb8880ac02mr414371695e9.6.1795715613194;
        Thu, 26 Nov 2026 09:53:33 -0800 (PST)
Received: from vitor-21h1cto1ww (dsl-30-199.bl27.telepac.pt. [176.79.30.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884a15absm564366045e9.9.2026.11.26.09.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 09:53:32 -0800 (PST)
From: Vitor Soares <ivitro@gmail.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Vitor Soares <vitor.soares@toradex.com>,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
	stable@vger.kernel.org
Subject: [PATCH ath-current v2] wifi: ath12k: report TX status for broadcast and multicast frames
Date: Thu, 26 Nov 2026 17:53:23 +0000
Message-ID: <20261126175323.2390231-2-ivitro@gmail.com>
X-Mailer: git-send-email 2.53.0
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

From: Vitor Soares <vitor.soares@toradex.com>

In AP mode, once a station is associated, broadcast and multicast frames
sent by the AP log:

  ath12k_wifi7_pci 0003:01:00.0: dp_tx: failed to find the peer with peer_id 2

These frames complete against the AP's own peer. That peer has no
station, and since commit 981050b918fc ("wifi: ath12k: Fix TX status
reporting to mac80211 when offload is enabled") a missing station is
treated as a missing peer: the frame is dropped and an error is logged.
Before that commit, the TX status of these frames was reported without a
station.

Report the TX status without a station when the peer has none, and add
rate information only when a station is present. Only drop the frame
when the peer is not found.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c7-00108-QCAHMTSWPL_V1.0_V2.0_SILICONZ_UPSTREAM-3

Fixes: 981050b918fc ("wifi: ath12k: Fix TX status reporting to mac80211 when offload is enabled")
Cc: stable@vger.kernel.org
Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
Changes in v2:
- Keep ath12k_err() for the peer-not-found case (Rameshkumar)
- Link to v1: https://lore.kernel.org/all/20261116230250.369383-2-ivitro@gmail.com/

This conflicts with c752394249f8 ("wifi: ath12k: store station pointer
only in dp_peer") in ath-next; the resolution uses
ath12k_dp_link_peer_get_sta(peer) in place of peer->sta.
---
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c | 21 +++++++++++--------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
index 41abf1865702..3c2a008ba185 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
@@ -856,7 +856,7 @@ static void ath12k_wifi7_dp_tx_complete_msdu(struct ath12k_pdev_dp *dp_pdev,
 	ath12k_wifi7_dp_tx_update_txcompl(dp_pdev, ts);
 
 	peer = ath12k_dp_link_peer_find_by_peerid(dp_pdev, ts->peer_id);
-	if (!peer || !peer->sta) {
+	if (!peer) {
 		ath12k_err(ab,
 			   "dp_tx: failed to find the peer with peer_id %d\n",
 			   ts->peer_id);
@@ -864,16 +864,19 @@ static void ath12k_wifi7_dp_tx_complete_msdu(struct ath12k_pdev_dp *dp_pdev,
 		goto exit;
 	}
 
-	status.sta = peer->sta;
-	status.info = info;
-	status.skb = msdu;
-	rate = peer->last_txrate;
+	if (peer->sta) {
+		status.sta = peer->sta;
+		rate = peer->last_txrate;
 
-	status_rate.rate_idx = rate;
-	status_rate.try_count = 1;
+		status_rate.rate_idx = rate;
+		status_rate.try_count = 1;
 
-	status.rates = &status_rate;
-	status.n_rates = 1;
+		status.rates = &status_rate;
+		status.n_rates = 1;
+	}
+
+	status.info = info;
+	status.skb = msdu;
 	ieee80211_tx_status_ext(ath12k_pdev_dp_to_hw(dp_pdev), &status);
 
 exit:
-- 
2.53.0

