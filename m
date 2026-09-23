Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843643E49C8
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 17:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790184363; cv=none; b=EbIHN94AyIZ+KJOyOFz1Kazuep5UF3Uw2VYaqsl/lwR2B2JE1wVE5GMSMHXwwXWP0Wnidod0kAHhCu6HSZLIuWyznwlBmDPna+Ah6rCiywtIdwIQAWJiycj2QyLTr6+CCnRAGe9bv6iVknQlguXxrZ4jEIzbWKQpsXrj98MlH5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790184363; c=relaxed/simple;
	bh=3KsAEjFLqBZmEEPAhvTPCECnRvZP15T6L/+sh2LbO88=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kJKlTdsmzZFUHbjz+97CApdf6OY6sg+eUTlC3fXMQcCbLPWpKz8hw4MPDXPTxgVYBb+aDh3AO63U3HCyLAsXTHJY44qieTRm9TcZ7N8RYds6uuaF9Ph0RFiV7FWWBI5tuWtvezwCqIgYL0fQpC7aOUXIYLYWgu5oj0gRMtmEPn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHNuEN/a; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHNuEN/a"
Received: by mail-pz2-f40.google.com with SMTP id d2e1a72fcca58-8748f34b1f2so708923b3a.0
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 10:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790184361; x=1790789161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=O22RbiDeWdUAyKALr8GFPofw9Urxk2fBLIPun4++/1o=;
        b=FHNuEN/aiRd9eoMRjYQqA9kN55PjuUYx2Brp/HnLItOyvSlvzZaG24K9S0wp/t7crO
         hgmmjWBA0uYJ+8DhMAm5gHQMEUV34HIUev9MrVZC1MMii7h28Ak7+u1JF/0fFsOg9MxU
         Y5WT8H6tmIXMIVcDSlBGl7mUL8GHmwVcFj1qYpdjf9SiHhY9nZ89dOrY9fsa2sbXaS8d
         JMRK4WdFgIWkIDLkaS+1ua3gTtxlSS/7w3cSdKWTM6UoS3N8XyR0cOyfkvkWXsMUlsWI
         bphs3M/dYCZul6ASGQ/Z81kc4BDG++PhAVY6GB/189bWfnr5MMPpzwiAdT1T8f/kUGRI
         L2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790184361; x=1790789161;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O22RbiDeWdUAyKALr8GFPofw9Urxk2fBLIPun4++/1o=;
        b=DTbINVcPx5Ub3PO2zUkAnSvg2qsaLpGj+xxr6JF1ApsiEzpoIELgbWXMLKzRSGDcTU
         +lrXdS3czRVxIAdoQJ3kDm3T+QWMbKBM3uGTuXNbkgr4BRVRsrp4ZYwMRXnjTLFOsl3z
         IRFWudieM81tB9ni3MQiZdsbSdRSrvC4hkmtzoM+QvAq69+1hOIFZWZHHDr/9QfPOv0n
         Jdi/kGf8r6GEruSvHETLliZxduCeGAexx1wTzuI0L+ZsxiUsXzdozm1dgyqCSjKXU9B3
         4IfcxeoKE9SMKf00NRkHLfRBXP3ID5nkJIf5BWDcvG1nEoYmGWYZfmWMzXANEopJqmug
         xUPQ==
X-Forwarded-Encrypted: i=1; AKwUvBy2HqXLxL8rzxE10vevU33gRyPJ8QnbyURALloSDFeBFs0SS1Uz+bZQAkUGIjqxKGy7faYHhMk=@vger.kernel.org
X-Gm-Message-State: AFuF++kZa1LuqkvVVZ2bRaJMGxocTmMdT+x0KhneCTXMrVZiTiSkE8PZ
	4222ZJ6fFDFM/6iayol0hEaajboPwYzN8K94ym54HjBe9AmMec01gQFi
