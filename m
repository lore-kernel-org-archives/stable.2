Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0578F38B125
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 01:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791768673; cv=pass; b=mlXupnDKL/RlssbEFCtS0p4eX6fjIXHGyUMoNSTTQRNG4KCVcwpyiOHpvcaOt5NEKYb0bsiF8yj1SbOQu/9yhWM5ijWluSTU8eaKF2C45n0VFahJlTSIoyHRK5nPXYHVJ1ihIaB27IMS8ocQfLym1p8NMr9vWG35Ym56WXCLQIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791768673; c=relaxed/simple;
	bh=yxS3uhBDvfDEPOTnAxS76usAFm0hrKWhB58ChKobAUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=heaGTDzqJKSXDK1ZOf2qlSq4FhE6enSQ2WEhWesqOxpEm6CdVynp3TtCe/+bW1J40Wag9AzEtjfDZvISHfRjSGQ7QWER3+rXGMKky5/F0QBMdVJo6OtsR9g+dyEC5nTtMQoF4Nv4qeVAAYXafNVq7LuAdoEMlwigzJydCnacPLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IovhHvuH; arc=pass smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IovhHvuH"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-48ed188ee81so913534fac.1
        for <stable@vger.kernel.org>; Sun, 11 Oct 2026 18:31:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791768670; cv=none;
        d=google.com; s=arc-20260327;
        b=edjEbTVBbRxggTQO2BhKJENJ4FTvtI/acKgNmxmzqM5pNe/r2MWpCe/8E7PxtcBjGC
         Q8HtGZbSvoGo++2rMdkl5YNzICi+9P5sDqjVsM5RuOkyppcopM/8lVZ3FBq8rmIpBLsq
         GieUHHlH5eZyqgGJuXr3CJzKFQJWJOWKkzYT3bad05ezryIItmsQMfYhJ7FOU7Ehk+dh
         Rfk8RcUxC54UxcP4r0FNCxOX9+2vP8YeBfI0qpSaenT1RInTIz+Ewfr+t8Ni6xDQkGjD
         OzZtd2laJD7+MxfOcXQtMcPp8vLtOYmUKHdeD8rtuyeAVY/tdOr1cbjmlIbXFKyxN+R/
         Ft1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0YNtwNnqhEyRRpVNg8EzN+lDMoQ6yIJewZ5GDTLfOXY=;
        fh=My+HMmPf8cqHyw4d4ayDIji8d6txrcaXSu0HEcwP3c0=;
        b=QVLcPfXDPYLSyiC7S4peYFdoqNsipiyy5NmWZnwFNCclEPvaKXp/xQE0D9Ywrf7hms
         0BuUgrdHUpehRJuLK2r9ssbmk/mrLc+A9piJtf5srLrRZdkgZFMFvyAuT+z3JfPoiHaU
         iduMQWnqNiZL4snIQqNOhkj3bOQPse6ew5hHXGALujgAejMPC+iu8E0lydm7VtoFjnUP
         3h9ytzaFg1kmL5UkHH5ipWyZ4/MqP0dI/hKg/bqHHDPctJr9CTlLLOBrMuwlgt0wF30W
         vMrdJGQMyWEvKKhK9vD0xaYAjgv7PaE6KVeUVclEV+Gu6aOyhOAwjujhlmNVdNQxCSJ2
         2WQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791768670; x=1792373470; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0YNtwNnqhEyRRpVNg8EzN+lDMoQ6yIJewZ5GDTLfOXY=;
        b=IovhHvuHDPrFc24HxlYyZOelam/C7lTGqjHacte8+xRMqRlrJTu9AbJwZZRvWrbbFp
         VFLH96WTeyDhAjZZXW0yImXztnDKWJMcygBUoZmDHajhwHGU0zrivcBwGRChWx+bScrH
         fpukR9VuSwmWLg9rMU9JKLu9zIzHTc2qmLsZfCyLB77Clr77bbKHvkwAtzWDnSwOZ2g+
         3oW9Wlnw286rs+Ct8MrGLVluDPfnMLfwUXrZ8UVU0gWsmaGl92C/85iJrEzFD7LI82iL
         daGg8PQssEzg3iVtyS+eAXOAf6rva1oMBhxvp8VDtk+z9BVjxZ/O79oGOY2MejP3n8at
         b68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791768670; x=1792373470;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0YNtwNnqhEyRRpVNg8EzN+lDMoQ6yIJewZ5GDTLfOXY=;
        b=KPh11O2AXHw/pdRimbYw5I83lUyWF60Ie8lToUjwKi0Y1hLm8w7LLWcbP/N1dzbc63
         E1T5gyN4B/hukYaCoFNWOWF8rdymw8YcSFx8okrEBffqS3WGMD9TnShhpx57CDvJsMBT
         sgMQaG6yTGY58lgNyRw14qsmDYUfBL9/L24DLjJuzfNY/muzBM2r0WeahdZ32ezb8+ki
         YCNFPCrr4BIg0+FZ9Zduqg1UsMoEcHOByDyw7q/EfaAAaO+S2gfCpFp7qjQUdId+tnIo
         no1sdx369YpeBXQbpcWp2gjr1OoOifrK85pFt6INw/bOXuUfmOMA/u29vIQXe6GDvL8I
         TaBg==
