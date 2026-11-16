Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794848097;
	b=AekaJcsju9ARunGa3GitMYeGPTexxvWDxZRnsf4IzevchCmikEk//8OMPwl2x6/flGo8
	 NN+UmGHBCdSd8OnuGh7qPzaMtc4Wphk1AhK/2t08dC05oCNQikzN8sv3tv7cdKYMRrxyu
	 3lpVYIb5IE6SicAO/WG4nSis3sb8kUcXN7UVv9fkaAfoVcvo58UHVKKBFeoiQRueS9D5c
	 1k7MX2L9oMliOw5b0jWnn18D07832ugvwgsUAgVQZk4MCbTcCuRlW6aJXPpURKdtJlnyV
	 btnh1gbZY5wfHNlXSjizgTkFwav3qUXG00szIyZWlQ+mw7U7W2WhQzRTa3fScOhjw8w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794848097;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date:
	 MIME-Version:User-Agent:X-ZohoMailClient;
	bh=ZSzyp4lFwlreLUU4PejF2EMnCKVfR/iyAWf8TtqgbQ0=;
	b=1bn2IopS1GXVVL/ozH0HeIXGtn88o0O8S8+9L6tfCgRolYqvew5LOUmAFFXA4aLButdy
	 F0gXGZ2/69xE6uyNNGgY4PGG2/3KTEyFycpzN/8kkRIfOoAxrcRUMW4cGBiEYxUbeCRkt
	 Hgqtkf9qnJE+A+trWYCdQU7qJ97w0imJzhoQfcATk4uvz7iQg5NEf1jljaJ+VXf+NI4ni
	 QtYdsQa6uJGWEUhSCSwZrH5uvIOh8sOioszC8GvPfxMbMQrsug8RnltHtKr7/o0kzB2DL
	 JdVnpG+tBlA3hJEmEQeDgk+kx48qStHXweeLVNQ39Mt6dRoEpesBFjl37mthM3hR1Fw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=C6zquPRs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6286E606A33B;
	Mon, 16 Nov 2026 16:54:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6286E606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=C6zquPRs
ARC-Seal: i=1; a=rsa-sha256; t=1794848083; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JD4ydr1iuiHowzpMJSrv8Q6GfZX0KYDc7G3D7m1tSwHAwd8zPUCzXY+5hZva6xFS4OnbIc+IBlbS3JJIF5Q5Jbd8hlcJyRWbXxLIXYXfcfRMlpbsFmL1O+q2h8lB9ZEpCDKcIVLN3n1Awmmb/aNS2KB5bczq3VTKPitwqUUBtmI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794848083; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZSzyp4lFwlreLUU4PejF2EMnCKVfR/iyAWf8TtqgbQ0=; 
	b=nI4G34cyRCkGjcEc2RF6lA5n1vRelRbVgHgOZy9Ko6nK6j6SixkIdGszxe+jqJFXrbbKoLCpvWWFqR6FNGFjmUHQnMjqhgRS5aUr6HrLVfckr/EeCnumoXAMpn5RB8ajZXa9fMux4yghlnaO1p09eWCqzTdoYPLLStLubJdUUvc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=C6zquPRsGZfuwy6/Qpi0D4VvD+o2x369ORaqRuMb5i4H+GvkWfbd9dLqJyyYqlF7vPwydqeEYz3DA3fzPLiGTpSMvbZ449tKKzk/DkEKAx6uwB3JwTgKwvj4/rKIQJFzppG8sChyGOw4RuUW2Pf2ptplzolGx+QATXoHlbDJNl91maAXNYmz/hU6UQg9zi9GOXUVgeP179jhQp4hWKSJiiRIUSNh/bgOI9EXCKM1NjAE3SlGA6+jS0BB63lPVripxzkZOkDXA3ttekRlU1jeHlWKHOHi5zFAZGIM8T+EcMXJ8RuvFT57d3pK4aPhdY//F7dCx+JVQZhE5HHr1wyQig==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=ZSzyp4lFwlreLUU4PejF2EMnCKVfR/iyAWf8TtqgbQ0=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 179484808123116.622750164090803;
	Mon, 16 Nov 2026 08:54:41 -0800 (PST)
Message-ID: <c5dd1ebfb0b359663636b76d3f61c9fd9fefd661.camel@rong.moe>
Subject: Re: [PATCH 0/7] platform/x86: ideapad-laptop: Trigger the EC on
 YMC events following Windows behavior
From: Rong Zhang <i@rong.moe>
To: Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J . Clark"	
 <derekjohn.clark@gmail.com>, Hans de Goede <hansg@kernel.org>, Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, Gergo Koteles
 <soyer@irl.hu>, Ike Panhc <ikepanhc@gmail.com>, Andrew Kallmeyer	
 <kallmeyeras@gmail.com>
Cc: "platform-driver-x86@vger.kernel.org"
	 <platform-driver-x86@vger.kernel.org>, linux-kernel@vger.kernel.org, Mahir
 Faisal <mahirfaisalantiq33@gmail.com>, stable@vger.kernel.org
