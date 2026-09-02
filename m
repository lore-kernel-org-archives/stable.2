Received: from outbound.soverin.net (outbound.soverin.net [185.233.34.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977AE2DF156;
	Wed,  2 Sep 2026 07:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.34.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788335353; cv=none; b=ppR0Es+z4mARa/+o908zp8ytpi+7Sg6kU39QFwg01B2zCXdQChiI7IjF6BHHU/18dNhBcCXgnEE8W5zCT/dazL/ORxlNt0uh+pus3CeQmTqc5xeNaFhPWtL9+LIWK31wMsok+188Knlifvd5G2VR6e+k7BLc5NrbYQ3H6h4DxeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788335353; c=relaxed/simple;
	bh=TqxZRHh11tGrsfSeQh1VCC4BJox2NHc74rra3jbkRe4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bv4EpvYRNkFQcuFGFOOfurS6jILmhwKOTJ7YiYqC0+OhaJ1U3auvj+OIyGwuF2rgcYedTYkXRxPM8ivUYE1nBoUcsbEZR25uYpyYCtYePJEsuWfwH075UGwiwzrqhl8158Ri0l+WGZED0PmktcU19jl2wRpc+tUYEGhoNXnmVic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lewisclement.nl; spf=pass smtp.mailfrom=lewisclement.nl; dkim=pass (2048-bit key) header.d=lewisclement.nl header.i=@lewisclement.nl header.b=P5LiB1vs; arc=none smtp.client-ip=185.233.34.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lewisclement.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lewisclement.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lewisclement.nl header.i=@lewisclement.nl header.b="P5LiB1vs"
Received: from smtp.soverin.net (unknown [10.10.4.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by outbound.soverin.net (Postfix) with ESMTPS id 4hZZRk73kLz1Z9W;
	Wed,  2 Sep 2026 07:41:38 +0000 (UTC)
Received: from smtp.soverin.net (smtp.soverin.net [10.10.4.99]) by soverin.net (Postfix) with ESMTPSA id 4hZZRk2wYWz9r;
	Wed,  2 Sep 2026 07:41:38 +0000 (UTC)
Authentication-Results: smtp.soverin.net;
	dkim=pass (2048-bit key; unprotected) header.d=lewisclement.nl header.i=@lewisclement.nl header.a=rsa-sha256 header.s=soverin1 header.b=P5LiB1vs;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lewisclement.nl;
	s=soverin1; t=1788334898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/JNp0g6f9x0w8D/VoiLN9dpu7SVnNhZShmMyCrXfYQQ=;
	b=P5LiB1vsTxDAjhPMVmpWMhIP5lXSJEK5/AHNxmxQpZxJ70cgjaiCg/pFhFMtmy9uDY/iPz
	d/OVTyqJZzDhjqyQmpKEWnUIzsTh93XF1FOFhIeTEEFc3T32pMJuWdbiqT5okYlXmQRR7z
	I59ved0lxFONEX7FII0+PvTCdcRYYx/v2hhpD2wdCOekGSWH0AkQg8ZjswGqEtEUProgZi
	YkthM9La6wPsgM0c7aJ3GWWKPniY2FgPPJ2g8WuJ3NVwS0Y4NjZL2JhvyzPXfeIyOnErsf
	nxoFYKDLdF4hvrQybYw0LL7p8kl891QwGyb3+JCdcIZLQCOWuLA4cpa22mN3kg==
X-CM-Envelope: MS4xfA3tel91+5X7uA1NvsgTQFfrow65uY61YSRmt/Cvn+tQpNeVzPb98Fpio4wFxD7ln9rQNx7cjqntkI0ck38h1hc/NBl/S59dwkXxuMtGauOvjETDNUq5 rxQK0mG15/ag80yz4cvyLEMdwpmCKidvFFIiVV5DQ1YXpKHF3HRPYvaOH9mGckGLyZVNE5Lrf26NY0PedQ68djt3QjFb3h01pVQvfZ3xvrerMt00bNkkVsRz 7mdwAjz901luMCeQaIImD8urLFWCtkXTZwO6GDZXGJQewFlfFSyPipz5+p0sTpVO/lstOqi1USua2NJEmBSsIrv+Mft1B9r5vy7IccZDbtjYHsXAkyM7BnrV Un+uAVqUxces1eVl/fTpuHiI9+dPDjSNUh9wZ4gGknzLGmn8ORxbf7Co+PUZNzheAIiyV8Ty
X-Soverin-Id: 01a06110-fb50-7fb7-8c99-b09f36b33fa1
From: Lewis Clement <lewis@lewisclement.nl>
To: platform-driver-x86@vger.kernel.org
Cc: kuurtb@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	stable@vger.kernel.org,
	Lewis Clement <lewis@lewisclement.nl>
Subject: [PATCH] platform/x86: alienware-wmi-wmax: Do not enable G-Mode for Dell G-series
Date: Wed,  2 Sep 2026 09:40:50 +0200
Message-ID: <20260902074053.59910-1-lewis@lewisclement.nl>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spampanel-Class: ham

The alienware-wmi-wmax driver auto-engages EC G-Mode (Game Shift) for
Dell G-series laptops when the platform profile is set to "performance".
On models like the Dell G5 SE 5505, this pins both fans at 100% (~5400 RPM)
permanently on every boot.

Fix this by:
1. Setting generic_quirks (gmode=false) for G-series DMI entries so
   selecting "performance" no longer toggles G-Mode.
2. In awcc_platform_profile_probe(), mapping PLATFORM_PROFILE_PERFORMANCE
   to balanced-performance when no dedicated performance profile exists,
   keeping the option available with sane fan behavior.

This mirrors commit e2468dc70074 ("Revert "platform/x86:
alienware-wmi-wmax: Add G-Mode support to Alienware m16 R1"").

Fixes: 202a86120590 ("platform/x86: alienware-wmi-wmax: Extend support to more laptops")
Tested-by: Lewis Clement <lewis@lewisclement.nl>
Signed-off-by: Lewis Clement <lewis@lewisclement.nl>
---
Tested on a Dell G5 SE 5505 (Ryzen 4600H/4800H + RX 5600M, BIOS 1.24.0),
kernel 7.1.10 (module built out-of-tree against the running kernel):

- Before: fans pinned at ~5400 RPM on every cold boot with
  profile=performance; cleared only by suspend/resume.
- After: fans normal (~2400 RPM, scaling with temperature) with
  profile=performance; survives cold reboot; "performance" remains in
  /sys/firmware/acpi/platform_profile_choices.
- Also validated the intermediate gmode=false-only variant (option
  disappears -> tuned-ppd write rejected as EOPNOTSUPP), which confirmed
  G-Mode was the only fan-pinning path.

Cc: platform-driver-x86@vger.kernel.org
Cc: Kurt Borja <kuurtb@gmail.com>
Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: stable@vger.kernel.org # 6.15+

 .../platform/x86/dell/alienware-wmi-wmax.c    | 22 +++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index d1b4df91401b..26ba91539b6e 100644
--- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
+++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
@@ -207,7 +207,7 @@ static const struct dmi_system_id awcc_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Dell G15"),
 		},
-		.driver_data = &g_series_quirks,
+		.driver_data = &generic_quirks,
 	},
 	{
 		.ident = "Dell Inc. G16",
@@ -215,7 +215,7 @@ static const struct dmi_system_id awcc_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Dell G16"),
 		},
-		.driver_data = &g_series_quirks,
+		.driver_data = &generic_quirks,
 	},
 	{
 		.ident = "Dell Inc. G3",
@@ -223,7 +223,7 @@ static const struct dmi_system_id awcc_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "G3"),
 		},
