Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9D53BFAEF
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 20:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782507001; cv=none; b=EucK7WUNn0eV3yQY6q3QmebV+PiMtb4Qc8fuPAncwJoTayib2EssxvykUaHi4dFbd4qakAMpi/80D5x+LdhkKjkYAVZQU6Pu0lwh2D+c1g+UQ8yqd4gAt92NKR34a4k0xeaDQiKG8jpSbggtglFUCkoMgmwac/QO+by4b3EKxvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782507001; c=relaxed/simple;
	bh=lqmOcWqI0FMeiKH4DVNZK8U1G2Kv6utppj1Q/a7Qx/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UJMlPIMEhVaXVVYpwM63HmFHnyQYGLEDCRbe1k+oxJM7WuXsAbeG4xGwi2mzE/O1Cjs1WVgjoHZT/rvaCMNsCaADEP97P/dOPN7RbDg+8KB081d2SN+tbumWycx+sGnmMP6pyMeOP+z9wCcSpRcJY78EdNYtUBYi/fVM5dj7XEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emGv4cKn; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emGv4cKn"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c0e124d2a21so136519566b.2
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 13:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782506998; x=1783111798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJ5pE+48i146L2Ym2Up31rAyIZfjYbmUnquanO7bZu4=;
        b=emGv4cKnofN7c9rO4jfnUS2rmyJq4OOfs32xeBq7aHaR6dVcpkF1I+6BoFllMpmLDZ
         rN4sWkgnu2WZWtHS2ohhDg/MvOIaZhcCVYMOaTYkC/IduwTKUubIbg3wlp43tEiC2SJe
         cosIoTC42Sin2Wd0b+epqISh3AyJBZGeSoFCStDQwEwUCTiRPnskiOU73s1El0niTCaF
         wIBHdsnUBEQEZUwMFi2w/RM55rrCACa5CSZbbD9G2UbC+7iQDRVi45UQC5/qkA1wtV+D
         fHk/iiQmFEerJtemQjhntMR0meHv7d/74KBcihw2GvMPnwOlK7knxy8/wOd0UoXu7Ncf
         35Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782506998; x=1783111798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pJ5pE+48i146L2Ym2Up31rAyIZfjYbmUnquanO7bZu4=;
        b=K3Ku17kwnqgsuyfNv/kHhrbTzc1cIBoBRgEsej7vINeufl0/qcmHHl6366onIEtIT+
         5ru1xzU2vRTyxLRjYTqm0V0g1jN7SsXsO9V28GfPMqk9TmlNhF5hMRlK5sOJPxiwkgXW
         MiFYft/o8dv9P9MJdw3GrUQd0+rNZaeUO2YWzcA08IBvXSwIyt8NhZ52gzQUAvgxi+FD
         S89YjCyB/Z4k1Sc6i4HJqEDuXXdf5t6pFmU7YNGRuH+lcqGa3vGrLFDPtIo5QN9OBpqt
         rK+3P974yfKWGJllAK+CbEohq9ncGBET0ZAuo2DgO0e8qSGcEJAjkspJyVTJ9GwBq5Lk
         g3ZA==
X-Forwarded-Encrypted: i=1; AHgh+RpbDI4S0SwW6EbOw3JW2HNsIpl9t18M13ayp2owdEo94fK9pMxbzJPuqB8/jmIGmFbq9uPxbXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXNOYzk2qgsrJUSKSHIYPTFIIsLx8w4pKqqqLp5rsK+pikHam6
	Q+vPCUaLw77NcPcg9KdP70mP70mJHRfXjFuDxWl4OyIl7Ho3Sub7N4YP
X-Gm-Gg: AfdE7ck60yyaRzZkdaeCy0jerykN9hIpRTu7fMPAVt+JMuiz4UXjsV57MAHLIgWTZIj
	gMQot47/4Oeo/pg9va+OXL3RuVbV11vXozXg7RMEdFC3zzsw4SDMF3esxUW6Uq2tEqgikyLBWco
	210EgDcEH6Roc+ty9AOhipBowwuW/mlqCLQq+2S2jMQnHl7PM3OTBJ5gY4Kuc9vQ4oNP+n1D61R
	yhzmHAokR6JyEtQ73vk9jBPKkf67W9Dr9ad+9ZO/8Pvak2eX6CC6D7Pj5ipG4qsqUU6yhT9wIhl
	oNlnK9o/cReAHTEPtvstDCybxSwFATS/QoTWaVyGeS2s69LAa8kbF9jstukI9nN0w7dZApe5afN
	ovb2QqYVJuhtUGhXsVF1kfQC2phuX90HQBTX4tU9HmKqg7spm7bNGX7DsNTck5jfg0Txx6FvQao
	9tl61y7Uqm/JYuFlDIL+FjCWYzD7Uohz4jVBEjFaWpD/lG0/GNItIb1Uoz70x6EqE=
X-Received: by 2002:a17:907:c0d:b0:c12:3597:2cd3 with SMTP id a640c23a62f3a-c1235973654mr75629366b.29.1782506998009;
        Fri, 26 Jun 2026 13:49:58 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c11fbbe8118sm387907866b.24.2026.06.26.13.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 13:49:57 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: Jorge Lopez <jorge.lopez2@hp.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH 2/2] platform/x86: hp-bioscfg: warn on element type mismatch instead of failing
Date: Sat, 27 Jun 2026 01:49:45 +0500
Message-ID: <20260626204945.18868-3-meatuni001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626204945.18868-1-meatuni001@gmail.com>
References: <20260626204945.18868-1-meatuni001@gmail.com>
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
  hp_bioscfg: Returned error 0x3, "Invalid command value/Feature not supported"

A type mismatch on one element does not necessarily corrupt the attribute
being built, especially for non-critical type-specific elements such as
possible values or bounds. Failing fatally here discards attributes that
could otherwise be partially useful.

Change the type mismatch handling from a fatal pr_err + return -EIO to
a pr_warn + continue, freeing the accumulated string value and skipping
the affected element. The attribute is still registered with whatever
valid elements the BIOS did supply.

Fixes: a34fc329b189 ("platform/x86: hp-bioscfg: bioscfg")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
index af4d1920d4880..78729354c04f2 100644
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
2.54.0

