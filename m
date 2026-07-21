Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EA6449B0B
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 17:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784654913; cv=pass; b=DHeuvfkvm72lS/H7buu/37pJou4Un95b+upWQBsln39sZ+Idr6TlswUFp+Cnd7UdHIhKAxC1+a3l2oQsA6yNC03qq6erFG2FSvJdUcSA7Yun18DQiTmkyWhsWNTBiO7RcnuXLWwkF0FXLraO3lXPhWp/TDlr+mMluxJZAzoA0J4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784654913; c=relaxed/simple;
	bh=WjClDNSarC5QjzoostKn8ApH6JwQOJ4VlSQLjZNFJ74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SUZwjBtL6hylw9TLyZZCF7eJlGI6aiCYQzmdCMoHAKTUnlDWa3qHIVv+3E9myObJgEvMkIVzIjpJ+dMOJDqEIyFRwBmI/WClw8KIsKjjGUsyQ/ALlLiqSXjygUnBvy7oNuYgRsRG2wXrbtAu3mV5GxmO+DcfX2ASCo+VqoLmRsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=m1UMgNPJ; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="m1UMgNPJ"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so126325935ad.1
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 10:28:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784654911; cv=none;
        d=google.com; s=arc-20260327;
        b=RpN/u9INFN59azAU6dUrpoyYfMvkD2i0jR8mjPluut218WER2jMQhfb41JkNWaz1N5
         76S8QtFumVnzhmRBSKpqIlDfgPbi9AKQbl2/nKXOe/k1X0silAsM4i3D8YgGgtrGtp4B
         xeJ++r7Y5iJp2yEGZYOqsohZmCZdt7EK9FDRVK18mt+otX1x3S6Zhye0y/A35EBz60Hb
         JoioGpQMZJzT9GZ1sbZzLjL9+knJhRTKDk2ktPUSX1gZAXyZVcBM1nL17hwhthuQZPdO
         I0qUeVRU9dLhC8gOIUWOvlAJPqf0SuNUBSTIMMUtzeDa8sRVgH74XA8Z8HQdS3H2g9K0
         F1gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sEpucA6cJ+wFKkMEgPwzn/PVy5HptrOhm/qxg/NLr6w=;
        fh=S/pHV2qzGjqcL/2EvOnijlJclqwMm54gK1wO50kFp80=;
        b=Ed6+6OTLAvkBYmKizQtW6gioqLfNZRQ1F9XpPhgMfY6O95LDgBduIENNz9bJD3JikD
         juTxLf74wAlChosy+o5UkSV+K4dk0I9NREGGhPYHBv7GcVqrPGXFZTqDPxO8J4BHl0Zx
         2S807f3yD0imQc3MYLEbA6UQXXfTbBQ2MiBCwFV6MHcJ8w6m+hzTEvYt4JnI5XfeYpAY
         kRNqokOzEniiINQF34UjDcx/22YCy3NjStaGvwnQAo5yPdrVJcum/0cnVwwqEIiLm+7H
         5CpOoW/ytuG6YZd5iFp0DHwpIq4Ambv5i9drKYfC685nS6ya5yKPrkS2KvtH1ASNiCrn
         d3hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1784654911; x=1785259711; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sEpucA6cJ+wFKkMEgPwzn/PVy5HptrOhm/qxg/NLr6w=;
        b=m1UMgNPJs2Op6PWWJNnyP0xAuS3lVjlTjxuo29aVj9W3g0FWhhuKUDQMyXOpEbnnDz
         zzAVM8HJ9qV9jrKBS6AkraftM+Z8KtleiEw4Q3A4Zi0M4eczJQl47WPHgGlfFFDQUNLJ
         AvhS2ylrghZ5Bu7mVhrLBIe1V1yPTGtanKr8TruC3uIGM7so5AfXQSQ53rxxqTRv7J1R
         ERsTGbaPMkcMGp6Y1MFUmxvjxqT/IwE3VfshtnRaYVbrnBAc52eC4izj9JimJQhxAu/B
         i2Tio6JxacU5sH1MXiD0SdS2yxYFPUAg+hg8NEkj7kx9/8TnBZQMtb2wQ2Hml3xoELUc
         9zHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784654911; x=1785259711;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sEpucA6cJ+wFKkMEgPwzn/PVy5HptrOhm/qxg/NLr6w=;
        b=nYF68ZBBZ2eV7D38vUQlBuEAKzzIGrbwk9WzwVRpe566UxCMdqKqe/jqSr/wRQonjc
         Rg/pvy522YqYvRE28cwdnoSeNEFI9av/IkCM3Ukr1PcKPdgeeuTS4GkX9UVZbBCaNWFO
         VS1Np613F8KNezNhslRwh0GwqSxeaFtmwrAatE0iIz3SD+2v5d0BNngyPQMvs8vSIZ0l
         mQmMo+Obma+gCcu1GwO91S4dugr9vd0B4UB+xpEbw6KWC+4WhK5gYOwjuo+5YRz1hyuL
         oyqrGfMriwI/hZzA43YrT+Etb5Mho70/DGhy3j8Bvy/0/IoLpZFnB+NrsETZ51qExiNu
         67xQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp+mkzfcjm0cZibsneZvOCnhsUFFUCZrOLFCfFEZQVxMBzL8nQUl1UHKX+s8QfsQ/JDa8W2g4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJByRHq0ts8BsqsvaP96pxoNl+SDkaHr8B7GR6+0TISOmR6e8a
	rEPTV6/zXXBFwyNu5N69L7K2G5QUmW61YPsS91GTb+78p55uxkTBSMrco2+MGUKYp6SaQOKWVNL
	kN05vYLosgMqisgTOOe6sPoxEI83AVr3+ojRXNZYh
