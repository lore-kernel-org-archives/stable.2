Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793039850;
	b=wLLmjmRPvYXRjzQ2QHKznhC6hqUuA+hzK/m8fsClp6gJAzDBizjvOtqHjq2saL1dhZtu
	 dT2b2SxV8kQJhHC9iqI4FccMwVYTArpnRJ50XJIyqPFXEWBe5SJjK9fza2SDshtn+s1li
	 y1mSl4QXUjjSEzzNRo+ncGY2TeQ6ZcVaiiSSWeqc3iLqcsDKOZHZLJ0by3AZY0vqsXh//
	 uT7eKXZajWXdCqxvpxesZRLh0svaFghQdLZ3DTmZGVSoC/TBSTB7TRjDNPbmF/V3He92A
	 PdcRpVeGpcsjJNmEKVFNmFJ7+ky5yXQHnm6WxL+/1ucXH01gDd5kmZWxFRJ9b8+ABMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793039850;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=jz6PhmHAqHAHeg3j44XUyEwE6Xd1Y8uRjpXGP04iFfo=;
	b=l59OxE2QDV+4u1KPezTWVkeJyNp5j0OPAR9zIfd8myAH1g7lsyScuRyxRivH1ilCNeVx
	 swF/n+yYv3pRoqrLH2/IWOLdY8iigACd1YPeP7W2ZwdkD8DX687d/y3to5GtVdBeSMcoS
	 G2uW7yyNa/D6ELFD/I4J9/AKBVCTo0SEdk1gLY2tDei1L3psFv8m/1wc01nMB3rfx/1zF
	 xNbwqN+o60rI7BwVLhH9VavgRKug+IXVCB4whOlTuPNOy6CICu7A1ZTwgkcDQaormAj47
	 2KxWR5SP56VRMFXOkHmGTIyJYtk+RMtVX6uwDaJ5MYXG9nT44XZBM1wBifBz1Kn4s8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cVO0Vd4B;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF1E606A31D
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 18:37:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DF1E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cVO0Vd4B
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a4d7ae1ae9so16878975e9.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 11:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793039848; x=1793644648; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jz6PhmHAqHAHeg3j44XUyEwE6Xd1Y8uRjpXGP04iFfo=;
        b=cVO0Vd4BaAgLdWISFKSYTIzQtS1MXDzRDVaSVak7zkkNZEW5+3DDGPQvwc1ImtkYYv
         yINVsVjI2CegnkPDhWXYOUuK0LVB/YZkXr5B3/P3IPiOiJZJIigJ27grxIEVt/3yyQut
         ZSJET+gCiv1LI3fM9mA4LNQq2TpU1GcRnP2vBl0rVylFXi3tAN/d3tIzMVHBIDHwvLAB
         uKPpT+lxdnIlLVIDYzFiCi/RRIv5zkhBM5wKxZASjWoNLOQFYg6qGn3iPixYOhg9ky09
         qkkbmrA/P20ZQVk6g0ePZUg4pvAZxwDZNeS4oZAVcU7P0L8lHKDyCIb++tsiW4QABTip
         fXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793039848; x=1793644648;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jz6PhmHAqHAHeg3j44XUyEwE6Xd1Y8uRjpXGP04iFfo=;
        b=LpGOh+i+XwuSWDD6v43ajHd/Pc5DFEUqJa0EtTAeP5bYwIGnLPB3QDwdZxkSBOZ4/i
         FKu+7Pc7vFZOX4DyhyyU6SuZuIHP+YB9ZR861HjUhQiYZcmoV0xkuPJRuJ1a0fsvyXnl
         /gImoRcJ87GzLKExOpQrTGIQajKVW6V2sycnKsTw+aN2ALZ9r/f8DCQi0EFuJWFKhaUa
         lkMAbv4DcaxhZgODhk8BVyxZ8d06ls/X0KDmEjOg12CLXcNZNfL5T2cTXiaEUUo0hea/
         6kVT6KPw4KYhAY1Wrzdlrau41Js9+o8kttxbW4wlh9XmJnpiGkRbAMbGldCR//8ANbO6
         ueGw==
X-Forwarded-Encrypted: i=1; AKwUvBzwFZlcv0vdAw076NXsIbW18L6ikYcw5bN8/O4q3UfQ5Zv5p/waHJC/2Dwa7w7rhglo6OjX2+U=@vger.kernel.org
X-Gm-Message-State: AFq9FYLb2VN8pBrvVLiBSYfxYVl+5T7rXej+TDPliFZTFNow8qawn0fo
	OudEHtPB7kgfvdPUUCETpPFUXrK5Kch59FTNCaXMHqpZPRXl1zTHUcvQ
