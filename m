Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320833;
	b=pXtltj2OYR3Ao7k3sKQgShbkCYBsYYpxFs0VbL9/mt70a3y34QDP0lKWTTVotLvckVVE
	 fS+aIunlEpflKzDR6mfEZZWzpRksb7K8twVDsKZcLbTziBoVUbCHpz89e3FC973iu9rpd
	 dC+03pOk31ZBgAqEWkeHJSXoAH85N3jFekITmO9gXzm9pmmLbG2I4Fi036nj0z2na3uNB
	 j4/3iY9zOzavlTZfinahr1qr0LJrD7uBVEZrfYhSaap0r7YV6ivg7wVVIx6UWYNOo9e0F
	 NWgxLg3lLDVEDU/F+2bnofyfusR9HkOYQ46iLg6xKLNkeLHl4hmdS4oQmUm8fximgfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320833;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6E+/kQQ4kHnCd3SMS5uPNQMx96UrRXPD/XNn3NgbOOE=;
	b=juFEx02FvRlI3Y5tgGxZgjMqZ3itCe+Euj4mjekUqYh1jmvoV1mcq+kkJJfxbNyKNiuA
	 8nhE2vDKvTc906QyYIuP1x7JY/pMK8YHulHwOsboVljnp9BgJetsh7qJh76UX3frxhgLe
	 fGvv4LAP8Dtx/p/HSOnFKdr/2wDCHBaEIlqol0szKIl3XECF9Quuh7JYZqo1kRgK0/R8j
	 unmze8B9Sg9BFL5BKdymHkhdnh/ADm5uxutSRhG7W6jtDn6LqQNlnzNJktWjCsdrx+lOb
	 uj9z3h8c3D+AhCd4Go+av47PusRR5IEf0NjfvZz3Zll+YLHi59sD6LLCDBSpzTewR1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WZ9TMXtd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11B4606A339
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WZ9TMXtd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4C21F008A4;
	Tue, 10 Nov 2026 14:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794320833;
	bh=6E+/kQQ4kHnCd3SMS5uPNQMx96UrRXPD/XNn3NgbOOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WZ9TMXtdOM5Z9b1PCeD69ptfoM4Gb/xkvJJd1qP5MgxT46WP5chnVsz6lpyY0449F
	 qUhEF0UqZ3gSHfKBSnEUESLBoHblMiFZ5VYXk3oIDsYTnAcFpITua1cVawLC+nWSw+
	 b5hqut2eUDZfQCdsF096+5DgiRuJmFBBQFQZL0L2/GY67/+Xbh0EKjLmVyhaJyYAsv
	 9GDOa4gkfNEbuE1Tf6beR/miV5Cdj8siB+w9Tx1cuoMwop+Eyf3ckVhD/8pMEVCRXb
	 nwRfeCWgoeyUWdy9rYqk4+KB+j/SOLIvpFDLWeJhCO6AtE1U1W/M13Mw8kLhc+DYrM
	 gTqPJ5jk4IPdg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] wifi: mt76: mt7615: restore DBDC state after ext PHY failure
Date: Tue, 10 Nov 2026 09:27:11 -0500
Message-ID: <20261110142652.1886873-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053229-failed-6.6-7907d5270dc5@kernel.org>
References: <20261107053229-failed-6.6-7907d5270dc5@kernel.org>
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
[ sashal: Omitted error handling for mt76_eeprom_override() because it returns void. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/init.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 129350186d5d5..e50dcfc8bcf2e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -545,8 +545,10 @@ int mt7615_register_ext_phy(struct mt7615_dev *dev)
 
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
@@ -591,7 +593,14 @@ int mt7615_register_ext_phy(struct mt7615_dev *dev)
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

