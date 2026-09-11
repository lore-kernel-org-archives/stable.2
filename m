Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C52D406261
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789123814; cv=none; b=bjdLgP4sQ7jdq1JmsChy006NFHu/KNKoAdYp2+GDe37D36U2joP0JrKfbhpEvJExGMVswAdgxnvWLpSBIe6LpmMswG8xBp8msy1bcJfqTWwonZE17bISVb/1oArHaDU7ojTRaS7ZmoCvRikqaL+wXR0DM0L3VzF3u/+zqqRnvDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789123814; c=relaxed/simple;
	bh=FhuV4VngtUPdEMsxkmWPbg4ZZoKzo68a1q9cqNNVxT0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cYJmqprVczsRdu/o/UEsccNprN1dBcHq/SUKOhPX9LfLzxsP2j1C3FrkHsV9AD7wUiG3KKZyIc5SR2Zv/b+wzfObnMzUBOZUvHFHCACFWuUY165BhYk2YzsxC4ZJBAKvbkJpWHmhb5yK020qHd1S0qOtRnNEEQ6xT2rWc01nXCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sL3MNBkg; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sL3MNBkg"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912e2406so3431295e9.1
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 03:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789123811; x=1789728611; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W07kJ3p6qzFM1kDya7o2HF3cIvPn0BxyCJFGBFTKDFg=;
        b=sL3MNBkgqhssWly3IbJxqbX7jjp5lGmXQWn1ZlvzPoUOilmCWADm0PJbQQDzKcClyB
         XB2uXDqxDkC+jpnjeQ4zb72KTZVRJ2TmQet8KFV24WjU4zD0pyEP6kr+gESi8rMRfXQs
         +SzEkmkpewTDJZhmxp7p7Tj5kK6AKBA/ynR80j/kcrCUxr4lLOHByo5FjS5/KHAQ8PdJ
         RO4sjcgLLxdhGvd3UuTVtoPkSL5eVA9zCBxiRDUNIPWzNici4smjUu+kPbmpNiivM55N
         GoGPH1DjJQ6cJDSwNhCxP6LRsx8tZkf+EY3FCViRwkgb5ntvjzcprzZuIm1pwkROqRt2
         s8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789123811; x=1789728611;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W07kJ3p6qzFM1kDya7o2HF3cIvPn0BxyCJFGBFTKDFg=;
        b=bVzWFocIlOnRGbKL/XAK4dk2eyFFhC7QO3c/vDCx7txmo8kIMTucKPNgnfYhFMaT6f
         vHpJAbRfBrY3U0JDr1maSji18OhC3N+0GZlsKcJEnnyiH0hwTAWiGlsXj3j/NUjveIj7
         rs1XM/5wowRgAtgLEqI1jZdr6fy/oCACpCaORArc1C3C+PZ9iB80ghHNrlh/fI8IJZK+
         upTcQEI1cJQanwtRtii26EZ2K7cKBxOeryn/4VGmL5gw1pa2FFuodU6uI+YVWZ1lztVE
         NGSUsWiDvb9tmybWB/MGSlCNPuKfbzrfpPMTdDMhYJsUIO8nA8RyDuuuYXPsS4xoX8gM
         niLw==
X-Forwarded-Encrypted: i=1; AKwUvByikF/X3NERqz6TtVhkKmm7R8FhiLv3eFf1nghCv/Y/LAziAkwUAH+S1+M8MmsmWbWcexf640Q=@vger.kernel.org
X-Gm-Message-State: AFuF++l8ERQK6t1pv2xmSMtGc8/mpn6tPiI2gRMZ6Z1T2bfcWKZ9Ou5V
	I6HmXbUHZXjfot0sulYKMLoPnazGx0CVTw8Q/gh9riZCAsePOACGv657
X-Gm-Gg: AYBFou2C7DyvrpEcAlFpQaeh6UG56QQEbLAzLR/P65YainBhYhoh46D5tddiGB4YpsF
	TJawCc/MymX7cDEui+9vWn5DZ7NIy3FWcsaYRJn1sq4rZml3ssGwVjQP6wPoUz98RrMsAPWMLC/
	gVAnGcPPguMFDwlr9OPWxQ8RXXR1bWatm8EoiWJAAidN1yDjqo7FwKuBurwzbCATwJqMWiU5prD
	j590VLJuBWKTO3ulm4lBducK+5J6zQx86ij5GvV7GJxLB0kwR7PO/A+N9UJ7+hRcaH3f1fyjHEi
	uRDca1iNxQ6SBfAlCjtgt1CFuEZuQHTH33SGloGF0GWRWRh8xi9Wh+Y+E+pZDVTxu2dkuaALw3V
	PDF6rn4L99fO/fLUJ4ZOEEa7BI1MlYGVK6H7atojkJOcQUShxeYVNZtgtw10sDHom2kjlqVNnW/
	farFSkYa0+LaXjV8zUQRZP2voqCC+wrkCbnanOjplo5thSatsDhOnxv0eZYRPmET4YZNv/rtgxU
	0WPMIMsZHrEBHaID7oLT7fUhFMd8tyhVKGoeojpthdR95ARIFdeGLIZ4lwWb2zk
X-Received: by 2002:a05:600c:4ece:b0:49c:f13e:e4c with SMTP id 5b1f17b1804b1-49e610829b5mr43022575e9.9.1789123811015;
        Fri, 11 Sep 2026 03:50:11 -0700 (PDT)
