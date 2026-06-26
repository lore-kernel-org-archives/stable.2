Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800603B2FF9
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 20:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782506994; cv=none; b=puFIjdsUH/mnw8WQdAv9/5TajLFvEhNQU6U/iVua62OvlpKDstcHNbbA+y66QOKJ3H5UDPiIdPjVLucIW7X/DsmFauG34Ol0R/0JcX0hxRaCiCXEsp4ezfnIC81FOWvuDlbw3xBi9mr71wda+Z+RmYB3zGJjmO0X+8GkTyLREqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782506994; c=relaxed/simple;
	bh=/by/3emQITal9Kugr50sDPX9bYLyrZB8f/kpJDD8TKo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ONKgJe8gpOf92Hr9dVWB9OHwA4XZphY4X5/cj0Kke9xPAQlo4fpchMC6Y2AHtiXswNvQX1WdZ/jdX/o+bDaLA0mkbS2u2vi9nGIQ1xOwUmnK0xL1EGnqMVLB8Jg1y232e74NlSEm1/UYFiczAmCsYXfWlUdLk2uM+yWgzAaMHpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PfFer9NB; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfFer9NB"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bdb3fd39045so191478166b.3
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 13:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782506992; x=1783111792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=thuY1JcilTL2WkrIhTO71nKlX6gsdJPpD5eyTDT70VI=;
        b=PfFer9NBrtYnOtalqrHLmrGoefOQA8qxajAOs+tdxYL0gq/4hjGL5fn48WtTpF2aEo
         45yVZtSFkZW4wez1quo0NYygZ+fmQ9/HytD28mdAdh2roRKvG7035E5j08nXdWJuXiAp
         HPawvbANcdmdYkADekaEPQzfusYzdUyEhc+r4Q2C71xbnaJcrZVhzgi9K9nSsuxH4s21
         nOfqjQ9uXHJSEKFU2vHcZisrd2EspVmc4aqm43YsWGqaw/VstnaMhKGLejlHh2WsVTAW
         JIOvyb2j8izIKc+QylaeUECqsgI1b7mWZSLxeAlI+M/ibgoT21zjmfGURyeWIiPl3C5N
         aiZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782506992; x=1783111792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thuY1JcilTL2WkrIhTO71nKlX6gsdJPpD5eyTDT70VI=;
        b=leBxHWJ2wtJPzE9SMIjig4jg8ZDfDcg0RHlFzYcD9qszin1hsleKA/G9VdvvqwdqRr
         PC12fiHeJyolKv9FJKQRGfUYVVp6qjeRrDPMLqfvOUjax3dCF+FtFhdxfp3jIVX8D5RS
         LlIRt8tRejOAdC2j7FhNqeRpgcRztcsnyTI2GXPCYf8kuESS86gqpf1CRsUD/1Tlf4vA
         J1K+Tpaxecw/JrstgyQlaSEMU7p4eABqwuXj7ufG7a9vfWGNuwvn99BMRGacbmvB0wJ5
         nTcfRKBT8KumgowR5kApIpT0oZxyNSf8h96mow3NarYUawqqnjJKTaLJy0/66AKCIh6i
         42OA==
X-Forwarded-Encrypted: i=1; AHgh+Roc/eTuTHKLCD8SwgP8ba1DvRk1jvTu+MxxlREg/Zbb2Nf0Ad0tnF4TfV7YxhbVHRoFhUTFjUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvW3MGxfq4XZG8AgC5JGw3rEeltz034VZOyatM/SLQt1D0l+m7
	ZNRGexkutMQDhrRPAPgoulStXdJgFUhKlAf1Dgh5xKnVyp4Fia2LjDWL
