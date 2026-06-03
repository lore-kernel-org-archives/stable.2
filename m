Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F83329E6C;
	Wed,  3 Jun 2026 13:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780494380; cv=none; b=KFiLYpQ2mqqPcoDjlohI7rOJONVjH6vnWNqkB02fFQq1YEkA1RX2FPl6pkQqwiO9Rd9AqduKHKqGDRdXhFq+7IBzoThhyuWYwDPbCwBHDs7k08hGonEaotecQ3i5oD9LfU3V8PEP4juL53mjpFHtxL0GQ7BTN1d7VGgduPe7jb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780494380; c=relaxed/simple;
	bh=YFNAqFDxk/MEMEUnwOMbFmzvs+j1ZkGZaJGTjzFOkMw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q9Fe2pnxhV7dj7njZ9Mzj3X9ngZGXMo+0NPBUb1o7nizmz+O2VmDNA3WFclleUdRlUsLRezq2ZZxIDDhcjvsQq1R6ziitF2NcKAKvWgeJ8/1yRQqsRz3c+3yu1J7mkkOVC8if9VWxTT6REXYGtI3H6jkDfKgYUMchC8NmGKLxt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3lpzVzN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3lpzVzN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92741F00893;
	Wed,  3 Jun 2026 13:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780494379;
	bh=SM1cKq9SfWufKuIA+3YVCEbGbuxmG5CEwN2ohUYgVxI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=X3lpzVzNsmzUvBWgrJY/p4bH8g7VDsT822kjq9ZTydis6zw7/CngVyU7LjFVwcqVp
	 PEuYKLUGDIRYvv/9CdXuFr+/WK+OPzpdDRSAENljYuFyvoTpyyHiFzmexKqJvSvlSL
	 iAyp3Pu6EJZhVkSMowL5zHx8L3AKv8HL3Zys4IVIGtV5axAC0EXnNNqfaXLXUcG2N6
	 Neh+iezmCtZmXO+5sIQLR3/K/rkoxTi/JFVHEdANmw15bE2mOgeVIYj2zQLQg5v7Xv
	 Wwl2ZMeN/qHLyQbPp74H6ZAZUxdXdv+S5qQjPXop4bC3FZrEMH1x/d44Ae3uQo0OvH
	 bvrwIEVjAmhgw==
Date: Wed, 3 Jun 2026 14:46:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>, nuno.sa@analog.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, andy@kernel.org,
 benato.denis96@gmail.com, martin@martingkelly.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 jianhao.xu@seu.edu.cn, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: imu: adis: add IRQF_NO_THREAD to non-FIFO
 trigger IRQ
Message-ID: <20260603144612.0102a336@jic23-huawei>
In-Reply-To: <ah997ABzoOb0cFq3@ashevche-desk.local>
References: <20260602091727.2406720-1-runyu.xiao@seu.edu.cn>
	<20260602091727.2406720-2-runyu.xiao@seu.edu.cn>
	<ah997ABzoOb0cFq3@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jun 2026 04:05:48 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Jun 02, 2026 at 05:17:26PM +0800, Runyu Xiao wrote:
> > devm_adis_probe_trigger() registers iio_trigger_generic_data_rdy_poll()
> > through devm_request_irq() on the non-FIFO path, but it does not add
> > IRQF_NO_THREAD to the IRQ flags.
> > 
> > When the kernel is booted with forced IRQ threading, the parent IRQ can
> > otherwise be threaded by the IRQ core and the subsequent IIO trigger
> > child IRQ is then dispatched from irq/... thread context instead of
> > hardirq context. Because iio_trigger_generic_data_rdy_poll()
> > immediately drives iio_trigger_poll(), this violates the hardirq-only
> > IIO trigger helper contract and can push downstream trigger consumers
> > through the wrong execution context.
> > 
> > Add IRQF_NO_THREAD on top of the existing adis->irq_flag value for the
> > non-FIFO request_irq() path, while preserving the current trigger
> > polarity and IRQF_NO_AUTOEN behavior.  
> 
> > Build-tested by compiling adis_trigger.o.
> > 
> > No ADIS hardware was available for end-to-end runtime testing on this
> > submission branch.  
> 
> These two paragraphs are unneeded details and can go to the cover letter.
> 
> ...
> 
> Code wise IIRC another approach was discussed. But Jonathan may know better.
> 

Whilst I dislike the necessity of marking these, I'm not aware of another
solution.  Maybe the discussion Andy refers to what the one around
papering over ONESHOT where if that flag is set and there isn't a thread
handler it's a driver bug.

For this we might be able to on day do something cleverer but that would
first mean fixing up how we run top halfs when only the thread is called.

So with a patch descriptions tweaked as Andy suggests I'll pick these up.
