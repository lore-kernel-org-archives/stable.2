Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792972078;
	b=tNfcLD0Uzdde9R8nR/ObiqteJYKMoJ6fWi7+lk2AjMfQXdk7Az16rsCArhfJDjGpLa5I
	 zPrVW/JVYHw2LALqMp94NkiuEncFBexZbishzyNnN0ZZf+reAJ3xzlNCen7vEWqrIiBKo
	 Q5bNZ6on77XgInZJvrqD402FiCrt6YbRg0fDzrLPfwqBqJH5FUda8jdIfHTVcFiAwwXk0
	 tY51P2RS1Oh29ZImTtLYDpfSHXZ5OH0RbJqcQDCcwxx4RWRLUU9kXsHdbadW/MrGh0bts
	 rd9aLCJZWDKKPqlmNfj1B0I4zxkezewUo1O5nHcEooXHREgJSy778hK2IT40XDChgMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792972078;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=YRzMgodGFzIBBq+9796zrLdbYjk1ni9Pt8Zo5ySPvGA=;
	b=zG5Fug2GTjwa3nGRrMu9lFjFJPRiI1GhDkCGi8hNQqmsa0WYPWTfcm4wJVrQRyXes3Bc
	 XVh+96svqtg1Kg1fOS/925HO3T2RmgN0JV6aqQGIdqC6+U+ybTrBk21r0NDq0OfNr2pkN
	 JgHqdSsQJXUXWI3viLwN6yPFbOj0uajurkXTbyqWfimW1uAjg3qygg2m62/vsILoxoACG
	 28ZsMwyFZhhjHsPt8Frcpdvjn83jV2m2nC9F/6ifwkbo/B9+z9tLZI7vT5YLYmSdv/dHq
	 oHUqzHJknvIG/O9dNKCfhxujImhgzJ/o0u6QJUjP+M1VXHfm3F4GqD7Bz4p333cVEDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n8jxXxhr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30007606A31D;
	Sun, 25 Oct 2026 23:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n8jxXxhr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460051F01825;
	Sun, 25 Oct 2026 23:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792972077;
	bh=YRzMgodGFzIBBq+9796zrLdbYjk1ni9Pt8Zo5ySPvGA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=n8jxXxhrP8iCZuknRC/B2gvVZdRoEI3wL/ZPgor/BrkkT5RtB8dR5noFAFVtoSLlY
	 rwlB49YsSDpwzGMCaBW0KmdlQ0IqlLuogg4hZuJEJvO+ViRrNB7DIvK6/YkUzObOdl
	 XNLtR0YEwOmh/3nwIDfaK5oaMK6PLtrXEY2zeDJNeNZplLUExMMHvAGXUJb2HRkWXP
	 X64wjEW/40y0XqAHoAgBNg7usJLOouK9fdh/1wEETvnmwNbtorlBqPW8xgnNGoqQGJ
	 dSUFctk+fZzUIT2ADcFcWuWnq7Xo8Uvug+OiREVrt5+4vRISYo/kCm4Z4qPr4fSkb4
	 mZQa24YZkG3rQ==
Date: Sun, 25 Oct 2026 23:47:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Arnav Kapoor <kapoorarnav43@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, stable@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: proximity: sx9324: fix out-of-bounds read of
 scan period table
Message-ID: <20261025234750.5b26c0bd@jic23-hlaptop>
In-Reply-To: <atyMCCJsBDPdgl2Q@ashevche-desk.local>
References: <20261023192700.221344-1-kapoorarnav43@gmail.com>
	<atyMCCJsBDPdgl2Q@ashevche-desk.local>
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

On Sat, 24 Oct 2026 13:44:24 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sat, Oct 24, 2026 at 12:56:51AM +0530, Arnav Kapoor wrote:
> > The scan period of the SX9324 is selected by the 5 bit wide
> > SX9324_REG_GNRL_CTRL0_SCANPERIOD field, so it has 32 possible values.
> > sx9324_scan_period_table[] however only has 16 entries, it was copied
> > over from the SX9310 driver where the field is only 4 bits wide.
> > 
> > sx9324_wait_for_sample() indexes the table with the raw field value, so
> > all the codes from 16 to 31 read past the end of the array. The default
> > value of the register is SX9324_REG_GNRL_CTRL0_SCANPERIOD_100MS (0x16,
> > i.e. 22), so the out-of-bounds read happens with the default
> > configuration of the device. It is only avoided when the device has an
> > interrupt line, as the wait is only done in the polling case.
> > 
> > The value read is then used as the duration of an msleep() call, so the
> > sensor is polled with a completely random delay.
> > 
> > Fill the table with the scan periods of all 32 codes, which are the
> > periods documented for the corresponding sx9324_samp_freq_table[]
> > entries, and add a static assertion to keep both tables in sync.  
> 
> ...
> 
> > +/*
> > + * The scan period of the SX9324 is selected by the 5 bit wide  
> 
> 5-bit
> 
> > + * SX9324_REG_GNRL_CTRL0_SCANPERIOD field. The values below are the scan
> > + * periods in ms of the corresponding sx9324_samp_freq_table[] entries.
> > + */
> >  static const unsigned int sx9324_scan_period_table[] = {
> > -	2,   15,  30,  45,   60,   90,	 120,  200,
> > -	400, 600, 800, 1000, 2000, 3000, 4000, 5000,
> > +	1, 2, 4, 6, 8, 10, 14, 18,			/* 0x00 - 0x07 */
> > +	22, 26, 30, 34, 38, 42, 46, 50,			/* 0x08 - 0x0f */
> > +	56, 62, 68, 74, 80, 90, 100, 200,		/* 0x10 - 0x17 */
> > +	300, 400, 600, 800, 1000, 2000, 3000, 4000,	/* 0x18 - 0x1f */
> >  };  
> 
> Haven't checked if this is part of any ABI. Otherwise LGTM,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
Tweaked and tagged.

Thanks,
