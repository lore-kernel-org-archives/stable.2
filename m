Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047551;
	b=QZ8Z2G1e7yvTLX+Zmyv6i4oIIinVStoydIGKNyWFCaHU7yWkjTQXSt46NZsL/tAw3R/S
	 5NcpyoHAG9V95Ne89aNc7DzM5tXw5PBCFrTnsBGl4L8VuM1/HuQfhwhpo/wsIZ10AFZ+d
	 fqI5BY7YoaWvCji9PNEECabXQOrqW76mjblEtagttok9ZuuFgqWHawGKGj9tj00p7vRhK
	 6AarN5HuXgDOO9uglWWRu8JNnK1JQlgHr+oldEB5pIjygMoFA21iDr1tNEV7WIj7RvQfG
	 1CzkbuWiY8fSwRh6piL5Zr8bT7/OyHRQgLQEj0klw55SBh+9ne8Ro9K13mx1aW/7GEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047551;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Vda/UAlo6Nh0jWVyarOhRn3uYL3r089vPRKwYnVojZg=;
	b=nNJdSDdYtWVSueJL7WbfUdhitWhKZJLy79yuYGFtMEMYbr4dbgE1zndUEXxDLssU3T+Q
	 HCl375lvvsj56oFnL6w+KxWXNgYJiYAC2BW9ColjYTq4m9UjFc8MFvFD3uDk+B/FNCQ6v
	 DJ9OPjtU4hjfLiSoyNeAFbb4UYuaKgEi6vek38Fl0DVwBK7Fin7+bnV0YtJ9Y+PD7MzSN
	 zUPL7GEgz7KBa/gbl5q3Pm5Q2ygWUI3fDAaUwXezE61ZEsG7CjCqLe+YGt2nk3/Cq82Z3
	 2oCe1XRAxQVP4MmXc2RnQZONkAVeEdfxgSN0fEvNDfaSeQh3GR7eIqgGVvWTgO97DQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SUZLKdvg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232D1606A32F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SUZLKdvg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0171F0089F;
	Sat,  7 Nov 2026 10:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047551;
	bh=Vda/UAlo6Nh0jWVyarOhRn3uYL3r089vPRKwYnVojZg=;
	h=From:To:Cc:Subject:Date;
	b=SUZLKdvg9xVy6dmLc3gb8KagTSqziGWKy3apTgszZzn3f3QH5m8RyoddWq77NZtTm
	 EQAAKarXcTq1EWatIuIpwmFtSIkIphz9BS05zE/Alvw241eT314HdDh++PVFeDL+7C
	 NaZfaw2TFxA9ndO7jhSItu6F1Xy1p0E96gDRkpgqhXBi6pwWos6uv6wNvkeiA1yJzm
	 T5HJFeP6a/OVKETu9rczPNnxhdtT2VcnlFyyi/GWb7WuH6c4L00QyN+62a8CejbQ6q
	 sEFEvDvju3+kRdRW6SKjOXl3PHXRQAYIp71U7RUqeEPeOAVFmBjd/Jns1M1ikf1lY/
	 2m2YE/gQ//1pA==
From: Sasha Levin <sashal@kernel.org>
To: mhun512@gmail.com,
	ae878000@gmail.com,
	nbd@nbd.name
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] wifi: mt76: mt7615: restore DBDC state after ext PHY failure" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:32:29 -0500
Message-ID: <20261107053229-failed-6.6-7907d5270dc5@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 7907d5270dc5c13b6a95754c08a77d5b06bbc786
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053229-failed-6.6-7907d5270dc5@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 7907d5270dc5c13b6a95754c08a77d5b06bbc786 Mon Sep 17 00:00:00 2001
From: Myeonghun Pak <mhun512@gmail.com>
Date: Thu, 10 Sep 2026 17:54:41 -0400
Subject: [PATCH] wifi: mt76: mt7615: restore DBDC state after ext PHY failure

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
---
 .../net/wireless/mediatek/mt76/mt7615/init.c    | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index e437e088b2e91..665b0f1e939f1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -541,8 +541,10 @@ int mt7615_register_ext_phy(struct mt7615_dev *dev)
 
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
@@ -572,7 +574,7 @@ int mt7615_register_ext_phy(struct mt7615_dev *dev)
 
 	ret = mt76_eeprom_override(mphy);
 	if (ret)
-		return ret;
+		goto error_free_hw;
 
 	/* second phy can only handle 5 GHz */
 	mphy->cap.has_5ghz = true;
@@ -590,7 +592,14 @@ int mt7615_register_ext_phy(struct mt7615_dev *dev)
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




