Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB243568FCA;
	Tue, 29 Sep 2026 19:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790711725; cv=none; b=EX2avFS030Xu6tWhe6nJ6aDsL9f9fEZxcD0RvdwO80Z/TZEBt32hEIU6yJ5dlVxvSVR7L2VDk+1y1w/QroBEdoAVvK77qGkJOWvEVbvPfcPGNBNxOafYsEs4yZXRFOUlloeV4r2BMfybGHJjbRmMx151enqShiiyOHBL0KypU/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790711725; c=relaxed/simple;
	bh=ZdBVVYhs8ucGQJsrN69gWfFbyyqgSaNpY0JZk86j1zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/LKhSs52ZxqTbyax9p1vPj+2hxWLtUhp9fKCT4/s5WjW9kV0GNwLp4+RXivFhV3P/gKQB5YpeRJtKxf+TlcIfOzLxazQdPAyumMT+uzMQWqhuOGnEzJ66n5N4fnKXVvI0/KWhKiueLdp1/W6gwrEDyzQOK8QOVllbqwQQ/hKZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOwkZk8E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOwkZk8E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC061F000FF;
	Tue, 29 Sep 2026 19:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790711724;
	bh=iB9OihUdNpovJy2l/Ipn5MetrsvjMVExaZ/AmkjE4LA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OOwkZk8EKiaZ4g55alEPL1ivnLz4sCKU0U2L7EdfvB3tUPTnqVDgjHkcxbgLTlrCk
	 hCvPCXdgKce/gCGULTuSJliOUBPdGK0KRQQkGE1OHqEyIgQ59SpDp83NqagfXtw90Y
	 uq8mXG5KRGRid3MjtA1SMExTAQLh8w9MF7pSXM811RyyU0eXTLDGXR2O5u3RV4Iyph
	 2gMBFM372a0O+ErgHQtvUNorN5RxhKw4vpcOMdULNCBKgZKp99J/TJr6GNVXiX1qXX
	 dcF0f3kffbKNSQF9HcePMw0OMBFjjotvrb+bs2K5/n6N99jdPLWbEeqQ2ZHq13KBho
	 BuOR8hqvmBXAg==
Date: Tue, 29 Sep 2026 12:55:22 -0700
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
Message-ID: <arwXqtNq63F9D9M6@x1>
References: <AS8P251MB00013BD9A093C06D2D60E10EC8B42@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
 <ce401b42-9dfb-4c8e-9051-7ba08c107382@embeddedor.com>
 <AS8P251MB000160067A8B595BB9D743E8C8BF2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
 <arSHQglLv0FfAmiw@x1>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arSHQglLv0FfAmiw@x1>

On Wed, Sep 23, 2026 at 07:13:22PM -0700, Drew Fustini wrote:
> On Thu, Sep 10, 2026 at 01:47:31AM +0100, Aamir Ahmed wrote:
> > On Tue, Sep 08, 2026 at 11:56:12AM +0200, Gustavo A. R. Silva wrote:
> > > Looks like variable num_clks can be removed entirely, and just do:
> > >
> > > clk_data->num = data->num;
> > 
> > Yes - it is only read once and data is const.
> > 
> > Thanks for reviewing, and thanks Anirudh for testing. For the redundant
> > variable, since this has a stable Cc, perhaps we can keep the diff
> > minimal here and I can send the cleanup as a follow-up once it lands?
> > 
> > Kind Regards
> > 
> > Aamir A.
> 
> Thanks for sending the patch.
> 
> I would prefer a v2 with this change in order to avoid a trivial patch
> later. We are still in the process of upstreaming support for the
> Atlantis platform, so there are no users yet that would be affected by
> this issue.

Applied to tenstorrent-clk-for-next with that fixup so there is no need
for a v2:

  da9f1312b06e clk: tenstorrent: Assign .num before accessing .hws

Thanks,
Drew
