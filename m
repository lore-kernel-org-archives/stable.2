Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DC633EB1A
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 20:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785874143; cv=pass; b=DO805kWZreUxPPnXSUcyNawpnZ8Hrjk63nOMmL5zEjh6m0RANqO4tL1iQj0Bvc9LdQN6z+p8RXxmsqVaZUppRDBRl4KFPIIoLfvBMQRBm3CgOnhfDmOJHkbzDOz0Pn/NSTYRKy8QWJrhQTEoOtBZ7yK0OTzsDOsQml7/xKDiWMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785874143; c=relaxed/simple;
	bh=w8embR9BTW+t5dUO7ZziHTZ8jQl44WhxcOaK3zXIKZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M3OXS1DWD2wj9g5EvjZmCPfm4qcMZDIZ7Sse/r2KRyZi0D3FH4YpkSlO7QePOTIjpZu5hV3QkKs//NsDVeo7YLzKLnvRSEFtKk6HdKI9Ru/Mtl6TViif/umt+D1Vys1wrK+c2wnrfxWdkJVzlsCQUpPHcxmUF4r6KiQGFccF0O0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g3URB2LY; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g3URB2LY"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c10e86e52so9581cf.1
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 13:09:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785874141; cv=none;
        d=google.com; s=arc-20260327;
        b=DG3m3QAzCtDOmJrz5EStiyM5narJNfdEjO/C/zY4N2HyLYagneDxdwAjzlDH73/syU
         eHIYDgmCuphk7GLLqFy9HLdy25TWNSqL/2iRUc2jEpo0Ht9V87w2loCHnJGYwYDxKN/V
         OCVcdIinDMx2XpTTgxilDLNKmpBxiv04V6PPUVpkeC7E+9IXHJ6mY/hs02UewA2tnLEo
         rpSj+0J9Did/xYgwx0y1dX1Fq6MXkjd7vVcLkM+PD9pCw3cV5KfTeIcZP/gYtIc0K/qw
         5sZySI2ut2beQiqrHkl/ToML58wh9Ze9KvqJrwRKsGle6P7Pl3XnRJuDMuzZnq16YEdO
         FixQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gLpRO5dH+fN1LCShnLYbtBYMbkUOmAnIe7RU35Aq/BY=;
        fh=+IJSwUQIAL6CHhXbP0Vj9fSZpU8eU83jL/N3Z+gVmyA=;
        b=YdH7yZ4dwnQQzwZwN7Jp6Y6sG9wknbM6wlstCxvSuyJtZVXaI/11Y3GaWDJG5znvMc
         qJTXlTUT1Dahjc48aWnY4hRCWuVtmZp81MB7QA8KGJlUDR71s7ITV/te7q7FUisB1BGy
         qKa+AelzTjIVViYJcMS483jSBL+uMHb857dAMZVCswSOphxc6J7fhM0MNRo5Nvg6m+qi
         ro+4OmflgA9i0rrCRQqcm7BoGejMuIjpgOskxLsF4CuUsHZeoiCxD3cXzwMDLtqYLnkl
         rTo5AYDmtSF4NjgsUZqk8JQ1z63oWc25N+R/ovV+94SO750J0ZFUTUUhyD8KFYKEcFCW
         fU3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785874141; x=1786478941; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gLpRO5dH+fN1LCShnLYbtBYMbkUOmAnIe7RU35Aq/BY=;
        b=g3URB2LYtL9TNdU1rHG/0OhJfu/HtdrT4QuF0CkHxYKle6JLWHAx2SHpIJOHh6ZIg3
         R0/Yn+WqZyKwKUK2q2crER4FJLtt70nmlK9hz8ECYhexQTDJ5HDOcyI7LsIjb6TQrjcO
         F7II1bcITN5sHLogGacQJVapZifmpvWfJ/a8kYfRTyWRIMwf7BBGhOLpzrTKpFW1cAyU
         k2P8wvQhGItOtxmxlmgk4WcvurKKwXP0mHHaRxEqS4auPbtXQ6E5IEgGjFcbQ7m9pmke
         HZYovyLim6oFxglMfuDeyJZqjLsC0b2n6nQgcZEuajUhrHUGM6LUff+MeNSg54vkRWnE
         cffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785874141; x=1786478941;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gLpRO5dH+fN1LCShnLYbtBYMbkUOmAnIe7RU35Aq/BY=;
        b=gi3PYi4kaJibPwujFaKIyG/AXlbMIdnVY4M9mDc3gvTWABjd1eJbIH/SM9I7+ufFua
         SBtOEYPGJKXbqvkE1vT4fyzSGhe5mvky9LtA6N0QID9sOszxzyR12iGnP/QOwGSva8gn
         u1LpVcf1tTVCVOM24mDRyDg1Yxp8WTmyMW2k4s/ubIMc36ZZPtKjSdxfDlQf/VoFzZjU
         jqKw9yHxlEZUJJFSMqArVtHZ+4xW8WyWBN5CB4YchbFrXk1wjRfydJoCZbipdenkvBDI
         7W0awJqDjL2YgssLmuF5c64Ow+Ja22TDQw7CsrR230iFqqw+TdM7dScpRMWDUb2H/7dn
         qcpg==
