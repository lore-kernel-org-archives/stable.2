Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006BA3DAAA5
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 09:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785749076; cv=none; b=HWdW9m7D7TDTfLeyi7lKSo7nIjTV6mET/4FUO42T2LsfjbOdFSQgdamN/sRRPgKH9nm7JknkwqX+O6tnKQS40xzdKmoFiazT/fr8whVf5roHpjeaNbsqzZ2OxYF1+xEONLudJDYriGlB3Wl5CaUL99Nxu7Q8mtCRK9MnNTS2LxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785749076; c=relaxed/simple;
	bh=dkU4Tw0yAuLuGOa79nc/r9FpS2/pes1r5ogzZx5MrtY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VwJ6FVPtOc2El1S6sacLeIQmR2ffwnXd6bHgN3Xb57qifx9p9j7nivPa6Sq3LU4ukTWG8lgzdhJls0kOTEXKs5WC/pvDu5c3Vo5qsVxC4/+IBLpRRXGyy2T3tr4E2r4gUUFPjEoqk6KWkZR06ZZiHGsg3liYsaT91Da77RIQbGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kiepbW/6; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kiepbW/6"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4957952e0f8so2015215e9.2
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 02:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785749073; x=1786353873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V9QHkMFg6ACXXBOTXO2bQNyqADWHuSvYdeuTGK7GMdw=;
        b=kiepbW/6iz3NKPMDNUbwTXw+hbivgOP2Fqb8LV0vZqrkEblPIjesGaA09gdq9EjlXp
         WFUSptGaT0ILpKMRG075lY4BmtSZJ87p/gVuwoZEn84tXVPuUqkJ9svVYe52f4ThDQU4
         UA304C9v4qkqHBvjsy0naLtIqdbDZTLg8exvgIzgvaSuSnXUnivvJDckjvj3/J/0XUj4
         ClwcrQ5CbQ/WbYgM1PfFjGV6U+R3BzQnXCLTLDVh+asZRFS7WhhBdPHEkv0gMRuczdHG
         XHg5FEksL4w7qvjwXSwXmR9OL8XXqDZRTcMYFbV7UYeDrjOjMnW/ACCzk6g3vn/lUWVg
         zWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785749073; x=1786353873;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V9QHkMFg6ACXXBOTXO2bQNyqADWHuSvYdeuTGK7GMdw=;
        b=snGcsrU2xgsb7ECWTh/j7f+YLBsQrZUDi/bXiwWBsm2yjkx8M5tcr1cYd7dot1NL/M
         wC9ZbHHvC0Iy9RpmOgrnmmdPHICf4R47PmgwNhanet9BXYotxXIcxnnoPvR+UssOKvuo
         XGlK0wjUbpn1roxGRJRajNpX1pK+HMFFBHOhwO+ZRdwuxi/8kqnhMvylQzyy533vbMbT
         c+vsCWNkS8RQJuw2XBeiNJNHTdCAbfJPIJbeutBg0xZ95cMYpuKpfOzLgCFmfXPwc8MX
         zxij5z5Mj7cwgBCM3yzkp6hMbfXSZdeLE6TQF2Eb3Glq5VwLmSgbxI9Of2qxzse6z1Kp
         2/zw==
X-Forwarded-Encrypted: i=1; AHgh+RrUX3tgav0eKrGz+BBi4RUSWu75Ok0wmQnl75vuU6I/suu5FD/L2zIGvTtzQxmc66nlIodU22M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw13lx7HNu0W8V9BEczdkKXE67uzVD6M7R0pyBZqRCNy5g42EaY
	AeHrXWQkAVoT03uL6gR4PHHLid1ooFqq0KexZLVqLIbwETwUR9Hw+gQP
X-Gm-Gg: AR+sD13y+PFLZQAr2Wwx3gEDkhM7l2aRgVW97VnfU6xgXvJknjOSoFoDAsIv8VG7qoM
	XxxM/yreXBy9bWnbA07NImNF+3xw4sy7MurettoofBFzkVaoZSzS3vSlJhf4iFFmRUR/xM9ZUYC
	5c9Ee9B4ByL1Fc5XVj5Fg5UekHXAVdQVq5p3JUQxhmOY3IRC52Qifkc9rktMNQmXWPM/dBwLXCj
	1C6LYYz+X+VsD8maVEe4lr65nZZfDP+IPEQ715NDVwiIaCmn4XYKBH9/g70jvhyiAdvsXPIl+BN
	eeUPULwI87RYecxU7v4VvTDNrMiHcQ5vOTamDTwdA8tyUPiptlxUwq2VPNJjF4hs3KdZBO4HPKJ
	GuE7yvPvXC5EpqEHK6mZROMo3Z71DuHbSXUdCji7X/w1eNHLNO9S6xTHnFRJnGfR4t32SFsmanR
	AhhXj3Wi21tOb98ni+HMLJ0bNUFDx1bY0kOu112+pXKoboN18GanbtA8KKdd5AQg86GkSbwfNew
	trROhU74F+ZDbr4AwZ5+gM=
X-Received: by 2002:a05:600c:840f:b0:495:4840:c6b with SMTP id 5b1f17b1804b1-4980c656b36mr87800415e9.1.1785749073091;
        Mon, 03 Aug 2026 02:24:33 -0700 (PDT)
Received: from thomas-precision3591.inria.fr ([2a04:cec0:101e:c128:4719:1287:c5e5:152c])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49807b5b4a2sm250009655e9.1.2026.08.03.02.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 02:24:32 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	stable@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	linux-integrity@vger.kernel.org (open list:TPM DEVICE DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] tpm: Fix barriers to prevent hwrng from activating during resume
Date: Mon,  3 Aug 2026 11:13:24 +0200
Message-ID: <20260803092240.18348-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory barrier is placed after clearing the suspened flag so
memory reordering between the wake up and clearing the flag is allowed.
The reader of the flag is missing the corresponding barrier.

Clear the flag after the memory barrier and add a memory barrier in
the reader.

Fixes: 99d464506255 ("tpm: Prevent hwrng from activating during resume")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/char/tpm/tpm-chip.c      | 3 +++
 drivers/char/tpm/tpm-interface.c | 3 +--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 12b7394b34bd..7f500797b7a7 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -173,6 +173,9 @@ int tpm_try_get_ops(struct tpm_chip *chip)
 	if (chip->flags & TPM_CHIP_FLAG_SUSPENDED)
 		goto out_lock;
 
+	/* Ensure that device is fully resumed */
+	rmb();
+
 	rc = tpm_chip_start(chip);
 	if (rc)
 		goto out_lock;
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index f745a098908b..2de12b02f62b 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -474,13 +474,12 @@ int tpm_pm_resume(struct device *dev)
 	if (chip == NULL)
 		return -ENODEV;
 
-	chip->flags &= ~TPM_CHIP_FLAG_SUSPENDED;
-
 	/*
 	 * Guarantee that SUSPENDED is written last, so that hwrng does not
 	 * activate before the chip has been fully resumed.
 	 */
 	wmb();
+	chip->flags &= ~TPM_CHIP_FLAG_SUSPENDED;
 
 	return 0;
 }
-- 
2.43.0

