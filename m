Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE1B24BD03
	for <stable@vger.kernel.org>; Sun, 31 May 2026 01:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780191901; cv=pass; b=KG+EwXK4PLWiDtWVDu6xv1VVwnRFKI28WS5JD64UhUXlaNb9g6R39dwblTL8PKrqlkkoqapNF6N9FqudToIAbDUoU4mPol1DdMumjR/RoETme0OUjb43GLYOoha28SyjbQu4UKSpFfe9fjQX3PkhX/OrdSYcvaJax+BobQKV7nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780191901; c=relaxed/simple;
	bh=VwqbU5ro897QX71KGfNrhRfC/Ah5/wdZUHUGHxN8mQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lvX0UM7fvjZgsFsdEs6CCz+9XSxMWCNoU6edzqDIk2zJuJWKqawL9Wy87l7VVipFewiFKLF5udkr/mzlm9zMzK5II8xpX7jyr/VVumAaB6TYHE4t2crisKeU2h3eJajTGP5G4iS1aiKAvCm32aQZSvllDDY7/oC1DLG4nHlmkhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGdk28lo; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGdk28lo"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-6605e6db5f1so1035332d50.2
        for <stable@vger.kernel.org>; Sat, 30 May 2026 18:45:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780191900; cv=none;
        d=google.com; s=arc-20240605;
        b=fyz2RMlxcU/eyZXRl6LS2WGIvft1P1hmTepjwrZB4ToQZHJ4+XLMB9F+cSJqbVodq7
         ptXEs855ErbLx0ee1L5kPi7SJB72buPcnHw0IxAehLvF3oo3DX/Aol//9vSLaStu3jpt
         bY1qaLr/MZNvMHFmTOYWpojD/AjsTKn8VqOrS9I7+dduhbPO3s/wu9H1q8PV0in9Zekt
         wOyBaWwcWDR4vZHyIrzdgS9S2CjQBanHjx6LH0bT/qlvPiK7LfCYjbYp9vdLg28ixJlZ
         hBGc+VDkDG1ksUP14KOt/6wtvMQUWVeXR5cH+qhziMAkgN6upyZhz+SVEO7TlDp2c+hy
         CrZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VwqbU5ro897QX71KGfNrhRfC/Ah5/wdZUHUGHxN8mQk=;
        fh=FIoHdjbNh2TWMsxWYVaU0b7VViy88cpUQS24tjkIW/0=;
        b=QaEHoECQpFBSsVr6P4ALrQ4oFydQlPbrhr4qyNDgjEmS3bscLUa5LeB0nRJmmZE47T
         g6UJt25qM8wg8zbX7DRqPxehre6X4yQUBsVz0ljdhal3/N4apP6bLjXKKe9KrBNGznW0
         2CBYDnlvvBdsmXXUQ/ZZQAAn1/QsLtzEPMlWMdYAfDdk7iW3ZOheex15qJLtwYc4Pynq
         dAkEO7qEqhRQoXMv9i50wDMscBSkD0++RjnFEkYgti+FhtzkZ/fiJOMDvy/r7vP2F234
         9LIp36tHG1oHmYLVPRhqlJJxKTPEv8RsPc4GhOnpgq0VQ2U+bvie2JhG8u15qqFON0XE
         rxjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780191900; x=1780796700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VwqbU5ro897QX71KGfNrhRfC/Ah5/wdZUHUGHxN8mQk=;
        b=bGdk28lozACXNPKfBywsZ3mG6s4zBF2PgTH9KaAAhWQpAPSYGWFrFSa4Wfq4oq7mXD
         P+NV0gftMhyf+PbSOitcvS4y2Ab9C7kuGJCZ//4ISxAqp/bsugwq6OyENWPn/XxP2RbW
         81y3xLQgLMmBsYOduwi/CN52nHOU4D7DK1ITQqUFQzKCvv6EhwFkDdXXF+dN4Ta9Hc/0
         4us8/1BJWkhQ48lI5giAlszQAeSz+zwLc8T98VLTAXABILzqfRMq/JW+MlsJuD9xT+ul
         R2JXQUu2o8Q0ps2sQ2jUBAMET21+7zT7Mda3sryP9zrAb8DhnbaNS05MYPteIlGGqG4Y
         PK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780191900; x=1780796700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VwqbU5ro897QX71KGfNrhRfC/Ah5/wdZUHUGHxN8mQk=;
        b=ZMB+K2GkVP6KxPBGXixDltFbuR/64pZBalHQIpcBg0bC+NXNOziD8fBQ2P3lz/isT2
         wl2x+PQ7p4zkFsNumC8aEYAkXmWKGXW5gaTeQrx99ebNb2jXlIngUvWlHHO0KrFKEMKk
         mGVIhTCRS31O+U6X0SRfFZj45IH2RJXpGcu3PriZemLG0eH277B0cdykum/DL388Tq3I
         n9Un2h7/8UvUGjn3VH3NNiQBwXrJEv2tK4bp0C5++qLBHf0x5aeHgS5rMKi0BwMHaZ/Z
         o91dWllVK5dce9+b4/CApp51wXFghsaBuUsToH9izNLOtXMKKt6q8QVhc0oxFJQe78H6
         Io7A==
