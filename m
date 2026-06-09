Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF561231832;
	Tue,  9 Jun 2026 07:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780989405; cv=none; b=LQIZIK0JxsCqv8w2L8UKo/lTyiQSt7CqjNph77cNqzEGs7A8Pyp81yLYHMgt/ZAu0Pc2f2u2hxLsI0zwex4YcjkOJg9Wf5obnWOTnBambG8YqtO6I6ASZHw6UePq5mX0VF4QK0N7xEezxUgDw/p7Gqr0lyXDnkd6Qngf1rO/aG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780989405; c=relaxed/simple;
	bh=opZAywMiMJwNqnAF0qCOyiFq0tt6Du3M9QkQqyqnf0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q4khfz7pf52OQEopfT3IfHKifgZx2KS/jodv9wUb3A1lnAjtqBjhq47Z7IJFC9+A/W0vvHVfFXcFHWkKkdkKmwC+3lxzT5iN4IYLcRCLCPeAesShOhzLdHT2UPcPnyXs2X010g93DuG6lS6LpHP+ioWbeD9HEjYiH4u2aGV0hvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Kr1n4Uts; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Kr1n4Uts"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 61AA1C4FED4;
	Tue,  9 Jun 2026 07:16:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 009365FFC1;
	Tue,  9 Jun 2026 07:16:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 31A7C106A2AA7;
	Tue,  9 Jun 2026 09:16:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780989399; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Ll4RtAYhS2rFE5eRASFLWyUVEVc0Hay6pdACZEO3nE8=;
	b=Kr1n4UtsKcLcc8mnEDUlI9/QEfHHzrU0bANTQKUzXFK+cPPHlZu6J6AOijWyT4ubEyFdFu
	eHyxh6eR/FpPmd+Kr+XeyR/Paqkj3P0cCOmhCvz6UcO8oHEfNxOUtwU4HO8h4oNjv4S8vP
	xYC3KXPW+qQ80iwTv6O7Wpav0j0keC2njj+PMxuUKo4bdBWVYfh//3aKNEr5L0eOzA5qQf
	U4/mGRNmhCZKd5hBjNdLtd420py/17wAnSAvLV/UQyH/RlFaNCAqc/M88xLKORBeMeBy7J
	/uCfKqNgRLXIcHurkosOlhYyOvcPmc/MWIT3GB4D44/va0XDUJYLZLVUzunwaw==
From: Romain Gantois <romain.gantois@bootlin.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Paul Kocialkowski <paulk@sys-base.io>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/logicvc: Avoid use-after-free with devm_kzalloc()
Date: Tue, 09 Jun 2026 09:16:34 +0200
Message-ID: <aEp-mETTTxmIRUxspbPhzQ@bootlin.com>
In-Reply-To: <20260608-beetle-of-infinite-atheism-bcfcee@houat>
References:
 <20260601-logicvc-uaf-v1-1-8c9ca5b3429c@bootlin.com>
 <5Q6YIC1WTqOFVMFErYGBEQ@bootlin.com>
 <20260608-beetle-of-infinite-atheism-bcfcee@houat>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPartbwA1YJYMT_237ZM1LpD28w";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Last-TLS-Session-Version: TLSv1.3

--nextPartbwA1YJYMT_237ZM1LpD28w
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Romain Gantois <romain.gantois@bootlin.com>
To: Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH] drm/logicvc: Avoid use-after-free with devm_kzalloc()
Date: Tue, 09 Jun 2026 09:16:34 +0200
Message-ID: <aEp-mETTTxmIRUxspbPhzQ@bootlin.com>
In-Reply-To: <20260608-beetle-of-infinite-atheism-bcfcee@houat>
MIME-Version: 1.0

On Monday, 8 June 2026 18:19:04 CEST Maxime Ripard wrote:
> On Mon, Jun 08, 2026 at 05:41:11PM +0200, Romain Gantois wrote:
> > Hi Maxime,
> > 
...
> > > You're only partially fixing the issue. You also need to protect any
> > > device resource (register mapping, clocks, etc) are no longer accessed
> > > after the device has been removed, and this is typically done using
> > > drm_dev_enter/exit.
> > 
> > Sorry there's something which I don't quite understand: is this a new
> > issue
> > which is specifically introduced by my changes in this series, or a
> > different issue in this driver which isn't handled by my series?
> 
> A bit of both I guess ? :)
> 
> My point was that while your commit log claims you avoid use-after-free,
> and your patch definitely avoids some, you can still trivially trigger
> some.
> 
> Whether you want to fix them all at once or prefer to defer it to a
> later point in time is equally fine by me, but you need to be aware that
> it's not done, and you probably want to have it in the commit log
> somewhere too?
> 

Ah ok, I didn't mean to claim that I was fixing any potential UAF in the 
driver. But if there's another one then I'm definitely interested in fixing it 
as well :).

> > IIUC all I'm doing here is just letting the drmm code handle cleaning up
> > the plane, crtc, etc. objects instead of doing it "by hand" with
> > devm_kzalloc. Why does this make it necessary to add additional
> > protection of driver resources?
> 
> It's not necessary, but it's also kind of the same issue. The reason we
> need to have drmm over devm is that the driver stays around longer than
> its device, so devm-allocated memory would have been freed.
> 
> But that's also the case for *any* devm resource, or more generally any
> resource linked to that device, so register mappings, clocks,
> interrupts, etc.
> 
> So yeah, it's a different symptom of the same underlying cause.

Okay, I'll assess the issue and probably make another patch in the same series 
to fix that.

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nextPartbwA1YJYMT_237ZM1LpD28w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIcCsAScRrtr7W0x0KCYAIARzeA4FAmonvdIACgkQKCYAIARz
eA7kTg/+NoagThXw+iN7Q3fx0etdoKAG1eAtU2g5ctpyJHJt+byOCdo++rTheK2d
ivZDjZDdF1pORoe0XFPwgp+hl0VcZ3D7HJtKhMgftUH50k1Xh5VBBPgV7yjH7rGM
rcaBvqRxWf+FyrqElFWfrdMz5ewbszMQYj3oo/wWaztOZquuzc3rE2IJc5NYz396
OQUKx5srPy9Fy9+GWc8KsAn+4Y4awRMokffzE7l0tKCSX0qssNYCdHzzX1r+gCpj
SmwHoHJ+IzPI8lJnE92KMnjzrwDcpD0R8UdEMHu25dfsPwkpc8d9io95qlktwAPz
ogDl2SKsPo1clIjxrzT/SmHFzGjQQtIRXC4QkMfmtpp8MxA3wrFtBPqJKOKyG0Z2
twJ0L9wBxHyTYPhOqiaPeUtOVg66bi7Tx/DpZAOx3IAaDUHUhdeepmM0spVh2M+P
k/i6JzKu8D+5yDBHoOrL+G0MzL/SU13cw+epxtNGAbIm8iQRLYHZjF/d5QPLlmFf
oIp3tzqkGVB4DAIVjTbHaZGdAfgikC9ZjqU7qYXTxQx7Z2dd/wTe+u3KJ0A24IlZ
6a8fQN5IDTpdtPrwWSAMoRUZLHB7AGZ10lGNKsUHAsIo2vdt9NvpvaQ4ukYA04kn
g9416mcACNduCd5kvERtF0iDtUhtCk4fJX91WpwXWRz6NMZulfk=
=WA82
-----END PGP SIGNATURE-----

--nextPartbwA1YJYMT_237ZM1LpD28w--