-		.driver_data = &g_series_quirks,
+		.driver_data = &generic_quirks,
 	},
 	{
 		.ident = "Dell Inc. G5",
@@ -231,7 +231,7 @@ static const struct dmi_system_id awcc_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "G5"),
 		},
-		.driver_data = &g_series_quirks,
+		.driver_data = &generic_quirks,
 	},
 	{}
 };
@@ -1345,6 +1345,20 @@ static int awcc_platform_profile_probe(void *drvdata, unsigned long *choices)
 		__set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
 	}
 
+	/*
+	 * Some models (e.g. the Dell G5 SE) have no dedicated "performance"
+	 * EC profile and map PLATFORM_PROFILE_PERFORMANCE only to G-Mode,
+	 * which runs the fans at 100%. When G-Mode is not used, fall back to
+	 * the balanced-performance profile so the option stays available with
+	 * sane fan behavior.
+	 */
+	if (!test_bit(PLATFORM_PROFILE_PERFORMANCE, choices) &&
+	    test_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, choices)) {
+		priv->supported_profiles[PLATFORM_PROFILE_PERFORMANCE] =
+			priv->supported_profiles[PLATFORM_PROFILE_BALANCED_PERFORMANCE];
+		__set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
+	}
+
 	/* Every model supports the "custom" profile */
 	priv->supported_profiles[PLATFORM_PROFILE_CUSTOM] =
 		AWCC_PROFILE_SPECIAL_CUSTOM;
-- 
2.55.0

