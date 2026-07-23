Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655CB442B22
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 11:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784807151; cv=none; b=O7fYC9AI2QS3gt+8wm2M7ebAHAah/jbXi/gODWSva4Ypj/AnirKqb0Ik+qW1X+ePzVeLbl2I7tP1EcM+E+sBtIaBBNrg3np5eCDT3qFbBrPUAonjct18t0sjZWrh8lMOqGqxqv8GzNlNy0l5LLSyoRVDOF6/eHd9QPLIwjKOnoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784807151; c=relaxed/simple;
	bh=rnQRIx9nr5Pt9psdgxOkFunoRdX6Lj3wKYuEaoFGItM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aUsFTW0uar+6Qh+qNCga79h23hskCiWE6BwKX2fTWqiJn5Ge0Y7V/1ojVEW1fDENjpI7TJHtxBIrJIOciaEXT/AqrzI+sSZYqmKviAJQTUwDGr8NChm7hLlobUmRw5gm3wX+H5fpJ2b8om5XGVpt+a/0hUGcPAU2bLXAszDOi0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=zRSwyafH; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="zRSwyafH"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ceb096e675so6184955ad.0
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 04:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1784807146; x=1785411946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qW5FtRGSlPIuifYqC0uvc8wKrWKuGaKd/2/4BPZB+Yw=;
        b=zRSwyafHeEBVEgI0lXX37qd8vyO0T2BR5gC2Hah9+rBG8ExIARFVe6GB8Gk6ujmeh8
         3rjss4wDFlLmdmLnZPULpwQutc+GDEMqJTugY7Yz9qV5Qy+t9+FGk4z/hssRNR9yeZO/
         EmmwE2B8sBMwsvfYgb5hLjStarLm5ylj+DtDdQ9Y5P2K6SUqW//qkJIxBgagW4eMB1//
         VjnoToNZ1TY0Q/gF0jdBGSXm8eQYA0jMmCzA9SehQneUBJbOvy8j8B64G7D99uvSG/Dg
         RiVkQpapN4VG68nQqlxDFAabNwtbdwbf6UnNGeHo5VPf2L4VGzKcNCETRdwbUQuF3Z1O
         y7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784807146; x=1785411946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qW5FtRGSlPIuifYqC0uvc8wKrWKuGaKd/2/4BPZB+Yw=;
        b=YNmxiHb46OkzMvwD0ze5uqBt+n4xQd1izxqR/Ds2MMeJH3mCG91jOv9gRczWTQ5dHQ
         SGD+ySPGQ0i7jWOsAtTLuGBBlXyb4mHRI5ZZ27g6A7NAZ1tghua2C0fE2fTFgembu1Vt
         9Sdo3OOeoa6L0EF90ucf+rtOp04Wk/TZdT3awHuGmawYnasTDKzomof65Q7czH4pgoTg
         v1X8xqHdeoN8JUsgCCMrcA9RKUajDsrVqOWMG5TopypeYyv2MsOKWWo8ORu4uz6ZJPUF
         6W0cQ4Z/Cl+oS0hXlldhnGmYMmcy8y5t1waodIcEShxBvKCi8ATKoWcuG74vQKhKHRKI
         jHDA==
X-Forwarded-Encrypted: i=1; AHgh+RqZtywz9Zt+jXrxofWmDu31cSEiGs4PCL3LcjPsI6TIyZ7ZwrKFymNmjkZUY6Kh+QOP0MEdmgI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/MLnUsGu44FKNjyY1OERxGFo1a5Nv8NNuAS/Zlf+OnIwutiAJ
	fdzq37lDa+IwQSVsqd5izeoBkshTxLss3tqr070cK82/sMpS1Lo4rB+TbFEOCmE2MD8=
