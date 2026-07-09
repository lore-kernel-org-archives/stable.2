Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DA639D6D6
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 16:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783616358; cv=none; b=pky6BU1DKv7rqD5NXWBp67Xwxvv/z7VpenLWzdLmpU4UF6WjX0BqgxO4TOOr0sQfVTo6tuw3Tdc1vVpsBWnFM+XovrmSCpzVOqDHLXxHanVV3pzhCduptp71oOFrkphQyXNHq8MfiphgyjRIRlBeMtdlEWfRuq8gYA0CwPD7u6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783616358; c=relaxed/simple;
	bh=4NG8zneOYe7p0UrTp9P9R7HnMyKE7GyM9DN8ppk6JVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o0sE9UGd5loD7GaAhUK/RygjQpDOCFBLXq2F0ThkTXQrNayqMalr3rHi9m6qS3oFp5Rh/JwFLDDirhheZhjt/kifkh3E0oqaOlq3rVu/lOtROVW5DPSikLmWZB/nhPibzVeUHXgBnrR+KlrJSXtvWjase5hCYLeO6xlvegRdlUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4XTruzw; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4XTruzw"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c15d3cd51b2so10604466b.3
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 09:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783616356; x=1784221156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UMhE6Jch/T1UvoknEZxvYaZzdpc2xBp5cw8Z7tMZGzI=;
        b=K4XTruzwZQfWdS03JP5KLRY868vOFIRyRT44vrIGnh16fCgZl7AllXPBjI2b9noJ+0
         0b7ECJqZfcsLfkxit+4qM/SZOw+8l5hyfSxdKkpdt19kFKAZTivNedSaheo0e9sMop+y
         K+JBgXjH6jVrdA6a9XM7RdA7nwCfyfsoYIgih1CuvtUdWBkrQmWvItW1sOlP2sxzQm+5
         0tSYmSlZ7xWsv5fdN5Q8dyrut/ujeH8Pt/q2r8LLWpa4urMLIomyvH4DmCMBfpqm4f9p
         s7fHnQlNs8FePOdMvwu8imjvsLrtWsJMow+UG/0TqOv0xAgnh3HtidI3sdTCqMRFOTQY
         tD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783616356; x=1784221156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UMhE6Jch/T1UvoknEZxvYaZzdpc2xBp5cw8Z7tMZGzI=;
        b=TYfbvwEuesePsZeesiVKr3EEnAU2AsLfqC+Z0swjLXEbe+mNsUxocgbRzx+SrIYXqp
         7IOOBIEP+3qzysEFlP3/wogg0MelcNw7cOgSJ+isZDkbjlCvVLdXpz0WZntjQWnmfHF9
         M7nb5c9KfqDIOpyPNFSNtnKJmM7/KH0ejnOTquRlDENYzZ3yYCuNmrXLBOLYUlSnZH6t
         N/+v0ChD2Pm1T/atoQFCdkR09mwJj+ZekheleZ3TDEe84qS+lx36X4ZJVzpwz+c1h9Tx
         YXAo9zo24x/zJldtibPZrulT8+rMBtBer8fW7M/iSzbtikGhkUVwlxT5swbONz9baeM/
         fQcw==
X-Gm-Message-State: AOJu0YxFSho8TLXg+SQmGbjpbIRtQlNHnNaGqFV4+AtMoERvdQUgxank
	VfXCg6RJRYt9rW06RPGQEsFoAetV71xjLLPK8FD/CVO2r1UxEyfbcHUE
X-Gm-Gg: AfdE7cmM4MkeOmzJpaXAiQ5RF4I8Fc3x42qJqRYOtzB8WkyZFId8ySZy/ANTYiSEzBa
	0sezWIXPYziXkGRvGRi3qT2O7KGjOiVyITCy8TBl0zUJVE1NLiQhrZLk31dRepWtjqcg4+WUqXY
	2Ykkf6VsJeqAz1+tkHR1ONKqndc9++pCtf+QSXCQ+uviHuUxXZnp3nlyz96LFQSTfk1gW1fndt+
	66ZKBifdm94Mrx7NLcujvcBGOYH+GU4bWh/PZBrCqbufei8m+7OTIT/uZfL3crEDoX5VqUdidR1
	eFzLp6Q//jvv8jzEw/XNKHODqaTi7swFnQgWdg3WKpY4Zsa9KGADdiZwAnSAza0IoI006LvUhQl
	wOl5kRUK88/PRIN6zfdWaTk8XhhQLa5ZO79ePwNzZLytmDD5rrX9VMu4HFtgPqQIVlsfPtRbha6
	NuIr0g6aTe4NRI5VzsxqGq2joQmDjy+mfOeWcunnVV0IAOjVVBdfIYGGLYVY4GC4M=
X-Received: by 2002:a17:906:a0c7:b0:c15:b26a:8fd1 with SMTP id a640c23a62f3a-c15ce0e208fmr254039566b.55.1783616355657;
        Thu, 09 Jul 2026 09:59:15 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15c79f2a3fsm329902666b.49.2026.07.09.09.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 09:59:15 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jorge Lopez <jorge.lopez2@hp.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Mario Limonciello <superm1@kernel.org>,
	Armin Wolf <W_Armin@gmx.de>,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v5 3/4] platform/x86: hp-bioscfg: accept reduced ACPI packages from older HP BIOS
Date: Thu,  9 Jul 2026 21:58:58 +0500
Message-ID: <20260709165900.30615-4-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709165900.30615-1-meatuni001@gmail.com>
References: <20260709165900.30615-1-meatuni001@gmail.com>
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

