Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA6937C0EB
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 12:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781872074; cv=none; b=hm5q63vv2AAf2qbQzSapDJ2FUqd9xq7zDyvKHF9PCw9YdbouEKY08P4Rpz3LZi3a1XJiQhvy5cb0B2Hq869K52/yUx9+gPnxJh/t4GAGFfNc8cyRCFkuRqtwXtNnTFy3qoeKrHcjCLjr2b4uyN2Gw0tWHk6vtSv3hdyXKcIsHa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781872074; c=relaxed/simple;
	bh=wZ0BVCkZ6ce5isOe/jcnLSQv1d54qdYvKIo0gvE3qfU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WpcnGBX/sngTodpeXzJ44Gb0iJiPh/K+RmEwS6s5nrHTGsJtlSyqVD2ztDwJNn25NlrkgBiWhLQTzsAM6dxbdcIByZXbYPEfI+pJ4Lo2v9XiQvJW9i22LNdC+Ib5uVa/DIYyL4Y0+fRhSeghte+u/JUuGQhnQTk2kUTllMFCOlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmlIvT/p; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmlIvT/p"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c6d4851142so17785415ad.1
        for <stable@vger.kernel.org>; Fri, 19 Jun 2026 05:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781872072; x=1782476872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6I4kwZd7kXRIlQDpaVicdpgo0wsKxK42taTZCo6USLU=;
        b=mmlIvT/pIEwkANSROEN7tGxYcuND2XIyKJWY4NUw+x64aCO48kRKIBcF5Whx6PMMij
         tkw+4anyhSvh4Y+KQS0eFzG0p4eoLdWa5Z0AMeg0EuJSK9vL8/O02SYDU/WTvXvqwXcy
         2p4wdT6rSgVB+fb1e87ARhOoBRCQ3pI7ETi0MKEIyy9fAZO6FxDgs7jj6lMcTkZI4BLx
         8TGHjKCMTB65z3bfasiZK02dvCqD/fFAY4GRJ5mY7q+omjDdnW5biDV/ipmBIJlecZpp
         DMkELJIYyrHEXAcMxNAQ+4kJOkgnb3XLIWR9inIm99rVg0ca+cVYhQVNmFOAZg/mSJiy
         H2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781872072; x=1782476872;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6I4kwZd7kXRIlQDpaVicdpgo0wsKxK42taTZCo6USLU=;
        b=PYTA30HwVliWKdGKFynC1/eRkwZBs2HD3bdtojUIG6J4Gx9nBOjAvzJwaz5IuHanKJ
         DFa2uEfWE4bGj8/jmtUcmEPwyR1TcJCRnQf8l6DDLaSLubs9pAPqIGg9ds30It4qhyLo
         6yetJ83x3td6ATWydEVDKLM/eEcaEvIub0Tfl3EH7f4f1CsjwSva8zjQfh0Sdg+7807E
         JGjbkqvmGWVORuXfXCvVxTwYmRSaGVdjvF/u+d+yG30qluE2/ZTXcsZ4/cic6s3o9HYo
         8Oz4bfqL0PUTN7iOEMWVwPagsjO6Uc9emx1kTrX2fAziBEsKQpMJkpughhQlaNaOgJ4h
         HMIw==
X-Forwarded-Encrypted: i=1; AFNElJ/mMuNw1XH2N4KYwZ/Ma6KJEQlVnU9led0kkSNPPDiO/JiKzvgvMeSTE2FTuQeIxL1j/g+G4gc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1xnK7BSruKLg+SE4mIEw1hIXId29ymz9N21jlgovy7X5Kjc25
	2Mp/iWNGQtfLRPkXSEXw0op3gznNDiwDBIgivD1bqmpo7rJmgpdWKqYQ
X-Gm-Gg: AfdE7claS9mNpZwvOvBb7sZa7UMv2sbmGy6sxD+t/HPUH1ApZTzvfA1KrGy9xTqTy9N
	npz4IpHn5EYMRM1tKK+/tgLfMKZp36/cWVTYXbCANCgK4Jr5gLJP4GH5OLMDUf7I19OTdtw9dHb
	dWowWUPXLrat/svoIhSwpbfZbY3b4ynfM+6vdu2LsJJ/KP0Pkc28dQdbvLQMn4rIC2E3UT1wfEQ
	ckgJ6lqTZsDZflTPrcnP+8ZL0FEIYPph8atszbl8S+M1Q5Um1VEHU4drzOYNF/PvVO+/pEp7qk9
	mWSI+HnfX5WMdUWnxF4qAYZh/fqFW7ND/gHqJNsw031r8E6uknNkn8XQ9CqPU/5SFvR6tA/kDG/
	DemmGccuakwuDpFMzZ50blMTjp9eCe9pEQyE0yPpR2PqNkVcZXY5vqorN/UTiN7geHiq3mxea5o
	xhPaqBXkd1K1aP1DOulYg7XLYCRaOZDgUNNMIKDNP2ysCU8xuCdFL+PcpAV1sVeocdy5EC9EcW1
	3eHTPHnrtMJou4l
X-Received: by 2002:a17:902:d50b:b0:2bd:3c21:a053 with SMTP id d9443c01a7336-2c71961f2b7mr26944005ad.24.1781872072091;
        Fri, 19 Jun 2026 05:27:52 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7209bc296sm24046885ad.49.2026.06.19.05.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 05:27:51 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: Luca Tettamanti <kronos.it@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] hwmon: (asus_atk0110) Check package count before accessing element
Date: Fri, 19 Jun 2026 21:27:46 +0900
Message-ID: <20260619122746.721981-1-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

atk_ec_present() walks the management group package returned by the GGRP
ACPI method and, for each sub-package, reads its first element:

	id = &obj->package.elements[0];
	if (id->type != ACPI_TYPE_INTEGER)

without checking that the sub-package is non-empty.  ACPICA allocates the
element array with exactly package.count entries, so for a sub-package
with a zero count this reads past the allocation.

The sibling function atk_debugfs_ggrp_open() performs the same access but
skips empty packages with a package.count check first.  Add the same
check to atk_ec_present() so a malformed firmware package cannot trigger
an out-of-bounds read.

Fixes: 9e6eba610c2e ("hwmon: (asus_atk0110) Enable the EC")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
---
 drivers/hwmon/asus_atk0110.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hwmon/asus_atk0110.c b/drivers/hwmon/asus_atk0110.c
index 109318b0434d..92afb64c09df 100644
--- a/drivers/hwmon/asus_atk0110.c
+++ b/drivers/hwmon/asus_atk0110.c
@@ -1037,6 +1037,9 @@ static int atk_ec_present(struct atk_data *data)
 		if (obj->type != ACPI_TYPE_PACKAGE)
 			continue;
 
+		if (!obj->package.count)
+			continue;
+
 		id = &obj->package.elements[0];
 		if (id->type != ACPI_TYPE_INTEGER)
 			continue;
-- 
2.43.0

