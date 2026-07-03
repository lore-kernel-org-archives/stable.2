Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5E22C0F8C;
	Fri,  3 Jul 2026 19:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783105816; cv=none; b=n4+2LbbOZhzxuLdrEFNIu87SJLHCbDYSqaqoFcoI/2vCrC+ROeA0o7eBqeFqGNlo3Htk2tQtnouwzWZEiVGshwF4Wynqr6984djGwcZ0Cyq3NZC/0k1LnVOYHmcQwvkf5Cp5W/hRjpU8SAC+B8te5ykeCiocrGlIP/k+pTNG3EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783105816; c=relaxed/simple;
	bh=DF6xSAfyotD0N4Tz08NYeXqgEusoeoCZsDHG/oMcw4k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bn5e2EkjZTOjfn+qgKnzyMG/em5+2+aazQKP9drb0hBWgA/XhNc3ZwesgEGZiajx0XG09h92ohisyTOeGEB+9K0GJK8CystwXlMHFp7svB8pleuNureCyflBgsY10jujxuQzgGCrTDlFAu38OUIV0U/aqu0NCKYKaiqAL2Xy8qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vqd0EeCL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vqd0EeCL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40DD1F000E9;
	Fri,  3 Jul 2026 19:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783105815;
	bh=q47bqK917XVa4fbWBKvXnG7aNu6rcDrNfatTcJkAkZM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Vqd0EeCLVDvEv3gZU9oQgu2Jc71QFkR9Kkf7XvkYEqbpzi7Wdf3TxlRq6irwhv87c
	 sz+f68OhWOu8zC5MBdBuGy2xxUzx3dk1TkBPlPWDKRSGCrC0p788/j6clQdNmlYK9o
	 tm/7WGwQaoOFNswKtgWhEFupuU0FxwqspfxYVXF+36/N8OiHYCMtAL4QZcx9XIkqut
	 PiGa5GGe0cE1Gsl/ipHIHd+Rau2Ca9NZzRB68LiIoQWxnxU8vaaXuGg1VymKcXiS8q
	 XVNp+f2IugXhFFUR3giWNvGX07gbwQZWs7pwcLzSaC+/ZqzsNGAZowUXrApEtY8mo3
	 QUvRMIs9YTNdA==
Date: Fri, 3 Jul 2026 20:10:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Stepan Ionichev <sozdayvek@gmail.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, hcazarim@yahoo.com,
 joshua.crofts1@gmail.com, gregkh@linuxfoundation.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: light: tsl2591: return actual error from probe
 IRQ failure
Message-ID: <20260703201011.31bfbd84@jic23-huawei>
In-Reply-To: <aiEoilRNQuHR_dqb@ashevche-desk.local>
References: <20260517181042.668-1-sozdayvek@gmail.com>
	<20260518094311.2000-1-sozdayvek@gmail.com>
	<20260518163647.3b4966fb@jic23-huawei>
	<20260518164309.04ed238f@jic23-huawei>
	<20260603182345.5fdb66b5@jic23-huawei>
	<aiEoULtZmGpDd3cy@ashevche-desk.local>
	<aiEoilRNQuHR_dqb@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jun 2026 10:26:02 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Jun 04, 2026 at 10:25:09AM +0300, Andy Shevchenko wrote:
> > On Wed, Jun 03, 2026 at 06:23:45PM +0100, Jonathan Cameron wrote:  
> > > On Mon, 18 May 2026 16:43:09 +0100
> > > Jonathan Cameron <jic23@kernel.org> wrote:  
> > > > On Mon, 18 May 2026 16:40:48 +0100
> > > > Jonathan Cameron <jic23@kernel.org> wrote:  
> 
> ...
> 
> > > > https://sashiko.dev/#/patchset/20260518094311.2000-1-sozdayvek%40gmail.com
> > > > 
> > > > Does completely removing dev_err_probe() here drop the deferred probe reason
> > > > tracking?
> > > > While this patch successfully fixes the return code, dev_err_probe() also
> > > > records the deferral reason in debugfs via device_set_deferred_probe_reason()
> > > > when ret is -EPROBE_DEFER.
> > > > Could we keep the diagnostic tracking by returning the result of
> > > > dev_err_probe() directly instead?
> > > >         if (ret)
> > > >                 return dev_err_probe(&client->dev, ret, "IRQ request error\n");
> > > > 
> > > > Andy, what do you think?  
> > > Andy?
> > > 
> > > This is a change you might have asked for, but sashiko is correctly noting
> > > that we might loose a deferred reason even if the print is otherwise useless.  
> > 
> > Incorrectly. IRQ core prints an error via dev_err_probe(). Did I miss something?  
> 
> I'm referring to implementation of devm_request_result() in kernel/irq/devres.c.
> 
Oops. I almost lost this one. Patchwork had my back though.

Applied.

Jonathan

