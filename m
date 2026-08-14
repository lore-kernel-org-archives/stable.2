Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34ABF3C943F
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 10:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786702040; cv=none; b=aPgKlRMQ+6nkoDuQZOg2/wMIs+4csJ/f+Ab/e5i7es/uaWu0nwr6aOHF9JKDBLqQMcU/rTG41KIEjOuyTOCnRC08FN4hWUEx5FDiuqeuEnLAY92m8pvcKIf7qGUei2f1//8GGrl2I5gBx3dpDSucz5crxL+2kVZnnUxkIn52kMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786702040; c=relaxed/simple;
	bh=hCXudEeCSnCZtuAi3Cht+1XCrfbVixEB54WT/2J0Tg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s1PSEpCT7zfvlIk2LhUqtRaBWErEr1ZlczEb7NnVvEG8udn54lx4tBt6R5RPEcxaBLe8Rh5t1LbNN/trS06wIhcqxN4f9pbWf8IGXN5t933OfkefG4R9q4lRhiZl72ok5+9kiw4/nTBNmC0wGfFgnulX+jz55C5XnTrl/rZt8xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=HsNkhr9N; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="HsNkhr9N"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47c2ae992beso62150f8f.2
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 03:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1786702017; x=1787306817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q5u0s7u8HMkYvb6p5iR8GlVo0PrR1aZerYcIC8LuwkY=;
        b=HsNkhr9N2SWojp9CEtlTra7dNCKn+kF3oAWenytNJ54yTyNqk+6BiBLjJ8CM3/mVZJ
         pYepJDD9QPkSP05U4f2Jm0Mo1ShrKdPm1DaI503w8MMSiOfnQWB8In20d02D1w88LQDB
         +B9N8EOKB5ZWdHeVQwRQk8CvJV8me7NO4wd4dGGBFxisGUlLy2lrJfAITJRBtz9fiTGA
         c0dnZhy9UKlHPIadkZ+WBAvV8mO5lN2jKI18P13JTby/RHpoTaCYnDC+m7Dzwm7MTzyF
         Vs/Z9egWnSqII6lVVDUIf9v91TLe+RX1RSqoIQWOnerC8N6chVVyB1R848iPV9IMZvVl
         3sIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786702017; x=1787306817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q5u0s7u8HMkYvb6p5iR8GlVo0PrR1aZerYcIC8LuwkY=;
        b=K6Pjd6SEeQnkeJQzEvGdTiYuYBsxBeBwdYBE66xvvtLZm4NbAY6Thg+PqD2zcwzHpO
         1rBoKmRZB0rdZ2cRYvRaYljKd7EY7YO4K3QzrU5C4Ww80fxAz/ZlLBTx8bVH4KY3nNi6
         MUZRmgFbgZyrD3dDNyR5+TjyGRPEcsqne49jf8SxtAa5iFcUCbmMutDZra4Xst3du4po
         JNWMdwecGwCd91+/Fcg48TZA8/pI6V+1H4XSkcPzY71XtY2Wsob6DS9SFv2+cplRMaga
         McodkNTUu6uVi1hvyC832jILejFxDElwMwrAgyff9gBXBawyYkNr7Xn9Loj4OlRqJE+6
         OemQ==
X-Forwarded-Encrypted: i=1; AHgh+RptB/jJCSFopxwI9ji/hA+GS5G3cXlzyZsyJ0J312Hxr9aut+dOHyHftd0XUqpRoWXw8dJIzQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0nGLwYUoFZaTRhrN/z/phf8MRuQ6fT44tJk5xq0P4cgDxBmJn
	fWuTxYH8pZvkVtJ0s6l4X1LOawjoiUjmteNFvne1e4qg13bXrwSAlhoz+LaUHtCRAgk=
