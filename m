Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A103ACF1C
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 09:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791018905; cv=none; b=fiI1cs+BBhxwg+N3AQlAOzcloKkhEexXpv1RDtO+2GerRzCdxSj+Rn3cy2owRWf2RrGeNk9fq/DgvNkktZJICcWkofLRtEAW78LZJIqFOVb+xczD4ZENEGPjcdjSs1pw7PcUivOU8an0JNp3CXBY/UidOE7HREg7NGzNKcqy/mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791018905; c=relaxed/simple;
	bh=rP9RNg9VVmVKDqjlIhXyymS0DyeJ4N2kWy3XBRaq6DI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=My1gjTnSDU/P4U5h+D4q4goWdFLbF0vHuj3goWSceePAlJZ9Szm+IY494pSZv3BEcVYaLMw3Pp/5s8tBszVRiVVxcUhpoSndBu4hQeHEBclxetXTuzLjrd7i4M1eeVC/R6Ml4/KrXA10SJyBHQdDRkTUJSfUtbA7Vhy+3rpDDj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bstz7Dpo; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bstz7Dpo"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48bbb06e746so99718f8f.3
        for <stable@vger.kernel.org>; Sat, 03 Oct 2026 02:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791018902; x=1791623702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IWrQtgnBBrtxYpdGid+lEFP8Z5fa4mnFJvTHl2+VUDc=;
        b=Bstz7DpooO5uerNBptHAf7KqjxxySQWjVxB8WCxnEr1YSZ1S4MqIhtJiHrCLocv7td
         fRXJLAR4wWTVF27Hnip/1NM//SFQoQKbs+xiNDtgxolVkIcw1mEkMLA5ISLkfATAruQa
         BSGiJqbX66d9v8Ar5tTqq+dans4J3OOepBvkn+RfJ1S+pwupunlPcdCFBHR+QvMXdv5K
         bzkBTF6egtNZQ45bc8Nqylr1UPyzeYaO7vMywaxpedswydnzpMCgd1yyczgECmkt2XUs
         KRyKfZp0rP0YNBgEpjqydFtNBs7C/WvwJMwKCNpJdse68gc9TyUkzT26uyzth9dh3ep6
         5SfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791018902; x=1791623702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IWrQtgnBBrtxYpdGid+lEFP8Z5fa4mnFJvTHl2+VUDc=;
        b=M1ILzPXOrBbBpmKrfXQNHua0zCVvs/gfZNIA+APYgLY4/YtFoWKVocrYwUzuKFiYLa
         6+KOkTKhW1LKZacjrxMHV566iyHodZ+l5kawGKFaP1lUxSm3Vv1ziTepAOMTPt6lEVsC
         86EYmMft31SjUi+nyswcg1oCpqkGbgDGglNYkRG2anBVWt6ZNKOLO0/Sz1T2KIEvMxD8
         pO+QQVcg01aUd6Oh/6KxspTLPOYoCxoh53cyiInC/NkU9ebsXQjsY7ki1sb+okbH8j2f
         fTCrHUjCW+HEouzJIAKB2OH9YzyDvcUt0iZ7+Pzs1Q6Ryi59B8Gaga4OW0dt4D02NqkS
         mR9g==
X-Forwarded-Encrypted: i=1; AKwUvByvI2ytnerCzZttCSqbkX4JAK1DZ8itt43GuZAknJXmQBh3zhYMs+i2iEIeymBgJgKRNz6ahd8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKe6nTJ4XhRENNUVkDxqDdf6QvgUJG/Mon8cvBOiwVYrkeE/ESg
	GpTTtcY+Jqno+YqPiPmnuEi2oc4c0yUh3sAQeFjH2omqTqhiVaBESfYU
X-Gm-Gg: AYBFou1fmJnRI53W5zrCS6YtJ06LfScLkm4WkbOLeaTWA39r27Nud4yRbRDGG0fqQUK
	wugfLT/Kc+NhJMlyHReq58twDS4PptgztPc/T/0WcJGlZXhKokzNhpqva7jSfgLl8FpHbimKxGu
	5RmJgT7l6l1Q2mKZT0yy+s5M9MG2YVyfS3YL39SCNeJsv83EgSkUk3TosC5/bfXeGSUHu9LX8DS
	6/Z4BV/LDcTDPLEGZGvhZert2GSqQ4GK5qfs1dc9OPeZFS46wrnVZ12CMsZndpr/MK3qd2nGRHO
	xRYlUxbxLwhIbpRVqlVG8ibmfYHq0QXvGc2x5eF/WwN7BDSEdhp9lRM+5yw3OFRafQA7Ij3pi0h
	9RNZdG5JWUcf5THjKeD36nWzcNpoQ/31MA7R0UksmLPp3WDUWe5igXwD6p4GNdl+VZTf0gGt33D
	hz8uWLEdPDY4V1FDs7lNE+aZCVW4dce3O+YPGfq02va36DKwzKNMtfH2s1KWlDPf0GrchaVzlRq
	8g9KHNHaAg=
X-Received: by 2002:a05:6000:230c:b0:488:7f1d:2728 with SMTP id ffacd0b85a97d-48c47fe497fmr3047875f8f.30.1791018901393;
        Sat, 03 Oct 2026 02:15:01 -0700 (PDT)
