Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088B33DB302
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 19:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780945691; cv=none; b=qR9K0QFk0hF/ob8VCXMqD3jSPRd6YTH2cOBbCDNxqFJxnVctckiQOtZZrgJBQYsHB8VMPhIKOmD0d400UjfcvAIvdUOrdPbX7vE33SWESqzTR+kerVB9d9gPdZHU2mz3YmQnGfUMjzjfpgb0u0v4PHKCMkcHI6GZGcaOLeky6wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780945691; c=relaxed/simple;
	bh=mrlN8oTK1xCKFazv7gxjN+JMJKdR9jAYfIEr3zLtFSc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hHO22ck4qNhyezCgVGibnwMhlP8OoXBNsZQXnjilgVmj5kL2uu1e7TAcLDyxAYUjX4iprunaBZZtjJeFCdx/7CaBqRMp1gb2ph14FYxgR9AmmYUIN39kTM3LbtCC9i2WDq9guLHwwq1c+okKmCNLlpcc7ezK+r9pPXNzex86rPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FehfIMEK; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FehfIMEK"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490b211ee6aso36704155e9.3
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 12:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780945688; x=1781550488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zIpRmwEDvt5u/zq21xSApuv1AvoqyPfLmSADHW3zJO0=;
        b=FehfIMEK3s2UeL65bya4uOlbnM8KvvZScjUhxzOGi3qKe+w3T9SP3O9VEPcYasKbOx
         Yd1af2QTpDgtdqrwLmRd73dc1XXCjVIWpxvqhS9ZjRFF+kfKSYu23uKgU5v9qRUn+Y04
         wmFWCN0lQyILXc4ijvaZmHs1DFtvNnZqrHsuWe+uyLoCUfS9SXJIY6n+zQ9bdO+z5iY5
         J2x6Y+qDMxBXx8s2Abh6ISZafQyXNz+8rn061L6UWgUwp/ryftnQJV2jQHFFuKscQNRF
         glWPILdnqvOXmMEVuX8Vbz+MT2iVAMi8L3JGCAoPZpHM7wDT78zEG3GapZV4tiuvtyw/
         4smQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780945688; x=1781550488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zIpRmwEDvt5u/zq21xSApuv1AvoqyPfLmSADHW3zJO0=;
        b=aPiWliv7viLjZlORQoKTIuEsWEQmqaddMzOXKVPOVetsGNgUIHvlySBmjRvscuNgKh
         J9Zc7RbZ319r6c9ck+jCB6ctatB9/PryeY4t12aWflhdE+bg87Vo1aTWOQi9ZAAVKZhc
         fkAvAjXyWpri83ztWu0eqxEaS+4mPyEoBzmvHAWISnMEVRIYg+K1u6GIDkS+LwohRrGE
         2S935Qk53k8tj00DgY68bGXVwInR3mXtow6eVmZfXuOuTTNeoJSH0JGnsCx4ate5Mpo2
         qgvL3prUJAAgNpxq6X0y+ZJzcUYMrtgb5X5/lYTKYridLtZ9QHrUQtYyqw84GLF0bIBN
         /x3A==
X-Forwarded-Encrypted: i=1; AFNElJ8wUwce0WMQ8qPbUbbNLqyvRS9BNC/jmDPh4mV9VCyr0TvXYSRqf4vPxtsTaWvAFqyxY/4//cY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKqBuVQqwqrG8dPBIdVzrqeENIkA42CYp0VLYSFT/RHtE2b+Qb
	UuaEXARLro1YD6E6pS3Idt6sXhBb0/Jfv/1NqKzQiwDoH6g8FL1aUJxy
X-Gm-Gg: Acq92OFK3OxD8047Cgkg1zYMX3pCyKSZNJL0PB7takKup7A2vvzW2q6WGb7WEXPWG4B
	1eeAKtw4Qch0PdFegXOA+H1++i/avEP+ybcGeHoWI3OmXPpC+bu0PBWGxOsn/aPvx0YwMyW5T36
	aV7dDKTeJ7YL7CRBGizaS+cjpEmBGNRL90EdKIsbjpdz1BUT3FPtHobvqe839ZeaGPERTskNtm3
	3hNRLm2HFo87dQekQEOGgAhSQO7rF00gm22RTkHM/JuZpIY0G2vf8bpXKmmIkT8lNwcAzkZ669I
	j/xI2DfBKFSvpa23gRCMwmqLcFToP/jZhpYrg/PCC1GD75HUGI7v9k4NXHz26Xmo4YCY0lccbYC
	lhNyOLAo2T69COtVN/m1HbAiQeAi9jdNkbUiQOICsyliEHlXXbEYSKxiQS1hTy4AUt1M9+0uz4X
	5N7c6LO0PJ2fPFFGEVFF8knA+hEakqoJVR
X-Received: by 2002:a05:600c:4e43:b0:490:3d62:f5df with SMTP id 5b1f17b1804b1-490c25d24f4mr273799625e9.30.1780945688319;
        Mon, 08 Jun 2026 12:08:08 -0700 (PDT)
Received: from omarchy ([212.58.120.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dc412sm56878622f8f.4.2026.06.08.12.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 12:08:07 -0700 (PDT)
From: Nikoloz Bakuradze <nbakuradze28@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Khushal Chitturi <khushalchitturi@gmail.com>,
	Archit Anant <architanant5@gmail.com>,
	Minu Jin <s9430939@naver.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Kees Cook <kees@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Nikoloz Bakuradze <nbakuradze28@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: core: avoid NULL pointer dereference in c2h_wk_callback
Date: Mon,  8 Jun 2026 23:06:58 +0400
Message-ID: <20260608190700.85755-1-nbakuradze28@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

c2h_wk_callback() allocates a 16-byte buffer with kmalloc(GFP_ATOMIC)
when the c2h event needs to be read by the host. The existing guard
only wraps the read step, so on allocation failure the loop body falls
through with a NULL c2h_evt and dereferences it in rtw_hal_c2h_valid()
(via c2h_evt_valid() which reads buf->id).

Restructure the check into an early continue so the rest of the loop
iteration cannot be reached with a NULL pointer.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Nikoloz Bakuradze <nbakuradze28@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_cmd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index c1185c25ed369..874970116f920 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -1702,12 +1702,12 @@ static void c2h_wk_callback(struct work_struct *work)
 			c2h_evt_clear(adapter);
 		} else {
 			c2h_evt = kmalloc(16, GFP_ATOMIC);
-			if (c2h_evt) {
-				/* This C2H event is not read, read & clear now */
-				if (c2h_evt_read_88xx(adapter, c2h_evt) != _SUCCESS) {
-					kfree(c2h_evt);
-					continue;
-				}
+			if (!c2h_evt)
+				continue;
+			/* This C2H event is not read, read & clear now */
+			if (c2h_evt_read_88xx(adapter, c2h_evt) != _SUCCESS) {
+				kfree(c2h_evt);
+				continue;
 			}
 		}
 
-- 
2.54.0