X-Gm-Gg: AR+sD12qfdW+8bM8CvdM2GTju/SDz/tl+3ea/sP9pFfJxUkfMjs4vEARN6yLWqza+jl
	0gJlfj6KjTFWorPn6afXRoIV0pcPB0Qa7ZGJyEezA/vEWdX8pEULUnCWB8mFH8GmC92URom3uP6
	sKJnXfxN7iMVI66o2OFaDn1/910UCNK5HQB8XtzoRatteK3jCK7UHd7RHA7jAwBU9FKgFO/0orX
	YfOz4bCo4GAzFUyqJORvV5Q3qCgxeF+Kt4YS2oj/4knXhHCRiu9v4165I8/Eo2LMg8norX+FfB6
	yaC3KjYSfjbPK2eBfEqpNuWtmrC3
X-Received: by 2002:a05:6a20:a124:b0:3c3:875d:c538 with SMTP id
 adf61e73a8af0-3c3ad78cd25mr21412312637.8.1784654911423; Tue, 21 Jul 2026
 10:28:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714215612.1528518-1-xmei5@asu.edu> <178463069007.324722.5307902735949232521.b4-ty@b4>
In-Reply-To: <178463069007.324722.5307902735949232521.b4-ty@b4>
From: Xiang Mei <xmei5@asu.edu>
Date: Tue, 21 Jul 2026 10:28:19 -0700
X-Gm-Features: AUfX_mxnCz-fE8BkgnQH--dbpmQvBuka8snMaXdhAoSerY_uAy5pY24BHX5m-EM
Message-ID: <CAPpSM+R_LvAZdmimzs32ETWf_LYrhP2r+7A9xOecpRnYUWdwCA@mail.gmail.com>
Subject: Re: [PATCH v2] xfs: fix off-by-one in rtrefcount btree root level validation
To: Carlos Maiolino <cem@kernel.org>
Cc: "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bestswngs@gmail.com, stable@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 3:44=E2=80=AFAM Carlos Maiolino <cem@kernel.org> wr=
ote:
>
> On Tue, 14 Jul 2026 14:56:12 -0700, Xiang Mei wrote:
> > xfs_rtrefcountbt_compute_maxlevels() sets
> >
> >       mp->m_rtrefc_maxlevels =3D min(d_maxlevels, r_maxlevels) + 1;
> >
> > where the trailing "+ 1" already accounts for the inode-root level, so =
the
> > deepest valid on-disk root level is m_rtrefc_maxlevels - 1 and a cursor=
 must
> > satisfy bc_nlevels <=3D bc_maxlevels (=3D m_rtrefc_maxlevels).
> >
> > [...]
>
> Applied to for-next, thanks!
>
> [1/1] xfs: fix off-by-one in rtrefcount btree root level validation
>       commit: fde50b32183f19041b4bab66c8f07b1cc38f8e26
>
> Best regards,
> --
> Carlos Maiolino <cem@kernel.org>
>
Thank you for your review!

Xiang
