Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795536620;
	b=ThJpRW5At9ExrQeR8Hjq2N2wcGN4D0iuPirI1RNOZu7CZJehN1Q/I4nRjnZ5+WN1YHNS
	 hkwEqXrdlD8ecMIvpx+IyVERHJS/BoSi+RYnRX75OoI4mC/bToCCuzOTYX2c/UiWQWv9A
	 R8c9INhbkQmUpJv89ur2nnW0MQArNPfsWhpagdkt7TlkCSiYSARgPWBhAZlx6zDxQFFTq
	 csNcL0M7B3G9CVleW+lV+6GMPqRbalHNklD4q08CdEAOsMFvi4lTleIsNUwUcs8/oHEU8
	 gQulezI0/4R/5c0mb3kyyjYQXWuOkxuz1L2y5f/WnkCS3rVeKLm0QB70Kiuh43+2I7w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795536620;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=HJt4JMv5FVP1qu+wQIQwqnzbRKFhP11tEo/XVFuWAeE=;
	b=lAVr+3Ujh96aF7u0UrNPs4+KtVPWVHWqqaOwWWZtm/5QhnjaV3dmV2Q5D2sTPSTRFU7Q
	 BH1me4MDhqtjl4TPp7MP/gH3Yc/OdvLz/uU1yuk2iFPejT5ervyJwB/IhHD6yrmhj7o2z
	 gJK8+kDzYO3/st1NfKK0nPizBXqa1+YYy4opE2pfrGWC8NwqhUDo8ypUMga9S+7PZmHzp
	 yF29eSsD2Usx7nhkKlr4rae1vHgPQEFhk4+JYUheNKcp93fVBfeHNWtoK9KL6aIb5KSBW
	 94ELz37vKeuZYVVOJmUCSEZQ8rENaHaG+7uSRjQiz5FhMi3zJPA7Tu5z2VXb5wF3YLg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Izs0kVUG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.43
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FE9606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 16:10:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77FE9606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Izs0kVUG
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-77bf892b496so1662305137.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 08:10:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795536619; cv=none;
        d=google.com; s=arc-20260327;
        b=LnBbx0z999q6oAVZfhOix71saiffurb6hMKmDlGstmrZLwSxXHFJY6Ia63Nsp3MWC8
         uPZiIa+dVc1bCdECjsB/XmKHNUPRhZc2kqe6KyyGhT7pyLHzW8ECwWZc7KY17eWfevqr
         0qMZFbVoMjI8rrTlQScEiMeIqQjIbFvQRivzcThQpX2x2KGPSXSitjr/1/tRDk3Ib/dK
         R4E9jPehOYyW2XwGQur2+l1wL7GlQlU/bl/ycDeHS7wHSDBXg1clWAY6s+hv+eQEXiVk
         VjPPpyhTJjj2FSyZfRNdKWeqBaSAl05vB1FZ37MsMwy2LPbX9T1mf3jhofL8fcaAUcvW
         Gv5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HJt4JMv5FVP1qu+wQIQwqnzbRKFhP11tEo/XVFuWAeE=;
        fh=ctBx5OER603RimLQQwT3XxIJSEpFcqcMRr+nZtj56do=;
        b=XfyxCUT3Kd6OK00hQpZcRK8ioMB6avPlxLjKvztXAs3jzMQZ+B/thG54rgi02plduG
         BFJxJcv80a3y4UzhTRhYNYcBVaoA+OG0MVc2Tc/xPi0W3ErFftXQ0kVN7d1T7hWekC6H
         4uVy/QTSh9O7o6EO887Ugi6IKJPVgToE5I8DLw9PDICCGEBF1UxCpB3M+ntd5xdrZwaN
         wRlliww0Q/9RaUOLO3Uc7eS+GFoMGAuHmQVMYwtskOFbWesigftWUz1K2ZO7Xnu3AinW
         7mm0F7dWzUM8zgCthvS8AfyVamD6UFHlXqqb6dub09Pqwcg9uRE2maOyBJ9qSVMaaoxF
         G0iw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795536619; x=1796141419; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HJt4JMv5FVP1qu+wQIQwqnzbRKFhP11tEo/XVFuWAeE=;
        b=Izs0kVUGNyHF84e4n2Ea0lhHR7xnboALjopfciBG2KPRUxuoXTimpltEqJU/1v+vYU
         oyN61+xrJo2cIWhKym/ntayfPLHTrcXoScUFdVLzDYIlHWSyZ6mT+jGozVv9TEJ/h+h3
         2fjwaW2bUrMhMVWJsJI6H0CH0rIGBdmbczKiamU4cWSF9CPm3nnk9iv2IvisiRS3zNnq
         ls0vo4TF8ytbfPe85D7Q5vuswBYIQ2OU/qudDl6IEMQxqh8Pk9hNNsQU459ErGsDLgmI
         nXrEgwltEXCbiFkDY92k68d52oGYjMUZy2YjuB+PqE/zwgS2PMlW3yE+Rej4vT2PpyNu
         eXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795536619; x=1796141419;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HJt4JMv5FVP1qu+wQIQwqnzbRKFhP11tEo/XVFuWAeE=;
        b=c+MWCaI+uab74DMy1O1g/RBdemtJ5rk0zXVVWmWpT3wP3WrasBo6o4TosW37xigwfB
         7vw80FcYRU4ugXiMM2SVzgsaxCPMuHZYVRzPvWyIBSCh5kp5s3PRbHkrqRMkQ4fKTnfN
         uUOUuerBb5I5Tx3hqMi3Se3puRejkm1lhTPSpN/+fZUxWERIp+/7pg/ozR9LL0L5GItC
         z/PCzSaBsFyQh1AKIlhM5fQDog9p7CIwYf2ecy22aOkkpn8Tr8NCHUKPsaW6Ioa5rZhu
         1jeOSORUjGXygGmHN17G6+W6ZpClqrZLztbbAsu+IfpHOihjtP8GMpr+8fXt/Dn/EdbI
         bkNg==