X-Gm-Gg: AR+sD10T+zxIOToiZo3feLbDi/DxF6/ATqNcJdXahPV+yA13B2cmT4b3WH7P8twH3IZ
	ofEz3J//80KPm4cjPZ45x/vy35K8pz5VFNHoC9PeEpGgIO29TuNZ9GPQmDx+XRGBCWgHSJt5XTH
	BbnoAEcLtlTmR+/WMRiR4N048Tz7k6vfIFREmUdGUSPtAJR6gbJrONVnuwr/P+SIcIaYobLYQHF
	sAwAEKC+MmnV3I65y3imnyWBumpdxtb99v25vCr/HXjwgibARFASr7DNNVy3IdB6PNMuTQBreaJ
	Z1Lkkz1TwWms+XHomxg+J3lJFUtBkxe3YlPZKUoZupVRbQAGfbcuJaszyGuOlnBd3WR4zTSm1YJ
	p1iHTqF5bBNOR8QzzK0LabcVsR4tszrWzl1HNT7ScMMoDDJZ9e/bitZaopEikI6JPQQF7sjC7/p
	sN8GaNr2pIaJxkk8QZtKAkJxvX+n2bsSPbOlx+BOPbeutL2DVmD3A4TB7wWsZrZIg6UOsMzA98b
	BwBnDcpOjyUGRQ2j74CUptVeVVIACUU
X-Received: by 2002:a17:903:3bc7:b0:2cf:4c0f:5116 with SMTP id d9443c01a7336-2cfa6c5e50bmr34449455ad.28.1784807146525;
        Thu, 23 Jul 2026 04:45:46 -0700 (PDT)
Received: from Metius.iitm.ac.in ([103.158.43.43])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2cf8f310644sm32175005ad.55.2026.07.23.04.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 04:45:45 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: pkshih@realtek.com
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rtl8821cerfe2@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2] wifi: rtlwifi: rtl8192du: Fix possible memory leak in rtl92du_init_sw_vars()
Date: Thu, 23 Jul 2026 17:15:37 +0530
Message-ID: <20260723114539.136986-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory allocated inside rtl92du_init_shared_data() is not freed in
any of the subsequent error paths in rtl92du_init_sw_vars().
Fix that by adding a call to rtl92du_deinit_shared_data() in the error
path.

Fixes: b5dc8873b6ff ("wifi: rtlwifi: Add rtl8192du/sw.c")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Issue found using static analysis.

v1->v2:
- Avoid jumping to error path when rtl92du_init_shared_data() fails,
  since in that error path, the memory is already freed even on error.
  Thanks to Ping-Ke Shih for pointing this out.

v1 link: https://patchwork.kernel.org/project/linux-wireless/patch/20260722121236.136754-1-nihaal@cse.iitm.ac.in/

 drivers/net/wireless/realtek/rtlwifi/rtl8192du/sw.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/sw.c
index 7bafb051d5ec..88e8cc590c54 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/sw.c
@@ -145,8 +145,10 @@ static int rtl92du_init_sw_vars(struct ieee80211_hw *hw)
 
 	/* for firmware buf */
 	rtlpriv->rtlhal.pfirmware = kmalloc(0x8000, GFP_KERNEL);
-	if (!rtlpriv->rtlhal.pfirmware)
-		return -ENOMEM;
+	if (!rtlpriv->rtlhal.pfirmware) {
+		err = -ENOMEM;
+		goto error;
+	}
 
 	rtlpriv->max_fw_size = 0x8000;
 	pr_info("Driver for Realtek RTL8192DU WLAN interface\n");
@@ -160,10 +162,14 @@ static int rtl92du_init_sw_vars(struct ieee80211_hw *hw)
 		pr_err("Failed to request firmware!\n");
 		kfree(rtlpriv->rtlhal.pfirmware);
 		rtlpriv->rtlhal.pfirmware = NULL;
-		return err;
+		goto error;
 	}
 
 	return 0;
+
+error:
+	rtl92du_deinit_shared_data(hw);
+	return err;
 }
 
 static void rtl92du_deinit_sw_vars(struct ieee80211_hw *hw)
-- 
2.43.0

