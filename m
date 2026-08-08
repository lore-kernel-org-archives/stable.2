Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C9C3451C1
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 09:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786182213; cv=none; b=LWKvIxxLz46NCBgXrGBm82SA7x01Fib8RnSt9Gutca8dfUkwmFDYIvoFSmawbal9Pshge5pCHRzI0OU8aWWbDC5SE4XS8/8W8eZ8MdJG0XKHggVHYaEL6VnZEZG8OCwyeMy2wcGkrnmE4G9wlLpqLP2kiJEZwfXZGHCtAtN6PCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786182213; c=relaxed/simple;
	bh=r6nfrHf9VWnHnAVX3pP+NYypBFwJru0XwFToKW5t2DY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P9EjyuSuz7bFcA5woD4thEfhC7bQXAUY01t5hvMwNbDa/bGl9cqhnYU+//a3QtteRVgAfluTjEM8Wc71zjhUkGyPXtSiyTFsOqffprJBwM0d2Imd0H9/3WIcv6IDf93ahfy8GdIV/F6P6zjQfEmOndxEQQNl7d/ZoSpyo8Ojm3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hA6gL1nG; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hA6gL1nG"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cace91f112so3526985ad.0
        for <stable@vger.kernel.org>; Sat, 08 Aug 2026 02:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786182211; x=1786787011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fDbi4zALnFhUD4L9Nk6WABMkAbrLbdj/pPHftS8rUB0=;
        b=hA6gL1nGLJwB0r6Ykkti04RzpX9yCIaB8wtGoSLqt3PKQG6gb1KPvSg+UWMRiCtltW
         ySLX2C2BnQcVwOCWPzrB4uZ9HM4Fc3NDKTpSbqGttN1xCxg7eJxSHreFx1tUpGRO2JcS
         JCFEr2CiGryD6k5i7ZmQdj8HN4LVOhjM8lQHDyL656AEWHi3LDFyyEB8T2fTOjn05nAi
         Ov2qSjCMbcG1O5+tZBY/zQv6RDIEfBvA7iXZ/gMl5MHF81hCW+f2lnnWHsLxd4nSjVmY
         4/Lkck8R1bzFhNEA5dTsVmd5SoUqA1Q4xOW/NeyOg+HJt6sGp2/hr1izFz8AZphOt9vN
         Euow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786182211; x=1786787011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fDbi4zALnFhUD4L9Nk6WABMkAbrLbdj/pPHftS8rUB0=;
        b=a/FAvnZNSeBUw221nIVx7LPQxEVqxt6wxTe5sgS85CQIaI1dHa2Qrp1GeRsvP/xkQX
         yeJPkNm7drA3/3wAKq/RO/5S9feOs41JQW/C3esaZBf77W5A1M2/MLJhi2LL9bCd1Ivq
         XXRm5p2vI7OroLpNcY43yDNYCu0YvuQvDfwwVnSXJ1pQxNPOw1MEMIeJFszBRW0R+yMz
         WeCZ3+wqwlYuP69bDZqlGceBYuFw/esVYtcXVbbstgzGCsZaR/YCyXAW8hBJkWcL1/q8
         qKpl9KW+Rkm+xM1ClvAIaLcL2fSK9cPxMJUJwf7KHPp38c0CSVE/8UR5rBABmlT6Xsqc
         N1FA==
X-Gm-Message-State: AOJu0Yw2nVkpD4Vy1BL8nhrt+IwlETNWILMF2lcINfqsHFqmQyCGaS4J
	K9yQXItHxz0CzwUUChfUgulH5sjtiMZBWfnJv6VJ2+r7rZ0ACwcm3eOJ
X-Gm-Gg: AR+sD11peb6sulTqJYigajPhO2UekaG4vmZjGtZkcpF4QD9npyn2rjD9z0ff8FQLFIY
	A0Fif7N5XnmUdl3DZTixFrfVlX2NVrXg86cyKu6lxKjHJ0QaHiyQP8RjNSIWgYGtlxTSpXge6tW
	rVcEAzmqM6s8svVMsRjCjf3Xv7X1iNmHVrkCECG+9qtU2qMLxc+QhxAaASbNP5KiW/XujMI9Dff
	ZtKu+HfD8xMsIlJEmRuzDTx2xpMrirxlh/jifpDCKoCHhD+AAMjdsuP+VEkR2i6DqxZTCTZqT9h
	B00ieNXPyxDTXleKw6NfWroQ6ZiXl4g8C5jL/zBOu5hFrA2Kbu0W5JnoCCOMTKXa7kCTruJoJx2
	cWCrr9G+mRTv1+ZB0XzrVFuvMv9GgWIjcCFMqwQL3tCHlWqNZMRDw0VlvCaD5BN6yCav/W1Oy8T
	9jRNhBu4wmSXzOZ05oAbqykNhVN5xCLieIOZPzYAiU6vJE6FJygQxWcg==
X-Received: by 2002:a05:6a20:b598:b0:3c8:f342:132c with SMTP id adf61e73a8af0-3cb85e99264mr35264761637.11.1786182211362;
        Sat, 08 Aug 2026 02:43:31 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe8f1b3eb2sm1707505a12.13.2026.08.08.02.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 02:43:30 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	"lionel.debieve@st.com" <lionel.debieve@st.com>,
	linux-crypto@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] crypto: stm32/hash: fix autosuspend cleanup during teardown
Date: Sat,  8 Aug 2026 17:41:14 +0800
Message-ID: <20260808094114.2750088-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

stm32_hash_probe() calls pm_runtime_use_autosuspend(), but neither the
probe failure path nor stm32_hash_remove() calls the matching
pm_runtime_dont_use_autosuspend() before disabling runtime PM.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during teardown, this reference is not dropped and usage_count remains
unbalanced.

Add the missing pm_runtime_dont_use_autosuspend() calls to both the
probe failure and remove paths before disabling runtime PM.

This issue was found by manual code inspection.

Fixes: 8b4d566de6a5 ("crypto: stm32/hash - Add power management support")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/crypto/stm32/stm32-hash.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/crypto/stm32/stm32-hash.c b/drivers/crypto/stm32/stm32-hash.c
index dada5951082c..12fa1a8f67eb 100644
--- a/drivers/crypto/stm32/stm32-hash.c
+++ b/drivers/crypto/stm32/stm32-hash.c
@@ -2456,6 +2456,7 @@ static int stm32_hash_probe(struct platform_device *pdev)
 	if (hdev->dma_lch)
 		dma_release_channel(hdev->dma_lch);
 err_reset:
+	pm_runtime_dont_use_autosuspend(dev);
 	pm_runtime_disable(dev);
 	pm_runtime_put_noidle(dev);
 
@@ -2482,6 +2483,7 @@ static void stm32_hash_remove(struct platform_device *pdev)
 	if (hdev->dma_lch)
 		dma_release_channel(hdev->dma_lch);
 
+	pm_runtime_dont_use_autosuspend(hdev->dev);
 	pm_runtime_disable(hdev->dev);
 	pm_runtime_put_noidle(hdev->dev);
 
-- 
2.43.0

