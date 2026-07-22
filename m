Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43431385D7D
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 12:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784722367; cv=none; b=sXunXndzEavJXeQBRXhOc7pgz04zlMoNUgebgQ2BBCwBwBcxcASJCe5/JHPfklyBUgwlMkZZlFrh2OV5fjl2SupJ0joi0ucBfIXta2q3VmtaA4Di6M/s90KWDtVRwBHC5MuOLJh1IolxvGYQXgbzqg5ybWMM5kkRZ4QpKQYOPp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784722367; c=relaxed/simple;
	bh=79j7NnDjv0QihjdfhzUpWvNFrgM+H6kwI0tyHE/S/UI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oRnSAtfRXoD0KGaQZ3L09uDpqyMRsYWQkf75Mrtwj6/471VxQ2isULUwFropngay13slpAyUmagKRZcADYAf5149s8kAHlaGtAYY4G54HHmldiLb4keFjOu61rldlAYPKEU0y8Subt5viklHBB3H4BxSdnKTs/X/BO59Me5/CU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=SlGU3Cqk; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="SlGU3Cqk"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84867f07d63so13889025b3a.2
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 05:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1784722364; x=1785327164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fHYM3ypwNgSEsVx6UcghJ4+KBn7vHb7BLLcIj3NJUsk=;
        b=SlGU3CqksJg3LxVsi+nxHv8sxnQpEwiv9+Y5xp4ofUPM+SjmiXbhzdEN3eoOlJ+5M8
         guUcnA8ztpiPUrn1CVvkDGnZQj4VDuyhOcPLobRSDprOrrij0lMet5u5AHyEsSmuMAZr
         otrAr0560Sr3IcJUkd6qZ4zibcZ1vDHRXmThKdVRIbNwSBc+WrUC3MgEK/PeSVyPBrhm
         E6A0qp2j6I7GrZjO1VD4GNJd6v3wr6500klIVLgcE4p2W+InyqXXFz1kwH6gawIuNcxC
         k4bNpcSxe+melEFNfo3QBpYewkVuPCp7H3Ib9b8XCluDgMxyRpN42AzqO+y+Rk1cBHu3
         c9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784722364; x=1785327164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fHYM3ypwNgSEsVx6UcghJ4+KBn7vHb7BLLcIj3NJUsk=;
        b=jkJhZxCZ7HqFcB8j9kLPQsjTQf2OpEUA7VpOolEfdvshfK1yaQsR+6PIzhPqKrE8mf
         5rRSw2BuIJ6CpGvnr94SMBcR+nLW6z4o3zS7WIUcCiNdeROYfvaUaR4+uPFffY9gisSR
         xrUaH6K9ImZ+siJqpp+1VcSYgAJyM+m1oxOoSkA6OegjLyHlrdhEXEcaQ4fIjouKl9i7
         aq18Bbui6oAD5K349ncgdfdyykPQIEk5t4zH+xxd8tnSQkTN83nxob0IEdWmSFAisWoD
         Ms7PN9S6nDaj8ECKTKyWxFhohLISTR0EdPHCak47FwCzaHMEuW35svLbR8Kg9PEZ4C8M
         H7kQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp3cFj3snx8XPwKk8cr/xYQ+kcS3D+jkBklYEgzQwR5lVUP3G+82TtyFqgs6TqurhEWBBRnP4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCGRl6bvWAolDP/7vui2udUsdfx49kt+MNmM5v5lDLaJJwQpu5
	x2ZJeZvZCM9St9jfY62/a1Taue2rmNss+jjLCshgGOyyBIdB9nMppIXBOXvdWRlSCtw=
X-Gm-Gg: AR+sD11C4GkDx0V5jhRr5qjIQAQyyO9zp/t5pupSHWXp4TeIK3A+WZ4TgmiQINK66o2
	Hse0czTihxOTOw0SxWeBNRvADcLKMA1oHEGFb2Qr5RX/rWBhio1EqrWyQuXGCq22K5hSFf3kVLm
	ewguGaHNLegziBGQTOfLV5B6ukWUO2AZ/kwklM1H1geDnw37RhYn88Iqo3ObY2yyFUj/W3eQ5kr
	6SSh+/6+lXxl552LedUk9TL7oUT2KxI6pGUsa409udDUUXr24nbXOBhclTVls5pTYSo1QnZzzDo
	UgL51I6dc6JihqO/5ElndAJroTZjjOrKv1FqYS0m4P0e5FON6DQTx3nwdj1w98BhiD7N2j7c+nU
	36hXajfRKlJbh1o25QlF/TtltGjErCrMGDNYcMBcykdFRr/gv1cn4LtA+U7HroMO1fbmJ0aURHL
	iQQ/vFtJJqGrwn/DR723n9KyPtAXihj8FZq4iBCq4fdRqsHoRras1YZd9st++egu+60qGHJcIrF
	R8onPR8VRRXGffBvX7DwNF+D0ZIjyjLN1pHumAPcPI=
X-Received: by 2002:a05:6a00:a10:b0:847:926c:582c with SMTP id d2e1a72fcca58-84c292bc6aemr24736309b3a.29.1784722363558;
        Wed, 22 Jul 2026 05:12:43 -0700 (PDT)
Received: from Metius.iitm.ac.in ([103.158.43.43])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-84e1757488csm1205304b3a.33.2026.07.22.05.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 05:12:42 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: pkshih@realtek.com
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] wifi: rtlwifi: rtl8192du: Fix possible memory leak in rtl92du_init_sw_vars()
Date: Wed, 22 Jul 2026 17:42:35 +0530
Message-ID: <20260722121236.136754-1-nihaal@cse.iitm.ac.in>
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
Compile tested only. Issue found with static analysis.

 .../net/wireless/realtek/rtlwifi/rtl8192du/sw.c    | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/sw.c
index 7bafb051d5ec..c7eab3382b73 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/sw.c
@@ -118,7 +118,7 @@ static int rtl92du_init_sw_vars(struct ieee80211_hw *hw)
 
 	err = rtl92du_init_shared_data(hw);
 	if (err)
-		return err;
+		goto error;
 
 	rtlpriv->dm.dm_initialgain_enable = true;
 	rtlpriv->dm.dm_flag = 0;
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

