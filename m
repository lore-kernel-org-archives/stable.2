Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDEE19049B;
	Sun, 13 Sep 2026 21:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789336682; cv=none; b=FY/FevdIDGs9XOaK56qUCU8Bgc2DU52u+N6eXreiHjCoQ47iTNtxDeiw9JqL6XYVqy+oEub+NetlCykcUKNTyfPSKHa7r3j+UigETRG2xojnN0cBW4TDWilizmhecjyYnVML8hX4DtmezXSR8b64UKC2PkkxWm+kWa8Xeaa5ckY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789336682; c=relaxed/simple;
	bh=QpwBlJhTECD9ZC1qVkRgG5+z8OD+fwSwbL6opAXeXj8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OFKNIzgvHDmfQKOw7dNKxsU4b/EXdn4X6Ud4ynSswn7rrHt129vM5yBtLhZC01x8IBn2MqNNn981g73n4eQ4S4zGY5psDQJZzb711CltyquB/m7Brf8GLpP5HFqsujDS3HXm1lFv9Hz+szU16joF6myB8s0TgFXbaI37RuU40Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqcRc8kd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqcRc8kd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D361F000FF;
	Sun, 13 Sep 2026 21:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789336681;
	bh=HLlNiJzlDXkQ2SZXU3tFf+X3xoH8F5gK/oZBldA+BJ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nqcRc8kdMNcz8jKrbOMg9w2qyzTwXV7SC4uVvZFgX0XP8pSm0674TceKLVHRx2AP/
	 JlNBwuGEkM0eWnOG7wjuOXxvmE1f3GpVzdpzRMPaRJRN/fcZtVHIjd6hX1i0OQb9GS
	 xTsB7Cns8aQgibJNbDVlFIlJOMgpAbIDDj28wHxgcJowiJB9CRst6AH7r/GXuMl1We
	 sYUY2JpU7z/aZPstlgau5U8ZY8Vuj3aUk/bG+Vmet2cyL3ZBAhFr1v3fnEN69M5Rav
	 XF8jaRV941WrrnWZwIqPtTrRysuiSgTcW+/iV5Ik59/ms26kqLMDdDGmwGRKW6s1G5
	 K/ILLepY6JywA==
Date: Sun, 13 Sep 2026 22:57:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, Kim Seer Paller
 <kimseer.paller@analog.com>, Marilene Andrade Garcia
 <marilene.agarcia@gmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: max14001: add missing MODULE_DEVICE_TABLE
 macro
Message-ID: <20260913225759.7627fc92@jic23-hlaptop>
In-Reply-To: <aqFnvoGj1ZNEUlUw@ashevche-desk.local>
References: <20260909130304.1395-1-joshua.crofts1@gmail.com>
	<aqFhagdhM4Z57eqh@ashevche-desk.local>
	<20260909154526.00002640@gmail.com>
	<aqFnvoGj1ZNEUlUw@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Sep 2026 17:05:50 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Sep 09, 2026 at 03:45:26PM +0200, Joshua Crofts wrote:
> > On Wed, 9 Sep 2026 16:38:50 +0300
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> >   
> > > On Wed, Sep 09, 2026 at 01:03:04PM +0000, Joshua Crofts wrote:  
> > > > The MAX14001 has an SPI ID table, but does not export it with the
> > > > MODULE_DEVICE_TABLE(spi, ...) macro. Because of this, SPI-based module
> > > > autoloading fails on systems that don't use devicetree (e.g. via
> > > > spi_board_info).
> > > > 
> > > > Add the missing macro to export the alias information.
> > > > 
> > > > Fixes: 59795109fa67 ("iio: adc: max14001: New driver")
> > > > Cc: <stable@vger.kernel.org>
> > > > Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> > > > ---    
> > > 
> > > Changelog?  
> > 
> > God, I should start using AI to check my patches before sending.
> > Appending below.
> > 
> > Changes in v2:
> > - edit commit message (expand on module autoloading and SPI)  
> 
> Thanks.
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 

Applied to the testing branch of iio.git. Not rushing this
in as for dt at least the other MODULE_DEVICE Table probably
does the job (or the driver name fallback).

So nice to have rather than urgent

thanks,

Jonathan

