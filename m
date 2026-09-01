Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6BB432E6F
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 15:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788276807; cv=none; b=JvHk5mc2BAdeNFCM+4xrOAiXL1SWTGsii2qLEW1X91ySfvBzdTbSYt8SD5pnkjbyInGxYZloej+HcdSA2qbMX3dEJasBd0GYPKYJNEbC0WMESUT8VOegHGsN0K9dvzGSPtEQXwLCrZTS6zNRDMe+PdoG5eoOHoKM1J0HuRBP+pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788276807; c=relaxed/simple;
	bh=265EXKY1LpSnh+xYZaVde+XE9Ub2EQ+extj0SjJz2p8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CBzUiXp1okpBSKplUYnAhL6dLFu+6Wn10UJXYds1m0b2fwjg6475CgKUIyiOgdk38A1mBFjNCDr5ElvXXAEJFq0cmBy0HWm0ZcWZOaKZDeYu39UUUzuf7kLLxn3LBV1eVoPP80xWv7O4mVZgjkRa0KCGF0r2cb1zdXJtjDvhw8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=LyOsI2RZ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="LyOsI2RZ"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49ccfae359fso8038735e9.3
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 08:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1788276803; x=1788881603; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KFq2GkDfRXlsOR078AWttqIDotbtBYpQKPjXjcs2jO4=;
        b=LyOsI2RZDXiDRwtRiRRUUjrEZxuzO8l+Klujx1y7iWjW7FSd+zSicoEFGLiRmuB7qg
         9F1CE5opUA5O5aL4ukNBReiCx3dhTtEb13IQn+481gh6SOmDXy95o5SkIzXc8GiUnE/S
         XjP9uvAN31jCRVdliuL+M/7jWohzG/ljAuUjKLaj79nIS85h+w2M0j2cu1I1Odhm+IjS
         W4ZjGpDJG6Mepw/baA3+9Helpvr7wa61yGBg/GC2PQp1/La2biLgNAXxnEJcdl6BJHlc
         6k/Np8CmsddhJ1Fz6354ulYP2apoO2ltR2V4pKz3q9eeEzeVQMIE9dDaGHfMg/iY7YOx
         /F1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788276803; x=1788881603;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KFq2GkDfRXlsOR078AWttqIDotbtBYpQKPjXjcs2jO4=;
        b=hwIsocaYnYWTQT9EvqY9QyOpHwYBDbdWO4z0JlKz3AnGv0G/jxzN1z82tFbmuPQGnV
         TM2kX+HnD4cYwDYSlYzuxSry1fGqMVJlC8Z/jb/OfQVc6Fiy9gETOBLC7pOAvDX08HE7
         3eHZT4DqiGrhXQCnC+CT9DdtnwmwN5Z0y01UPbMX/WHLUJsUcEvWE7H9BZQMnhJjF1Vc
         qPsoL8h3NLpeIJyBhiIFMYg3drzDdfyUHHeCy+8ve8MVBnk3YyH7Jiu8ITluW8M3znvn
         fI4igjkdwKDFWBDOBrtl/AnedlFbMTfdDY1JndurVBpHjQskV5DkAcFEzYmGx3mnsE0r
         iFOg==
X-Forwarded-Encrypted: i=1; AHgh+RrP2RJPeWYWyBFFV2v5pMFPb5t+vh61ZTt7Q0RU2iNqTa572Co8hlsdRR8OgA5yeP7rbe+1kNA=@vger.kernel.org
X-Gm-Message-State: AFuF++mMZzDJ4DWIltNctuL9r70CCPdh/D9WGGBj0vAfOzZ0BlXfHcAn
	tv1cSwOiqT7xcAQe1sF3KF/9nizPLb1AivkQqLUF79sBMfW6/f0Z6LmKSD60Vqfy+vA=
X-Gm-Gg: AR+sD102cgMHAVBBTzzjmcg9n6NJdn+BOp1JjcpbrA6tXLCuuTzxm7eZuGA/1WlEBfM
	xeF9oPgVGKsi42JA9S9kELqCXrNxWnRjPqlsDz11AWHA6stsxcTjFc4OzMkCRVUOQi6lvV8xEMR
	br2F7myaFtWGJ0YFNzcpdKLjLLsyHdokTZoz4TUd6DVqA/sug0PsnlBWu4HRgYrRdZ9w7FpUv7i
	IgLqyX/f5mbucaQMKBsZam797qGYqx+K5q60X8BxLv45h2m2Bga782HnNyxPzLSGPw6pEcgdNlE
	rEW+B5BO84mfFVcwJ0S9vuAjtymmp4yONJCRTGlamPKXQs5qlbn1CW16hA65NyhJ5itvt46wRaU
	DT59i6xF0csHiiAWGmvbG8h8x0mkkaitKZD+n5Uw8MPseBrwxa1IuORMMzGJ48eTVbZ6qaQ4MFU
	bnCXA5L+E3JCJ6IvdmmrtO8DC4LSpwlDy9Gwytg5ERQ21TdqS+SvAm1q73XRmLV8URCvcctkrOj
	3b+Mx9wo01FUTODLebYY9zU+nKvRRXRI5El8biJ
