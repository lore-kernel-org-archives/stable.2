Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D96357CF1
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 04:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786336085; cv=none; b=sKgxLDvnljAjs2GhVOoKiebL/W5SuaKQzLV7HcM0EO7+/PNpGCZrUgQrSX/hYePi2FPcQq74DHwlPTrJJAkpBRhU4LICMZgrZuDBSleuttPWOinY/Pgfv1O6rs8bqX0cvbDYYNZRfuGpyx6CfhtujvBloGrVTCejugUlg/AXfrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786336085; c=relaxed/simple;
	bh=dQPkDTMmuze2BB03YWJVGmQDQp7RRBBNNh3k1shsgcY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=caqXvHSJin16FBF+14EqCilnNjI6gks7994vCKD026PVBAmM2ZuIPjEvtDmQ0OmS1cma/Adei7BXPBm7+q61S2CCIfs8VPi14S7vPo2gdkynyiwybAcc4ex156VLEUOQZkIABHk+dsUxCBZyDRcolw7iUZ85f5IyIhAoC6kTuL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cvonk9WJ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cvonk9WJ"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ceab75934dso15932755ad.2
        for <stable@vger.kernel.org>; Sun, 09 Aug 2026 21:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786336083; x=1786940883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G2+mngqpXFB/BdP3WTYNLW4HV2B5Fpn24ngCal9LsJQ=;
        b=Cvonk9WJ8EMy8mlSpxKEX/dhsCFKv2cm+8W9qq+xzAVOqd+Sz9CT7ea37/cNFRjiOE
         8i2aMXkkL2jF3V/+FsdyS7g/gBrpHXdsf/LFTDZbawmEdwjVWdj5MABBXKzn0bbvwmTn
         m3yuu85AHYx2QuzdnHkQ4qlEj5B4u+KHAfuPtTKyv2zVEgCWTJoKXmMMxrcPYnGYYIE3
         Q0W2BEwqdp0WLhQIrB6PvtsMckquX0uFI68Q6MC2nXaqrGKy4ExanLwe9tDIwGnVPmLA
         Ao0teF74S+sYHaCNjStEdbqZS0f2JK034Qvnkg7xySNECPChWwVd7iHi7+1aTXYOIYOY
         QQ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786336083; x=1786940883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G2+mngqpXFB/BdP3WTYNLW4HV2B5Fpn24ngCal9LsJQ=;
        b=NnGvvu7VZj/8xtx1GbTn1dXuw9JC1MuKF9pyrt09mGOpylYSlCppXx3/A9Vf4lFbc5
         fEzL7WRJ8VWcdfzMCwNERAHaqkjj70/NrKqpEvH5qz+zMynxvfYAhDaKHStenL4u1ch1
         RvOHnckEEqbaCEiV7/Nam1DG0uSZ+lg7WWmSVFLnDg66RlASlp4IiGNYKTG5+ceZbS2n
         q/KwzZT7TwP1QhkUdoCNXcfJCMIat5T5u8sCTjb2Ur+HFqJn1tJNLERRJPxopi3rjOZP
         xUoIFOlrpYxJHRfEGHl1KffpURCi8VfzAj1Ie7fsUwE25u8fOlkO/evky0SUJR0E3eXi
         yrww==
X-Forwarded-Encrypted: i=1; AHgh+Rphk95kYMtXXbzVtRQr5ZVVTbmcwcEXCpKtnDS0HjCTELaQGdX4eTYOfBgsoZWrmP2yjZp2UtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFcER8T7y0zTc4XbkkhOAwU3wgZx1lQqz2jqqGqpcFNIk4v61r
	74+yx9FnKgq+LmdTzkCh8LywFa1PZdEgHq0/PTEOtLU0iJ6HIFnmAzi4
