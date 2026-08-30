Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9312E7396;
	Sun, 30 Aug 2026 23:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788134256; cv=none; b=JrhXwML7M89iKrLCxz7dWLoIaO26gk5HzEBXn1K6ixVUvJt4VbjjlYBny1sYVJyQh0Ko4l/uYgU6fmrT/+PnRhs3bTeU+HXizeHUv/jrgHcFm/XzKxWKEELvUbQCkSH39eGjlsuAOjaS7gom3c7uNliA8WEOFy7+dnIEKi/ls7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788134256; c=relaxed/simple;
	bh=u6uVkbROqgEmpkePXpsow92Di9+pPZesG4KZe0CvZP0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rQw+s/k6d6iFAYshTb5IdNCZ+9IudGieH1PEWW0UDHNqHHNEwCPJ0yM5p+gmrWPDGuHtTBM1zSTJ0pTukc5IU8uEpU7RLkiZ3u3LVXIV2U1/rZhcIUNLQpZMHwnxPzJIGYIrLYyWGlg1Q9c1tZx3821vmNcVwg7UVjs0Fy/FvPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpnmjXXO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpnmjXXO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5209A1F000E9;
	Sun, 30 Aug 2026 23:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788134255;
	bh=ZK5RX3djCBeW83wImVahZU6spUvB3gHUKmlbJ6W1v0s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IpnmjXXOXbWKrOtujXOtuS25+aMIMguPd8OtT1hduYwLN4Jg+KgokhvK8uTlBlHPu
	 ZLldHjJtKWPqkGPe2yiNLyNjSZEWNXTd5hnreRkovyY1Fsi7wpYn6kZHLQx+x7wx7s
	 jcuaMv06o+SQXnexDboQdOQN9L9tGX6OiBE+5HmaF2+Oz4WQg72nY0qI9OOdGxfMrL
	 GRqp+6mWrf29sL+1mRr8lrGBtsxEDpo5gzctld3z7Fu9KZ64MFzO60Om5eZ5gO2fgI
	 22UCrOnmqSs59G8BYpk7OnWw8VtxXrFx3fwLxXiY1sJd3rojwtudOM0EGazhbQD8Hh
	 iXYTsVyWC1Oug==
Date: Mon, 31 Aug 2026 00:57:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Linmao Li <lilinmao@kylinos.cn>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 linux@analog.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ade9000: fix NULL pointer dereference in
 clkout registration
Message-ID: <20260831005728.4c2b80b9@jic23-huawei>
In-Reply-To: <20260826083156.2287106-1-lilinmao@kylinos.cn>
References: <20260826083156.2287106-1-lilinmao@kylinos.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Aug 2026 16:31:56 +0800
Linmao Li <lilinmao@kylinos.cn> wrote:

> ade9000_setup_clkout() passes NULL as the register address when
> registering a divider clock. During clock registration, the common
> clock framework calls clk_divider_recalc_rate(), which dereferences
> the address through readl(). As a result, probing an ADE9000 configured
> as a clock provider with an external input clock crashes.
> 
> CLKOUT passes CLKIN through without changing its rate. Register it as
> a 1:1 fixed-factor clock, which does not require register access.
> 
> This change does not affect the configuration using the internal clock,
> for which the driver does not register a clock provider.
> 
> Fixes: 81de7b4619fc ("iio: adc: add ade9000 support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>

Looking for a tag from Antoniu for this one.

> ---
> Changes in v2:
> - Clarify that the configuration using the internal clock is unaffected.
> 
>  drivers/iio/adc/ade9000.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
> index e57e24b6acdf7..4e96cc37fbedf 100644
> --- a/drivers/iio/adc/ade9000.c
> +++ b/drivers/iio/adc/ade9000.c
> @@ -1647,8 +1647,9 @@ static int ade9000_setup_clkout(struct device *dev, struct ade9000_state *st)
>  		return 0;
>  
>  	/* CLKOUT passes through CLKIN with divider of 1 */
> -	clkout_hw = devm_clk_hw_register_divider(dev, "clkout", __clk_get_name(st->clkin),
> -						 CLK_SET_RATE_PARENT, NULL, 0, 1, 0, NULL);
> +	clkout_hw = devm_clk_hw_register_fixed_factor(dev, "clkout",
> +						      __clk_get_name(st->clkin),
> +						      CLK_SET_RATE_PARENT, 1, 1);
>  	if (IS_ERR(clkout_hw))
>  		return dev_err_probe(dev, PTR_ERR(clkout_hw), "Failed to register clkout");
>  
> 
> base-commit: 6b9f23b5460818aaf199dda90210d5fc08d66c8f