Received: from tachyon.internal ([194.220.152.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e668aca6csm13863965e9.7.2026.09.11.03.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 03:50:10 -0700 (PDT)
From: =?UTF-8?q?Enrique=20Hern=C3=A1ndez=20Bello?= <ehbello@gmail.com>
To: shawn.lin@rock-chips.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	bhelgaas@google.com
Cc: robh@kernel.org,
	heiko@sntech.de,
	dlemoal@kernel.org,
	linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	=?UTF-8?q?Enrique=20Hern=C3=A1ndez=20Bello?= <ehbello@gmail.com>
Subject: [PATCH] PCI: rockchip: Skip the Tpvperl wait when power is already valid
Date: Fri, 11 Sep 2026 11:49:52 +0100
Message-ID: <20260911104952.4190994-1-ehbello@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since commit c47f90be4c89 ("PCI: rockchip-host: Fix
rockchip_pcie_host_init_port() PERST# handling"), a JMicron JMB585
behind an rk3399 root port almost never becomes usable: the link trains
normally, but the endpoint's configuration space never answers, so the
device is not enumerated. On this controller a configuration read that
gets no usable completion is reported as an external abort rather than
as an all-ones response, which on arm64 brings the machine down.

The change added an unconditional 100 ms sleep so that PERST# stays
asserted for at least Tpvperl after power becomes valid. The wait is
performed while PERST# is asserted, so it also extends the reset by
100 ms, and this endpoint does not tolerate the longer assertion.

Tpvperl is counted from the supplies becoming valid (PCIe CEM r5.1,
sec 2.9.2). On boards whose PCIe supplies are always-on -- vcc3v3_pcie
on ROCK Pi 4 is regulator-always-on and regulator-boot-on -- power has
been valid since boot, seconds before the driver probes, so the
requirement is already met and the sleep only lengthens the reset.

Record whether the supplies were already enabled before the driver
enabled them, and skip the wait in that case. A supply that is already
on at probe was brought up either by the bootloader or by the regulator
core at boot, both of which precede a PCIe probe by far more than
Tpvperl. When the driver really does bring the rails up, or on resume
where vpcie0v9 has just been re-enabled, the full wait still happens,
as it does if regulator_is_enabled() cannot tell.

Measured on a ROCK Pi 4C with a Radxa Penta SATA HAT (JMB585) by
booting repeatedly and counting how often the endpoint enumerated:

  unmodified ....................................  0 out of 84 boots
  with this patch ...............................  3 out of 3 boots
  other ways of dropping the same wait ..........  16 out of 16 boots

Fisher's exact test, pooling the last two rows against the first, gives
p = 4.1e-21. With the patch the endpoint enumerated on every boot and all
four disks behind it came up.

Each of the three PERST#-related changes that landed together in
v6.11-rc1 was also reverted individually; only removing this wait made
any difference. Moving the wait to before link training is enabled,
rather than removing it, did not help (0 out of 15 boots), which is
what identified the length of the PERST# assertion rather than any
interaction with link training as the cause.

The measurements were taken on 6.18, but the code in question is
unchanged between v6.11 and v7.2.

Fixes: c47f90be4c89 ("PCI: rockchip-host: Fix rockchip_pcie_host_init_port() PERST# handling")
Cc: stable@vger.kernel.org
Signed-off-by: Enrique Hernández Bello <ehbello@gmail.com>
---
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -318,6 +318,7 @@
 	struct	regulator *vpcie1v8; /* 1.8V power supply */
 	struct	regulator *vpcie0v9; /* 0.9V power supply */
 	struct	gpio_desc *perst_gpio;
+	bool	supplies_pre_enabled;
 	u32	lanes;
 	u8      lanes_map;
 	int	link_gen;
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -314,7 +314,9 @@
 	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
 			    PCIE_CLIENT_CONFIG);
 
-	msleep(PCIE_T_PVPERL_MS);
+	if (!rockchip->supplies_pre_enabled)
+		msleep(PCIE_T_PVPERL_MS);
+
 	gpiod_set_value_cansleep(rockchip->perst_gpio, 1);
 
 	msleep(PCIE_RESET_CONFIG_WAIT_MS);
@@ -614,6 +616,23 @@
 	struct device *dev = rockchip->dev;
 	int err;
 
+	/*
+	 * Tpvperl is counted from the supplies becoming valid, and the wait
+	 * for it happens with PERST# asserted, so it also lengthens the reset.
+	 * A supply that is already enabled before this driver enables it was
+	 * brought up either by the bootloader or by the regulator core at boot,
+	 * both of which precede this probe by far more than Tpvperl, so the
+	 * requirement is already met and the wait can be skipped. Treat an
+	 * error from regulator_is_enabled() as "not known to be on" and wait.
+	 */
+	rockchip->supplies_pre_enabled =
+		(IS_ERR(rockchip->vpcie12v) ||
+		 regulator_is_enabled(rockchip->vpcie12v) > 0) &&
+		(IS_ERR(rockchip->vpcie3v3) ||
+		 regulator_is_enabled(rockchip->vpcie3v3) > 0) &&
+		regulator_is_enabled(rockchip->vpcie1v8) > 0 &&
+		regulator_is_enabled(rockchip->vpcie0v9) > 0;
+
 	if (!IS_ERR(rockchip->vpcie12v)) {
 		err = regulator_enable(rockchip->vpcie12v);
 		if (err) {
@@ -890,6 +909,9 @@
 	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
 	int err;
 
+	/* The 0.9V supply was turned off on suspend, so Tpvperl applies. */
+	rockchip->supplies_pre_enabled = false;
+
 	err = regulator_enable(rockchip->vpcie0v9);
 	if (err) {
 		dev_err(dev, "fail to enable vpcie0v9 regulator\n");
-- 
2.43.0
