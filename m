Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCDE3E0C67
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 04:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782794584; cv=pass; b=ZEGNQi2EF2rHv2C22KIwgg2fFVOscvCR1P5bnG6WsXuiDKiaNvIEqqd4G+yU/1v72g5N1ZalRK1B6rJdoYtMcGmDJxMledmokMeHNru5IzuevRGUf5KaF/F9lZWNdktnPfq/dYeIXAnWNXqR6KlL0J6Pt15DZcSAdtlQ63Jh5TU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782794584; c=relaxed/simple;
	bh=ML7QEKbCRptYZgAfgwwWP1fX1s6dzYdPXJ7jhGC8qnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fRxsKYgHqTIHy/4Y+pAIYyGrdyh10nKaMx0U+4Dl0z3SQHWIBYPSc0M1xPKDOt4nHzZEzQszAqxU79MbA3SCtSF47yegKpv+tSHxBcRDE/Dl054jnm0loYTpbCzE6Foxy+KTSfPyFzrTwgFEXQnk0fmx2NF0kvfQ52hi8o+4ibY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Lt1+DV48; arc=pass smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Lt1+DV48"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-495f312b086so38946b6e.3
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 21:43:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782794580; cv=none;
        d=google.com; s=arc-20260327;
        b=axpKKYPxARq2KmulMvksw3krIOVxlK6V9DVTD0g/cifrdtwT0QRc1cnnbF9+1vZURg
         1xF9KUuRqoSWD62BYgGg1rBohMEo1y22eMlk38defnx89cat4AXuhSy5MktIkXH3bMZa
         pwA9X8cia95nhwcmEOF3XSxjlUqofB37X359poVwlYILO3+pkBivOp5y8Qb8MSnP8l2+
         zUgOInG5RrdeMnTJzmQnVX89cHdohRRPlUtuy6fePYDOsq2dGGlqKSbXk/qNRpCPWS9k
         t9KXK2XpzVPCbKV9Pq/QsCYgil+fkOcOb6JQpO5WhTHXPI+dyMiisTzPQSFINUPyfN2M
         Qt+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TkcngDtZZBcSBYuktpVSvj/Zq3c5gyjbDMX0CALcXeM=;
        fh=u5W5ejdjkavZXOnnkDm47pDkHlazHViYWQ5KBXug7b0=;
        b=aoRkQvpkvU2rq3G0BUDyitbOyED7mzWiBGyvNk/xDlAnCmPUngAbziq6stzw0lzy9T
         MvQ58nkzEOfRnL1rMsWH+0rzUS4zPiL04QC+3uL7Ju61bmEqpkNG3LnXQRmjPLsvVlxU
         AOEuruJpXrzhYPDvVHA0vzAypb3vH2tDjeAVK6qjws4QsdBYMfNJ1jaMgad4D2FOYtde
         5716GG36f32o0ITu9cZYQNl1uDXSWwkPlGHDaPzteGbGlieKAA/VpKeBy3bpwcfj4JJU
         x1R2ZoAdB5FOnqAon2KYDHxYk7l0NlwLv9Znux4v8HICZa7d0LAeRT3qcy7rAoEMYJWC
         Nl/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1782794580; x=1783399380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkcngDtZZBcSBYuktpVSvj/Zq3c5gyjbDMX0CALcXeM=;
        b=Lt1+DV486SFojwft46ivqfDysbSDBR6BUn+OpJMg79zzaeUNhxyeWH0ASO07p/kDAB
         tUMxmgiFoud7HAeMbEBbdMSnMqwthQK3/58HBrM81LEq1lrjRjWwXvBM7lXB9+txWXEv
         qR53Fvgfont+KErXhAra8U69x/rEbZjkwWcXx+YRwEuTHFMYetoMNg/RaknimpXUUDcC
         BlxSgat/eJqJndmzGccghQrzJtRnbq/0qAUooPMjfu9UT8YpkGPL+tufUhMo1XVtSFWS
         P8ylJhRjHs09cMkE1RgYZ1cOuKut19tph8rZ7j4lBkm0osmtkMNyXm6ofg/k+I4j2KFR
         t9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782794580; x=1783399380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TkcngDtZZBcSBYuktpVSvj/Zq3c5gyjbDMX0CALcXeM=;
        b=TbwJ/E077pO3GYBaE8NFyow6TlrPoMZHRnmdmkfP66P9yvCZhzRJH0Og1YFx9Vy3z/
         1mx6RMpbGiuUwg+ZMJ2PNXJ8NXpcuGiRWWGOxNX3Tcx69rPtHI0v1x83sYh4riV/AUcB
         W3O4gRv4xegamUidnTraxuqyEX1NWU3mCDB/fh+K5xwqh7Ps7mOrdRBkMhvxVNUIMM+D
         4q0VoQYnYu+2dJn2a04B3OhEzJIUFEZf/9jp4tvnc+lBQB4TMqN0XqyWr8gnlKr+L6lF
         JzgkyESoiANLaeCZBlwBi+iNnXhMgwmaCZZI2JQOnfptYgBgj1pJxJYc677VJNbrC/Vs
         SU+A==