X-Gm-Gg: AR+sD13wY25MYLfQMXEJhtNPnqW7YBV65cSxhHDQ462epsWQUlB/yvVtYbWne24l68+
	1FKv5jupviwg65bp7JrCEwZ957NQ27m05eL7QSr25xsc6+ieSKVx5U/9Uc3o1Dm2ulH911scdkE
	ceLZoni8zZPdc1v9cPL8KB5tV9A+DXPTUbPHq6bZ37vHunJlKq83f06ZdVT0Yec5K+xt6PATret
	H28FwlvGJrs83hf/E0JhqALEW4HF7PFfXcVzwojjuwcs6XB6iaPMPu1wmhOvYmcJ7NaihJUwWFa
	GGOaX35+Xa0Lmz1kzQMedBazJ2yZqaDERnc3JszupBq6KG6taBOl9ObUpiflsQJajTMukNXoIV3
	1vZ8N80h9Rap3CLBllfC5GOYzrWbZMJiQgk5BIR2pc5sWCEPCs3qMdBuG9No7XgnKIdXjTQ8bR8
	MouaQe8BRgGI1SvqvPL/QFGraiNAQFqHfHUrtLXamysQ95XrIOwb1rXsfsW9rS0dLdIyvqJ7xGs
	62NRbOcUexWjuvdQy62sg4FubgrkA7vLOE9
X-Received: by 2002:a05:600c:358d:b0:493:bea7:6b67 with SMTP id 5b1f17b1804b1-49987960f4bmr38786685e9.3.1786702017530;
        Fri, 14 Aug 2026 03:06:57 -0700 (PDT)
Received: from jwang-ThinkPad-T14-Gen-6.fkb.profitbricks.net ([2001:9e8:144c:bd00:56c3:670b:dfc6:d046])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2b1d9bsm6948207f8f.24.2026.08.14.03.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 03:06:57 -0700 (PDT)
From: Jack Wang <jinpu.wang@ionos.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: dmitrii.omelchenko@cloud.ionos.com,
	Ashish Kalra <ashish.kalra@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [stable-6.12 4/4] crypto: ccp - Abort doing SEV INIT if SNP INIT fails
Date: Fri, 14 Aug 2026 12:02:57 +0200
Message-ID: <20260814100652.225499-5-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814100652.225499-1-jinpu.wang@ionos.com>
References: <20260814100652.225499-1-jinpu.wang@ionos.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ashish Kalra <ashish.kalra@amd.com>

commit 6131e119f5799bec55535530fa2fc44f5c7be1f1 upstream.

If SNP host support (SYSCFG.SNPEn) is set, then the RMP table must
be initialized before calling SEV INIT.

In other words, if SNP_INIT(_EX) is not issued or fails then
SEV INIT will fail if SNP host support (SYSCFG.SNPEn) is enabled.

Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/crypto/ccp/sev-dev.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 6e08378eb5fa..d6a0773d6da8 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -1118,7 +1118,7 @@ static int __sev_snp_init_locked(int *error)
 	if (!sev_version_greater_or_equal(SNP_MIN_API_MAJOR, SNP_MIN_API_MINOR)) {
 		dev_dbg(sev->dev, "SEV-SNP support requires firmware version >= %d:%d\n",
 			SNP_MIN_API_MAJOR, SNP_MIN_API_MINOR);
-		return 0;
+		return -EOPNOTSUPP;
 	}
 
 	/* SNP_INIT requires MSR_VM_HSAVE_PA to be cleared on all CPUs. */
@@ -1357,12 +1357,9 @@ static int _sev_platform_init_locked(struct sev_platform_init_args *args)
 
 	rc = __sev_snp_init_locked(&args->error);
 	if (rc && rc != -ENODEV) {
-		/*
-		 * Don't abort the probe if SNP INIT failed,
-		 * continue to initialize the legacy SEV firmware.
-		 */
 		dev_err(sev->dev, "SEV-SNP: failed to INIT rc %d, error %#x\n",
 			rc, args->error);
+		return rc;
 	}
 
 	/* Defer legacy SEV/SEV-ES support if allowed by caller/module. */
-- 
2.43.0

