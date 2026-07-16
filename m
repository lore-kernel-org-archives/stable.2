Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7A02DF6F4;
	Thu, 16 Jul 2026 06:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784183574; cv=none; b=EpVxLvR4CZ4Ui4hJHB1MuoDw2uBOa8lEvlPhAotAlAQbzyQFsBmYHBlUGiOJ5ygroeK69es9vHEhw+PILPm5i2CL4OTsnf2hvY3pADxsF5hBSCGRYn2IASGTAIb4Tx4y6sHM2c67amVtXPDT+IQW1pmo+vWm25r5zKCKaZaL/YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784183574; c=relaxed/simple;
	bh=lDA7uCvnT/xeTZbznuLWB9yjRaZIyZth5Q4edj9STPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ro+DHdSdBQGiIdddgCfAhM94t6qCwTxPbYbax8w6cTA7PN8upb8/w3IwZaJKA6KIqLwZIMSkCGPzt1W0iYi/vqmpvbmViCG4BmFN5wmn0YgEi45GI/wfiblsw17g2W0MMVeQawMqXGCIa54MSnq9thkZagasS1UDU8Iza4g0S5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=GL0tSqxS; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="GL0tSqxS"
Received: from francesco-nb (xcpe-178-82-120-96.dyn.res.sunrise.net [178.82.120.96])
	by mail11.truemail.it (Postfix) with ESMTPA id 1E74522924;
	Thu, 16 Jul 2026 08:32:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1784183570;
	bh=CoCwsfMousf3sBF2a1Ij+N+podS4wPT0tmTiYv/NXgY=; h=From:To:Subject;
	b=GL0tSqxSA7SnfbpyAmsErQKldrT3tyUoqBWFRihEQ15AmxuDWBAJhNRC+in+l2rLo
	 myzbAnmZB8NHGJxxrqbmThqw163lgkP3WI2hbwOQq1YFUoIaV1V9T5Jbs7vm74HOfb
	 +cYanV+u6qYUVo/K9e8lcew5CjI72Y1MY4whH0WuKqpoQEmsFGxysZb5rD5omrXjdS
	 UwIrMdN5JdvxEFQWrmvDITkr2absnHSEc+Wi0w64PzBom8fhDG+uSoIl6HQTFWuHQW
	 e2MyvOiR2uv+/S77+V69hEXfJsZFyQjdvcbMqO2GbXdxUqnJOMRh3g25VtfzFw8l9m
	 JR/gg7QKck8eQ==
Date: Thu, 16 Jul 2026 08:32:46 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Dan Carpenter <error27@gmail.com>, johannes.berg@intel.com
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Georgi Valkov <gvalkov@gmail.com>, briannorris@chromium.org,
	kees@kernel.org, bhelgaas@google.com, s.kerkmann@pengutronix.de,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] wifi: mwifiex: replace one-element arrays with
 flexible array members
Message-ID: <20260716063246.GA17850@francesco-nb>
References: <202607150932.F2A0836@keescook>
 <20260716001728.57799-1-gvalkov@gmail.com>
 <20260716061638.GB9973@francesco-nb>
 <alh5y74H5bJyDSSP@stanley.mountain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alh5y74H5bJyDSSP@stanley.mountain>

On Thu, Jul 16, 2026 at 09:27:23AM +0300, Dan Carpenter wrote:
> On Thu, Jul 16, 2026 at 08:16:38AM +0200, Francesco Dolcini wrote:
> > On Thu, Jul 16, 2026 at 03:17:28AM +0300, Georgi Valkov wrote:
> > > Replace deprecated one-element arrays with flexible array members.
> > > CONFIG_FORTIFY_SOURCE reports the following warning when
> > > one-element arrays are used as variable-length buffers:
> > > 
> > > sta_cmd.c:1033 mwifiex_sta_prepare_cmd
> > > memcpy: detected field-spanning write (size 84) of single field
> > > "domain->triplet" at .../marvell/mwifiex/sta_cmd.c:1033 (size 3)
> > > 
> > > Convert affected structs to use flexible array members.
> > > - Preserve existing wire layouts.
> > > - Use DECLARE_FLEX_ARRAY() for structs inside affected unions.
> > > 
> > > Tested-on: WRT3200ACM, OpenWrt
> > > Signed-off-by: Georgi Valkov <gvalkov@gmail.com>
> > 
> > Cc: stable@vger.kernel.org # 6.12+
> > Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Are we CCing stable for this sort of thing?  How many FORTIFY_SOURCE
> warnings are still remaining?

Yes, you are right, my mistake.

Johannes, please be sure to not have the stable tag in once you apply the
patch.

Francesco

