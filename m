Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7272EBDE9;
	Wed, 30 Sep 2026 11:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790769337; cv=none; b=t5mtyTTBsDo6jJBUVhiajl/YoFy634/Br/3FMsrHZPiozYfxbdemM3Dxp5W7l7vQ/t1yLzxoYFBSC1IfJpQ4T795JRtWJVMhAmc4qbbueuUFbga7T/sjJAai4T075yqHUKZ5cGkcXz/SRA7qnh6h/f/JjkIH2CeGcaFd+Zh6OFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790769337; c=relaxed/simple;
	bh=RJ3PFtSXV3VjA/T+92PcgYsKJVGmk8iC6uL5M9GSLx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3p0wZCTWGAXmTWq2ixiD2ob+Z7tD/u5tSaL4E1qX2wjZQWxBUUsgx9vFzhnBGFw4sEh5mH6lj31cVbm1POUowv4pIYxt0LQFwdFe8vfIKfyAbafcM1dfrzhK/FN+kyo0q3ZRBN5noIlNXLCSJYzY/6IBlUStEvorkZ/qEpl1sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzmNi4Da; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzmNi4Da"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C5A1F00893;
	Wed, 30 Sep 2026 11:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790769336;
	bh=5meFYk8A6OECXcbERFC8vfkK/C/8PqfInrhYe4+ifGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LzmNi4Daa51WDFjSoir1xbp6dOJXW+dMjTMrMdtLb43+u6E0X6pmPHDFH7bUpBdfh
	 evfZ6y5kYwH7O3rue728Rh6422nWbNsJiGvmI69G89oEhXRrych7qKgXibxv1hYKwz
	 N+vOi6fWtCQBWveRnn0uYoRqLUF0GrziA4Fv2IqQGkFGzUxZP8z6wbkTucuvvvYWMZ
	 EOKuBMTp75lPiDRgzTL0iRS7hAdnIojvWjFXz4vg2MWEbWbXGsRjab/84bbEc8egYm
	 0ud5d0aIdWGMJRYc4jSJtLPOsTKDbT2fRrbzlsxKsSmIh4M9pnwQj5Y7bum73AL2Bn
	 pI1jB9Jl9vtNw==
Date: Wed, 30 Sep 2026 13:55:32 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Jacky Huang <ychuang3@nuvoton.com>, 
	Shan-Chun Hung <schung@nuvoton.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chi-Fang Li <cfli0@nuvoton.com>, Arnd Bergmann <arnd@arndb.de>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Avi Fishman <avifishman70@gmail.com>, 
	Tomer Maimon <tmaimon77@gmail.com>, Tali Perry <tali.perry1@gmail.com>, 
	Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>, 
	Benjamin Fair <benjaminfair@google.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Steam Lin <STLin2@winbond.com>, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, openbmc@lists.ozlabs.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v5 2/9] dt-bindings: clock: ma35d1: Document the missing
 crystal inputs
Message-ID: <20260930-asp-of-pragmatic-discussion-16abe9@quoll>
References: <20260929-perso-ma35d1-upstream-clk-v5-0-68533e935ee4@bootlin.com>
 <20260929-perso-ma35d1-upstream-clk-v5-2-68533e935ee4@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260929-perso-ma35d1-upstream-clk-v5-2-68533e935ee4@bootlin.com>

On Tue, Sep 29, 2026 at 04:44:45PM +0200, Miquel Raynal wrote:
> The MA35D1 clock controller takes two crystal oscillator inputs from
> the board:
> - HXT, a high-speed 24 MHz crystal for most of the system
> - LXT, a low-speed 32.768 kHz crytal for the RTC and low power modes
> 
> So far the binding was expecting a single crystal. The example named it
> HXT, but no real definition for it was given. LXT was not even
> described. In order to remain backward compatible, we will continue to
> allow either one (HXT) or two (HXT then LXT) input clocks. I propose to
> give those phandles a name to clarify what these entries expect, but I'm
> not listing the clock-names property in the required block, for backward
> compatibility. The rates are fixed by the TRM, so even if the second
> oscillator is not described, the OS can make an educated guess.
> 
> Fixes: 2f8b5eb589cb ("dt-bindings: clock: nuvoton: add binding for ma35d1 clock controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml    | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

