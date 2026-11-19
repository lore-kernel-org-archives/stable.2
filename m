Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795094722;
	b=JQnHkB7k+p5KU+h5resJ74uCCXMrVeCCDvqfJg7db8nzLomMrKtkb9x1K0TMdWvURStg
	 0tWow1OBWW5pobEMIGI5Kxd26vnXbegVKh1hZaxACHy1gBXrBPPzu6DkpFcKy7X69wstm
	 6TpyuU25b04hJmZDP8RIOgPi4NuPDMmQFWhVPEKO//B1CCsY14sy5DXCjru20Jxv2MEto
	 bPtGQX+SAMIK4k2a5CegPS9bOdR6i2j03dTX6fRFHEXFE9g5bdsuUUy4qesprwgo6rz8F
	 PCXxb/dch6Fh6QBjbcu2ySu5A2om4ZRL4HOIJ9RMUYLMI855z6piZN9ppldpX5q7Yeg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795094722;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=sgmca7XuOnynXT3mQi31mFdatxGlHzSq89iOdzC/zQU=;
	b=YGUIgrJd7/j8c+MVVLsIyed1ydzW8K3BMNBM3jTayb4eL5gHMmPmN1WcpLDVNGTMwZdH
	 4Hb6yDTzm3SgePxhyhX5KCZO43j9QA4uadF4Lemi2VBUzt8znh0GrO1AI1MBhdr2yeKXS
	 6DvPJ3dKBUTcgTiqbX7o5XMZKWYRX1AX6WAeXAaVZn79IXf0Bgm/NbILICUMFsjuCl4el
	 VbUHEzW+EO315H1AEYVkrY/4W/w6c6nDHVu7fxRC4YzyhsFwtAqhUtMR9wYDqgAJbf7PX
	 8lpfmxqMUR1uySNLzji/NWygbE34nksE1tnKeUzsvOJr3RCQt4KDcT99otFKi0Q/D8w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YzH3FWyv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08D7606A33A
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 13:25:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D08D7606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YzH3FWyv
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-381f65e4e4bso3442201eec.0
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 05:25:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795094720; cv=none;
        d=google.com; s=arc-20260327;
        b=k/cokt1ANspBvoxstsMzbJWUn8YqB7fK9nm4ioZhS/AUNDxQosHO2qLxlMJ6HCJGT1
         J3NaNvIvpObAtCQcXe7gpj4eMlLYbzW413yE8W0DRzqvyyncsAs7LNDmjYBprp50NNfK
         oPFDzwlHLqxaIEv4UWO6kLpvO6Jozzh9+qBX/Qkpcpm0VIWyFH/rtcUCFpHOUTgkubIs
         Xl8RLQFA20YPZpp09r7fYnlQjXDOifNVHKPAm6VqYSgSE4gDlrAJWDq/1kJAopBXgjN/
         TryNvyEZjG6dXbeyoKCb6vAGqifWqhUvRBqsXKmT9a2Ms6ByiAP0Bj4oYGCJ+dnp8GzL
         Hf/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sgmca7XuOnynXT3mQi31mFdatxGlHzSq89iOdzC/zQU=;
        fh=f6Tn5Faj9q9bOTH56qyDU+7WTEpW+1kDEDViPj6xxJ8=;
        b=UQJYEvA/MnMATHwhXXJ74Osy0msZUaBi9Y4uELVLBOSZb58OMq2/SeIQb8BhLPjEsA
         HDeJdM4aGMVyDhDdEJ7UumLYQ6e488wy00P4bdkP85r1DRfIlVvFO0pJphTJb9aZaKTC
         xRvfdfoWPBSc37pCuKoQz4c5yHbueFO0GHGN0h/k2nwWqU/wLNdmldLPxL4bcI87ecuj
         kmyV8aumnEAhV9WotimgkPT3BQWvWTKjx2IKBVy5t5SDqDKRAc8wI2QljH54wheUFZb1
         gwKnBjXB+gfNiX42fNQxwyKq+E4+PudUfCY1xH4Iz2CZNVySipya9+4dJL5nx1bTL1Ve
         +0hQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795094720; x=1795699520; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sgmca7XuOnynXT3mQi31mFdatxGlHzSq89iOdzC/zQU=;
        b=YzH3FWyvCslA7vMobf7qLaUOeC6g2jhmXWuFZHf8ddwn1zqrbF+eDhUD3L1flLIfWj
         uFiD/sXUKtWs408RBoSYBWLnu/OiNRF6l8W4PRoqlonZaBGyZgdUmAHYbDBkqhwBE0bC
         PGnCWvbbAc37L1EEjR3CgynSKfKdQaG0/JNGMzin71maQ9X5IzXG3+eQaz7qovwv1xP9
         H7UgiubcQ4J4qOPdiuVB7moyvKtlIqSnKAFKM8BzXLrHLzy25rySwhSYCMrIQv8lweYI
         zy1MUKxBWTolou0eicamjUCAwTpzR6ET5YkE4gXHf9SU7kVepVDQ3+s6mPmDMNEoPANz
         lSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795094720; x=1795699520;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sgmca7XuOnynXT3mQi31mFdatxGlHzSq89iOdzC/zQU=;
        b=vP75mHxCN4u+6lmY0kT+DjvsnlfHf3oCTxYy0V3dVqGZOoPAPA4rfwvr8MAUIJQDmO
         kP7Y4Ew5MwGiBDWn5SB/TMeQpqGq/Oya7qsxR73J110Q2z1K75RecqcyIglrajxVAL0a
         w/+b+TZQIh/fr9ftstBQkKn+wbSJqO2niKIBOUtLv7GAdjzXJCKxgMEXThUQo+Kp3n/b
         fe1CJUdt364osmzqTSURTO99lhBrZJjqfY+8L2OSCVOH7XqRvOLdnS6ssdNzstjTJcAk
         xzhs1oGK8WBnKeEU/2a8gewYlZ+xTKmvuvaaRiKeLlNugoStIDeQaFotRz+ydLkYV/Dp
         dXUQ==
