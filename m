Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794229117;
	b=1/a3eJzLQTIyiOqvO/NpPh4iEHH1rAbEvB1jvy8vJ8tL1BUrhn50/62UEnKN9UCH14up
	 LSkPwhTB/PuYMvS+NJsPkAzjS3/a4Rg3mJfaEtaDN3J9Liz9eaV2PTbHTifUDfGR3+zeD
	 SGWvlEommDKcdcJiwRjFs2iTQ+HhKVhNoS0a4/CIZwnteP9ZOX6L/U+/Js8vzqdI8uPVl
	 L1PWpbHXQogkLIbeuQQVc9CWNvIZZ37FoUkm22+/mfvqA25KP2d7fy/yp9ajls/0iMgIW
	 X1lO76XcolWl241fNsddVDvSkC25oszlMxM+icP36qcmjh+N87vaq35UuaMdnAbw1/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794229117;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=q75vlc6esDYIJIWoOj2faBZYA7/uN4xpfj3g+F9w3P4=;
	b=IDq2QfEaKz+df6wyxEvfdem8U9q2CQqb0yjmMMQFTf2DgGCcihuj+VhdnA6SbIvPXr8f
	 Ok+MRydMK9PdE0ny6J1Cemn/x4urUQd0tdjd0NodfPvwfFBl3zxgu0vy/UUDPRfu5u+XW
	 NBfB4rLJQyDE0OKRn7NOi/vc6xcu26PQzlXoyX0ReIrTbH3ojixpxEK+MqXcdqFQFHNgx
	 GtNWdhsPnXfXG7K3cYg25QXsd2975mLeQl/4qPXZCmjfaAvg1aPTrh7MDWZXEqAhdiaOb
	 bvNBnuV+5MNJlDJTnrEzxPAK3iL5nV/peud+cW2+MNmfbIkyOvRO7HDFUIYt+ghVV0g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="GKbwP+Y/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92707606A339;
	Mon,  9 Nov 2026 12:58:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92707606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=GKbwP+Y/
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 6CCE42008BB;
	Mon, 09 Nov 2026 13:58:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794229113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q75vlc6esDYIJIWoOj2faBZYA7/uN4xpfj3g+F9w3P4=;
	b=GKbwP+Y/AVGQSp2OgvmywE4GBeChAMvC7uU53ZKAe2uf6VjA/MwL4bwJ7SBd2tQ+XM5+Nc
	MTnFWdE8zemEtnMBlQwZUQTuYSztC2EsoL6EJOcScexRhrJfzpt3mR68vxnjo6JX3fhGdS
	GfG9ov99vlKNTD/XM7jP+tcIpe0cP41rV4YEG1fgNGpcUUcTt+HUQp01B06FCC7i7idcCF
	loYqDwGtA+sO4vV0Pw4Bygr0KLSubvORmzWp8Y6djhglX3BI6WnJfHQC/agaHNHkmRfuRm
	ZxCCtJZdQjQVC9SFpvG/O2Nv6iX/PbnIlJ+nwFmGifLM7JtbSdv9m5lUU0Pm/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794229113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q75vlc6esDYIJIWoOj2faBZYA7/uN4xpfj3g+F9w3P4=;
	b=XgkT7RpSqAQXgWgtEUjwPCBC3FJOdXy8Rct4sYkITDXTeQkEUva3R7AZR4zc+d/x9rWomL
	a4g8x9tpXL2WaN6KurTEInyEbkkzpelimSIc/IORT3P2OMgXa4GE0/0OKucsp6NGf9eK2D
	r7lo6RqC11FwfUljrU47+qx9tjbDMSBI3uq05T3SoOXRXaTvKQ7jDNtCfCxakl0HLSdpQr
	bA2fxI9z9jbz24gqd6Du63Rw7PgzVzdHPl3uvewYdklBIP8yteHxm5Tqay3/5wvdCMqJwd
	ttK8JB+Rz+AcJhsh4i6gnjf1V6sphDyvsZ+zkcc330ftPe5/6sfV+iwiowIpUw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794229113; a=rsa-sha256;
	cv=none;
	b=eAYoNj7QD+WWlAcTPPDQPlPMP29u6X8F2uFe36FSs3zFJvbl0G0sb2t7+vSAovGZTMb1Rj
	lGgwkg+fFdIaNmp8C6F6H6u+frDaluvPLyMOgEUXyKujg+X7bARULWX16A+Z71oriPavXP
	tUg9fKcIpnnKBcPSLyYOdHO6NpriWBPjoZA0AV9AUxIp2RO1XfouDjvnA4Km0CQ3pAN6AJ
	PlL1vI98dtWxu4cY9q2bQxRML3pkuWH6tWuuVK4JqEgQTS7X6rdGeBHq9uVHOlPoTK8+XB
	7VshG3LdBKP+STdBBKP47TvWnQ7DPXQhHymFbhwB6/eENROzOG/AfeT3APPpsw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xQOxF-003LRW-12;
	Mon, 09 Nov 2026 13:58:33 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 075125E54C2;
	Mon, 09 Nov 2026 12:58:32 +0000 (UTC)
