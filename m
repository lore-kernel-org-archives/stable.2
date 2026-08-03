Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F95E411FAC
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 14:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785767515; cv=none; b=qi0mZLdd4gM/itYgbbDqpuehFTF2ptF7sRqPfRxMAZW6O+H1mO19rzsNLnHdzpgy73eV08MozqLpKTrs0E34faap+Zedldl4Gu9XcyVItz2x+ORovxMp3HqYmTVf6KtsYGgDojplwPvJ9nohQZdQTR/WI0vDO0He+NeajHKrl/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785767515; c=relaxed/simple;
	bh=mbTl1m4q/B0mmfJqUSHx3puQD1k3DIBxLZfuWKkL4MA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qomuU5ReqZo4wehwwe6JRWBP5pLeO/CQuuAZrmbwnirf7xWnZsbnasFHD+BK9wJSNUPvdiWa6AokfchYqVHWSDd03NCTbe3ruOzW0rG9ZrTvHow7PTB/8iWYG2lPjuPOE9DoGFXrS6qKgvitD/cNUIPqq5pw66cc6eb25AjRTUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdjfZmRm; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdjfZmRm"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47f93b2fe4cso2135856f8f.0
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 07:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785767511; x=1786372311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zNxBi0gHfRrbC33pAvz30lhxp0rXTHoZRpmh1XXR2eM=;
        b=RdjfZmRmmBhZ9tsnpwBd6w8YUwgsN8ToL5Q9opJKUCBxXA14Hu6m+UtOzkiE7Tv2zn
         v/PyYdmFxQJMc9W2vwaNc91DVbscaQvpELa7M4aPxKINXZJ3R1FPxEE1dGn9HQ3aiPRk
         OQ4xR2R/R8KT5bOMRhM4ssv9nRFMfOSUyi4G60PEV61GtgBpqqKL2NvKjue04J6AEkJP
         JBON4dO2S3RLTKGNwH4b2Xt96drEk7UTEQ0hIoLZ/iyv8Co+D3uxMWczHUAaqVFuKlif
         eMxmXSDK4lsd891EcsfeQM7M/B1DkO55raFvX4c78fiz+A17iZ05dhpafsbMMCg7EixZ
         9pDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785767511; x=1786372311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zNxBi0gHfRrbC33pAvz30lhxp0rXTHoZRpmh1XXR2eM=;
        b=XZLvJQnuy7lAxBxS3WlSM8sltu2D3hof+QPAyeJOJIUxoji7DQxNfrsJrgpzzha3Es
         kfT8D5l9AQQgdEALqrSs0Nl67NKq1GhQ+dwqwzIGZLYt+d6Dbu7qiQ2/1IvBBnuSanRs
         chuXp9ai/cnZxsIN8rTFug4SioUXOI7HJbXE+M5PUBy+Wnspcp+eGwGkxdxgiYJ4yiMo
         ZSPtpzbiugX/2y9wRd0XHfnxFgggsyvt7xQBxbsShRKc7lvyGJw7vsk/15O69lIOwC+i
         2ArkofubUfvVEOfoHVUwj05k7jXMrXjeQmN38Yk4ab9AkChEj9/nDDv9ci7BOdfnDVlE
         JUiQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro066QelvqSPExMfg/uUoP32j7RexfE7iOk5s0oLJ9V9SsuLcxOzPDDYikFkBBzI3gEOQQB4CY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwROfC6lbf+YH5bRf2WRySs0b7GODXcJa/pNLpRPPh12jVJP/yk
	csdvuApHJ+dlImhc5PgWmcQRG4weGEqWKXkzWoBfnXZBQKYIgI+JIG92
X-Gm-Gg: AR+sD10NdK6pmiLaz9SRYzsHrZGFh1TqKhyQMV8+SFdYqTfhManrsxJVXiIi+XMXnmy
	+hz1LiidJjNBWhjbVN/CMxeoIGzj3d5lFuRt41xswoKbgzy11/ElZPV9QPNxS6P3FtJU15bGNEP
	V4F61AWg1MCyArWdBf67tFunsEssS7u8PvavcWXNO1cXjyAlc+5+Kwljrm2/7/hHr6kDPIZd6pS
	+Gz+Fbf5Wzt/yEEEq9utlocdu/0uGIjY2M/9niOLuNhkwudyZMCTMuWtn9rKjCooGhh4vwunNHg
	JLMoL0AfljUlTDSXpsxp4+kyJxG/Xf1wOxFhw77mGdr+j3/B6alfLU10cKLX3nx/VtZGvCeX+hc
	6uTv58zCkmBOq4EHCjeWAPak3N/izXyjHFiIFaw1bXr11oVWTKS3pMj0vMry1vZoe5E4Y4KbRfK
	n4Q0Vr2AIEuMU3ZCJ8tuV6mmjI2rQhR/e216v7+ljVc3GNwxKXwkBJvH6DxT5y6bdWTTFzgOetX
	GnLSt9LmVlbaJ/Hguae6VpcZls2vAD47S4A/8ygy0DazSsf1+RY
X-Received: by 2002:a05:600c:1d1a:b0:499:49c6:bfb7 with SMTP id 5b1f17b1804b1-49949c6bfd8mr2265555e9.7.1785767482896;
        Mon, 03 Aug 2026 07:31:22 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b98284sm236575295e9.12.2026.08.03.07.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:31:22 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: jorge.lopez2@hp.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	meatuni001@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH 11/13] platform/x86: hp-bioscfg: advance elem past consumed array elements in string-attributes
Date: Mon,  3 Aug 2026 19:30:34 +0500
Message-ID: <20260803143037.93105-12-meatuni001@gmail.com>
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

Same defect as the companion fix to enum-attributes.c in this series:
the PREREQUISITES case consumes "size" consecutive ACPI package
elements via elem + reqs, but the outer loop only advances "elem" by
one per iteration, causing the next iteration to misread a leftover
prerequisite entry as the next property and abort the parse with
-EIO on the resulting type mismatch.

Fix by advancing "elem" by (size - 1) after the loop.

Fixes: e6c7b3e15559 ("platform/x86: hp-bioscfg: string-attributes")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/platform/x86/hp/hp-bioscfg/string-attributes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/string-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/string-attributes.c
index fe5a9a3a4ef1..5abec8995911 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/string-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/string-attributes.c
@@ -233,6 +233,8 @@ static int hp_populate_string_elements_from_package(union acpi_object *string_ob
 				kfree(str_value);
 				str_value = NULL;
 			}
+			if (size)
+				elem += size - 1;
 			break;
 
 		case SECURITY_LEVEL:
-- 
2.55.0