X-Forwarded-Encrypted: i=1; AKwUvBwAqzVpq58rQ32OOgrzCo/ip99QzT6T//v6XP5n7rJIx4+vi3uZATQhZCdQkBrZWmM1K+Uind4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLvDzxuDXuRo8kaQTiNma5JiRuGTts4uE4QHWMX9DjMCWqJK6MN
	LM4CprjHdXRpmNP3sfNXx/LTdA2aWjSRvk9PXiR2J3o9yrkytL4JQ70zmF1wPs5ySNHTxcXEN46
	zSEbac/eZsWk+/VxMSj+GyJ0IuiNQ/6w=
X-Gm-Gg: AYBFou3nqSHCLLMw679iqpwhNMLhdK2s/p3o4KJbvxxEWcMyE3Kjq1G2sUDPA5O8ywX
	vUmvg2+lXnrh4Oy2er7LBasmBU6UblHht4p8/vsy5DOTiuYX1CkvoVgHF+BRzsM6h+9ujjruENb
	qMkm9kOaU5jIe2bqKl/BP3CgBGZesVAGaGzwjBWxk3lxLCQdkDjcuebP6TKIX6ehP5PGNgJ2+MT
	eoBsggggy1ntyHO20TavukAZMUeJ50Bue4OIW8Bhvq/xy0y48VuWxEgt1z37yciCIQRh3Mnq8/p
	nqWTj6Di1O1crcpecusBHHrIrun9SXzrnhqoV0JMSXqpXBP3YVcm4r4=
X-Received: by 2002:a05:6871:88b:b0:48f:e0f6:bd68 with SMTP id
 586e51a60fabf-4a2a8b421abmr6481919fac.57.1791768669944; Sun, 11 Oct 2026
 18:31:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903111328.805352-1-christian.loehle@arm.com>
In-Reply-To: <20260903111328.805352-1-christian.loehle@arm.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Sun, 11 Oct 2026 20:30:58 -0500
X-Gm-Features: AclHuK-niUwLhpYe_kVt5YW52V3PgUDZ5R8udpP7iFVNpudx-8Rk0OjArTDOtgk
Message-ID: <CABb+yY3h90WhxRyQnK21NhUNYcD9DVaivpxQGv54S3CHUw9jWg@mail.gmail.com>
Subject: Re: [PATCH 0/2] mailbox: pcc: Fix shared-memory teardown race
To: Christian Loehle <christian.loehle@arm.com>
Cc: Sudeep Holla <sudeep.holla@kernel.org>, breno Leitao <leitao@debian.org>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 6:13=E2=80=AFAM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> Breno=E2=80=99s fix frees the PCC channel before unmapping shared memory,=
 ensuring
> the IRQ is disabled first. The second patch serializes channel release an=
d
> request so a new mapping cannot be unmapped by the old release.
>
> (I'm happy to have my patch folded into Breno's if that's preferred.)
>
> Breno Leitao (1):
>   mailbox: pcc: Free the channel before unmapping the shared memory
>
> Christian Loehle (1):
>   mailbox: pcc: Serialize channel updates with shared memory teardown
>
>  drivers/mailbox/pcc.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> --
> 2.34.1
>
Applied to mailbox/for-next

Thanks
Jassi
