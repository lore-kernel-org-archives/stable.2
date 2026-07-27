Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BEE41A4EC
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 13:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785160789; cv=pass; b=nswexaJlpjivZRf+gkTUUKlNuoHO6MQi0D7xPtlDmMS3qR11GSCZmpEdoyj4DVWcQaB1nYwwD07buiUwEBffPPnc/s/Hdg/AdszIlaVtgBOgChb7lul22xLjm+JomWA8H5T0dQ9hizQB7kaO2XGMS+3qRQ8CyzJEKbcgUX/PnfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785160789; c=relaxed/simple;
	bh=IEpFdTbEDe4/3qS7nmuAXGPsai2eB8Cjwz1UUJ9YxOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MhLPrvIsHABkJKZbh5WNKjXlyKmiPS6RRT5G0f9FKaal5Pk+cmMPYjQOWJtY+mtcu0D/HE5uOdS2gCegiqP1qFpHZkWJVbSxIZUb3LvyzXuAoHzGPfRYy3tSfDHC95HV8oNYOS3YEhPm+JUe/6AjWah+FGQvVIzn4XrwZlEnsC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbMfWq6f; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbMfWq6f"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-664b05d408bso2155777d50.1
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 06:59:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785160787; cv=none;
        d=google.com; s=arc-20260327;
        b=nHYDDsjHapfGt3XMP4JndzbWpv9nlHwCkkooB8sfAQLMyfCf6rPeIHsXyB1bBp/6cf
         NWg+mFueBoUdavrY9k97bJ0vkbR5Wyzx/WNSNqB9acC47y4Vjay87adJr8gbNqpMEoKh
         vfTQsQGajyB3HPG+EjmkniizKp+z3CRY/ybopwEAqQptRQ7XUVZhK//EiNqtA/atQDD7
         vnjr8AxxzG/v4psG7JgdRAtZyfGVwwpu7ptEHUke1yeYb2dl2aH2FSmSsRvPbwlPl5b4
         QZ4AV8SFfw4nFJfF/121I8vo251dEGdf8D1M7ja9vZ9cCiiPgjmbiy+d1c2CSxvI37Pl
         qKhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=k1F8pOYech1vezxeER6um+vlnnIEvPDmg0g+Pyi2X6Q=;
        fh=WZ2HaZXWO8TwvIo/Exj9KZ3lKIx0En68MDLz0i61JB0=;
        b=RpROYPxxBbBxhEZK6ooOET2wZcwp3d1048Ol95vpwgomZo5hFR+knSc52a8zx1pZB6
         Uoy/TDFih8mnlPJZo4jt11kY+7fHBE8Dn803AV/l+dY/Fzp4mFzfK+Q8BhLZL1//UWCw
         bbIvJ9XVjeN+WtKlj+yYudJqhSmPmVS8VcSCBVdEYEJP+i/Uu2pt5xNf2COrJBTJJrfD
         rSx8bdLQxImHDaYbIkYjr+SLhTp800lmqkUB/OowRe7rG+Gg9LolKe/mY5apSdzHHr+9
         ES+yml5JMaOPbllYkDKyhAn+Xgj8Qp7uuQOaSqmrLqprwkwo0ZUMB5bKgnE/UfQm5Zqy
         0Z1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785160787; x=1785765587; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k1F8pOYech1vezxeER6um+vlnnIEvPDmg0g+Pyi2X6Q=;
        b=cbMfWq6ffw9hAUO9kjeUxNXJBqJNg2m7U6jNa4Bk33CMb9cQaXPxIAJ70klgmdDBjj
         wJqCRz/nTM31b3YOriEAiCaB5VN3KpErQcZJl43oLC6O3BFrsx8G5sOe8zclO+rLkThA
         7Vq0S9uv4HwdmZqVti2xoRAtqRYmudvT+5hPbk53/HvhJtxivmfgmVJFuEmpiCmx/7lY
         Q4L3TADiE5f5dLQlQ5RUOJt+EDtxwkL0Lp1h1arMvekT5KwlEUsLhL8M4BEub7GZya8s
         SRGLtSPz2f1GbMOSzJMrSkzYg9u9zCrLFcXKcJrQsAJ8NajduE2+9zOgbIqlleS13E89
         3x2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785160787; x=1785765587;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=k1F8pOYech1vezxeER6um+vlnnIEvPDmg0g+Pyi2X6Q=;
        b=nXFUrUt2liwvs2i2vjC5aKbfnhJ6XgasvQm9/ubJhZGa+sA182uYKTtP6C7OKH0nj9
         HQF0EaPQDX0r4tEe7JVmSG6pN7PIQ12LNk2q6/FyQ1Vrfzh1v81ZSpwZ3htkEgX364VW
         NaPdaqXVBfkStZfg7ol4AP2bj6pUbOT4ntC/cD+wDIRGqHTGeIxSdv+OcOBwxK6zt6zv
         HbjnvIoQBENzIywts3JA3wqhTGbzZjCZn8XOTyNfK++Vx9c/ywDeDBS+l8AObKq0nFT+
         2D6jv6E0BRIf+1uz4WIJrQbosG/wspF9mV7W3ZYBSWXr36/iLazBafnCkyPgSPMORrfF
         hVAw==