Date: Mon, 9 Nov 2026 13:58:32 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
	Eric Evenchick <eric@evenchick.com>, Maximilian Schneider <max@schneidersoft.net>, 
	Wolfgang Grandegger <wg@grandegger.com>, kernel@pengutronix.de, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Shuangpeng Bai <shuangpeng.kernel@gmail.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH can-next v5 6/6] can: gs_usb: fix hardware timestamp
 state for mixed channels
Message-ID: <20261109-singing-lyrebird-of-bloom-ed3c85-mkl@pengutronix.de>
References: <20261108-gs_usb-fixes-v5-0-d52dd4940d46@pengutronix.de>
 <20261108-gs_usb-fixes-v5-6-d52dd4940d46@pengutronix.de>
 <b2c7d556-a6f2-4b3c-b141-49c3b558da87@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hk7cwk4ko7grop4m"
Content-Disposition: inline
In-Reply-To: <b2c7d556-a6f2-4b3c-b141-49c3b558da87@linux.dev>


--hk7cwk4ko7grop4m
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can-next v5 6/6] can: gs_usb: fix hardware timestamp
 state for mixed channels
MIME-Version: 1.0

On 09.11.2026 12:40:14, Vadim Fedorenko wrote:
> > diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> > index 6327069f63c9..0a1cd14c940c 100644
> > --- a/drivers/net/can/usb/gs_usb.c
> > +++ b/drivers/net/can/usb/gs_usb.c
> > @@ -337,6 +337,7 @@ struct gs_usb {
> >   	unsigned int hf_size_rx;
> >   	u8 active_channels;
> > +	u8 active_timestamp_channels;
> >   	u8 channel_cnt;
> >   	unsigned int pipe_in;
> > @@ -481,18 +482,35 @@ static void gs_usb_timestamp_init(struct gs_usb *=
parent)
> >   	cc->mult =3D clocksource_hz2mult(GS_USB_TIMESTAMP_TIMER_HZ, cc->shif=
t);
> >   	spin_lock_init(&parent->tc_lock);
> > -	spin_lock_bh(&parent->tc_lock);
> > -	timecounter_init(&parent->tc, &parent->cc, ktime_get_real_ns());
> > -	spin_unlock_bh(&parent->tc_lock);
> >   	INIT_DELAYED_WORK(&parent->timestamp, gs_usb_timestamp_work);
> > +	disable_delayed_work(&parent->timestamp);
> > +}
> > +
> > +static void gs_usb_timestamp_start(struct gs_usb *parent)
> > +{
> > +	scoped_guard(spinlock_bh, &parent->tc_lock) {
> > +		parent->active_timestamp_channels++;
> > +		if (parent->active_timestamp_channels > 1)
> > +			return;
> > +
> > +		timecounter_init(&parent->tc, &parent->cc, ktime_get_real_ns());
> > +	}
> > +
> > +	enable_delayed_work(&parent->timestamp);
> >   	schedule_delayed_work(&parent->timestamp,
> >   			      GS_USB_TIMESTAMP_WORK_DELAY_SEC * HZ);
> >   }
> >   static void gs_usb_timestamp_stop(struct gs_usb *parent)
> >   {
> > -	cancel_delayed_work_sync(&parent->timestamp);
> > +	scoped_guard(spinlock_bh, &parent->tc_lock) {
> > +		parent->active_timestamp_channels--;
> > +		if (parent->active_timestamp_channels > 0)
> > +			return;
> > +	}
> > +
> > +	disable_delayed_work_sync(&parent->timestamp);
> >   }
>
> That's quite defensive code. You have both disable/enable delayed_work
> and active_timestamp_channels counter just to be sure to schedule
> timestamp worker only once.

disable is needed to stop the worker from self-scheduling.

Sadly workers only support multiple levels of disable, but not of
enable. So we have use active_timestamp_channels, too.

> Just wonder cannot we keep this worker running regardless of channels?

For proper power management (on the Linux and on the =C2=B5C side) I don't
want to keep it running if the interface is down.

There are also (more or less) gs_usb compatible devices which implement
(more or less) independent USB interfaces. All of those interfaces have
a common clock, so I want to share the HW timestamp infrastructure
between them.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--hk7cwk4ko7grop4m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCavHDdgAKCRDMOmT6rpmt
0hFjAP92TkKVnrL3ILSGScPGwz183HyjTpO6DV0QrU8iM/0xswD9HSpuIbYwSUxl
A9qyzKqP7wTPlfE+SWkH6NRuqbyJNwc=
=eEax
-----END PGP SIGNATURE-----

--hk7cwk4ko7grop4m--
