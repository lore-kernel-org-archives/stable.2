Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6E735B632
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 14:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782658248; cv=none; b=s6Xn35rWRxAhxClZuRKfr+35U7Kz4gcPf9pqtGYrzgvmji3WDYM56tLY25zqCHD/4VYX0hd0kJhjbsoXbH37+HS9djDVgKcHUXfn+3IeSmpwH9F+UMT6zCmZL+rEEhTWmgcBNLVaxmiF37j8QBZR0dBAdpPRSQtuqxbP1p9B/78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782658248; c=relaxed/simple;
	bh=4sy1Y4WR9ugVm1F65RWh7OvYWb4yYk3Tn9QjzRV+Rq0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cbVCOi2g2pBbZRP/VXCnH5grLgA1I0YP4hAL/DsmqfOJZLdm7AaCEw4NvRcpPXvUzK6Z/uRcq6tmMbhgJ/BX5yKbsoFjtWO7kG+ECzl+9Ek3JF4Sgip2bvZipI2WRGGaiyg3k+XAf74FzMs3hmiGHeuq3Y5+0uAWY8pvb75vfPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXqjuEyi; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXqjuEyi"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493a54b80a5so10104345e9.2
        for <stable@vger.kernel.org>; Sun, 28 Jun 2026 07:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782658246; x=1783263046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIbIf43pbwX/hQV/fKrmKMDT2zLMO167rrGvyP3bRww=;
        b=dXqjuEyidrp8mZ7tBLHJkteW8ltO3ZFVT6Z64dVPHZAewV+vI2mrFfevHD/nNjwJK7
         qzvOMwGg172+ZjbOWMJmObKTr5zj4ku3DecV0wl+4jXzqakEqB4HfAuiKv9hy3+a0dvl
         3Wjehu1VSLFFtkR5P3405ewO9UY67z/Qm8wfsIlS1w0QxdeO05z659n2b+A+MEvGhzvd
         rJy/wMxcZjUzZWADTbjaRfJ/tVTT/AiQ4vo7k12RnSaKDyBcRAkEdLzd6UJQ7wcMz4cD
         RJpKEu3KK17Tia8rkPLv2PpZ1D8HvpSZotAPk6ok5+fP2RziW1+/ektnkFK6ga5xE56C
         s5Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782658246; x=1783263046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DIbIf43pbwX/hQV/fKrmKMDT2zLMO167rrGvyP3bRww=;
        b=O6/bJ8yDIImpcVlGN1RZnGnaIpx2A4aK+yvzhWOlijRe1i34CVRUjXZv/J3/7wY50O
         Hc0+nBxsYLiSy8AYmvlgi79+OGZ2gxPNVltC/eAWZ9hcVOhGJex+p6PvBvrZ0XohFLtt
         +l+tRVbeIx+MUp/oNzjT4mX4qaEGZNg3Hj5cJLDIUJjodVTdjJeHc101OhzCPVHM7i2B
         2BkO+gTKEeCAxpX1pubthsR3+Q43S9Hq5xmApghuhiXyMXOlgzHnVrAbQZV34nUrUNUO
         PDydnXpjwqmW3LrgG8ikH0LcBPGYHanZR42ZapZbmI++alGjHARzCYkL+6/PG8icffr+
         PPQA==
X-Forwarded-Encrypted: i=1; AFNElJ+BaQJ0ulxzSXS+8yR3wpasHzcuOMupaPKvm9oZtNQ9YVDKEKYkRrV5U9LK4x68TZcSX/6XfBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJqSItTYnd+5EpgAeB1J/StQiE3KSPe0JHpQP1EA0cmCsxb03O
	qagoTYeRwEVi72Z7Iia9du/4o7YZ6YYgHEsX0AMOy4Poq5X0IpDiaH0Q
