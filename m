Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794651240;
	b=dSEZLVKh1Llp92LSrsW0GhCItxKAx88UlPODcYvnQjU4KVcB7qDb58OVVWx2XlcNFH59
	 sRoNZpCMTiNawBiJRD2uKCK1cYrfw6tf6uYTZOR6XCjtPSRN7icGHpdVIowEGFUpCOlEE
	 bkZ+0s6YtJvC/sYETdVhFsT3ZzhfVhBVXmXiet/nB22+RCfii05RpywGucuNqYELMfyKM
	 HUKqi/YVHuIaO+4cUbXYsdMproaVWpPXmjA6mTq6vJ8OaeuMZHnabYrdORyPP/xfOm3ge
	 Gf0tJrEke8qc95pQHwv6JyWYdmjEHvOlzVBwJDMl8owgfFlVCKuvGqQAPgLlSC7HnhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794651240;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=CC8AtHwZZub26kjn5ZZpKA5wzTG30rrk88z324avJjY=;
	b=J7G95gxltliwfCbFX3KXdnkDFKCEZ4AV9LWlJnzca4eOOS0TkGwmqnOYL8v2rxm/37Oe
	 YZaQIRXC6C7ZRPLmkG3nN21rXnqV/gX9Fq3o0HkL1ijmgwLbx/uuvHRku9t+pgH8B8BNS
	 SlTAqz9Zhca5NqAASm6l6apDWwVCAqwXLaHG4sCuFc5P7t4aWqW7A84ltF/dMyBjPT2IZ
	 Z3/TqmsNF6img05FAmadCbEQgK6XjS10GB967SO6L7uQQGq7HJYdGhtbJGwFnt5aqaEVj
	 jEB78V8UUDt4YQQXYMiA+VZHbjN79QySvO1ebGI5egK/BaPyGojzPxhylhqfL/eW6YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nabladev.com;
	spf=pass smtp.mailfrom=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=Q5EjRVDW;
	arc=none smtp.remote-ip=178.251.229.89
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FFD606A327;
	Sat, 14 Nov 2026 10:13:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87FFD606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=Q5EjRVDW
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E353610EA56;
	Sat, 14 Nov 2026 11:13:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1794651227;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=CC8AtHwZZub26kjn5ZZpKA5wzTG30rrk88z324avJjY=;
	b=Q5EjRVDWT3H/xWt3GrsIshGnhpWFrEavh+eY86S263kmWctWNZfRU81FhBHggWF4lOEiU8
	msuBYOQeLmINg7TkyrL2pIE+U1NBKu7F0Cleq65rQLXW1ThqAgPvFjPojlt88O05F2wvGl
	luNUArApXeMXrG78BtVFq+d7brCadobBVCAJAMkxTTNaiVhM55NGeLJUNyBj8pdzPTLXg3
	ilhyqPcs1TJ2vmHg5758GYcaPugsyYvT2y3PXWH5pa2Rw9iX8hAPM6qtV/kHJpXSTfQtC5
	ehI6eOc566dPy2zbwP4WWukIHfF4JJhP8VaNZ3tBr3WGhhB8XuT6y2AyxNpbnQ==
Message-ID: <6fc041d3-f66d-47c9-9dc1-f47b4c416104@nabladev.com>
Date: Sat, 14 Nov 2026 02:00:16 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: mmci: stm32: reset and restore SDMMC state on system
 resume
To: Christophe Kerello <christophe.kerello@foss.st.com>,
 Russell King <linux@armlinux.org.uk>, Ulf Hansson <ulfh@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-mmc@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261113-fix-resume-reset-v1-1-115b3da5764d@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20261113-fix-resume-reset-v1-1-115b3da5764d@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 11/13/26 5:35 PM, Christophe Kerello wrote:
> On standby exit, the bootrom may reuse the SDMMC instance used as boot
> device, leaving the IP in a state not known by Linux.
> 
> STM32 variants do not set pwrreg_nopower, so MMCICLOCK, MMCIDATACTRL and
> MMCIPOWER are neither saved nor restored by mmci_save()/mmci_restore():
> their content is expected to be retained by the hardware.
> 
> Add a reset_on_resume variant flag. When set, and if the card is powered
> off and a reset line is available, reset the IP on system resume and
> restore the cached MMCICLOCK, MMCIDATACTRL and MMCIPOWER values.
> 
> This is done from a .resume_noirq callback, so that mmci_irq() cannot run
> on a state left by the bootrom once device interrupts are re-enabled. It
> also runs before pm_runtime_force_resume(), which does not resume the
> device if it was already runtime suspended before system suspend. The
> clock is therefore enabled locally for the duration of the sequence.
> Clock and reset errors are reported to the PM core.
> 
> Enable the flag for all STM32 SDMMC variants.
> 
> Fixes: 46b723dd867d ("mmc: mmci: add stm32 sdmmc variant")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
Tested-by: Marek Vasut <marex@nabladev.com>

Thanks
