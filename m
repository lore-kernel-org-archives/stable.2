Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C5D4854E6;
	Thu, 27 Aug 2026 15:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787844803; cv=none; b=CSdsc8fHJeZ87xgqoLBa+cuzol1SbnAVCwy8BiHvmqG3rnO38LEDgLrr2bIjXeRX2ZNjbR9kwm+GSyABe+psrE4tZDkIQkbQbUy/FM/nbhku6dewHjPLRw8mJfGQ78eKfy8zykkBm/uTgrsqj7ajLLj5bNjGSuG0Q+SUel/rSc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787844803; c=relaxed/simple;
	bh=acrqtwnCz6aCjrgJp356V6BEJQzXbFqyNQ8v2wYdMeU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SbTHB8EH1twDscunUDsrQmuWwJ825glv9qVF8ccwcVFupidT1vnyQ6l46BLxTLU5odTR+NDCW8port4Pcf5VLa0BhX9disfpSmNFO6BdSP9HzGywFIddj33ALYDn8egZ4eOy6DRxOZcLLm1/8nvtmINiMWhP5XJ7FUriokmZbCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUi1TIPj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUi1TIPj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0CF01F000E9;
	Thu, 27 Aug 2026 15:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787844800;
	bh=acrqtwnCz6aCjrgJp356V6BEJQzXbFqyNQ8v2wYdMeU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gUi1TIPjE3bF7WFEHkDssB/dCZQNR+tpfbsv6OBgrL5FmMZIyf+IKuJXr6AcJ6NkZ
	 23y17CXDxNqfcrlBzMWD2rDojgjEM+84pMaSGCziP1tP9KJKOlQj2FU27FjhQhaIsr
	 Yws36e2g28aXarOO4d2QCLQqeUB4Ivsmhd/a44F/IKC731tYglYpVw1nbzY/ipS2Vj
	 RWxQGu14/1oUGOJs28Ch+7kpUY/Y4I4Yo1NUMeejGeFTFmDTM2DzTARD2fQmy1opof
	 LcPlKd/hWS3cF0qt9Hq0bzfV98yJCVmGQEliRAgpeSqdHbJi/Ajp5VuYcPH850zl+e
	 lHu82+k9g+xRQ==
Date: Thu, 27 Aug 2026 08:33:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: js node <xuziyougm@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, ericwouds@gmail.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net] net: phy: air_en8811h: restore LED GPIO output
 after MCU restart
Message-ID: <20260827083319.391122ea@kernel.org>
In-Reply-To: <CAF2gcSXK6H76A5Z6-k-D04VaCR4QXNiWLmbQmcCBpsW=L+Hwyw@mail.gmail.com>
References: <20260820141034.1400439-1-xuziyougm@gmail.com>
	<20260824185043.2701718-1-kuba@kernel.org>
	<CAF2gcSXK6H76A5Z6-k-D04VaCR4QXNiWLmbQmcCBpsW=L+Hwyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Aug 2026 11:14:13 +0800 js node wrote:
> Looking at the register layout, I agree it is very likely affected.
> However, I'd prefer to keep this patch scoped to EN8811H where the
> fix is verified, rather than extend it to AN8811HB based on
> speculation.

Please fix both based on our best guess/understanding.
Leaving other variants buggy makes the code very confusing for people
who don't know the history, leading to more and more bugs.
