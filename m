Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795695977;
	b=NRo/3AOXQUyiMmLvLbANF8wNpkMMyO84uZk94jGAtCBynd0G6i3euc5dNIko/lAHiVGx
	 8iIYltQHzRsOyWBGG2BDMDzj2FpqbjLf9kJ/FANRMWgZhNDaizZIDpELDgdfPS4SHLXNw
	 J3CeuLcz+JKAS7Do6niDMitANOJu7xZamGXzfshEwz9NnA8+TxUXQKB0OfdzzyVHDRbWH
	 7MhYETHB5sdxhwXVNoAGUEeKb4PwNLdj7bhgU5k7/kt9mgoR88EqrWvFcnWKHQbifcbiZ
	 F6gbHkHnLTtRUZijqNq+BwmL0lt3BbeWAJusSM9WPz9RKdMlIXJcQR1OfJvwNwGjC9Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795695977;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=dvBrYsAGcqJ41oSp5NwAWPx5YIqYqwYWsABcr2HoDL0=;
	b=WioBycir7poQvQEQLXU/+uab7nb1PYlxWWgixrWubA4XECWoh9Ve+2UdK0XTtEVPUNSs
	 Op7roNAcTEm/Pz1fCf94zi37FR3luQFqWmZhrWRdBN/C5asajfu96mBe4BbKfom0htMeB
	 zuVU2BRn1/Sbty8oFfsX3/RHvR1XSk5WGQxJIkRoGWv8QXTVIZxikU3iShbVymwx9vf7l
	 FIx7SwzKTsrVXmK+qcPabtVfz5waJtrY4DxZ1QkmcgEYjvsWm79wW3s213sVRf6TaNcYX
	 kTpBm7W/WGnbvZ9+Oj8NYkqwX1TKm7HT/CPbsVRS76g0EnZuaPLNhgEkADpgM2FJlhg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oyTdh4un;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCE1606A31E;
	Thu, 26 Nov 2026 12:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oyTdh4un
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795695977;
	b=NXeD5cLzVC9x7KukaCf2lbrgkrfs41saVrlwV47SztzDJMSkc+jaf487AbrhucqkaHkM
	 Du3jgr055kw9sENzDBKqNlXWMlaW1Rqk10m9rnP7y0bu66ewDwmv+O02lmWQAd79Cc7p1
	 33almJcFGAPZkkrRi9V2QD/sZQRxaSifdsisy9yMDvuJoy80lYwt0G5pVHXiHrAFbvgTP
	 l4OfOQpJIiic61o3sqTET6v9dqvH7Q4x4SKRFWCIXFtlAI7MVQufBrH1hhgfH/OPTApQH
	 OPlnr9F/s/c16LWAoMkiC0iDx1yXmd5fdRziLKzWoXhl3a3vmFQN3je67pES003gOZA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795695977;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=dvBrYsAGcqJ41oSp5NwAWPx5YIqYqwYWsABcr2HoDL0=;
	b=CLAXMBLFw9nrcEW2KPCl3p1wqR3BItwow2Bj9lEVZDRVRxc3F2tfTS8DR00kDCHPVLYd
	 V62ruZwR/yDyZfe1kjbZGVFM0u0Sw9eKhAGSeUvP/t7z9imBi8Heo+gHbkCqMZOBm405K
	 /zn+Xb0GHySrLWN7Mg2vUN8eUBSXzwGxgUeKJHEn+3F91mgmBilE+BagMUA6Nm3czxwUB
	 RM31oTvJBoh4s/UdJxv3pirMUkV1hxi8i/7yrAfugucdzJ4Viyk1tD/qlajb3ikXNACKU
	 B0knDOv148k1Y9J8UX8zO5MdAx/ne2cM7E6f+ozcZQLBEt+CX5EV0KhxSVM3VsewwRg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 726071F000CA;
	Thu, 26 Nov 2026 12:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795695977;
	bh=dvBrYsAGcqJ41oSp5NwAWPx5YIqYqwYWsABcr2HoDL0=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=oyTdh4un3yBIF7v59UDBTfdQgbY5Zw1ZnahqLGZ0d5V9E01jb+eIy6VpJXIexjzZt
	 0Cdnm63q64qwGhhkIsQcdRPZofHUIkPF9QLZFIeeXA79VLHqewda1sLZ6h1Y+AlEnp
	 w0RKe/u2QMMAt8bTSdqMh72mLlCv759xGiK5NpH8yUBLhDJg75BpEq3i0Vk77AKfxG
	 QNovTx/MalKN1M+9hjPi3gS8fSVA5EZ6t+ndPOzVvF8QnhxKOFSza0Iy7pTR0OAf1V
	 JzTxdcNvMQnhBOGCbkfVU7E+TA8lkAuN0dcfJAlQEx0xswUpnKUpWI9at0bG9f2ZTA
	 w6GkSsl+MvWBA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id F303F4D406;
	Thu, 26 Nov 2026 12:26:15 +0000 (UTC)
