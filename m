Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795806595;
	b=pmV7NPB7WrTYj/exjg0EgbBc4dxjysGeM84qHjjNWB+Yc3BTesUe1F2b5v+KW+9OkcFx
	 mD+nbt6eKlF1dcauEN6O7khmz4UdQlD4WBdUGsEwDxFZsgpKqmrPC13OswnKvG+n2vShq
	 gDz5N+PM2fd5K36lh03W9yrvCT7IRLf9oVwvgNEZ9HVemVSXpSr06qXjfPE1PnP9IGxGg
	 KxK/uJcOsCGV/4Tf70PflpjZGf2Jv0lc0jg0VtqxfkaoLpiRmRjcwaOMaIrt726ZNpAfH
	 Z7UYv4Liqnu59cZUhX3y8k4mD7v0s9OfLFB+8fr2/SAuc4ufLlYcZtBX0AewAG2ObVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795806595;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=pPqjsPGv3eilo8FZQHSgEFw+4wPb6iLEdkbWG7h8j1k=;
	b=TYqI15wVb82Uq2WYHDeu0r7+hw8kwiRNf96p5KAN4MztZg6Vug337SquXgtcFIXXAGIA
	 aYfPtTd0Zlmwdiknb3KDg0rzcd4uuh14Rhj9pequ2Ww5cB+wA/6S9NN6/46bMeiWxhA/u
	 sBbg0u332bTNwRJG5058tpXJ0oYnBedmixmSZGUQTkRifr035a6sF0LXZyoFv18DKouyl
	 xGrf4f4mxArKaFeBYPgBxL73M6QSA0KNS9vtoO9xvbnYtEACyrl5WeuoV7zOaWUSx8Nx0
	 n3t0V2fvgYx/w4ZXxZw5qEpCtKpp3iktXg1uW0UVlPDN2RRcEyXoSX7TT1tUMpcciYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="V+Y3/Wxv";
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FA4606A321
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 19:09:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76FA4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=V+Y3/Wxv
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c51bf011392so354510166b.3
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 11:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795806594; x=1796411394; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pPqjsPGv3eilo8FZQHSgEFw+4wPb6iLEdkbWG7h8j1k=;
        b=V+Y3/Wxv3EQIonXFUaq/JKFEBf3WK2UbJPcbI2b0SojJ2IyT7ZRCcxvgc9C47fHL69
         jPMIwElCu+zJDWyWYtYBqGdAsKsbw6zu9uKZ4ErBd1Z2aMCfu7Ntl7qGJKmEZzhS5zU4
         ti/HB8wdq/cRr0V0RiONp35u2XoVNIniGbgdyKLmJdfDKU1J3ItwhWBldl9lleseKGuP
         ILWPDk2tHHcDw0cckNX/7WYRVfrgNA/YFvB2Rz2F4A2u4kHvj0pYW3cWSKvcMd5bTEMj
         QMbNUhOnC4vvcLsNJFHUmrxCpTCXeEyJu5bQe41325rgrnCUVlRLmafhrQVR/zXEhjpO
         gTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795806594; x=1796411394;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pPqjsPGv3eilo8FZQHSgEFw+4wPb6iLEdkbWG7h8j1k=;
        b=1Q7h9/GXGwiN3GpXr6Pb8U1TMuo2xNK4nioW2YwhlqVDjKBxMCgxILSwpraOQCTIVR
         ckdp1Et+etjWNLCUNofDr2geufZdcrzyGyPyQA8OLvsOU8D8bUc2bx6zvzxMOTI6rbBQ
         STeopcHzV35yd7+gySIrfkBkBh6ouFDhvKdRF0DCwUa1pb55mUEnBHvCqfulwRmDZR2j
         TJ9k1i0jI9mvLE7/w5KnjCnRHDHBfgbdnPPAYV0fO+S/Y2xRcZdJGtAC7juXlp6jFbQX
         i+9Q3fkOuqPY71IZb9pXLRp30hV1WEFz+XaqYSu+ygmlQh+ov7k0IMmT/cuyM3voM5x2
         hunA==
X-Forwarded-Encrypted: i=1; AL+hErEjpzBDnVwfQutgI99gh5TYD9eRBThQobI4CoVG41lU9PKZNl0/OZwZ/rRgaIY8v26lKWt4TjU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8k2MmW+shLA+mjEmvHeKWtL5fj8TopYx4NS81RIVJ1EGWIHTyT
	O6/GQ9BEQlTdDjmiNHZ9zv+n6yhI8glNb29w5j8ACE+fP0gMRhye5+XOCO1cBJXUOu8=
