Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BF03F824B;
	Fri, 26 Jun 2026 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782483924; cv=none; b=gD4IDIZehlDGWeX+fw0rSobnKkXRZL8dc+1Yc5P/4lmIqOXnH9aR8bjQ7tq6ImgBVPY9sL0gQKO/5xedQda4mGou3C15k9CtDHvsPYTPA+Tk9Hi7oi0CxGbnZsbShwTfQyJoXqnU2fsapwrqJD6iwk8FMoVUXIGF0FhKI2iSxa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782483924; c=relaxed/simple;
	bh=zFXw28tcp2znXE5YvFHH1BdbJpUtf0ZvLVZs71XWQbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=attyQwY5x6g9jl6XPFbuDWLzS2BVR+9GwPIkIFjvbjbK7RapE0QBeDfsk/SagYU9Lxf/X5nGd2uMBOQQMa+UvsytOUgEHURbt3q95CPKbtJzQemUvGJ3RbN2wxm08cT9DkFVHWhTIDKZO7O2eOg9IuF+Guw4bu2Bs27TOj2DM3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SlhftcQo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SlhftcQo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441BD1F000E9;
	Fri, 26 Jun 2026 14:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782483922;
	bh=Mq5eB87xLrwNqO+AmRAx98AdQSUns2cVe/ldlPXsX14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SlhftcQoyt+CCvsFrPLqCbzrYbKhix2b1KAVgU9jE1ER84hpdJ5RoaGVryqSJBFqK
	 tlCi2DM/GtanGUCMkLwnL7TXrNNQtXobMg1AspzsQZtDl48fwaKFabEaac4blBeM+0
	 nibbMs0foCEmhcjqrKp0o117YZG0XpYNydueh2Ng=
Date: Fri, 26 Jun 2026 15:24:09 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: krzk@kernel.org, s.nawrocki@samsung.com, cw00.choi@samsung.com,
	mturquette@baylibre.com, sboyd@kernel.org, alim.akhtar@samsung.com,
	bmasney@redhat.com, linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] fix: clk/samsung: exynos_clkout_probe: success path
 leaks parent clock   references from of_clk_get_by_name
Message-ID: <2026062612-twiddling-lagged-62ac@gregkh>
References: <20260626120135.34173-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626120135.34173-1-vulab@iscas.ac.cn>

On Fri, Jun 26, 2026 at 08:01:35PM +0800, WenTao Liang wrote:
> of_clk_get_by_name() acquires clock references stored in the local
>   parents[] array. All error paths correctly release these via the clks_put
>   label, but the success path returns 0 without releasing the parent
>   references. The references were only needed to obtain clock names for
>   registration and are permanently leaked after probe completes.
> 
> Cc: stable@vger.kernel.org
> Fixes: 9484f2cb8332 ("clk: samsung: exynos-clkout: convert to module driver")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/clk/samsung/clk-exynos-clkout.c | 4 ++++
>  1 file changed, 4 insertions(+)

For all of these, you are not using the normal kernel style, which means
a LLM is generating them, which implies that you did not properly
document what tool found/fixed all of these.  So please go back and fix
them all up and resend them properly, after telling the
maintainers/developers that the originals should be ignored.

thanks,

greg k-h
