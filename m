Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321814;
	b=0iWsY+aKo6n67caad2tCjoLxVQ7Xwa+ow11WjUiM+WS5zatvhX6+YILLgGzys5k7JmmZ
	 5U1VqT01xdRYFRa5E3ngXRONgkJaiNgHgT+cQysuhIL+AoGE0qqBHs9ni9genptuIPa2W
	 mx6opCln3AguLQ1aMadWem6v6JeiErWlXqVDZPh/vqv76rjx+YIlLJ2WeFeriba5OASxK
	 bs0VVdxJRMxGxUfLYViKcaG1KdljeVdxos5PkPWRGdpkXMfrBNbcs5NiF0lcmBBDsq+t1
	 0zRY0BahaLymyUi9vGNlZR2XqLlpAIpXnvU2cw6EHrBhPkavbL7wP0P92CUZtM4XT3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321814;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wX3bwwoXzMsxnSpxVwviRoqxZrpyJTHj8Yzx60K5w44=;
	b=Alz31nQ8RgcuNFHxdqaJqJrLN5+YGicOgCGxTB4ORpwY+UTnvz3ELesys6kD2uLrvAr3
	 9qbUmA1itCKV7JkyT+UDxa+2taYee7qDHOF6q7O71407sJS7a7XsvELiL7NJxUktdUUNF
	 hp1ImOIWydttFGwgPpO3IcL7nWJNvKR0b38BJKSZalX2XFf1dDpRDC9geL1DMh/AgLpbq
	 DKdGPA2Y+RiXoV4CvQy6TPAPPpRv0mIy0j7UrPakgcgVCI90zml0OtQC2iSvHs6WVRocn
	 f65+AyMdPKxidcCYNDjZoVQ0UNUf0K2kjvWTy237c40BfEUX3RLQNlGFRXWiJOHzfCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d6gHgRYZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D93606A330
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d6gHgRYZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 989C71F0089F;
	Tue, 10 Nov 2026 14:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794321814;
	bh=wX3bwwoXzMsxnSpxVwviRoqxZrpyJTHj8Yzx60K5w44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d6gHgRYZUAAVz/Dj8Ur4C9+8Oi0LPe21Hap3aqypL2WBRFVn4ZKswGRaohxizSjIS
	 MTozj3U3CwlGNxK7ncVtXawoDEM6tFA5gaY78s+Y2iITxYaANiGORzNGrJH7iATTwp
	 4nMynuMYfkJ7F3JGSFCEFSdjFADOlhm74oN6d5BXd18GgSSzuxTq3fDJKii9gnJ0Be
	 pd148CqrBziGrfaMmpSq7EfRc8rkqEKjYcRcFmDxcHu3epF1H++6/ZB6j0ovHboZw1
	 w1tMhLkETK9raAmX8E16ki8bYmK+n5h9y6U1NN5p/ptTxaGAMCW5W9KCO6Qe3qE3hQ
	 lAWUDAywuQzbA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] wifi: mt76: mt7615: restore DBDC state after ext PHY failure
Date: Tue, 10 Nov 2026 09:43:32 -0500
Message-ID: <20261110144309.1931564-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060245-failed-5.15-7907d5270dc5@kernel.org>
References: <20261107060245-failed-5.15-7907d5270dc5@kernel.org>
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
[ sashal: adapted to three-argument mt76_alloc_phy() and omitted error handling for void-returning mt76_eeprom_override() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/init.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index b284e264d89a2..bae48fbed116f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -461,8 +461,10 @@ int mt7615_register_ext_phy(struct mt7615_dev *dev)
 
 	mt7615_cap_dbdc_enable(dev);
 	mphy = mt76_alloc_phy(&dev->mt76, sizeof(*phy), &mt7615_ops);
-	if (!mphy)
-		return -ENOMEM;
+	if (!mphy) {
+		ret = -ENOMEM;
+		goto error;
+	}
 
 	phy = mphy->priv;
 	phy->dev = dev;
@@ -501,7 +503,14 @@ int mt7615_register_ext_phy(struct mt7615_dev *dev)
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