X-Forwarded-Encrypted: i=1; AHgh+RpyeFPt0iLcpoXlnXhRi7qG6YXIWBKatzkrqc2p7XOcKcsXi+J+Sl3zdNvL3bdTe82/BPhqg8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcSDh6BlF6K1lKEm/RKpnprCMOXev8P7/+ZsnhgEmSsEeN7f0s
	2R/HjoKcTGKR505f+RKoI5czwLJlyKS6KZ6PwEmgNrPT5igZmLt5UqCyS+l5pRVnvCARy9N5lsA
	GanHNmXVZNzsLNbxRcitdvD/1Dbxd480=
X-Gm-Gg: AR+sD12svNQDaD06QMMwETm2p70qAsT+J5v/9tVLD3js5nWY0LWPn4TygeKeo8hYagW
	QIFUFewYRg4Up3qQb/kbjenDu1qEvVytTGLHg7uzl6Un5a6VN+ob4vMqj+Un7ER4WDH5mRswNwH
	eNXmt7Mu2TsGdDnyuq1SjLsQ/JtspybpUTv4HRHoWNctoZ/jp8t/sJCIo/ptZCx4HA6szoOtqNy
	6ZdkKdzO/I/+GtojrPZatXGExRpV/UrJpm77SvmUh6OjZb7GJR7uvo3AxOZwTw=
X-Received: by 2002:a05:690e:4093:b0:667:b7f0:e712 with SMTP id
 956f58d0204a3-668c7c0edc3mr3032347d50.76.1785160786752; Mon, 27 Jul 2026
 06:59:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624013603.1184198-1-shaoyang@uniontech.com> <20260727070047.328913-1-shaoyang@uniontech.com>
In-Reply-To: <20260727070047.328913-1-shaoyang@uniontech.com>
From: Marko Kohtala <marko.kohtala@gmail.com>
Date: Mon, 27 Jul 2026 16:59:35 +0300
X-Gm-Features: AUfX_mw-_rAEGSkuYEioYmQG6OzSUR-Ccvf7MoyY1qrCF5sM6c9pneaMyioBFxc
Message-ID: <CAJ0yFawVP15r84VyU2gCDW3q0HbzBSa6S2AW8qRGSxcfguzMcg@mail.gmail.com>
Subject: Re: [PATCH] parport: fix inverted daisy selection result check
To: Yang Shao <shaoyang@uniontech.com>
Cc: akpm@osdl.org, kernel@uniontech.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, sudipm.mukherjee@gmail.com, 
	linux-parport@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi.

My guess from this 20 year old commit 7c9cc3be1094 of mine is that I
had thought the response nError signal was read at the wrong time. The
return value was not intended to change when it was read at the
correct time, but it was inverted to keep it the same.

I don't have the IEEE 1284 specifications and datasheet available.
Here is what I think is happening: The parport_frob_control
PARPORT_CONTROL_STROBE bit is inverted into the bus signal. The
parport_read_status PARPORT_STATUS_ERROR bit is not inverted and shows
directly the bus signal. After the wake up sequence of aa, 55, 00, ff,
the PARPORT_STATUS_ERROR is verified to be 1. Again, after the 0x87 it
is verified to be 1. After the nStrobe signal goes low, the nError is
read for acknowledgement while nStrobe is still low. The command is
most likely acknowledged with a different PARPORT_STATUS_ERROR value
of 0, so the return value of parport_daisy_select is now 1 for a
success. I probably had a setup where parport_daisy_select had
returned PARPORT_STATUS_ERROR in the same situation due to reading the
bit after nStrobe was back up.

I only had one daisy chain device. It is possible the return value of
parport_daisy_select was changed and I did not notice the difference.

I think one could consider returning the parport_daisy_select return
value to the original value rather than spread the change further.
It's been like this for 20 years, so there could be some other work
depending on this.

I see the linux-parport@lists.infradead.org is not in the recipients.
They might have an opinion on this.

Marko


ma 27.7.2026 klo 10.01 Yang Shao (shaoyang@uniontech.com) kirjoitti:
>
> parport_daisy_select() returns a boolean success result. It returns 1
> when the requested daisy-chain device acknowledges the CPP selection
> command and 0 otherwise.
>
> Commit 7c9cc3be1094 ("[PATCH] parport: parport_daisy_select return
> value fix") changed the helper from returning the raw
> PARPORT_STATUS_ERROR bit to returning its logical negation. Selection
> success therefore changed from a zero return value to a nonzero return
> value, but parport_claim() retained the old zero-is-success test.
>
> As a result, a successful selection does not update port->daisy, while
> an unsuccessful selection can be recorded as the currently selected
> daisy address. parport_open() later checks port->daisy to determine
> whether the requested device was successfully selected, so this can
> reject an existing device or accept a device address that was not
> selected.
>
> Test the return value directly and update port->daisy only after a
> successful selection.
>
> Fixes: 7c9cc3be1094 ("[PATCH] parport: parport_daisy_select return value fix")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yang Shao <shaoyang@uniontech.com>
> ---
>  drivers/parport/share.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/parport/share.c b/drivers/parport/share.c
> index c4c5869..2888005 100644
> --- a/drivers/parport/share.c
> +++ b/drivers/parport/share.c
> @@ -1025,8 +1025,8 @@ int parport_claim(struct pardevice *dev)
>         /* If it's a daisy chain device, select it. */
>         if (dev->daisy >= 0) {
>                 /* This could be lazier. */
> -               if (!parport_daisy_select(port, dev->daisy,
> -                                          IEEE1284_MODE_COMPAT))
> +               if (parport_daisy_select(port, dev->daisy,
> +                                        IEEE1284_MODE_COMPAT))
>                         port->daisy = dev->daisy;
>         }
>  #endif /* IEEE1284.3 support */
> --
> 2.47.3
>
