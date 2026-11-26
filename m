Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795699901;
	b=rozlif0JXAHyOs8B1ubyVDdKpDRij1Jqujju/IFVEzSxRwLtlskd9/6KkUJHKdFavD70
	 jbHa+sKwHRp5hOuz6xLT/hJG713tFJ0OWZg35McfX7fJMkW4yu23gPhSlIajE8bQp5vru
	 tyfrbewEbq/gfDgtPqjBQfJ41snsm/RrBazEcMxEmxo0o4NsOreVkGswbsm0oL9o2kF7v
	 zhI1hroTJ4P0XWuAgB31k19JqyD0tM198v5E1YdAW3x+S6+SlW8wlUw8ncLJ1wFL/AYQm
	 wKHBYeD6ONOk/km2qrlFda+KsbLWcQWgXtyIZtCoP8ZcGsbwEPPTP5rKKs31IKlE3sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795699901;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4bpLkGggKND4rdI5aeb1fC1YriisxypN5V4Ha9pY8nc=;
	b=Uihjreo0/Nvfxbf69uEBC3IauGoyyh1ZxtcbCa8RW48NzyyxDpXJfSASfRY0+XJmEQCT
	 cgD13gJs9M0/IXf3EvDts9/wMNYA+SEiiGOZDS7mcGeY8Xdifrz6YhR6L3rY6OWFF8Mfg
	 B7lFIEDGLTbxSa8fe81RQdA6kVKUMvPxSmTYCPBSzgSUyEqYitAviEYuenyyfgOgfnfOl
	 JV7639viyHR5d14rHqx4SlIv+HGiwjhqh/7IXeeT9lx3ikWbIDXhf91MW4ygSCN03jKxK
	 3qodx0OE0oTT1pWq5e4LlAZhbS+LqAf1KhfqUd65p49GQ49wnDXRFp4p2m+F7FRIW0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ex4MPbIQ;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944E7606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 13:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 944E7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ex4MPbIQ
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3869f03af6aso6167213eec.1
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 05:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795699901; x=1796304701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4bpLkGggKND4rdI5aeb1fC1YriisxypN5V4Ha9pY8nc=;
        b=Ex4MPbIQnlsBn7GAG4/VCuSYs61TCmhayVVfq0Y2vPPT1s2YO2jM1Wo16z1gICrh8C
         gk0/EROp+S/tI22esTQi/MuxCWTZHMtMv7Y19sYaiRE27ynUhlKUBUI0LrW8lGbHvU8w
         WOXbaSFDHR843eYyhcdP0O0oioe2SiAynDEpEefqLDL9o1N6K3IxwKxRMl5b2DiUr4WG
         ByMLICKpZAmRIpHEN7UOAMOIbNKLjP4oNQvhwBTxkr3DpG7AmgkJC+KUMNQjMJ3s6yTX
         zfFVYGyUdGAwQp/TVxPLn217yeFpHpXE2MjJYOOmM5JbYDaO78rrvt75w59X4j3I9yE7
         7+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795699901; x=1796304701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4bpLkGggKND4rdI5aeb1fC1YriisxypN5V4Ha9pY8nc=;
        b=PpJFWnyAWCJZJLmxXltSwQq23KHaVoVItjUozFRjAaG4bN93nT+yLMu7OlxLdt/vcH
         ZewwF45yZU4rgKCcFn5h51OppOUdPZ1fnO4DPBppVBCyeQadtq1/S6H50WsfO1JSaUrk
         BJSJsMbEYuV8WNcd0GX4l0g0QICKCOouiKLDfMV8SaMpgWUGQv601urc3Es7Th5ztTOb
         tOkJmvlhmDNdYc4WlCLfQsidb1gt8zeYcWDT/S6NW1gKQEPv648S2T83DLgawSdme+a5
         fuvzVm4y9InnW89by0Uy/R3FJaT5pOanR7uiU8phCk5eoi+zO+/FS3CKucPuVOw2UyZI
         +Azg==
X-Forwarded-Encrypted: i=1; AL+hErGZI/oHHFCEDsmQUy2aWow5Fc+IcP8bloOdiutagonKHZH6jH4Qv59B1FvEVRi1tuHP8sDsBXI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+AuKSHXzVCEq7TqEv9hPvSHjVYnc8YL0AKlpRxLyriDg/VYr1A
	FZoZthCEMg705csoRYVArm+5jy47FEU0JFO3dsGK7NlUd8H9RspqJoE=
