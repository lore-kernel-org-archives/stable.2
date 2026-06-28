Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490112C029D
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 16:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782664307; cv=pass; b=d4R5pw/+PbZOzeg6lHJVBCqPJ+qOEKenXgQy3d6NWIwZqJnRbPAEw1MmF6jPN/+KAg7OOGEClAO3m7BNZlsnTi11dlZe1X5haTwSBb1DuSkB5mN7PtiVP+ftSxomxPZbreyRxBLD5E/oN9J9b70TwQVyPrbie+E0jkmVehr4uc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782664307; c=relaxed/simple;
	bh=5l1bZXAfKUSX0ItYfzxbNxOUmUVQ5YgkicP6K61SLbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H+tlbpDM+eXYzA+tUiKXmjRvdJkBIHOAALKG9LuzBO2lxnfGKUFqLVFjmhCAIKH6Cpmsn2Ji8+RMlQvlcE6E9VL0fBZyFB2xKHnbbmDYQiQL4q0suaIyl38X7py8XBOWxpXdFsQcGXB8pIUDW5YqybgLjyGPpz1iDigtuDCOYgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bd1f3474; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bd1f3474"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-697cee2eb6dso2433830a12.0
        for <stable@vger.kernel.org>; Sun, 28 Jun 2026 09:31:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782664305; cv=none;
        d=google.com; s=arc-20260327;
        b=d38+N9W7QDFUONO0ftvjiGoYRoIuR/0zMWLTwHNq+MGR756vG9lVpYJG9Z8LIXBrfN
         WGqFm6YCYdS8V1V2b+X4lOATDtumQptNFvCQhmXDiFZQlX4BOrvhW/r7QJFCPbmsF5fy
         WvNZTDhmfHClbBwT9Ecw7wR4aUEp/+98AzfezSgQC1L1pPsA37T76Ib7/81x0GFK/TfR
         tHHlHK6eG9OcRredCVlVQS0YY6tXpJNVN+8ct4nmUnrDSTwkF/ZRBLy6+krMxnG4Sgmf
         zNB4hcnNCQvkcwEVQ1F/M64Wqbo8S78ksEtoxKpVnhAssqKujTbTgxfv/aOeNdQN0atz
         bSdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NwIs/NzgKCDhYw7/WT2FuLFglQDbPL5SvJrcFuoFlVM=;
        fh=YX7IeCcUnKHW+UvKrv+m3o/4CvPwcotqRxvUXyHn1/I=;
        b=gA8ThP2cOTpTjeLA4WxVNXmkwRBNyFygYnH0LWYJrtIoeOQr4TjGL+ZsO1opIAQUuh
         DD2kawQ0fT2roo4uQxxmKxIHrNOEWp51KuDl5S/Sb0/KsvNM1S/eL/nYRZAUklei8F39
         Pd9TBhXrC07Frsfes0xt3MZ3+nV/S76dYsZMI8pjoakWD6iyUKiduaX++Qnr2WCOsW9Z
         dvcwINT65hxw5jafrKQmS/QHoj1swRuIoBnBbYLcj8Vv+N/50i65TsuM5la1q5EM8s+W
         PApEIkMfsN7RxlI7SGCGZP9qbWJ6COqh31WpLIqZBg4DnKWKsAgwQUwAC3XDuqHTXAZC
         3Pcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782664305; x=1783269105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwIs/NzgKCDhYw7/WT2FuLFglQDbPL5SvJrcFuoFlVM=;
        b=Bd1f34740muALFdIz0yfIB/KxWR1AnpECIewflPt3T1dsz2t1bLid8NECOx0395x/D
         anFROMa8CLdpUb6n8t84M9iM4mfDZEQwTCICAg/BXfbtUhu0rLIzO7MDY+wpdqAunjRc
         g3zFzoCXBOfV/F5gj8tGIOkYSG8XD0+2e0ttxEi7GeHVea9V8Gi6ugtS+hX0NgOpWhd9
         ueVIdMq+ElqnLmoqbMxL+P3qqvuRon5zvO8PviEwOAg8hn7GUy5AoVolHlOkLCfDN4xM
         eIoBqmkNiHC/1c1Syy0Mx8Y8+WcK9l5vnUqwBsQBtxSSPfgWA2wPAvJ6Hbe/Q2meYg1g
         RFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782664305; x=1783269105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NwIs/NzgKCDhYw7/WT2FuLFglQDbPL5SvJrcFuoFlVM=;
        b=F3gTyiRFd9C8Dcexypt4x1BKqlLytzHddJhdjLEAR1cSxwlWB1HAIQEkwQkpLw5Zu6
         4/H52cOew2H1TMeYszzRfJUn/RGZBQnWwQ/SjD4Lu2mL8zeqbNcc3zn/V/4L2EwDm/Od
         2x7wlNNKH/swjTwr06buDvjFwr2WGwND/cNN+ypG74IsnyNRWbtOM4VkeOMJPSqbZAom
         IXyGeXb4vJ3ZlvYgFauK5ymMnlMQNG2vj/RhvHCBJfruw8dVy5akuVGbogntK768AtkU
         0t+O4YYVYNG7o8zYMX3QSlU8A0RoIkxSihZFESz2pcOJcjau9fFZkPveLJTXKAivNHDu
         RFKg==
