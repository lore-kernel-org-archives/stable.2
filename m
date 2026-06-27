Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8EA227EA4;
	Sat, 27 Jun 2026 17:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782581285; cv=none; b=Kg2XPBvwbhP652iBH+MAzTaNXG9ZF7z9AywCCQYVQLVGl5169QXMSlsKiVZoi9VYBAY5NzgF91Ve86BUi9Xc++NS5nWKIJf1D9e7uAnANc1SnZI9UwAHkwWkf7HdbUcjS6LN+A90Jr9kHeOdAl/CwhH6RQwPZArwDDLaay64IYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782581285; c=relaxed/simple;
	bh=DmZDPPqhhkvHZLZb6YokbPqUR4ydJKbf0IXnVNJ1PUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nsJe8CyRp5QcGlqm1vusuzajEcLacXCnCaObQ8cQT5l8v0eCED4Uxyy0zQzVorNZSf8zD0M52r97g9pnMPniFgLtIHIwOUKG8KzB0Unw2yihBcemloiylyzNIOpzJ5CjKPjfz0IfK1XEY7VHbp/iOTgYvuFIbjfuAZq/ViIumss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xn9DlXaG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xn9DlXaG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC2B1F000E9;
	Sat, 27 Jun 2026 17:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782581283;
	bh=nH9xtVPzbPWocfOAVQI1VzHO7nyVTdC36kSsc9UTgzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Xn9DlXaG3KC9wdc99i+Ulwez0X/m1yy5C/uOxFiGfNqxy41v8TKKh5zKWRcSxVvW0
	 Ou7BlXKIvzKdvg3hc/Zqx/N4Fnoqfm87Pfaa0DJpzyoDJQvG22p5ZpZdeHx4rNiLgh
	 /qLeQn9iOUdH8/k7AwWwMMuB5Iydro53kKGXn7DM=
Date: Sat, 27 Jun 2026 18:26:45 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: krzk@kernel.org, s.nawrocki@samsung.com, cw00.choi@samsung.com,
	mturquette@baylibre.com, sboyd@kernel.org, alim.akhtar@samsung.com,
	bmasney@redhat.com, linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] fix: clk/samsung: exynos_clkout_probe: success path
 leaks parent clock   references from of_clk_get_by_name
Message-ID: <2026062704-detail-machine-270f@gregkh>
References: <20260626120135.34173-1-vulab@iscas.ac.cn>
 <2026062612-twiddling-lagged-62ac@gregkh>
 <10D15C29-89E4-4A0B-BB89-F03A86963DDA@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10D15C29-89E4-4A0B-BB89-F03A86963DDA@iscas.ac.cn>

On Sat, Jun 27, 2026 at 07:42:36PM +0800, WenTao Liang wrote:
> 
> 
> > 2026年6月26日 22:24，Greg KH <gregkh@linuxfoundation.org> 写道：
> > 
> > On Fri, Jun 26, 2026 at 08:01:35PM +0800, WenTao Liang wrote:
> >> of_clk_get_by_name() acquires clock references stored in the local
> >>  parents[] array. All error paths correctly release these via the clks_put
> >>  label, but the success path returns 0 without releasing the parent
> >>  references. The references were only needed to obtain clock names for
> >>  registration and are permanently leaked after probe completes.
> >> 
> >> Cc: stable@vger.kernel.org
> >> Fixes: 9484f2cb8332 ("clk: samsung: exynos-clkout: convert to module driver")
> >> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> >> ---
> >> drivers/clk/samsung/clk-exynos-clkout.c | 4 ++++
> >> 1 file changed, 4 insertions(+)
> > 
> > For all of these, you are not using the normal kernel style, which means
> > a LLM is generating them, which implies that you did not properly
> > document what tool found/fixed all of these.  So please go back and fix
> > them all up and resend them properly, after telling the
> > maintainers/developers that the originals should be ignored.
> > 
> > thanks,
> > 
> > greg k-h
> 
> 
> 
> Thank you for the review and guidance. I understand the issues now.
> 
> I will:
> 1. Study the proper kernel coding style
> 2. If using any automated tools, document them properly in the commit
>    message
> 3. Fix all the patches following the correct style
> 4. Send a v2 series with proper version history
> 5. Inform all maintainers that the original patches should be ignored

Do this right now please!

> I apologize for the inconvenience and will ensure future submissions
> follow all kernel submission guidelines properly.

Also try learning this by doing just a few patches first, not hundreds,
otherwise you run the risk of being outright banned from development.

good luck!

greg k-h
