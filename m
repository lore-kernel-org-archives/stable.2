Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C84750276
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 01:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784423317; cv=none; b=ZgUbgwKnnK+nBt2YhRr7lqD98eHnxrRY4cQWxzeH24q3i4vFjFaqfGyEixxCrxOdOShV8uIZaH302L4zjCu/zf4CX6V06v7L6i7h/I2t3PQZGafi144ECy7wRba8MVYoRPqU3mOjnsjQTh6FT3/yOAvhEGj/81cNnhT8vRnevGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784423317; c=relaxed/simple;
	bh=VKMEI4O3cVms7BwzrmdSd1LsVh53CDmsQOARqM14ZxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KKolzELb7AvWS9ndcCS3hdBE37KHJMu74Cm+cASFRnmoVFo9XUKjK9RACRbBCqjemfSdV1VRhNIPCp3gxvcqaxhpODnS6oVXBSsO7MRZv7mYnOcOoK+n0FV7lHISsmL65XuLKHqn5sjZ0eiieiwDKLsgDTouM4UKBYR1PvuNm0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQGJnYps; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQGJnYps"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c9e0b89e228so3589679a12.1
        for <stable@vger.kernel.org>; Sat, 18 Jul 2026 18:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784423316; x=1785028116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i5qdSIBDIbeiuMoqbVIlnag+bM7io+xc2WQjdX5cfZY=;
        b=AQGJnYpsF+TbtZcuVemrPizm//+iMZ/8hYcoE1VCnFl+NlWXYA8HBFFb69RSiONt4Y
         izcEi2lMbG16UmLf5/kIdrGinQsx0sfXLokRHW8CTmjMS1sZ0s6DLRgbVrWlJEj0LlIe
         slNEwQnJVFk+Z0/Ae8lyyFDbae2KlTnw7xL8R6KJDw7oRG8APYBjGpxdilCByPud7Zl3
         grVRUA6paUome1lz9pQt28hVs0OWimVnZqQcxEjOyF2Y387JuddF49xQTv+ww/tqE14x
         f/Ihb0zO+BoNlW5k/GFmVM7IOes+YGpeu2vEGb4u8ZkKWytsr1AFTKjGO0+r9MD8Hv4a
         2cbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784423316; x=1785028116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i5qdSIBDIbeiuMoqbVIlnag+bM7io+xc2WQjdX5cfZY=;
        b=s4kWqTp9gJUGASNcFD25PkwarYq2/4DxKGmcOYtxbuGDvHTY7fMhHdeaJpC+QkSC3w
         aVnIGBmORgGJlwuBZqLKp6IHXR+ZZelEcRNEYysshYRNxK26d554a+Wfi2AyJscD/4Kl
         khuFdG/qQRDsnh60JPohVi/r3gkuRNJn9Du7n/bN0MkX2dVfQsbeNCgT4E4MvIgLJWKE
         ODzjMGn8bpfIrExt7CTI31Ulgtp/1vnvh1fD2Xn2Tb6hnAje93SmeoYTnhBbqh7TIrV3
         I+Bu/tpbGSbq6/sB4cjmWmhlgMhGesp2dlDGdUeb7eTq4EH7MtsM8Lo6xv9Hhbq0Fa8E
         VUrA==
X-Forwarded-Encrypted: i=1; AHgh+RqvL4rhSasMcbqrTLoF1VMkG5Eb/sq69+QEHDVjQ4hSHgRB+iEir7Z0j0ytc3FaHFQnatjrJVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmYzXRMXjOutdZHce6tXGj3D71jJzal0Jx1a+Z/cNSxOsJ0M6j
	D3NkcQBKuTqngwc36W7sauc4PGVmbwtwalGQQNGq6WBoRLKHb23JKxvz
