Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794484093;
	b=2fKIco4zooS+5btk7uJH1Y9okm/eLTuG0gfMJSoEtxDyMl3mh9bPGzYuY02lfHbeCBr8
	 /4eip8OqVpTOrgOe2lkQptaHoFY0AWLoL8/K7y6YX5MNJPmq6DhL0iKa498ZSireWu/wB
	 UemOYQXGOldeWZb+1TIniIYhIwTC+R/00+5EpfZsFgXsfexOqe/uFdSPnwX48tAf9wWBe
	 AjMUAnlQtuiZEV2jQXzB5b1AxnNDMIWtJNzhmL5OZkOjULz1gCVts47dyU7OLwL8OLdcG
	 PjmJV1SXZaHfTrMVyhnOivA9xRxcyZXvvLefMbKBgJVM5zTh1ctI1+S73ieo8uWFBtA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794484093;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=2G7w3a5fSFO72sjeDlpSXv/kZonU1Ep492RRrSQfwCA=;
	b=u2h00UJfvwmSzjOyWpe1a21qmr5yO1DTgZ6JZWa47DezC91X3fO/xXV+9gbWq7RMD2dM
	 pfwiS72ypZ0WvyqJMrUWdPuxLqOc5dTkLIFmA34KDZEzMd2lbWLIEDqOTkywN/KxQeQcO
	 tF8CoYSFkQFjujgV4Gju2s6X4ggY8Aecmv+3JhYQMGnm1Jw0P51LYoTrnaQgIPABJaRIu
	 ULV77i8CSnDawDAZn3tGQmFU7mmE2Pk+X0FYZH8P6vOnfPq6BQIpskpoGHjpCwxF7Q0vO
	 CSRw3fzu+JMMtTRsp7YoPfdxBuh9chZLh3bWLkczNpBdclnpqyZMRlnz9cFQTV0jz7A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nV3J6Zdr;
	arc=fail smtp.remote-ip=209.85.208.169
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8317D606A327
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 11:48:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8317D606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nV3J6Zdr
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3acc7a0b558so33762301fa.3
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 03:48:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794484092; cv=none;
        d=google.com; s=arc-20260327;
        b=LRODjkT/OSVTHXifC58d+TH7CnPDrc8QLIx9/IYJGIbQA9TuF3C3NWGXncMik3qXAc
         S7PHXHinVTX2F6j0BXQgZvLF9nyhJjqzOjSeI0YbxW01JnyO41/vb0vgWPaRAvTa14aB
         GP4RXyrFKKhhE4VjOxkb6o1l7waYLaLzty1aPnMqvTCdv/FriNloh1cxOa/DFVq4eiJ4
         DKERMMCozZEhcL9wxIN+elW12Kj2IEKOpFh7ojk90QlQaO8529XaB91KSzMYB9Kh3jhz
         hCMAxyL7xY4g5WyPOmK2Y7ip/Rdzsfm5+P3pfqOpHNZuiv53M+vT1NNaBOWnGDO1xGS5
         HKVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2G7w3a5fSFO72sjeDlpSXv/kZonU1Ep492RRrSQfwCA=;
        fh=qlSaC81V6x/QhBZD7ypuql+D/+6/c2hn7zam1UJ8NNw=;
        b=c0sJilL2xPBaPz7NmL7vpra6Yj9d/yC2mu45dA4xU6oJSALeot9abwTmYOlE6duA23
         tGnf8FComYBYdHH8vnE2o7At9UaLQkcsBGHnKWNid3brLDqdNtVGVY/GEtoreiFP7asi
         0ZOi2JoMyhyQadxgMaroINtJx5LQ9MCqAiEMLJADUIuWuffjZAsGc79legFmndR1vZbr
         2QscW2LbRcU9mbRrTBK2kWRjNuWePvhQj9TppTUe4jHv+3WkPwRnCYGc+07hjpaDYFS9
         ZgEtJyR8Mw/nKrxbTFvZhVhKgtYfgmq9KIWBEkXOLdGE7QLnz/65tdyKbxERQ3wOcf+c
         dq/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794484092; x=1795088892; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2G7w3a5fSFO72sjeDlpSXv/kZonU1Ep492RRrSQfwCA=;
        b=nV3J6ZdryFVbPzy80vruIcDLwXvsDLos4LsRVp7+6RXO1aO9PFbsobQ9dhE7qi1MEQ
         9LDpAbYYdBq5qVvcm2xM1Mzw2ueqqjhnwlB/p3lI9G4C9E/LcRmGxWbHfMTiGjJl+wiB
         2HhESkFrG0hkmqt3hrLd0Q1JZmZbBIVhLaIgVMibt961ShIH4tMYglJCvwRUd47wvJ3P
         dQRdgGe4vk7dz9YgnPsyUA+Wv9C77PJ+LwVwMhqktWGR4DMdyIA5iLtQ2POpQDLfKPWT
         +frDGxzM5cQ63KIGkzMVkqHbokDBYvxYQIU1+ysq9aIC2u7b+Z9xOm73dCoeLU8Yg7YZ
         gMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794484092; x=1795088892;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2G7w3a5fSFO72sjeDlpSXv/kZonU1Ep492RRrSQfwCA=;
        b=xgtG2UCRjVH7m8skNjtFCkQuBQbhhXYpPlz04MWs9LvxX6/vCeTWOip6GSA+DgY9KU
         oraTP2v9YfELkmllYUP71Wl/+aIpjAlH3kGcThQeQrWrcQp0HDqXUxUYlt6DnZCiK0OV
         +cQDPaOmGVVcgrxqPeVVRBn2tybMz7OhRoBr8ntRsQpndM5iqbCrTOLqv6M8gd5JWhUy
         +09fpKVUqpQgJBMpo6npXH9614qnOPaMNGcxL9rsvLrUpNZTLNCjzP+IR/cY28JfXQqd
         JHDiHrqKKqZpdychLUt1+IeMhPG/Gv5WoqAoDLyV5dKX053P5ChiuI9H/sVcYmwO3tTN
         yO3A==