X-Forwarded-Encrypted: i=1; AFNElJ8vUWKHdPomk0iiyWAjZmn/1JU8aS0vyyFAvi5Ztu1BVNnjfhyD4SeouWQvr6YNDAvvTzYkfsA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3de6tel6n8KQlisLulML8BWgmYyLT0YR9vNTYeG5ascv/DJZx
	sHPsma8sMvZ0bky3wLD8W7Vj78v9lO0oG2zo4j4FQdatkRB0bwDRaeM3yRe2n5bC/CwOWLbo7QS
	Xa8utJ0HPGl/BZkcYfT5MpJCQG5RKa4OaY3dd
X-Gm-Gg: Acq92OHR5+H3Nj2znvXotqRk1XN6qH8c2sLcWaWBjW+9GpS3p3qjm5qsIaCeTnc5NRr
	etdmI50v/jNUJbNRLibt6eBPmoTGtw+vCqlvZdPW91I13w7fZoOas17BXveotRTRmX+OB7yPbwq
	rEt8sjjagmkXJIL4VVMEysjwI9ZnDeqwSB7Y1o/EsWZmc3pRYSjIgV7gzss2K/j2eQIUs8BvptY
	Xf5UmZw6Q2lBlSo4+qEXjmA6QsFUB6fz+fg6unclX9rd/wC+z2mBiDXxnk0ekBDM7+lO3FGsSvn
	RRF8l/t/QileSXmJRIJmPk85thJXHOL9YibG8PjQVBr4nAtGBaVaf98rkzj4jc6rzfZrBmV+xBh
	ZLdCdbg==
X-Received: by 2002:a05:690e:43d7:b0:660:460e:254b with SMTP id
 956f58d0204a3-6605f068571mr3687927d50.38.1780191899729; Sat, 30 May 2026
 18:44:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430040704.113622-1-kartikey406@gmail.com> <eea194aa0f8734f38fa645db935aca47175bdf17.camel@redhat.com>
In-Reply-To: <eea194aa0f8734f38fa645db935aca47175bdf17.camel@redhat.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Sun, 31 May 2026 07:14:48 +0530
X-Gm-Features: AVHnY4IoW1fZ_suyNHPqLDrDuECtYKSHSM3mNf25rwJnNEPZzvMHT3qfHLCFemI
Message-ID: <CADhLXY66nCRtQk-gzHcZGm596sB2BAVKM1Ehue0ELj=OjuC-=Q@mail.gmail.com>
Subject: Re: [PATCH v3] nilfs2: reject CLEAN_SEGMENTS ioctl with out-of-range
 segment numbers
To: Viacheslav Dubeyko <vdubeyko@redhat.com>
Cc: konishi.ryusuke@gmail.com, slava@dubeyko.com, linux-nilfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+62f0f99d2f2bb8e3bbd7@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 11:41=E2=80=AFPM Viacheslav Dubeyko <vdubeyko@redha=
t.com> wrote:
>
> Usually, I prefer to keep the err variable at the end of declarations. Be=
cause,
> it is the ending state of the function. And I am feeling that something i=
s wrong
> every time when likewise variable is hidden inside of declaration list. :=
) There
> is nothing critical in my remark. But anyway... :)
>
> The path looks good to me.
>
> Thanks,
> Slava.
>

Hi Viacheslav,

Gentle Reminder. I want to know the status of the patch.
Let me know if anything is required from my side.

Thanks

Deepanshu
