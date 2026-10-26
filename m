Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793003453;
	b=YP7uzWLm8k5OYku2HlDVnAV6Ps5/cFGdkHp2sKu3dbctQeoQd5dhi15ybMbaaG8BUwKz
	 1rlUWiHeg3654LuYI9eL1ki0vv2TWaZT5a9KkEladf0hpSXt3tJulxU4fF+Z2vmzUFCRQ
	 efXoasKblHppINkyOFJeKzD3QBYrgpdORIo75QmBGPBwlfSV+xq/VTF+1up7ts7XFiAPu
	 Sv8y2c1aYZcbOOwqPKXN2UI0ngvxZZW86b/lvjisdTRUVXcbZQOOpznkAAJvCkgFce+ii
	 F4icAwPdqyfNBP4JTmB29JMj1jIpp6iXsqax//ppNodP0T9Bi3tc+gnr5G3ZI0YPy/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793003453;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/7TxP0v0CwRMpmnuZd6/tuNx/k5bWUFvFfdUCTCmnjo=;
	b=4UQE++2Gq1UlRzwWao8sSurYJakC7wh5pyaXur9mDL+zVG4G0dpncdWlHoF37XZhYONu
	 SMqQ15cGVqTrxHIeY2u2Uymz4W/RYejRd7VXilZKOV/bFrKmfLsxvEyHGgtXV69crrRdT
	 KFU+JnTnQk5XJf19419GDx70eV9xjGYU4Rf0beD9ym8K+IBr94Qc9Ct/I+L/MPMt7H1eD
	 3e8sw3UixxyWyFBPoeeC09rBq31Kevy9dgAIh6pxseCngX7cthrqGh05BuZAeIqtfUbSk
	 W/QvEcsld30/Wzq6VD7BXxONyukws4c5dYq3zsdcpqqO6AuecJFwdnDGC0jI5NeLCVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qAvD4XZE;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAD6606A32A
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 08:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BAD6606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qAvD4XZE
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e8f2c3ad6bso17066685ad.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 01:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793003452; x=1793608252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/7TxP0v0CwRMpmnuZd6/tuNx/k5bWUFvFfdUCTCmnjo=;
        b=qAvD4XZE4lDyXVZfGlRec+31mDHK+yBDOxa07rhGV7u1dQaJxSweK/VxGCqd9NM3Kl
         NUNqYwtczRP0TAiTVQ+znqCAsrLArktdEzE0YIGwikiCGpRMMofQtyJmHFtppmVvea0C
         4YXWB/kMpoaeQwSKnZ51sUKb+1nxqVw79gUs9spBZ6goknRJYWqYMNTO1Ef47F9xsYFJ
         ycjDvpttjYP/bHhyD0lMhYiDV5Ejtqw9+a5AqEzoX81AlSrMP2bW2wze3Kvn/0/TKXz8
         p/t6nhvUk+trz7t+35jX96tVyJ/uR5C8okZBOGpQKXgDWXKL5puJibdjiQ42CqUZXWId
         BHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793003452; x=1793608252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/7TxP0v0CwRMpmnuZd6/tuNx/k5bWUFvFfdUCTCmnjo=;
        b=RoUTLBVNkmB1S8CUR7/ft9Veil3p9qWLXvU8N4IbHa7TyuAep7mqEK1uOGpgJFfsqI
         dL8InBsooVHu7byRQT/VUoUIuOYRX2n9DGx6maxp+/Xswlf2cvCJu+k3XqzWJuvPNhAV
         zTzBP0ZWqkPc6KseFTEtOAQAVr6BRbjxCbVzjscKBwzk0FYCWJly6SJqFl7SNXxJnGi4
         vlE0D6MLrTsAsFla6rH04l31LyqL820hMgaZTreg5DtwRILsU3J2unADE1GYwMxApOr4
         YBMLiBs239WIx7hDMrIDjfDQgVzdAI8gOci2ITa3QBu4XE+dHMZG9dsqa0F/PyXE6/Cs
         HjBw==
X-Forwarded-Encrypted: i=1; AKwUvBxHrIZ05IfQDkNE9iJXNdVKnRG+VJkAGnQiGNI8jaQWIkwrWwB2C7Ew04NgqkdpMQAeJlIyJ5E=@vger.kernel.org
X-Gm-Message-State: AFq9FYL9WLhEHs2mPyk3VeUxamdYVPzOx0D6QyYJZuL8/6oSryWINH5n
	rzI73iGvGwt4Wc2TJeSUqUg8+Tnu3iKLsbSNvJA4gqVTz7/nam5e9ItwN3BoFnWX
X-Gm-Gg: AYBFou2zfcYjJb2MuZ7goLytqDXfcylAR+EaPt3u6gIvcG8y6EkXBQrdOFPHaGWMVNT
	mDvaaMrRJo6SHCpSC0IzLre/+n4PpcORVg4UVI9XcqSr7sTxZ0WSEx5daKKXUHXEzSuRP6SBNwa
	jkcKk77VO6Yn1VciHKiXDiDLMk5dWvrA6msuJDxrToHXQwJKUBWNIy1dlpLAPD/DaqDThZV5c6r
	LerRiWxe8+HFK8mju/NGghHGHZa1QBtL8qXOuIRP/69/qZi2V4q74KDSvp4AXdmO3w7pxp4b3I5
	Xn9LhnTXHjMihht/HITyeS5CcCtgQFlEUEeBXlYKLSqk2qfMmz85xpNWTF5qWdjYsWe5xifxOEq
	J3y2GxMV/0H1PcMCWbqJtK3UONrQTRu9Cv/PmLIV76yXUdbgx4anDia37e0A7am61Owifr989D2
	9qlYnlIEFixCzxWq/9SeI5Il6NYCKisEv87v7fbGar7yB9ShHAV73Dp2SFuUbmuXCOSPsRrCmke
	CER4zBSwqRBECH4Qu4hBMgSMPXLzGVNLK8JKHXF1O3ymGbbtekWrg==
X-Received: by 2002:a17:903:b85:b0:2df:9497:3c89 with SMTP id d9443c01a7336-2ea9c953f2fmr49737205ad.59.1793003451901;
        Mon, 26 Oct 2026 01:30:51 -0700 (PDT)
Received: from lgs.. ([101.76.249.61])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eac37ba924sm5584415ad.49.2026.10.26.01.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 01:30:50 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Azael Avalos <coproscefalo@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Darren Hart <dvhart@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] platform/x86: toshiba_acpi: fix UAF after IIO registration failure
Date: Mon, 26 Oct 2026 16:30:42 +0800
Message-ID: <20261026083042.3982005-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When iio_device_register() fails, the error path frees dev->indio_dev
but leaves the pointer non-NULL. Since the probe continues, a later
driver removal or a subsequent probe failure can reach
toshiba_acpi_remove(), which may call iio_device_unregister() and
iio_device_free() through the dangling pointer.

Set dev->indio_dev to NULL after freeing it so the remove path skips
the already-freed IIO device.

This issue was found by our static analysis tool under development.

Fixes: 98010f1ea0cc ("toshiba_acpi: Add IIO interface for accelerometer axis data")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/platform/x86/toshiba_acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index a0b8060836d0..7a7afae0fe45 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -3493,6 +3493,7 @@ static int toshiba_acpi_probe(struct platform_device *pdev)
 		if (ret < 0) {
 			pr_err("Unable to register iio device\n");
 			iio_device_free(dev->indio_dev);
+			dev->indio_dev = NULL;
 		}
 	}
 iio_error:
-- 
2.43.0