X-Forwarded-Encrypted: i=1; AHgh+Rr56KAmxBZqLCr9TkVhqAeKGLewOzOHRFJNMore2h5+HxUS5JOQurxJG4vh7MDm+gZBmEwfBFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZvrtzfhYwY0Q42Z7VHDqiloMGabKmbgTAZ8P+8obTiVmt8mow
	IlOBRD6ZjoRVWJJGnlx66qW3S/jiQtofpjNTKrBxnb1roEvn4mmk+J36GnpIQO+edxJ49cLRcS2
	kTYQ2scJv9xKMReX7IBiut6rEOuIuucQ=
X-Gm-Gg: AfdE7cmXQiZ3T96ZgcWJWYxHMrZSpXiqymLmlhjVeZ898R+BWLKdkpQuv5iGJGuWqZD
	cDxfxrmtAvuyZ63ngdCLWDczwi6hsVCszX0Sx1wY4iM/v2rwkDu8EA+fuVA5kz3FiLuAeQ+r73T
	l/DxhNFPpDH+b1rkz3IyTKB3VJdjgGaYU6mOjQkzG2VMCGBm2AO9jewmrQnVg45zWz0zpFY9ScG
	VgmdyL7RpsppGct2ch4i0UFFEwxMtw5hdkSyOFSWm3/D1cc24OG0CPkTYEm1JhvEe1lAyTt
X-Received: by 2002:a17:907:3c8b:b0:c12:f84:85d4 with SMTP id
 a640c23a62f3a-c120f8487bamr640300966b.24.1782664304274; Sun, 28 Jun 2026
 09:31:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623161035.5792-1-nikhilsolanke5@gmail.com>
 <567e8866-4308-4e5f-819c-fe778dbf74f8@rowland.harvard.edu>
 <CAFgddhJk0EYG71fnKdio=RHC-cH+JmL-EZ7-oVD-LdHoa2TBSA@mail.gmail.com>
 <5159fd69-dddf-4073-a8e7-95fa77de0b7f@rowland.harvard.edu>
 <CAFgddhJ2HeJ=oTBX_axMJcgJq7GXH9abe+LH+x9NGekGO4BMyw@mail.gmail.com>
 <eb0dfd45-91c5-49ba-a297-b183dbc52c8c@rowland.harvard.edu>
 <CAFgddhLZ9SuOzG_6mW09j9aDkCp6TedpNkzJ6TUD+DnR3TDLKA@mail.gmail.com> <02060df3-b8c5-4a86-b3ab-3a28eea8a562@rowland.harvard.edu>
In-Reply-To: <02060df3-b8c5-4a86-b3ab-3a28eea8a562@rowland.harvard.edu>
From: Nikhil Solanke <nikhilsolanke5@gmail.com>
Date: Sun, 28 Jun 2026 22:01:32 +0530
X-Gm-Features: AVVi8CciSyj9HcmsKDyCiGg7VrCDEm8PTgxDVOrwRIGUvZ81AFhzla4U4iZ5FyQ
Message-ID: <CAFgddh+dEgtJf=3rL_48x5aQx7q3FH20CAw-50J32JOJCYdtMQ@mail.gmail.com>
Subject: Re: [PATCH v2] usbcore: Add quirk for 255-bytes initial config read
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb@vger.kernel.org, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, michal.pecio@gmail.com, stable@vger.kernel.org, 
	corbet@lwn.net, skhan@linuxfoundation.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 28 Jun 2026 at 19:25, Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Sun, Jun 28, 2026 at 11:53:09AM +0530, Nikhil Solanke wrote:
> > I need some help with the USB_QUIRK_DELAY_INIT part. I can't figure
> > out how to make it properly work with my patch because of the
> > following reasons:
> >
> > 1. I don't want to move it to the top because, from my pov, there must
> > have been some reason for placing that quirk where it is now. so i
> > don't want to mess with it.
> >
> > 2. Regarding my idea of adding a condition =E2=80=94 so that it doesn't=
 change
> > the behavior when the quirk isn't set =E2=80=94 if the full configurati=
on set
> > exceeds 255 bytes, we would have to issue a 2nd request. In this case
> > the existing behavior would be more justified.
> >
> > So, I'm a bit confused about how to implement this properly. Adding
> > yet another condition to fix the second case doesn't feel right to me.
> > It would look unnecessarily complicated. I would appreciate a bit of
> > help and advice.
>
> If the 255-byte quirk flag isn't set, do the delay before the second
> transfer just as it is now.
>
> If the 255-byte quirk flag is set, do the delay before the first
> transfer.  If a second transfer is needed, you can do a second delay
> before it or not -- I suspect it doesn't matter.  If you want to be
> safe, add the second delay.
>
> Alan Stern

Ok thanks! Just to make sure, because the change I will introduce
won't affect any existing behavior, these changes (relating to
DELAY_INIT quirk) won't belong in a new patch, right?

Thanks,
Nikhil Solanke
