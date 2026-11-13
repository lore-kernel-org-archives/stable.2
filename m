Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577239;
	b=MPHdIMbrR0sB4tt7p+MkDj67Dt/rSce7BECSTPrsSzvfRMm759k56nUwGzYzYqUdirWk
	 5kIGIA/FLofH71t26ZkcbQpAauJA//KUJsKosxplZMCyd6nI3FrLRADtHsBXDosCiiUCD
	 5v06BV5ZO/hSexxC8wq2Nuly/9aFcPe2ag0yQX/8/lHblNY0AjWu7NBlnlgW+aJ51aTt0
	 9bGc7pGGw6Wf/1DmVdsGx1TJYqIhnMKyZnjU+sbl2b4DdrS0mcB7Eie5EFngyM8iciJry
	 IoxK27s54TyeiYYAYkftI5x9Oyguq84kiXq0jTNUJtHE6Dt8TzILIanKUz98TUdKEyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577239;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=beZHGSkmPVhqezkVJzzwT5A5ST/itYTHmBhwgZp14Hc=;
	b=W2+KZ/on9e9BL+Vv1aHWN6FKcoiuVL00IguW5BMV4I3U82D61oAT6xnC2rSWHyYpP3Ol
	 6C2mDgB/DYjO5eJRoSaQF4ZsUmZKGoqMFzd23FY77b2nIAlLyz8uGfT8sfEZzBpVcwM6X
	 qx8tEaQjcERyEtfWYMCYm+msplJKps5Fog32Vi90TmONGrVxCwKeW52/sX4xStq4rucZr
	 9Uul8o0/fMsHMJbpOByIHmgbujnNwvPfKiJAZd0HHx3qT7B996gu+KGihyfFtSn+beG40
	 DVEoWKW6S1HlQmPsjL++q8B4UriETwuxmK8Uvbcx2t3UUBB8b5Eyj/d2EbxxIzqy46g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i8gHTW3q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE42606A32E;
	Fri, 13 Nov 2026 13:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i8gHTW3q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B70E1F000C4;
	Fri, 13 Nov 2026 13:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794577239;
	bh=beZHGSkmPVhqezkVJzzwT5A5ST/itYTHmBhwgZp14Hc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=i8gHTW3qe36S0QAB/lTQZVGWTCKSOOVwU48+cA80mOPXEoTi9U6UkYvUNlZWAK1+3
	 kRNlth4Xw3U/3rhcb0ciwk9Sx5ScGaBT2vbt4IvKY5JW4VelCe6pZUjCbNaIVCB+yG
	 8mBHsTG3xEUOYqTIuwBoELTSaMeS7OdDc26XFmpfVVYdaO4kWSC6QEOcb0cRjyWBke
	 5PIF/FbSmKk9vykuk3fQRHI3TJVH+4euE/ZB/SIoJq81C+rGj9Wn1E1OifnJCo4X6v
	 fqBGIrwx6NSa5Ci1X03xanvORWPJPrCllBXQ50TU3tBOUNi5G6Q2rJhVFC0tdG2CYI
	 wkR0JX8GyrW8A==
From: Vinod Koul <vkoul@kernel.org>
To: hyunjungg <hj351016@gmail.com>
Cc: Ray Jui <ray.jui@broadcom.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Raviteja Garimella <raviteja.garimella@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 bcm-kernel-feedback-list@broadcom.com, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261109170223.1829473-1-hj351016@gmail.com>
References: <20261109170223.1829473-1-hj351016@gmail.com>
Subject: Re: [PATCH v2] phy: phy-bcm-ns2-usbdrd: cancel extcon work on
 unbind to avoid use-after-free
Message-Id: <179457723606.636098.6675726002332403998.b4-ty@kernel.org>
Date: Fri, 13 Nov 2026 19:10:36 +0530
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
X-Mailer: b4 0.14.3


On Tue, 10 Nov 2026 02:02:23 +0900, hyunjungg wrote:
> ns2_drd_phy_probe() schedules driver->wq_extcon (extcon_work), which is
> also queued from the ID/VBUS GPIO interrupt handler gpio_irq_handler().
> The work handler dereferences the driver data via container_of().
> 
> struct ns2_phy_driver is allocated with devm_kzalloc() and the driver has
> no remove callback, so on unbind devres frees it after probe's resources
> are released. The GPIO interrupts are requested with devm_request_irq(),
> and so released by devres; free_irq() only stops further interrupts, it
> does not cancel a delayed work that is already queued. probe() queues
> wq_extcon with a debounce delay before returning, and the GPIO interrupt
> can queue it too, so on unbind the pending work can run after
> ns2_phy_driver has been freed, dereferencing freed memory (use-after-free).
> 
> [...]

Applied, thanks!

[1/1] phy: phy-bcm-ns2-usbdrd: cancel extcon work on unbind to avoid use-after-free
      commit: 7a14efb16083531e442de4c7897bce74ac8635e8

Best regards,
-- 
~Vinod


