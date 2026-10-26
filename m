Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793035895;
	b=JA7KziOMqKNMWwRwhJbvcUiSuNnpidpgfVEMRFjNegjc/afmfSEAKvDX6Zf+KogjPfPd
	 NEXFS58jWX4ZTBW1Fjh07duDUlkjggWz4r8UuG04MNDAVaUFkee4WngISC5TT/3K/xHTT
	 RpofNSEbpZRXsJR5DNeKlpfW61B+bNt9XA95TEsvlygWfTDQ0cmsClfpte89GrzvESy1d
	 JN6u8wIzSBvkpObYk27Oxm9j3dOmEqAEWz724Bc9mhN3sQXTHyW/fw2VXV48VZQskyRf9
	 vjZHqep9e4XhE47HV6W5clUf4EM4dafEJFyxvQjh1MnZt1REQ9pn12T/f3ML4J8fRoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793035895;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=mjT/jJuFM6XBK5jXoyA5s/eNOp2DUiiIPlqtvzyid0Q=;
	b=RLiURNujKWWu5f6O+BLwzKCEUeq3HJVsjcQMjHIG4oBIRFmHlkGd/yRtdfU7Fjvd/PuW
	 zggPXYv1ntlY2YRie0NqwKJ1mQHJxIQCBvR+mHyVvURNkU9CkNasN5HlaS5POgU9/Fd9i
	 eSzaaiE4K4g6kOYKt7OKP9L5rNCl+JEWA4rGesHlhC0ysKaeHF3R651ILxueIYQe7hAgo
	 vl/FD+3Wrw0gx3Vk5Fc0/YBnKB+qU2IVQrNPUbAeo0AujmF1oh5xHKCS4wr1txx8io8vd
	 R9zlxYu2+gF1XS69WS6w2Zg59ea2gTt+1WIyRACNYCXnhbOEEQ356RhmYYnB7PMfkjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GL8Z2bVj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2763606A31A;
	Mon, 26 Oct 2026 17:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GL8Z2bVj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778061F01825;
	Mon, 26 Oct 2026 17:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793035894;
	bh=mjT/jJuFM6XBK5jXoyA5s/eNOp2DUiiIPlqtvzyid0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GL8Z2bVjh1iQjwgmKrgs50oO9s/5XVCtHvyU0etT5FZlYyrrdGOZ1Ms+v9BInuK2a
	 N+yISQv/k95xO8+gyX8HkagUvYUwNKWFtOZfYTTqv2aarHNF3JRhG+aIIKN6SNbc8U
	 G4KnxxoYktMtSpcrLGtTYAatssL+utymuiMUVMvMlS/MSCmDTbHyXsD97pmIy80y9k
	 B3IUjO7egnN9ohbnePwNQvqcdStVVM1HGuVWPQLDnXnWhRFDTYyk4mWRNxRX/GDaVE
	 OtmXq/lOhBkKxy9YnyqQuViw99n9XbTQzRf4f9kvYcajAQNWqXi+z8FB0n1Zx63zBB
	 2HRlp86THJUqQ==
Date: Mon, 26 Oct 2026 17:31:29 +0000
From: Lee Jones <lee@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Pavel Machek <pavel@kernel.org>, Dmitry Antipov <dmantipov@yandex.ru>,
	Jacek Anaszewski <j.anaszewski@samsung.com>,
	Bryan Wu <cooloney@gmail.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 14/21] leds: flash: Avoid divide-by-zero in
 led_clamp_align()
Message-ID: <20261026173129.GF2195460@google.com>
References: <20261021123406.3163547-1-lee@kernel.org>
 <20261021123406.3163547-15-lee@kernel.org>
 <20261022220006.6e066670@pumpkin>
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
In-Reply-To: <20261022220006.6e066670@pumpkin>

On Thu, 22 Oct 2026, David Laight wrote:

> On Wed, 21 Oct 2026 12:32:23 +0000
> Lee Jones <lee@kernel.org> wrote:
> 
> > If a flash LED driver leaves a setting's step size as zero, writing to
> > the corresponding sysfs attribute invokes led_clamp_align() and triggers
> > an integer division by zero when aligning the offset to s->step.
> > 
> > Clamp s->val to [s->min, s->max] and return early when s->step is zero.
> > 
> > Fixes: 7aea8389a77a ("leds: Add LED Flash class extension to the LED subsystem")
> > Closes: https://sashiko.dev/#/bug/linux-9d06d7fe-310b-4aee-8b16-0fb49550c287
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lee Jones <lee@kernel.org>
> > ---
> >  drivers/leds/led-class-flash.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/leds/led-class-flash.c b/drivers/leds/led-class-flash.c
> > index 181dfd49c6ad..16b3b6b9365b 100644
> > --- a/drivers/leds/led-class-flash.c
> > +++ b/drivers/leds/led-class-flash.c
> > @@ -375,6 +375,11 @@ static void led_clamp_align(struct led_flash_setting *s)
> >  {
> >  	u32 v, offset;
> >  
> > +	if (!s->step) {
> > +		s->val = clamp(s->val, s->min, s->max);
> > +		return;
> > +	}
> 
> Why not just:
> 	u32 step = s->step ?: 1;
> and then use step instead of s->step.

I can see where you're coming from, but I don't think this is better.

With `step = 1`, the reader has to mentally trace `1 / 2 == 0` and `1 *
(offset / 1) == offset` to see that it reduces to a plain clamp and the
CPU still executes a redundant integer division.

IMHO, simple, easy-to-read, maintainable code wins out over clever code.

> > +
> >  	v = s->val + s->step / 2;
> >  	v = clamp(v, s->min, s->max);
> >  	offset = v - s->min;
> 

-- 
Lee Jones
