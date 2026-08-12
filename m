Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDEB4334CF
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 11:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786533542; cv=none; b=U1fC0vquFcKL+I/F7EPfMVxwnDimOUTBDF/AfS8pmUuczN7Z6oHJw4+ZmPkaB26fHTOkQXkRI1F7wFpSrAHbJ67Ltuv9sM92P3OVNFT1cIMLODFfGxDD9CE2GAJjpafIFJAUiL+7Ntzw5XxoKm7vGzI41Z5cpj5iB7eqd5A+T9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786533542; c=relaxed/simple;
	bh=jIs7SBmbrIzpQPWUe7SIDuER+UB8eqmz6Q8ZK68R+M0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pDs+ixZnujRvPqDd36dYbBmcGXARuzUeNXqRWH8BBIyfkhoMRXIL+S1NAKOoqsrtvgk87+SdZkA9wTs+engKYYKkYERpMykWucoAnkq3agB7SiH2RG+qfeDS/wxmdhw79QXnB3Jv/beE0v27G9+cWX88qYRE2RXdxsrNDX7WEbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GxQN42Le; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxQN42Le"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4997581cdc1so6861065e9.3
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 04:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786533539; x=1787138339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vM2gdPuCkyOEMq/7xYv9p7Pxqs4FlFaCZ91sPS1S74s=;
        b=GxQN42Le9+jE4vuEAj9Fc0uiESfs4mmBaDbPbbUgzhV59YjjLCbxQp912dLeFtO3Dk
         4pfHu2qX4BXioPnFsqSOg9Id8EopLagEreYJ4/JN/jawQ/JjymfmBD+yOuayPz4eT5Lv
         USMxugUlpU46PaLbHJiNikOunvWkGXVOUrOOtjOSVj3cVi7Lx+G8lnKjnkpWNpnyltrb
         ZaS7y/DtXUn9BSLwQnwsdH56CFLOHAT9lW4PMTzIQM7GvPZ41jhALhAsGzcQRyjtm7Bm
         r3+iS88q4JiHAO2HA54TWu3WKXCnBZ06hW3exht9BALgoRzbzoZkmYlwm1wOPGGfxQWy
         nuMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786533539; x=1787138339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vM2gdPuCkyOEMq/7xYv9p7Pxqs4FlFaCZ91sPS1S74s=;
        b=SK5yhopx6IARbeL5/jqtRxjcYIe2qYOpmflGW3g7NzCVKksDMf15g/gja24Ic90pyH
         FtdZKHmVtuEIzM/EVwOpQxPezfO0axEowe+48mQJYAOs2uMY8s2R+JPLKGvU3XWXWV9r
         U3gSyGjm9RvXf9k3Fn4qLk3Xa/qy3vw+zP510kzrwboLUUvb1kVAc12GiiAx9nV/SOTX
         meAVyZ2m9sgOuesEuzBTpY8AXFGSO6MFiGWZDQ1g2aMGPTFMMdwX5hz2kn6lSamB/0/i
         oOhUlLH9GsMrFnZSWyxr4yK1ZY/tCQfBmBnJgAqut5vsZ9G5VYI8Kp4aBAO9P/5n6hi9
         18rw==
X-Forwarded-Encrypted: i=1; AHgh+RpIZlshZr2iaBlQx/V+PBa4mviVIyi15BgKwtQMAhPKKOUNGBvHmMcOnUzlXd/qhZVdHFpWbkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoZvCUjdT4Na/ZKETcgLIuMTAs9DYZ7vus952Rrl6328Pi9hsi
	RFrDDjVVNPh1404BnrPzpz+B3oxIeVmH/tAzqfC4M0kCtVsnPBFDLXRq
X-Gm-Gg: AR+sD13VAd+wGgfgX+Rt4h6Gh3qNXo0ecuTZGp2HAUX0UPv0d3t2G9J9pSwNJqqPM+Q
	d4+rW/Qt4GKbwnAZg/GDPOM7vV+gogxn0sJIaPmRiV2vGI8Bmb9Z9T77AToiOGvw1DD4RvmN3VG
	O1NPDNBQu2CdkkfwidbOPxsPKnUuRD1y+HHaZQzHrMbX67LkntSUGoKAPDbKoXZ7p/E6JpmmKDo
	RFBgdnxJ4aGyk0B3tXibD/rGMUlZ4RIxxrpPzV1lum8hC1L4zGPaiY5qrDgZDQlKBvM2mn36fPA
	p0RPuvTMOo5kqqmOQ8lIzjm+/6oxvKIMLqVfzwAdsSx5SOYObY2USu8Rj7B95vPdj+u8hDd0XOg
	Z5S/NfZckTL03exZqJFKcRqIzY7x4iI6hTumvLV9JmSKdElCpMEKy99kJvYT7kzeAxmwQoe9HaR
	kDuuUlOu6O/7+dDdGl/TaorYnutUUcv95WUcuewkR07Ps2sB12o+BE9ux69isoW4EaO2iQM3G3F
	RUpaljZkHiotBYZzvaK4xlk188vOWQBo26VeHygQw==
