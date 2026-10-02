Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457221D4606
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 19:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790968517; cv=none; b=Gb2wAOX/tmdAECZs4rY/+6acWdizpB4T9+QIJOHlR0bT47zmsY4fl9yg9zvoUSEYDuKGw7ElBFJH4LaJ7fOEnzj2NiDaGAXi2ndO4hdSSXi5Eite23XE8QUoUpM6QGYreAhA1Mhg+VGNX8Ygg+XNWvA7pEBX/8hYMPHiGEeJLeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790968517; c=relaxed/simple;
	bh=le86Vs12P0V/PWX88/E32KKW09JygMIzk5c+9/KmSqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VlxrGtCvMlnQG1yATUzJNSvt7xMGaf0YiSNNSAvAfndSCqid4cqJmVQKxry9IP1Plk4cHNAz0Cz2/qBJRBFUV5WG9rtrSsudunVL/tZnXAqrAuTm1mzWE2OhR78Z1xs5CuvI3SnOnEceNV5C/ZpE/tc18+ZzALWasW1UX8/EPOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SiMFHAWg; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SiMFHAWg"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffde3cec6so1325825e9.3
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 12:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790968513; x=1791573313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pmp2yHqc8wcYY2dKL69Y4+l2VNO8tDlsDM/e1KEltyQ=;
        b=SiMFHAWgZBDwcKPgjzL6FcX9ts1QoukJEWiAa90aJq5wwt52SCsnQ1Yd3cSSYJKTtW
         3EGi0lcdL+CzUeihczFnqXHbSmaByF1frkUNtYGRBXBp9PzcGH+1JRz8cGtfKaFQxnME
         nPKe9UTzc+jMHEGZfxIki+OZtFx3LMRSrv1Mm6s5XVI86EZ021EKKJJMMp36KDPbcaYQ
         NDCjvxRyNjJ/THtzAirdxgEuraqEfLcJSbUKjH88rMl5xu/KJ4bdQyo6VPC7LtzZdfaF
         rShgx5/hOEmxRSFGgx12NMnyMzQbDM3HsJrz2SpzZ5+EaiP5IUsTFzpBRjNDvEAHJofr
         PqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790968513; x=1791573313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pmp2yHqc8wcYY2dKL69Y4+l2VNO8tDlsDM/e1KEltyQ=;
        b=DJDPo8fzNrhVPrscK1Y6xWbP0ch30oE3c8adE1ACezw76Y+1bsCNkOpLN7ivFLE08e
         GdipEJo2Q8wnnFL6YYok+OGpSR35/MlPi5NRWDgKxomDv6OxQLcKITErkfdVnXDohzL3
         jtyR3npUUZNa91x83bIteSOIPIC4XilS05o9VwMUG/7W++rh2c5tWsihjCkPq3+B2RlU
         RT5taKA3FoxpWOs7mWZdAmU9em0qP1KxKJs8KZfJNXjWKXfzB/6MtToi6dFusxXW9go0
         aMbygYBnswRH8AtIM68JsrPKdfHUBjo9xKB7I3buZPfKc5xXuZTs00Kk2Hc1lGVz9o2z
         yACw==
X-Forwarded-Encrypted: i=1; AKwUvBy9zLlxah/PYbuNwIl6s6j0v//HdhlXYRnaddoDLRUqIb2bmSn2C9H4NkwV3NCcdXQeu8gCtio=@vger.kernel.org
X-Gm-Message-State: AFuF++kqGgKkSoNvgoOVZVHNt0oclw5fIRFQoU9GQ7vQPExm0y2mcFwb
	OmawfcW7ESSoXeKmOQ8g5fX85dNjibCS29viavvspvdWfguywhqCVapO