In-Reply-To: <859daa2c-e891-410c-a528-58fc49a2ccea@app.fastmail.com>
References: <20261116-ymc-82yl-v1-0-fac1a2b01a84@rong.moe>
	 <859daa2c-e891-410c-a528-58fc49a2ccea@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 00:49:31 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Evolution 3.62.1-3 
X-ZohoMailClient: External

Hi Mark,

On Sun, 2026-11-15 at 17:38 -0500, Mark Pearson wrote:
>=20
> On Sun, Nov 15, 2026, at 2:27 PM, Rong Zhang wrote:
> > Currently, the ideapad-laptop driver triggers the EC with YMC command
> > 0x01, which seems to be randomly chosen with trail-and-error and turns
>=20
> typo: trial-and-error (this is in patch 6 too)

Whoops, I will fix it in the next revision.

>=20
> > out to be not a command for YMC events. While the devices in the DMI
> > quirk table recognize it, some other devices do not, making the
> > trigger_ec functionality a no-op.
> >=20
> > Lenovo's YMC driver for Windows (YMC.exe) emits YMC command 0x08/0x09 o=
n
> > fold/unfold YMC events, in which "unfold" means laptop mode and "fold"
> > means other modes.
> >=20
> > Adopt the said sequence to make it work on all relevant devices. For th=
e
> > sake of caution, only emit YMC command 0x08 only for the known fold
> > postures. For all other postures (including unknown ones), emit 0x09 to
> > make sure the touchpad and keyboard are still functional.
> >=20
> > Beforehand, also fix pre-existing issues, modernize relevant WMI
> > drivers, and add a resume callback refreshing the posture and poke
> > ideapad-laptop to trigger the EC. See each patch for details.
> >=20
> > With these changes, add a DMI quirk table entry the Lenovo Yoga 7
> > 14IRL8 as its EC must be triggered by software on YMC events properly
> > (i.e., with command 0x08/0x09), or else the enable state of touchpad,
> > keyboard, and keyboard backlight become out of sync.
> >=20
> > Reported-by: Mahir Faisal <mahirfaisalantiq33@gmail.com>
> > Closes:=20
> > https://msgid.link/CAGAHqH6o0TUa1HXMrNV6e+HNYwU3xxHkOM665756n8Cp3AzhVQ@=
mail.gmail.com
> > Signed-off-by: Rong Zhang <i@rong.moe>
> > ---
> > Rong Zhang (7):
> >       platform/x86: lenovo-ymc: Use enumeration to represent device=20
> > posture
> >       platform/x86: lenovo-ymc: Serialize WMI event handling
> >       platform/x86: lenovo-wmi-events: Modernize WMI event handling
> >       platform/x86: lenovo-ymc: Modernize WMI driver and factor out=20
> > events
> >       platform/x86: lenovo-ymc: Refresh posture on resume
> >       platform/x86: ideapad-laptop: Trigger the EC on YMC events=20
> > following Windows behavior
> >       platform/x86: ideapad-laptop: Enable ymc_ec_trigger for Lenovo=
=20
> > Yoga 7 14IRL8
> >=20
> >  drivers/platform/x86/lenovo/Kconfig          |   2 +
> >  drivers/platform/x86/lenovo/ideapad-laptop.c |  42 +++++++++-
> >  drivers/platform/x86/lenovo/ideapad-laptop.h |   9 ++
> >  drivers/platform/x86/lenovo/wmi-events.c     |  38 +++++----
> >  drivers/platform/x86/lenovo/wmi-events.h     |   1 +
> >  drivers/platform/x86/lenovo/ymc.c            | 118 +++++++++++++++++--=
--------
> >  6 files changed, 147 insertions(+), 63 deletions(-)
> > ---
> > base-commit: 7e1392a42ea288d70a266f6553fe06f57f8647ea
> > change-id: 46a18a06-ymc-82yl-d59b4f8f891e
> >=20
> > Thanks,
> > Rong
>=20
> I feel like I should be able to find some more formal documentation on th=
is, but as these platforms aren't in the Linux program not sure what I'll g=
et (or how long it will take) and the series looks good to me.=C2=A0I'll se=
e what I can find so hopefully we can avoid a long list of quirks (as neede=
d in patch 7).

Thanks. I have a faint feel that the 0x08/0x09 sequence should be
generic, and removing the quirk table is on my plan, too.

My decision when I wrote this was to figure out a compromise before
confirming how generic the sequence is. As a compromise, PATCH 6 applied
the sequence to devices that were already in the quirk table but did not
apply to all devices by removing the table.

Would you prefer to defer to the documentation, or we can figure out a
follow-up patch afterward?

>=20
> One open question on patch 4 - but patches 1 to 3 and 5 to 7 look good to=
 me.=C2=A0
>=20

I will answer it there.

> For those:
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Thanks for the tag ;-)

Thanks,
Rong
