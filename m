Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E59B3BF68F
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 20:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782506998; cv=none; b=EnsoI+tTy68fwhw/4N8nZ2kWKevKZgS/NpihWDyCKNO9caACk6pk5sKQ0iBfcCpDdQOStTQNcwNLk0XvuHhQR/51RsTXVOtz1ydtSdPnDiOvffr/FLtEH1xR85Jd29omP+ldKHwUECNVKPDnc6bzlZv8TTNPAEnfI0W8Ojnf/Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782506998; c=relaxed/simple;
	bh=0sIDfSgUxXO2vmSLA31+EiQLz3GAhPSQpy3CjWo81L0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sOn66Csusy6bp9vqiM6ReVGWy2PnXq56ircdTtKJwZYf6SV9rQVxTUbTTyokriLS6zn+QRWTlDMdMSRRczFByioHOxiL1hJwTuMYlDyDaBhy1Qptt1JRG4m7QrHitB2b7mxHlicTgNc9fF8msgdNpRIqiR1Tqf8anjRzvhmop9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9TcolpH; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9TcolpH"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c1218f9a39aso158720866b.1
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 13:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782506995; x=1783111795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZqKhdXPzlMwgJiJAHOYQTFAjHWL44qDb+NmBtEip5cQ=;
        b=J9TcolpHIkspMIWwMDyDFrXHUeOqse0tBXcUfAGA5XCxqSSrnS5E4kAQH0LX+z7+rS
         tCkPmZRiogCNtIpsC1VHYLaiq2D9zvOl4h+f/lUmT0piA7u+rIVJf4u+7WYfjc101oUj
         dm/xOWOjb7J9Fe+/pmnbOLDvvbx8rDe2hBgZIO0HeoIxkpKQqCIcq3xQB8bS9oCQhaNK
         edhG9YnFqCmRYqpX1Z59D/+pFw9oznI5f23EnzBb09HRltQZlXbiymY3a/qU22Ol9aW0
         hyiMtVdS1SjexAuSYfo0jyr5wcXhbG6mT2zHYMTm2WsP0pU7+nwqncP2dVFBSdU63ruF
         3TJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782506995; x=1783111795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZqKhdXPzlMwgJiJAHOYQTFAjHWL44qDb+NmBtEip5cQ=;
        b=iDdAqs7tKaF/Q1qq9UpSQc/HSwIcO90htuZX8Vru8R3HhwAZF2OMRel99gJGMAkF+I
         rMzfHCGGcG70lWW4Mm2nJ7Qeh2fFCBWw13ut45Vj6/Ans/PbDdgNi1l8EUloQFXAE16U
         XpeUztmmlcInoR8+n3sOu+IxoKq7WNaw0/D9c1TtF7Vcr0UkJK15oSZNldT6gnkiIDZh
         359PUmvYlzBCWsVmcWg8eqbtH47K+uiLXy1VwiaAWFykz3/Ji+wMWDQWwKBr4LkQuRB/
         n8jnU7GFCxfpGXKLJUnG3Lp2KAdLhA9qC1PHZJ1H4KSydzNRVO8q4n0yx+jBP2jAHTxU
         +/BQ==
X-Forwarded-Encrypted: i=1; AHgh+RqL1/F+LHt6xSDWU287ToY0TNNctqE/1qcPUwKSPvhYmZwgLOM/PHREt4qPb8uoW8fM9eHzNGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEWjk4vlOPE4Igzq8cPvOYyB1PWzbP4cksm4L5bNjoMJT1ngio
	HUngQkNdWaI8O+5v1/Jj1zW135Yt2DTWlZSPO9rZi14LwDruu9d1W11W