X-Gm-Gg: AYBFou0B6jq+2mHGDCzuXEhfRXlFIuuYCATUSH7t1XvnG83WND7OU27g7gXz6Osx/D/
	bDel+WMODsA83zO7XRoUQY9Uyl1yX9kw526+NAhcxdZ/U2pcbTQL1Ufz3Dpk7hH8ciFtsb88Ipy
	Y9v5+qqG55oiagWc6QNKL1BfGoOWCc2kAe57vM9ApzdiUB4kRwsL7b91KgSb3mRCGSKPWd0Hj5R
	AvsfpM82ehyI+MUX69JuM3JRcOu8kEhjSjFI+Q6GKS6t5LtAZ9xEa/2EwZny8QZylPoJLcLfpQu
	dcfs0x0s6dF5GiGdCsygK3AuI1rCAIx/cXNe4IR0YlxfxPu7Ket0sZbtvY1yCr/8q/efUkgo6Ij
	nBRmItQLukjsWbLvCkJFNgM7mG6eC0iI1b+o2hMnl/J3UnMkMrjwog/thuCPA+y1jbX+FAFes/L
	0n3Hoe2unR2z3Akw6pmtx26g0vQoscgvoE4tZ2D9Nhi7KPFHiNWX78yXWyrL1xlJd9TStkY2wQr
	jN/JZijvm/kyt5ULr3/pZITfQARjDBi0ehd4BWDx39f5KWXQE0Sd4nmUZYsiSU=
X-Received: by 2002:a05:600c:6092:b0:49e:6778:c2bd with SMTP id 5b1f17b1804b1-4a027543095mr61406415e9.6.1790968513064;
        Fri, 02 Oct 2026 12:15:13 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0e1afbc44sm81151145e9.4.2026.10.02.12.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 12:15:12 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: Jorge Lopez <jorge.lopez2@hp.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 6/9] platform/x86: hp-bioscfg: fix heap OOB with embedded NUL in store paths
Date: Sat,  3 Oct 2026 00:14:31 +0500
Message-ID: <20261002191434.58529-7-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002191434.58529-1-meatuni001@gmail.com>
References: <20261002191434.58529-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The store handlers copy the input with kstrdup(), which stops at the
first NUL, but pass the full write size to
hp_enforce_single_line_input(). With an embedded NUL the copy is
shorter than count, so the helper reads, and can write one byte, past
the allocation.

Writing "A\0" followed by 4093 bytes of "B" to current_password makes
memchr() scan 4093 bytes past a 2-byte copy. On an HP EliteBook 840 G2
running Linux 7.2.7 all 100 such writes fail with -EINVAL although the
input has no newline, so memchr() matched one in the heap. A userspace
replica under ASan reports the same 4095 byte read, 0 bytes after the
2-byte region.

Use kmemdup_nul() so the copy is always count + 1 bytes long.

Compile tested only.

Fixes: 5f94f181ca25 ("platform/x86: hp-bioscfg: bioscfg-h")
Fixes: 8646a3b5ee3a ("platform/x86: hp-bioscfg: passwdobj-attributes")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
Changes in v4:
 - New patch

 drivers/platform/x86/hp/hp-bioscfg/bioscfg.h              | 2 +-
 drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
index ac57d6eab..77cb9cac1 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
+++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
@@ -326,7 +326,7 @@ enum hp_wmi_data_elements {
 		int i;							\
 		int ret = -EIO;						\
 									\
-		attr_value = kstrdup(buf, GFP_KERNEL);			\
+		attr_value = kmemdup_nul(buf, count, GFP_KERNEL);	\
 		if (!attr_value)					\
 			return -ENOMEM;					\
 									\
diff --git a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
index a2f50ecbe..6c123d7a5 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
@@ -93,7 +93,7 @@ static int store_password_instance(struct kobject *kobj, const char *buf,
 	char *buf_cp;
 	int id, ret = 0;
 
-	buf_cp = kstrdup(buf, GFP_KERNEL);
+	buf_cp = kmemdup_nul(buf, count, GFP_KERNEL);
 	if (!buf_cp)
 		return -ENOMEM;
 
-- 
2.43.0

