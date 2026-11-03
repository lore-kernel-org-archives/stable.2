Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793712263;
	b=Y77QG4jYZO2zXdx0DU2IFR5fcR49Ai0k+edprvb47yvwgncz5mvGL5L8Xj2oWsTMzkGz
	 QdaN1VvD9yRWvMh+KkIbs+W7FuFRuhn/COvUzm43X8sFXzynh/EyAkelXFGG1gOoaOFxm
	 hZK/5faJ3PpOOoDnGfsqV/h/WEz4kq2YlDAWSGF9VWU5MvqXpH14bRF7pVcvgPvmgsrmN
	 m7qDvFTL4wd1hFZXKYNA/0ycHRvYOMV9UWH7FrE7BihGHZspgl4KKhWs/TrLyNVNuInD5
	 0FS9cewDuwuVWE5dT+fQAUK3/BPQiE0SvdiH0Mn0LxGMQH6fqEdlcCfe7BaRv5l7sPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793712263;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=2j0GMs1294BoS0QgCrjSsNNwFi17Dnm1SAfspQeLyKw=;
	b=nDn27iuRSBz0d/PTE1fULD1hqt/sKxl/BRrCk0v5GpN+76dkJUCMe4zawWhT2xoR+dO7
	 5fe9EuWxW3lBRJvX5XRzngnDZr67lHIwV3KrHQF7k3jTPPvbQcqeUi4+7FbbHDJOMElfc
	 lgNBHAmpNOjT5ALHcACa1D7WfmGWjJKlqhyN6PMpOfpKrIqtx9L3xtimNc6N5kTemCjW0
	 BzpZfXgfdjSdCUheGaU8s9JBG3es/VdIb6XcSx1YedbJinwHqyGnasKXc9tDqhKd8hXFv
	 7Eb2kz5VVZpZkJGvJlSZaQcC2ovgzMFGCso08LdtuTsIN76UIRp7e+rtzZLUgXjMVag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ftOEIgad;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD6C606A32E
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 13:24:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AD6C606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ftOEIgad
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a214af2076so32021065e9.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 05:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1793712261; x=1794317061; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2j0GMs1294BoS0QgCrjSsNNwFi17Dnm1SAfspQeLyKw=;
        b=ftOEIgadY8W0LAJnkXXgN0QtEq3/FP+QPVbndYenNNSBW9T1qhi8kSL3zwCjBwffS/
         a5aQGC/hg7bNcK/3BQh47VdySgCybacc032j9tUvbAGA8w9I9jN9qaMqjvIXgtVeaUpf
         yw0zXUu3X6yc4my7Ltu54Yde+oSBvHwUIAhp7ehOavw4DQZwgrj5l9KT7Atg/SwrAZq5
         Eah8hgcrQeFbzk6RK7x6mHX9Fk+Q6L6UNNOsGZgqN1t1HwWAGzVVuAVYd4QxBqgd5ru9
         1WBT9BL8kLOtpOrlWljRUr/59Wc5gztLPIcSORMVove8sgs7ete+Y9jrcCFPIqhBuKrQ
         dPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793712261; x=1794317061;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2j0GMs1294BoS0QgCrjSsNNwFi17Dnm1SAfspQeLyKw=;
        b=S7Zi4YpxDktEFbW5fvBh/zrrLt0QXG94Boq4UH1LhzETaTOr0jcduMe8iO8cJlcpls
         L5OOiGQd8kOh2MAknz+KVtEAOtyu9oMR1O7etxAflCszDEYOOi6kVJM9CpZi05itrkg6
         SfC9JcYrknk1emDF4dCnLpsc/cdVDJmZuS6NlrdrSC5cBfRgtUtBhvd0j5FxPBC242f0
         jhWsLJ2UZUFC/TPTKcAaIlrBZtyUcO+3/u8hI6z9KY40amlY2XILejn/e+aPBT0gu61+
         61IkwRztF2bln6Vk4VUruAFd+VKpaYv8LL9TkC6YG/1MYsJNHrjDPl+hz//qc9ZLZcHe
         Kj9w==
X-Forwarded-Encrypted: i=1; AKwUvBzkfM7394FWTyprf38a73qoBeCd9bx4AA92rH6EcA6hrHUMIdGnNY28P7ITiimgd/mX8Ynb9Ao=@vger.kernel.org
X-Gm-Message-State: APuU4Z/XknTIYyUhzcT2AoNY0j+XQOn/+HS5Mle4kUG5KxdUVLB2F36p
	wLjIczm3dndC2H+F0KRrf+JenxF/PFtg2gXgK0FEDekEaBq30yr1bZ+28HM8MnCPvAM=
X-Gm-Gg: AYBFou2Nhbc3lnafTd3j+AtrL0oul7K9FnlV3aL7Pow3y4a4qSUF9sNWlVI80pshjiq
	R0x6CqMpdMBv81AotIsRwCucSf/5naxuiX12gtPqN121CXlYBQAN3CEf8rZNWVNJm3Qr/StBOON
	JBCGBysdiNCQ01LGWO6at0+GkFxhXS7uN1kKcuJBIU4OGqQGvSRDQZAPxR8UCZYcw4oS2DlDCCS
	T+oKpuYYqgnV5n1A4uSJJD/X0tpY5gMZ+eBQcjEHYbktNDt0XqQBdCZlqHGMF7/Quu0HOEIXE3N
	ihXAjsQHH98SSr++wRs9tER/JBUsw+PZq55E4fm2ujwuwlUzTXpVssgrtaR1VCvtbB+FNQO3bzn
	irCZTB92oBwGfv5e6RVwd1PDbJRlpnXXUHQKWSQaGTa/EV/jff+dTxXvto9xXviBRJ+ONmDtcF2
	g3gS5qTvUoSHiwkKJuyS6sLTHfhc/Vcxgl92aOay/qGXkOr8yaI/h+fS1aeMQLHnZy/8gAsESGm
	6/pUD4Ta7aQwV6jfp1/oWyKqbng6DgfrGPTSf2WZQBD3iKu2nko53PYa5lDNV+F9YpWdV+rF6VV
	XnsUrJXu18xlXrIII0H7ViLd8Q==
