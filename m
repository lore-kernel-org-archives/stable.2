Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94233AE198
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 05:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788499269; cv=none; b=pLh6e6l3y94u27uV48pO6i0i6Z+EJXraDtT8Xwh6yinIwsTXBb3ehrQ176OFyTbm+SPjNnokoPoUKm7ZgHRZ+kp7Wye/ssd10i/RGVm2VKNLJrsv0OD3qKvEap6TgSZnyVBaPYVzi3r4McZa+R8/uiyiOzFu0r1lkyiaibkUvtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788499269; c=relaxed/simple;
	bh=bw8idzDqY+WuTnwVqKBc9dwfUNPmvKtLIFb9sTimgSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=igK3T8X1fHKJwPxgQY0M9cQ+B0DKjyPd45Uv2cIZQnZvjmGsEWejFcDscMJno50gy9gdsXwoLyVsgzAswoLZUxpkZPxorEFNXXNeh9IwT/DI2hc1Su8OZEedlB00GF540TIu6fItCB+SW7ie7Qm60AzDxF6/sdyBKzuIRttl2Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PxIDQzhG; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxIDQzhG"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84830c774a0so644636b3a.1
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 22:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788499267; x=1789104067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L3EHpehCxZtLURNDjp+bNAgtij9Wvbx1WGmSA+OoVmA=;
        b=PxIDQzhGuCpsWXTmqIy5eaGJ0mPUpO5bOljjhiL4aWs1lXqNnZt/MMY+amBPDxzMbm
         zYCm3XnU6l8Obhdp3NjsZYmPiqQhaKfZtF5yJMnPkqNf2k5qkseHZcrs5F5/AMQXeDXW
         nP5hIpqTQcHXM1r1+tOL0q5b38hbVVpVofGDy91+OHhU24XI81gFiR4h2VpYWo4RBn1Z
         cVG25Pa19QF3lsXbSy24yIAEhFZOZHY3ixgR+WKzgcfKYpahRLbQPNj4AzVphwLrY5O3
         P0z+sPYW+7RYkZm5CNg0mA2Gn13DD49OGlOGd+O6q4XIok0jjf70H3xgdtU068XFnYkl
         /IaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788499267; x=1789104067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L3EHpehCxZtLURNDjp+bNAgtij9Wvbx1WGmSA+OoVmA=;
        b=Tn6tyDT9edaIWaXiO68W4fqCrDAF33PI+e5rwjzPiwwmalWN9BHn3ZMYlMgeIQ21aw
         2iaQsOkTmcve2GLmSiUAOWhL7b7AHl+WKM1/qt4ivlpsw+rrapIer01lD5qFMi03idjN
         amyWraeP2jecdhT54SgAwY/NdTRE6sDkyQ4jK6iMOe8JLRftbx92sLjpUSaZ6kqh9QJ/
         IwLL2kEAXT6e49gZNFliHBAnbs/O/7MKVU9LgqCZXs/zPsAcDNwOvbI13KTnQYTYzdSg
         W+7kVJ2tVmPH5u3iseiF31nV5/O0eOqvWsgy6txHWQXz0DhiF+ksYCNbfA9HJdM2Ky4V
         K0gA==
X-Gm-Message-State: AFuF++krvkrKSngMUs0lZdGt6Gr+Vzoj8pKBejkTZLXWJr3ZO9T3Kb61
	1O7nVSmz4gSDfls/IRaYJCCBI8oG3kkF9KrbHK/gAq9bt8iWbHWZpmZ2vvERmA==
X-Gm-Gg: AYBFou1LJ/tI0fHA+Naq2BVF7uYTLAuDFwrFtjBs68K62FsBNLwJau9YLeHPAH++4fU
	D709n48qKVU/vov6PigCnTgYG5JCIH6KjoBMG0x7OJGgq6V9UWZRX5TndZLYGzvwkvXFnf88MVH
	zl+BADvyuEYjOyZkhnhr2GB+t+azhPPtaunCX/xTOX7F9yh66Me7YVWH5N3qRmbHE9Wgn1coj+W
	407YCotfZ+1QrP/CSJYeU8H64tP3DwFwplEorlxPFfKw9ywxmi0VFm2CMKiEaLEginmgo9l7LEN
	+gzTLSf+igaxY80y8R5NnAqw3b2t3pJK8eMcqh42Sz96yOImOmtvA++sT1dhb7CjUTutRM40e2j
	IWgqCsTZGdw7AicnBY9pC0YbNZ/WFn61Oowz8q5llt75Mss089nfQ7xnfBsDvbp5pqLSvcv+jrE
	NB5D+2QGgZs4KqaVwwsDSDHfjB1KzNzAljxdrNQR0oGQd/tQXUezrFD5XIbNAvBAy78HfT/2NmG
	Y31MgHeo3QmvK4txPqQZTN1nRxaKYdKqXciGGgMZf6RFWryIAeZ43CO9YU0xYjkd8N6IrWNb9FV
	g1SeFPobwQRP1OetDbVM9xVIBQzAYbpMQh9IDO0mlR/MXIKmX+J8mpPkumHj91K4I2GMDqx1sD4
	tKQpnMHCerevpLXYrL72V61vzGMCWDcomTQUWsQo92zPpX8/N
X-Received: by 2002:a05:6a20:4388:b0:3da:1e2f:3be9 with SMTP id adf61e73a8af0-3da3a0b0070mr5812163637.22.1788499267061;
        Thu, 03 Sep 2026 22:21:07 -0700 (PDT)
Received: from localhost.localdomain ([101.251.7.10])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc45515436asm443322a12.3.2026.09.03.22.21.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Sep 2026 22:21:06 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: stable@vger.kernel.org
Cc: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>,
	Felix Fietkau <nbd@nbd.name>
Subject: [PATCH 6.6.y] wifi: mt76: mt7996: validate default EEPROM firmware size
Date: Fri,  4 Sep 2026 11:06:00 +0545
Message-ID: <20260904052100.15696-1-acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <2026090432-semester-ambiguity-70b2@gregkh>
References: <2026090432-semester-ambiguity-70b2@gregkh>
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
index 544b6c6f1..8cc1d7ae4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
@@ -43,6 +43,12 @@ mt7996_eeprom_load_default(struct mt7996_dev *dev)
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

