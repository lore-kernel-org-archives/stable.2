Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047555;
	b=P+TZoqQy35ZGChKqPO/lS+PLBpVlDdyCd19PbtoH7GGwGmLO6xN6PNFmfBM3al6qADCT
	 j0sX4lQA20BqVlEfAsEe4wrUlXjecWDyuy2vhuS0wxcGqquH4gfEHJ4D5HBkzKRt++sKV
	 HW9J6sN9BRuY24gqNjkmKb5dUhypwlqmx1VcKQUSrJ7k1ibhQqP06iIAaBqfXn12SLBoy
	 mEl3SGsN1RgotxgZlMsUNDzSV8B6lgD8+vc3ZOAU6eEzdeEJ47arpKJjy9nhPJcRKU1Wb
	 KZZ3mv+4CPyR6DuebUEfotNaLQUPlB96XXecMD+Qs5JPWYzaY5/mH5xHkh8tA/lAceg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047555;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=QRiw9gjrxdWpSmrh0f//1d5Ncf54GZ6l3C9wtPSKol8=;
	b=PxU8BK/sHCOB6EiwUY0MB3S7zMtpqO7pr6nd+uXUba8jrEUWTkpXmwxr7xYQbDSayTMS
	 TzQziy4IM9KGh1jSPJOAJzNXhVCMj/5eNZ37Iu75kmbGkx0gdy24Dk834Q+EYm478L1BR
	 GjCz6Zh8a5tM1jGZh3JQkhDD9RwfkCxeN5mlpppoUAFmqchg2LezhdvLu5EViyDiXvBhZ
	 Bi9eJNZC0yptq3FjdntC4NcaDBYU43d8zMUf/XjL8S0Epcuojjh7Qzscc3XDUpxJK4QJD
	 KjZwybPcpdIOAUMV5QAkruoKQInLbGafgVudv97ivVtjHV1KkT2kEPYdQfwJcrsWrRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D4Nu96pM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7B6606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D4Nu96pM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC431F0089F;
	Sat,  7 Nov 2026 10:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047555;
	bh=QRiw9gjrxdWpSmrh0f//1d5Ncf54GZ6l3C9wtPSKol8=;
	h=From:To:Cc:Subject:Date;
	b=D4Nu96pMichEzIYnLuNxRvI4TYRb8My3tHxe16Ipm2KwMI1QeOURMhhTEOZIRcNu4
	 +1mvzCn4hntpLn8pPQusjIEc/sEH+tLTOVkLlhnfI7/+r+l3OByXXx9niS4BXpKulb
	 /361DGyNP8izHgycAR6KO8pj4cDYoMe3I6TYYTX55cJSrIpD4VPWdF1SBDl6qvuN3F
	 qIja+ZS/vY4MJKUpqMUpHbjpO39dJ1S0NnVZ0K4s3USrx7qaNpCKXR55+gdUepCZCf
	 mOrTVUqCFCSi5vkyZbl4BQBD+QSAZvSDcriecK1k1PZntYZxcdIPUlSKmSFsDG8Lqt
	 Qq5C9YG/ZwIKA==
From: Sasha Levin <sashal@kernel.org>
To: yicong@kylinos.cn,
	nbd@nbd.name
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] wifi: mt76: mt792x: fix negative errno truncation in offload capability" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:32:33 -0500
Message-ID: <20261107053233-failed-6.6-d0115096429c@kernel.org>
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
git cherry-pick -x d0115096429ca090a592770c7645f9553a839954
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053233-failed-6.6-d0115096429c@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




