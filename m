Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB8E42B32E
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 10:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783507431; cv=none; b=C1Mr82b7k/yJbLmNA7rPOX2+QoV3IIgHtNJ4ETr97DpuSGo9s69mU3ITl09DjzHSN5g8oqr6FCB9/cHVZVqf0QM/LWtN9WFE6Ht9RasBSyFu6eVsdy7mKCLapmcoCnDqkzbIW1vaZmI+RymmpUhItcm8vK0j1zixKfW1pNTcjIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783507431; c=relaxed/simple;
	bh=H5w2AGzF0fc8Ya/zdI3DizU+no0z49YzComkUyJ5R/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jzMxEcoX8WbQjX/XXkc3zor5J5uQJLQsdGanxbjyOTatCMHZs6x6KgZvdgeWe3V1Dcgj7skCo/34TMqmW5rGEtKidhM3oEH4uEjE+6dUoX8pnJptotODyZ8E3GJVWOOAYUteP9W1255D99RNivWpaIYUGZ2fpDBuBQP3Wo9BwVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gnnR/jY5; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnnR/jY5"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493c52cde9eso3849135e9.3
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 03:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783507420; x=1784112220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sd+jn8OxzBqMCiodLdjuCiQn2jNeMVrmmbxD+3HhGec=;
        b=gnnR/jY5B8K6fgOTPOCE/e30r7is7FBniqGRa96Uo38ATjVUKsRms5RRAQ934ESlLH
         gjAYl2RW/GW7BHcG5RUCF4rL6cEu4vbEkFnHdbkLOAHh317IPyq3ZAA8YWniqA5HJux3
         LqmccOUvedr4wpAoFDqE+csXyRLEUxSUaNZquK6ZEq/cCM3J29XTuwLj+9Bk1iIpslkK
         0Gc9h/kY3ntjc5lcmlF/l84lwsxTObJYp23JDxAtk19dlmm4ngeCmeU5DWNFn2keNQoQ
         LYbNSH2phUJ0pgR5a34HPGiWnvftUS0euQwwq1lpuWLB0H19o1ncHg5V3LDsk4gsUPvL
         Sdbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783507420; x=1784112220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sd+jn8OxzBqMCiodLdjuCiQn2jNeMVrmmbxD+3HhGec=;
        b=D8rNpRHKluixqtKKi73yafMl1vxEVJec5t16qkQnZ24d2t1p22ROVOVywskxCgN6zN
         u1bT7YhoLZUo6TglHckTMQ+aYVJ/edgMPDGUCmIYoZe5lpU51GOXJ85JuKKY19zTV1An
         I/EUOELYOv1ALHvF3BKXEb9UgbEaETisSt0imIn9L1Vr8/inxVc1xq6NCMkAm/k2G5p0
         xd+z0i7kqlZs0eg69L2MrXP6O1UgzpFZ8cuc+KaZwDC5wcX1WU7JSvrUwJKHWZtWa076
         qpV4OvdV/ZRbh7J5WHfZtNtfRLv1mP/P857a5We4JKWR6U7qnvMw4hqNRRIvJ5etyjU1
         qVbQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrp4VAmMpMEYd7PmWllq+gM3m1fMYx/CmwqbBlP97zyODybvC6r3s3jzpOYgJVFBYvA8ejk+XU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnD+ujp1H3L+3LCfSMhZzBVJRHUB+DHE050lzu1MKkNm7CiOw3
	EI0WTPXpBU/vx6tvbqo8RoQdGiPexbbco1NoTkAHWKmvs5bzSRwnCSbQ
X-Gm-Gg: AfdE7cm/Y0qrcyTLu0AjMbQrFenz/Ls739eAYM9wG7yAarjAah2xToHRhEcD6jrWand
	5gr+xvlIjua2aNcgDhGx+UZJYBRIERsAmTR3o6EvHglj8kdoQYJhDSoMd1Xelu/3HGiHrOTBGpY
	Fr5eN/Pw2WHL3pn9B00u129ePv9NC/Xup4IiKpujc35iwL1qzJChQyA9Hwq0pWq7pM05WQksXxw
	NqIW6uOwPpCvVyqg97qwHHWIgKXmemei1X1sDy6Py9bcBhpn3/xZB/oDSfbla+5XFHL0IU8Kp2S
	glMD/xuOMCZoN+UngmEotnBUq651IbwQAv1BOO1HDQNiA1FCFUW+L3ZXp0WA3LE/xe1m69ZppzI
	1lUxYnqYMA+skN7RnaJn30vzDVHIWRjHAUkDl4OYSqttRLFCiMTNBk8EecZ4NHfnQc4il5lic3c
	9WoEOJwrLRAzHJXbeMRo/em6oQOPmOVMAol0LA6G/+fWgDdlB275nP
X-Received: by 2002:a05:600c:548d:b0:493:b8d9:f28b with SMTP id 5b1f17b1804b1-493e68c7f63mr20954575e9.23.1783507419780;
        Wed, 08 Jul 2026 03:43:39 -0700 (PDT)
Received: from fedora ([2a02:586:e223:fc00:8acb:cd0c:11d0:f2d2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f50418sm117703385e9.11.2026.07.08.03.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 03:43:39 -0700 (PDT)
From: Panagiotis Petrakopoulos <npetrakopoulos2003@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	Hans de Goede <hdegoede@redhat.com>,
	Bastien Nocera <hadess@hadess.net>,
	Larry Finger <Larry.Finger@lwfinger.net>,
	Jes Sorensen <jes.sorensen@gmail.com>,
	Manuel Ebner <manuelebner@mailbox.org>,
	Panagiotis Petrakopoulos <npetrakopoulos2003@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] staging: rtl8723bs: fix missing shared-key auth challenge length check
Date: Wed,  8 Jul 2026 13:42:52 +0300
Message-ID: <20260708104252.144101-1-npetrakopoulos2003@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The WEP shared-key authentication handlers use the challenge-text
element's length. This text and its length are attacker-controlled.
The handlers do not check the length against the fixed 128-byte
chg_txt buffer.

In OnAuthClient() the length from rtw_get_ie() can be up to 255 bytes.
It is used to perform memcpy() into the 128-byte pmlmeinfo->chg_txt.
A malicious AP sending a malformed WLAN_EID_CHALLENGE element can
overflow/underfill chg_txt by up to 127 bytes. This is reachable over
the air, before association, during shared-key authentication. In the
case of an overflow, the driver can write out of bounds. In the case
of an underfill, the driver can echo stale buffer memory. In OnAuth() 
a similar issue is observed. The driver compares a full 128 bytes
regardless of the element's length, reading past a shorter element.

The challenge text is defined to be exactly 128 octets, which is
already provided as the WLAN_AUTH_CHALLENGE_LEN define; require the
element to be exactly that length in both handlers.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Panagiotis Petrakopoulos <npetrakopoulos2003@gmail.com>
Reviewed-by: Manuel Ebner <manuelebner@mailbox.org>
---
v2:
improved patch description for clarity. no code changes.

testing:
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

