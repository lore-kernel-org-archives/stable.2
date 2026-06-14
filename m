Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EF6292B54;
	Sun, 14 Jun 2026 22:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781475627; cv=none; b=n2hzQDf0w5FH23aq+rqYtbTzOKZIPLCY0F85T8xlGAedBGxflsVCB1wz4GodMtSHDI+Ru1FeMREIqV3ASFRrd+ldG3G4zsUSQxRzvtm3EI5XA/6udCAsO41ixKnJ/ekffSLF0T67b3Vx32pogX65O5PIKgWu2qsksSb4n54Nd/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781475627; c=relaxed/simple;
	bh=AolzJ5fBKCYhdZoy8bTLrjEDJd4XB/zbqN6ZB63xKyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NpPtA0nlyGckXCDD+JVm0f1BjqQzr1W7H4xWzYKxuJkVpEnGBr/xZyJMzh9TA+CXTMiOK4DQGWfskl3GEKKzvPM5o6ph/ZpKhEhJeIDKwOGVWZF7AR8twUyPc9VfrHllyIxpoePaesiF4AG1ucuEQjCj0pNoscmvWEZq+jY124Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pk+PbvAQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pk+PbvAQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2474C1F000E9;
	Sun, 14 Jun 2026 22:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781475626;
	bh=7RDOpRHXsto/ZnZ2BpjuO3i0UoV7uNmp1csBtkTg2I0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Pk+PbvAQog32lrbAeLhyfFZRdotgRwJRA1rtRd9LNXuh1UGqwuW6tP6p5vMmdWJ05
	 nAAKVx2vh77PZThJWidRzxlpmog9S3x/hpE3pRiZWSg5IYrdmMnqVuEud1HKr1xzei
	 186KjRZjhSXxiSm05dgb1CLShHW1x/u47FAOkISaFjRjzKqGQbWND3jBADRVPwFobl
	 my+NJDRgFV/r01dr6QLOXteOs/yDysxqNkFAqK830UUymDlUoQQVK2vtgxnefmQlBG
	 NRrj6/Kddf4Ace8BhzhxyqeOZBooxM23swbnVklJPRA6qbpmcO9QtYTcq8g0q1icz9
	 NJb9eKmlGjWnQ==
Date: Mon, 15 Jun 2026 00:20:21 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Hongliang Wang <wanghongliang@loongson.cn>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	loongarch@lists.linux.dev, Huacai Chen <chenhuacai@loongson.cn>, stable@vger.kernel.org
Subject: Re: [PATCH v6 2/2] i2c: ls2x: Add clocks property parsing and adjust
 bus speed
Message-ID: <ai8o9vxUX6rbZNV4@zenone.zhora.eu>
References: <20260608024533.32419-1-wanghongliang@loongson.cn>
 <20260608024533.32419-3-wanghongliang@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608024533.32419-3-wanghongliang@loongson.cn>

Hi Hongliang,

On Mon, Jun 08, 2026 at 10:45:33AM +0800, Hongliang Wang wrote:
> The i2c-ls2x driver supports dts and acpi parameter passing.
> 
> In dts, uses clock framework, by parsing clocks property to
> get i2c bus reference clock, and define the div of reference
> clock by device data.
> 
> In acpi, by passing clocks property to describe i2c bus reference
> clock and clock-div property to describe the div of reference clock.
> 
> Based on i2c bus reference clock(clock_a), i2c bus speed(clock_s)
> and div, calculate the prcescale of i2c divider register. The
> calculation formula is
> 
> prcescale = (clock_a*10)/(div*clock_s)-1
> 
> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>

I think Huacai has not reviewed this patch, his review was only
for patch 1. Am I right?

Andi
