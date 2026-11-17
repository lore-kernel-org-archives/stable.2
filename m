Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794918130;
	b=AxQxxwoHuaP9TExjJDsqlX05crRYlwZ9pj0lo8yhBluZ66H1dzBO8GyA0oNPLX5zRleo
	 AHpcfqqcMK7w1tuvHk4ZsjqiVsYJZTun4/43XM/rZNzt8VHK//GIMEShU54ehhDn9yNn3
	 4ztFmmwpog8fv7rjZcazCemkzouYJhecnWeXhBxMxDRn2Y1xVgX1xJ31CG+5i/LkUd4Cs
	 mHj3uWAgTtl1OEKwhgLtPRai8R03FrFuMa5fMU3Z4k5CGDaANjEmYXsq2TsM8qv5QcKF3
	 A9G6AdNFS+MXo8aoAGwf+mC+VDywqJQhHaSepeQSxnIRJHoux4Nbou6c67XTUHdupBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794918130;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=5dU036u9J5ChMGaHb9RB5xZYrWadr4KxpK+WZRfB+g0=;
	b=qlihzGD3yCpRHUT1VVle+eSiAdOmFk35ZLrrA6QwYoas20M4zMzRE3eTMAvdal+nejOA
	 kxKxig0Ov+jqL1eUoT9jK5lnfJwGIu+8R+M0HKMUOvHLGqLEZJUQ483AzoQMiKOJZW2Kc
	 dduwll5UMNYb1dj5iQKmO2UmrvjwJMDQUO2Zn/e7JfxqL9ped1q+jEeqV1kOsitbEaCZQ
	 FtOBkN+SFwz/pcpQGqIU/2ey/etqBXKE/cRj+hYsKsTPXpKkOciPHBpG8kyl+VOgFT2BX
	 iDw0qw9WyVwkfjJZ8fNTQYCBgAH5r1VC3l1InGUJB6R0CX+2WQBNM6zEEW2mkB0RgGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KA5k7YDl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C458606A31C;
	Tue, 17 Nov 2026 12:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KA5k7YDl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B481F000C4;
	Tue, 17 Nov 2026 12:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794918129;
	bh=5dU036u9J5ChMGaHb9RB5xZYrWadr4KxpK+WZRfB+g0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KA5k7YDlTN/loOdKyoP6k13vortRVZqxhoL77dZ0kTcbDM6c/vf7/1k/9T+4ujhsB
	 eHAzAi5+MuMoTOW5hRDDiK6CY1hsFBbKAzNHST8S82FL0JgViNwhRVhr+ki1Croy/7
	 /rpEp9MxxIFpIMCfIwECjTlcHW/OddJlVsbzf7XNcXqghhZOoF50ZIhkoyqfRHdTdi
	 KjD5eaWL+y4Xm9+MptsewRdKXsMKyibOUPhSxSePhHPZ2zF3Q/d0mCCYZs3L5Ehfzj
	 uDD+2A0lp2NiGqYUeb4F6iIABSW6gdi3xjXH6wT1bNkZZlTjorI5AFQ71qVC2AW/bn
	 BrPogZjwFSd1g==
Date: Tue, 17 Nov 2026 12:22:05 +0000
From: Lee Jones <lee@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Aaron Kling <webgeek1234@gmail.com>, linux-gpio@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 02/10] pinctrl: tegra186: Fix out-of-bounds register bank
 index for AON drive groups
Message-ID: <20261117122205.GB84168@joneslee-macbookpro.roam.internal>
References: <20261103213002.1673560-1-lee@kernel.org>
 <20261103213002.1673560-3-lee@kernel.org>
 <avw8tOcBNMPwS_z5@orome>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avw8tOcBNMPwS_z5@orome>

On Tue, 17 Nov 2026, Thierry Reding wrote:

> On Tue, Nov 03, 2026 at 09:29:07PM +0000, Lee Jones wrote:
> > The Tegra186 AON pinmux controller has only a single register bank
> > (nbanks = 1, indexed at 0), and all PINGROUP entries in tegra186_aon_groups
> > accordingly specify bank 0.  However, all 51 AON drive_* macro definitions
> > pass drv_bank = 1 as the final argument to DRV_PINGROUP_ENTRY_Y, causing
> > any drive configuration read or write on an AON drive group to index
> > pmx->regs[1] out-of-bounds.
> > 
> > Update the AON drive_* macro definitions to use register bank 0.
> > 
> > Fixes: 542baf77f092 ("pinctrl: tegra: Add Tegra186 pinmux driver")
> > Closes: https://sashiko.dev/#/bug/linux-a9a7165c-c5eb-463a-b7b1-24a30416b33b
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lee Jones <lee@kernel.org>
> > ---
> >  drivers/pinctrl/tegra/pinctrl-tegra186.c | 102 +++++++++++------------
> >  1 file changed, 51 insertions(+), 51 deletions(-)
> 
> Yeah, looks correct. It looks like this wasn't tested at all since the
> time this was merged. I'll add this to the list of things that need to
> have a test added.
> 
> Reviewed-by: Thierry Reding <treding@nvidia.com>

Super.  Thanks bud.

-- 
Lee Jones
