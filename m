Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050366;
	b=auHWDVuM6ad2MpsnzS5cnKl9nYN7m5ykc2ZeoYV354TD83hNLQTQx9IjfqUJlnp5mDGs
	 J6+l5IV/MbR4PTdKMkIwM8AjN8vMBo3Kysjyi+F8MeH57XRE/Q+zqdJZWGkSIX6AXqFOB
	 hScqrrMmOhb2D8QAqCpCyo9OFQ7qw/etSdNtHDbMvz/ZD0/vl0Auvwl924yH2Rw2X4vY7
	 qOzJIGb+YjuuMNh8N+ZXrUjgvWjRMJJNbmH3PqI+IXsOsGr0Wn0QX5Vqs8bwD9UwFezbk
	 BvkS/ax0PCIsogqD29dBG8ddNpEPVGKggAAzIG+JEZL1lLA+wUgaK3wq24ZiBCQlgKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050366;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=p/L4k1ND37c/pWrmIdLa/4ELspRgzQletED8e0qZx5g=;
	b=SdQYuXji0F29vdPq9W49q12emZN9l4SGV8c4rMcWhToQaDmtUl04ll/WRAF930bA+zNC
	 8trndZyGIOf2MbHCsXYlZSxBnKX/S1WoK8fpslmjgGPAsDdTAsJ4b3qMavFKRcfKTgEXO
	 ShBLV6DWnvQj4EVv3V1ItbvX59gBoEkUFPYBblX8B2NFcaJtF3iXMZxrvZUUIjlVvuBm6
	 NYMYBthfsDmNuoj38sYN0t9IC0gCepfMpklRtZ+FqzIVP1JfrM8s5q+GJbcOgVrhUhAEr
	 CPg6xk0qhV2xBCY+CNc7zUx7IWKHt/f7vrS9f/lq0C1O7EPg7i6qbt/Ju0Fuhvnot4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YP5l0Cld;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB0F606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YP5l0Cld
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55361F0089F;
	Sat,  7 Nov 2026 11:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050366;
	bh=p/L4k1ND37c/pWrmIdLa/4ELspRgzQletED8e0qZx5g=;
	h=From:To:Cc:Subject:Date;
	b=YP5l0CldrupMDU+9IzvV58azrRvg4JIltGiLBH4WjaiLGKl5ej4HArSPsORgDFog0
	 u+PFkqz3YgTJoMGvGTxPSjxxG9bfpVlX1qEIvdjJ3I5k2cuk+YspY7utuTojL7s0oQ
	 NJXCSNC3jHSIV6pkxLtD0XcloPdYiV3j2/M1qZNMxNzRnkW3l5ol102cjBkYLhfoa9
	 +7HOvLhkEtM1Mf01buapmMELnKi0s9X3qQYM4uDsQI+9AhzS3xzAipV5198Ip848we
	 ATJr2f1NxFjWRr0DPc0RVww/n9c1ab64zKZ0d/s2YMsPaRfaWfH4zUDhqK+31Kod2h
	 +1U3F6sdAc5pw==
From: Sasha Levin <sashal@kernel.org>
To: mhun512@gmail.com,
	ae878000@gmail.com,
	nbd@nbd.name
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] wifi: mt76: mt7615: restore DBDC state after ext PHY failure" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:19:24 -0500
Message-ID: <20261107061924-failed-5.10-7907d5270dc5@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 7907d5270dc5c13b6a95754c08a77d5b06bbc786
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061924-failed-5.10-7907d5270dc5@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




