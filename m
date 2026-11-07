Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046809;
	b=kdNUuWPKtgEhG9Fhu96FupH5vIhcZR6PMvRCqLPbLuwFYLoxwVAzyE9WyqvU1ZNiXr4m
	 nojGd0P1uwGGCqAKI/hMOUnYPyOb/Yn3dSeehhYtry7vR0/7TCRFb8MCqe+L5ZjZt3baJ
	 PqnoElDbSyTYYeIOwNeBvMTQ40OWl6/wee2mTtJiG9T/Pi+ti1b86jtUoRcpoXIWD6Hu0
	 VSqhwZjYtQGyFumPT7Y+I+sz6GESe4UFrIgoM6Fc6jq99YtlKEYjIAzhE00Q9JBpp2kvl
	 ZjEYEM2sACAbahCZKML4U7CXgHzrF1ZBot2qW0fnjEzJfEwW2YaAAVLCPlPTMiY7THg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046809;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=9z03sd+7RIjTNb5+W9UVLbzxCNucBNO5hiL4jD279Sk=;
	b=O1FW+HEvgzuzp7S1ZTdwrd7OQSf0g6g6XfUHeVj4ZLoCezsv3lXvzzzZ/JdqmtNQEPUu
	 7NFMr11imyKEXqLSnt/EsugFSBaAfslifallxGwomMvzPqM/sspu90149Txb48AVY7jpQ
	 u3kfu+z8NkX9uPMfrK8YZaJQAImZklo+XEdTdNnEnReGBGqZG7BlCBb9zvgW7EUEBOw4w
	 TyBhk019YI3MObDx6Y9yLFbiYCDlXne1F0X3uCSgvkJc0AQTjF6GYBSIi8J8TDQwZK6i8
	 I3YrM+GYVxqJS294WUkg24gJ9x2e6TYSm4yM3Ig1uZE2tmAyvV9iW1gieFKKc6l2r/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CzGx0UGr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F13E606D81E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CzGx0UGr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923541F0089F;
	Sat,  7 Nov 2026 10:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046809;
	bh=9z03sd+7RIjTNb5+W9UVLbzxCNucBNO5hiL4jD279Sk=;
	h=From:To:Cc:Subject:Date;
	b=CzGx0UGrWTPFpl9WbuOY7JX9NOxviwqkoSDVZ7GST3yqjE4Nf+rpiyxp1VYTrYROx
	 FNVxofUM0xlXFxT2/m3dDZVtKA7NgrgW2Vy23EjsIzhSM1ZGLarMfYnHf851SqqAlm
	 Yn0J3RGFhjunhzvdJ+BPvXNBgKJPXPGH0OJMcWSeaXPrUX00+oNhc+BN9I2HmylD0c
	 HuFYULrwSRCYPd0hHfli3tWMkK8OCjlKlqY+Fi1nM0w3uAvGDC2XG6jjaVtnuNOzIq
	 Q9GGD89cbSwz3Y8kmTXEg6IkjqgtBtt5isn3JnATWPJdJ8IGMI1yZKyPXGW4H0cV12
	 FWZlCr+SWVT6Q==
From: Sasha Levin <sashal@kernel.org>
To: yicong@kylinos.cn,
	nbd@nbd.name
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] wifi: mt76: mt792x: fix negative errno truncation in offload capability" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:20:07 -0500
Message-ID: <20261107052007-failed-6.12-d0115096429c@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x d0115096429ca090a592770c7645f9553a839954
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052007-failed-6.12-d0115096429c@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




