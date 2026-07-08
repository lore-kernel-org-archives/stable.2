Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9AC4028E8
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 08:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783500232; cv=none; b=YkOlfQusV/uEqqMO/X3cRsfPMowh/QjYmcorsHIbtSJ3wLPkiMzfGMcvmJZdUUTkqIrzW0EvB7I6rEsIjkjnxmH0zntu2hLOJk9eNy9zo5FMSTCKoi1tpbJB2OimFepdp10yBtZpcwLMVt3GJFcCyrM9rIQF21n0xtG1s9HWH2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783500232; c=relaxed/simple;
	bh=coXAOqh54O06cdwsWZhAVX1eDRPqTpuYjLzzbMpMqEg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UqLy15IXuG1yhbLpxwxXNjE0Zjdlwt0efLFcPM85d5iu8VA0aPFtwhXYOl3fZMv8snUaEdiVHOzn87+mUhtzidohNpxopfmUoHBWrNEHWY2WgMVoWX8g5EyXZdF2IKaCSugLlBZ5AmMojP7rjlaBSy1xZxcfBuOyCji3M3Z3SIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDMBMNOM; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDMBMNOM"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493c2b3dc8bso2385805e9.2
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 01:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783500229; x=1784105029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b4UxBahBQcan7ix1kOENgrscU0vnxasAiMKDV3UuEs4=;
        b=UDMBMNOMVnZp3WPAkr/cYqLo1epJ83tnVdBe1RShOGemnASAEvwZyP4YKe9AHAcvC0
         3w32y1qz6f6jevRkCeKbw5nwF3AgCzzUgqXxsBlomG9UgeA/tbJSjyhEL6tPh2WhEuZ5
         ZOtwcaKn/p9bCze+ZCc7Ozygsxt8APKMiCHg/56+ClrFex5PSIbeqXqMWp6x3qeT/I7B
         i10teqGs5FnFKmwz+u+CZXdb44BJAZ6oAaUMDXuuxwopQ0rx32es0g4Ec23LqS04SP9X
         qhhHIjmDiyvHcc88QCpIyava3eMb/cbm210x8S8nVavvxXlKG3dXo87TAjgU4bdkbZHU
         gS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783500229; x=1784105029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b4UxBahBQcan7ix1kOENgrscU0vnxasAiMKDV3UuEs4=;
        b=SfqFUyuIaA8JhZwGNv4JrD+FWb/sFU8wo+pa4yuDeC9RMNPJvNZOcsS6YoPpwJFYIN
         912+B3UZChKMfV3i/ILfghoumYtBeeEJp+rENm9MEivUGzminV+LeO2oUnIpYqN22k6f
         R0NVmLkn40OwxtP/z/D3pHBsbX7UHiL1hfHlJbypCckA08Egj2bWYOdZ+FVGoNMPvubs
         br8PlICWg9yCVpwj/CdiIUEp7+meJ4lmEAzhg+sZpP8FHD73Xy4TRBm5YukI+sCB2id8
         EkRF2jLfSJ6m6kWZrQdW9Z252IAnlJ0oDsdin3kE0eh9Ah6uRa+qJ0gXVH4iPLsaafqa
         hZFg==
X-Forwarded-Encrypted: i=1; AHgh+Ros78veetsu8/zZ8V37SU8y/ucDGMPPtCMXbqzUs4Yjpux5N94Ice34K0p2LkcSKmnr6K5eTzI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+O6i5jMU8d63lU6Tmy0og6xF114HaQonOldhYOxUsTyLS+dlv
	nAkTvOJL3jAjZlahqahb7Rl6l6OH4+UKEwZ4V6jWtYohM2MMcsp4YjZV