X-Gm-Gg: AZFdTZdoAVq0sR9d7Dve5hviSiKKU1PkN5JLAVhTdO562DFR+bKB+c+Z05/sDc0TpBx
	MeyXD+0paPUndB7dfBm0qhC82lyrOl53JcswIyIEph51kBGRBjxbObMWHtPxQchBkiSvKqfmiTu
	nW51I+lmwDQaLzlK0r8SjzeAewOjt7Cc0I9cOQwvXfC+LFj/NC8BX3Y8AvCfjXxCY9sORX9o/FG
	KC6oMnSgdXEmQcWEMbt5KhFeiqrlsOEUSwMZ8RdIh2A9PE6npaDPIfQUjQvOku2c48a/gJ1FkpU
	Je9DEJc9vlaNvYjV1Q4e/kxPnwJwnDGTH5/r6IuXIDlLoqAkLIkUaLZ7qpbcZYA0lvRjbTCpOR9
	NV7V7hPb+6OGoi21rA5JtSr1rDZe6bdy22T098EdZ6pjRdtwvtSC8dT4fFHqVqX6Tt1gz//v/Lj
	uEvZjEj1awPY+S1MqS6fLWeMKjXP8sgVIxja5qPiGgKIbEbEfN346vcWsNnwh/gzKxInrnO2FnV
	4h28KyRuUZkgiJo0G/v6E5StPRPLiKlwKllBuLPgkI2Sh0Ghr1gtras8Ov5fvqFBeUrQ+1k0Dwm
	XukKzCyoPwbjtFTvzhM8LSLUja1zPV2zHQlRDi3KMf33IS07eYXIGvcxtniQUjazQ6q/bEqfjOp
	gGOubS0WiPNiSELB20A==
X-Received: by 2002:a17:906:c10e:b0:c41:5e31:5184 with SMTP id a640c23a62f3a-c513a99abe6mr2111709066b.13.1795806593819;
        Fri, 27 Nov 2026 11:09:53 -0800 (PST)
Received: from puffmais2.c.googlers.com (226.124.90.34.bc.googleusercontent.com. [34.90.124.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afe85fdsm909175266b.69.2026.11.27.11.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 11:09:53 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH 0/6] power: supply: max77759: UAF, charger ABI, input
 limit, and supplier fixes
Date: Fri, 27 Nov 2026 19:09:51 +0000
Message-Id: <20261127-max77759-charger-fixes-v1-0-b364a0862d72@linaro.org>
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
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAH/VCWsC/x3LSwqAMAwA0atI1gZspQa9irioGjULP6QgQvHuB
 pfDYzIkVuEEXZFB+ZYk52HhygKmLR4ro8zW4CvfOOcD7vEhotCisa6suMjDCaObxkD1HKpIYPO
 l/IO9/fC+HzyzkaNoAAAA
X-Change-ID: 20261125-max77759-charger-fixes-a1cb573d50a7
To: Amit Sunil Dhamne <amitsd@google.com>, 
 Sebastian Reichel <sre@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lee Jones <lee@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
 kernel-team@android.com, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, mfd@lists.linux.dev, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 stable@vger.kernel.org, stable+noautosel@kernel.org
X-Mailer: b4 0.14.3

Hi,

Patches 1-5 are self-contained fixes for stable backporting with no
external dependencies. Patch 6 fixes supplier tracking to follow the
DT power-supplies relation instead of matching any "tcpm-source*"
supply by name; it carries Cc: stable+noautosel@kernel.org because it
requires v7.3+ power_supply_desc.init, the v7.4+ in-tree DTS
power-supplies property, and the core fixes listed below.

Summary:
- Fix a use-after-free of chg->tcpm_psy when the TCPM supplier unbinds.
- Report and program constant charge voltage in microvolts instead of
  millivolts.
- Disable AUTOIBUS alongside CHGIN_ILIM instead of relying on firmware
  state.
- Notify userspace and downstream consumers when supplier updates change
  the charger mode or input current limit.
- Sync existing supplier state at the end of probe so events emitted
  before probe or charger module reload are not missed.
- Follow the DT power-supplies relation via .external_power_changed
  instead of matching "tcpm-source" via the global notifier.

Prerequisites:
- power: supply: core: give each supply's epc_sem its own lockdep class
  https://lore.kernel.org/r/20261125-power-supply-epc-lockdep-key-v1-1-c8a41b8a4470@gmail.com
  Required for patch 6, which calls
  power_supply_get_property_from_supplier() from
  .external_power_changed and would otherwise trigger a PROVE_LOCKING
  false-positive recursive-lock warning on the first supplier event.
- power: supply: core: fix use-after-free of supplier names
  https://lore.kernel.org/r/20261126-psy-core-supplier-fixes-v1-1-33de6aa53cd8@linaro.org
  Fixes a pre-existing power_supply core UAF on supplier unbind/reload
  whenever DT power-supplies is populated (since the base driver already
  passes psy_cfg.fwnode), which is hit during supplier reload testing
  and by patch 6's supplier lookups.

Tested on Pixel 6 (Oriole) with USB-C charging, tcpci_maxim and
max77759_charger unload/reload cycles, and lockdep enabled.

Cheers
Andre'

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
André Draszik (6):
      power: supply: max77759: fix use-after-free of tcpm_psy
      power: supply: max77759: report charge voltage in uV
      power: supply: max77759: disable AUTOIBUS for CHGIN_ILIM
      power: supply: max77759: notify on mode or input limit change
      power: supply: max77759: sync supplier state at probe
      power: supply: max77759: follow the supplier from DT

 drivers/power/supply/max77759_charger.c | 244 +++++++++++++-------------------
 include/linux/mfd/max77759.h            |   1 +
 2 files changed, 100 insertions(+), 145 deletions(-)
---
base-commit: 3191063649dbf7c0d0b768e1f3655e4c5fc6edb5
change-id: 20261125-max77759-charger-fixes-a1cb573d50a7

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>

