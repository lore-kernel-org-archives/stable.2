Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794991715;
	b=sedka4L1OI3CAnxwENcGEn4CELPrj8vkRfq5V7keeyIMG1pGz//H2PIWhx3xWSXp2QLD
	 1byDrRgwymIHKM5/n3v1q64qj8idkhrY7JEWU97FSJ/l8g/DuYN/Zad3sMXZ0/vr8ECNI
	 Pjh4C7OEZ6ujh8V+jIPotg2hjeS5WBO6OC5g6wN9e2u3m7f0ATQFGESh2OM9CVovmOA77
	 xMR1rPqwym0zwnQA4Sr8d0RzArxuvAqkssi/gsX8UxdB4ApBuehLkZRy1USPQQ/irC1cd
	 F+oz8RUuu7qKrh03tlIvM8CNIP84kpS24XrQAjvuxdDC/OMNTfzg34PyXOtaUNq81xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794991715;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Q+ekdDiad6PVYgqJZBRpDmNvdoTyRgI1QVONhVWIfvU=;
	b=XEI85GysZkM714QMdOnuj0WLOTXO8C17x490a6YI/vCsDnSGA9T/W/ckhp6C78AsKRpz
	 NhfVdASkh6E/qJH9lInfbY2ty+G3JaULuJojLexOD6QkOHbKavIvNeqACGev5d/z9MRpc
	 nCdlbvwNbiVXpdH8W0B6yc+TEa07+ezs4YBxjdpJHLtBs4KM3URZ7ZzTrujud1Rw3BQE8
	 3ciT57/W9XnrD7KkZxHOaM0yMm5mEgOC5H7r8QBG7sgT6K6GnvTXyeV9mqQKXZIsYNJxw
	 MBvSabR9bqhQNowlG4sGck7+HGytG24Dh1g0sca0xvQo9wnAY5GcEAdpLo3UCrICvJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LRYHGcb0;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA295606A32A
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 08:48:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA295606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LRYHGcb0
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cddac941ed1so291952a12.2
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 00:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794991714; x=1795596514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q+ekdDiad6PVYgqJZBRpDmNvdoTyRgI1QVONhVWIfvU=;
        b=LRYHGcb0BVwaI4rBkAYGfCcsjbX18pmL4QUbFXyJ51hzJABmXTJXeCsrQgitXrR2Qk
         3luxGHYiaGK1Px/hZUXlYx8o2KlAFnWcqDOIeFue8mMxAJGcAQywoRqnMRERXRhrKby4
         9lc/UY4A63t2KrvRwTKZFtp950YXVd1UQtlAK78fjUB8AdMPASPWvay7ahKcBsJf1I97
         YyM3blXYiCFzFdRT6mKquVAfQvH0SaqZuWXLW90ZEO7h0Xt8VGnG0Rfg3DjVr97AA7KM
         SoyqQQOer6DSvq6hRCX0OuGQ+PUGXwjfI1jQ5MTDe/SdnOB+r0wBK9hE6ghxcqK2hunV
         Wfow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794991714; x=1795596514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q+ekdDiad6PVYgqJZBRpDmNvdoTyRgI1QVONhVWIfvU=;
        b=ze9sbqHOfeYgSc0cXAUK2KopIK35UoEt7bw+pj6ax5S4/PlHqxWVSNbhh9zkA1coIJ
         aY0LQSlU+t139gDvy9vqdhbQNVK/4+aLQpJpKSjoTstdcdaVJmWE2ZCXOKe/SzGVuhGx
         2Hp3qgVaXcin+Me5tWo/0bygCI0XJy9eQpM40S3kPoo72EOTgvLnh+v6QBkrJb2UM3NV
         WyTRmNXQpGc75cRYjP9UJuULNdKBPz9HNQSfp5LF0LQJzydXgYV7FkaQY9IqxSyKgWW7
         6JrIfLU2M3TIamDJDxgSWFjMev32rOxQOLuLG1Ja+nfb37uM5t6lIQUl2Z2pfr12RcUQ
         Bhgg==
