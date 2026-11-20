Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182424;
	b=AP9d7ihEW2oEuzP97rAinDTkWaTKXpLPwClxSJYgytFMwNWdzcW9Qe+YUBPCBsT8s827
	 jM3v8tFU2Nbn2ICQ0jpRKyCizUBqctrg9rMnEzlRevvEA0Fg0/vJiXFXROAYTtUNC03Vw
	 VcPD1zMDZpjGWhmNA7PyuZWMEh2jqYZkCX3UOIQjnSBVwrTvASEiW420X7lam0v0w60V+
	 nLFcgEZqgTgbVd2sL3CS214E0kH6BlRJPbGhHf9WEqJnDmlLwQufESbwR4oX2feXACBRv
	 iUmJpAw7SCctX4oLUNH0838tVmNLBcQXUpbm9BF1aRnWZ73JONEjpUfdqJ5upkXbHrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182424;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=e+NSYRuHag+IOWBgljqQOHteMpeLzW97XrKZ6OmQSCU=;
	b=uoLg5ZzaKnZxlBegybxEoolhV0vsdpKDu2kOxIQVtKUy8qfEk3kb/LW7qSrV7CXym5aB
	 niA/JFqt//GynJTmFH1nBXcAvQxQYj68CEteFzDD2w0Wd4o9BJbBgSxF2Kb58bJl5WD9v
	 zK1yHT/8m27/Qo0ug/uGXG9/uvIuws7L6YW09FwTuQ64OSOD+0Zc7+ZMWHRxBnA9mf5tj
	 Me96PG2kul9zLSWCwfQmTnawQoWdGwn2c+G60S0P/BKVu1z4JDsP2S9VLF0/u9iAErsoe
	 dTtRx9EPWlMlaX2JKnG4nzZPORQnH5JxBv/vt2KXk8aDsbmpIzH0oXUqF8SqOJYK1nQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zxr2wflH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89371606A325;
	Fri, 20 Nov 2026 13:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zxr2wflH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8361F000D1;
	Fri, 20 Nov 2026 13:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795182423;
	bh=e+NSYRuHag+IOWBgljqQOHteMpeLzW97XrKZ6OmQSCU=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=Zxr2wflHUvrA37wDMKM2Z7eQAa9nPwD0aQjkjMf18UCgxZQCnSf/8TMo6xEMoe0D1
	 pzlxcb2qM5YZgoUKFJPiSxQj/aDvTYWoyTd0uyvQf55HOer3Q3wBDivB2SrMo21bMp
	 LECbNp3ZYl9rDuC6CwbxVCyCqchT2veIG87r1wYZQNCPqIYdu7z5qQ9zXG87Vp0Sea
	 QoBOQII6Y36aa4kndLSaXtUisSr1Q+S1Gfs6lyRd1/zEMnuvooyd4ysuiz/Mo5SNRl
	 Wuf3vh3pdobC2fQuCCRCK00jIFjag4rrIKyDl9Pa/AMhU3U3IRFJI7hO9ln92GdOP3
	 zedUqYQedYCbw==
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
Subject: Re: [PATCH 0/6] memory: tegra114-emc: Fix bus width and pad
 auto-calibration
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Patrick Fischer <admin@tsv-stahl-riesa.de>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, 
 devicetree@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261111-upstream-emc-t114-v1-0-54d9e1bceb6a@tsv-stahl-riesa.de>
References: <20261111-upstream-emc-t114-v1-0-54d9e1bceb6a@tsv-stahl-riesa.de>
Date: Fri, 20 Nov 2026 14:46:44 +0100
Message-Id: <179518240415.10624.13757193124982371025.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1942; i=krzk@kernel.org;
 h=from:subject:message-id; bh=5VF2fEwtX761ujH12rg2jXwnzx/wa39kyjerTpDQEf0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBrAE9NFRwmfwslkPPpjWpqtFr8DEa0/hUZYGYTr
 1IUbh6UZeyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCawBPTQAKCRDBN2bmhouD
 170gD/0f1Cfr/qj/ksDRrjvlpfILxLqgKfLvokbGsEZ0nUGrlNUSy+1E3JoZX4nCk7brg1285vr
 qxiNARuAtmEp2m+vfkAnGs6XTTUAPee0whxjLcd4S2qSOoJfccQudIreB2P5NyzObZ9hAf+7v6l
 wiUiEsOqPfWEUbiVMyuiaruv29reWK4hbNfKTkbANsYoM4OFS80VNLugYJvhFiCAIs3TQ1Vyt34
 5e5b8S9RkyHIG/E4wcKmSA4UGyBxzzbS2f7JIoLE+LYKZ1IPVAmWG9E1l0/lcc4ytUfeHMixZdC
 1/yWhRG8h+Pn+PP0Tvr7ykukvTqPNPStF3kAvWvyMqYOuJIP7qxvNcQDtWhClBXQgauVgVQr0Ab
 k2VB69q2VC7jEkRirmiNXo4ALJvf/ti52RZXuWnI566hNqg5P6q+jfchAf5aDyj2dn/Mp07h9hL
 GZQLADOflkEMe4GS8RljtyyylCIgyc4k2Fx5S4ZNvQxqzK/LtfmW7Gp6EHAlaUS0O442fjkleGA
 UWVY2l1YeI9dIOfD4JgzTLbdBGkCkylR8rZ9+zuEMe9TX+2HBlmlsubzeOhvywYDThS9XWqWwyk
 vvNKI3q5BQagCcKpYMPUY7lLLS3YynNl1K8aGlkkVyXt+5ImPN39aSfOOP5f1H1ew7n/cPGRBjt
 JKbku/nZrr1T8Fw==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

> On a Tegra Note 7 (Tegra114, P1640) I had kernel panics, bit errors and
> WLAN firmware hangs under load, and two kernel panics on EMC rate
> changes from pll_p to 624 MHz on pll_c. Looking at the EMC I
> found three problems in the Tegra114 EMC driver:
> 
> 1. EMC_AUTO_CAL_CONFIG is masked down to the self-clearing start bit
>    before it is written, which clears AUTO_CAL_ENABLE on the first rate
>    change. The bootloader leaves calibration enabled, with channel 0 as
>    master and channel 1 as slave. Patch 1 stops clearing the register.
>    Programming the table values needs the channel registers, which
>    patches 4 to 6 describe and use.
> 2. emc_icc_set() assumes a 32-bit DRAM bus, but Tegra114 has two 32-bit
>    channels. Every interconnect request asks for twice the EMC rate, so
>    actmon at 312 MHz moves the EMC to 624 MHz (patch 2).
> 3. Pad auto-calibration is disabled for every clock change, but the
>    interval is only restored if EMC_CTT_TERM_CTRL changes, so it stays
>    off after the first change (patch 3).
> 
> Patches 1 to 3 are small, do not depend on the device tree change and
> are marked for stable. Patch 1 comes first on purpose: patch 2 and the
> clk patch mentioned below make the EMC run at a real 624 MHz on pll_c
> more often, and both panics I saw on a change to that rate were with
> the calibration cleared. Patches 4 to 6 are not marked: they need the
> binding and the device tree. Patches 1 to 5 are for the memory
> controller tree, patch 6 for the Tegra tree. The driver has been there
> since v7.2, but the first in-tree Tegra114 device tree with EMC timings
> (TF701T) came with v7.4-rc1, so the stable tags matter for v7.4 and for
> out-of-tree device trees.

A bit confusing. This clearly suggests dependency on DTS, thus ABI
break, but code does not look like that.

Best regards,
Krzysztof

-- 
Krzysztof Kozlowski <krzk@kernel.org>