X-Forwarded-Encrypted: i=1; AL+hErEhzL126iq5+wQIUx4M4oe7NWurv+bNddFGvxF9IQlAuutRTkei3zf36YgLP22PVyJ/VNkNN70=@vger.kernel.org
X-Gm-Message-State: APuU4Z8cP9qCGOTCk6dJ7P60pAGyZNX/FoZjs9QSSa782szYTk0tGdtx
	NqKnv9Kg7BglAdUvIqbf8nlu8CxL59Nwb7nLLd61NdTtwco3r/qG9PHuMhVJPiVwxONIcEyfrPb
	UwvNarEiw9fmsmsnDQl030tB9ibNKfag=
X-Gm-Gg: AZFdTZdE4qhoq4RcXxnTCq1JfVN6fq40+xyksoEnXDE5toCjUBy/CfbsR0MulryCHyR
	c+cnVj6f9salQL165MhA1HHT8RJygnChZAAPRImzmprK9DH9/KHSlLutQWgDRedlF+fX2m6FdYy
	B9xHRhFEET965v3Bc+vmjIyaiKOJ7JbXLzr50vEn3blQO8nKVjNWTYh4+LUY3ypeGnNxDta4qU/
	rXz/UmGt+8OaoxM89C2iXCEC5H8sMqcKg+TwtLppDqDjokBCQ8ja/IomoFfXkqAy4TwK1T4qP94
	btDBkDo5NUB4V3+2Vwec2cegzMq/hWV6tp/fmYNeEvjlN7SCkB8Yl+vuD4XmqTLdb0OsXSace4H
	+wT1Z8qc7tFP+DMwyi2DhGpGgB75nMvf9sIonUZ6iyA9pQGEm1xfEvDedScIMjT8AR7WIFkE9xu
	PKtbCdbDWfABYvBux3Srs8kSr4raPcmRHBfxaJ2QEj8i4dyJ0we459VWuzGuM1ZwKKxFR1uaHGu
	jJ9NAJKw1GXKJuOkxlUnJLxd3/yE/a84fUzOu7iqHu/r0yOubE=
X-Received: by 2002:a05:6102:442a:b0:7d0:5688:f4f3 with SMTP id
 ada2fe7eead31-7d72b368b6amr6483489137.1.1795536619304; Tue, 24 Nov 2026
 08:10:19 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261122-submit-rawnand-operation-locking-v1-v2-0-030bc867f0c7@gmail.com>
 <20261122-submit-rawnand-operation-locking-v1-v2-1-030bc867f0c7@gmail.com> <87a4mys2ia.fsf@bootlin.com>
