Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1F0380FD8
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 17:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785346615; cv=none; b=SLSDAA23DpWE/qmqkmJgRLGf/oASjArAsvtcjwMkivCw+pKiaxRGzcZhkn2cevp04Gmk8P2wCEZ2t9+Am2VrrV4WmorgjjLDwcHp/lInlW7saxptpDPp4RPnpTApv+e3hmoaiifq1Lb9tJQOD+kXyR+L66d4cSHVjggOjbrztWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785346615; c=relaxed/simple;
	bh=uf/XwxYZfY9BgYrEGqyb31ycLivbYD9kLuKe/0q9hTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ec0MNSq6Id+jxuhgLfLOlYe2ZPHGrzI3AZRMFaMTxegdysXkSV1f5koQWSUuJ7PqB1b2HmqTaR0PrFS42NeMgOwWtjmJE3/1wxjMyk10JHphdAYqnC60HZ5fFq3Q/muHrKQIMPoShefvZJzFBprm1ioAkEO4sM3XBhVI0+eu1p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EkDxQocP; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkDxQocP"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cca0c5799eso13112535ad.0
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 10:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785346612; x=1785951412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O4KRrR5InAG6qbH+2o0ICn/FfbIaKM6RpEitfK9J2zk=;
        b=EkDxQocPAjLEGGXLBylwYw7OYPw4QE/p4DU5o9UHe+Lg/XTre4EsAvgRkcd4zrZmhU
         f3CMkPrftkTAhlGZEZ8TBRgyeKhJMP8w9XXllXwXsMU690EcoEYjLyT7ZT+7JLxi7zVI
         77jpMn3JPq7l9XhF2c0KUtW67qjfyhBkAd/wcR9CAeBekC8BCZtPeriJpoR04ETCaA7y
         Uo/Mks6Xpv9ymBrAAjAZ3jufFv6yzgRgz+Giq6R/DHWQzO/9/PW5XV0umk6qzdPF7gCw
         FPbS0w/WX9YHhq4mtlZUETFLTqkrndCrVsIw0ZvgtQTe7a8HjmxBd4OYW0yqBR2Ndts8
         eBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785346612; x=1785951412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=O4KRrR5InAG6qbH+2o0ICn/FfbIaKM6RpEitfK9J2zk=;
        b=h52w2OL4BzmjTvACBVd/jxoQ1jWwpAeZ//7XnfLGFNAgzaHIcQz9QDSTYj5EtJrXZU
         3pF8ty1v/Fu/OV7QckcN8HMSD4Om12zGk1lakO+pY2oUFbuTX5eGX06v22FMtgJg/+rd
         KV1gDTCQaOIvuZw2wCQYOqskXmHf6yDhyQsEGZOjuUuArWi70nHUIAJq3Lh0fNwjWwGV
         u//S8m398UVzkKaPCwJhyKJzqqEdMnMp88xCuJNcqk0IPYJDObPs3Z572y0JPxO6j7I1
         to4iOghNJHaBi9rCpPOV3NbLItmsq6XW+jSxAthhZKnnBtgQXkL0Buyg0QOWaNpnxaR0
         TJ2A==
X-Forwarded-Encrypted: i=1; AHgh+RpCrPAicfOtDRWI2AXP0dVbQ64SrKitNM4ePJCvA9ej4v6uyaLrg28ypBX4rpCwP46dMvXUa9c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy2vHJsI41LYI0sS9wXYvZpKR7YVbtYBZGi/IG+5UcUDqwpBMg
	qaEBChA2sNoKteW5awDWfoqZHWbNB13VXGFqfvC0bKW1Nup+uHRaFrYv
