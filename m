Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044B52C029D
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782664577; cv=none; b=dU/peTBOY9QjTEPSGWMjrhyhwnlrJBCFb8A329eoD9x5VJezhH1nYEx+R5aW1MxVc3D+8mEvUcwNfUOg6vD/jjDuL64VVSrVXc7RxlJ/uSq8Skx0uzyZnsfgzy4MqQTP76S5NnHZ55LBnyTZgC7PSXlbWVIcxf46gyNpNDYqULI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782664577; c=relaxed/simple;
	bh=Dzm/2Mq150RuPlaAtMlFI0lpKRikrDTWDtmhd2EHuZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E7xdYUvX18qffKLM7P5qkGuzMSaHV+kW62fbLXUJ0uUincu4AaGVog7Z1UhFwc9pKjK4gGSE3VxAB64jTrLVSHubYSS8GPjd0aqpUKyaqOcSY5NBWOAkCBvITpScLcXHQa8a74q9Z3swt7jU6Sb1BpIDRslCfWEDuQ3KZlkw4i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sCnou9TD; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sCnou9TD"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-80e4455ba39so729077b3.1
        for <stable@vger.kernel.org>; Sun, 28 Jun 2026 09:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782664574; x=1783269374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cK20Prk6Ya4IGoxcL3yINT5DZ9onNoyQ930594kHMCg=;
        b=sCnou9TDaw/osbNb4Nbmo5WlwIaGjdsLb86o6KpdxM9mgwHicXcrBejxZCjZXz9SAt
         YMJB9/9TNXPIYr2w7ovNycI/ezd1/AiwI2KJDhOwzi8BdXC0lExg3aa7AcMmzI/HvNQl
         TRep2IXzpPOzp+UokpDSrA1ldFXZHF7ciAGz7smGwB6cYNj7yaM0EJt2Jr6esCVAoP+g
         dVkVGTAgYOgZMlVAD/duDC2Qt8e5qyjZM/5YMdQ8DUFj53l3ev7Ax323B9EugGYpUBIO
         uFWb4Q7SklpUz+pcDsKmhk2tkBpq1o0OQc6MvlIHhppvnToMOW94AuZWq2MC+QX397o1
         /e3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782664574; x=1783269374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cK20Prk6Ya4IGoxcL3yINT5DZ9onNoyQ930594kHMCg=;
        b=OQIbmtulQL6x2Wyne526OyUoPN0OXgeD/hAYvKRiVrxrqmbwfYSnDWv2xoez9lDNzq
         MK6B8ChJwrYjqj4fBqamrG2JGF5CE75DHApB/4cAZWVGA7CcG00s5mjqS/1nwnQArSI6
         Su7Hq4ERamkgFMQOscXm1Km5YsahD5AWN089Lviq/miRgJ0VyiRkrQBz+tLgmyOhzr5z
         A6rr9vLiE6yJwoK/aYh53F3d+av9Jf0RpPeMX5f3vW9ayXYjFeTrc9FOuuNhMFC8akIX
         1zCwFuivwv4z9p5Kb6rowbGK+YmP9yu0TU7GpcF6XFPjrCDu+ddVGijbiRG+HdOERAL5
         SOQA==
X-Forwarded-Encrypted: i=1; AHgh+RpfDydY3oU46RhwS6/wYQ1xCRf3t+gZZMxlefmWx7ypg8eqV5ARsie5MFSeTemRZ4XCjf9c/w0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy70bWc5fjTVEagslgx4HMs65q5O6h/3/U1na55fAEUrUvMnYqp
	27TAgiC6YuGHpGMgWy2kbCXr8iivmEUlPHWPu7oCexYJfpk5E1BxJyuYh9S5eGnrKXo84Q==
X-Gm-Gg: AfdE7ckvt/ZP301FrWoU7+f0Yh15tXSlPuK6TrNk4obvAFUWGs6NBQ8ucDmrSS/16eY
	vt6mv/6dggoVClK65YAOFoJ2aDkrweaATnL3YsX+EFXTLzd7mgUMB1QON8a9GjUwKoRlL1Ru4UN
	VaG0y6a4AwVfBdObWd13J5Rr/hBFcVgxtlhwm1yE0g8hh88H5kB0Dvj52+3Q7OTQ98s0+FKZvSF
	Fg8+aX7ET1SV9Qx7BbHb21efcT08GjPB7fjvicutbLVJw+gS3RBmKNDQquoX2xhnn2/zgZ9guf6
	auF5SICuI/vD77esBJ9EyMbwwHPAnHVwP6LxVUskayWq8KqvUUifrJCl41XuMfVtFI7RIkEhIya
	9SXsBWllzEqP0CKazpV9T1V9jbKcOlWyNe2AuSi9kPRZmCksRT1O69M6cuftdwWeQ32JCzeoFw6
	G00OUx9s3FiKI9Bd4acAXz1P2waQ==
X-Received: by 2002:a05:690c:6b01:b0:80b:b76d:650 with SMTP id 00721157ae682-80bb76d0704mr85139297b3.31.1782664574020;
        Sun, 28 Jun 2026 09:36:14 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-80ea903f74fsm6294817b3.21.2026.06.28.09.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 09:36:13 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Stefan Achatz <erazor_de@users.sourceforge.net>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH 4/4] HID: roccat-savu: reject short special reports
Date: Sun, 28 Jun 2026 18:35:27 +0200
Message-ID: <20260628163527.14279-4-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260628163527.14279-1-alhouseenyousef@gmail.com>
References: <20260628163527.14279-1-alhouseenyousef@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

savu_report_to_chrdev() casts special reports to a five-byte structure and
reads all of its payload fields without checking the received size. A
malformed USB device can therefore trigger out-of-bounds reads from the
input buffer when the character device is claimed.

Pass the report size into the helper and require the complete structure.

Fixes: 6a2a6390cf09 ("HID: roccat: add support for Roccat Savu")
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/hid/hid-roccat-savu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-roccat-savu.c b/drivers/hid/hid-roccat-savu.c
index 679136933560..04fa4c50cfa4 100644
--- a/drivers/hid/hid-roccat-savu.c
+++ b/drivers/hid/hid-roccat-savu.c
@@ -152,12 +152,13 @@ static void savu_remove(struct hid_device *hdev)
 }
 
 static void savu_report_to_chrdev(struct roccat_common2_device const *savu,
-		u8 const *data)
+		u8 const *data, int size)
 {
 	struct savu_roccat_report roccat_report;
 	struct savu_mouse_report_special const *special_report;
 
-	if (data[0] != SAVU_MOUSE_REPORT_NUMBER_SPECIAL)
+	if (data[0] != SAVU_MOUSE_REPORT_NUMBER_SPECIAL ||
+	    size < sizeof(*special_report))
 		return;
 
 	special_report = (struct savu_mouse_report_special const *)data;
@@ -183,7 +184,7 @@ static int savu_raw_event(struct hid_device *hdev,
 		return 0;
 
 	if (savu->roccat_claimed)
-		savu_report_to_chrdev(savu, data);
+		savu_report_to_chrdev(savu, data, size);
 
 	return 0;
 }
-- 
2.54.0

