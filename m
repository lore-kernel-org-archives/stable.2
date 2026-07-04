Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5281345722
	for <stable@vger.kernel.org>; Sat,  4 Jul 2026 16:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783181324; cv=none; b=ichacBm9O1a2Yqto9lr0RF/iWmclg3gHoTN3K3pDPElRdVpIm9xrjfAH9Wc+Vpa49ATWG9EMXHxFj38NHD0GfhF2Ho0MQKKy/v3txjBw2h/03rZrUIx59JoHZRQSb6h3KQmurwY9COZq/VEZx/NSh6VguWadFaNfNYmjz0G80I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783181324; c=relaxed/simple;
	bh=wjEuLU1CJf1Zs2tXMZxRP+871Bsd20sx3b5ZT1x35tE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dT15FZIhLVMefbEduP7KlRF4PKShE8mdZkFL3COektG1JhpPBTzCLNsdydLivLcNj4LyVgE5bCiivMnSB78QM0dHQMg7n5N2/vYcA8NEBi/hZzgZeB1VttNPSKbJstertUNZfx4WkjH01mPHKDoPDNMi0DeYyYaFmKGqdO7DKEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqdl5Rag; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqdl5Rag"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-698a9f11776so2107744a12.1
        for <stable@vger.kernel.org>; Sat, 04 Jul 2026 09:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783181319; x=1783786119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q4PVKheO70omY7vqhOkhAKukkc1icX8PYGa0AwAUYlQ=;
        b=gqdl5RagVKpJ+nqyuzL6mXbrz7Ti49Tu+xW3h/uI5T8bbDGodSXc06roYdqHpPvOOw
         hAkRTiRoGw/8WnoBx/zxnH1v/93RAncJoA/zbjHPX73RVjKnixNDvDRxL9TmrUW7hEEI
         liEasWDAzJggc9EdBx3jl6//ofrKbUWchzDgBhCa3DNN1S0D8AhtOumLm22/1mVhLBPu
         oPLp4SHrE6JxdlE9ZLpSR5ahS3h5WuaWWvScd1WhqUZ3r/KY74ylBYNKADatxm2TDbmy
         UxRGYoW2eroy1Qlzpcqwih6jpzOQhI5fI7UxFf1jJ4nOBJlyedJi52BBkRRyi3mfMK8t
         vBNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783181319; x=1783786119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q4PVKheO70omY7vqhOkhAKukkc1icX8PYGa0AwAUYlQ=;
        b=HWY34JAVdwPMap5JOzvQXkyGpWJLRahPNAdkQuMsKL7oQQDGFp4d8sUUMBiLxCdLi9
         9/9VNYuQjlwH3won7ytGLzaAV7wAu8tMZL3ryqllLvTDLRePXsmeLOymEPsyaDoN19HF
         ujbldzlYWkgCcBmoYW4UNiiz2s8IIYECq3W+IwRh3IZMvWrmkLz3SROxB4p/zmp5KxxV
         2808j68NYbePA3SU2LhI/9YNPMWyWn7MDNXDVM0qWyCKCXZlnVlpB/nYWb74Xh0DFEwb
         Gany49eJE+nNn+NpES34meIydnedmw14JLYKmvIqtCbW0MnxRCxKV7PD74/3KhiXdGDT
         X1NQ==
X-Gm-Message-State: AOJu0YzCGnhnZHWK1Nrq8LFXc9fJneDbCz0j86Ih0lYFp8/NckJRehkk
	8cFt6Y7Zc6ydZRo7AxsGfC9biJ+hhJLvqircOvKMOUXzslI6Be/JGbT7
X-Gm-Gg: AfdE7cnrV6nYO0ePDubs/d9R6RHctI7zwaRQTFz7B+ki+lzL2w5P2cOx5K6gXc2WqI8
	P7ghlM6DD0pYRWfXW/BUnJkdo19caUz+2jqaalLtda2AwoCKwl5SqzkYYHZ4UYeki8GaE7nBDaD
	3p6jyix/GB5SLxnOAdbuaY2V+djKqPzgbv5ktBLvBUP8HajqzT/7bNylVeVwuFXfpcUF97LLZHN
	J3IA4ORVNZx7jyjivxA2vaU7VEtH/KM9kl3JGdQsYOA30JwSMC1J4g4oQCG6zg65HEokrcO91Tj
	nOB7WvmAOuo8nloMVOB2sgyWYRWFVqx1hK7joI6AYuFqp49kAR1SZ2L9oCOyNbVonE8qt6gtrYY
	XeT9HZwy3ITHC07gS3G8NYIrY6Y0aCdkB3e5fvAcBt7B5HQceC000zIcaB+rVNvRwf1T0osXaR3
	rmzmy6Crpr+KHx6OprS2J/hDRmUDDt2BVfAovd686JHgEd3lbJzFtEiYE4N9pCDzI=
X-Received: by 2002:a17:906:99c1:b0:c0e:883e:e4f2 with SMTP id a640c23a62f3a-c12e6c2fccemr104916966b.30.1783181318994;
        Sat, 04 Jul 2026 09:08:38 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b60575c4sm438586266b.9.2026.07.04.09.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 09:08:38 -0700 (PDT)
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
Subject: [PATCH v2 3/3] platform/x86: hp-bioscfg: warn on element type mismatch instead of failing
Date: Sat,  4 Jul 2026 21:07:59 +0500
Message-ID: <20260704160759.236249-4-meatuni001@gmail.com>
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

