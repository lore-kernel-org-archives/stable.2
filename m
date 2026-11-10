Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794300860;
	b=iaZiJx99ltdixwx8mPGGfLSWOGnwmZheNPXc5Ddc/iXhVEM3gFZnHFky2qu2D3+Pi70+
	 aRNZ3njGEzqeQrCWuonT1LveIWwrHiBbpkeOY5tJP747ic0JCvDVCP/wzfznKEx2H2gtx
	 y5USfdJ67kWXur9DujnU7gnYVYhksYSQQ43t753ixr3a3r70b/XQGuutx4rLSsK8LkV61
	 VuZussz3RN4IdGvIWKEaNNuu8Grw3LE5Ch3memZ+3pXWc6AiRkevkw2KMuohor+TF1wO0
	 zYhpMs9WExWJPK5wKiS/C2JJEgH830cmDK6K0CPPz+FkcZL/A2lcrM1yyMQk3RYYAaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794300860;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ggNk5U9ggfmA3f998rJ3qvt5tEr1LMQJ1Vt5cQlunjk=;
	b=UH34kIWFwaz41vlW5qwx8dANbzCoFvrdmIs7apMM4PjlkkYbYwqy+pDKf2+BkqnpVK+/
	 fGtrmK+OO20Hdodb+FmZeNWu0Xj3ZvT1OKc3h+C8HVBpyqUQlUVTSuYjJve0cHr9Tm7t0
	 pXUurt68T/sMhJd+upTR0ilv8gfNG4k92thhcfEAboiIRVJ1Q8oDbq8b6ENuNZMQaPLq5
	 8Jvcl99spiGKdhZ4lnabUQX0J+dR/qejr1MFXaphlzUCynlGJCACj+5KpVv0uypAaxL9M
	 h0jsSvZXF6OFHzho38iIxi2gjHEYaf89/gArphpAE4Hq90ZN2PiY2RJBs+iREG6rVvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FGLPB3eP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 57870606A31C;
	Tue, 10 Nov 2026 08:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FGLPB3eP
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B38F21F0089F;
	Tue, 10 Nov 2026 08:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794300859;
	bh=ggNk5U9ggfmA3f998rJ3qvt5tEr1LMQJ1Vt5cQlunjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FGLPB3ePZ5J3tTWm+3ArMy/T20VTut0oj/NYSEZwJm0RoBXcknY9aKiNcYwkx6KUw
	 eM2YT0yUEhLILXHkZIo9KqVD4P9uFS1GvOxsA+fz5ByeNW30o3dAU7Zbi9pifE7j6K
	 0kYTyAkE2KKbRU61stIsWaoVM3WF3CojI48VgwB15/70c/nIkuY1LDCjrFwyTrE3/D
	 SUR7w/slvklK5dxm0LaUl9XVQG3G3ctw4PBaZWvumMG6PmEOfdJfVXJtnymg+bewX5
	 L4C6Ck/vFC2rzwZu1Cq5hTLF1YXBJepDsII8kLkuud8oRmuJmHSJt1WF962C9Kc/j7
	 U4KH+Dd0aZ1Zg==
Date: Tue, 10 Nov 2026 09:54:11 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Linus Walleij <linusw@kernel.org>, Kent Gibson <warthog618@gmail.com>, 
	Adrian Ambrozewicz <aambrozewicz@nvidia.com>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2 4/5] gpiolib: don't overwrite the entire flags field
 in gpiod_free_commit()
Message-ID: <gw26q2blrbmmxwzv7vfjxwc5bzqzfgt57zs7bvt2kdx7x6a6qk@6i5z3a3crqft>
References: <20261109-gpio-desc-flags-atomic-v2-0-c4c54b476628@oss.qualcomm.com>
 <20261109-gpio-desc-flags-atomic-v2-4-c4c54b476628@oss.qualcomm.com>
 <avJAv_3ACjvyc9VU@ashevche-desk.local>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avJAv_3ACjvyc9VU@ashevche-desk.local>

On Mon, Nov 09, 2026 at 11:53:03PM +0200, Andy Shevchenko wrote:
> On Mon, Nov 09, 2026 at 11:27:08AM +0100, Bartosz Golaszewski wrote:
> > Use gpiod_update_flags() to clear all request-related flags in one go
> > instead of risking racing with concurrent users and overwriting any
> > changes they could have done between READ_ONCE() and WRITE_ONCE().
> 
> ...
> 
> >  #include <linux/acpi.h>
> >  #include <linux/array_size.h>
> >  #include <linux/bitmap.h>
> > +#include <linux/bitops.h>
> >  #include <linux/cleanup.h>
> >  #include <linux/compat.h>
> >  #include <linux/debugfs.h>
> 
> No need, bitmap API implies all bitops.
>

I honestly have no idea what the policy is on "proxy" headers. In some
cases people advise against them, in others they say to include them.

Is this documented anywhere?

> > +		set_mask_bits(&desc->flags,
> > +				   BIT(GPIOD_FLAG_ACTIVE_LOW) |
> > +				   BIT(GPIOD_FLAG_REQUESTED) |
> > +				   BIT(GPIOD_FLAG_OPEN_DRAIN) |
> > +				   BIT(GPIOD_FLAG_OPEN_SOURCE) |
> > +				   BIT(GPIOD_FLAG_PULL_UP) |
> > +				   BIT(GPIOD_FLAG_PULL_DOWN) |
> > +				   BIT(GPIOD_FLAG_BIAS_DISABLE) |
> > +				   BIT(GPIOD_FLAG_EDGE_RISING) |
> > +				   BIT(GPIOD_FLAG_EDGE_FALLING) |
> > +				   BIT(GPIOD_FLAG_EVENT_CLOCK_REALTIME) |
> > +				   BIT(GPIOD_FLAG_EVENT_CLOCK_HTE) |
> > +				   BIT(GPIOD_FLAG_IS_HOGGED), 0);
> 
> Indentation is broken (and it has spaces, which makes me totally confused what
> the point of those spaces in the first place?).
>

Yep, and sashiko has some nits too. I'll need a v3.

Bart
