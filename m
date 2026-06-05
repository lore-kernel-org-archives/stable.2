Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636111FF7C7
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 04:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780632253; cv=pass; b=ainTYrcnThYMPWXla4hzuvCICKH7oWavTIhebqkcu1GyVcxv2cyx76vwdusQ3Qzuw4eiWpJaQehX0n0kwCQm9kJXFdyFFtU6K0guInsrFRmk75cPJtd/lAMIt7NKve+YpHLiHq6Wb+vplWDW+n6ytubWWfIdDpoOF+rHMkaf5AE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780632253; c=relaxed/simple;
	bh=SMu4Bnd9qcF0Ipjxn09C+Ag2Z7SqqmA3tmv+df2kGTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rsXtTpskeF1TsuybjZ1EPdyBez93AESjsoTREwAjo/OXLTfLha+ceRP4Q4QREnyQOo94O3qeEqyc2j7e71WDFKMzWCXGhZ+7tR79zMtKNZL3zTIJHG0Ony05QDVnkwq2skRxrHIyVmrqyJeRot76CO6V+ZkN4TbyvqbOA5VRvZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=R3M1lxtL; arc=pass smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="R3M1lxtL"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-43d34292872so734915fac.0
        for <stable@vger.kernel.org>; Thu, 04 Jun 2026 21:04:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780632250; cv=none;
        d=google.com; s=arc-20240605;
        b=Gf+vanVbR9DvM63L9FlROGZuTz2zPBgWl9pEPNBX/oqbaP9MZPECfN/R2eVk6/8z65
         GyHgZil+Jft6PKQWmqbo2owATDQthvIeeAxaqr2mBpTGGUG5cdDUzwxgpItwTVRT1zgH
         P5Y0tqdTjMI55NPRwq+/IhkdMNmg/KKwKagVrkvoza14OMfJ12tFZiJTmZVCv4QyDO3E
         hmfBntR8Ezp8kc0V2vcnw2nnNhZ0Zd4dBoEQ19f5URexC/HGOw90QN63mZgROcpK55uz
         lOVkctsWp4tBKNrwPymbwuZP6b9fLsNJTI4ZqJ6dxHIJsDxi8H8G37195o8GbYnbs62n
         3ziA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WU2MZ9gTzdCxj3z3pNHIH3hYvAv4mvLkS53mP/Ms51g=;
        fh=G3jU7e5zzN6umS4eiwZmklrEn+5SVKMbtoubLpWWEhQ=;
        b=FpO9EVUe4kua1Fg0GUHAo+/LBvIzpYm7wDfO9RdmoN9mtheT+kUMOfutAFrwJ/8GT4
         WBB+BAg0ul08OqfdzNB12iqVp4U5okX5lBT5fjvSEVkjSjctE7LuyItPUZFVlcYBEfSf
         zmt8fIgm6kbh1BKMCzKrY+r6dYMIeNFzgjV9WuQU6M5PrYLxPr1Yo+WSf5kUde2CN+6+
         hC6+bgY7P3kNSgTcPx+8zD4VtqaNTSXhKZCWFCumSoQsLz/Sr3RkgUY0ZS3jJAwKKLeJ
         GqZPeiB+RtuGbXm2I21frmC/4SgC4JP9qhSPHfSmsXtUzzTPYF5oUGlukQqfYHC++uxx
         MeAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1780632250; x=1781237050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WU2MZ9gTzdCxj3z3pNHIH3hYvAv4mvLkS53mP/Ms51g=;
        b=R3M1lxtLxIX3XP5deIQo0jvwveq3rzNqnAc8MhljdfR1W2aQ22iD/2nHt9vj5oaEgB
         Zbfl1C51RsBZXlAgs7PZeXOYRKc8bIMcrZ+/Md7Rt8kqRq2sBh1LejVP6Uzw3eNVxMNm
         3uaExvugUf4u9LsAtBfrubWuA1D+hHYU1TkEK7MkfPj8a6AJuNwJE4r5iviCv6AMIvVJ
         o+mkgEJ0DMgpRxaHB/WNhCLmTHHtLWwMnpC0MLI1tqKCkRKl0WFBepuWs3fHUFNRcUyA
         Xg+NPUz3U5Wr8h5gynutXPIbDElVMJy4MJwJU4LifVsuEthi8nND+Snoo6Ru1KWN2ULo
         WblQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780632250; x=1781237050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WU2MZ9gTzdCxj3z3pNHIH3hYvAv4mvLkS53mP/Ms51g=;
        b=TSzWnLpKggA23aC4yLV5pra3P0yfVM/nw3X1TQDv5oKuJmtgWU7RrVeImihInmm6ws
         k9EM1FBxxzQZqkflN3jU1qak/cQLZhTNXSn1elmyH/jq9dElGLOPpLa7sBb6vL81F97O
         NvDG1CmTNR0u2TcX2ZViihrem2VGk9PrBh14UzK66Velz6NPi9d0hL7BDETgshcudoDj
         +2Wxar4E4Si2Kwg4di2oF/9y8OKO3aatZuJPgIxURgqiQRdZnINx6fVWq+7YM9h/wDOD
         MgtkHcwD6weMzrllLiNL+N5vNeql2x6HUnPFCTVVEZe3y95yoDOaEmQNCQETGL38py3X
         LlZQ==
