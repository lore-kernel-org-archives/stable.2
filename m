Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C75F45D903
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 20:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792094772; cv=none; b=n0JFmwQDRqSrBvi8lkoirK1g0zRpUY9wjM+zxT9+HDswIhuqwY57tIlsfI8x4lKJaoWz/vk71sQc9OYJTwdExxpNwtGARojo4y9WXPWbuPZNkHQZ1P/ebMadsHiU6MO4zYCGpIAg/OEWea8CnwOMeSBrPGZX1jncqmC7LZKP+qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792094772; c=relaxed/simple;
	bh=ETkB9eRVciEJ5r6J2oMUPIOaoRp3Bl4yuA1gSHfcqV8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=obJRf7cAs7G8EyRK1MW9uNOBVVo0T1t9IL2J2deh0iaWgDQcOEebe9Pc3IWedv3Suh49FlZ+8u065puOseIdhdXFOTVTN/5k5BJlT2YoS6h4la8watlCLu74FBnbcvqFPHWrVq07lfjVs+Fzy8nL/R3vyV0P0BcjgzfftNCgznY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qla1F7Df; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qla1F7Df"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso24645915e9.3
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 13:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792094769; x=1792699569; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dd8Vgfqw5fBEpKq9DzmBZr+ZmWeBjt5IlpJ/9R33P+o=;
        b=Qla1F7DfLHVT2Oe8pGk4o1DMRRNYCBH3Y7f4frRzZTq522ng4uL4PF4NtTrY4iSpWn
         oChZsYCDDr7St47k0KxSiN8Hev1jg33mrt0iHhYtB582mWdDAY35NL7vD1juiL8djSZV
         ARn/3aPHbpIB0EJV90a3O31YX/XAsj3so0n+KqmEV+m982Dfc+c0uJGrymChngtYhlgU
         hIO0FfKHRLQPXuzBW5mWm61BVq1V2rT3chl07gv6pFbwrLWJ1cHeLkoWyZEymLRpsb3V
         rWjNVgLNKaJStF7jG35eTBk1yFfoS8XAza30xRUB5SKROXHEnDZc77O2qJj/TNiXtNSu
         0dOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792094769; x=1792699569;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dd8Vgfqw5fBEpKq9DzmBZr+ZmWeBjt5IlpJ/9R33P+o=;
        b=XkkzTxiqToVtKTvAaQdumQXVaw/SFClhd2NBN4DnDzoUwo3BXZVJjX0hzCpTOPCbkM
         zfWoIvNJLTuOqk8N43b4D09emgWtcURFfADa9p8sW7xRRX68v1KGseJifixZ1U5MMolW
         g6xg9kZk8hRZRL96ajVq4MQgAdB6264BncQBVA7ec++Vm8+4j//2HbYf/iVloWH1GnhJ
         qwsSWLgXzcP64L+qwcFVKbbfVjv/hD6yg1oPdt3lYhwRGn9zlpJP0ackKkxBD8hwxG2V
         PovNV6aioV8EF/kb4H62WSqseo8yOra+oNHKlERIMkbR3aqQYj7OyjDW+jh+2L+uQzpn
         BWcA==
X-Forwarded-Encrypted: i=1; AKwUvBzquGlVV+H7XwRWDC+ID6i82+IpjTxPseBy1oVQtROuVZJJry/ruGwf3eSwE7eBs8jC9UCJLdg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIsRihSJPA6oukx5WVb0C2cwjN5C+mJZYikz2Qsjxlv9PIpo3E/
	HyrD/OUaZUxMex3CKQEDcGkwSnPvKjFkXJKqWSj5YoOo/vDzxu0Cti0R
