Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAAB4D956F
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 19:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792091155; cv=pass; b=itDsWGC3Dn5DReLYAlqF3tgntqqn5QF+KkW5hIy4I0PX7CrL5jmq72K8GeEyZ+np7yBmoT6WCtCSsQSP/WExg2anocw4Tbl01tWSb6kbJpKgPOJXYURMR/pTz3tkE66F9llaSFwoksG9MAZul9dxj/5jLI1PREs2iIDRb1yPTNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792091155; c=relaxed/simple;
	bh=njrs69PTpabl/E/c3igW5pfsoq94perIYIoiSEXvZaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KsWJFLQbU0FlfBG5mXvE3LHBJm1k64l1EPXxlHM+8AeZ4IKl29h7OKETaq+ev1MN2i3pAm7QlDWTnB6VxV5X/t7iu/vQUm7Vl2L/4Ohlg6I241o+fi6jVUZIcXPSZbRhNfK6cCdIp4HPVfKKgZKzhOO6r6DTpoX/Xu46uT+mFkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wv3WNItm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OCeKBav8; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wv3WNItm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OCeKBav8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792091153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+t2QXv6kbjJkqJV/NGflwSk1ZKtAPXbD9EclLnTEDp4=;
	b=Wv3WNItm4uVAnbKHZ675WoLz38h/8kY7MU2NAg+5lT17THJIFrogFmbjkJnOW61gOu6hoO
	6XRfxqnAB3ZILdAd4iPJK1gyQFWfAndqs99an+eoXvUwvQ7189BoQvCkrHoHPudDEaGCJs
	+3cxdl6sh80/eMSYRJd6yzIAgExjVUw=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-OVt3I7rwMUmf2j-FlSiuOg-1; Thu, 15 Oct 2026 19:05:51 +0000
X-MC-Unique: OVt3I7rwMUmf2j-FlSiuOg-1
X-Mimecast-MFC-AGG-ID: OVt3I7rwMUmf2j-FlSiuOg_1792091149
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-67694007c9cso7565908d50.3
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 12:05:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792091149; cv=none;
        d=google.com; s=arc-20260327;
        b=G84mSHFRvHdIEjkzLVRwomPvCt5sMyCnj/o+Ptw7AcvJlwlGsP2Uc6jkQcx3urr2eE
         Jm0mwHn6e2aR97/xmrl7feO3u+iQUHJwBVLErdd7pGS/kt2KBIYiLhkbcEDP+WEtFczV
         04hc0wYsu3aBYLK2lREQrZK5sfzlP7bVlvi9BGDacPQVo9WwTjRUc3NJ7awwktb2E1KG
         2rRFbtvn4iP59PxuyU+2bTjJTnNdi2x3P+VG4DcqaG+sonLJx+qvP5zua8n7lDjj7riD
         loZ+R0ezR7l7wMOGTQjNBok/wh1aUvdF+qgjWQplLoDqVTOVQexEg01zUs1aWKIZ2zAC
         kGWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+t2QXv6kbjJkqJV/NGflwSk1ZKtAPXbD9EclLnTEDp4=;
        fh=qyKYvTtMc5V7hi/3DKp1NJR1ztWEbDIiMMCgRyG8vKY=;
        b=kHSRXN1LFDFGi5+Oys6/PbGQJ+Ex8oxBIX8JW0VEMQKAkZfwk8LegAv85UYmfej8Iy
         mvbqEX2GZHIUd3w3QfR/Mca7AOMs7ApgI4tbDF8hGOWS8b3OoHuSmTiR1Vgvlz1IBWbf
         3P2710W6x0VdfQun3tPVLtFJ4IM2F55JDfHLZEUvL/tOh3mekvE735dRAMxbAPqXNe1e
         NfODmMtWP+PI91FJ+Moa/cT64eTDuZIdf3BQj9bRLbuA3WDnvPjzmSG1yrmbw9HSVBon
         OXXs+o92Px/NOvlpE1h3666xduRr8m2NEAnnv8xnGoZxSjTZj6ifQoz27KF6KfKOSVt+
         8cQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792091149; x=1792695949; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+t2QXv6kbjJkqJV/NGflwSk1ZKtAPXbD9EclLnTEDp4=;
        b=OCeKBav8rrmnwZ4fmkBgShSAreSUFTHGxEYUZBRtrke8yelkCPud/Af/fE3G4NFkAe
         Ky2GOLk63kj3irZWtXdUETaOPhHlx05oVEg3+spqjgm8puheLDJqCZbvFXfoK6uY3vxq
         uM2kCvvikltQwy0zNgVaLvoE9eovy3JLRkx8bUu5nmOmgYYfvHqiPnGiERegaK4jmoJV
         3+5g31ZiP1EUq9/1uZpXV0F5TUatW7aCEleEO1NeYCeHZgA+GY094MIMUMcyN4qBqVOj
         Htq0dlVC9xiUQznX51qFRHfa54RrWUEvHAiTLwWlLeM1IRLYImqJ5NcGY/V+7PInen4K
         3WLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792091149; x=1792695949;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+t2QXv6kbjJkqJV/NGflwSk1ZKtAPXbD9EclLnTEDp4=;
        b=sbdDjqRov2ZYJ65D+5bb9+yeg9mm1OVx0+bOmroY58eMUKrKUedN6I8W9c3VUJGWoL
         3jNzObo4wRA4s7aPRgkca0dWiVC1msBXW6EW5ywWzFE1u5/pJVSD9DOIgq6Nj6vYlkFF
         ObP3t4qVO86r3dw4rIAEZsMGK+ysxMgwpWBrfQjxOW74B37pIPzI1yhq97GP0u2S6NQ7
         nNnnUvB87yCT8Zqhxguqvlbrm8kHa1cMLNmyBrQ3I/qBAIdTwTruZDU/ATzkD/WJ2475
         kDvDyOc4bZL/HoFHkprbKksc9GMMhYph1f5znp56qPPPqTCJDqj5S9xqTJ4xxCGgEE/R
         h6uA==