X-Forwarded-Encrypted: i=1; AFNElJ/ZZ3SjO/vkrMUNVr3PAsWA38gMCzxAK3uEtIdd8nhMIw0krmTk7Lm3H8cqZ0l+Nd2Uhejspts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1d/IhBK2wiv+c96Zpw+ThnocfuKJtAqTMRwInkOaHRC53UfSV
	Ad6dJRG4mn40jQTjycRL5XNMr+VV5vXSp6gkgIhaXb3WEp950yj0ac/u/ZxpBmYjmSN+bCOigId
	E4HUr+P5NCVFjsaQs3fGl98Y99Xi/iFldgZK42CuQGA==
X-Gm-Gg: AfdE7cnPtIz8cF+N2g02hK7ExxIKwnI1+QGEYq6qeMg4IHXHWGk1QLojXgsk8aNQdGT
	crV5a4154i6uxU/F6BMiOywXPnSRYTBBy0rfBIh3RQX7NeJgG2jEAYHxSxGhYNDz94NaJmamDps
	qfbuvRqJazA5LsUWgRKA0dNchbHlz8amQhNWymDbYBYbTZ7TVeUoDHKxbMhFqTlED/7nEuzcBco
	ZADJ6ll22tXMvssUrJva+rkjkLavYVzuM44d7undf6dAf10qupKq6bFZVvl9hS/fbqSGT3dMBQ=
X-Received: by 2002:a05:6808:c2f8:b0:492:5bf0:d29e with SMTP id
 5614622812f47-495eafc41a8mr2097270b6e.34.1782794580112; Mon, 29 Jun 2026
 21:43:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523042052.35476-1-cuiyunhui@bytedance.com> <20260629210432.ef76ce885cd9ccd28b7a2127@linux-foundation.org>
In-Reply-To: <20260629210432.ef76ce885cd9ccd28b7a2127@linux-foundation.org>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Tue, 30 Jun 2026 12:42:48 +0800
X-Gm-Features: AVVi8Cf2cA6T1Xo7mNpI3K1o6jk4PWx27zkWEacArefsJbxedBCHcATc89AHDzk
Message-ID: <CAEEQ3w=XVq_y1kG8YTHkwavB59R3kJXonX1G+QmB+TTin-BFOA@mail.gmail.com>
Subject: Re: [External] Re: [RESEND PATCH] riscv: mm: exclude invalid THP PMDs
 from page table check
To: Andrew Morton <akpm@linux-foundation.org>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	tongtiangen@huawei.com, pasha.tatashin@soleen.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Tue, Jun 30, 2026 at 12:04=E2=80=AFPM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Sat, 23 May 2026 12:20:52 +0800 Yunhui Cui <cuiyunhui@bytedance.com> w=
rote:
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
>
> Thanks.  This seems to have slipped through cracks.
>
> AI review appears to have found a couple of related and serious issues
> in this code.
>
>         https://sashiko.dev/#/patchset/20260523042052.35476-1-cuiyunhui@b=
ytedance.com
>
> perhaps you have time to take a look?

Thanks Andrew, I looked into the Sashiko findings.

Both findings are pre-existing and do not appear to be regressions
introduced by this patch. This patch only changes
pmd_user_accessible_page() for page_table_check accounting.

The pmd_present() / _PAGE_LEAF / swap soft-dirty interaction looks worth
checking separately, especially with CONFIG_MEM_SOFT_DIRTY enabled. The
pud_present() / _PAGE_PROT_NONE case also looks like a pre-existing helper
inconsistency for PUD-size huge mappings.

I will investigate both separately and send follow-up fixes if they turn
out to be real issues.

>
> > Fixes: 3fee229a8eb9 ("riscv/mm: enable ARCH_SUPPORTS_PAGE_TABLE_CHECK")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > ---
> >  arch/riscv/include/asm/pgtable.h | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
>
> I'm not even slightly a riscv maintainer, but I'll queue this up for
> some linux-next testing and so I can keep an eye on the issue, thanks.
>
>
>

Thanks,
Yunhui
