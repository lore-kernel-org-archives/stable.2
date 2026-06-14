Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3341ADC97
	for <stable@vger.kernel.org>; Sun, 14 Jun 2026 04:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781412855; cv=none; b=umFHpsWa9+CI8ln0UkaA8MHDT/fwq2AcsCy3zLFXPlN9wMRPts3hNFEakgiYuEWSuViBvJzpWd5ipBKw2EPdMz80IBjH9njzaCWluV0wZhJHKPxPk/H9is6BTCoLWGcYryBl5nPpsaojZSqFJEEu8vhtJ4H7/vyT+zI+Akp7w+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781412855; c=relaxed/simple;
	bh=c4pEfoWDhWE8jZi9anj93tJ4F8Zl5tOqhA7faMzyB+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jN/FW15mPn2C24dP9D+oU3maKFZekqoYgcs/rTceWaBSoY7xBEEDMtVBCNPPwTEHOVk/WrdVEBirfa0nPDXArdTpHv7zFkV4Ph8D9+l4MsFIXCS8mAl9bD1BqcY4RcK+dkMTDBjxwtb+ErQZM+6EXND8SV4/gWVe3j6GFRcPLE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyxTxYUc; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyxTxYUc"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c85ba774551so797201a12.0
        for <stable@vger.kernel.org>; Sat, 13 Jun 2026 21:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781412853; x=1782017653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PDspLBWU0zmhscYIXZ4nd2JbJSwrZkIPTEIbvNZ/tPo=;
        b=iyxTxYUcKtxH0InJeOUP767xcP3BOBWcsUWv11jjbAveZ3e/W5srA1A010Y4UwBoaZ
         7LyiXt1BP0TDGzFYZDHVxH5C1INMu0juqTImMNV/enVMpsPABIq3xJ0I2KPKMjj9u695
         T35YcK9Mg6TMEWcVX1nELB/4b56/EDx2IJ0Hp4YOc+Ju6ZxXWvE2cOGxWEyoMQ1tFPe0
         Wen1duT7+cngCf6u+rLZo2/a0tp8/gkRtFvlDET1NzXiPG7S5fnPur/SkHQcVcVYN26r
         tkkiW7ZfLQNMq7aR37KTHtKL0WQURIN7ZDRgI7r30JfMJzPOaFDKj2SEqMW/osvbzMa1
         7CMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781412853; x=1782017653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDspLBWU0zmhscYIXZ4nd2JbJSwrZkIPTEIbvNZ/tPo=;
        b=jAJbdqOOgxVS12NN54bvAT44zF+bmqBmotqA9hZIezPuk9zaedJ6WBaAUNGimvD9Pi
         n3tzu56vHb4z8jSu5DDGicNIHlmdxBTcMvckB1+fZY3GJUdbb/nDJTvVkQMUYxzCogd6
         FznWnwbzGZUQPjspsG20xowe/At0mqAlm45z/BQgP4OuS9n/D7h5MPsaKq8CS4Zge7G7
         vRNpfiUGo6lu+0JNAuCrnspB9xjHtvFZlyFKfvD0PSn1tAspucY51//Bh8c2Vw3qsYKI
         NSchNdMkfdXc1vgbp6etERDJo7Kylu0K51gUvP2wtuEVO9IciNxUQGoa4v4GmHobFqfC
         UVIg==
X-Forwarded-Encrypted: i=1; AFNElJ8pq41f217KLGexXGFSz2dj3cYvxHpCwni5dVT2WxJ/AyULLgHxiTqUNk+pGGCrZByTTBKnA3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuMOOC0Ufm8Jt42/UcDNmYpqECaO9yxP6UX9+YWN/QIozn1bYm
	RSOtrwmmFDnN5rwCBkS2tyNxJosXuG99WnnGfkbNYSw/HXW3oy6VhQ59
X-Gm-Gg: Acq92OFvcc3UvNWjJehSyKVvkmV6vzjP64lpOFXpC0dZee9g0FUfjvzKMjQeYYDxhNQ
	Kr0+DsQ/cEmzGHhrpGpXMRtmuVFfP1ySJFREzapzf2eXWI+6wH+BWWe2cTCO4AQlJtFjcs1Htlu
	r0XzhYNvLbDZmTlNKPPu7YeUStgW0vcJu5fhN9T0CTlcMNP8dSAIbIjERMb68R3Txw16ZXBMZhX
	mlI6gKE/eDCYEzeb+e3Lrgj336cWDG3Wa+xkkCNHE8ugBKxJaGA6RXX1bNjySCEIhYdyDfiW9Si
	FYL9rZ1kILOvbLW6msJj+iTAtdaJugkkSSKEGsQaoITUnMQZJ3OvxE5GKNiRIWA/nGvqaWc8NsA
	69W+pRY6BmXfaM1tjzk+1lEk2dcYwG4uMWJYKRDP3amq0muK+O5kyqgRjBJk86ZO64l3K94z3jw
	Yf6N4S/9bXf26m9ORmuoMvSMXNuIgMQqQ9DMA2i9Tul13P1JcRcEZxB/8idTaO7mGmWqyqKOIzR
	YflCVupB/dZsH01
X-Received: by 2002:a05:6a00:35c7:b0:842:6a3b:60c9 with SMTP id d2e1a72fcca58-844e1a3df2bmr6837677b3a.24.1781412853538;
        Sat, 13 Jun 2026 21:54:13 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b00d3f9sm5715031b3a.41.2026.06.13.21.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 21:54:12 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: Prasanth Ksr <prasanth.ksr@dell.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Dell.Client.Kernel@dell.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] platform/x86: dell-wmi-sysman: Don't hex dump attribute security buffer
Date: Sun, 14 Jun 2026 13:53:53 +0900
Message-ID: <20260614045353.143500-1-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

set_attribute() populates the security area of the BIOS attribute request
buffer with the current admin password via populate_security_buffer(), then
dumps the whole request buffer with print_hex_dump_bytes(). This can expose
the plaintext admin password in the kernel log.

The same issue was fixed for the password attribute path by
commit d1a196e0a6dc ("platform/x86: dell-wmi-sysman: Don't hex dump
plaintext password data"). Remove the remaining dump from the BIOS
attribute path.

Fixes: e8a60aa7404b ("platform/x86: Introduce support for Systems Management Driver over WMI for Dell Systems")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
---
 drivers/platform/x86/dell/dell-wmi-sysman/biosattr-interface.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/biosattr-interface.c b/drivers/platform/x86/dell/dell-wmi-sysman/biosattr-interface.c
index c2dd2de6bc20..fea97d6c3bf0 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/biosattr-interface.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/biosattr-interface.c
@@ -84,7 +84,6 @@ int set_attribute(const char *a_name, const char *a_value)
 	if (ret < 0)
 		goto out;
 
-	print_hex_dump_bytes("set attribute data: ", DUMP_PREFIX_NONE, buffer, buffer_size);
 	ret = call_biosattributes_interface(wmi_priv.bios_attr_wdev,
 					    buffer, buffer_size,
 					    SETATTRIBUTE_METHOD_ID);
-- 
2.43.0

