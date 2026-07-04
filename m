Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F46C3A4520
	for <stable@vger.kernel.org>; Sat,  4 Jul 2026 16:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783181318; cv=none; b=OL+y/qFpa/DRIswNng1UgJjwUa6BQ9atSqR6JKCB9yEmuWl25XjgszE44KUg1qnfJp68zbaKHJ7jJAVIiViGD+H6XuthSbRFzoOvyuMS9/doqrgXlIAvT1Wi8Sg4eJ2Sd8NBkz2qbG5ppxVR2yGtV6YieobhX3eXvam/7DG/Dwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783181318; c=relaxed/simple;
	bh=4NG8zneOYe7p0UrTp9P9R7HnMyKE7GyM9DN8ppk6JVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n6y8IXpsRhLSxHb+lr8CRZ4IZsBMBme+39HinRqb27BIyHZ4H6Z54DA8sFMJGqGuP1lHAwbKSDOhY1JMJRpoyV/AcrcZXllL3KJiJ03hTM60moM+bG/rXapzbs01WF9fVJo+siAaRQfCxwKMNZ6fdiyqnkGIe4hFoG9Vtt6B5A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAyHmCdu; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAyHmCdu"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-697564cb69eso3065400a12.0
        for <stable@vger.kernel.org>; Sat, 04 Jul 2026 09:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783181316; x=1783786116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMhE6Jch/T1UvoknEZxvYaZzdpc2xBp5cw8Z7tMZGzI=;
        b=nAyHmCduIRga9XqSsxm6NHkRUl5TrvjCy/cOLYHXTKxqRSkFqeDSwKZz9NAeqh2jPL
         nYIK0+T8Z8IbRnx1kLShK3jYXeForJfBmwctcfgNeps7fzj/hIo/NNWj1ezrXoHR1+hj
         4m9J6PSW/lcuJb2qxCUEmLJsoZNhvMaSV+Cox7GByzO7eG+Shjt6C4Tp6jR5A413a7pd
         im96xUQ4uoQqMnZ8G+5oTTSB3ZBxNcpyz8NzEAF4WnrSZiWbZEzOne+TR1QRSRadD7KF
         8viq74ACEWZd4XgJRLGrYHHteyh/jmEFG47endbjItsKd27MMIPPeLWaqUyK46YBV70u
         DazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783181316; x=1783786116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UMhE6Jch/T1UvoknEZxvYaZzdpc2xBp5cw8Z7tMZGzI=;
        b=QMc+8lFk8XwrkQA1pRDWFp/meZvwgaLdjLa0M0+MFBlJTyrurLLphIxqiTxC0o0UgY
         3a53yep+pgsJVJlZZuAV/XtdDf7e7u8bGgiq6pSYtTRkNs3PJNbUzCvgag2l6u7iUKKC
         p7g2oD3OrpwltM5WbhwniSF64YEvSxrz+4cAhpHGyTqFI6Fuu34vzvc40YMOdPl3Oq+x
         wxsRX/p8NEwpWnZvqDX5bx02nhN1Iwbuf05VjrorUrphH2KjI7i/hAk3DWlTeY085R0B
         oIofkOPHM7yL9s9/GAb/MJmKN+ytgOZB+YImINQXwNezX+rvU7ZwuEDaxtg0JRHaA97k
         FAbw==
X-Gm-Message-State: AOJu0YwJqMuquQICWKZwtqIX6+u4NRRBNPFk8QDJBlBk80+tv4ChhNyI
	CC/j+Gb5CfvBjIGnQtncKRlaHv/umj2KA5Hvxq1V/gclezBalaMhZR3O
X-Gm-Gg: AfdE7clsYzXcxu66xBtWXCPoL1FcSbKaWeF8KH6Y4/RL73jmNWaqz/W7WEGeq4StNCV
	1nDPASwnp9LZd/OTERsMUyPGLrX25gT5QL2eEDTOb2IbijYinx2VKbRG34rlnCdjpeLZopgpijW
	+XYvqL5nxnCixSTlB3oToImcOZEn/F6rwBkCrFrX6HbpTIOoso/hp9cWk0CcQf12h0Ebu8y0c9q
	i2HPdm/TRp9FToiH8ARpf7oHiW4q3MU36rHAcQdTF5+mlmcR8PaA+5xrGM475Y2XJg05zEDfUYJ
	lJgAiuujQv2xAdODGpmwwvhJVzNdKXkzBLL9bpqYeXY8J2ZxtKZXCPTO4o5weol7heEBX0M32bH
	Cts/v87RSEE1pIUWamAP9WdPAkYxvxeWqVdEfQ0GvDOolXbqVNEIMTACEaS6dGMyp1XiZwhjTuf
	0FljvjzKjUSL8j94696CI12ShC0ZtMKV9VLHN2T+pzPeClF6juMoqWaDE8M6h7vqI=
X-Received: by 2002:a17:907:998d:b0:c12:d64:ca50 with SMTP id a640c23a62f3a-c12e6ab6f98mr119057566b.16.1783181315826;
        Sat, 04 Jul 2026 09:08:35 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b60575c4sm438586266b.9.2026.07.04.09.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 09:08:35 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	jorge.lopez2@hp.com,
	Thomas.Weissschuh@linutronix.de,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Mario Limonciello <superm1@kernel.org>,
	Armin Wolf <W_Armin@gmx.de>,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v2 2/3] platform/x86: hp-bioscfg: accept reduced ACPI packages from older HP BIOS
Date: Sat,  4 Jul 2026 21:07:58 +0500
Message-ID: <20260704160759.236249-3-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260704160759.236249-1-meatuni001@gmail.com>
References: <20260704160759.236249-1-meatuni001@gmail.com>
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
index 768330d291da8..78019644ec358 100644
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
index 416d7e7aaaae3..ac57d6eab4c35 100644
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
2.55.0

