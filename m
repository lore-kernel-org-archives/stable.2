Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794664824;
	b=v7LoB09HrQDAtvCecDuvRUCMb4pz+NuHTQRpxEqw3zaqeZkYsM8M6ZhR7b7tmu9X9Kpw
	 vbTpw4JKqgc3ijJ6JWbwJmcUGYPCa9y12UBtR/GIcllf3qyYquBP68a8jg0saKf9fcWIJ
	 55kiWNn+aqK+skntRN4ORWchYm2rcXHIUMAu6v8bP19AaNl0tTyDvx2F0J3z6vvFa9U7e
	 OEQvdZvrJi0Gc+/PTf13NgwS+4hFTfVcC4UTYzvM4WHYFxXVMPgHZR4BxYV35xu5MGbUp
	 VC/wMSy7/Rpet/iyPHpq3UOHa9/RsjHQBpLBJ+jabnijTU0s/wn2QcijeSFdB7CU6dA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794664824;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=1dpTcg8HyfSHsl+XvtGX2FlBQQEU6hsYdR9t/FaQ0zQ=;
	b=k8uwKflGxmaNxTzoCSvjF2gKesY0di+t5jKr571blrOSkGI1Ow9aWDr2qiSsIgJ5gBOC
	 NteaF7/veq/8POjX22uqfrVY5CsXiM/YBdv7DL4IT5lqWG8/3BqgRqqbV5CyFY6cA9AMX
	 HxcwYjzGRf0qILTSJuk67+l/JhrrqjhxnhwFmm3F0pCuV3qJvwYvhSa/4C+tXd1F8GHGL
	 gvH/lGKLO8C5Fo8QB7elGdlVw3TAZOD7+Fy0W6oQaM6rnk3q0uv5aC3tL7vVsP8gF/c2a
	 XefPiUX0frQD/8aoPHBra0x5BgQnIIePoJ+NlzAr0ie+5Mu8LliN7HBbk0d1GqPZPkw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=XdRyzMuI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88C3606A329;
	Sat, 14 Nov 2026 14:00:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D88C3606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=XdRyzMuI
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 7C89D201CE0;
	Sat, 14 Nov 2026 15:00:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794664820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1dpTcg8HyfSHsl+XvtGX2FlBQQEU6hsYdR9t/FaQ0zQ=;
	b=XdRyzMuI0icxAFx8JBPICCXqHQhP7Q6+sBy/Xeu12M1iCwzqlFSAB4W/lRmz2cAjslx+le
	ZnG/wg+7t1UAxj3pX2i8TI8I6Tz2eP5H4z0An4HdJDPZ5+tE+yy5dSsaPrzgPyidSbZ4xN
	cWt+v6vnpZqhWrWQYnsOoUtEjuQZl0Ypo7YMZohoOywRkk9EZuOW2eRRZqFmVX65IvBHnz
	BkhtoRCC1f/apqESfCxsvAynkZ1Yvq6j+NuDd8DHxNKi7mlSPHaBGRzBd4jorLen9fFWBM
	LrzLgxDzWeJm3y6RCVhoksj+1ZgoF8PjOS9CeimNRjQ2sZHzhZL2t7PBJuSyOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794664820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1dpTcg8HyfSHsl+XvtGX2FlBQQEU6hsYdR9t/FaQ0zQ=;
	b=AGwy/al9BvNtOxxSpWuPfXxueIlXpc26x/EdulXEAX+Mdt90BuhgJr+TLuIcEAj+HXmx2U
	YBQ7HvYdkV6+aCpGWfko9kibXS2xv8J9iLKk8MkXGH6RwbQt7VUPyyFKXynJUvttZREfQV
	PzQLjmcYAn54QSvTR0eOSk/3B+FeSv2HrRqN4E2MkecarFYyPoR9u/pV7AzpUUnUYUHOSu
	cBsiE4ACnaxHC3+6pFoMyAK75VAH9Ie+y186g4IANkGCpn9Nd+R3p3OUbT3rozYSO6NxS2
	tXl9VaBpxr6CaXqYhZ7BAz5P+KVm1XrR6tZJ1tbNcDQ9SMQnr6wHn0z6AmFFpg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794664820; a=rsa-sha256;
	cv=none;
	b=ONVrIgef4hdTZTuTg2ysDJY10hubKZV7+QjzIGcZzvignb2VyzVNy75gJH8rCydVpjHRCy
	RRgFOEDvSS5r99WmGyIkHwgJDUKIgp53Aw80fKQNp6FU8cyPcP6i1HgBB65ZhI5x2HBwkz
	mUfaHGZ3kbJQ/t2W5GnqJT7pxahXmlbACn+ZAqxiH7LGqfZoREecgWcsfXYcaNmXY1E/JK
	DVEOoFyXlIliZ+RnyqPtcXQDiMxKxRgiANY1aV5nJtHZoKeThtKYuNxODFGJ3qLTDsl/hU
	5JpooL6Tzgu6icdUbJUUOan1yUZoFCCVTq3v5wbqVK9FFhUq+QNt5JAuZuQSzw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xSEIm-0049Bq-1G;
	Sat, 14 Nov 2026 15:00:20 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 17ED45EBA9B;
	Sat, 14 Nov 2026 14:00:20 +0000 (UTC)
