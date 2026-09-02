Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C095E39EF1C
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 22:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788386616; cv=pass; b=jsN2U/4kPPbxoyvW6Nz19sRPyXzRvOOgOv7X7wLhOqd6rQEVbEYibjFRPMedTsbYt94mKN8pU5DFZY/cC4WL2OFEuFV8LqAugTgHPuxz8W6fx6P/Ayphf8LdQTUtKf01eFswNsszDf3j+XNOr7TMoGACTc+ma0qZGkhT7CC+lKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788386616; c=relaxed/simple;
	bh=Ji96awhBSDtE9T9eDzIF/2tyM2hKMLoai8rzH+V1s0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cqAyi2BkgukYVtv+VPGdpXZXR5k+L+KUS6d+Up2ruUvOvvNklAcsbIzlgigmvux+ttMNmrl/+6m96diyur28tlsxSlp6z3BfYdaPl2kUHJn5C2ApXO+2du6sYkCtErdsHK+hxy2KI2DnsT8f4TNb65HzRnT6H6DJOQ/R3CJn43Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XKp621Jv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cgdxn1K6; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XKp621Jv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cgdxn1K6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788386607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FSyGVw4A9GnmeP8/IbMD6oCendLxzXyxCDzDxdtJ6gA=;
	b=XKp621Jv/GchpmQusCqsNtdeZzS0N3918q6N73KQXnCKmqH6qc2ckx71db3+SFR5px4ZI5
	5iHlTjQUz8XUHHcKtrUkuDYBuMwRZsjKMWxwpuPkORjg8o2sAniyuP2bO2m6sNLVzO1WWR
	Y9B3QVGsvmtMTtt3vFVhoSstq7ryhwg=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-qtS5CiRqNra8pBjeCT1DrQ-1; Wed, 02 Sep 2026 18:03:26 -0400
X-MC-Unique: qtS5CiRqNra8pBjeCT1DrQ-1
X-Mimecast-MFC-AGG-ID: qtS5CiRqNra8pBjeCT1DrQ_1788386605
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-66cad42590cso1708542d50.1
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 15:03:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788386605; cv=none;
        d=google.com; s=arc-20260327;
        b=X57BCKS3QUBloSwv1rggWR2rRmh9els+G7YV1OGAViZqXhxF3ikmagVX7xEyy1v5TF
         9o1PmXyxwNTI6mD61BFEenbeLZ2ukJT1RFBRt+hh6Wnm3KNhqo6pIR6ZxsvWgzRj/9x8
         Ezw/v/P7ffp5J5h7KZGmzfIYZ+2E8Ap/cuFVCm+GJ8iTEuCZ7oXZ2dF7mUeptK/rnDT/
         OLLaYApwQXiADiVonE2OsyEOwQhhrKwObXDvh7H3rqB0gxcouNnZX2VqxIT+i7C9VhZw
         Hu8zM8ooHXI2FN1O0KoxJkV/XpzsU5M6O10dLsxtYrHK/x0RUryQMPpkrPkW4OaXQy+S
         xxfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FSyGVw4A9GnmeP8/IbMD6oCendLxzXyxCDzDxdtJ6gA=;
        fh=KUIA09dCy+Cs94+Jh9Drg7iXkwtro5DRVxZJMnnV9ZM=;
        b=Que7gvxh6UZDnTpHNud8hR8Uk55e8mmScULY+Lsz94zo/IzDrtaw+cDoBY+ccI7msa
         dS/ZvriJ6nuuGUEAuSennvaCS3+4FAUt3ItbMqrb7k0Z8wahuWm1m0P4DqwUZEXYrJ8b
         ehp1YiJ6pmx2r8QfOb0pbjG6i6RJj5J9tgxakd7brkEUBf2tYs6SMbixEsJ9S4EfNQDC
         CpiG2C7t+K1FxvljqXqu0PJ0dosGl6Q956WJAnk5RixjZgJHE1BJsOnkiWQJPfrOYRjO
         JDCQuppWURN/Kwex4JXkzTaCr0qcVWX4XiXIWcn7tkr7sVqoZt23rn/JbVNBE8BOC5sG
         l9mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788386605; x=1788991405; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FSyGVw4A9GnmeP8/IbMD6oCendLxzXyxCDzDxdtJ6gA=;
        b=Cgdxn1K6kz+lCxUM3aCqSrrxctfEMS8FsbTkAd7BhhT72FAtKMKJdFGtSXYCnvHp8/
         gM85PvFKsaX3gco/F3MRvhsUf4FLdzZgqesBW3Z8J8nzUwq34Z4y8OlRYzZMM1qetKqK
         2xGWMSJxlWd3DFY0zIdosa/WvC+pv1AnMyRWScn+8i7nMGHWGUbnRbucQlrpbNdtaF1W
         2nALeJV/DkxKIq/G+TlcUHveeim05+9O5O7ELs6A/2KyfNtq6Vu/7cH+STXj7Lns91kH
         u+OQOLsJGf4um7qmLXC1qBzfdbKLvN6hr78KWSiLe9hmNedZIfehGpnEwRDHYWVoRPwu
         wrnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788386605; x=1788991405;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FSyGVw4A9GnmeP8/IbMD6oCendLxzXyxCDzDxdtJ6gA=;
        b=BRQWM+LKv6vHYrZy4yXdzZA1fQLYN1AfU46BrYvs1i8uoKFUKGdW8G7slNrVh8vsVL
         6FFZi8cFr14nBFeqLERHo7ExiaOqWoWyVMJTGXHOjF0PMhy+SLRLD7+c2xDuIuFn1LST
         E0fqU5YI3f3cHqUc5zeUdHciBhfo0g9VNjAN7H9k+nm1SOcCfukIcB7N2EsTenaAVx23
         BkJk3TxCDj7JlxhUKxlgT941YqXAIucePZJ3gD2XDlAMY/h59jU2g6bhnndRN/SqJOca
         ttmuiFdYoaklERo9KpQtNicqmb/+Jr47veppH2RhJtdu9WBRJ+PNGE1gTOLBEFxB2B7s
         qkmw==
