Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795265641;
	b=o/o5aecsVBfdShSICy3bK9XHKNttiwDC6vJ3UROKBwRat+kCny2MxMYw+haAvKTOMFjt
	 sjFoTK3pCKwkRa4+JGH1VFBRfvsl1T+f1mlS+pfSIheSuIri8/nssgoprF/OyrQ0DxDHk
	 5B20bndJZNl0RBya/pgnE4nrAUXLKeFEA9EwACp50PkoUm7YpdsLz7m2oaVVsjgXW9Bbk
	 nNJB2rLDE0bLmUrNOghwjMamsfIXorXiaYaEGWLuLNO0vx3jq77AhZGKV7nVNeQnDGvUq
	 iPpoSrPUT5b018PHjK4W+7i3OUfS+J8ZUD0aT8tpsbJ7nXd3ptg0K+dXVkSNqRBX4Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795265641;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=FgvFBR0X911CFkft+m8BaNuu7kHa0PuRcgZI2MmyPWU=;
	b=0jJH8Uc4ZRqnZtUlU0aaL8Ur7BXy4yfEztGo1keKSwsjxPVt3HwK601yPXvW21qNcwAB
	 qhj5PNKsxVzTom8DMeQvEctJJ7RpCoFMPsvCmYWwrcDGjWmJgS243gKeK8j4B8xzUYcWg
	 PRVwz5gA4J5XauEgqrCrBx71cNGnceYaiYOZWGdksTOS2D39yquQ1WSSdzzkjE15PQ7SU
	 PUAlxVu1P1S2Nwg3ixQc50BfBiFfxyyM7rFpd6xxGDK7eGJPNI998g6TsPCsGID4G1RXo
	 4YX+Rw47IxfzF4jWHBG8wMwI8aTXJtjN59NQggWLYQdynTaPdDR7PFQ1uyv7YsmTjSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z39VZU0d;
	arc=none smtp.remote-ip=74.125.225.139
Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6B8606A32A
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 12:54:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E6B8606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z39VZU0d
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-4a5f76661b5so6536865e9.0
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 04:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795265639; x=1795870439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FgvFBR0X911CFkft+m8BaNuu7kHa0PuRcgZI2MmyPWU=;
        b=z39VZU0dqtn9kYyfaDyAKgib3xIksgKtBeCjirM1HX6p41OyYALNbz1anmDI2lV8LF
         Er9SMg2QxA8pNL0XSCDYLp50q/ehl6lm6xmPAjJyQVdMVw3nhODjnd5YFEKd93DV8cVE
         ewCsLFReMnfVYa2rT1INKMu+Deo0yNvgCIhpJXm/rZTvRfej8J0T8vX0EouyRm2xr25f
         35liin1vll/j4c0WcQh4FiACL0sU88kujT5RMucj+EsoG4i2oNdOpHZR+e33VkKqQNcA
         XxBDviTStAyGK3xU7B3UmZitisOjzCleyhmAGtXrx0Ekv9cHQECCED63DgpR8bQpurn5
         iutQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795265639; x=1795870439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FgvFBR0X911CFkft+m8BaNuu7kHa0PuRcgZI2MmyPWU=;
        b=pluqPY1YyusSiUYbWIddKlFwgMV7JEoviz7le8F6blY+FRlNRSsKqYaf66RqLDZsVA
         B7EAWaVur8ADuVuCb8CLjhaPb9XwKPxzCE0v+NW7Q8ci0uAVlNm9ZcLvFWiuXDAPhi6z
         9QUM8yRCghZz69hoMIhyA5YsMQGaFWxcolVVJNb7kDH0T1RgiQdHvCC5OR7GIS2cb67Q
         civ7Rp+YS2ZDEYO9q7JOEEgnxHQaL/WmT1ctRqqHZzjnoIDWqoT9uBpArN9HcvKfbKE9
         x2LDG2OAeusgdsVKAxlI/8IezqH3/YNocKvNZ3STaEgFaIPExIZh0bGOgGcBvSLQUpY0
         ZjXw==
X-Forwarded-Encrypted: i=1; AL+hErEz3Q+fyp4F19D2TZnxvUulusFtJgU50ZK7hj7RixYqHE/AJU3cg6RACy1H/CaW3VJP33aknY8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/JZxp8DHpZenTdwwrGWTBxyppK2VVnAqNffGD7zhGvMFbMmctS
	ZvGIETb7Kv+BnzNlFcLzcWIDNfzNGaP62ER8h7JElX7987qrC/95J5X7
