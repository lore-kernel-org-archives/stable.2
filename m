Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BED3F39EA
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 08:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784016369; cv=none; b=FMDxLD+BaaNR/8IPTKtFH2uq4TKp7GRkBBiGmYYk2a8aECtm4iKlXoSpfazVKN+M9wEMaQ7OQKayw1r4VrQkkEZFprIhGyZjbJ8sqQg82879Q5ghLguCTeNw4al/jxXTgR+lydSBCZ2rCK7AUrdTBH9TH7n/Onuscov+98dMKVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784016369; c=relaxed/simple;
	bh=iEdFzK7xpXCvHtMu35ZXOvPgRl4ORJgloYuTHHBTGNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PSylVkxZeklcTyA0kPhu7P7d4NXPIqghfwY31Fzmi2jtyF1z86GlgBHUClYky0UFwtvVv0Hb9pvu4xTUND12p7XX3Yr48DxBvOzOQsBmLVIRLadhz35GfgfC2tIwlwYLdHuzJXj3ZjVDJ5yO0n0FSkLcamtZmH4BUxpm14wWEVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UUhvAR3D; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UUhvAR3D"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 64F78C2BB23;
	Tue, 14 Jul 2026 08:06:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E510B60346;
	Tue, 14 Jul 2026 08:06:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B570111BD3B23;
	Tue, 14 Jul 2026 10:05:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784016361; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=0Tr5FyN1yFpthV3VK225kkpXsZ1+Q0ewXRFUsrX48A0=;
	b=UUhvAR3DyUsKeZ48khLzz/RdRv84xOY22/Qhm3XoX9CbNw1gs0svpqNBm/qEokdnu5EIv6
	v2O/ILj+ugqfNoSd/d+H1e62p6axvHGjlaSXuvAcTKF4VTXhJzWNhGSnE/SVr6yPSn+k0r
	ZPD5zjXlnrjRtF45RE5zTLOb7ltACN5ehJNzBp5GKmphkdqLx9VWvnWm9gmaIAI3Dgvox4
	D50HMojooGQIcwQyNqnlsi3y9KknvFb5Np3S4K71bQH0De5Hva7q0n9O8bT7W7gE16xm5E
	49uaXhN7Pj7/ukVgFASP2sPi635Tf+Cv0ce3x0zd9vLu2iscHZYFFubD1syBGw==
Message-ID: <edc373ca-fef8-46e4-8b4f-8afc257c2349@bootlin.com>
Date: Tue, 14 Jul 2026 10:05:51 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: stmmac: intel: skip SerDes reconfig when rate
 is unchanged
To: Markus Breitenberger <bre@breiti.cc>, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
 yong.liang.choong@linux.intel.com, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
 Markus Breitenberger <bre@keba.com>
References: <20260713171619.192452-1-bre@breiti.cc>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260713171619.192452-1-bre@breiti.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Markus,

On 7/13/26 19:16, Markus Breitenberger wrote:
> From: Markus Breitenberger <bre@keba.com>
> 
> intel_mac_finish() is registered as the phylink mac_finish()
> callback for the Elkhart Lake SGMII ports. phylink calls it at
> the end of every major link reconfiguration, including the
> initial one during probe.
> 
> The callback selects the PMC ModPHY LCPLL programming for the
> requested MAC-side interface and then power-cycles the SerDes.
> On Elkhart Lake that ModPHY is also used by the on-die AHCI
> SATA PHY. Reapplying the programming during the initial
> boot-time link-up disturbs the shared analog block while it is
> still driving SATA, so the SATA link fails to train:
> 
>   ata1: SATA link down (SStatus 1 SControl 300)
> 
> The disk carrying the root filesystem is never detected and the
> system hangs at rootwait. Ethernet itself comes up normally,
> which makes the failure look unrelated to the network driver.
> 
> Before mac_finish() runs, the legacy SerDes power-up path has
> already programmed SERDES_GCR0 for the current interface. The
> 1G and 2.5G ModPHY tables selected by mac_finish() correspond
> to the SerDes lane rate, so read that rate back from SERDES_GCR0
> and skip the PMC reprogramming and SerDes power-cycle when it
> already matches the selected interface.
> 
> This keeps the disruptive reprogramming out of the boot path
> when the SerDes is configured correctly, while preserving the
> previous behavior when a real SGMII/1000BASE-X to 2500BASE-X
> rate change is needed. If the register read fails, reconfigure
> as before.
> 
> Fixes: a42f6b3f1cc1 ("net: stmmac: configure SerDes according to the interface mode")
> Cc: stable@vger.kernel.org
> Assisted-by: GitHub-Copilot:claude-opus-4.8
> Signed-off-by: Markus Breitenberger <bre@keba.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