X-Received: by 2002:a05:600d:a:b0:4ac:aae6:6400 with SMTP id 5b1f17b1804b1-4acaae665a6mr224247265e9.13.1793712260624;
        Tue, 03 Nov 2026 05:24:20 -0800 (PST)
Received: from localhost ([2001:4090:a244:81d0:2c16:1c4d:8a04:e0bf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8011csm28284449f8f.31.2026.11.03.05.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 05:24:19 -0800 (PST)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Tue, 03 Nov 2026 14:24:03 +0100
Subject: [PATCH] bus: ti-sysc: Don't reserve the system timers on AM33xx
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-v7-3-topic-am335lpm-ti-sysc-v1-1-1b9a23b4a7c1@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAHLg6WoC/yXMwQ6CMAwA0F8hPdtkWyMEf8V4wFK0RmBZB9EQ/
 t2px3d5G5gkFYNTtUGSVU3nqcAfKuB7N90EtS+G4ELtHTlcGyTMc1TGbiQ6PuOIWdHexuhpcMG
 33PZ1A2WISQZ9/fbz5W9brg/h/C1h3z+Ok8lJfwAAAA==
X-Change-ID: 20261030-v7-3-topic-am335lpm-ti-sysc-13f0219c9d67
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Matthias Schiffer <matthias.schiffer@tq-group.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Julien Panis <jpanis@baylibre.com>, "Mendez, Judith" <jm@ti.com>, 
 "Francis, Sebin" <sebin.francis@ti.com>, stable@vger.kernel.org, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2495; i=msp@baylibre.com;
 h=from:subject:message-id; bh=nVuwYE9m11lYdl/oeJjVyknAejqd1mpWoS0UcE2QfJg=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqyXD6oj9lVMmdu1+oNC/u7HTrncbqHN86yzeVlXTFx1N
 7Tw8BuRjlIWBjEuBlkxRZbOxNC0//I7jyUvWrYZZg4rE8gQBi5OAZjIupeMDEsCTvq8DVS79WtF
 ttxF1gnM3y9IG965VbyeTckmdpFD7VuG/35rWZ/e5Nkfk7Ew/fhVSy4ZlpqNq4/MfdG35aGPeBl
 3KR8A
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

Commit
    3f6178392050 ("ti-sysc: allow OMAP2 and OMAP4 timers to be reserved on AM33xx")
introduced handling of am33 SoC timers that are already active as
reserved. During probe this means the clocks are enabled and a reference
is kept.

On AM33xx deep sleep is entered by the PM coprocessor which
requires the PER power domain to be idle. The system timer driver
disables the clock during suspend but the additional reference held by
ti-sysc leads to the PER power domain not being idle:

    pm33xx pm33xx: PM: Could not transition all powerdomains to target state

The reserved status is only needed where the
gpt12 system timer must be kept from idling, see commit
    3ff340e24c9d ("bus: ti-sysc: Fix gpt12 system timer issue with reserved status")

The timer configuration in the devicetree is the same on all SoCs, so
there is no reason to reserve the timers on AM33xx.

Return -ENODEV for the system timers on all other SoCs. Like -EBUSY it
stops the probe but the driver core doesn't report it as failure.

Fixes: 3f6178392050 ("ti-sysc: allow OMAP2 and OMAP4 timers to be reserved on AM33xx")
Cc: stable@vger.kernel.org
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 drivers/bus/ti-sysc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index e118b900c9ac..922a90d4c5a3 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -48,7 +48,6 @@ enum sysc_soc {
 	SOC_UNKNOWN,
 	SOC_2420,
 	SOC_2430,
-	SOC_AM33,
 	SOC_3430,
 	SOC_AM35,
 	SOC_3630,
@@ -2917,7 +2916,6 @@ static void ti_sysc_idle(struct work_struct *work)
 static const struct soc_device_attribute sysc_soc_match[] = {
 	SOC_FLAG("OMAP242*", SOC_2420),
 	SOC_FLAG("OMAP243*", SOC_2430),
-	SOC_FLAG("AM33*", SOC_AM33),
 	SOC_FLAG("AM35*", SOC_AM35),
 	SOC_FLAG("OMAP3[45]*", SOC_3430),
 	SOC_FLAG("OMAP3[67]*", SOC_3630),
@@ -3124,13 +3122,12 @@ static int sysc_check_active_timer(struct sysc *ddata)
 	 * A to B4 at some point.
 	 */
 	switch (sysc_soc->soc) {
-	case SOC_AM33:
 	case SOC_3430:
 	case SOC_AM35:
 		error = -ENXIO;
 		break;
 	default:
-		error = -EBUSY;
+		error = -ENODEV;
 	}
 
 	if ((ddata->cfg.quirks & SYSC_QUIRK_NO_RESET_ON_INIT) &&

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261030-v7-3-topic-am335lpm-ti-sysc-13f0219c9d67

Best regards,
--  
Markus Schneider-Pargmann (TI) <msp@baylibre.com>

