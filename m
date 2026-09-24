Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F653B9933;
	Thu, 24 Sep 2026 02:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790216005; cv=none; b=eo+324GudgHB0wjrWQXIXBCk8AzSARf44ogut0QeOWp96cV0wdJ1NzcgzAx7zVc+8AaCSoJXqvXBvtT7ot3q8k+O89XEEi1yb18LYSmrh1CXc+x2tuRfzsb5kB1ohvagk+8RmGOP3P9HO1Z+ddSJMFDOSrsIRnVncm8WCKWRPdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790216005; c=relaxed/simple;
	bh=Tq5R6L/RBZDT+AdIssqLNCvUx5CpiAJs4sgCdQ0If2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7zoHq2G36y6csDMX/f9kd0DDn7isiR1dP1Q8b2b+DQJBlBMV6IIoyhQ1ReZKCKLJN78TCJa6p+p41wXts/O8W06NW3XWCuyVXMA4vYlQoP21/e4R714IJp9n4VY2epLWZ/T1/+ctdYfbkDdHfFG06d1mSiBNLKfdYegtEMnA+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xgb8nMOL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xgb8nMOL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4737D1F000FF;
	Thu, 24 Sep 2026 02:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790216004;
	bh=FYlZeJoBP8nu9jdhbNtZm6ZtdlrHib8ZSDD/RuVVTow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Xgb8nMOL7TxPeS+MjK8lWxnuZQF/r5a0/cysyuwwSFeDctLvI2GyAsotvrsX20KCt
	 4XiOqqBQiTsN/CsP2+2eK1GbosWMszT3J5na8iwNOurOa/fhQ2on9FPnMID+Km/C1p
	 zMeeNR5JTfOtwntdY7VEdH1LG6WS5PbEERvqYXKXeB+r6aFM06pPCpjqKO07ep3tBd
	 xkZLBGmkQ9oKwEIaJ7d33zeZrsbsGQrTFlTPUIKOxJIdPaqnF6lI8IEDaovICgqrGV
	 ziHZhJTst87KPRDvzdbkCwW/i2sQrHs1TMb1PfA8UZVUqUicO98QEqkIPOFrqLLju8
	 okwazLpRWR41g==
Date: Wed, 23 Sep 2026 19:13:22 -0700
From: Drew Fustini <fustini@kernel.org>
To: Aamir Ahmed <elb12345@hotmail.co.uk>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Drew Fustini <dfustini@oss.tenstorrent.com>,
	Joel Stanley <jms@oss.tenstorrent.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
	Kees Cook <kees@kernel.org>, linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] clk: tenstorrent: Assign .num before accessing .hws
Message-ID: <arSHQglLv0FfAmiw@x1>
References: <AS8P251MB00013BD9A093C06D2D60E10EC8B42@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
 <ce401b42-9dfb-4c8e-9051-7ba08c107382@embeddedor.com>
 <AS8P251MB000160067A8B595BB9D743E8C8BF2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8P251MB000160067A8B595BB9D743E8C8BF2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>

On Thu, Sep 10, 2026 at 01:47:31AM +0100, Aamir Ahmed wrote:
> On Tue, Sep 08, 2026 at 11:56:12AM +0200, Gustavo A. R. Silva wrote:
> > Looks like variable num_clks can be removed entirely, and just do:
> >
> > clk_data->num = data->num;
> 
> Yes - it is only read once and data is const.
> 
> Thanks for reviewing, and thanks Anirudh for testing. For the redundant
> variable, since this has a stable Cc, perhaps we can keep the diff
> minimal here and I can send the cleanup as a follow-up once it lands?
> 
> Kind Regards
> 
> Aamir A.

Thanks for sending the patch.

I would prefer a v2 with this change in order to avoid a trivial patch
later. We are still in the process of upstreaming support for the
Atlantis platform, so there are no users yet that would be affected by
this issue.

Thanks,
Drew