X-Forwarded-Encrypted: i=1; AKwUvBw+tj19mPDcCDlhST3dGpqKdf3AgdtS9vvC99zdcSMO6sFQerOcjeGxbVWhJCJDpL1nBWOlRgs=@vger.kernel.org
X-Gm-Message-State: AFq9FYI5FiD9g4R9uBHsc38I8ivRx/jNdhDEI0LbkMLdHEFwg+a452x/
	EsD+GHUjom0mMcvWaPgYv9PoIECBBwdHs0zvXEVp5AS0hGM8n9gDaJyMABeVGrVfWNIuEeMHt3o
	1t7yRi8alRvu5Eeajx1Vx2/wLBszfl/kIO44dIiQuQn9HXqVcXyyuBykcfdDnmF9aY19AW+LCXL
	l0adNjsnIDvJ/o3jFbOuPPAdG0SEJHs3jz
X-Gm-Gg: AYBFou2y5fiiUff04yfOKzZj8P3yQQ6PIlR9fbdLTgGtkOa0AshBms4IOeKonRNaojE
	RbYRGg1ulA3MMZYvWV13QDVIpbweZQ5JfkSK7qgxghD3abUK2MLfYABaPZmB/vdhWbLRVGGyPue
	ULlMCKrZUSfLVo99SPfkgzK6aT+6HWV1MGO7KPJtco9IbkpRmIlBqFmSSXgIdfh2wLDWp1T5kvN
	xQjB7rDMIBNKqDXF1aayL9JnVrZ48+8JbMD3taJXvYJNA==
X-Received: by 2002:a05:690e:c41:b0:679:8bba:31f9 with SMTP id 956f58d0204a3-6798bba38cemr2199243d50.91.1792091149390;
        Thu, 15 Oct 2026 12:05:49 -0700 (PDT)
X-Received: by 2002:a05:690e:c41:b0:679:8bba:31f9 with SMTP id
 956f58d0204a3-6798bba38cemr2199234d50.91.1792091148870; Thu, 15 Oct 2026
 12:05:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014-gfs2-escaped-copy-fix-v1-1-ff917ec48fcf@columbia.edu>
In-Reply-To: <20261014-gfs2-escaped-copy-fix-v1-1-ff917ec48fcf@columbia.edu>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 15 Oct 2026 21:05:37 +0200
X-Gm-Features: AclHuK94-O6U3jMmeZ5GvtKhtuJdhgNOo4OyQgWOMPl5vnte_lO1Kd2hA9skmQI
Message-ID: <CAHc6FU61aba=a4eTH8xLGm5RDpLxxwzstq5B3aMTA1R0CaNSug@mail.gmail.com>
Subject: Re: [PATCH] gfs2: fix the escaped block copy in gfs2_before_commit()
To: Tal Zussman <tz2294@columbia.edu>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 2:37=E2=80=AFAM Tal Zussman <tz2294@columbia.edu> w=
rote:
> Commit d68d0c6c3fc7 ("gfs2: Use memcpy_{from,to}_page where
> appropriate") made the escaped buffer copy read from the mempool page
> it had just allocated instead of from the buffer, so the block written
> to the log is whatever the pool page last held. If the journal is
> replayed after a crash, the block is restored from that and the file's
> data is corrupted. Only escaped buffers are affected: jdata blocks
> whose first four bytes match GFS2_MAGIC. Copy from the buffer's folio
> instead.
>
> Fixes: d68d0c6c3fc7 ("gfs2: Use memcpy_{from,to}_page where appropriate")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---
>  fs/gfs2/lops.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
> index 77ef22eab368..16fba2108a4f 100644
> --- a/fs/gfs2/lops.c
> +++ b/fs/gfs2/lops.c
> @@ -689,7 +689,9 @@ static void gfs2_before_commit(struct gfs2_sbd *sdp, =
unsigned int limit,
>
>                                 page =3D mempool_alloc(gfs2_page_pool, GF=
P_NOIO);
>                                 p =3D page_address(page);
> -                               memcpy_from_page(p, page, bh_offset(bd2->=
bd_bh), bd2->bd_bh->b_size);
> +                               memcpy_from_folio(p, bd2->bd_bh->b_folio,
> +                                                 bh_offset(bd2->bd_bh),
> +                                                 bd2->bd_bh->b_size);
>                                 *(__be32 *)p =3D 0;
>                                 clear_buffer_escaped(bd2->bd_bh);
>                                 unlock_buffer(bd2->bd_bh);
>
> ---
> base-commit: d0c4bce31a579216780b990a09250f15e00f38ff
> change-id: 20261014-gfs2-escaped-copy-fix-1055ded37add
>
> Best regards,
> --
> Tal Zussman <tz2294@columbia.edu>

Thanks, I've applied this to for-next.

Andreas

