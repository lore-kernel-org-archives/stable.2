Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7BD40FD9B
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 15:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783525745; cv=none; b=nPfJir4XjsmV6fJGvewNdnNCAiZNQLkjnhy+SlwGWgB18gU9LC97FEnUD/ed8iaEHa7dUG71/IMadTY/+keegfiDi9szfGqRk3Pt9ntmBtMpLLNkM+98qgGcMeu51j+m1UjzTqlb5p5STgMVfqtf/FTvyk3Tw8D9JM6jZpRswOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783525745; c=relaxed/simple;
	bh=+fb2hm/AV+gpBOcwwKZ0VASVGKm3XP6ZLpjp9sYFqfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L1xrvqdk1g2KMKasvZNbKNTcsxPgbIm7OnWygjp+WVY3nQQt3fxZQc0x3xNvtodMxhj3bHCUrVVT+c2w2YfWvtgQHv6s49eh4uwj+t9u0NWRIGSSUjxvKoEHHuF331+eWFnXpweMYkebKr+erqBCgdSZ8g+KuNus1OFpfBArV5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tCVFg0vE; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tCVFg0vE"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-698beff7178so1503619a12.3
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 08:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783525742; x=1784130542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aWjcO3quzBLPCQpyEkYQryJlDPpxypgV7KUttYaLljc=;
        b=tCVFg0vE8SjqeX73phKxLJdwORjAjBov0SFnBJxL5VAlKDnjn+qfjAmxSwpBUBTEtS
         xZ9vySE7EDsJzTcWUoU5gZnLxmLg0lj/ss3zj9JaI5lAV7nhV1dRIEbHwRTqQz6xn3TY
         bItr2zHbVWrrvJ4s4YUumBY2XYQsx4f+HREw316kAL/uVAZbdRqiIgAjHaJEAieu6mZg
         HQA6Nt7oM6GKeaJI+g+iNw5WDoln3643MTkQ/N9qs5GzSaz6wuUine6180jR4Zh4n1r3
         35gkjlaiRCRuYjq21IIsstw0RLZsAdX6IcZu9dA+oabNn8jyNnefHmzbwLvjtJMtl26K
         J+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783525742; x=1784130542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aWjcO3quzBLPCQpyEkYQryJlDPpxypgV7KUttYaLljc=;
        b=LzS7X1AWkYQpr5PKnPAAc5OWpSiNErxP6nqf0CJIhw/RMxST5JolTSM+VukzCw0tYH
         aIsCEm0xqEXmHTDlcfS3icKkRAUxxNlmpZjzTIUFk5MpIMHG6wzJOFdZMC/zaspFtcIs
         0IcHLx5dZExzQwK8jiLbCIQmNXSm6C/MylhzyZ+yCQADaAC5UIf7KFAvDAmMFt/1GEgA
         5bKm/SuGsF6g6l2+1tzSje2UGImDtQWkGf7b8+gVCoAGcqNTGnc9f387phJhB9rPx1MU
         urq6g6VmT8dYUQLOKNvtdo1gqiDEnS5yz97QAJN1l7+I/n8TdipVvNnYTt0lm2r+tNS9
         JtAg==
X-Gm-Message-State: AOJu0Yzxn630MmhdhurTXXoSZpell4nCWkdvFV8g6Ou0JLxQP/xWAUG+
	E5L68a+XxxN55nTui/Xmlt51LxjzzT+SD/+JAq3QXuOBf49bkDi0YBC1
X-Gm-Gg: AfdE7cm1pqoSD/A0RXIQcH/BcJamQ4v3pelT/xt8vw50DS6I1ZNalVEQdbe7f0mRhmN
	gcHOOWotYOGMXs6wvaGDP+ciyuozbSk4p6XHF4CPbXsD8XqCkvwasGT7/I58BpFrVO1Pmlly1SK
	QZ4ySzSduhnTCH8Ldk9S/+g908wuuRMHebqhX0SbyKPJtpIc0sqR0s6DWRNPQiCC9Aesp1+x+8B
	iBgG2jKhoD7rPbp1qKFWpb1J4K+wq5ghTHz3fOX+5lWHMdPDGn6vRxXJKTdHib6NXn/S6qE8xEY
	w2kUhsFMuH655G3eRlS7K3AR31Xud+Nf4q1AmRPJlGi1XoKyfJS3DoXOh5wBEzyUStpqNzQ+1jn
	nsuGY26+00r4K8UXtwPrPLVf0M7TkVM2Mv/d583CQlaKLPU5h2QYi/W6tXj8e6ps/HjZvjj3Bbl
	G+i+xozeZsHHLmmG7e6V0PiIftd3fM3LISNrvfoagcbuvjYJSO84B8Etj9KHpc6qU=
X-Received: by 2002:a17:906:6a0f:b0:bec:fa92:d36c with SMTP id a640c23a62f3a-c15ce1884e6mr147647666b.38.1783525742031;
        Wed, 08 Jul 2026 08:49:02 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69ac41d7ceesm945125a12.23.2026.07.08.08.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 08:49:01 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	jorge.lopez2@hp.com,
	linux@weissschuh.net,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Mario Limonciello <superm1@kernel.org>,
	Armin Wolf <W_Armin@gmx.de>,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v4 4/4] platform/x86: hp-bioscfg: warn on element type mismatch instead of failing
Date: Wed,  8 Jul 2026 20:48:45 +0500
Message-ID: <20260708154846.12356-5-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260708154846.12356-1-meatuni001@gmail.com>
References: <20260708154846.12356-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hp_populate_enumeration_elements_from_package() returns -EIO and aborts
enumeration of the entire attribute when any single element has an
unexpected ACPI type. This is observed on HP EliteBook 840 G2 when the
BIOS returns malformed ACPI data following a failed WMI query:

  ACPI BIOS Error (bug): AE_AML_BUFFER_LIMIT, Index (0x000000032)
    is beyond end of object (length 0x32)
  ACPI Error: Aborting method \_SB.WMID.WQBE due to previous error
  Error expected type 2 for elem 13, but got type 1 instead
  hp_bioscfg: Returned error 0x3,
    "Invalid command value/Feature not supported"

Aborting immediately discards the attribute entirely.

Warn about the unexpected element type, free the temporary string, skip
the offending element, and continue parsing the remaining package
instead of failing the whole attribute.

Fixes: a34fc329b189 ("platform/x86: hp-bioscfg: bioscfg")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
index 3aa2c440e0528..b834303e5bc79 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
@@ -163,10 +163,11 @@ static int hp_populate_enumeration_elements_from_package(union acpi_object *enum
 
 		/* Check that both expected and read object type match */
 		if (expected_enum_types[eloc] != enum_obj[elem].type) {
-			pr_err("Error expected type %d for elem %d, but got type %d instead\n",
-			       expected_enum_types[eloc], elem, enum_obj[elem].type);
+			pr_warn("Unexpected element type at elem %d: expected %d, got %d, skipping\n",
+				elem, expected_enum_types[eloc], enum_obj[elem].type);
 			kfree(str_value);
-			return -EIO;
+			str_value = NULL;
+			continue;
 		}
 
 		/* Assign appropriate element value to corresponding field */
-- 
2.55.0