X-Forwarded-Encrypted: i=1; AL+hErGGOIWW5XSuMWgUPzdbEjz+zzV5/7ec518380mx1MwvuvhC/vRz4AaZ6UL20ngtbsrSX9fWaZE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9lDzXRRU9fW4ES640ssNScTOLj3aHx+vM7r+pYU2gH3CsaTm+4
	Sp/F82pFL9J4TFhh3XW7dtJYwck4IjGLWpdmXpFzpMddRH6flZ2o2KuPl6c6jbuATiJ52G/Y10+
	90n5LR1zR6pLqXu6mdebmsucQC0gHTLg=
X-Gm-Gg: AZFdTZffMlI1mQoovloGnHelLVxnnJQPNmQWKphII9kV06OF83YTMV0AFVHburn52L4
	f8as0q2Fab8smoxoXsOWgGIk+N2RzTUkwUDmTHEZyQ+VMv/vWQkRR0hOIdAJ67ifjGHSrYkj/sl
	H5AhlV9HFTbMOFxAENohvnPaZ4HxeeFMVsmipYEMp55AWF/n1da01yGEprV9E0enWdttgJAeSjG
	bzhXdW366auu1hk5arMuRCLCcMbHMLqUy0KlalmLt/K+swo16ruuwRFAjkgKyPcRX+ZtaQ/Z7Fp
	ydEe8yE0F1UwhsUoOFDwF4Fa362RyWa3ZMWjLMkJHyalnwCedskWDJ2OzScU3oHAwckPgn6mCIj
	UkQ+Ai6WAkJ7Lmkk9pO2vJkkJYXzFrzMiaAZgZDSRpLfoNJ6SGrlB9R/zpLz9RqsP65KKk1hNZr
	vAfFXIHN++7ehBFg==