Date: Sat, 14 Nov 2026 15:00:19 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
	Eric Evenchick <eric@evenchick.com>, Maximilian Schneider <max@schneidersoft.net>, 
	Wolfgang Grandegger <wg@grandegger.com>, kernel@pengutronix.de, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Shuangpeng Bai <shuangpeng.kernel@gmail.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH can-next v5 6/6] can: gs_usb: fix hardware timestamp
 state for mixed channels
Message-ID: <20261114-impossible-cuttlefish-of-witchcraft-5e882e-mkl@pengutronix.de>
References: <20261108-gs_usb-fixes-v5-0-d52dd4940d46@pengutronix.de>
 <20261108-gs_usb-fixes-v5-6-d52dd4940d46@pengutronix.de>
 <b2c7d556-a6f2-4b3c-b141-49c3b558da87@linux.dev>
 <20261109-singing-lyrebird-of-bloom-ed3c85-mkl@pengutronix.de>
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
	protocol="application/pgp-signature"; boundary="oszfdmhn34udnkmf"
Content-Disposition: inline
In-Reply-To: <20261109-singing-lyrebird-of-bloom-ed3c85-mkl@pengutronix.de>


--oszfdmhn34udnkmf
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can-next v5 6/6] can: gs_usb: fix hardware timestamp
 state for mixed channels
MIME-Version: 1.0

On 09.11.2026 13:58:32, Marc Kleine-Budde wrote:
> On 09.11.2026 12:40:14, Vadim Fedorenko wrote:
> > > diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_us=
b.c
> > > index 6327069f63c9..0a1cd14c940c 100644
> > > --- a/drivers/net/can/usb/gs_usb.c
> > > +++ b/drivers/net/can/usb/gs_usb.c
> > > @@ -337,6 +337,7 @@ struct gs_usb {
> > >   	unsigned int hf_size_rx;
> > >   	u8 active_channels;
> > > +	u8 active_timestamp_channels;
> > >   	u8 channel_cnt;
> > >   	unsigned int pipe_in;
> > > @@ -481,18 +482,35 @@ static void gs_usb_timestamp_init(struct gs_usb=
 *parent)
> > >   	cc->mult =3D clocksource_hz2mult(GS_USB_TIMESTAMP_TIMER_HZ, cc->sh=
ift);
> > >   	spin_lock_init(&parent->tc_lock);
> > > -	spin_lock_bh(&parent->tc_lock);
> > > -	timecounter_init(&parent->tc, &parent->cc, ktime_get_real_ns());
> > > -	spin_unlock_bh(&parent->tc_lock);
> > >   	INIT_DELAYED_WORK(&parent->timestamp, gs_usb_timestamp_work);
> > > +	disable_delayed_work(&parent->timestamp);
> > > +}
> > > +
> > > +static void gs_usb_timestamp_start(struct gs_usb *parent)
> > > +{
> > > +	scoped_guard(spinlock_bh, &parent->tc_lock) {
> > > +		parent->active_timestamp_channels++;
> > > +		if (parent->active_timestamp_channels > 1)
> > > +			return;
> > > +
> > > +		timecounter_init(&parent->tc, &parent->cc, ktime_get_real_ns());
> > > +	}
> > > +
> > > +	enable_delayed_work(&parent->timestamp);
> > >   	schedule_delayed_work(&parent->timestamp,
> > >   			      GS_USB_TIMESTAMP_WORK_DELAY_SEC * HZ);
> > >   }
> > >   static void gs_usb_timestamp_stop(struct gs_usb *parent)
> > >   {
> > > -	cancel_delayed_work_sync(&parent->timestamp);
> > > +	scoped_guard(spinlock_bh, &parent->tc_lock) {
> > > +		parent->active_timestamp_channels--;
> > > +		if (parent->active_timestamp_channels > 0)
> > > +			return;
> > > +	}
> > > +
> > > +	disable_delayed_work_sync(&parent->timestamp);
> > >   }
> >
> > That's quite defensive code. You have both disable/enable delayed_work
> > and active_timestamp_channels counter just to be sure to schedule
> > timestamp worker only once.
>
> disable is needed to stop the worker from self-scheduling.
>
> Sadly workers only support multiple levels of disable, but not of
> enable. So we have use active_timestamp_channels, too.
>
> > Just wonder cannot we keep this worker running regardless of channels?
>
> For proper power management (on the Linux and on the =C2=B5C side) I don't
> want to keep it running if the interface is down.

But for now, we can start the timestamp worker when bringing up the
first channel, if any of the channels of the device uses hw timestamps.

Good idea, thanks.

> There are also (more or less) gs_usb compatible devices which implement
> (more or less) independent USB interfaces. All of those interfaces have
> a common clock, so I want to share the HW timestamp infrastructure
> between them.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--oszfdmhn34udnkmf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCavhpcQAKCRDMOmT6rpmt
0uxJAP454aqOQ+vBZ4DpCn+WSjY7G3GCvYV8sO9sDMhcyk8FHQEA7wcXxYce21+4
AQsT/v/nB1AaSbsorKB+lqnHbyej/Qk=
=v4YI
-----END PGP SIGNATURE-----

--oszfdmhn34udnkmf--