X-Forwarded-Encrypted: i=1; AFNElJ/GWPSr8fiXJB30oxU9qy0GXTtUClWw46whoRoyrO+u1hVIpS8QA0BiKZUQMukx/vSGJ+2+DAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRg5e6Fz5osmhq30iwKeg86alBAPlubb6SBIQUpvDj5hZbNz6N
	a2joDewsvk+dYWuvDljQFGHZVmZ11gx9vQ2wObPSX4re9+MlcXN25sPgJkUCGPRkJpHCVUnp8za
	05+k6tvVmGi0w23RUhYjXnNIgvRzu2lXHecU4c+0v8Q==
X-Gm-Gg: Acq92OGgL8mjOqZTqhgsteNMVPEPAdjYtN70qJEodjmN3ofN9jSl6la/8UVHc+SbgZW
	RWcXX9OhpG1/OPduRgWgJy4EnYRo4LvKXBX95Pnd7D0mxzOaSTEmbud08voH10zTzaaLwGYShFZ
	r191CXUPvdaP2hz7eeP9yHpxHdet07LZMb+tWknOi5/HYJV7fSybBOY6LQyZogS8osw+VtQ/avs
	oYJTMpUphvvWmx7xPyT6OA4WznKJh/FkJ41kf6/hyDdQiKv/LSM4bZHA0MTr+lx2sOBlz3k+3B8
	ZbMg3LH+KZdoOkd+3wPR
X-Received: by 2002:a05:6871:729:b0:440:e18f:c17b with SMTP id
 586e51a60fabf-4413d8c1927mr1043972fac.14.1780632250264; Thu, 04 Jun 2026
 21:04:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515065048.94564-1-cuiyunhui@bytedance.com> <252be770-4d9f-954a-9388-8f7b52a92d90@kernel.org>
In-Reply-To: <252be770-4d9f-954a-9388-8f7b52a92d90@kernel.org>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Fri, 5 Jun 2026 12:03:57 +0800
X-Gm-Features: AVVi8CfJzfw8QQiRtunxFq-NUfTJkIEqAOk44niae1WxngDtB7-RHX2XNxBPT3Y
Message-ID: <CAEEQ3wmnZnoDm_YvHTwSdTs1RJTt009tVFQM-TtS+6O8TJpG2w@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] riscv: mm: exclude invalid THP PMDs from
 page table check
To: Paul Walmsley <pjw@kernel.org>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	tongtiangen@huawei.com, akpm@linux-foundation.org, pasha.tatashin@soleen.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Sat, May 23, 2026 at 7:10=E2=80=AFAM Paul Walmsley <pjw@kernel.org> wrot=
e:
>
> On Fri, 15 May 2026, Yunhui Cui wrote:
>
> > RISC-V THP splitting uses a temporary invalid PMD state where
> > pmd_mkinvalid() clears _PAGE_PRESENT and _PAGE_PROT_NONE but leaves
> > _PAGE_LEAF set so the MM code can still recognize the PMD as a THP spli=
t
> > in-progress entry.
> >
> > That temporary state no longer describes a user-accessible mapping, but
> > page_table_check currently treats it as one because the RISC-V PMD
> > user-accessibility test only checks whether the PMD is a leaf and has
> > user permissions.
> >
> > As a result, when a PMD-sized anonymous THP is split during a COW fault=
,
> > page_table_check can account the invalid intermediate PMD as a live PMD
> > mapping, and then account the replacement PTE mappings again when the
> > split installs the PTE table. This leaves stale PMD accounting behind a=
nd
> > later triggers page_table_check failures such as a non-zero
> > anon_map_count when the folio is freed.
> >
> > Fix this by tightening pmd_user_accessible_page() so PMD page-table-che=
ck
> > accounting only considers leaf PMDs that still carry either
> > _PAGE_PRESENT or _PAGE_PROT_NONE. This preserves the THP split semantic=
s
> > required by the MM code while preventing page_table_check from treating
> > invalid split PMDs as live user mappings.
> >
> > With CONFIG_PAGE_TABLE_CHECK=3Dy and CONFIG_PAGE_TABLE_CHECK_ENFORCED=
=3Dy,
> > tools/testing/selftests/mm/cow completes successfully on RISC-V after
> > this change.
> >
> > Fixes: 3fee229a8eb9 ("riscv/mm: enable ARCH_SUPPORTS_PAGE_TABLE_CHECK")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
>
> Thanks for the patch, but it doesn't apply as-is.  Could you fix it and
> resend?

Thanks for the heads-up. I have fixed the apply issue and resent it here:
https://lore.kernel.org/all/20260523042052.35476-1-cuiyunhui@bytedance.com/

>
>
> - Paul

 Thanks,
 Yunhui
