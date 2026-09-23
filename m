Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068B0424D6B;
	Wed, 23 Sep 2026 18:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790186520; cv=none; b=UyP1fCx7PWnN3iOjYwFfwWp9rActMMhhYwmfq1AqgQwPKz3uk/egTVUo8yj88CAxFVzchUYPPM6uoe2zkfHiWcBauWeKZgTSfLqPkrb8byiYdYGeP/AJB+vMUx3rmZYG80QxO6uFKJGth1RjHytNAlDtnwhO+zMyNI+BRckqBR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790186520; c=relaxed/simple;
	bh=2LcJXFfLglMAHFOvjRcZEnGSimjOxEhpXRXzE1krsME=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oGAOCCX7lTlCKcYWineCVZkJSap7a7P3l9UE/GHCU0AqW2MKUPxrUbBbglDnl2vEkixNzlIV9tTCDdyR+KqH2clW2BzGzQuF9Fx0aBj6OoGDMTblO0QQXa0fjusRMXq82yZ8DIF1KH+qeo+TPNtacFQAAMNrfIVEph/AcVw6mlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLffsnpN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLffsnpN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A6F01F000FF;
	Wed, 23 Sep 2026 18:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790186517;
	bh=9PEG2hQh4VbbIb8Ol2k4AHCAhheLSNq1fmhDKGZBrJo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=OLffsnpNikCrulk6Drxd5vXez6+YqaOmw87TdolQ0I5QmEVYI3ILrMHj40D8hu/MO
	 N100XMsDhvhTcbB/Bo+RhfUqDiNy5Fv69zp6ErYhfPIIvkYDeSgFIusQrWc6FoKqUT
	 22JxqlB+EMXrKiB2MMuBK75/yPkK8dMEwDyWF2Ff9k3J15+I3BRMuVwAL65vol8yes
	 mX9LklkXDq/PTLwfmmuxrYUlDVZ2oeoKND55LqWEakUelKQFQLtgov8ppeHc1HDzFf
	 xyO8pqZ7KTit90Z9rdJAKO4ZuvYdsY7CCC1k89T2t1H3MInkCLGbZJH71Ik9wteSRB
	 3p89msLBSCNjQ==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Patrice Chotard <patrice.chotard@foss.st.com>, 
 Diego Fernando Mancera Gomez <diegomancera.dev@gmail.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Christophe Kerello <christophe.kerello@foss.st.com>, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260917235925.44185-1-diegomancera.dev@gmail.com>
References: <20260917235925.44185-1-diegomancera.dev@gmail.com>
Subject: Re: [PATCH] memory: stm32_omm: fix child clock leak on set_amcr()
 error path
Message-Id: <179018651467.64819.2245489948858045.b4-ty@b4>
Date: Wed, 23 Sep 2026 20:01:54 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Thu, 17 Sep 2026 17:59:25 -0600, Diego Fernando Mancera Gomez wrote:
> When the mux is enabled, stm32_omm_configure() enables the two OSPI
> child clocks via stm32_omm_toggle_child_clock(dev, true); they are meant
> to stay enabled for the device's lifetime and are disabled again in
> stm32_omm_remove() and on the devm_of_platform_populate() error path.
> 
> However, if the subsequent stm32_omm_set_amcr() call fails, the function
> jumps to the "error:" label which only calls pm_runtime_put_sync_suspend()
> before returning, leaving the two child clocks enabled. As this happens
> during probe, the error is propagated and .remove() is never called, so
> the clock enable references are leaked. devm_clk_bulk_get() only releases
> the clock handles on unwind, it does not undo clk_prepare_enable().
> 
> [...]

Applied, thanks!

[1/1] memory: stm32_omm: fix child clock leak on set_amcr() error path
      https://git.kernel.org/krzk/linux-mem-ctrl/c/a22355280361d2a376a2020059a2bae11e6cea10

Best regards,
-- 
Krzysztof Kozlowski <krzk@kernel.org>

