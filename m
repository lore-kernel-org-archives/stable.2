Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCA439B4BB
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 22:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783461898; cv=none; b=oyg6GVz/VGvNAN9w+Aj+IdInzQfSSlJgBXEpjbgPDWTgFumGTsdNAICC2PSN73+e8owZK7EgiTaB25oekZydcNeXse66xx7/6u4t3kVgqAHCsP+AGzZnPEQtYMn2BJf3iShMjccPfhzgBPucG3FCGOtmW4t4AR92NgTWMCaBHN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783461898; c=relaxed/simple;
	bh=bH3gk7RWnvE3hlcnw01+4CMtuv42q3VTAN/STxJ01j8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUXrhKQHT+Vp+lwWNPJLoUlPTgCmpYUykbRgVzZebDWVW4w88S/1nRo0Hl5ILhZYgkuOulNrD12kLcX0iX4/kVgM2N8KbgkZHINeThm+Q4rPB+FSDaCuOnaSkl7H4xgaESjQmfnqyMvXPJcQdMk7xtQQU5JkLT0djlRl+x4BnLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=breiti.cc; spf=pass smtp.mailfrom=breiti.cc; dkim=temperror (0-bit key) header.d=breiti.cc header.i=@breiti.cc header.b=MHgkDJnJ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=breiti.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breiti.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=breiti.cc header.i=@breiti.cc header.b="MHgkDJnJ"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493b7612475so954145e9.3
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 15:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=breiti.cc; s=google; t=1783461895; x=1784066695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=itsXGIDk7WLLBfalclN3ttCU0xEyv6kkTFRPr/iZ59E=;
        b=MHgkDJnJXT/hJF4wUpX4BgCERs+G50kCwgLARYdsVL0xmM2dmrblY0BLVPIBovNYva
         hdcbWmcZSRgt3euA2ZHaj89RaGus+c0XGovBxw912UB6NkJvQ7e1gfKXdpUF9IWe1ITh
         Xddbi5PUFTQr+YONPrlAmYoMQtyJjDw+9H+sE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783461895; x=1784066695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=itsXGIDk7WLLBfalclN3ttCU0xEyv6kkTFRPr/iZ59E=;
        b=JSIhncSegYoXh1qgkv0b5Lc1bKLc3nF9QtmY9gfuZoalp6J/ZYXQqz47uSO4xHcr+J
         9ymdepfYHPOmA6UxHhET3h3AaEyWsLSFj2k0XCZMDOjNDss9vXg4RDxnlcrucJd15aC3
         T7o49YOm7+A26Ujp1+ZXAKKXKt1b963+MePZUfTxhft+wSAWPS+qgnPp02uMOeD6MiCU
         wmOqMkFo1lQPkZzk3kOVhx6CUrEGMGk8KRAV9gCvg9VXcGsrluCiN7wdgEEeAd0M9V1P
         mHbiBCzawuB4BjNocHYFsr2xWd9lTWyVjfx3VEI9EBRV9SCVt8yd6ot/UYSF8ZIf/K1C
         CbIg==
X-Forwarded-Encrypted: i=1; AHgh+RoRXg5nPB3nNQMejzXmQkoW/gEF2XgmlvOmkFMB6r/obbbQWNL4MLVAUwnAeSlKlJGbgGlBTAk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5xAIMXz8zdY/2pbBiq0iDORJb6Ga0lP1xmwUBJdv239J4CBWB
	EN+HZ1qcVO2bT5l1B2pBqV/F4LMExqADnlUa6EtocdtPZhKKy00etUZWjacIvSBq2A==