From: Dickson Wu via B4 Relay <devnull+dickson.wu.certik.com@kernel.org>
Date: Thu, 26 Nov 2026 12:24:11 +0000
Subject: [PATCH 6.6.y] wifi: mt76: mt7915: clear wcid mask under mutex
 after RCU pointer clear
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-so1-mt-66-v1-1-429a17b69783@certik.com>
X-B4-Tracking: v=1; b=H4sIAOokCGsC/z2MQQ7CIBAAv9Ls2a2CcaN+xXgAuliMQsOi0TT9u
 6CJx5lMZgbhHFjg2M2Q+RkkpFhBrTpwo4kXxjBUBr3RpJQmlKTwXpAIjdodvN17q2gLtZ8y+/D
 6vk5APfVvOP+0POyVXWmfFlojjDab6MamhONQUrph8+v/H5blA4kzXGmeAAAA
X-Change-ID: 20261126-so1-mt-66-a159fb8fb163
To: stable@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 linux-wireless@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795695850; l=2795;
 i=dickson.wu@certik.com; s=dickson-b4; h=from:subject:message-id;
 bh=2Yvt6AJuNvts0+ANo6CU0QtnmDtVLXdldOC/Am3e2gA=;
 b=w+O49ZjIy9egfIJbvByoykDXAcgK+TPmDWIgXps9KXkT+HQlgsgluVsBhtUMsjgUuGRE14I11
 s3n5Sy3qv3eApIubLJz/OVseZUi3g8Z6+GuM348Hf//IpAMb0gzWPZ2
X-Developer-Key: i=dickson.wu@certik.com; a=ed25519;
 pk=fxH7FS4FdojeJSGLJzgKdfO51Rvr4EW30yinj2mc1vg=
X-Endpoint-Received: by B4 Relay for dickson.wu@certik.com/dickson-b4 with
 auth_id=1647
X-Original-From: Dickson Wu <dickson.wu@certik.com>
Reply-To: dickson.wu@certik.com

From: Felix Fietkau <nbd@nbd.name>

commit 6486e11a6e2f679597af2d5bb48c3b07a2b2a7ba upstream.

mt7915_remove_interface() cleared the wcid mask bit with no lock held and
before clearing the RCU wcid pointer. The mask is a non-atomic RMW shared
with the allocators, which all run under dev->mt76.mutex; on DBDC the two
wiphys share one mt76_dev, so this raced add_interface/sta_add on the
other band and could leak or double-hand-out a wcid. Clearing the bit
before the RCU pointer also let a concurrent allocation reuse the index
and publish its wcid, which the subsequent NULL assignment then wiped.
Move the clear into the existing mutex section, after the RCU pointer is
cleared.

Fixes: f3049b88b2b3 ("wifi: mt76: mt7915: allocate vif wcid in the same range as stations")
Link: https://patch.msgid.link/20260722082610.2699628-8-nbd@nbd.name
Signed-off-by: Felix Fietkau <nbd@nbd.name>
[ adapted to 6.6.y: context only, older mt7915_mcu_add_sta() call ]
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---
6.12.y and newer already have this fix. The moved line is the same as
upstream; only the surrounding context differs on this branch.

Tested on v6.6.163:
- x86_64 allmodconfig W=1 build of
  drivers/net/wireless/mediatek/mt76/mt7915/main.o, base vs patched,
  no new warnings
- booted the patched kernel with CONFIG_MT7915E=y under QEMU/KVM. I
  don't have mt7915 hardware, so the remove path wasn't run.

The backport and the test runs were prepared with AI coding tools
(OpenAI Codex agents, with review by Claude). I went over the result
before signing off.
---
 drivers/net/wireless/mediatek/mt76/mt7915/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 864f636666e5..017181c1a2ea 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -306,7 +306,6 @@ static void mt7915_remove_interface(struct ieee80211_hw *hw,
 
 	mt7915_mcu_add_bss_info(phy, vif, false);
 	mt7915_mcu_add_sta(dev, vif, NULL, false);
-	mt76_wcid_mask_clear(dev->mt76.wcid_mask, mvif->sta.wcid.idx);
 
 	mutex_lock(&dev->mt76.mutex);
 	mt76_testmode_reset(phy->mt76, true);
@@ -322,6 +321,7 @@ static void mt7915_remove_interface(struct ieee80211_hw *hw,
 	mutex_lock(&dev->mt76.mutex);
 	dev->mt76.vif_mask &= ~BIT_ULL(mvif->mt76.idx);
 	phy->omac_mask &= ~BIT_ULL(mvif->mt76.omac_idx);
+	mt76_wcid_mask_clear(dev->mt76.wcid_mask, mvif->sta.wcid.idx);
 	mutex_unlock(&dev->mt76.mutex);
 
 	spin_lock_bh(&dev->mt76.sta_poll_lock);

---
base-commit: e2bb30811e063ce0db964484357973b855b06572
change-id: 20261126-so1-mt-66-a159fb8fb163

Best regards,
--  
Dickson Wu <dickson.wu@certik.com>