X-Forwarded-Encrypted: i=1; AL+hErHV/Opj2rbdZ10MHiZtbhiQv7nLmIblZD1DCE9a1i+WxNNetVSeuIRTTSqZ7M059ykIG0xetq4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9XN52c4na4brZkEFTbdZl0cFEImCyUyFLjekpTUKgH6J4StwTX
	VQabJ181ZoryEYFYwrDB2fPQQb+jfwzXlmHTbNrEvu+h9/p/SbtLP4aU7oAAmhfKSzB+o4+faQS
	n7gBIWTd9L6u50nzY3v+HKoGiGNsBAdU=
X-Gm-Gg: AYBFou2WCgDErpKe2h9csAd7cTm3/HH35NTESGouBG//rx12ZmCjWFcp7nGgOOKwdmb
	ViFHf5lJqkMoe6zoKM+NJjstEVDKVA5zQa4mJ8ndTUaqN2XNc0iNYMiCHYII++J5xvMPi1UBHoT
	GbSohuirBdpQbOa4L4CYb4IG1vZPjzUmAwoRB4kCBL8MUhhv+aq02PiwBlA1RPUDOODYJ5Uk7kp
	RpUjfHh1CyuKhodOKfQcz53NzpRs7fYgxNwpv+DdWqSISzbeFeEhF7X6hiykN+DfIlgbr0aC2a7
	sBVwMYdUjazLqmr+0Mz1bBB8BgV2VCv6ehy9IN6tg1203MawLm3x97oFzxjgH2AeamxNUsUD9Z4
	/O6Kf7XykgYQ60Hq4xJHn72gJYMEZFDYlcxcqXDmMylVTwJAN52PFNAMZC+B8EBVXrefH854XbQ
	u9thvQ9lBmDDxEMAtLCVfvzNG/Bw==
X-Received: by 2002:a05:6512:3191:b0:5bf:d54c:1fb1 with SMTP id
 2adb3069b0e04-5c15d54b357mr1552506e87.2.1794484091504; Thu, 12 Nov 2026
 03:48:11 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028132825.657546-1-festevam@gmail.com> <20261112104151.713649-1-sahil.malhotra@oss.nxp.com>
In-Reply-To: <20261112104151.713649-1-sahil.malhotra@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 12 Nov 2026 08:48:00 -0300
X-Gm-Features: AclHuK93YbB4VWMKEzFyF2uYg_cLba_j6jbM7pY7iyTKLjV65FIWhlOBoNvuhlk
Message-ID: <CAOMZO5DOBhSY874fAyZZRdyGW8=Qcmf8TT91gnE+++xRAEwizw@mail.gmail.com>
Subject: Re: [PATCH] crypto: caam: jr: Use dedicated shutdown callback
To: Sahil Malhotra <sahil.malhotra@oss.nxp.com>
Cc: Fabio Estevam <festevam@nabladev.com>, herbert@gondor.apana.org.au, 
	horia.geanta@nxp.com, pankaj.gupta@nxp.com, gaurav.jain@nxp.com, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sahil,

On Thu, Nov 12, 2026 at 7:41=E2=80=AFAM Sahil Malhotra
<sahil.malhotra@oss.nxp.com> wrote:

> Hi Fabio,
>
> Thanks for the patch.
> Can you please tell me how to reproduce this issue ?

I observed the warning during a normal reboot on an i.MX8MP-based
system with CAAM enabled and an encrypted volume:

caam_jr 30903000.jr: Device is busy; consumers might start to crash

It happened in all 'reboot' cycles, so it's 100% deterministic.

The warning occurs when crypto consumers still hold references to the
job ring during shutdown.

The patch allows the shutdown callback to quiesce the hardware without
requiring consumers to release their references first.

Regards,

Fabio Estevam
