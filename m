Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EA237DAAF
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 19:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780341995; cv=pass; b=ZYAjqKnaW76weiXl6EcAeAB915leLHUfJMBYLnKm1Pad/WBHiC+k9RgH7Un2Zg94EU8oXX8Hpne2+ql/25hTldxFqVaw7x7gzABTW6ZkQkuQ9N+IjY2KHxTtwjHKHFGb+8oHadrMjk5ItD8J0V+RTKnEynRyhcWKB6zuBK6kqX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780341995; c=relaxed/simple;
	bh=hpACHX8gpPgUdVyv1/sEpHCxZ58roJACIEZKoxqYnKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sRNF3dehuHJGR//ABC3eg9w4uK2vn3YmM8n17oQGeJnJR7KQHTaET5cK/kUSePtksWbm9VvIlJ72WXKZ1k6dW4p85VFUVrJsWaf25Sl4GTH9pkOXJk9Hscmr5BL6oLxidUldg6ZseHMXqYJi58yUBz3k7DajGVq2YCoRt55fjRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g1SfaUWc; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g1SfaUWc"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aa67ddcf56so160e87.1
        for <stable@vger.kernel.org>; Mon, 01 Jun 2026 12:26:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780341993; cv=none;
        d=google.com; s=arc-20240605;
        b=JCyMtanReTQgAUK6o3OIr1I1VpVXDGiCSedN53FVJ6TisjAve4XcM0JiZ704s1GVm/
         sUbXYALydNo0GKBqT9XXZP5MDdNuUVlx1PGho+ZxBTaUTJ5paMfdnMQZNk9paRHEbR+2
         zMuP2Oo63HvRGYPSxoAYW16Hsa69WSgoCUo+CBNCM6J75q61JrwRxE0H9PlaRBxslwGf
         tqj3DvGnxyLnrlcGemgNtSeIRRUQXdBwszsBrINe7y6i7EXa1L3ARpZ05u3K3aRmShFg
         qatAif+2fbcA5uLgzwM0/B3VSTp2ZvotSYRND7jmvKgQ3nS/TZ48c83ZpkTv2j1hShpw
         exKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RUETtszvlgjxvwcIcmAnMCzPRiN6e9NnLidclBHMCNQ=;
        fh=C/qFoRKG8jy5qBff3jIcaB6KbUR/UK8JlVY9RFbW6uk=;
        b=UJuzRRtXmv+o762a3rgOKXI4dKKaVF2/T0BEgOpiKwdGMtKAodS3AEDJRi1/mhErs2
         R1AeAcgKt5Lb4sor/ki9i+7kkP/BLriTM6i0w4HrIIRzkNmteiPOISfuzWJkF2buIX0I
         lP2ZbSmSLJrEJ8WuqpQEVe1p9zF7jZj4KefrIZfFICyRaxmtXOA3uMd+WTZXQM4eq8Nk
         4y8/sOkc9RNxNdctVWD9aDCrgUToDkIC7HsOiZ8i6VPDbP57xe2dLWQvjG6y5Ra7Yume
         chaJV8ZDNLms2oqnvL5eMGDk4gLoATTpiupUlTWhSpbj+g7K/wSzuNdKXlsIShRRWpgx
         NU0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780341993; x=1780946793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUETtszvlgjxvwcIcmAnMCzPRiN6e9NnLidclBHMCNQ=;
        b=g1SfaUWcyQfxtm+ARSabOP/RUnigKbuu3d9hg5nA8FOKVAHYlSX2ZLkM48ndQ1ICi9
         xuVhCLN7TC/2gwIVgWDpZHxN8JZZPZTlNdJR/ceEYfEOqCMOznvXa2+yNqs452UhluxE
         H1b0eXKxvY4gh6fmLh5AsR4YYYmxQAmENqdzVaGHZB3a1gcoE0+WmnIIrxYWTvSZFJE2
         CD9LD+vuerFATuIxin2D0q3oxUfINdIq7HbeBzrClapZAybB2twd73bb02GaI/6DQ6sy
         JrnP6aZa0trtstbimbx05j3iDcfgrsdOUV1KQcP6Fts3Quu20gVcsFjUic+CUbaVDvdq
         skJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780341993; x=1780946793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RUETtszvlgjxvwcIcmAnMCzPRiN6e9NnLidclBHMCNQ=;
        b=hjRQnPT9xDzQW50c0dPy24NLlBYkJKzuXGpIuVwPVZGS32/0Mw2j447DE9XeZ587e4
         DXnYSPZNJQz8ZcpfUYzhJmPhZfRDOH33Rji3ji11EcD6P+59C+yw15lMgg18fGXkYgX6
         Bcefn4HbyRAcIA+KjyVjrUIrnBwrlcI4cHveLLHdbGuhsIoiXNYGUReLp6WNQzikL7pA
         czCT31AMpspjoG3n3bPQyZmZJpeCxAyUFBVqPPuvBA8lvdmMxb5wdNWdJpUR1YECk+q/
         hdGNP/LmN+PYrxd18MQ9wZnCUJzFG+k0YwiV5EzfVle7S6y4pmoU/oPHdtDge2k72LnH
         DIgQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Zmi6CE1/OXsrZuppCc6cIU4glNQUQUo0pSzpBPl67iNkmoR4t2Cj0Qu4PvKFpe8meWyH6IH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzqK2BiYSNLC4JEC9+aNYnW+QG5SbqSgDV8QfqZ5cGHQFVvEtI
	5a+GqSufm06sE9IxJHWWIh8wN+8VB7zuaz+qMJ3BE4/tVz1FubWijV3iq41g6tPZ0ZEntFfWvaR
	PQsyz3XG65ith3uoS0LxDmw4Ws0jIPtizI0N/IWE=