Received: from FranzSP11.fritz.box ([31.31.60.25])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b382f8ab4sm10549817f8f.35.2026.10.03.02.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 02:15:00 -0700 (PDT)
From: Franz <franzelfranzel@gmail.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	linux-pm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] power: sequencing: qcom-wcn: power off WLAN at probe
Date: Sat,  3 Oct 2026 11:14:51 +0200
Message-ID: <20261003091451.4727-1-franzelfranzel@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <CAPjyS8dY0Q_o3XmFjuKZZsjhzhoSNL+ZGJtw5cQt8HiV3sUtxA@mail.gmail.com>
References: <CAPjyS8dY0Q_o3XmFjuKZZsjhzhoSNL+ZGJtw5cQt8HiV3sUtxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The WLAN enable GPIO is requested with GPIOD_ASIS and then kept at its
current level, so that a WLAN module left powered on by the firmware is
not switched off. The FIXME explains why: toggling it would take the
PCIe link down, and the controller driver could not recover from that.

That reasoning held while the PCIe link was trained before the
sequencer probed. Since commit b921aa3f8dec ("PCI/pwrctrl: Switch to
pwrctrl create, power on/off, destroy APIs"), qcom_pcie_host_init()
powers the endpoint through pwrctrl before it starts link training, and
defers until the pwrctrl driver is bound. That driver cannot bind
before this sequencer has probed. Power-on therefore always comes
before link training, and keeping the firmware state is now harmful.

On the Microsoft Surface Pro 11 (X1E80100), the WCN7850 sits on a
PCIe port without a PERST# GPIO. While pci-pwrctrl-pwrseq is not yet
bound, the host init is deferred about ten times, and each attempt
powers the PHY and controller back down. The later power-on only sets
a GPIO that is already high, so the chip is never reset and the link
never comes up:

  qcom-pcie 1c08000.pcie: Device found, but not active

The endpoint is not enumerated and ath12k never probes. Bluetooth on
the same chip fails too ("QCA Failed to send TLV segment (-110)").

Request the GPIO as GPIOD_OUT_LOW. The chip is then off when the
sequencer probes, and pwrctrl powers it up cleanly right before link
training. Drop the FIXME and the code that preserved the firmware
state.

Tested on a Surface Pro 11:
 - b921aa3f8dec plus a one-line version of this change: endpoint
   enumerated at 2.4 s, ath12k and Bluetooth working.
 - next-20260929 plus this patch: "PCIe Gen.3 x2 link up" at 3.4 s,
   ath12k and Bluetooth working, Wi-Fi connected.
Without the change, neither kernel enumerates the endpoint.

The culprit was found by bisecting v6.17..v7.1, with the DTB and
.config held constant.

Fixes: b921aa3f8dec ("PCI/pwrctrl: Switch to pwrctrl create, power on/off, destroy APIs")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Closes: https://lore.kernel.org/all/CAPjyS8dY0Q_o3XmFjuKZZsjhzhoSNL+ZGJtw5cQt8HiV3sUtxA@mail.gmail.com/
Signed-off-by: Franz <franzelfranzel@gmail.com>
---
 drivers/power/sequencing/pwrseq-qcom-wcn.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/power/sequencing/pwrseq-qcom-wcn.c b/drivers/power/sequencing/pwrseq-qcom-wcn.c
index 7f88a29b2..636dd7e63 100644
--- a/drivers/power/sequencing/pwrseq-qcom-wcn.c
+++ b/drivers/power/sequencing/pwrseq-qcom-wcn.c
@@ -526,15 +526,8 @@ static int pwrseq_qcom_wcn_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(ctx->bt_gpio),
 				     "Failed to get the Bluetooth enable GPIO\n");
 
-	/*
-	 * FIXME: This should actually be GPIOD_OUT_LOW, but doing so would
-	 * cause the WLAN power to be toggled, resulting in PCIe link down.
-	 * Since the PCIe controller driver is not handling link down currently,
-	 * the device becomes unusable. So we need to keep this workaround until
-	 * the link down handling is implemented in the controller driver.
-	 */
 	ctx->wlan_gpio = devm_gpiod_get_optional(dev, "wlan-enable",
-						 GPIOD_ASIS);
+						 GPIOD_OUT_LOW);
 	if (IS_ERR(ctx->wlan_gpio))
 		return dev_err_probe(dev, PTR_ERR(ctx->wlan_gpio),
 				     "Failed to get the WLAN enable GPIO\n");
@@ -545,13 +538,6 @@ static int pwrseq_qcom_wcn_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(ctx->xo_clk_gpio),
 				     "Failed to get the XO_CLK GPIO\n");
 
-	/*
-	 * Set direction to output but keep the current value in order to not
-	 * disable the WLAN module accidentally if it's already powered on.
-	 */
-	gpiod_direction_output(ctx->wlan_gpio,
-			       gpiod_get_value_cansleep(ctx->wlan_gpio));
-
 	ctx->clk = devm_clk_get_optional(dev, NULL);
 	if (IS_ERR(ctx->clk))
 		return dev_err_probe(dev, PTR_ERR(ctx->clk),

base-commit: 6474fa070f2b8013b4b87350b775b8c3be6e8aac
-- 
2.56.0