X-Gm-Gg: AfdE7cn1UCPMHLr+7ARyK5lSPaCOYT87HVn+0JpO1sKQV93u78/rIKqT3H+3j46TypD
	GJ1tgndGrIf5hTBbL1heJcU53zGhx4QcTTvtf4zASW0248rNK3UuQS9royM88pcqGTG3CZq0h+r
	ZOWkx8IoJ/lOa+uNvk5Nq8daeyfsCNdbgek1LhaUxXiJyyQpvRZxaQRe8G+4m4vVkk8QtrMDooF
	1TsVtKLbTWr5IIHGs7KNBfVl4ekyETgXULoSP10eIwA8NxdUN3YiUGV/++LVvM1y93FD6iZb7UU
	atWAoFHr+xHo5dHzqAIUJLsH5J/uAhGzM7Xj+ZZKw3paZcU0KKkUPKf9HmA28k2wRyaoSNRciXX
	/OMnjragE4PqJEsCwbosQxV0jHEc0EAX3kD/lYo+yG0FPwqDRaQiRwsva20E+6o5fj4qdSpi+6Q
	fC/R4IetH/qopaEqvRD0cMjRFv
X-Received: by 2002:a05:600c:c4aa:b0:492:3445:ecf8 with SMTP id 5b1f17b1804b1-4926685fe2dmr206794015e9.3.1782658245742;
        Sun, 28 Jun 2026 07:50:45 -0700 (PDT)
Received: from foxbook (bgu190.neoplus.adsl.tpnet.pl. [83.28.84.190])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926c00a34esm136115845e9.0.2026.06.28.07.50.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 28 Jun 2026 07:50:45 -0700 (PDT)
Date: Sun, 28 Jun 2026 16:50:40 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Nikhil Solanke <nikhilsolanke5@gmail.com>, linux-usb@vger.kernel.org,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] usbcore: Add quirk for 255-bytes initial config read
Message-ID: <20260628165040.76fd608d.michal.pecio@gmail.com>
In-Reply-To: <02060df3-b8c5-4a86-b3ab-3a28eea8a562@rowland.harvard.edu>
References: <20260623161035.5792-1-nikhilsolanke5@gmail.com>
	<567e8866-4308-4e5f-819c-fe778dbf74f8@rowland.harvard.edu>
	<CAFgddhJk0EYG71fnKdio=RHC-cH+JmL-EZ7-oVD-LdHoa2TBSA@mail.gmail.com>
	<5159fd69-dddf-4073-a8e7-95fa77de0b7f@rowland.harvard.edu>
	<CAFgddhJ2HeJ=oTBX_axMJcgJq7GXH9abe+LH+x9NGekGO4BMyw@mail.gmail.com>
	<eb0dfd45-91c5-49ba-a297-b183dbc52c8c@rowland.harvard.edu>
	<CAFgddhLZ9SuOzG_6mW09j9aDkCp6TedpNkzJ6TUD+DnR3TDLKA@mail.gmail.com>
	<02060df3-b8c5-4a86-b3ab-3a28eea8a562@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 28 Jun 2026 09:55:07 -0400, Alan Stern wrote:
> On Sun, Jun 28, 2026 at 11:53:09AM +0530, Nikhil Solanke wrote:
> > I need some help with the USB_QUIRK_DELAY_INIT part. I can't figure
> > out how to make it properly work with my patch because of the
> > following reasons:
> >=20
> > 1. I don't want to move it to the top because, from my pov, there
> > must have been some reason for placing that quirk where it is now.
> > so i don't want to mess with it.

git blame is your friend:

    The DELAY_INIT quirk only reduces the frequency of enumeration
    failures with the Logitech HD Pro C920 and C930e webcams, but does
    not quite eliminate them. We have found that adding a delay of 100ms
    between the first and second Get Configuration request makes the
    device enumerate perfectly reliable even after several weeks of
    extensive testing. The reasons for that are anyone's guess,

> >=20
> > 2. Regarding my idea of adding a condition =E2=80=94 so that it doesn't
> > change the behavior when the quirk isn't set =E2=80=94 if the full
> > configuration set exceeds 255 bytes, we would have to issue a 2nd
> > request. In this case the existing behavior would be more justified.
> >=20
> > So, I'm a bit confused about how to implement this properly. Adding
> > yet another condition to fix the second case doesn't feel right to
> > me. It would look unnecessarily complicated. I would appreciate a
> > bit of help and advice. =20
>=20
> If the 255-byte quirk flag isn't set, do the delay before the second=20
> transfer just as it is now.
>=20
> If the 255-byte quirk flag is set, do the delay before the first=20
> transfer.  If a second transfer is needed, you can do a second delay=20
> before it or not -- I suspect it doesn't matter.  If you want to be=20
> safe, add the second delay.

How about "keep unrelated changes out of a stable patch", i.e. always
do the delay (if any) after the first request, regardless of size?

Regards,
Michal