X-Forwarded-Encrypted: i=1; AHgh+Rq55skrn2IcBIr6HO/8XJHMJy3DiJs1Tjb4aTReT0laIfM9dwj6lX7Q2d6TYqMTVn7/08+K3AQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfNeSiCH9oDxVZMcy4op5Utz4NMu/T6eLOKwC2ZG/jvKZjvmYI
	utX/tF9UyXBpLomNmR79J6QblnQD6EfJK+fcWaH39xUyj7gzBmWJaeE5McPgAPGn0e06Gse5svK
	QAmLFwes1+efYTb0WKcbDQiiOkrLNC/EBRzwj/nVeS1Rejp1p9BJG/0YpvDg=
X-Gm-Gg: AR+sD13d37jnS4o/1R1KNroO2a0T/6wLcy/6Gkh69pXMJ8Hr1bIOcaBKydtsnwRVmV7
	G7Dq95LLp9bRJ+6D2aEWhsr0DPl+WxB0P2cq6rjri+1HeSfbptBaRRiQvjdvKB7vkyA9Jcx5NCt
	SPBo1NLOnFD3Atn2VKRxsOg6s0EF8TK30EeyM9sB0CdTqhkTEUq1Xr5Rsj7TBtWd7J/D6wrsIFi
	nf4JQICs/Zxw13L/JUQqsD5vQ9B9fcEP1v1baNBPrSYJIR1gdIfDQOwAscuC9F+8osyFZkejWOc
	UJE87QF3liPtc+KG2fEKgCngAPpzcN/u8t1M1/EzIUqvH3VUgfLSbDyrKTUyEtt3+t54fOhgUsE
	=
X-Received: by 2002:a05:622a:a6c3:b0:51c:ae6:a57 with SMTP id
 d75a77b69052e-52ce6c8ef40mr4163801cf.11.1785874140324; Tue, 04 Aug 2026
 13:09:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804122038.190270-1-hao.ge@linux.dev>
In-Reply-To: <20260804122038.190270-1-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 4 Aug 2026 13:08:49 -0700
X-Gm-Features: AUfX_mwIgnpCsSpVuGaJq123_P9l9T9DSb_2ViQo7h1MG8JSNzWnfW8YjiUletY
Message-ID: <CAJuCfpGit7zcNPGAB9D2A5+718NY-qdksxt7gUaN_eRcB_5+Ug@mail.gmail.com>
Subject: Re: [PATCH v2] alloc_tag: fix undetected compressed tag overflow when
 profiling is disabled
To: Hao Ge <hao.ge@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Abhishek Bapat <abhishekbapat@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 5:21=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
>
> In reserve_module_tags(), the tag overflow check is gated on
> mem_alloc_profiling_enabled():
>
>     if (mem_alloc_profiling_enabled() && !tags_addressable())
>
> If profiling is toggled off at runtime and a module is loaded whose
> tags exceed the compressed-mode limit, shutdown_mem_profiling() is
> skipped. vm_module_tags_populate() still maps memory for the tags and
> the module loads successfully, but the total tag count now exceeds what
> NR_UNUSED_PAGEFLAG_BITS can address.
>
> Once profiling is re-enabled, ref_to_idx() computes each tag's index
> as its position in the alloc_tag array. update_page_tag_ref() masks
> it to alloc_tag_ref_mask before storing in page->flags. Indices
> beyond the mask are truncated and idx_to_ref() resolves them to wrong
> tags.
>
> mem_alloc_profiling_enabled() and mem_profiling_compressed are
> independent. Once compressed mode is established at boot, it stays
> active regardless of runtime toggles of mem_profiling.
>
> Remove the mem_alloc_profiling_enabled() guard. Also return an error
> after shutdown_mem_profiling() to skip vm_module_tags_populate(), as
> the mapped pages would never be reused - shutdown_mem_profiling() sets
> mem_profiling_support to false, so no future module load enters the
> codetag path.
>
> Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compress=
ion")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hao Ge <hao.ge@linux.dev>

Thanks for the fix, Hao!

> ---
> Changes in v2:
> - Return error after shutdown_mem_profiling() to skip unnecessary
>   vm_module_tags_populate()
>   v1 link: https://lore.kernel.org/all/20260804064408.105033-1-hao.ge@lin=
ux.dev/
> ---
>  mm/alloc_tag.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> index 52aece27b00e..d8c36430f1c0 100644
> --- a/mm/alloc_tag.c
> +++ b/mm/alloc_tag.c
> @@ -904,10 +904,11 @@ static void *reserve_module_tags(struct module *mod=
, unsigned long size,
>                 int grow_res;
>
>                 module_tags.size =3D offset + size;
> -               if (mem_alloc_profiling_enabled() && !tags_addressable())=
 {

Makes sense but how about replacing mem_alloc_profiling_enabled() with
mem_profiling_support? Otherwise this warning will be issued multiple
times if we are loading multiple modules.

> +               if (!tags_addressable()) {
>                         shutdown_mem_profiling(true);
>                         pr_warn("With module %s there are too many tags t=
o fit in %d page flag bits. Memory allocation profiling is disabled!\n",
>                                 mod->name, NR_UNUSED_PAGEFLAG_BITS);
> +                       return ERR_PTR(-ENOSPC);

This ENOSPC error will be propagated all the way up to the init_module
syscall and it's not among the error codes currently expected (see:
https://man7.org/linux/man-pages/man2/init_module.2.html). I suggest
returning ENOMEM instead.

>                 }
>
>                 grow_res =3D vm_module_tags_populate();
> --
> 2.25.1
>
