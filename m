Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E7B4A9D6F;
	Thu, 17 Sep 2026 21:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789682285; cv=none; b=DnMZllclaZzw9Ha3QRogUOHJqDO/mBXOEGjhdUTKNL0kXkez+4xEstgxjtW44TSWNawyVTreQmh+xrtDpji/qwqEiLSYyJCvA2U7L54gSN/H8uGtyA/s2RKHi6Cm86n1rCPgCcpqjPx4OskpIYF0RZKZKGjS0SHv5Bgc9ww7kuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789682285; c=relaxed/simple;
	bh=K01OWSwrQhLZ1I4m5H6/VZez8MW387RtFv6BpX2DCqw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sFcIxFHANUSahWJbr/SjATTvdf8WQqbgzaWtdxjGslJzO2xkb/A0domwMQJpZBjrJCd0qHKyjzziwqN22lGQRzf2sh9T25xZi5x3+kD+i3VnxZUFo7oY0k5y90EFJfoQA8MVdJ07ybqGeoSpQekJyw0wza3gili/1yU7+vv2T7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMs0O2Bc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMs0O2Bc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7769B1F000FF;
	Thu, 17 Sep 2026 21:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789682283;
	bh=OP3JYLBXOqOHgXrUVwmby9CoOJ787szehasQI38rGyQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=CMs0O2Bc4ICSa1T8bJvuWgzlf1kyPiBEEAF8YyNkZlKYj7AxxFwuNZMf3kUkq6Spa
	 2qeDwdnLti+1xiaJ9UVSm+RmoHRrX3uzf2/IH2yZFTVvppENKWnC0ZpTieYrfRdFxR
	 CSNdnYwPeuvBZBm3nKeHhvWK+Q4iUClTWxeQ0Oawmp32DyR1beYSUW/qKkJZ7GvprH
	 GqeZzJlKBlIJ1lXFBksRX5HROuSwupFZSnbecaWuaYZeecNNWl9Nc+lEaSKRZjTJ3k
	 JUckV5Lra7ixgKiCSl9YKGOc8KE0Jk+DOq5/1uERCzIaTyfo5f752rKdDTL+lqMFs1
	 k4YU98t7DQ4FA==
Date: Thu, 17 Sep 2026 16:58:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	leoreis.costa@gmail.com, fra.schnyder@gmail.com,
	francesco@dolcini.it, frank.li@nxp.com, l.stach@pengutronix.de,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, hongxing.zhu@oss.nxp.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>, stable@vger.kernel.org,
	Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: [PATCH v2] PCI: imx6: Move clock enable after core reset
 assertion
Message-ID: <20260917215802.GA1056201@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ed9e4de-2e57-4c15-875c-16512f00163f@leemhuis.info>

On Thu, Sep 17, 2026 at 01:08:03PM +0200, Thorsten Leemhuis wrote:
> On 9/2/26 16:15, Manivannan Sadhasivam wrote:
> > On Thu, 13 Aug 2026 17:50:03 +0800, hongxing.zhu@oss.nxp.com wrote:
> >> Commit 610fa91d9863 ("PCI: imx6: Assert PERST# before enabling regulators")
> >> inadvertently moved clock enablement before core reset assertion, breaking
> >> PCI device initialization on i.MX6Q Apalis platforms with
> >> ASM1061/ASM1062 SATA controllers connected.
> >>
> >> NOTE: It is not 100% clear if the issue is specific to the ASM1061/ASM1062
> >> device or on the specific power-up sequence (reset vs cold-power-on).
> >>
> >> [...]
> > 
> > Applied, thanks!
> > 
> > [1/1] PCI: imx6: Move clock enable after core reset assertion
> >       commit: 16929741a622eb345057e41c7b335d9b297890e1
> Thx Mani.
> 
> Mani, Bjorn, what's the status of this patch? Is it heading to mainline
> any time soon? This (unless I got confused, which is possible!) afaics
> fixes a 7.2 regression that annoyed quite a few people -- which is why
> it was even briefly considered to revert about a Dozent changes shortly
> before the 7.2 final:
> https://lore.kernel.org/all/20260811214900.GA763236@bhelgaas/
> 
> Didn't come to this, but it afaics would be good to finally resolve
> this. Or am I missing/confused something?

It's in pci/next, but probably should be in for-linus.

I moved it to pci/for-linus for v7.3, thanks for the heads-up.
