Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADCF1E505;
	Wed,  3 Jun 2026 12:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780489382; cv=none; b=hC8X+7At3Qlx0jHD+NkHTuDoAaL5cK/bwd2KNk9DvR76A448KyBEzuxTHjVMTdTAu8JevGK4Ujh5j1+RX7SHb56JxiRYS/mDtVTz1v5Ua+dKr7IKNrlAlVSQoM+x2L44c7GTjhACLX5llu8dEZ6IYEG208aZas8o8OF9miqlmYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780489382; c=relaxed/simple;
	bh=KV5uC7PKcB+R3hscROj8Kgwv0VOsdJTwkz8sis3IUUw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aluIv6TEuc6fqQiWDK7ue/U5Z4BX0DNbc2zZOWbuiZiVXB6EtOafOv8RjxSCfn+UbwEowa5ERX1UDn+BV0Sdi5SpwHGCoC/Gfcwc3o5K3Qu8A00v6MAzz7rLNdK3okRqAu9/qZ0TD0lOQ3LcqOvbUroVzo7YHfWFP7F71GbTwEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PbjfXL4A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PbjfXL4A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5AEC1F00893;
	Wed,  3 Jun 2026 12:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780489381;
	bh=+x/5iFyh81ecJOIvoedPkJ2hY7shqzS6w5IdRGSquT8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=PbjfXL4A5ecM7RLdqACjoaKzuFfbpD20y0foLs9/xm+9gbmxjO20Hvky+R9jdCOHT
	 EZgL9223Ew52lgALEUrnYA8iiKwe9g4lV8Kyo7pErBWkI2Xge5j65+r/RL1316JO97
	 lNGunpzi20yQYYJGx+dnEX0Ib+d0DV7mg2KVD4S6YNoxHoVYHleW27uafi3b/l2ANs
	 zHl2JiBL26cpCX2xh/6v2rRk2SIfcbf2r/YihZyykSPnMuFf4ycLirn9xpInrs/Fi3
	 2W9KpI4DMnWT4QgwNChXr9N+MRzEpNsKDY9qMV/0cCLxYVvE51up/R9iTbrByxjSFg
	 nmx3AqE3eZe9w==
Date: Wed, 3 Jun 2026 14:22:58 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc: Myeonghun Pak <mhun512@gmail.com>, Ping Cheng <ping.cheng@wacom.com>, 
    Jason Gerecke <jason.gerecke@wacom.com>, 
    Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
    Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH] HID: wacom: stop hardware after post-start probe
 failures
In-Reply-To: <ahdE9G8I7kd_OoGW@google.com>
Message-ID: <nr568s88-77o5-p5pn-5r1n-236371989rn0@xreary.bet>
References: <20260524175552.1973-1-mhun512@gmail.com> <ahdE9G8I7kd_OoGW@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 27 May 2026, Dmitry Torokhov wrote:

> > wacom_parse_and_register() starts HID hardware before registering inputs
> > and initializing pad LEDs/remotes. Those later steps can fail, but their
> > error paths currently release Wacom resources without stopping the HID
> > hardware.
> > 
> > Route post-hid_hw_start() failures through hid_hw_stop() before
> > releasing driver resources.
> > 
> > This issue was identified during our ongoing static-analysis research while
> > reviewing kernel code.
> > 
> > Fixes: c1d6708bf0d3 ("HID: wacom: Do not register input devices until after hid_hw_start")
> > Cc: stable@vger.kernel.org
> > Co-developed-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> > ---
> >  drivers/hid/wacom_sys.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> > index 0d1c6d90fe..c824d9c224 100644
> > --- a/drivers/hid/wacom_sys.c
> > +++ b/drivers/hid/wacom_sys.c
> > @@ -2456,16 +2456,16 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
> >  
> >  	error = wacom_register_inputs(wacom);
> >  	if (error)
> > -		goto fail;
> > +		goto fail_hw_stop;
> >  
> >  	if (wacom->wacom_wac.features.device_type & WACOM_DEVICETYPE_PAD) {
> >  		error = wacom_initialize_leds(wacom);
> >  		if (error)
> > -			goto fail;
> > +			goto fail_hw_stop;
> >  
> >  		error = wacom_initialize_remotes(wacom);
> >  		if (error)
> > -			goto fail;
> > +			goto fail_hw_stop;
> >  	}
> >  
> >  	if (!wireless) {
> > @@ -2496,6 +2496,7 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
> >  	return 0;
> >  
> >  fail_quirks:
> > +fail_hw_stop:
> >  	hid_hw_stop(hdev);
> >  fail:
> >  	wacom_release_resources(wacom);
> 
> I'd get rid of 'fail_quirks' and use 'fail_hw_stop' everywhere,

Agreed. Myeonghun, will you send v2 please?

Thanks,

-- 
Jiri Kosina
SUSE Labs

