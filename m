Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321107;
	b=GsGOr2iLHG/jrPONh8iiiizFhb1lGj9WbvRSfP7Tp0yUf2ymNLbQ5TNUfKbkkZw4o06d
	 ZRW76DhBtZu9qb0XAjidKHBK5oqxy6e0LdLj1sQltJgrYA21wZ9vzA2GhPO3oC53aUNAh
	 dyBm1jdUenf9d2ptlO5yv4cUsWpHRGGS4FT+9feaHbumvwKZmuMQrJj6SgCzwLK5UVk4E
	 /LjdXpsZMwntWkFSZeLxetXh7AHD8+HZHOQzz9qDMRLfNKH5FSDSBUCPXq+iEVPqPxkFh
	 JCcNE8/TduaL27NVipBT5gBGbuBrX2DXXCn+Y58TkZomq20HQyuHr5MD/1KN2OePIVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321107;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JBDDNV6lQ59reBnxPt4erQrBPA152YekVwx7tBl7MZU=;
	b=Uy4/Wc3wSWNOhRy1lrq9sBfy1WuolCXuidRlnvpj1a/8LXaPXaJ5MDIFsDgwL1s9Yqf3
	 Gbge8NIDXvHUyPvf2EJ0wUBSL5T74aWYsnSSpjLYJzbxICqcxftrhWirnT1XMr3VhoN7Y
	 YphAfRfLRwJ5CRP8jnDl3xcIdGem2VWjODV0myo3O56piKbq3ytxbrem1zGwNYC8dOuiX
	 buxuj+Nu5ju3/LmMYVeOh+6pRNGMslAwdjif7+hRtAh4NBYb8ujlJ+DI8dg4DQAPtzRsQ
	 7S6U1FKKZt3WV07sF4MLGOmy5qbD1cUAgWyxqgKKhCmOHtuz/azxtax6NiGU7HP//3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NZGMGgg1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF30606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NZGMGgg1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A66BA1F008A1;
	Tue, 10 Nov 2026 14:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794321106;
	bh=JBDDNV6lQ59reBnxPt4erQrBPA152YekVwx7tBl7MZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NZGMGgg13p6B46fJKni6qkLQK+2cAi2kKjKokbq1WWZbhUKYk/4u9uHod62kNZEuW
	 K3LbsnzIvINLzQsJini72Rh6uP4aSwkKz1AVIP4S0NnfWAw/l/jqjaJ7o9Va7dyM4J
	 Pw2vQVA4xFlVSEpOFL+uwxjiTnWJYbaRfdFgXczCt70vsTIuvDNuyIJ3hC/pJKsNzR
	 B0ChDHJpt2yRjBnDYHVWdXN2k3OZMPrUMj8BRVBKXybrYKuZac+o/mJu6ZAjinqyYk
	 yt7y3uzb0FaGPTwhGsgwD3TzNZcJ4IGi8sXhV6iBy3r7gbPudQumyNiWEAwX8TPk89
	 7qWfux8In0OXQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] wifi: mt76: mt7615: restore DBDC state after ext PHY failure
Date: Tue, 10 Nov 2026 09:31:44 -0500
Message-ID: <20261110143128.1919615-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054521-failed-6.1-7907d5270dc5@kernel.org>
References: <20261107054521-failed-6.1-7907d5270dc5@kernel.org>
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

From: Myeonghun Pak <mhun512@gmail.com>

[ Upstream commit 7907d5270dc5c13b6a95754c08a77d5b06bbc786 ]

mt7615_register_ext_phy() limits the primary PHY to DBDC capabilities
before allocating and registering the secondary PHY. If allocation,
EEPROM override, or PHY registration fails, it returns without restoring
the primary PHY capabilities. The EEPROM override failure also leaks the
newly allocated ieee80211_hw.

Route all failures through common labels that free the secondary hardware
when it was allocated and restore the primary PHY capabilities.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: 0f2173f093b3 ("mt76: mt7615: add support for registering a second wiphy via debugfs")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Link: https://patch.msgid.link/20260910215441.76683-1-mhun512@gmail.com
Signed-off-by: Felix Fietkau <nbd@nbd.name>
[ sashal: Omitted the mt76_eeprom_override() error-path change because that call is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/init.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index cb5965700dfbb..333e33189c4e8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -463,8 +463,10 @@ int mt7615_register_ext_phy(struct mt7615_dev *dev)
 
 	mt7615_cap_dbdc_enable(dev);
 	mphy = mt76_alloc_phy(&dev->mt76, sizeof(*phy), &mt7615_ops, MT_BAND1);
-	if (!mphy)
-		return -ENOMEM;
+	if (!mphy) {
+		ret = -ENOMEM;
+		goto error;
+	}
 
 	phy = mphy->priv;
 	phy->dev = dev;
@@ -503,7 +505,14 @@ int mt7615_register_ext_phy(struct mt7615_dev *dev)
 	ret = mt76_register_phy(mphy, true, mt76_rates,
 				ARRAY_SIZE(mt76_rates));
 	if (ret)
-		ieee80211_free_hw(mphy->hw);
+		goto error_free_hw;
+
+	return 0;
+
+error_free_hw:
+	ieee80211_free_hw(mphy->hw);
+error:
+	mt7615_cap_dbdc_disable(dev);
 
 	return ret;
 }
-- 
2.53.0

