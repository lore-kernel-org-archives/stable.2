Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1DF3D6664
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 05:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788499283; cv=none; b=ZsKeawma+F4LDNTMy1CdUTIqD5pOxaWJr0bgwA05ysY2kkhjrBNtljn2sMCnqz7h0Zjk6/HrGvOEPXhpq688T7DzVS/DB1xcB79CKK8RQGdXbpABY7sLL6Xnu5rJMVyPx6UvK2TwCQqILm/L3Gbjljm0zzG4exzSIPR8QHzyObQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788499283; c=relaxed/simple;
	bh=uxgnammUB7WAI7xn10qHknRdqAOK17Ws2n6LqT6TByk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZmhUfiPwkApBqRvP/PvMV071gVWIWxyT4f8ZH5SwaSqCJMmDGQTPNGkgq4zaWeVemQAlG0lpCw203PrpOzWvAUc57mtp5LVsMLUP14JV7Cp8kS7lHwef3wlKQZfPcO/HH+dgBf//E4+gR7A0KrCE8PULcpier3NMVB5RBgjv11Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qigZnFHy; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qigZnFHy"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3964e480f76so781685a91.1
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 22:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788499282; x=1789104082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qmj0W9o2Wdtg73j/k8mocyZjIfELT7Gf3Os/u4t6eHM=;
        b=qigZnFHyvV72p2y9vqj1A/2/hFi2Y2Lfe2KnS4OGjCe89dL1znksnmZWo2oKHs879w
         6TY5P+MxTCxtiW8CWUQpJFhPizRQ4ECx6fjWgFCAwtGcdhy4/odd3Q2HIT7Sk/jQMDhc
         dyCzxWxUucIvIwLZFiXiO9sQSY6rDJUh14ODF9uSgZmvvbcfyVQWh9vjGV7hF4GuwCEK
         qDa5crxFbteIvG3VX+g4WSUZthzWsRWD4CMfoectuZ/alnSy79e0+ufGgwN7XVLOesqL
         0cPh1aGDtYiQLc9v//IRGkRpdz+YIbSkWvKiKSAMQF8xzNp12+MsfrRRcuejp20PVDtZ
         +2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788499282; x=1789104082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qmj0W9o2Wdtg73j/k8mocyZjIfELT7Gf3Os/u4t6eHM=;
        b=kjExTNlY7o1b6HoM69SBk73LIerAOV/Wazf5rIT7ViC1Os5FEnXBqiMrgj/6R+4+vl
         WrqKLHcjrHVwxDDeIy1yXosGHLwIhHIG907fztoQPCjKg9IawOzYdtd37KKiWSL1wve0
         SNnJvJrhmH6dJd2VG/4RUU56FANr2db49eY3Bj/Xn4lH6m5lyp1LOEvfBhn+b3jCxvj3
         0l8nyLmX5EMiYHCcoCcgO5GiSAg6lgI3WoXunzc5qQ257U4/YegUqhKAeusLEgWDgmo2
         jXErc+nb9kz7luSdwA2ERLNDRV/DmPFJzSJtUBcTkxFSnhlXo4V3dWMmMLRVtzdHaLcj
         NB/w==
X-Gm-Message-State: AFuF++mBlwHqFUQsUn5ZlgzDCfPJb4PL8K23Ce7E2zkHbrtoByE2rFkZ
	B4vhxBGe3TVq3nDumvuMYxmUl8egJ8zdelJ+rae7Y9FybNTQWFMXPrvPyfmSRVHm
X-Gm-Gg: AYBFou0RLUO9gsUB3I57rOE00cnpjyHAnSUSmlQK+xmygQlwEHVgYpmX9OOOgUEsJIG
	+ESiBfcbzt+A0HniX/11NmizIczb1331MtGBXEa5/hV/usQDmjqRlBf3Pv4Bi9usX95JDPDD8Xm
	BmckvLT85phFJ5E94jnQcs987cLkUnTlU0RCFtQ0kXOMo2aROcGd1WNtUfC31AYRI0wPFXLWmTs
	ovzXEEKu0819JtrKAUu8zf8llDleqaHPsUGrAfotrTAuRYxDrk+Q0imyMk6g/b1RQXrPWA9PFZP
	WPK46FMN3TotknSy2m1dRzXjQXga4tHs0+28qX0m29XxN4cjrBniK8j+rvyuKmvdQlJCwhVxNRv
	cCZIYmVmRsaohQsE/sAPxWJvi2xKkOlK5ftzT4jsoDERsqp09cBZvHcZXt7O7QzHNp+jhEXn/0J
	YQid8cKEA/ji5eVuAnLiutyWnmL1XuZVB+HkAJTlYva/FdOBILN4/bOvU7hUJdM2ZyyJt85MOq4
	b6UbUqq55Qm7xCqIoQVIBtJDP+/FIRVbDrhBc9TRc2vcBo0MwpuGE4Qpv2o6jBR5jcofeDUZrx7
	Ankzk/F3EEIvNOpxVeFz+8WlXDS/tipRRR9HamdWNn/yO3iIuVELc+5e2J252iqHnGGkcNIcvkH
	ghnNCnV9WB6sr77QR4JD20PB3isb4+PV+OZupGKum/i6EO4R0efYY0nWrWNU=
X-Received: by 2002:a17:90a:c106:b0:398:e1f4:bda1 with SMTP id 98e67ed59e1d1-39b2624cf3fmr6437179a91.21.1788499281924;
        Thu, 03 Sep 2026 22:21:21 -0700 (PDT)
Received: from localhost.localdomain ([101.251.7.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08ce4221sm10352550a91.14.2026.09.03.22.21.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Sep 2026 22:21:21 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: stable@vger.kernel.org
Cc: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>,
	Felix Fietkau <nbd@nbd.name>
Subject: [PATCH 6.12.y] wifi: mt76: mt7996: validate default EEPROM firmware size
Date: Fri,  4 Sep 2026 11:06:14 +0545
Message-ID: <20260904052114.15758-1-acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <2026090431-charred-eggnog-c271@gregkh>
References: <2026090431-charred-eggnog-c271@gregkh>
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
Link: https://patch.msgid.link/20260713115412.67095-1-acharyalaxman8848@gmail.com
Signed-off-by: Felix Fietkau <nbd@nbd.name>
(cherry picked from commit 653c6e289b13cc6942f3e8f8e3c568e70fa42d1f)
---
 drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
index 4c4ab0d40..a14d1d284 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
@@ -51,6 +51,12 @@ mt7996_eeprom_load_default(struct mt7996_dev *dev)
 		goto out;
 	}
 
+	if (fw->size < MT7996_EEPROM_SIZE) {
+		dev_err(dev->mt76.dev, "Invalid default bin size\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
 	memcpy(eeprom, fw->data, MT7996_EEPROM_SIZE);
 	dev->flash_mode = true;
 
-- 
2.51.2