X-Received: by 2002:a05:7301:4d0b:b0:369:f18f:3492 with SMTP id
 5a478bee46e88-38281b03d18mr6111471eec.35.1795094719830; Thu, 19 Nov 2026
 05:25:19 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119083959.1599898-1-hj351016@gmail.com> <2026111913-hulk-attempt-905f@gregkh>
In-Reply-To: <2026111913-hulk-attempt-905f@gregkh>
From: khj <hj351016@gmail.com>
Date: Thu, 19 Nov 2026 22:25:05 +0900
X-Gm-Features: Aa3M54ryYvpRhTygUp9ra3za2GRssMOntZpGUE4ymj0rS-2Zx00kGP6XapwnBzI
Message-ID: <CAGr5VtPbUdnx4UOMsikDkjVZ_kr+faLgB2suRm2XJ0oFjiTjEQ@mail.gmail.com>
Subject: Re: [PATCH] usb: usbtmc: reject a short READ_STATUS_BYTE control transfer
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guido Kiener <guido@kiener-muenchen.de>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

You're right, sorry for the noise..!

buffer[2] is only read when there's no interrupt-in endpoint, so
rejecting every short transfer would break the devices that get the
status byte from the notification instead. Dropping the patch, I don't
have the hardware to test a narrower fix.

Hyunjung

2026=EB=85=84 11=EC=9B=94 19=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 10:13,=
 Greg Kroah-Hartman
<gregkh@linuxfoundation.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Thu, Nov 19, 2026 at 05:39:59PM +0900, Hyunjung Ko wrote:
> > usbtmc_get_stb() asks the device for three bytes of the READ_STATUS_BYT=
E
> > response into a kmalloc()'d buffer and only checks that usb_control_msg=
()
> > did not fail:
> >
> >       buffer =3D kmalloc(8, GFP_KERNEL);
> >       ...
> >       rv =3D usb_control_msg(..., buffer, 0x03, USB_CTRL_GET_TIMEOUT);
> >       if (rv < 0)
> >               goto exit;
> >
> > usb_control_msg() returns the number of bytes actually transferred,
> > which a device is free to make shorter than the three that were
> > requested.  When the interface has no interrupt-in endpoint the status
> > byte is then taken straight from the third byte:
> >
> >       *stb =3D buffer[2];
> >
> > and the caller hands it to user space with put_user() from
> > USBTMC488_IOCTL_READ_STB and USBTMC_IOCTL_GET_SRQ_STB.  A device that
> > answers with one or two bytes - with the first byte set to
> > USBTMC_STATUS_SUCCESS so the status check passes - therefore leaks one
> > byte of uninitialised kmalloc memory to user space.  Both conditions ar=
e
> > under the device's control, since it also decides whether to expose an
> > interrupt-in endpoint.
> >
> > The same leak was fixed once before in this driver: usbtmc_ioctl_reques=
t()
> > bounds its copy_to_user() to the number of bytes usb_control_msg() repo=
rted
> > instead of the number requested.  usbtmc_get_stb() cannot be fixed that=
 way
> > because it reads a fixed offset, so reject the transfer unless all thre=
e
> > bytes arrived, matching what usbtmc488_ioctl_simple() already does for =
its
> > own one-byte request.
> >
> > The check is not limited to the branch that reads buffer[2]: buffer[0] =
is
> > consumed on both paths, so a short response leaves the status check its=
elf
> > reading uninitialised memory.  USBTMC-USB488 4.3.1 requires the three-b=
yte
> > response, so a device that sends fewer is not conforming either way.
> >
> > Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
> > Cc: stable@vger.kernel.org
>
> This is a "fun" one in that LLMs keep tripping over it, and they
> generate a patch that is usually wrong, like this one.
>
> Be very careful here, and test your changes with a real device please.
>
> thanks,
>
> greg k-h