X-Received: by 2002:a05:600c:468f:b0:499:4892:e84e with SMTP id 5b1f17b1804b1-4997c14569amr44988515e9.11.1786533539249;
        Wed, 12 Aug 2026 04:18:59 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48150d702c9sm6670072f8f.34.2026.08.12.04.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 04:18:58 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: jorge.lopez2@hp.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v2 9/9] platform/x86: hp-bioscfg: advance elem past consumed array elements
Date: Wed, 12 Aug 2026 16:18:29 +0500
Message-ID: <20260812111829.172273-10-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812111829.172273-1-meatuni001@gmail.com>
References: <20260812111829.172273-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The outer parsing loop in each attribute-type parser advances "elem"
(the index into the ACPI package element array) by exactly one per
iteration, but cases that consume multi-element arrays
(PREREQUISITES, ENUM_POSSIBLE_VALUES, PSWD_ENCODINGS) read "size"
consecutive elements without adjusting "elem" for the extra entries
consumed beyond the first. The next outer iteration then re-reads a
leftover element from the array just consumed instead of the next
real property, and the type check fails on that stale element,
aborting the parse with -EIO.

This produces exactly the failure visible in dmesg on the test
hardware, on every boot:

  Error expected type 2 for elem 13, but got type 1 instead
  hp_bioscfg: Returned error 0x3, "Invalid command value/Feature not
  supported"

Fix by advancing "elem" by (size - 1) after each array-consuming
loop, so the outer loop's own "elem++" lands on the correct next
element. "eloc" is intentionally left alone: it indexes the logical
property schema, not the physical element array, and each array case
is still exactly one logical property regardless of how many physical
elements it spans.

The defect is identical across all five attribute-type parsers
(enum, integer, string, ordered-list, password), which were
copy-pasted from the same template when the driver was introduced.

Fixes: 6b2770bfd6f9 ("platform/x86: hp-bioscfg: enum-attributes")
Fixes: 6f2c06d5a467 ("platform/x86: hp-bioscfg: int-attributes")
Fixes: e6c7b3e15559 ("platform/x86: hp-bioscfg: string-attributes")
Fixes: 4b2672ec71a3 ("platform/x86: hp-bioscfg: order-list-attributes")
Fixes: 8646a3b5ee3a ("platform/x86: hp-bioscfg: passwdobj-attributes")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c       | 4 ++++
 drivers/platform/x86/hp/hp-bioscfg/int-attributes.c        | 2 ++
 drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c | 2 ++
 drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c  | 4 ++++
 drivers/platform/x86/hp/hp-bioscfg/string-attributes.c     | 2 ++
 5 files changed, 14 insertions(+)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
index af4d1920d488..43beb639051e 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
@@ -227,6 +227,8 @@ static int hp_populate_enumeration_elements_from_package(union acpi_object *enum
 				kfree(str_value);
 				str_value = NULL;
 			}
+			if (size)
+				elem += size - 1;
 			break;
 
 		case SECURITY_LEVEL:
@@ -280,6 +282,8 @@ static int hp_populate_enumeration_elements_from_package(union acpi_object *enum
 				kfree(str_value);
 				str_value = NULL;
 			}
+			if (size)
+				elem += (size < MAX_VALUES_SIZE ? size : MAX_VALUES_SIZE) - 1;
 			break;
 		default:
 			pr_warn("Invalid element: %d found in Enumeration attribute or data may be malformed\n", elem);
diff --git a/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
index d96e160953e3..5373af71549a 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
@@ -243,6 +243,8 @@ static int hp_populate_integer_elements_from_package(union acpi_object *integer_
 				kfree(str_value);
 				str_value = NULL;
 			}
+			if (size)
+				elem += size - 1;
 			break;
 
 		case SECURITY_LEVEL:
diff --git a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
index 704c69c18146..6696255738ba 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
@@ -232,6 +232,8 @@ static int hp_populate_ordered_list_elements_from_package(union acpi_object *ord
 				kfree(str_value);
 				str_value = NULL;
 			}
+			if (size)
+				elem += size - 1;
 			break;
 
 		case SECURITY_LEVEL:
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