X-Gm-Gg: Acq92OHZ2hMwaEd2NYd13cJoJpuzEIVlM8AuH/+Z+R4VItxQJ39xOChlmDAhzKdCiaR
	4oP+JbdT06wOlZ+iz9FExAcygysL0BDm+3VbDC7EaCYWrDg59rRzdxqaAPdVRuT6Jdhnc334BHa
	oajjUSwdJOhupAbLcFw230/whVPYsh7MNq8at2tQp8DGmlczeOG1QifhfOYjkr3a5I/c8FhFAFj
	wz36VENp5P5I6uvFz8xY4I3cYXlIM/PZ/2SfqC0Ci2RSIgIG/EYAzLelER38KsnuBgCsIqrzAPj
	3pKYWJJkP3F3Z6SSkCVOtaLJSHdXBzn+4lpo0+C7ezXV1nY=
X-Received: by 2002:a05:6512:3a8d:b0:5a2:9b28:d64a with SMTP id
 2adb3069b0e04-5aa75b3495amr52247e87.8.1780341992156; Mon, 01 Jun 2026
 12:26:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528191658.2506362-1-xuehaohu@google.com> <20260601175252.GD2487554@ziepe.ca>
In-Reply-To: <20260601175252.GD2487554@ziepe.ca>
From: David Hu <xuehaohu@google.com>
Date: Mon, 1 Jun 2026 15:26:19 -0400
X-Gm-Features: AVHnY4KmXOz7naPVQt3RnYf5-sps0yuGM1iGSV6Zi0v2ewCpGm4R4O7z_6CO-gk
Message-ID: <CAPd9Lg8Um=0LJWB-QCqLyFksX=dTsu3hwuVXK9_CGRWTVBJppQ@mail.gmail.com>
Subject: Re: [PATCH v4] dma-buf: Fix silent overflow for phys vec to sgt
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Kevin Tian <kevin.tian@intel.com>, 
	Ankit Agrawal <ankita@nvidia.com>, Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, jmoroni@google.com, praan@google.com, 
	stable@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 1:52=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Thu, May 28, 2026 at 07:16:58PM +0000, David Hu wrote:
> > diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-bu=
f-mapping.c
> > index 794acff2546a..1aabc0ee70bb 100644
> > --- a/drivers/dma-buf/dma-buf-mapping.c
> > +++ b/drivers/dma-buf/dma-buf-mapping.c
> > @@ -51,6 +51,9 @@ static unsigned int calc_sg_nents(struct dma_iova_sta=
te *state,
> >               nents =3D DIV_ROUND_UP(size, UINT_MAX);
> >       }
> >
> > +     if (WARN_ON_ONCE(nents > UINT_MAX))
> > +             return 0;
>
> The WARN seems a bit much, but if you have it then it should be
> arranged so the caller ultimately fails.
>
> But otherwise I think correcting the types is a good idea
>
> Jason
Hi Jason,

Thank you for the feedback. That makes complete sense. I will remove
WARN_ON_ONCE() to avoid dmesg noise, and instead add an explicit check
in dma_buf_phys_vec_to_sgt() to fail with -EINVAL if calc_sg_nents()
returns 0 (on overflow).

I will send out v5 with these changes shortly.

Regards,
David