X-Gm-Gg: AYBFou3slkhH5xs3IlRWokVb6vMGZDeqN8SGHH57rItZEzxqPj9zRGbj1ljWaoxFBhX
	VWiWEQ6iIbrS0bzW7aaExzVpeNIL8IxLOArYVPGF6uWWiXvm0Yyhc3sO1HHycBUlTHF1CslbX2S
	GAtQmsOXSR+YSh2pduAPplAbOoGKfLA4hyEChnZGYUXprWCT49Nb2W4zm4NCvsraYBQhYgKgxNn
	Po/ZoD0PHV9JfD+dikANPu1p5xP15XExiVotHPfqmBYP6yJsn5eVC6getckU69AoubYdzll0W2q
	Knw8QOh3dVjWU5sfHGr0PtUZEAt6vzpJifxUYtxAIWVselnO3cCcNpclJm5lv58T9QamN5Kw9tb
	5OPgwAGdNjvEUZ3h9kPFV3peQCXChM1YZwKhQRKqNplUBQo9fazSTaeDM1knDNzKvLBOssfOfZO
	CaqI+X3a7e09dZQDF4E4GxDhwQc0R0CigdF5SLBLaAODMqMGnLc9ltEBq6dbTKojbq68Og1BVpk
	Xf1+OMWVV59FQ17F61lPwVuUJnWO6Q=
X-Received: by 2002:a05:6a00:14d6:b0:86b:4138:4084 with SMTP id d2e1a72fcca58-87d19376b36mr3446218b3a.15.1790184360521;
        Wed, 23 Sep 2026 10:26:00 -0700 (PDT)
Received: from cfarm424.jing.rocks (cfarm424.jing.rocks. [2600:3c18:e002:2e11::c424])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1e601b5dsm1685893b3a.61.2026.09.23.10.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 10:25:59 -0700 (PDT)
From: Ridham Khurana <khurana.ridham222@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Brigham Campbell <me@brighamcampbell.com>,
	linux-kernel-mentees@lists.linux.dev,
	Ridham Khurana <khurana.ridham222@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] hwmon: (lm95245) Fix negative temperature conversion
Date: Wed, 23 Sep 2026 17:25:48 +0000
Message-ID: <20260923172551.1593798-1-khurana.ridham222@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

temp_from_reg_signed() uses only the high byte when the sign bit is set
and drops the fractional bits in the low byte. Writing -500 to
temp2_offset stores 0xff80 (-0.5 degrees C) in the offset registers,
but reading temp2_offset back returns -1000.

Negative temp1_input and temp2_input values are rounded down to the
next whole degree the same way. The chip reports -0.125 degrees C as
0xffe0, which the driver returns as -1000.

Treat the register pair as a single 16-bit two's complement value.
lm95241 had the same conversion fixed in commit 0c2a40e2fe4f
("hwmon: (lm95241) Fix negative temperature results").

Fixes: fffd80ccc1e6 ("hwmon: LM95245 driver")
Cc: stable@vger.kernel.org
Signed-off-by: Ridham Khurana <khurana.ridham222@gmail.com>
---
Build-tested on arm64 with CONFIG_SENSORS_LM95245=m, tested with i2c-stub in QEMU. Not tested on hardware.

 drivers/hwmon/lm95245.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/lm95245.c b/drivers/hwmon/lm95245.c
index 11553391f54b..925574b8b0ca 100644
--- a/drivers/hwmon/lm95245.c
+++ b/drivers/hwmon/lm95245.c
@@ -96,9 +96,9 @@ static int temp_from_reg_unsigned(u8 val_h, u8 val_l)
 
 static int temp_from_reg_signed(u8 val_h, u8 val_l)
 {
-	if (val_h & 0x80)
-		return (val_h - 0x100) * 1000;
-	return temp_from_reg_unsigned(val_h, val_l);
+	s16 val_hl = (val_h << 8) | val_l;
+
+	return val_hl * 1000 / 256;
 }
 
 static int lm95245_read_conversion_rate(struct lm95245_data *data)
-- 
2.47.3

