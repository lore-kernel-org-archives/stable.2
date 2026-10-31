Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793483040;
	b=yhKMBPUjuvRpTxpz7RiQULhRboVKLd3uuNm8FfriPdNfOOpHgwjafjPXmPAfVdR3SOJn
	 vnDtr52ZdxDUYpFhYBeWMV5spI2VS7gzRdIK7yIjiyyafafUA2ifUoAT/m9fhUsBQbZaz
	 1Ji27qBXjotkTfJHbwCK1/BVLC72+VIJ9/IInJI7sn0CzR2gpZFzht2KjTeeP13Oe9rto
	 Oq03ZV8/AA2s0qiCrt4P54qgdwkufli0FitYcK0lVy96JRnV3+mBZ19xC+GO7TR8P41DV
	 7L0Sdf2jTkalF7MdyL232rQbPsN9JWUs2SmVSX2EF0TES3FSWrbP0IyX7lvBUk6akMw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793483040;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=n4/FdkbJCBiK1V2GJNaCfclA9B0e/fDcc+jSWi7alCA=;
	b=pmxjQP+JkRHutzXWZbqKTRKjilDLKcGEwsA6yy2tWW1vocgHvIcuWe46PVOtxgmU4H4B
	 z9VxU8N4woad3dU3KFf+0V8mbtqtebkFMf2vB/ERdqcaZH+al+3yugVaV8fDT3OqMUbgB
	 B9Xeh1kFLXPvKxyZxsEg3OrBTHar9Elh+Wh1ZiOCyOs3gfGk6bc+08EOgo8b2PeZJ5Zc4
	 x1WdWnCwaUIx4p41d2ltxxN8V96WRCTYgyRAOzU0x5RY6gbs7/S88Itptf1djVquVzzIE
	 Gns+bX47n3g4XvFB+MghlDxIK0c+8oe/EWn1kFLeas6w9wnmGS7RPH4g9w5iLy6GjVQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=amacapital.net;
	spf=pass smtp.mailfrom=amacapital.net;
	dkim=pass header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=VlNTMbus;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.170
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10167606A31C
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 21:43:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10167606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=VlNTMbus
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3a98fc80925so25603711fa.0
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 14:43:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793483038; cv=none;
        d=google.com; s=arc-20260327;
        b=c9+YZ37OtCGt0tK9RXqY1D1hkQsWuy6RoM7iSa/hGNOS2vtYnpNDMsQ+iXz5/Yuxg3
         ljVaYR1vElza7fSn7jMj7d9YvExifKZNd6NDyNwBpRsfRUJ6nWDTgAkMozfzChNCnJgV
         uGtmmahAZ6fglr5Wm4QxL0Tkft9E6fHOT9Vf6EhmNuEJeiQaNRoHPHG58zI1pWC/1BI5
         L4pTlhvsXzYKWVvFGJ2eEPItmzXEKeJYKLvpJ0xY6fDKg9WrGt3F8jq8QWJ9PRLq39lT
         y/24qR2FgV0ZKU2wIW8oUCPGSLrk/77RZjTrlTnDOaE0ppRMdISA9892cqWzM/gT+aZb
         dr+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n4/FdkbJCBiK1V2GJNaCfclA9B0e/fDcc+jSWi7alCA=;
        fh=HdlQ83ReiDE83OVqnadkR2zlTXW66tklnNaS71GjROQ=;
        b=fBrVwq9w+W6+zojS4PWLvnGHfOvNxy4axn+6keUCxbV3UrNOSY/pZnFQHiY3YH665K
         4zOawYq5DxeQcbpjBzIfFZVVTGll5POL3+hNLS6B+QNrbptdTqk1f4xrYnKOHG/z/HWZ
         a++bkquZPZMBZI4ZbV2lA18q/gTk2acK7mNNEuYh+oj73AhgfqP4XSGb5Bt+QT5kuHTy
         0adG8QQYg83tfriJUigNCoWL4KtoHGBPPFOxO0F5wJpPZ9CVocKgkEKnWgYNwnHAYWwV
         5mqBZMF/a1cIQjzVJD++3yWNSxA7ii6hNT3ljXLu9r2ks8hd/02uzWKIfd5eZk/fMHTN
         rTrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20260707.gappssmtp.com; s=20260707; t=1793483038; x=1794087838; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n4/FdkbJCBiK1V2GJNaCfclA9B0e/fDcc+jSWi7alCA=;
        b=VlNTMbusTTtj5z/0RoodUfO2YXSIX1yilyHP+JCuk4VW/18QD3PGWTc5f6wSekj0ZB
         j/+TxCN6iTQJfc+1bM9s3GgGh1JITXBXD7UFd4n5QoXYi0rpFXnmP1BAL9QVcG24IZvl
         8vfpwSx98fuLBVv4938WA/mQbf8V3kTnlfP6z/6KfJWNO9yy4JSyMLOL6qp9+10Dx/dj
         FJnF850XVbS6l9IgNdVuMVzcEUyf2gIe2JgK/U1/8OmEpQnEBMj4HuRZjXFY+q7Riy9n
         Q02asQ+mlz0ISiaxbXw6SRrTYj4sy9rJ9dy7IBD+bWMBwSPLBWilnrDW6RmcDd0mpYOG
         Iy/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793483038; x=1794087838;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n4/FdkbJCBiK1V2GJNaCfclA9B0e/fDcc+jSWi7alCA=;
        b=mqFAt1AkkWGVL7edokTYLB4fWbc9EfpjmLpllVWpC+ThpMJcZuTE7S6xXmPgUpg2RH
         OiHw8CUHQj9hE8LB0yAg+TbhnOv4ykGuP1jY9Bjduehg5V9OIHTNLBGVgFbfXeGegcbQ
         xwGmcRZ4fp3FbEolAASCnmptoyBfPydnMRRvQ1Nz8+Ht5+UKd7btEVUW5bi606thyKBY
         8mcxlQ+BUD/tVoQltxvu7IflHLt7Ee9pQ9NVLT+LZcA0biXUfLWY6VwNDDGf1qTeV7EC
         npO3T31oWXGufCqo5B/k4vYQ6olTmJ5OaisTeOKD3EedkzF3Qj1fDuuir2UvBYmrMfQA
         YuHQ==
