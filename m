Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0B831F995;
	Thu, 17 Sep 2026 00:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789606527; cv=none; b=GzOIfMPkY6ZH09tbMU+9NYnA76CKYhejAdwWTjaz4qQRr1zd5Q88Tghll2nNH3HfouqNuaCeqYBQAeUYOVc+SkRko1BMBamOnstJiuu2aLlkkNTy4Oscr1FhUwc4c7yQt/tvtDIkrupdytPzNKYYMqZPF1wgAVz7S7BUorRVsuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789606527; c=relaxed/simple;
	bh=5Gk7YOcQjobOARYVTo8Zbsh/Xcyr08ld8sdEcA9Hiyw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PXrok7WZ+0TyXfMJtWxP+S3NjTN3nasYa3nOHfpvo2u1NxEko/q2iIb9QEFjsvPdFiFP2hXmPKfxs1O2KDCUxRqVS56pf56l2gBQKys7ETDvq0LDPH37hYCiBcN4bIsavZ+8i5624i29itdjFTSRzEGd0pGRF1TXtf+fO3HK9q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R82HJ+kn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R82HJ+kn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC90D1F000FF;
	Thu, 17 Sep 2026 00:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789606526;
	bh=ew2MLBOZW3IEh1uLMR3gKDGMsv6SKgUQ51K3T6xXMeA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=R82HJ+knl4UkRr9zegF3CMUxmTVzVw3N8GfocrSbznSI7+oRqPrqGS6A1XTjOHA3t
	 ZIEjURpCkgVyT50Y8a3bk3Pk4MGvbHigs+ioQDT891G4LmigbJ8fi2xwdpdklU4QCc
	 b7HgjEAg9FHGjt6CZLFoNs4JhDFbLeuNWDeyGFRKVe/tNzfzvUDh52kpXPgyICTUP+
	 5Kgf8A0o25xQjAxcTdwjTNX5jIbsf6PxSE8aFZREvXIW5NzbXObPoZDSq0OEe5TTaR
	 Hd5Ss/Q52q0kO0tNzfqlLifgWWOG551UWt9GpugPt11CYbTIV60sHiJGyssUiy2tkc
	 81cp1u2qx/3XQ==
Date: Thu, 17 Sep 2026 01:55:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Ariana Lazar <ariana.lazar@microchip.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, sashiko-bot@kernel.org, stable@vger.kernel.org,
 Joshua Crofts <joshua.crofts1@gmail.com>
Subject: Re: [PATCH v6 00/11] Refactor Microchip MCP47FEB02 I2C driver in
 separate modules to add support for MCP48FEB02 SPI driver
Message-ID: <20260917015520.55c3ada9@jic23-hlaptop>
In-Reply-To: <aqq1Dxeu7njVPI6R@ashevche-desk.local>
References: <20260916-mcp47feb02_refactor-v6-0-285464651f89@microchip.com>
	<aqq1Dxeu7njVPI6R@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 18:26:07 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Sep 16, 2026 at 05:16:26PM +0300, Ariana Lazar wrote:
> > Refactor I2C driver implementation into separate modules in order to add
> > support for SPI MCP48FxBy1/2/4/8 DAC family on top of the I2C
> > implementation. The I2C and SPI devices have the same memory map and
> > supported functionalities.
> > 
> > Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
> > ---
> > Changes in v6:
> > - use field_get() in Gain, Vref and Power-Down registers channel formulas
> > - rebase from 7.2 to 7.3-rc1
> > - add fixes tags and Cc stable in the commit messages
> > - add numeric constants in front of time defines for better readability
> > - replaced dev_err() with dev_warn_probe() for missing label
> > - if match data is not found at probe, return -ENODATA and a suitable
> >     error message
> > - Link to v5: https://lore.kernel.org/r/20260909-mcp47feb02_refactor-v5-0-8b67bcab93d1@microchip.com  
> 
> My main comment against this version is the usage of Reported-by + Closes +
> Fixes versus Suggested-by. Note, some of the changes doesn't look like a fix,
> such as a typo in the comment, I dunno if Reported + Closes (no Fixes) is
> legitimate approach there.
> 

Other than that one minor thing I raised around field_prep() I think only
need to sort out those tags.  Given that it is probably near to merge,
feel free to send a v7 a little quicker than normal. 

Jonathan

