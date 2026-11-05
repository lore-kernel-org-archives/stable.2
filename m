Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793837344;
	b=rmw5vYPHh8pWG6uhLgYwT+ofo5x6/ztYao2lrDfJe7Q2Dp/EoUD3Bnf6S+ls4FoL6KmT
	 kiqbJwWQtB3U9kLQ1lPlc2NFfzbkOgJetwTWeE6H9JAL/mYGtrIcIijvWt07qBU1e/4XF
	 aIvms1AXgzn45y1HH4GsCiPdb9/uZMo0BaOlcZc24OKOHNtWtYhEy2npP/2QerExN4NZr
	 0Q3L3A/AxY4j+4hYK2NWXUzTzG80BD9uSvMuCbFGiFV1opIHFOSAXubHLiK17LpdZiGy7
	 jVr3PyZo2poyWHr7mbGYh1ojcpj84J+PbiuXKGODNojp6vTGb1sEp0PELk6v6lD5uRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793837344;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CWbh8T8xcwlyHyj/A2VvfzV9LVGJIdGPItMWQe9O76g=;
	b=zuBr4sj7kgSeq4nITlP7KupzD4rq6gVROqce6TrgvYSsm6O8raUYf5zGSIGSOFrSOWXO
	 V35SUd7g3AygRJhGETAlI9YvSzNdQ706xcCXzXDUVtbP9AIZTDhPe4Vhm6aoX7+5E9CiA
	 RZFBY/kJ48i3eLVj7Gdnmq5zmAmZTtw5QQbIfcvjbigv5+rbvGhsu6tg++zx/6So68/Ku
	 g4IM/2XBTAlFhMu/enc3TQB7S/eSN64QPrpr7CPh5/AyKjaNDvOeEyKypiznZc7pIKDAb
	 inZuEtt2EzKjxGzNAeeFsxNMVrq3XCY0DyAjquZsxPF7FEYH6FV5dBNhO7FNsd1vl+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RleSyJh+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF9B606A328
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 00:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RleSyJh+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFCEE1F000C1;
	Thu,  5 Nov 2026 00:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793837343;
	bh=CWbh8T8xcwlyHyj/A2VvfzV9LVGJIdGPItMWQe9O76g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RleSyJh+dcxHW6pcskYIu5ZkrANvTrFN2IbBDcMrwKkjjX0Joqdfdm2WW5AuYMs/D
	 GcVd81iNR/s9uq6dBmL1/PdOWRLVCdhVgJWijnXyLZE3Gjca58OA7hYIDmbMe48YBd
	 vDze9dtPX/fJoLDuafQ39a2I9RCLwPhNQuhVCyGBuTuLNS98phaReTeBCk+ZOeB9hH
	 TRYycyx5D94OXTbkAQc2x80menwYqCCbppafacDs4A19Z9tipdL08DIlOiuEkAaGXW
	 QmHTQwpFr9kBzLVs/jeVtTNWONk2LHE4W7It/xKIyNdp9L4Iz9jp6OBF3mllgQ/Glt
	 3+34ipgPH/Tvw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhao Li <enderaoelyther@gmail.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] wifi: mt76: mt7996: unlink TWT flow if the MCU rejects the agreement
Date: Wed,  4 Nov 2026 19:09:01 -0500
Message-ID: <20261105000820.978745-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110430-vagueness-punctuate-be5b@gregkh>
References: <2026110430-vagueness-punctuate-be5b@gregkh>
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

From: Zhao Li <enderaoelyther@gmail.com>

[ Upstream commit 022f5f8b7a0580da50fcbc34da853d03d4321fe2 ]

mt7996_mac_add_twt_setup() links a new flow into dev->twt_list before
asking the MCU to add the agreement, but exits without unlinking the flow
if the request fails. The flow-ID and table masks are only committed
after MCU success, so the still-linked flow is invisible to the
mask-gated teardown paths.

If the station retries the setup, the same slot is cleared and its
embedded list node reinitialized while it is still linked, corrupting
dev->twt_list. If the station disassociates instead, teardown skips the
flow and station storage can be freed while the node remains linked. A
later scheduling or debugfs twt_stats walk can then dereference the
freed flow, resulting in a use-after-free.

Unlink the flow when the MCU rejects the agreement. This restores the
list to its pre-request state while leaving the unchanged mask and
agreement accounting untouched.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20260729173632.14387-3-enderaoelyther@gmail.com/
Assisted-by: Codex:gpt-5.6-sol
Assisted-by: Kimi:K3
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
Link: https://patch.msgid.link/20260825112620.97568-1-enderaoelyther@gmail.com
Signed-off-by: Felix Fietkau <nbd@nbd.name>
[ sashal: Adapted mt7996_mcu_twt_agrt_update() to pass msta->vif instead of &msta->vif->deflink. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 14c84219ef750..42e75e7416ed4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -2551,8 +2551,10 @@ void mt7996_mac_add_twt_setup(struct ieee80211_hw *hw,
 	}
 	flow->tsf = le64_to_cpu(twt_agrt->twt);
 
-	if (mt7996_mcu_twt_agrt_update(dev, msta->vif, flow, MCU_TWT_AGRT_ADD))
+	if (mt7996_mcu_twt_agrt_update(dev, msta->vif, flow, MCU_TWT_AGRT_ADD)) {
+		list_del(&flow->list);
 		goto unlock;
+	}
 
 	setup_cmd = TWT_SETUP_CMD_ACCEPT;
 	dev->twt.table_mask |= BIT(table_id);
-- 
2.53.0