X-Gm-Gg: AfdE7clR4M66SS1qkY7oNR+7TMajJTLYtCejjf8eojUd5WgD51tThHdmtighZSIR4QA
	3Y3V6r+Pc1+7VndqcCQkFdLNTX8aDsV+XWBbWr9dQxfV58fG8Z3aTa/x/ARr7Iky1UV2dpOLgLO
	qIZUE1Cnhm04rWgJYiqzvqy0qdB5gRLgSyxm4QOLErZfSynCnHuSgLeI0KyTbj7V6gYU4lL/eqq
	pA2CpBfOY4nb5VRz4KOEMtqVn6X4Sq2znONm8XtDMkn4zBDEb4/TffNh8lmMrFxgq8wPHRYClaz
	pWGkFsEZBnGqtCQdwRBq02JBVh9eOr4ptI0KC/97ybfiO84RiS9T4v3pYB88O/6NQEz1fC75PXF
	7xq8148+mCsPKut9yxqujQ2L8wNzpD2C8Glkji5ac2u/DCrZcC02lkqBZu1hIKuU/nSf/rictp1
	OoCC55VAk/tKIoa/sgm96CvCSUZd9K9Dc6gMnwo6EONZwIfsWxG1UO
X-Received: by 2002:a05:600c:871a:b0:493:bc4a:e7d3 with SMTP id 5b1f17b1804b1-493e68f14a9mr13221615e9.39.1783500228871;
        Wed, 08 Jul 2026 01:43:48 -0700 (PDT)
Received: from fedora ([2a02:586:e223:fc00:8acb:cd0c:11d0:f2d2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d8f1sm41581979f8f.3.2026.07.08.01.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 01:43:48 -0700 (PDT)
From: Panagiotis Petrakopoulos <npetrakopoulos2003@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	Panagiotis Petrakopoulos <npetrakopoulos2003@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: fix missing shared-key auth challenge length check
Date: Wed,  8 Jul 2026 11:43:42 +0300
Message-ID: <20260708084342.136878-1-npetrakopoulos2003@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The WEP shared-key authentication handlers use the challenge-text
element's attacker-controlled length without checking it against the
fixed 128-byte chg_txt buffer.

In OnAuthClient() the length from rtw_get_ie() - up to 255 - is used
to perform memcpy() into the 128-byte pmlmeinfo->chg_txt, so a
malicious AP sending a malformed WLAN_EID_CHALLENGE element can
overflow/underfill chg_txt by up to 127 bytes. It is reachable over the
air, before association, during shared-key authentication. In the case
of an overflow, the driver can write out of bounds. In the case of an
underfill, the driver can echo stale buffer memory. In OnAuth() a
similar issue is observed. The driver compares a full 128 bytes
regardless of the element's length, reading past a shorter element.

The challenge text is defined to be exactly 128 octets, which is
already provided as the WLAN_AUTH_CHALLENGE_LEN define; require the
element to be exactly that length in both handlers.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Panagiotis Petrakopoulos <npetrakopoulos2003@gmail.com>
---
Compile-tested only; I do not have RTL8723BS hardware to test the
shared-key authentication path at runtime. The change only rejects
challenge elements whose length differs from the spec-mandated 128
bytes, so conforming peers are unaffected.

 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index a86d6f97cf02..13634d4e83d1 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -787,7 +787,7 @@ unsigned int OnAuth(struct adapter *padapter, union recv_frame *precv_frame)
 			p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + 4 + _AUTH_IE_OFFSET_, WLAN_EID_CHALLENGE, (int *)&ie_len,
 					len - WLAN_HDR_A3_LEN - _AUTH_IE_OFFSET_ - 4);
 
-			if (!p || ie_len <= 0) {
+			if (!p || ie_len != WLAN_AUTH_CHALLENGE_LEN) {
 				status = WLAN_STATUS_CHALLENGE_FAIL;
 				goto auth_fail;
 			}
@@ -873,7 +873,7 @@ unsigned int OnAuthClient(struct adapter *padapter, union recv_frame *precv_fram
 			p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + _AUTH_IE_OFFSET_, WLAN_EID_CHALLENGE, (int *)&len,
 				pkt_len - WLAN_HDR_A3_LEN - _AUTH_IE_OFFSET_);
 
-			if (!p)
+			if (!p || len != WLAN_AUTH_CHALLENGE_LEN)
 				goto authclnt_fail;
 
 			memcpy(pmlmeinfo->chg_txt, p + 2, len);
-- 
2.55.0

