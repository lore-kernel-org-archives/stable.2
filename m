Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794700406;
	b=tNeedzhkciGnyL/+Y6QQ9iT7eEeQ1fZ86Ti0xwiyn349GQ7wAn5L9fykPp1PUH0DSUVB
	 3F5pkYVPSGBJH8rIKPtEdioWoFsBKKkSYI1oaRy7LT6dTxeGspUtIDnMz3tRcP9nRJ4+c
	 S8D6Df+d+ajvOdOQ6qjJb52owFK90DrYtJ5DdBBKIg+q1og/opqdEDIzUs3ad2UFlNfKw
	 BiPOF0aHRo3rdhsC1++QkOeGBnkYWCA+SZtLbnCae2U2MIavLkYf4Kl+im7ai2Xoecvv0
	 5TLtLBS43YK38eZxHM0XFjjC5FAVS5Gl82a/T7mywdRyy2Dq9xwtyQOv7e3r4DdOniw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794700406;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=BcS6lewsMsxh+yguDvKs5aIMaULOPSzvSJzYsHF8Bnc=;
	b=hp0Fx8djsOUHrephVS6v0b+nf/v5aKN0zjHAQ36uH+5ffSKcpsjkOjJ0C8bL1f0vQre2
	 rFt8ArChJkRPWcL6QI/R33GDVG2Ek21p4ZNkSnC8IkUsmS3qVcFDoH5p411BWBmXzknuY
	 6i90b3P4Ep0lvrUTRmLkXnwKu4c7fYm2/RGT0vp0MnRbymIGsliU86hlqprCE/opj7R3l
	 Dcc53Eqb1WPN9suh45t9RzQCdTnWPgQA+yvafHYaJowu8eOEL3Me7gFk0/MDbl100zWZI
	 G+Al94IereaYkxP1+ehOQgGN8BPQzCb3nY8GUm93ANHiUYCT2vX4Ivtt+UbapGQVMnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dILB7IAA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8058606A323;
	Sat, 14 Nov 2026 23:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dILB7IAA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C9E1F000C4;
	Sat, 14 Nov 2026 23:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794700406;
	bh=BcS6lewsMsxh+yguDvKs5aIMaULOPSzvSJzYsHF8Bnc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dILB7IAA+jHokJuEtOTRXAu7Abug2vOjywOp31dAhe+jPVfO9JSkjfjni58mmxtX8
	 bukLfkWRH8prGRkPQFuBgfwRfIZ2M/dbVu9tb44SUUXu8LfSTUmlJuKEi2aGsqAmV0
	 xFc7Bdcpwq5g+B1LZiDjQaI2x/ZjoZNcAak/iKaFtmiWMKn6wduYngoxI10T73V0s4
	 TzjeWhfsJZDHm+wdK3Kicsejl07VlrDBm2tmFlFpkcfavlYG9qe0sTnvY10DHCfgEG
	 mI0aSk9PYv1RF7S/lXtvXX3nHBv0l5Yn9hA3I9bevFsSbm2O1h4CegCr6u156HARhv
	 +zFksWVgh+5iw==
Date: Sat, 14 Nov 2026 23:53:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-kernel@vger.kernel.org, Lorenzo Bianconi
 <lorenzo.bianconi83@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] iio: light: st_uvis25: notify the current trigger when
 done
Message-ID: <20261114235318.67c97636@jic23-hlaptop>
In-Reply-To: <20261109085523.0000513e@oss.qualcomm.com>
References: <20261109025454.1260519-1-jic23@kernel.org>
	<avGKjh7GOtE2tPGt@lore-desk>
	<20261109085523.0000513e@oss.qualcomm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Nov 2026 08:55:23 -0800
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> wrote:

> On Mon, 9 Nov 2026 09:55:42 +0100
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> 
> > > From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> > > 
> > > The trigger handler calls iio_trigger_notify_done() on the driver's own
> > > trigger rather than on the trigger that is currently in use by the
> > > device. The driver does not restrict which trigger may be used, so if
> > > another trigger, for example an hrtimer trigger, is selected then that
> > > trigger's use_count is never decremented and it stops firing after the
> > > first sample. The driver's own trigger use_count also underflows,
> > > preventing it from firing later.
> > > 
> > > Use iio_dev->trig instead.
> > > 
> > > Fixes: 3025c8688c1e ("iio: light: add support for UVIS25 sensor")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>    
> > 
> > Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>  
> 
> Given content is all still here, rather than resend immediately to fix
> the linux-iio mailing list address, I've just fixed it in this reply.
I decided to be a tiny bit naughty.  So picked this up directly from
lkml (Well I asked b4 to find it).

Thanks,

J
> 
> Thanks Lorenzo.
> 
> >   
> > > ---
> > > Another LLM found one as part of refactoring how all the code around
> > > triggers works.  Definitely the wrong trigger. There are lots
> > > that access the right trigger via the wrong path (shortly to be
> > > cleaned up), this one manages to get the wrong one in many cases!
> > > ---
> > >  drivers/iio/light/st_uvis25_core.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/iio/light/st_uvis25_core.c b/drivers/iio/light/st_uvis25_core.c
> > > index 94d5261b2663..5c63a68948d6 100644
> > > --- a/drivers/iio/light/st_uvis25_core.c
> > > +++ b/drivers/iio/light/st_uvis25_core.c
> > > @@ -248,7 +248,7 @@ static irqreturn_t st_uvis25_buffer_handler_thread(int irq, void *p)
> > >  				    iio_get_time_ns(iio_dev));
> > >  
> > >  out:
> > > -	iio_trigger_notify_done(hw->trig);
> > > +	iio_trigger_notify_done(iio_dev->trig);
> > >  
> > >  	return IRQ_HANDLED;
> > >  }
> > > -- 
> > > 2.56.0
> > >     
> >   
> 

