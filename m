Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196EE3FE363
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 11:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787657193; cv=none; b=GnbvMMbD7zqoyjJKB2JIeVfHfXJYDIjsTdO+AMUTIkYt8IVZHx3BakVMqC3tcSaFk6MzYedt5D/opiMz5PaqjpFby7dhcI1ERWRvC7blNo3tmPb0feKaif+M4QouMel+tjezb8ihfvLhBcSqhUXvPo/4HwHnepyRIFJ5rj7zklU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787657193; c=relaxed/simple;
	bh=Yg6bRBKQjliUp7NCfg2G5T4E08vAklJuXs4oqUp1Sg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rTyioec2/N9y5dvXHnWWYWCOTncR2zOqxJ2a3WfKX84Yp3Ay8aw3z/sh9ZAkKbIolwAAjM3L3dEREPWJjMDjIzBS8Z3kCjSrnEfXKFlYFakWJQQ7lJGfCp0K2VO+WhcLG3XFcZ86jIZIhQw2u1jfUcjSI8v/88DAfpQ1peXHf/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqFhzk6s; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqFhzk6s"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so3643782a91.0
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 04:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787657191; x=1788261991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n+tRyTnlpLmJp3+Wgs2dMuwtgQimEwJVqYrZ9xUm0L0=;
        b=fqFhzk6sTXchbLc0RTkZ5k5oe4HYTq0X8FZiDkFBD4uEfgAM4rg6ls9Wn3q5RQ2KcJ
         slLu0R/iFTsNnilB2NZ3Gpem7BsWShFqLwWdGsWG6fy8cZafhIw+t1QXqNSszMSy5+0x
         PL+CzYJWCLZlFGXtt9bPsesUBZhENGfi7ahRpZgL4oSV12Z4M+R60ND2CejKbBbASerN
         94Gs+H6pijUXbhLegIyrqSXTw6gB3pnadH723gtbTMrvJsp/gsiT7cN1iXm9j2wPpFWL
         H9JsJ82Aomlq1/x4FBYrkAQhdy5vcszheumQ60pVpvMQyXqVqHMYCs5jhgmYdPv3h6GK
         ARAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787657191; x=1788261991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=n+tRyTnlpLmJp3+Wgs2dMuwtgQimEwJVqYrZ9xUm0L0=;
        b=cZQPRYKxdYzn7x49Af4Mm4O+MEs8x8H4roZWpvMLpvlQSRDfUEJwv8VI1y371Kt+2O
         sOlMdtaMkhThQ9PVOVCvOIKn70ipWB9ehLUieA+tX45ZEAs/7aH080z2oiT5upTrEsNO
         nS+ya2K8ymohkKSoC0JNr2iHmjncoYURGaSLwcI33OvOb0QyHw3KpEX5joCWOMc2kmr2
         eGeFL/RF2KRmZDJ6x6Nj59nPypZBZuiPCBkVJgAjlCrTn71ULxEXQdO2yQo+RWmQgmTs
         BlLVjXxmO+8819x2Fm9GZbXg9qEFSNfm2pXcdF94BfbYUzCQ+DCGMpOzDawld9ZVW9WU
         4tXQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro2IMuSvqyE1adALv9lTKWHoiUDcYVRU08/2/HFNs/KDWcefP2XYU2+rY72m2lTs4EuV6JKVj4=@vger.kernel.org
X-Gm-Message-State: AFuF++loWJ44PcO8zsvfdlEP5wEU9MQ7ZVL9qhoNOorpNrqhSiVVTCkN
	LPxCgXVVHdKv0hI4Agm2owg8LT86T7qAPOQtzOuDKFJ1NxTkDth+Uupc
X-Gm-Gg: AR+sD10F79EDk6wtCjBo1xCuT1eOxzPdZ5EGZPgl5QPoeBBUFaGuaUZmt/gD3eEwHjR
	E3KZg5kScp642WZ+mMiN5RL80663tWDVAVrb26Q4yJPdOL7RgwBsMXAHc0MywTf9lNAKkhiN6if
	itki6C0K4Io4F4eifyA3tj5BT76Mx3eBEBoKivFFyG5VO/JvkD5BXPb6Is/e2iDvS14pFKGAyrg
	EhQeqGd1otkTDTbwO0nna1hzkQPdL08zP+uJAO+XxSs/3HTTi1K8SbdLTrh5QRCTedwmG+VQxY3
	2sFK0Ed/vtpUvbZN+nV1PA6lN/35q/LbErgGJwfZq8zcXRXpy0gz7Nchhr3k5MbReCfPr7U+WEd
	+/NelbmRXI9o1EQI1OnyxStGbCDND8hviOnJD47Ylw4ESTqtB4bS5/leTYBKDMm2PlBOtETM4SV
	pcdporukDTS0eb05Kp6H2X8Bx7PaVJDzZIq/TKzHliNUp8649FPt+LxxyJzZqs+44PP2QkwgvHI
	Pe/B7JjgbQluFu7WlEsKXfw+NI=
X-Received: by 2002:a17:90b:2ecb:b0:381:1f51:1ff0 with SMTP id 98e67ed59e1d1-396462b886dmr13579385a91.2.1787657191098;
        Tue, 25 Aug 2026 04:26:31 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([203.208.189.10])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f909a51fsm32952386eec.4.2026.08.25.04.26.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Aug 2026 04:26:30 -0700 (PDT)
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
	Evelyn Tsai <evelyn.tsai@mediatek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH v2] wifi: mt76: mt7996: unlink TWT flow if the MCU rejects the agreement
Date: Tue, 25 Aug 2026 19:26:20 +0800
Message-ID: <20260825112620.97568-1-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260729173632.14387-3-enderaoelyther@gmail.com>
References: <20260729173632.14387-1-enderaoelyther@gmail.com> <20260729173632.14387-3-enderaoelyther@gmail.com>
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
dev->twt_list. If the station disassociates instead, teardown skips the
flow and station storage can be freed while the node remains linked. A
later scheduling or debugfs twt_stats walk can then dereference the
freed flow, resulting in a use-after-free.

Unlink the flow when the MCU rejects the agreement. This restores the
list to its pre-request state while leaving the unchanged mask and
agreement accounting untouched.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20260729173632.14387-3-enderaoelyther@gmail.com/
Assisted-by: Codex:gpt-5.6-sol
Assisted-by: Kimi:K3
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
Changes in v2:
- Rebase onto wireless/main commit 2812e64e1575.
- Send mt7996 as a standalone patch; mt7915 is fixed by commit
  16a04441eab0 ("wifi: mt76: mt7915: unlink TWT flow if the MCU rejects
  the agreement").
- Use list_del() to match the accepted mt7915 fix.
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 0eebc8182ca9..4d3829e4220d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -3207,8 +3207,10 @@ void mt7996_mac_add_twt_setup(struct ieee80211_hw *hw,
 	flow->tsf = le64_to_cpu(twt_agrt->twt);
 
 	if (mt7996_mcu_twt_agrt_update(dev, &msta->vif->deflink, flow,
-				       MCU_TWT_AGRT_ADD))
+				       MCU_TWT_AGRT_ADD)) {
+		list_del(&flow->list);
 		goto unlock;
+	}
 
 	setup_cmd = TWT_SETUP_CMD_ACCEPT;
 	dev->twt.table_mask |= BIT(table_id);
-- 
2.50.1 (Apple Git-155)