X-Gm-Gg: AR+sD11tu1i2hKAftz23G55ZYMm4V6XQVGb0N05S3IPb9HAO5Z5fJjqw55rkug64clT
	CTFsPAG4MzNao8Dxc/TF2gWUujaHYo0x98hsWpI+K4OtEikQ1e5O3J74XZYeNAq3clZp8Z3mK0D
	QyXHpJCSAQGp5c52N2+3tYAP8OtAEAExYRfL0QQsewsdHb6CuaXNCDA7Jeu52xBdXDvSqoUyh67
	RisvEZGzkulKryjZLo8PkQwlQFe7YrGWSalFnofVchGoZGJ5RS6zKYpbdkkKeK0yLlbYlTkkGY3
	sl/TL1ImnXbYZ0jxn6sjh8DCRAsKGjGc4r3CwvO3lF8y7AuAbjuqKjcmLDUURL/esIYpIjU3lkd
	ZVI4hlJl2eaSBSVwi5nDSlIyHMjJ8V7vbKged8Vs3fRIY38168bfvmE1VeHlVVKtXagT5SqBERT
	prqag7jKbVSCfZdgHwZ0qXWrkxRGcCoxMPDffoQwy1V5iWa8xZ2XqAu6pCIEtA2AW8ibkKVi8VR
	w3I8YrWcMn36vCdpv9z8ZicVgyv1EK/uwrExA==
X-Received: by 2002:a17:902:d2c9:b0:2ca:cde5:29c4 with SMTP id d9443c01a7336-2d015db90afmr81414495ad.47.1785346612435;
        Wed, 29 Jul 2026 10:36:52 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([120.234.91.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022bf39cdsm14806045ad.55.2026.07.29.10.36.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Jul 2026 10:36:52 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>
Cc: Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rex Lu <rex.lu@mediatek.com>,
	Peter Chiu <chui-hao.chiu@mediatek.com>,
	Chad Monroe <chad@monroe.io>,
	Howard Hsu <howard-yh.hsu@mediatek.com>,
	StanleyYP Wang <StanleyYP.Wang@mediatek.com>,
	MeiChia Chiu <meichia.chiu@mediatek.com>,
	Bo Jiao <Bo.Jiao@mediatek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] wifi: mt76: mt7996: unlink TWT flow on MCU add failure
Date: Thu, 30 Jul 2026 01:36:32 +0800
Message-ID: <20260729173632.14387-3-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260729173632.14387-1-enderaoelyther@gmail.com>
References: <20260729173632.14387-1-enderaoelyther@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mt7996_mac_add_twt_setup() links a new flow into dev->twt_list before
asking the MCU to add the agreement, but exits without unlinking the flow
if the request fails. The flow-ID and table masks are only committed
after MCU success, so the still-linked flow is invisible to the
mask-gated teardown paths.

If the station retries the setup, the same slot is cleared and its
embedded list node reinitialized while it is still linked, corrupting
dev->twt_list and potentially preventing a scheduling walk from
terminating. If the station disassociates instead, teardown skips the
flow and station storage can be freed while the node remains linked. A
later scheduling or debugfs twt_stats walk can then dereference the
freed flow, resulting in a use-after-free.

Unlink the flow with list_del_init() on the MCU ADD failure path. This
restores the list to its pre-request state and leaves the node safe for a
retry. Mask and agreement accounting remain untouched because none of
it was committed before the failure.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Assisted-by: Codex:gpt-5.6-sol
Assisted-by: Kimi:K3
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 0eebc8182ca9..445bd7d63cc8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -3207,8 +3207,10 @@ void mt7996_mac_add_twt_setup(struct ieee80211_hw *hw,
 	flow->tsf = le64_to_cpu(twt_agrt->twt);
 
 	if (mt7996_mcu_twt_agrt_update(dev, &msta->vif->deflink, flow,
-				       MCU_TWT_AGRT_ADD))
+				       MCU_TWT_AGRT_ADD)) {
+		list_del_init(&flow->list);
 		goto unlock;
+	}
 
 	setup_cmd = TWT_SETUP_CMD_ACCEPT;
 	dev->twt.table_mask |= BIT(table_id);
-- 
2.50.1 (Apple Git-155)

