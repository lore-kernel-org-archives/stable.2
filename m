Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9C341A4FF
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 14:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785767494; cv=none; b=pC1nPtGxtgR3o/IqTEpr8xiqXWzH49NqdjWBCMOJD93Vw4kbHczciAlX1JvEXqY3tb4YUqg34iWkGjDrR1BTTT877vlTLDaYHNI4KNA9G5hJeZDGFOwm8n6Z2sL6Ud6ugA4V7pwQOUCN1QMCCe0LU2aYo+ttxaqgiyolIN/+3nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785767494; c=relaxed/simple;
	bh=bxA8J6/qIIfaCWTOgjW8WTYcWhqAJeYz4cR1gJwp01U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bk0B2Dbi/FhyO2Sx843iJrW9oX7pgqDfmbXKKv000ZgJ9fiW0cZuYCr9TUCnCggmI/UUtZKGpPsvWjkIc0Z4oFowdRSvYmb1qY7WwbRaazhg0nwrSmPPazPUPJdWZEB066ZxRnjfbAtjYaay/MAphYJquWZwY2HgBUDmExGorwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n75G9mHi; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n75G9mHi"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4954afac04bso25861235e9.0
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 07:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785767491; x=1786372291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aP3AzbHc5YQoHN80VU5i3zw1DBkXU+MO/jUixWC22QY=;
        b=n75G9mHi6Hk0eaxOlM+uosEL+Ab/+FyB4PZEH6zRgOTxBuKVoDALRfcpRj4v4BVSGO
         Rw+xjlNaUYmz0WUmH31ybt27W4BNEbrt62NB9QBZNkihfx/cmrlqzGFe9nY/H77o3YJu
         QoBwjiP2y3MI8vUVJT8cJZ1M1XqbaVSXqNs99TT0wLb6pMthyKctXLEN78IWLhZHFtUs
         gWmgrlHe1C9TgcvIJmk1my9csBypZluiiD9i7MaAvuKMYvJUrGajyQgPzc+klvLY+RCq
         npJs2J8kYeXM2kte4lqHaHKJwdElVkMeGzzLzK2WEASY2IMHUbbWJ89y8ScRg+YLk4wX
         7SPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785767491; x=1786372291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aP3AzbHc5YQoHN80VU5i3zw1DBkXU+MO/jUixWC22QY=;
        b=GzQPKRDgtMoekJ16o3qieKkG8CCZKFnmCKP4BtvIVwh/p8p1et6PMDQYf9kPVb5906
         hCNfiZKQC2ZlrnkSjHMxp/p8wyP80aKUh8Xf4PcdfxQU1uRXyNHXOIT5PapG+0S3mNU/
         recvz5HLGK2NGNxe/xSJ1Ab37f5rnc52cCBxMcQJ29QPItFDX5O3uHjxeAkSQACwOstO
         QZNsGWEJy23dJny7DK/pGiRNDGpNoRERxEnjTxTENbpMnqE5ObVVIBN/pxiJyEaicgkb
         CdHLyo7N/AvOvkishF9Lx4+24x2y331VdRevklxilnGzSmtlsoklGLhUzUB8oNCPsQUj
         qF0w==
X-Forwarded-Encrypted: i=1; AHgh+RrdR28yilY6PxJeYsmc7QXEfURTFVvk655Eae6Wr5KmfClGOuKVmhX/Yfpyc1Ftasy+RPRpnMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDwPzS55snNY2mn2Kzjo9XG7js/vj4AagaX51gnXXKG8c2Y4ls
	9ZyZagMGGajT2wTdE7SJf8dGT9+k0vQ1Cyhmh5FLq1lgxEqN0FNdS25vV7085kIWbiA=
X-Gm-Gg: AR+sD12TqRwLhnzalfU1RWvHTzj18P4TVIdX7SyP3yAcS04OX67ZEcnqPHGyAl94t2z
	M85Sxp3GNwPyf8GbVFmaYB6PuRBFWmZqBSISB+peWpzPnETPqXDrPnU01Bzm/lov0AE0I3bKJk5
	d5IFJD4V1nuCR+Ap9mTFjG8XcFtwtAMvkfwAPfv474ILWBpx9HyQOfmoTTBIQF7nk9E1D6ob49h
	nr5yXLAEPoNCF1MkBt7qy/28VVAGPr8RofweljGTgKLkPc+n9h5Qv224pSsDHtaXW/EUdHnINIc
	i/GObcwqHtNCns+kWU7Jza6jBkU+W8HlFlUDynq5wMYf0jKivYKK1RC+gHmGT++BZx2Qdqbse9g
	fKmnEMygpCrETWKMA3d1snccEWwkTUVIqBCUuow5Ee59BnK568iyQ2g+hE3z8LuXJWPozcivomb
	W6jeE/mNuQfkJstpp63OyLI/xsPjIXHI79HDJF8ud5BUuiJ0N91WpDJjXK3ftlWAt0ExEjkGWUP
	aOsm+gJBbVkIIVv8IlFsKVeho8/lSv4Ub9tsu5qQQ==
X-Received: by 2002:a05:600c:5248:b0:495:78af:78e5 with SMTP id 5b1f17b1804b1-4980c66c80bmr200642125e9.1.1785767490982;
        Mon, 03 Aug 2026 07:31:30 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b98284sm236575295e9.12.2026.08.03.07.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:31:30 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: jorge.lopez2@hp.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	meatuni001@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH 13/13] platform/x86: hp-bioscfg: advance elem past consumed array elements in passwdobj-attributes
Date: Mon,  3 Aug 2026 19:30:36 +0500
Message-ID: <20260803143037.93105-14-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803143037.93105-1-meatuni001@gmail.com>
References: <20260803143037.93105-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Same defect as the companion fix to enum-attributes.c in this series,
present here in both the PREREQUISITES and PSWD_ENCODINGS cases: each
consumes "size" consecutive ACPI package elements, but the outer loop
only advances "elem" by one per iteration, causing the next iteration
to misread a leftover entry as the next property and abort the parse
with -EIO on the resulting type mismatch.

Fix by advancing "elem" by (size - 1) after each of the two loops.

Fixes: 8646a3b5ee3a ("platform/x86: hp-bioscfg: passwdobj-attributes")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
index 6bd56d3f5bd0..9b989ef756ea 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
@@ -321,6 +321,8 @@ static int hp_populate_password_elements_from_package(union acpi_object *passwor
 				str_value = NULL;
 
 			}
+			if (size)
+				elem += size - 1;
 			break;
 		case SECURITY_LEVEL:
 			password_data->common.security_level = int_value;
@@ -367,6 +369,8 @@ static int hp_populate_password_elements_from_package(union acpi_object *passwor
 				str_value = NULL;
 
 			}
+			if (size)
+				elem += size - 1;
 			break;
 		case PSWD_IS_SET:
 			password_data->is_enabled = int_value;
-- 
2.55.0