X-Received: by 2002:a05:600c:4445:b0:499:900c:9c69 with SMTP id 5b1f17b1804b1-49b91c44fbfmr487364265e9.9.1788276801577;
        Tue, 01 Sep 2026 08:33:21 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae. [2.51.220.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b91c5790csm314541845e9.0.2026.09.01.08.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 08:33:20 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Subject: [PATCH 0/4] nvmem: Derive Rockchip MAC addresses from the OTP CPU
 ID
Date: Tue, 01 Sep 2026 19:33:10 +0400
Message-Id: <20260901-rk3576-otp-cpuid-mac-v1-0-ea9135270fc2@flipper.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBBA0auQWTvJ0CKCVyEscDrCaISmBWJCu
 DtFl2/x/wZRgkqEe7ZBkFWjTmNCfsmAh27sBdUlgyFTUk05hre93kqcZo/sF3X46Rgt12QK66i
 qCkipD/LU72/btH/H5fESns8X7PsBL2E1JXgAAAA=
X-Change-ID: 20260901-rk3576-otp-cpuid-mac-3c90243d0884
To: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Michael Walle <michael@walle.cc>, Miquel Raynal <miquel.raynal@bootlin.com>, 
 Finley Xiao <finley.xiao@rock-chips.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Alexey Charkov <alchark@flipper.net>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2718; i=alchark@flipper.net;
 h=from:subject:message-id; bh=265EXKY1LpSnh+xYZaVde+XE9Ub2EQ+extj0SjJz2p8=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRN+2DnU7Gh6/4Mn5hdmn/laj6bZar7X7yrwmsYVtp9/
 JG/1cKujoksDGJcDJZiiixzvy2xnWrEN2uXh8dXmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 0EjHWMeIgYtTAKaaK5Lhf+m3u0Wrlz8oMrOT3VPHc+n2ojDpS7MyCstc1CsldpW2uzAy3A/u0Lg
 +/+CNNxViTpySi7QueS68sTeWTV8pb6vMZcYsNgA=
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Rockchip SoCs are shipped with a unique CPU ID in their internal OTP
memory, and Rockchip bootloaders use it to give boards which have no
dedicated storage for a MAC address a stable one anyway: they hash the CPU
ID and patch the resulting addresses into the device tree they hand over.

Kernels started without that fixup, e.g. straight from the SPL in Falcon
mode or by any other loader which does not implement Rockchip's derivation,
fall back to random MAC addresses which change on every boot.

Formalize the derivation in the DT binding and add a Linux kernel driver
implementing it, so that a Linux image can use the same stable addresses
regardless of the boot flow.

Only RK3576 is wired up here, that being the SoC I can test on. Other
Rockchip SoCs keep the same CPU ID at a different OTP offset - 0x7 rather
than 0xa on RK3588, for instance - which makes supporting them a two-line
addition to the driver's match table plus the layout node.

Patch 1 is a prerequisite fix. The OTP hardware has its own internal state
machine which only works correctly with serial access, but the current
driver serializes nothing, which results in timeouts and/or corrupted
reads (e.g. returning splicing a TSADC trim value into the buffer of a
caller asking for the CPU ID, or mixing up trim values of different TSADC
callers). Hence the Fixes: tag and Cc: stable.

Cross-checked on an RK3576 board: the addresses fixed up into the FDT by
U-Boot match the ones derived by the new driver, and the driver correctly
assigns them to the network interfaces when the kernel is booted without
U-Boot proper at all (via Falcon mode).

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
Alexey Charkov (4):
      nvmem: rockchip-otp: Serialize reads
      dt-bindings: nvmem: layouts: Add Rockchip OTP CPUID layout
      nvmem: layouts: Add Rockchip OTP CPUID layout driver
      arm64: dts: rockchip: Derive GMAC MAC addresses from OTP on RK3576

 .../bindings/nvmem/layouts/nvmem-layout.yaml       |   1 +
 .../nvmem/layouts/rockchip,rk3576-otp-cpuid.yaml   |  73 +++++++++++++
 MAINTAINERS                                        |   7 ++
 arch/arm64/boot/dts/rockchip/rk3576.dtsi           |  12 +++
 drivers/nvmem/layouts/Kconfig                      |  13 +++
 drivers/nvmem/layouts/Makefile                     |   1 +
 drivers/nvmem/layouts/rockchip-otp-cpuid.c         | 119 +++++++++++++++++++++
 drivers/nvmem/rockchip-otp.c                       |  10 ++
 8 files changed, 236 insertions(+)
---
base-commit: 89c07d98716a13454ec3fd9f97689e812cc71bd4
change-id: 20260901-rk3576-otp-cpuid-mac-3c90243d0884

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

