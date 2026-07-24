Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A60E56A
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 00:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784851739; cv=none; b=hpNRZOLRY+c5CmW/JEv4t5DPIcWgolwwP6bj17NyeAQYYDxUs7HgHxRG4Z3r0QXVf8rF2oB4HmcW9FXiMGygphIVZI7UAWXGzN01qTx5FKyLQRkY2I2FZhE828WUeQjlsgaQyQBEIM2JVcSFLe6OoKZGKO5PpJdBg/HEF2t3pfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784851739; c=relaxed/simple;
	bh=OF4euTvz9Hql8JYKKoh5biNS8RtwKAs/ME/rZeYZvqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BaizDQV3LoVuO0BmBsr1NB5nZzN9QRyvuTpfmQacfzVL4FGFhdFeg0uNEZ8eLMZ+OrNHpgq+0CS+YyqhL+qPcCvJly4/KFhm6/o1L5wGRxn+nUwl+YFU4ozQASponf1kXl6L204kzU0leFt2k/YChOt1UvqsyqTR4g/mw6RMdhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qPw0FSQB; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qPw0FSQB"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4954d383e64so7966695e9.1
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 17:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784851736; x=1785456536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nZEegZeal7l4AtR9CR5NVf2WTYyHtR0C/RY7KRHJhyg=;
        b=qPw0FSQBUhpNwglGQqX4CFE2SwjdBbxjCTI5It/fhtTEQLNRw5THmZBWx/FMkpsvC8
         THnD6Rc2F1Gblurd2ot2Gab8ErbcvfUJYlo9eTafyIcmLH7/UaPKrcrlB9zKXd9fZrWC
         E67F6Az+87yGE/mpYMQxA7Z4sAw2MfYK7bg9ylk7zE/DJVQONC9DVK5wXK754TYe2N7q
         RtYzfPG8NdT1BE2HphMxuHUaa5FK5KcasC9LIvAm2yWuSNlQVFy2rywGdG8wox7sOR9h
         wc+5Fj1OxAwvpMNlWbllzIqPD1kLnuPFzRkzMRBQflm8Cpn6mwLlqoEEanuhKTHDbxdt
         5yWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784851736; x=1785456536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nZEegZeal7l4AtR9CR5NVf2WTYyHtR0C/RY7KRHJhyg=;
        b=Q98xK3VNBqt6dEXCrOgK/tOT1ECOQpLROQTcvgQEr0ZNttfQR0uBWJ5Dqf0+gJbj2v
         PXKAWDTQ14NwfnXTOFl9KSIxJ0SoBxSqjoAJh5sDsWmsqZntyy48H5NaR3sptDWz83Uy
         7J+nzAWHsByxlQ6EddGsU9jRlpMJx9JrxTxUjPxFhGiEMoohyMDv8e8RfxlFZSPNMPgK
         UJXsDRdkucWTcjE8tio7IbnCQGG07fDH/FMizGpI+F7nUt9H1FMSZz2RHxvAyYUoowZV
         YpdppSOWoHSGLLLlwhhQgfamY3dmsNoFp2HjADXdSyAKS7GB5S1RxmKjs4BeC8022fLQ
         NHGQ==
X-Forwarded-Encrypted: i=1; AHgh+RrzKzZVWho0InDGK60LBNiwriQLk9jQOG/Ca6UtDWSDDpnV3ARWdw02zurbukjnZbaMmtXS7Mw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxefECzLZGpNuuQqdRqI7kzWVTniBn9xCwoRdrpwq5e+ixBI5DJ
	sLutdnbT+pVA/5MZcX4tGCDajVMkgtu238g95Y63Q1t/2sRbYnnSir41