X-Gm-Gg: AfdE7cnn+/FHPZlhCHgGD4XMRj0vTSZBXBbhV1tDE5SCOBQkiAqr2fm/EeebQO6fl8B
	0f0+Zv36m5JICtW62fmqE0zwfIUVGm6JjNXnCuLrhtioX0redIUvkHsjUIA/D75P/ds31w1TfN8
	hvuP84CXhBjpTlQ0GQZUIwF64Jh+5xzMePlo6OVDWWy7FAjqM/IXqstt5LofyLwBty+URAXj4bO
	+o13zua//yeAPkUZZHQPb9UzR7OsHMvClRsBd4knZUYX3si658iPkuh+qBlryM2CQuQXPrKVa1a
	9Wqhhi0coHCjFI77X+4/xYffkj1X6UT9MAON+NCSTIeKxWv7ausafb8XQMr7T7fDKtjuYkk6qYr
	4rNjjkyivU0HbaHlgpMlgjtSpNGeyFSwZ7/wVxIgz3PaOuG2gAKTHS099ysuCOvFh5SRoXK39ZL
	IAadumPyi29mD30G9Wv5SGJIOEEaWaCAQZ9qMibjjssr8WhKziNw==
X-Received: by 2002:a05:600c:4595:b0:493:bd67:316 with SMTP id 5b1f17b1804b1-493e1fa35c9mr45147655e9.16.1783461894949;
        Tue, 07 Jul 2026 15:04:54 -0700 (PDT)
Received: from framework.casa.breiti.cc ([2.57.48.190])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f3318dsm78535105e9.3.2026.07.07.15.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 15:04:54 -0700 (PDT)
From: Markus Breitenberger <bre@breiti.cc>
To: maxime.chevallier@bootlin.com
Cc: andrew+netdev@lunn.ch,
	bre@breiti.cc,
	bre@keba.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org,
	yong.liang.choong@linux.intel.com
Subject: Re: [PATCH net] net: stmmac: intel: don't reconfigure SerDes on unchanged mode
Date: Wed,  8 Jul 2026 00:04:31 +0200
Message-ID: <20260707220431.108611-1-bre@breiti.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <565c18f3-8b1b-4832-b060-617b7d683eb6@bootlin.com>
References: <565c18f3-8b1b-4832-b060-617b7d683eb6@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Maxime,

Thanks for the review, and sorry - my commit message was wrong and
sent you down the wrong path.

> One thing is that now we 'blindly' rely on the bootloader / fw
> having correctly configured the initial interface.

That impression came from my commit message, where I wrote that
"firmware already programs the ModPHY for the configured interface".
That was incorrect: the kernel programs the SerDes rate itself, in
intel_serdes_powerup(), from priv->plat->phy_interface. I'll drop that
claim in v2.

> Maybe instead the serdes interaction logic can be reworked so that
> you query the serdes rate, see if you need to adjust it based on the
> selected interface, and if so you re-configure it ?

That's a good suggestion, and I'll do exactly that in v2. Instead of
comparing the cached priv->plat->phy_interface, it will read the
current lane rate back from SERDES_GCR0 and only run the disruptive PMC
reconfiguration when the rate actually differs from what the selected
interface needs:

  cur_rate = (data & SERDES_RATE_MASK) >> SERDES_RATE_PCIE_SHIFT;
  want_rate = interface == PHY_INTERFACE_MODE_2500BASEX ?
                  SERDES_RATE_PCIE_GEN2 : SERDES_RATE_PCIE_GEN1;
  return cur_rate != want_rate;

The callback selects between the 1G and 2.5G ModPHY programming tables
from the requested interface, and the SerDes lane rate is the
observable state that tells us whether that programming is already
active. intel_mac_finish() applies the selected table to the shared
ModPHY LCPLL through the PMC IPC (intel_set_reg_access()) and then
power-cycles the SerDes, and that power-cycle is what disturbs the
on-die AHCI SATA PHY sharing the ModPHY on Elkhart Lake. Gating on the
actual rate keeps that reprogramming out of the boot path when the
SerDes is already configured correctly, while still handling a genuine
SGMII to 2500BASE-X change at runtime. If the read cannot be completed,
the helper returns true so the reconfiguration runs as before.

One caveat: the read-back covers the SerDes rate bits, which is
the setting relevant to this regression; it does not read back the
full LCPLL DWORD state. I'm keying on the rate because that is what the
initial mac_finish() would re-apply on this path, but if you'd rather
key the decision off something more specific I'm happy to adjust.

Thanks again for the pointer - reading the hardware is clearly the
more robust check.

Markus