X-Gm-Gg: AfdE7ckHaM+YdkOH8+K3Vv9XMBb91iD7lu/0MAfXrVaaCE63AooPLiFAeWvLHdTnBkM
	b+pRmo3LNQ9LGzAVqgFuuDMISip2w3k0mPKgBCDDGxM6U9APY9W3ZajhjnwCxJoqegzRsl/y51n
	1oYPWknYHOzEv4ygBqeoeILPolY5qOOft6808CGGNaKxSL11Hur7EyWlva9KlOJyL14cguvAQIf
	yYkI1ThJB2lPNmXRnQ3yrFuJY79is7ka9lmmxMF+zUmolxqcDxSATiUzlz79zZIXevHzcR9OEkp
	gFYsENoRafG3WdQDYzhlY/LTR1Ug7JTmdxwltbqh7BcUr7ILBipUDCBrXo6cwa+0wAIfyQ0viIK
	NTc4KlyxEtGRQq4oDprirppkt94TMEGaK3W3n8kl5vmBEXv3TmyiGHR6foaA5X5D24z4Jj5mL/Z
	ezHtENcmwTapH5syTDZch1f0eEVRFTzor70LImyMW+MvZAu2LFwVxuGyFti8wlA4/080A=
X-Received: by 2002:a05:6a00:451b:b0:848:7459:5f62 with SMTP id d2e1a72fcca58-84c2945a902mr8415573b3a.44.1784423315683;
        Sat, 18 Jul 2026 18:08:35 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2af9af73sm3446544b3a.53.2026.07.18.18.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 18:08:35 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: Takahiro Kuwano <takahiro.kuwano@infineon.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>
Subject: [PATCH 2/2] mtd: spi-nor: sfdp: check the length of the SCCR map
Date: Sun, 19 Jul 2026 10:08:20 +0900
Message-ID: <20260719010820.1924739-3-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260719010820.1924739-1-sammiee5311@gmail.com>
References: <20260719010820.1924739-1-sammiee5311@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

spi_nor_parse_sccr() sizes its bounce buffer from the length the flash
reports in the SFDP parameter header, then reads DWORD22 out of it:

    len = sccr_header->length * sizeof(*dwords);
    dwords = kmalloc(len, GFP_KERNEL);
    ...
    if (FIELD_GET(SCCR_DWORD22_OCTAL_DTR_EN_VOLATILE,
                  dwords[SFDP_DWORD(22)]))

Nothing checks that the table actually has 22 DWORDs.  The length is a
u8 the flash supplies, so a device advertising the SCCR map with a
shorter length makes the read run past the allocation: with a length of
one the buffer is four bytes and dwords[SFDP_DWORD(22)] reads
eighty-four bytes beyond it.  A length of zero is worse, as kmalloc()
then returns ZERO_SIZE_PTR rather than an error and the read of
dwords[SFDP_DWORD(1)] dereferences it.

Reject a table shorter than the highest DWORD the parser reads, the way
spi_nor_parse_4bait() already does with SFDP_4BAIT_DWORD_MAX.  Failing
an optional parameter table is not fatal: spi_nor_parse_sfdp() warns and
carries on with the data gathered so far.

spi_nor_parse_sccr_mc() does not need the same check.  It derives the
number of dice from the length it allocated with, so its highest index
stays inside the buffer, and a length below two leaves its loop empty.

Fixes: 7ab8b810757a ("mtd: spi-nor: sfdp: Add support for SCCR map for multi-chip device")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
---
 drivers/mtd/spi-nor/sfdp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index d3d85b5d1b4a..6c9db103a29a 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -1266,6 +1266,7 @@ static int spi_nor_parse_profile1(struct spi_nor *nor,
 }
 
 #define SCCR_DWORD22_OCTAL_DTR_EN_VOLATILE		BIT(31)
+#define SFDP_SCCR_DWORD_MAX				22
 
 /**
  * spi_nor_parse_sccr() - Parse the Status, Control and Configuration Register
@@ -1284,6 +1285,9 @@ static int spi_nor_parse_sccr(struct spi_nor *nor,
 	size_t len;
 	int ret;
 
+	if (sccr_header->length < SFDP_SCCR_DWORD_MAX)
+		return -EINVAL;
+
 	len = sccr_header->length * sizeof(*dwords);
 	dwords = kmalloc(len, GFP_KERNEL);
 	if (!dwords)
-- 
2.43.0