X-Forwarded-Encrypted: i=1; AKwUvBwywm6Q9nXUVS4dEGMnwpjntwwLjINT8BkCqFSXe9AiOktP2J4vcDJMIthdh8b9KPJByrMvMdk=@vger.kernel.org
X-Gm-Message-State: AFq9FYL8UNRsdZMgMzuIR6BAZG1Zlyxshf38BgF8zy+LjFXwF3X/PAO0
	DOqVlpSphf2xXpMdN0tx4OybOlA29KcO1HiHT3UPatTgLcKjILfT/dzjmuS5e3gXgjPmdTlSqe3
	IG1g4pKgPVHgVgb9OWadT7sY8XolOtWX62UV5o3FU
X-Gm-Gg: AYBFou16arX7cNWV6+dR4XFDZcmai967QtHGANPT2XayNzfnA5n6R+5Xqk1HVMjRYLV
	Qm0ahKgDuXEhkrfWhGH/hKENwnArNmaTxaoFJ+UqcBLUY9aSCVU3umddgQinJFc2FvKSmc0KVsi
	ziF/THEb5JBxnkbM7UZ8Yn47meA+AsqaiXCPA5lWrgWbDuUzVkWLRV3fawqtvlJypaVGjCMRTrv
	TugXIM+XcZrospNBBszxa95u7bikLKKejulfK8RIvW1RjYW4yu2lp9KIIFrAFWQvM2n9UzzPAB7
	UHfXUfcCGv93PfMyf8w7jJ1BEUKL+fbgHrA8IHmmi/SMQNEwIWlrYS+KmnkvWrMdZYn1AJBQHfY
	A1avuI0gI38RH7xcqEDX7bw1Qj3HNo9mNsBuGWaIQIGWClZEqKWLdan0=
X-Received: by 2002:ac2:5681:0:b0:5bf:c2af:3915 with SMTP id
 2adb3069b0e04-5bfd95730d2mr2003629e87.28.1793483037747; Sat, 31 Oct 2026
 14:43:57 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261031203540.2282507-1-skhawaja@google.com>
In-Reply-To: <20261031203540.2282507-1-skhawaja@google.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Sat, 31 Oct 2026 14:43:45 -0700
X-Gm-Features: AclHuK8DXwQuKXG7YuVQ17qPxlP42BoepMeBjGp7aRwX7XDPrtPwMbgsBa7Xe70
Message-ID: <CALCETrVMC4cPuBeSgPRr21zNoCDqz5op8VR=16382FFSf9ymeA@mail.gmail.com>
Subject: Re: [PATCH] mm/gup: check folio->mapping under folio lock in memfd_pin_folios()
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Hildenbrand <david@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Chris Mason <mason@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2026 at 1:35=E2=80=AFPM Samiullah Khawaja <skhawaja@google.=
com> wrote:
>
> memfd_pin_folios() pins folios from the page cache without taking the
> folio lock. So khugepaged or MADV_COLLAPSE can replace the folio after
> its refcount check while memfd_pin_folios() still pins the old folio,
> and the caller ends up with a folio that is no longer part of the memfd.
>
> Lock the folio and recheck folio->mapping before pinning it, like other
> page cache users do. If the folio was removed, retry the folio lookup
> from the index that was removed.
>
> Fixes: 89c1905d9c14 ("mm/gup: introduce memfd_pin_folios() for pinning me=
mfd folios")
> Reported-by: Andy Lutomirski <luto@amacapital.net>

Reviewed-by: Andy Lutomirski <luto@amacapital.net>

(with the caveat that I still don't like the fact that pinning a folio
does not keep it associated with the mapping.)
