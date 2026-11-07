Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046163;
	b=Opd+swiaNCn+PxZzgLf5J3gw8Vr4SN8S1GsQzIUmjReNTnkSrJq342elqNLno8RajEV8
	 2xYVgLbcDBczrJChBmVUIl6ECQ7Ijasfg5IQJgiF31KrFZXsZqvTeB+PwEDJy7NDzQFRF
	 /WqD/wHMMiIy/Ty2WfegqsYR78klBDVRvu7mCMhZgHoqliE92jIcAChT9eIhij8ZQ8Hhd
	 Ug4UlbbisKLfuG6h17v3cAh6FeHYI2MebhHvbWa8Rdu/gzkALgwTzqg+XMkTfF1yCaF7u
	 ABryRoNI6qUVMfZbgnt3NVBpBIi3bOo+O/xgPJ/KOZZVYty0tHxpQl8gUf1TQ1JlHQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046163;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=23NQe1ca32mdDZl7ebn5BJi/YlZvQaMl6r3XrRBcPMk=;
	b=ylX3gFedN5hW0M3tNob7UMq3TxwffplbYUvZOOR2YQLRw+eyvjDA3/k5lbtjD8UbPrAm
	 AUBnbv1EqY7ETBKVqshFWtsdjPspjomzg01UrbJfTD13jVTKGJcZbJQ9bU8oAB+SZi3a1
	 7j0L1YdRiMqS6hIUxftyS9CVAhHdop7VCVhXB7EAWrq0ofaJ8nf8y4P2voYDMAZZ7hi+d
	 NU+4i3nOsmhH6mYQwlywV3XnaEKAdvO4tsoC/gFy4BQDkJFtv6sBr1shZvaUlLEaN+5hs
	 2HZ8Mu0yo23ai25oRtp/fCZAzGGHzKfEaKaaZgeY7z1+vMEUHBwKEF7kIO+AisT/YDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HZSgJN4O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E43606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HZSgJN4O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 584D91F0089F;
	Sat,  7 Nov 2026 10:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046162;
	bh=23NQe1ca32mdDZl7ebn5BJi/YlZvQaMl6r3XrRBcPMk=;
	h=From:To:Cc:Subject:Date;
	b=HZSgJN4OLT/k2+fkf5+GKs5QCPaTVFCebGb6o3QlbjmjYti17VD4V7joLY++TTOEW
	 +qUnrWYd+iAkFDhExeiNHQPJinj5PHn3mxGYqUA1GbCdqWmz0YVNaJGq1Kpu2dleqe
	 kMdJwhKvEgnbVlvA4y+ixbIo4opQQCu5cdjhVs0ITI6mAMuJYmBUuaduvrSRpvZA/u
	 0F0ds4YxN07hB2Csw3J8rxV0El9XFJv1rGa41FdSG/GDvt2l3Ox7tvntS0RbmJ0A20
	 BvT9Ies4Jgu4o41NXP0ULxHLgJSBPC061/RdQJPhTvj0vXMJWaLQvx2up33ZwrbHRs
	 dMMZ3R724QWpw==
From: Sasha Levin <sashal@kernel.org>
To: yicong@kylinos.cn,
	nbd@nbd.name
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] wifi: mt76: mt792x: fix negative errno truncation in offload capability" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:09:21 -0500
Message-ID: <20261107050921-failed-6.18-d0115096429c@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x d0115096429ca090a592770c7645f9553a839954
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050921-failed-6.18-d0115096429c@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From d0115096429ca090a592770c7645f9553a839954 Mon Sep 17 00:00:00 2001
From: Yi Cong <yicong@kylinos.cn>
Date: Mon, 24 Aug 2026 10:14:29 +0800
Subject: [PATCH] wifi: mt76: mt792x: fix negative errno truncation in offload
 capability

Returning a negative errno as u8 turned -ENOENT into 0xfe, wrongly
enabling CNM and NAN caps. Return int and default to no caps on error.

Fixes: e8a264ccd2de ("wifi: mt76: mt7921: move init shared code in mt792x-lib module")
Cc: stable@vger.kernel.org
Signed-off-by: Yi Cong <yicong@kylinos.cn>
Link: https://patch.msgid.link/20260824021429.43761-1-cong.yi@linux.dev
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt792x_core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index f56f03bfe3874..3ce6c6ceac81c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -858,7 +858,7 @@ int mt792x_init_wiphy(struct ieee80211_hw *hw)
 }
 EXPORT_SYMBOL_GPL(mt792x_init_wiphy);
 
-static u8
+static int
 mt792x_get_offload_capability(struct device *dev, const char *fw_wm)
 {
 	const struct mt76_connac2_fw_trailer *hdr;
@@ -927,13 +927,20 @@ mt792x_get_mac80211_ops(struct device *dev,
 			void *drv_data, u8 *fw_features)
 {
 	struct ieee80211_ops *ops;
+	int ret;
 
 	ops = devm_kmemdup(dev, mac80211_ops, sizeof(struct ieee80211_ops),
 			   GFP_KERNEL);
 	if (!ops)
 		return NULL;
 
-	*fw_features = mt792x_get_offload_capability(dev, drv_data);
+	ret = mt792x_get_offload_capability(dev, drv_data);
+	if (ret < 0) {
+		dev_warn(dev, "failed to read firmware offload caps: %d\n", ret);
+		*fw_features = 0;
+	} else {
+		*fw_features = ret;
+	}
 
 	if (mt792x_needs_cnm_runtime(drv_data))
 		*fw_features |= MT792x_FW_CAP_CNM;
-- 
2.53.0