X-Gm-Gg: AfdE7ckMHRtMq8dDo8EW2HVMdwGRYFhiLWiIFPYmGqh4ZOoJ7IF1bZ82afONp63Vf/z
	w4QGvQWOde5Oxlg9l8Sq8508/mZ4OWWU8bvX6uX+/SJwu3fiUf6P4A+gvyPilxMEzEucx915koF
	1a85Xy/WCat3eNHmLWidRwaK3QnQxZBD9dKW1JLl3r/Jh1/2qXzaV2LPasJ9IOpbYd0X9feFXiQ
	hqMPMfCfd1eIag2B9K7VPqtD7aHsWy0qTvbgAPSBYNSELqp4/CcZ98fq4oVnojJy8nQTxxPKSrG
	tiG12p+3Nr6jBiWGljdkOj8zUPgTQ27EZ6L+ahKCZSYyhvz5d1/TMjBeJgmLR8HsDlU72vk5txs
	6x7jIV6v36qExod9y/OYrFZM6fd6EfpmNYeZaqwZPDEJd3fjTpt4qQeg9p//kawLQSnGhftazdH
	ko/izcv2089vdxKNZ/qT7T0w9SOXIK3CEOEL3dg0x0u2CxKPp+nQ2zUrQE/tZjkWw=
X-Received: by 2002:a17:907:701:b0:c12:15c4:6df2 with SMTP id a640c23a62f3a-c1215c46fcemr421727366b.43.1782506991641;
        Fri, 26 Jun 2026 13:49:51 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c11fbbe8118sm387907866b.24.2026.06.26.13.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 13:49:50 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: Jorge Lopez <jorge.lopez2@hp.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH 0/2] platform/x86: hp-bioscfg: fix attribute enumeration on older HP BIOS
Date: Sat, 27 Jun 2026 01:49:43 +0500
Message-ID: <20260626204945.18868-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The hp_bioscfg driver silently fails to enumerate BIOS attributes on
HP EliteBook 840 G2 (and potentially other older HP models) because:

  1. hp_init_bios_package_attribute() hard-fails when a WMI ACPI package
     contains fewer elements than the per-type expected count (11 < 13),
     even though only the first 10 common elements are required to
     register an attribute.

  2. hp_populate_enumeration_elements_from_package() returns -EIO and
     discards the entire attribute when any single element has an
     unexpected ACPI object type — typically after a BIOS AML error
     returns malformed data.

Hardware affected:
  HP EliteBook 840 G2 (DMI: Hewlett-Packard HP EliteBook 840 G2/2216)
  BIOS: M71 Ver. 01.31 (02/24/2020)

How to reproduce:
  1. Boot a kernel with CONFIG_HP_BIOSCFG=m on an HP EliteBook 840 G2
  2. modprobe hp_bioscfg
  3. Observe dmesg:
       hp_bioscfg: ACPI-package does not have enough elements: 11 < 13
       Error expected type 2 for elem 13, but got type 1 instead

Testing notes:
  Tested on HP EliteBook 840 G2 running Arch Linux kernel 7.0.13-arch1-1.
  After patches, hp_bioscfg loads successfully and enumerates available
  BIOS attributes. Attributes with shortened packages are partially
  populated and accessible via sysfs. No regressions on systems that
  return full 13-element packages (checked via code inspection —
  pr_warn path is only reached when count < min_elements).

Relevant dmesg (before fix):
  [   11.xxx] hp_bioscfg: ACPI-package does not have enough elements:
              11 < 13
  [   11.xxx] ACPI BIOS Error (bug): AE_AML_BUFFER_LIMIT,
              Index (0x000000032) is beyond end of object (length 0x32)
  [   11.xxx] ACPI Error: Aborting method \_SB.WMID.WQBE
  [   11.xxx] Error expected type 2 for elem 13, got type 1
  [   11.xxx] hp_bioscfg: Returned error 0x3

Muhammad Bilal (2):
  platform/x86: hp-bioscfg: accept reduced ACPI packages from older HP
    BIOS
  platform/x86: hp-bioscfg: warn on element type mismatch instead of
    failing

 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c         | 11 ++++++++---
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.h         |  3 +++
 drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c |  7 ++++---
 3 files changed, 15 insertions(+), 6 deletions(-)

-- 
2.54.0

