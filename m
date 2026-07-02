Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCA231F9A2;
	Thu,  2 Jul 2026 17:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783011953; cv=none; b=kBB1kRK6AeYu/SoyfeA5MuI2Ikefx/DVQD9+5zVHcB8PQ7Uf7IKLy06gxi6it5SnPsgW5KsAwpHP0yVIvFvsOMfEMxXg1VvZQUFY0URSWHLlpgGXRFubl/YGeS1ESiS4Oh2Xm2H6C32sKwV7zhxdJignW1sryL2H9SoKZSWQ+aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783011953; c=relaxed/simple;
	bh=vgEYiPDUAR8MFY8T/V7VkePhk2r4/Zam4XfDFzJai0E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uVtbilOPrXzHL8Ku4SSWgnn+Vu+/w/LgFLnA1dBwBaWj80kT5KOmeI8FrIgLyzBgvAlRhXd+sBH7zejBfC23hxfUu9VJFZp3hfQa+CapjXmGZBkehHjLJd1HVnSvOwwyt2flZ2K5c0Tujn7wfKjN7tOwNKHEGb4cVNUOzGJxYnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NlbbMCA0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NlbbMCA0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E6A1F000E9;
	Thu,  2 Jul 2026 17:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783011951;
	bh=3F7AKCX0pjnj4U4BTcSrfEj0YWHfY9FVXVpF3mkxY2M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NlbbMCA0hgGr/QPVK0aEl9MoqqkEfyj4VKKUKiP7WvzgO27SAGvnsxF4Z3/1JHtvR
	 +CTfn1ExbRB/7OyMk985NiAJlwaIS+T4NLA338mROmP1EsWMZ5wa/juxbHvN3dO/1R
	 CP6RpvmbazHNGCWUKvTwK0uTQ6Gmd7k5XJ6L4/DtfjmY83A4Xi1GAF9Wgn0iugNlGe
	 O/L5LlM2NWHypp+Lr1g+wZ/PKdJLKgM1dC3XhQdC6zRR7j9j7p1/iu2rW2+sf9q3qD
	 VbkEd1w4KhXl8RYuD0MxQJXHe24L2DG4Pk0YEe/D0C2K89W6bi72q8xutVZryOH830
	 gb4HqZgSm8Fug==
Date: Thu, 2 Jul 2026 18:05:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Jonathan Santos <Jonathan.Santos@analog.com>,
 Ramona Alexandra Nechita <ramona.nechita@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 0/2] iio: adc: add missing 'select IIO_TRIGGERED_BUFFER'
 to Kconfig entries
Message-ID: <20260702180545.680c5265@jic23-huawei>
In-Reply-To: <akZFTC6qVzLG5ton@ashevche-desk.local>
References: <20260701-add-adc-kconfig-deps-v1-0-b9708d74f426@gmail.com>
	<akZFTC6qVzLG5ton@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Jul 2026 14:02:36 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Jul 01, 2026 at 09:21:45PM +0200, Joshua Crofts wrote:
> > The AD4130 and AD7779 entries are missing 'select IIO_TRIGGERED_BUFFER'
> > entries, causing potential build failures.
> > 
> > Steps to reproduce:
> > 1. Run `make allnoconfig`
> > 2. Run `make menuconfig` and select any afformentioned driver and
> >    modules it depends on.
> > 3. Run `make .` and the build will fail due to missing triggered
> >    buffer definitions etc.  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> > I seem to have stumbled upon a lot of drivers which have incomplete
> > Kconfigs, expect more patch series per sensor type.  
> 
> 
> 
Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

