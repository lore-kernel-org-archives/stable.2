Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFB0386C13
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 07:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785481929; cv=none; b=CNRfvr1hx7YJu02BlKgCF66TVq8KGs0UEnq+LFI7J0frIiwfPrNBiz6qxEAmkGBYXDBDeWznyYkVIWp4h+AXVG+Vw2Scir+Dq14HFeIoPeOWUrKI4tvxO+HddhIiT//IyLZWVUbZ7yJNM04GLmbdVPAgHL+StTC8GAs0FKKBNMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785481929; c=relaxed/simple;
	bh=zQi9ubKcOArEPKQUo2BWV5Pccb8fFbLU0DSqAsWQMb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WXSqjFArSeKFbo8a6gw6HUY+KgKvFcSbNJxLFiWOHURWQTkgHQa7aNPsFQrGoLZ7ms22xBQ2oho7jdGanREDu+WUXnovl5KdIk9XQV8APJYOrz827KnnajO9mZH3YoVPttY8aYkxhcmH2C7D1SrPKVSiyUPTcGff5s5r8zeeMlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EalirIWE; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EalirIWE"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d02b4c3601so7090105ad.3
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 00:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785481919; x=1786086719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=p/zSUWBhbluccRh5Y+3PaEaBGuhqo6tGCiQ6G7WtFxk=;
        b=EalirIWEPJ09Cebu3MNRI8bkiwl2XsvrhhhX4vePKd2+6FLrOX3aTMQX3jVLuRjvgk
         BcX4ai9Z2wnmmlKmD/M27Xg3LYgXd+O+ZF+/W8DaJOo0TIKB1fAmmfM/9CcvVrJl2TA3
         RB+nEGbS+I77Aa0tvHAgdJktARzCN+MAzSQ4Dc3mIwQYMSbvCw8oqEh2SeY3YiwUmkRJ
         XmnWWrLkUA8zAyqGZEiFYclpg3y9Xb92EV56kQva/b6fUyR/mJcXfjFaKVpAe63MkijH
         ALkC7knYR4gavBnazUG3eQQryYTJJGZQKWmaPvjl+U+oipmfvCaBEiIwRfYaukcDS4zE
         No7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785481919; x=1786086719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p/zSUWBhbluccRh5Y+3PaEaBGuhqo6tGCiQ6G7WtFxk=;
        b=IBaYEUUbuPACSJWFxBeV+FW+39EwlVJqbfuw19Dsv4WBdFSvHPmGEeezIlbk302MUR
         XSExadlw6MFi3DzF5HZrXFM6+Dteoo07Ss7iACjA1WrpmAcQBdLl4UwJQfbuwTYLdQb4
         fuKfnzF7NfmsZdgKCC1m8qYfvMA2ZKiPx/pUa2oN+y71Jd95b76s/eJg98pc8Lk059py
         gRzmtmpSm+GeWAmu6qwaQ8UOLgcD5OK8z/KtkOtuPQOM42LPvCCbUMlUv5LcliGj1WkW
         WTdEUtg7EnNtwuOA1ZC5nTjXZjrYxvU754wr6D4WFH/86HdXsJR+nfvymSq9fe1tkOFn
         LsHA==
X-Forwarded-Encrypted: i=1; AHgh+RrvHVBVkIbr0G+u0bXEJmxHVZr/y02qu7L3QhYhxAz31/uIPRM2FdHmlVCzv50iy5AdrHt1p5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtseBA7sSCsBEijnU31lvCD8n2oT3E3Gw5sIgGX0B/L3IzP/XI
	u0AOgG7b7bWLD8HOCJ1n6ggWXc0fxk8v/fcrhlkUqWvqpfN7vDwGic7z
X-Gm-Gg: AR+sD11C93wRBi06t5urg8tsmlDu7qJwNw15otCY7R43+BF0M6s75K53frSZWP+doak
	PG2q1dDt1zcWJ6yguLBVsnJjJaezZq1N7uMa0wUhibHbnjbcL8uYrHbt/3KW/1jOC5zJmFckTRf
	9n6nbahD8O7Xi0D85obAK1/0lE/+jKEjfpieccoqvGGcnks15W+9LMj0e8GTNwId104kqOuIGt3
	Q7dewi90yXHQrT+kY5WUzV5EHELterbBYD9hraCQRoC8nE0wPbcgL4g6hoTyD+jePkdgf0XdXEX
	HqfiX1L552EXBB3XbFs9a+2qgPAvNM1PvpdrjViRVrGB9MODDgt76h4eKnImkdbx2U63bsZbjLP
	FFcRBQGQXQAA82H9qbYnDWReK2/xowTfT95bzQQG9R9LWzSyEgBq3lT9BBXrqfPhCw0GX/EY2y4
	JPcaGYXYINmilw7RsMuBAMWyotpMr3AYYvc2UKWwogghB5xSR4dxM0i50W26bgd3DNfdT1eSPbA
	BaUAR3il/uC96O35apH//baVWo=
X-Received: by 2002:a05:6a20:4308:b0:3c3:a1ed:3c36 with SMTP id adf61e73a8af0-3c91b266a96mr892351637.24.1785481918740;
        Fri, 31 Jul 2026 00:11:58 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([203.208.189.11])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd4f0f0sm2308226eec.2.2026.07.31.00.11.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 31 Jul 2026 00:11:58 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>
Cc: Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	JB Tsai <jb.tsai@mediatek.com>,
	Leon Yen <leon.yen@mediatek.com>,
	Quan Zhou <quan.zhou@mediatek.com>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	Deren Wu <deren.wu@mediatek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH] wifi: mt76: mt7921: validate CLC indices
Date: Fri, 31 Jul 2026 15:11:48 +0800
Message-ID: <20260731071148.74484-1-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mt7921_load_clc() indexes phy->clc[] with the index stored in each CLC
record from the firmware image, but does not validate that index before
its first array access.

The equivalent mt7925 parser added the same validation for a potential
array-index out-of-bounds issue and later corrected the comparison from
> to >=. mt7921 never received either change; see the linked commits.

A malformed CLC region can therefore read or write past phy->clc[] while
the driver is starting.

Stop parsing the CLC region when a record has an out-of-range index,
matching the corrected mt7925 parser.

Fixes: 23bdc5d8cadf ("wifi: mt76: mt7921: introduce Country Location Control support")
Link: https://git.kernel.org/linus/9679ca7326e52282cc923c4d71d81c999cb6cd55
Link: https://git.kernel.org/linus/08fa656c91fd5fdf47ba393795b9c0d1e97539ed
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 25b9437250f7..1c99645b8122 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -467,6 +467,9 @@ static int mt7921_load_clc(struct mt792x_dev *dev, const char *fw_name)
 	for (offset = 0; offset < len; offset += le32_to_cpu(clc->len)) {
 		clc = (const struct mt7921_clc *)(clc_base + offset);
 
+		if (clc->idx >= ARRAY_SIZE(phy->clc))
+			break;
+
 		/* do not init buf again if chip reset triggered */
 		if (phy->clc[clc->idx])
 			continue;

base-commit: 4a0bd262df757b25fc4e2a53c947317c119ced4e
-- 
2.50.1 (Apple Git-155)

