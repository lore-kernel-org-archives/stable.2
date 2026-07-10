Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7E31096F;
	Fri, 10 Jul 2026 00:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783641860; cv=none; b=FMauzriOFM9kOAy/zJa6V2nkGMTp2BNz1WmWxrSGALe59mnYH1zlRxx1EONIwJc/o7JeM8+Seepve+bHD53imCInjzkZIWQKekwBlIvMei1ucyiXqGcrD+j3VlqShaYD7qwORle/05gj3E9sEvt/8jY0aiLWOz0srGr6Z17ty9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783641860; c=relaxed/simple;
	bh=6Us6evyqhVWSYqkGzpiAJLVf8D8JpPqm4dHTKkaccgE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kliJvEUCgsCG7Asd5luNZDnyYdY3jXHsh8YR3r800888Zt98QXllO+7YxEBVBG0TTZTgqkVPSkH9HPEXECjQjGkG1H4tMsIoK6pZJY/aVO21tK9bpflO3S78uP/UrjabVEosbwE/G3KLSd3Y/EeyZ2GlPishMUOBqdUtvJDPn2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVE/hao4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVE/hao4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7941C1F000E9;
	Fri, 10 Jul 2026 00:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783641858;
	bh=9ZewEz0IcUZar/HUtGfdbNhv8GOBVgrsd6pKqFz0T84=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lVE/hao4K1jJePLJOsDs71Mm0A6S9gDXYr3cfVfz2pPy0JMXXunghKiYt+ixej/UD
	 /t4naVyKRNuDdYnZvIHIyHe7JbDfKKq6OE/TESOVY7xaCDNErgj7v9XNNNFgHBfPFy
	 5LOY/qkmEYzdcua65TCa9/mk1+MGkVuJAzYZoX/HpTKzhgSGJISaYgZycvUgKD3D26
	 /prbeGgCB3AQA/9UBe0fACcYQWuRW0UOi4b1v3wsqlesRpFyWfBP+zG3G88EXfZgXZ
	 ZRaWALNmdA8r7Lxu+jiJFo6+I35WSXwq7Qbr/P13Hlh1VMK5rN3qIEURN1xaxMM4Vb
	 aKhoWPrNxXzyA==
Date: Fri, 10 Jul 2026 01:04:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Stefan Popa <stefan.popa@analog.com>, Julien
 Stephan <jstephan@baylibre.com>, Ivan Mikhaylov <fr0st61te@gmail.com>,
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>, Marilene Andrade Garcia
 <marilene.agarcia@gmail.com>, Kim Seer Paller <kimseer.paller@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 0/3] iio: adc: add missing 'select REGMAP' to Kconfig
Message-ID: <20260710010412.5692d626@jic23-huawei>
In-Reply-To: <ak4so4KAztmqaUgk@ashevche-desk.local>
References: <20260708-add-missing-regmap-v1-0-6d424322e3d4@gmail.com>
	<ak4so4KAztmqaUgk@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 Jul 2026 13:55:31 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Jul 08, 2026 at 07:34:11AM +0200, Joshua Crofts wrote:
> > This series adds missing `select REGMAP` and `select REGMAP_I2C` to the
> > AD7380/MAX34408/MAX14001 Kconfig entries. Without these, some builds
> > may result in a failure.
> > 
> > Steps to reproduce build failure:
> > 1. Run `make allnoconfig`.
> > 2. Run `make menuconfig` and select I2C/SPI, IIO and any of said drivers.
> > 3. Run `make .` and make will end with regmap-related errors.  
> 
> Taking into account the real build failures as pointed in the replies,
> the fixes LGTM,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
Applied patches 2 and 3 to the fixes-togreg branch of iio.git.

Thanks,

Jonathan