X-Gm-Gg: AYBFou1Pz1NMGPyw1OvdEsazLWOwf77H+4Zx+kquxSN5+gAcuBFqk+V1BaM5Q326Ez7
	KXEfGwWBplBObetGBtE9/emx7yLABh0dqvzWtNdxGyJVREeNMCqrOpEZtKymnXD2aoHH9oasYah
	VdfwsLZ83pnf2GBY6jicJR/yPxADmm/aWjKiZzxZDQgYkbJNGgqMwyYTXtJg36B+nN3NXuuWOhF
	A+VJMGYdwwN4DB6JV54wwbdGq5+xmWbP2cA5HRPWODX3VeR282hPnxQuj75IlknNOR6tExZDJdc
	wjIyHBQTaHt2FbzQJ4fCfPahKaq5eG6dWR6w+VRTV+hWq5gLsLwTXj53NSP8fG3QZXtAQJNmSxI
	aY1K2a12An9xWGJAZyMpHroM2C9zWS4Jr6mBK1ATZ4n6wn28aex3/Au6mFkk1f3N0BNUX561nJS
	fpXK9FYZzn17WH5gcULCLqi822gio6swCouHMkOAm8WUWIYBZiDdAma+YP6ZGp2UpXAKKJl6zTj
	WE8b0Qc82HLF8agnertFc8ujfvuY237tVr7CVMwlT4u3/p4vqb9av93OtJlisNgUFwCXE/eBw8N
	qVRquzskagUVBjtL
X-Received: by 2002:a05:600c:3e8c:b0:4a2:392:9de2 with SMTP id 5b1f17b1804b1-4a35acab6cdmr122544295e9.28.1793039847593;
        Mon, 26 Oct 2026 11:37:27 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a5698f1sm211231605e9.8.2026.10.26.11.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 11:37:27 -0700 (PDT)
Date: Mon, 26 Oct 2026 18:37:26 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>, Dmitry Antipov <dmantipov@yandex.ru>,
 Jacek Anaszewski <j.anaszewski@samsung.com>, Bryan Wu <cooloney@gmail.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, linux-leds@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 14/21] leds: flash: Avoid divide-by-zero in
 led_clamp_align()
Message-ID: <20261026183726.30238d39@pumpkin>
In-Reply-To: <20261026173129.GF2195460@google.com>
References: <20261021123406.3163547-1-lee@kernel.org>
	<20261021123406.3163547-15-lee@kernel.org>
	<20261022220006.6e066670@pumpkin>
	<20261026173129.GF2195460@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
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

On Mon, 26 Oct 2026 17:31:29 +0000
Lee Jones <lee@kernel.org> wrote:

> On Thu, 22 Oct 2026, David Laight wrote:
> 
> > On Wed, 21 Oct 2026 12:32:23 +0000
> > Lee Jones <lee@kernel.org> wrote:
> >   
> > > If a flash LED driver leaves a setting's step size as zero, writing to
> > > the corresponding sysfs attribute invokes led_clamp_align() and triggers
> > > an integer division by zero when aligning the offset to s->step.
> > > 
> > > Clamp s->val to [s->min, s->max] and return early when s->step is zero.
> > > 
> > > Fixes: 7aea8389a77a ("leds: Add LED Flash class extension to the LED subsystem")
> > > Closes: https://sashiko.dev/#/bug/linux-9d06d7fe-310b-4aee-8b16-0fb49550c287
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Lee Jones <lee@kernel.org>
> > > ---
> > >  drivers/leds/led-class-flash.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/drivers/leds/led-class-flash.c b/drivers/leds/led-class-flash.c
> > > index 181dfd49c6ad..16b3b6b9365b 100644
> > > --- a/drivers/leds/led-class-flash.c
> > > +++ b/drivers/leds/led-class-flash.c
> > > @@ -375,6 +375,11 @@ static void led_clamp_align(struct led_flash_setting *s)
> > >  {
> > >  	u32 v, offset;
> > >  
> > > +	if (!s->step) {
> > > +		s->val = clamp(s->val, s->min, s->max);
> > > +		return;
> > > +	}  
> > 
> > Why not just:
> > 	u32 step = s->step ?: 1;
> > and then use step instead of s->step.  
> 
> I can see where you're coming from, but I don't think this is better.
> 
> With `step = 1`, the reader has to mentally trace `1 / 2 == 0` and `1 *
> (offset / 1) == offset` to see that it reduces to a plain clamp and the
> CPU still executes a redundant integer division.

That happens with a step of one anyway.
All my suggestion does is treat the unexpected 0 as being the same as 1
instead of optimising for it being zero.

David

> 
> IMHO, simple, easy-to-read, maintainable code wins out over clever code.
> 
> > > +
> > >  	v = s->val + s->step / 2;
> > >  	v = clamp(v, s->min, s->max);
> > >  	offset = v - s->min;  
> >   
> 