X-Gm-Gg: AYBFou3gFDoYQ0o2wZe5USKaeyHB0lHE2GIOt/kE0IqA4rg4BacibnkS1C5CUtkWzLq
	EvIDa5P5HwVYLKt1ZJ+BlloT+gcvr2AACoi6/rTQBi10vDGiz1zm2IDSAhW0Z465SNyW2maSmkQ
	hKuyX2fssrJxLV79QK5Z+T7kKA/k/LDRtJtjuwIpUVcgnVzr/Hd0LyXUcthiRG4Z70cFcECZ/0i
	tVj9rohUm4rX51yhfkufokjkkoIE//80Ud9XPxjYXR/2uXTT24C44Ne4ThLfsADteTxyyTaL6eZ
	L68VUyETg5uVqaNCQxd7OWhuVmbF595R921OH7KbFecHJJagguLADoWPxidF9uwdyaQw6yaF071
	LuCVycQL8+yUhrm/0/7RDStmgITvALKILp8KVWu18qRTF0cKhCjSznP+iZVDdTeZh8vDR1g/7AH
	LqMSldqtWbxwl1iauzudwlVWX+tVv1wLwOUFTNCGrfmmm1AKPPgkKR3nHju7s63EKyV8esiQYbl
	f3g+PvVUg1Inxd2Ic+MRNYGrc27IoEU8j+roRySdIppgfbPlZZo5Q6UP3PFfgJWBN1q/621cPdb
	5FEnV+47EQjCbQv2tTHCSr7UZuDSJQN4yKq1/ALty9j9mQeJdr62PvqLhv7vgHbXOvrnZhpEF/u
	UBjWbfEFqjklN/1OR5Ey9e1ejnOl/jVw=
X-Received: by 2002:a05:600c:a016:b0:4a1:a44d:1d5 with SMTP id 5b1f17b1804b1-4a1a44d0221mr249515965e9.9.1792094769132;
        Thu, 15 Oct 2026 13:06:09 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c9a68c06sm1235745e9.3.2026.10.15.13.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 13:06:08 -0700 (PDT)
Date: Thu, 15 Oct 2026 22:06:06 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Dingisoul
 <dingiso.kernel@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] iio: gyro: mpu3050: add missing trigger cleanup on
 remove
Message-ID: <20261015220606.70c95a4d@systembl0wer>
In-Reply-To: <as4jIPWKMKIo5Di2@nsa>
References: <20261011-mpu3050-fix-v1-1-f55b0d138be4@gmail.com>
	<20261011191240.5a2ba4f7@systembl0wer>
	<as4jIPWKMKIo5Di2@nsa>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Oct 2026 13:30:32 +0100
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> On Sun, Oct 11, 2026 at 07:12:40PM +0200, Joshua Crofts wrote:
> > On Sun, 11 Oct 2026 17:53:01 +0200
> > Joshua Crofts <joshua.crofts1@gmail.com> wrote: =20
> > >  drivers/iio/gyro/mpu3050-core.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >  =20
> >=20
> > Sashiko review came back and the issue doesn't seem so
> > straight-forward. I'll probably introduce a local pointer
> > and then assign it to the mpu3050 data struct. =20
>=20
> Hmm the probe seems a mess of mixed devm with manual cleanup. Ideally we
> would move all of it managed resources (and that would fix the issue).
> Other than that, seems to me we have two things in play. First:
>=20
> if (irq) {
> 	ret =3D mpu3050_trigger_probe(indio_dev, irq);
> 	if (ret)
> 		dev_err(dev, "failed to register trigger\n");
> }
>=20
> Do we really want to ignore the error? I would say no...=20
> So, if we change the above to not ignore errors, we can assume that, on
> success, our trigger was registered. Which means that on the if (irq) at
> the errir patch we could unregister the trigger. Not that pretty but=20
> consistent with what we have :).

Ah well, I'm an idiot and pushed out a v2. This would make things
easier as the trigger would have been guaranteed to exist...

> If someone has the HW, moving this into devm would probably be the
> better approach (but even in that case, we might want the simple fix
> first for backporting).

I'd push the simple fix out, then move it to devm.

--=20
Kind regards,
Joshua Crofts