X-Gm-Gg: AZFdTZdgbdieeTgJD5HL44sAWQOu49CIeyDX9S82S9MdBjQzEUWzdyR52tG9NSjxnKs
	2OmTVajdTxapDRwHi/1Du6T7DR8EdlfVYGnQijIzx36m2qehKCrup0KEuvxxYJJySjMF7HLSZCO
	VaB5PpN4WpyCVHug/n89usqehAeRtXMbDhkKBAdWluaMNolfvgbh7/O7wUtRQgSwsOqOfpYaLCO
	+hsh251zNRoIW7RvA0jKpXuF6vDR22w2FGnksmSS35YLnWs0lZFRKARbE5HwzmYnAQOyYpBCz1D
	YW850mpcY1PqaNh8ioPC+DNaN3bN1W+yVchXuF6WRWHBaSQVz77/ecESlJ3x5uu3n3NWxOZBanx
	8dP+3HhrFv9wSEDxn9+rMIEPqXm2p8e5N47kW2eAttDHhucPx/h04/GpnHwCtM4AfRoB+nj1mMc
	AL71MjYU+XG0ajmv4aEPkdlsJB/h94/6KNzffiAt9Fo3IZPVt31MKGYczEXHRWSbonSiuJGW42h
	TRrmqdkmKejm28qhkKTgGaIRPchu+fx3J+OON5ZVvKhky0fS5tCSvr28avFif79pafX1mJC/8f1
	Jdt3Yld3d/PhAFbzSZbSih5QHx6g3rm/wiK9P27UMMvFHA==
X-Received: by 2002:a05:600c:674d:b0:4a0:1fb9:2f51 with SMTP id 5b1f17b1804b1-4bb88808263mr145949025e9.14.1795265639269;
        Sat, 21 Nov 2026 04:53:59 -0800 (PST)
Received: from bullo-XPS.home ([2a01:e11:1020:c3f0:892:8c82:19f1:6d0d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb9066f6e6sm40009215e9.3.2026.11.21.04.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 04:53:58 -0800 (PST)
From: Bullo27 <matteo.bulloni.27@gmail.com>
X-Google-Original-From: Bullo27 <matteo.bulloni@mail.polimi.it>
To: platform-driver-x86@vger.kernel.org
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Matteo Bulloni <matteo.bulloni.27@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] platform/x86/amd/pmc: Add T14s Gen2 AMD (20XG) to s2idle quirk list
Date: Sat, 21 Nov 2026 13:52:07 +0100
Message-ID: <20261121125207.12284-1-matteo.bulloni@mail.polimi.it>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matteo Bulloni <matteo.bulloni.27@gmail.com>

The ThinkPad T14s Gen 2 AMD is sold under two machine types, 20XF and
20XG, but only 20XF is in the s2idle quirk list. On 20XG machines the
Lenovo BIOS SMI handler runs during the NVMe D3->D0 transition, so every
resume from s2idle stalls for about 10 seconds with a black screen.

Measured on a 20XGS08D00 (BIOS R1NET68W 1.38, Ryzen 7 PRO 5850U) with
pm_print_times: every PCI endpoint's pci_pm_resume_noirq returned after
~10.32 s, all finishing at the same moment. With the s2idle_bug_mmio
workaround applied for 20XG, the same callbacks take 38-82 ms and the
stall is gone.

Cc: stable@vger.kernel.org
Signed-off-by: Matteo Bulloni <matteo.bulloni.27@gmail.com>
---
 drivers/platform/x86/amd/pmc/pmc-quirks.c | 8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/platform/x86/amd/pmc/pmc-quirks.c
+++ b/drivers/platform/x86/amd/pmc/pmc-quirks.c
@@ -56,6 +56,14 @@
 		}
 	},
 	{
+		.ident = "T14s Gen2 AMD",
+		.driver_data = &quirk_s2idle_spurious_8042,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "20XG"),
+		}
+	},
+	{
 		.ident = "X13 Gen2 AMD",
 		.driver_data = &quirk_s2idle_spurious_8042,
 		.matches = {
-- 
2.43.0