X-Gm-Gg: AR+sD10V7Gq1DFSVbowZbQW3jKIF13tRrqFoZYBFfZGw3msj/QXDcpsiI63zlUQoxzz
	CEI1jMH2Z6c4TOhUTJdfKXn5Xg8igt0k4+fYm2+DOpzLIMztGlhOTFNs6lY05pNHqInKIx1qNMX
	Cg+QiqHPdb/zzBT37fXVCmPwydbOo92K29gniPY0pX4Aq8Aawtt0vzUWOhDUt7HzU93Ohgr1sVl
	HPpEn10fuKx6lQdP37g3lredIhJiRXFGTSRHUluG15H2voVQzHNdEn1lFC2/zWDb43lUVTdtzj7
	KysfVpwBQ/OKTmHkTFkD15IZCkTR+siGeQGcqFrOOWQfIrahnCsJ0cjRU1hBNSQRgcisYNoj9zx
	qlBPMKLtHQFzAWO9UkiEDsD0H5Zd/4T0Tnz41tL2SINtLEV90cU4yXmcu6hXRB4+mTHbRd8eepQ
	==
X-Received: by 2002:a05:600c:6012:b0:495:4d2d:82f2 with SMTP id 5b1f17b1804b1-49573d0eb3emr41533275e9.26.1784851736063;
        Thu, 23 Jul 2026 17:08:56 -0700 (PDT)
Received: from beelink.. ([186.247.163.143])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957afb4da8sm24786345e9.12.2026.07.23.17.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 17:08:54 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org,
	bentiss@kernel.org,
	linux-kernel@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	stable@vger.kernel.org,
	Sashiko AI review <sashiko-bot@kernel.org>
Subject: [PATCH] HID: multitouch: keep MT_IO_FLAGS_RUNNING inside the flags word
Date: Thu, 23 Jul 2026 21:08:41 -0300
Message-ID: <20260724000841.933327-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MT_IO_FLAGS_RUNNING is bit 32 of td->mt_io_flags, which is a single
unsigned long. On 32-bit architectures a long is 32 bits wide, so the
valid bit indices are 0-31 and bit 32 falls in the next word. Both users
take and release the flag with atomic bitops:

    test_and_set_bit_lock(MT_IO_FLAGS_RUNNING, &td->mt_io_flags);
    clear_bit_unlock(MT_IO_FLAGS_RUNNING, &td->mt_io_flags);

so on a 32-bit build every report and every sticky-finger timer expiry
reads and writes the four bytes that follow mt_io_flags in struct
mt_device -- inputmode_value, maxcontacts and the is_* flags -- instead
of the flags word itself.

Before commit 46f781e0d151 ("HID: multitouch: fix sticky fingers") the
flag was bit 0 and the word only had to hold three flags. That commit
reserved the low eight bits for per-slot state (MT_IO_SLOTS_MASK) and
moved the flag out to bit 32, one word too far on 32-bit builds.

Put it at MT_IO_SLOTS_BITS, the first bit above the reserved slot range.
The value is only ever used as a bit index, so nothing else has to
change.

Fixes: 46f781e0d151 ("HID: multitouch: fix sticky fingers")
Cc: stable@vger.kernel.org
Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260723224211.613112-1-you@example.com?part=1
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
This applies on top of "HID: multitouch: bound the slot index before
touching mt_io_flags", which introduces MT_IO_SLOTS_BITS. The two are
separate defects with the same Fixes: tag, so they should backport
together.

 drivers/hid/hid-multitouch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index a75c821f7758..e7d811ed4123 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -99,7 +99,7 @@ enum report_mode {
 
 #define MT_IO_SLOTS_MASK		GENMASK(7, 0) /* reserve first 8 bits for slot tracking */
 #define MT_IO_SLOTS_BITS		8 /* bits covered by MT_IO_SLOTS_MASK */
-#define MT_IO_FLAGS_RUNNING		32
+#define MT_IO_FLAGS_RUNNING		MT_IO_SLOTS_BITS
 
 static const bool mtrue = true;		/* default for true */
 static const bool mfalse;		/* default for false */
-- 
2.43.0