X-Gm-Gg: AZFdTZfU78bWXTcrlfdOm+Ej1X/qB5cyHcP7ysTNmE1QVir6Vy44H5rfwM4iCrxS8mJ
	xviExKLw+lf//xiSgcfVsTqdAd1pNYuT/6pFYuT/rHYM7me7CmzOcyDqx2KRAVsu9S8y/lyRn4A
	9hufE74IHkdioh66TAWMwQ11TpKIlL/OMCF2loLJflYflg0CTEyWWSeamNsZ1cok5cgMrEc+RSo
	Od7hJDoERKtJkBhsGhzbx1QmYitmLEKGP6CnL//5X3V2zER3kmAIK4861Xc3a8GkmuXE3D74CvA
	KlrpNvzTExkJbcgcf1y+Wei+NCXCCnamJb4zQrmmz7Y73eHinHms0bhb0ydy3QHkhrRB9W3JONO
	mmqb6z92tqJkJpF1WlS910CExMhjdLMZZXv3Jksp2RtHYZMffneHlij+txlM9YTFnCHQxk1+UbM
	9MCIEgGQm9BEZZ8We4B2gI9WYrJTeTe4V3RWPVOE2aLV7xmGC9ND9bhGuY2oRrtef73DZMQ1rhD
	qDlo7AXBAjlk2yYo7kf1AN3FVp9gp3q0Q3hdNpE+TkW4duN66HAC3/drGcUFbhA9WNuUiLqgj8w
	j/k5ntmi/KYsIqJFUbr4wOfrP6edDha0Cnw7NAWnJSXmfJDQ/Jo2noaaTIsf/KiAt6UmuplWYvr
	GOwlhypcUZyku
X-Received: by 2002:a05:693c:20ce:20b0:381:761b:f335 with SMTP id 5a478bee46e88-3856f94eda0mr22296290eec.6.1795699900556;
        Thu, 26 Nov 2026 05:31:40 -0800 (PST)
Received: from localhost.localdomain ([2406:3003:2002:639c:a06e:23f:85ed:4cfe])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386992b404bsm50244649eec.1.2026.11.26.05.31.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Nov 2026 05:31:40 -0800 (PST)
From: Yige Jiang <yigejiang86@gmail.com>
To: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Cc: Yige Jiang <yigejiang86@gmail.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] bcma: Release the found cores when the bus scan fails
Date: Thu, 26 Nov 2026 21:31:36 +0800
Message-ID: <rc-b1-20261110-vc-96-1d8d0afe258d@gmail.com>
X-Mailer: git-send-email 2.50.1
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

bcma_bus_scan() initializes each core it finds with bcma_prepare_core()
and links it on bus->cores. If a later EROM entry is malformed, or an
allocation or ioremap() fails, the scan returns an error with those
cores still linked, and neither host cleans them up:
bcma_host_pci_probe() jumps past bcma_unregister_cores() and frees the
bus, and bcma_host_soc_probe() only unmaps its MMIO window.

Each failed probe therefore leaks the device reference of every core
found so far, and with it the core, its name and, on SoC hosts, its
ioremap() mappings. The Sashiko AI review reported this as a
pre-existing issue in October 2026; an unmerged patch by Haotian Zhang
from August 2026 would have covered the SoC path as a side effect.

Release the cores in bcma_bus_scan() when it fails, with put_device()
as bcma_unregister_cores() does for cores that were never registered,
and reset bus->nr_cores so the bus is not treated as already scanned.
put_device() is the right release only since commit b63aed3ff195
("bcma: Fix memory leak for internally-handled cores"), which made
bcma_prepare_core() call device_initialize().

Fixes: 8369ae33b705 ("bcma: add Broadcom specific AMBA bus driver")
Cc: stable@vger.kernel.org # 5.15.x
Link: https://patchwork.kernel.org/project/linux-wireless/patch/20260813100836.2913-1-vulab@iscas.ac.cn/
Link: https://sashiko.dev/#/patchset/87897
Signed-off-by: Yige Jiang <yigejiang86@gmail.com>
---
Based on linux-next next-20261109 (630059a5a632).
Compile-tested: arm64, aarch64-linux-gnu-gcc 14.2.0, W=1, COMPILE_TEST=y, BCMA=m, BCMA_HOST_PCI=y, BCMA_HOST_SOC=y, OF_DYNAMIC=y; drivers/bcma/{main,scan}.o built before and after, no new warnings.
No hardware or runtime test was performed.

Needs bcma_bus_scan() to fail after at least one core was found: a malformed EROM entry, or an allocation/ioremap() failure.

 drivers/bcma/scan.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/bcma/scan.c b/drivers/bcma/scan.c
index 84742408a59c..6aea15f54b30 100644
--- a/drivers/bcma/scan.c
+++ b/drivers/bcma/scan.c
@@ -520,5 +520,16 @@ int bcma_bus_scan(struct bcma_bus *bus)
 	if (bus->hosttype == BCMA_HOSTTYPE_SOC)
 		iounmap(eromptr);
 
+	if (err) {
+		struct bcma_device *core, *tmp;
+
+		/* Release the cores found before the failure */
+		list_for_each_entry_safe(core, tmp, &bus->cores, list) {
+			list_del(&core->list);
+			put_device(&core->dev);
+		}
+		bus->nr_cores = 0;
+	}
+
 	return err;
 }

base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