X-Forwarded-Encrypted: i=1; AL+hErGyd9yxWXvvwopp7IyC9UwcgG9lBSd/tnYxMiMm2KYAr4VXdt8hiHGKqy8G240ZuTKHV8ClfBQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z++OWd6loSjISeSKSzpyZ09enDSxcMnkokIU5Z0eYVckNha+fZP
	j73IZpSSFDWPJ7JcQQ8/M19eikTk9f+qY1E0KzQv1aqbm/g4Uav+mZ5z
X-Gm-Gg: AZFdTZd7I2AnRAhTYDuM/cbt+aCAaba6xie+wYjvLVQdPn2l7LH7TRiTxtEXATlX5GF
	SNNUyEPa8BmzYzJPisfnNocAcAvHiKxbLG01lieDyDz+hPIkYjlLsddA8rDnMUXJoxO2BVcKJcv
	kL+Nquz7SHpXjUlWfjJ+JXF8ENX7CMgpM8apcJ2XmPUMGnjAKks5ATVZvle0FrOLEFHVuUEaPq4
	RuubegEYN1ppz3RQWg3BXlZObyKW76rLtNxaS8OLk6ed6SgIheiUF+gPYVQD0VBPkmXiLI9yVav
	BQyjT6Y/OXExN76CY7bi4OSVe0iTmyq6tiTgkQz/ilJ4vEYSxsyh4MaL6mhTZ50Vi6hWSDXWdTC
	Trws5YPzGxjLCTpPsC2H3sAJ+srItPlAIMl+2xgJ+eR0K6BaKZG2hKHMkSqD6uTxFlDcejQbU9h
	GMG/cwzvKnPFLl58gV1fJ3WGVBgwvcjPkRRo/KiLuHlWQa4F4m+K65tCeADNQpBNnakGpZXguMR
	PGZ2FvFrkUobH5oPYtKiB+giPmq+iyKhSOGHlu5VCJHSM/h8XV7KxV4C4xt+LQtgdxJOwJlHTaR
	7s6Ncuu0kBPLlUMkt5Xludp/MD5PIHNULNUZj+F/ccfLzj80
X-Received: by 2002:a17:90b:55c7:b0:3ae:521e:767f with SMTP id 98e67ed59e1d1-3b3d07c6895mr1757056a91.36.1794991714172;
        Wed, 18 Nov 2026 00:48:34 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3d56ce9c4sm1079581a91.3.2026.11.18.00.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 00:48:33 -0800 (PST)
From: Hyunjung Ko <hj351016@gmail.com>
To: Eddie James <eajames@linux.ibm.com>,
	Ninad Palsule <ninad@linux.ibm.com>
Cc: linux-fsi@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH] fsi: master-ast-cf: don't sleep in reset_cf() under local_irq_save()
Date: Wed, 18 Nov 2026 17:48:24 +0900
Message-ID: <20261118084824.936702-1-hj351016@gmail.com>
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

fsi_master_acf_terminate() calls reset_cf() with interrupts disabled via
local_irq_save(), but reset_cf() uses usleep_range(), which can sleep.
That is a sleep-in-atomic-context bug on the terminate path.

Switch the two 20 us delays to udelay(). reset_cf() is otherwise called
only from process context, so the short busy-wait is harmless there.

Fixes: 6a794a27daca ("fsi: master-ast-cf: Add new FSI master using Aspeed ColdFire")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/fsi/fsi-master-ast-cf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/fsi/fsi-master-ast-cf.c b/drivers/fsi/fsi-master-ast-cf.c
index c3ac76bf7e97..787464c8b7f0 100644
--- a/drivers/fsi/fsi-master-ast-cf.c
+++ b/drivers/fsi/fsi-master-ast-cf.c
@@ -690,9 +690,9 @@ static int fsi_master_acf_break(struct fsi_master *_master, int link)
 static void reset_cf(struct fsi_master_acf *master)
 {
 	regmap_write(master->scu, SCU_COPRO_CTRL, SCU_COPRO_RESET);
-	usleep_range(20,20);
+	udelay(20);
 	regmap_write(master->scu, SCU_COPRO_CTRL, 0);
-	usleep_range(20,20);
+	udelay(20);
 }
 
 static void start_cf(struct fsi_master_acf *master)
-- 
2.43.0

