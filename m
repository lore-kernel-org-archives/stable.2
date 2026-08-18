Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84354442B39;
	Tue, 18 Aug 2026 09:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787045233; cv=none; b=arKjy4LkIY4hKibkpJLyf23+ckNJQJaH88NEFs3sy/0dPu/S4CMVX1d5dB9Wc9nexcgHuM5Ygr0d160zGydQorF4ysCwyGjR3rCSVc+BBGokd9UkdyDaPq383Oy/rCt8yNIMTuZFgUDcLusgJ3IGWbaqUqy6o6fZMwtXI+6zWCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787045233; c=relaxed/simple;
	bh=QIVFiD43+1OPw/wHvwwLZ/TaoJRXAySqKqdidyBCAj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WRooAXOs3wvSD3M4FrHVYLud3debyEBpvN+wDMdpeNLa50ibPjOiGkudBlH25PpWJZEwK9EwNiD82kMkyW8RfY9y4zfTrVZPoLQ7ZjWxRPsaBtNfP8PL5tMYfQXIzQzUmNwFUldu9G2ylx0mmgom/TPFYz6+Vcdh0vb4BFitpE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nAg4bcC2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAg4bcC2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 073451F00ACA;
	Tue, 18 Aug 2026 09:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787045232;
	bh=xUcfhj85sX4cPSzt12bp3zzQ/yVXxAtFH+q/piQ/qBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nAg4bcC2+xd4rXCg1Xoy05lf0LRLLNQkiFqvbfD1IZWaPZSWI34IBfju7U4vO1r+Q
	 n4+E3PM/xuCbBLjsOhVYbKrZ+8M+aFTsDHOHiMaAxEIoywpR4tMLpybhBVzRmGXRQf
	 AmHs+8M/RWjcxUZFa5vlMaQn7c+8SS7wAvccJiyCL7audVJddbgsGZ1dDVtbV1FrTN
	 65e5nDotPtuakJ7snWZFdnM5i8faaPQOJHezh+irnjm0AlAmnuVkzvZW353tiwG4CB
	 UpaSA+l+dB3St2LCtm9OcXWuq/cM4LInNCYeVpKbmolYlwbm0hdUyTQWi2w5rB17y0
	 OXulz5OKBHQLw==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wwG69-00000000oqO-2TCu;
	Tue, 18 Aug 2026 11:27:09 +0200
Date: Tue, 18 Aug 2026 11:27:09 +0200
From: Johan Hovold <johan@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>, linux-clk@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] clk: imx: scu: fix autosuspend cleanup on probe failure
Message-ID: <aoQlbUquNf44_eav@hovoldconsulting.com>
References: <20260808082933.2692878-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260808082933.2692878-1-lgs201920130244@gmail.com>

On Sat, Aug 08, 2026 at 04:29:33PM +0800, Guangshuo Li wrote:
> imx_clk_scu_probe() calls pm_runtime_use_autosuspend() for non-CPU
> clocks, but its probe failure paths do not call the matching
> pm_runtime_dont_use_autosuspend() before disabling runtime PM.
> 
> If the autosuspend delay is set to a negative value while autosuspend
> is enabled, the runtime PM core increments usage_count to prevent
> runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> during cleanup, this reference is not dropped and usage_count remains
> unbalanced.

As I've explained elsewhere, this is just misleading. There is no usage
count leak here as the count is balanced whenever the user re-enables
autosuspend through sysfs (by writing a non-negative timeout).

Drivers should clean up after themselves and disable autosuspend, but
this is more of a clean up than a fix and should not be backported.

You've sent upwards of 60 of these in the matter of just a few days,
some of which have even been picked up. Please send follow-ups (replies
or v2s) as soon as possible to prevent further of these from getting
merged.

> Add the missing pm_runtime_dont_use_autosuspend() calls to the probe
> failure paths before disabling runtime PM.
> 
> This issue was found by manual code inspection.
> 
> Fixes: 78edeb080330 ("clk: imx: scu: add runtime pm support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Johan