X-Gm-Gg: AR+sD125Vs+5Mm2HIp5itEHcJuyI/QCBI4kcNGXp08tpttKMGoJCLM93rKGR5eQ7B+R
	odADTOwF4LDOt1br3UCSZ3gcAsEjyDxZR7mkbnfj4xjGAQA6TnKDL7BZ8dRs/SErm/cHMn+xjhE
	akJUY+Ftbk1+oUCfxlHIjx6vOdeDTU0MSKZkrN5WxcNdts/MksW3BduwZxV26T4MRF5USrwKhhF
	4obH7i4uYc61S/WQV9hzAVQrikm+20MzUiacs4VP4hk4dPxUcxoVaT0jz4HH/1E3/9ghlVnbEdT
	peQGZCAusIl1MD0kL31+CNzNyt1ZgbFRdqJdt+K4hGsZ4O1+yCUCtB/e81PPe/QVSPhJXeqfZGw
	C5Cf8Xm6UDRgKV82KBcQDZgQrpa6T6ohZsaKfXrPX1Eh2j0qnDL73VazobbJ/pj23qS8O/yGJ3N
	ht61HM3O7Kkr/1LOw0VhaiR8lIlngC6pJL3UBKH7u+O0AbKMRgxb+kcRxNzTsoO6bwi4X8Yvm7f
	LvQgA==
X-Received: by 2002:a17:903:3848:b0:2c9:c991:3bf0 with SMTP id d9443c01a7336-2d0ca70da11mr486962195ad.8.1786336083184;
        Sun, 09 Aug 2026 21:28:03 -0700 (PDT)
Received: from SGN-LDSENG.tasernet.com ([2405:4800:5cc3:11a:1ac0:4dff:fe8b:4a69])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315be86e917sm43312312eec.5.2026.08.09.21.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 21:28:02 -0700 (PDT)
From: Cong Nguyen <congnt264@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>,
	Vadim Pasternak <vadimp@mellanox.com>,
	linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Cong Nguyen <congnt264@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] hwmon: (max6621) fix temperature clamp range
Date: Mon, 10 Aug 2026 11:27:54 +0700
Message-Id: <9d3a4f1895a47794bb359a2a32fb1ccd6a15812c.1786334038.git.congnt264@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MAX6621_TEMP_INPUT_MIN and MAX6621_TEMP_INPUT_MAX are used to clamp the
writable offset and critical thresholds. They are defined as -127000 and
128000.

The driver decodes the temperature through an s8 and its own comment in
max6621_read() documents an 8-bit two's complement value, whose range is
-128 to +127 degrees C. The current limits therefore reject the valid
-128 degrees C and accept +128 degrees C, which does not fit the 8-bit
range.

Correct the limits to -128000 and 127000.

Fixes: 92b64580f14b ("hwmon: (max6621) Add support for Maxim MAX6621 temperature sensor")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4
Signed-off-by: Cong Nguyen <congnt264@gmail.com>
---
Changes in v2:
 - Drop the temperature input change; it was not a bug (temp_input already
   sign-extends correctly via an s8 intermediate).
 - Drop the incorrect changelog reasoning (no "+128 degC", no PECI/16-bit).
 - Split into two patches per review: this one fixes the clamp range; 2/2
   fixes the negative offset/crit reads.
 - No 1/64 degC precision change (not documented in the datasheet).

 drivers/hwmon/max6621.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/max6621.c b/drivers/hwmon/max6621.c
index a7066f3a0bb4..ee5898fbe110 100644
--- a/drivers/hwmon/max6621.c
+++ b/drivers/hwmon/max6621.c
@@ -17,8 +17,8 @@
 
 #define MAX6621_DRV_NAME		"max6621"
 #define MAX6621_TEMP_INPUT_REG_NUM	9
-#define MAX6621_TEMP_INPUT_MIN		-127000
-#define MAX6621_TEMP_INPUT_MAX		128000
+#define MAX6621_TEMP_INPUT_MIN		-128000
+#define MAX6621_TEMP_INPUT_MAX		127000
 #define MAX6621_TEMP_ALERT_CHAN_SHIFT	1
 
 #define MAX6621_TEMP_S0D0_REG		0x00
-- 
2.25.1