X-Forwarded-Encrypted: i=1; AKwUvBw7yDp0KiK5uvyVJlInvgBjOmxprafUQQiusDTFgS8oNcJ0SDC/gPr+lUOpJT13nOBdm7nCKNs=@vger.kernel.org
X-Gm-Message-State: AFuF++n9lmPvvZ3sF+3xJfPiWfMGnFwvGrjBZALPaG6BDK6KJ/+fKgnh
	fRGNrYDH4Nwjzr7DCmtq5I1ae+UxzzrRW2HxO9MlPDFNkj6KA35nqjFngKp4vp+LyzuWjDyiiEm
	Yqusq/BTNvu/NoT6biIOTuT/AVMP+YV/41/QMhhV0gIPaeQ0MT9CoEEx6Ybb6v7F3TEfT9GQVKF
	c+h2LLWwFtW1dbSdhw55HUyi7tfo663Sr7
X-Gm-Gg: AYBFou01iwTEaU8IakGx/fc4P/2B/LV5JuwLGfy0CzxCt6e3vCKmuRkBIZGin6QsfYA
	yqwD6JW2LUjAkqoTM8rmSyEwn8lGISI161Uh0GvUCGP5erSpwnaz5mvW9UQNry96cCWo7EQg0qv
	eKuU9PdokUAG1CTKgmQtYHXWoz3YrkF6Wjj9RImttuFEG21hQezrVfBa3WN6cKwcZsk6GGteyBm
	nzDNyo95j3BLQED8G/uMTas5yX5kanwmfcWza1VOehq
X-Received: by 2002:a05:690e:4850:b0:668:568e:8618 with SMTP id 956f58d0204a3-66f9b8f04camr1991257d50.1.1788386605299;
        Wed, 02 Sep 2026 15:03:25 -0700 (PDT)
X-Received: by 2002:a05:690e:4850:b0:668:568e:8618 with SMTP id
 956f58d0204a3-66f9b8f04camr1991110d50.1.1788386600049; Wed, 02 Sep 2026
 15:03:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dd2fb3c26e999922ebb6413cfdde212903e204b7.1787225676.git.vega@nebusec.ai>
In-Reply-To: <dd2fb3c26e999922ebb6413cfdde212903e204b7.1787225676.git.vega@nebusec.ai>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 3 Sep 2026 00:03:08 +0200
X-Gm-Features: AcwNN1UenxlnRcHge64OoTYHPjVXDRRTQG3-A2SArjLH77ySOG-L6mixMR47X1U
Message-ID: <CAHc6FU61Jz5w3ExSVq_cEyOEKYsu5t27ef_pbXdgejfJK1AN2Q@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Fix journaled truncate range end offset
To: Jan Kara <jack@suse.cz>
Cc: gfs2@lists.linux.dev, stable@vger.kernel.org, VEGA <vega@nebusec.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Jan,

On Wed, Sep 2, 2026 at 4:37=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> The third argument to truncate_pagecache_range() is the inclusive end
> offset, but gfs2_journaled_truncate_range() passes the length of each
> chunk. A hole punch at an offset larger than its length therefore
> creates an inverted range.
>
> The MM truncation path then underflows the unsigned partial-folio
> length and passes an oversized range to folio_zero_range(), triggering
> a BUG. Pass the last byte of the chunk so page-cache invalidation
> covers the intended range.
>
> Fixes: 4e56a6411fbc ("gfs2: Implement fallocate(FALLOC_FL_PUNCH_HOLE)")
> Cc: stable@vger.kernel.org

this is not stable material; see below.

> Reported-by: VEGA <vega@nebusec.ai>
> Assisted-by: LLM
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/gfs2/bmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> This was actually analyzed and fixed by Nebusec AI bot and it looks like =
an
> obviously good fix to me.
>
> diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
> index 51ac1fd44f78..375595235aac 100644
> --- a/fs/gfs2/bmap.c
> +++ b/fs/gfs2/bmap.c
> @@ -2414,7 +2414,7 @@ static int gfs2_journaled_truncate_range(struct ino=
de *inode, loff_t offset,
>                 if (offs && chunk > PAGE_SIZE)
>                         chunk =3D offs + ((chunk - offs) & PAGE_MASK);
>
> -               truncate_pagecache_range(inode, offset, chunk);
> +               truncate_pagecache_range(inode, offset, offset + chunk - =
1);
>                 offset +=3D chunk;
>                 length -=3D chunk;
>
>
> base-commit: 24ef02f934eeb48830cff6b739abc3c62b1d107b
> --
> 2.47.3

I mostly agree with the finding and I will merge the fix. Since the
following commit, fallocate is disabled for journaled data files
though, so the described bug cannot trigger:

86066914edff ("gfs2: Don't support fallocate on jdata files")

When that commit is reverted, the following commands lead to a failed
"blks <=3D sdp->sd_jdesc->jd_blocks" assertion in gfs2_log_reserve.

  touch j
  chattr +j j
  fallocate -l 1G j

That can apparently be fixed easily by limiting the chunk size in
__gfs2_fallocate(), but I haven't run any additional tests.

Thanks,
Andreas