X-Gm-Gg: AfdE7cmqRzy0EJJWrF3GUUkVlmvnWf+Zzof6CJKkohFsuAntfSiq3788JorHa8Q3pQQ
	tiqeDLMe6r3BVBoxxMcc4xlbG8ZBGPQNbr6QMsoUMxamFRG2eyS7/2j36R1e1FFl+SF2g0gL2/4
	slhNtrackv5eLs5Kvy7amuOFZbSsdlxCK8KflqWGxUOcEDmTzDEZhVuAzMFpNqE3KOnebfq8ctp
	n7oYTVZTrUwvUjfe4agOYa8soXzfZNvIwMfZNNDAt2OFYBk10kS6FasU8OfdXPIRzWVjEFs/9Wa
	8yFgyturxTpHtZOr5eAlKSvGaocIj7TyZb66UVc3ezGTTtyAnzZUoHDleBzptoQ/LFBTANAyX/2
	wxe7WPyla3CWl9IFfcN0+rKKcj9EWBzaNfV+TQiJRIc3FDjvfqRDZGQph+8d5W7bmA2DOaDGoga
	TnrQwAFT+wEo9P3IeAsC3oU2/DGESSbDgAfVd6DlH3Dvgg/jSlJa2SrR4dkw+jroIHFj3z8YRjY
	w==
X-Received: by 2002:a17:906:c109:b0:c0f:4efc:e63d with SMTP id a640c23a62f3a-c1205f66c65mr520260466b.29.1782506994772;
        Fri, 26 Jun 2026 13:49:54 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c11fbbe8118sm387907866b.24.2026.06.26.13.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 13:49:54 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: Jorge Lopez <jorge.lopez2@hp.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH 1/2] platform/x86: hp-bioscfg: accept reduced ACPI packages from older HP BIOS
Date: Sat, 27 Jun 2026 01:49:44 +0500
Message-ID: <20260626204945.18868-2-meatuni001@gmail.com>
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

hp_init_bios_package_attribute() hard-fails when a WMI ACPI package
contains fewer elements than the type-specific expected count (e.g. 11
elements instead of 13 for INTEGER or ENUMERATION attributes). This
causes the entire hp_bioscfg driver to skip attribute enumeration on
older HP hardware whose BIOS returns shortened packages when optional
fields like prerequisites or possible values are absent.

Observed on HP EliteBook 840 G2 (BIOS M71 Ver. 01.31):

  hp_bioscfg: ACPI-package does not have enough elements: 11 < 13

The element layout has two tiers:
  - Elements 0-9 (SECURITY_LEVEL+1 = 10): common to all attribute types
  - Elements 10-N: type-specific (bounds, values, encodings, ...)

The per-type populate functions (hp_populate_*_elements_from_package)
already handle sparse packages correctly via their own elem < count
loop guards and inner-loop bounds checks. The only unsafe case is when
we lack even the common elements needed to register the attribute.

Fix by introducing COMMON_ELEM_CNT to mark the hard minimum (10), and
splitting the check into two tiers:
  - Fewer than COMMON_ELEM_CNT elements: hard fail, can't proceed.
  - Fewer than expected type-specific elements: warn, but let the
    populate function parse what is available.

Fixes: a34fc329b189 ("platform/x86: hp-bioscfg: bioscfg")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c | 11 ++++++++---
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.h |  3 +++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
index 27fd6cd215290..dd531191e88e2 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
@@ -661,12 +661,17 @@ static int hp_init_bios_package_attribute(enum hp_wmi_data_type attr_type,
 	int ret = 0;
 
 	/* Take action appropriate to each ACPI TYPE */
-	if (obj->package.count < min_elements) {
-		pr_err("ACPI-package does not have enough elements: %d < %d\n",
-		       obj->package.count, min_elements);
+	if (obj->package.count < COMMON_ELEM_CNT) {
+		pr_err("ACPI-package is missing common elements: %d < %d\n",
+		       obj->package.count, COMMON_ELEM_CNT);
 		goto pack_attr_exit;
 	}
 
+	if (obj->package.count < min_elements) {
+		pr_warn("ACPI-package has fewer elements than expected: %d < %d, parsing available elements\n",
+			obj->package.count, min_elements);
+	}
+
 	elements = obj->package.elements;
 
 	/* sanity checking */
diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
index f1eec0e4ba075..f4a375c5669e4 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
+++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
@@ -279,6 +279,9 @@ enum hp_wmi_data_elements {
 	PSWD_ENCODINGS = 13,
 	PSWD_IS_SET = 14,
 	PSWD_ELEM_CNT = 15,
+
+	/* Minimum elements shared by all attribute types (NAME..SECURITY_LEVEL) */
+	COMMON_ELEM_CNT = SECURITY_LEVEL + 1,
 };
 
 #define GET_INSTANCE_ID(type)						\
-- 
2.54.0

