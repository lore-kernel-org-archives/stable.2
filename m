Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCB6386C17
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 11:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783943678; cv=none; b=vCAzuqzfUbDfPBKXhsQxSEZvsZdx7VG6rgsyoWoUUWZWRyTILlSTxQZruF+ZBMW0Pggai+wHPX3gwO4qLdsRFzLvChABPy4saYj4Yxo6DvxvixWdTEJZLaSsNHlYqfmKwU3JXuteX9uErdts0Q7faSfoWM1ORIEo0VbNWRkwLvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783943678; c=relaxed/simple;
	bh=Xx8GPJ2nKgjX8oK3ouIjFUvUPuGPoItp/jdx3bi/nvc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QPaVkAFe5uZ+oOnPzJkuRw2dKLItLDGLaDPtn8AV/JAF+vRBdsIcfWyLAjx4w0SIWfTk6TSY9xW5bDh8wFj6ZRxh7lJ8M9p/ihkfq0Bs0BwHI2V4BxfrF6SGCsD9iJuu+Z/bjnmKGFCC1wo0PA5qW3dCEdt7OcGLwFyeTV0QPhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sFZoJpE6; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sFZoJpE6"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so521735a91.0
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 04:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783943676; x=1784548476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=x2fdTEqbfX9vvZ1ZNoboKP4zdBzByVQgUUXRVPv19eQ=;
        b=sFZoJpE6GGZUlfgUYueAoOD30HUb3qrDwrSGB8X6qXzdHwJX3rhphxni3Yx/niZlGt
         Oa5dJIwqxIeVwTedgYUoHJ+vD31ncffzHTTtrZQMlr8LMKQrfUQ3NJOZy9HgcbhlNO0V
         4ud+XF+Pf1/NUzFINSou5dEsrdahtojMQHQs3JBonRvD1TZcNszRyfbLGiLXSWW345q4
         1cetZnLfu4v2dgj6hQM8gxj0dROL8Eu5zqxiv2DbY8H2iMkloTOYJ7ZSNPgUtS+nM4t0
         9FXt/POZnzbV5ZJ9Y1jg8o09prBjSI/PNWorsISJyWIxD1FfniAZFE9H4GLrub3ScmWE
         UBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783943676; x=1784548476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x2fdTEqbfX9vvZ1ZNoboKP4zdBzByVQgUUXRVPv19eQ=;
        b=NEAKTpHomMjS1WanCkAiFxSNk6/Z1f9EZlqK4lK8gYjwRHdXMFZgT+QqqJmmFW+NOk
         RGwoOX6riYieVGxm05SgDIzSF7JkTRJlTqp1DwsgkZJ5eO7ZP2E4HVUoEPhJl8FfG1EK
         1XPc4eBpe7HGr1NH9xigDdKvIJjOhefCpU+6w97kjq0eIyk5UVsV8g/7zsNxS0NJq/A2
         EXV+WNPv/ZQqW5Py7940/IcW+H6VbxGnZvQRoyVRHK4EDpWzjBtlyDuDQgzkQtuuZOHE
         VI5Cz04hj/i/SuAGBFTvY3ubJLt7R8wswNacDi0Uyplp/CLgA/RH95Hg6rSvSohmdz1I
         R5tw==
X-Forwarded-Encrypted: i=1; AHgh+RofgUwWsMcSS/HZc/IP/I6dReUKx4wjRjEQelPzvaAEdkoOMNplFtOieqySL3S8KKJJvwBNSWA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7TEmJE5BpyCGr/SQFDC6SgnHEQTV5itursKUKzgRt1MUkUEyM
	k5a/lJ8QCB5/HkT5psnftzIJ3A34twYHMu9obUQlU2cbfKbqGZF81EZL
X-Gm-Gg: AfdE7cn9T30hwauQZqwM3AVUNtCBTVIR+xw3Wvp/6/lk0RA1t5X6IK81RGQt9gvCqIC
	ONCJt4Tx5aXTx9bxifI6cudZW0lAopLzFjhfjQ+7kDppURCT/xlusWLZhrbnAgRJtPJTegIn+EQ
	U7Grb/ABNO72lDtxqcWcEDg9JTL5eT5YWtgZL7l2jd2D1P5jtJnWlCJqJbTEfOvgZwuO83wxmiA
	BHrmX3AY93tsHMSUpTAINrgXWzVMEgcRBScgTFFc0pjuae10FJxfzUOvEOPP9pribWYZWYTIndj
	xz0HKw0jMWZQ8GO4LKGUcQh4ngPivcDbN8g8uEiFHBPujWShq3uFHiibvwZ4kjeCTTOrQX4iqJw
	1/CgL+CF63eHS/yCUNhZ3PH+6FDjqLBiMvLKIE76JfpJBtoNGaQILZ4hqOg/UAEbGi8F9zSTaTn
	FyTkkn9a72/WrVabbIsAX5ZazMMZreK8jovchpChz1UBmwuu7LJhD2mFQ3e3iujQW6HoGHYiaOG
	lzm793OAK9wxQ5V9d4W8uzIxdZVv+CpTA==
X-Received: by 2002:a17:90b:3943:b0:37f:9ce1:735a with SMTP id 98e67ed59e1d1-38dc7777c02mr9454667a91.27.1783943676460;
        Mon, 13 Jul 2026 04:54:36 -0700 (PDT)
Received: from localhost.localdomain ([101.251.7.10])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3118ee6080dsm51773930eec.17.2026.07.13.04.54.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jul 2026 04:54:36 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com
Cc: linux-wireless@vger.kernel.org,
	stable@vger.kernel.org,
	Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Subject: [PATCH] wifi: mt76: mt7996: validate default EEPROM firmware size
Date: Mon, 13 Jul 2026 17:39:12 +0545
Message-ID: <20260713115412.67095-1-acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The default EEPROM firmware is parsed and copied as a full EEPROM
without checking its length. A truncated file can make the driver
read beyond the firmware buffer during variant validation or the
fallback copy.

Reject files shorter than MT7996_EEPROM_SIZE before parsing or
copying the firmware.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")

Cc: stable@vger.kernel.org
Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
index ac05f7d75d63..ec33521db564 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
@@ -150,6 +150,12 @@ mt7996_eeprom_check_or_use_default(struct mt7996_dev *dev, bool use_default)
 		goto out;
 	}
 
+	if (fw->size < MT7996_EEPROM_SIZE) {
+		dev_err(dev->mt76.dev, "Invalid default bin size\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
 	if (!use_default && mt7996_eeprom_variant_valid(dev, fw->data))
 		goto out;
 
-- 
2.51.2