In-Reply-To: <87a4mys2ia.fsf@bootlin.com>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 24 Nov 2026 09:10:06 -0700
X-Gm-Features: Aa3M54pmQwhIMEHjbM07Pzq4IWONoMnEjbuJLtRAcRbDWaiND34wvm_s5GYEEOU
Message-ID: <CADvTj4q79XR9ymtzBHr7TUc+TnuoB2R-sUa+BWOCS1u7UTEUkA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mtd: rawnand: macronix: serialize OTP access with
 NAND operations
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>, Boris Brezillon <bbrezillon@kernel.org>, 
	Kyle Roeschley <kyle.roeschley@ni.com>, linux-mtd@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 7:55=E2=80=AFAM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
>
>
> > OTP I/O can also run while the chip is suspended.
>
> Really? Where does that come from?

I was referring to chip->suspended in nand_base.c. nand_suspend() sets
that flag even when the chip has no suspend hook. Normal NAND I/O waits
for resume in nand_get_device(), but MTD calls the Macronix user-OTP
read and write callbacks directly, bypassing that check.

I haven't observed OTP I/O during system suspend. Userspace is normally
frozen before device suspend, and the Macronix driver doesn't install
its deep-power-down hook on the MX30LFxG18AC parts.

>
> [...]
>
> > --- a/drivers/mtd/nand/raw/nand_base.c
> > +++ b/drivers/mtd/nand/raw/nand_base.c
> > @@ -207,7 +207,7 @@ EXPORT_SYMBOL_GPL(nand_deselect_target);
> >   *
> >   * Release chip lock and wake up anyone waiting on the device.
> >   */
> > -static void nand_release_device(struct nand_chip *chip)
> > +void nand_release_device(struct nand_chip *chip)
>
> You export a core helper...
>
> >  {
> >       /* Release the controller and the chip */
> >       mutex_unlock(&chip->controller->lock);
> > @@ -336,7 +336,7 @@ static int nand_isbad_bbm(struct nand_chip *chip, l=
off_t ofs)
> >   *
> >   * Lock the device and its controller for exclusive access
> >   */
> > -static void nand_get_device(struct nand_chip *chip)
> > +void nand_get_device(struct nand_chip *chip)
> >  {
> >       /* Wait until the device is resumed. */
> >       while (1) {
> > diff --git a/drivers/mtd/nand/raw/nand_macronix.c b/drivers/mtd/nand/ra=
w/nand_macronix.c
> > index 16847f28b19d..d7f5a9e7c240 100644
> > --- a/drivers/mtd/nand/raw/nand_macronix.c
> > +++ b/drivers/mtd/nand/raw/nand_macronix.c
> > @@ -380,6 +380,7 @@ static int __macronix_30lfxg18ac_rw_otp(struct mtd_=
info *mtd,
> >       int ret, cleanup_ret;
> >
> >       nand =3D mtd_to_nand(mtd);
> > +     nand_get_device(nand);
>
> ...and you use it across the entire OTP operation...

The race doesn't require suspend: an ordinary page read on the same
chip can issue its command after the OTP callback has enabled OTP mode
and before it restores normal mode. Locking each command separately
would still leave that window open.

>
> >       nand_select_target(nand, 0);
> >
> >       ret =3D macronix_30lfxg18ac_otp_enable(nand);
> > @@ -426,6 +427,7 @@ static int __macronix_30lfxg18ac_rw_otp(struct mtd_=
info *mtd,
> >                       write ? "write" : "read");
> >
> >       nand_deselect_target(nand);
> > +     nand_release_device(nand);
> >
> >       return ret ? ret : cleanup_ret;
> >  }
>
> ...and in the commit log you mention:
>
> > Make the existing NAND serialization helpers available within the raw
> > NAND core and hold them across the entire OTP transaction
>
> Why are you doing the serialization in one vendor driver then? Aren't
> all the vendors affected by the exact same issue? Why isn't taking the
> lock once for all in the core a better idea?

Macronix is the only in-tree raw NAND manufacturer that installs MTD
user-OTP read and write callbacks. Both use the same helper, so taking
the locks there covers both paths without changing the interface.

A core wrapper could take the chip and controller locks around a
manufacturer's OTP callback, much as nand_lock() does for
chip->ops.lock_area. That would give future implementations the same
locking, but it would mean adding raw NAND OTP hooks where MTD currently
calls the one implementation directly. Is that the approach you had in
mind?

>
> Miqu=C3=A8l
