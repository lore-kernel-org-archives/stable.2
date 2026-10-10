Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48389383C84
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 14:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791643516; cv=pass; b=m3NEfR6ITliixGC+VFO4EemGSmKDh+BLUNRrNfuC/K3nMtzVf46Ub7VVvwzdbEAYWPLcgTdH8gSn66feOlcJbidjecUIRgFHXMwA6vCF1fTT0axG0xsWdpcWZOUi2qjoJkmKlD08HDujD8azYVtXzBAoWyB1WKv0Y5lDP6UuM6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791643516; c=relaxed/simple;
	bh=tjv1Dx9mojDRn6/Nk7ipjEmycebqON8uLlu5/gd9Yz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RVpUbBktAtPn+aSPISHDfKVQAsi+Ph/jxifd+Qbr07uFMrzZRHOYNYLO3OBQ+CJqpAz0VlISSKgp1IS/vJiVC7pZKMHV0w06RGbSjbZKl1OgIaRqfgrwi9qRQSLBqQ82FtUmanuuhuxJogeVMcVreC1HzXifHxTT/uW9IcLqOXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6aqqDQU; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6aqqDQU"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b1aa27963eso3957a12.1
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 07:45:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791643513; cv=none;
        d=google.com; s=arc-20260327;
        b=CD+oEMte6Prhzvu/H1rZV+FMqCDWK4PL1GYopQnbpJ9zzhBoe4FAhbIux/4UOE3Hg1
         W8adgxM/IZ/6LMC7r/MdespBkxB8zJIgBKmj1TP8WlvUA+3VBzevUhONyGWxfUKNH8kA
         XiFKAoWnXsQpgKr2qfrEBHh1s0zDXaDd40RklqzoikiSCe9nLIIZOjLWH/iwam15T3Mk
         fuECBCMoYbhDd+gvdYeYU3u1IBkrUn25AJHLnTikCwr0ehCnVInBPOO8rlucAQc4WTSf
         Uh0WvcIWhFdd9KRb+2IMvXVMv0eD6cuWD9E4fM+o1xfcvjH0Og1+rOPhw11EUr3VF6K6
         Uxtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q2mxpDjcvQMoudiaPiTz0H/o7koOGZZNjVrfjTTYbJ4=;
        fh=hC4mMxg6Wche4fcotTy/l8oco4mzaBQqMykCNWSMBf0=;
        b=VYHwxBn2h/bL1kt8j2qp/ZOA4KAWHSiDmlhcs2lBT7Ynfehj0OP5LU1znXjKgvuy0s
         S49/eXzU8lD1EaPeqrjiODgIhCXgBo6tlr3InaAi73P4smQFAJponrKadD30bYbcEZnQ
         5xQtFaxCCWM6ccSkFCI5qmNob14Rqvj26pyerZ7OQ2dDKxsc0lpeQVpIOlo8oFj179+R
         ZwxieH8qG7rZx1XMeDK23H5WU9yae5EozE3TZ83ujyLjhUSAkqv6GrrId9O+xa3nVlvH
         YhCbSExOM+d/S/aVJdzIoezyJdD1dzynBcZHhjNscMh2B45bX+kKkia5DyS6jeax35Ux
         0VMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791643513; x=1792248313; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q2mxpDjcvQMoudiaPiTz0H/o7koOGZZNjVrfjTTYbJ4=;
        b=Z6aqqDQUaXEU0lszHXGrPXQOlHmmHoG73b6Ia0ccEwUOTRydMyX2BDTWJovRZLFeFQ
         hgP5OqTHKQV6IuNFAKqc8B8IM/60KU5YOFWm0ioLPV9eosu2nwjyflB7tPJSLDJrv72Y
         IbSKssCT2NTKynCL5Nig2Q3nMLkEs332mS+a2RufqpYX9RaJOxsnRfK8RhyFNdhaTMT5
         2gRvzNHVqB65xNR7mtBbD2ZDjJZ7J8VU48SqfQ/UXdVuxXhhy2CU9kcaWjBVPghDUdnp
         HllYX6kRBv+xJ11de2mbsVFcH0duzXno+YjBvaFQghWQF30xaxkRV9uMwSvmBGhuCx72
         IUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791643513; x=1792248313;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q2mxpDjcvQMoudiaPiTz0H/o7koOGZZNjVrfjTTYbJ4=;
        b=ovUtrrvF49feS4VY5LS/RAghAWKh7njQpv2ZWvVtTuiMDYHOOPLrPuJKL+l7Fkn+f5
         ugRUedyBpYHXfFhxlm+NcEMkCmg6BkQPn7V+gjapP2MFnoXHJyfpwercSpYYWvvFWfzJ
         Cv9amLs8/S4n/E1cO6z2KldpgTs0NURRfB8xLLFqTDXjjLJgEhesqerYfhYzLUSI6o76
         PvPASrMOvry7aiLaqIaLfxLGLruR+tA/Y5dGcjiezVvgyNDbnwHBpJ1ovl7sOGqsFABL
         Hy5a5Z1F5bAIfRSbuxhgPTJC0T8zIcNxx/npVumXnylTjVKiXHenm7c3PjuZNJoEJPrs
         /pEQ==
X-Forwarded-Encrypted: i=1; AKwUvBxkNx4T4qEyHLrko88hrD9GA5wPpgAwOGEVD/42DwNcfLSXLr7Nw2iHke/HmtgR7Y0tnP6Rmck=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ6mg5CJEjFp2pnQk9VrrgsbMtZQUg9ihlPbExoJS9LZluQTYTK
	l/rMrCrfGK5cjPMN3MgxdWPBNM5J2mYoH8uEdeTefhjF4weAGygiP8oDBB8GafJqB5deASYduC8
	83BtFA4UFpOWTAo+AQLFdYZgDKJ3ok+E=
X-Gm-Gg: AYBFou3EfxbB0Kdd7ggomsi+wgh3nYKsstqNX1uOfFZXU8XoxZNraEkdR8nBHgGQ6pC
	6aXP4+OSoYYoP8Nv3a8fZM6V9bbfPRs0CFTc1WkTpcft/4gfkM/NsvwU0BG2s2Q8mhIjPQ/nxmu
	VrWQJuy8/PbSPNBxT0AFKU164kfDDbLI5Ypq7ItfAHGIo3ehWoui/JdtDZ3xfCXl88gHjWDmkrS
	T3bAlMm4uFuLJ8y9aQiUO6Kph6PjnnPEm7yoL6NQ1z9A0ABtEoVgyPxWOYmNYSDKz2xJAVlNsK9
	NdNzPWcDBtQoWwf7BjrAuaA/VhaqBPnQCUtD+btwP4uvlXi3Oq9Eawe3VBBQcfbka5flfBA5ePG
	OcH+fh2uDdxvQuZ+tnc2eQVnQxtUMEFiy4PbydethJw==
X-Received: by 2002:a17:906:4194:20b0:c33:62c0:d8d9 with SMTP id
 a640c23a62f3a-c3362c156abmr56389366b.4.1791643513202; Sat, 10 Oct 2026
 07:45:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009212501.971158-1-linmag7@gmail.com> <20261009212501.971158-3-linmag7@gmail.com>
 <CAEdQ38Fdbx=pZ5=HmCU0C1=O+gAePAQEtd7w3oGSUX-gkQM4EA@mail.gmail.com>
In-Reply-To: <CAEdQ38Fdbx=pZ5=HmCU0C1=O+gAePAQEtd7w3oGSUX-gkQM4EA@mail.gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sat, 10 Oct 2026 16:45:01 +0200
X-Gm-Features: AclHuK9mqKRJdBvtEL1hfjaeZ5ZcV0DH_B5dMgMu_ql8of-_F8k9uCJs7svH7Ro
Message-ID: <CA+=Fv5RdML-Y2K7LV6X=SOV+GAbkWdTttFpzEXM-0thXCUptfw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] alpha: do not skip TLB shootdown IPIs for
 kthread-borrowed mms
To: Matt Turner <mattst88@gmail.com>
Cc: richard.henderson@linaro.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

On Sat, Oct 10, 2026 at 3:35=E2=80=AFAM Matt Turner <mattst88@gmail.com> wr=
ote:
>
> On Fri, Oct 9, 2026 at 11:19 PM Magnus Lindholm <linmag7@gmail.com> wrote=
:
> > Change ipi_flush_tlb_mm() and ipi_flush_icache_page() to test current->=
mm,
> > like ipi_flush_tlb_page(). A CPU that only retains the mm lazily then
> > clears its own slot through flush_tlb_other(), rather than publishing a
> > new ASN on every IPI. Once these historical slots are gone, the shortcu=
t
> > is available again if mm_users remains at most one and no other CPU has
> > taken or kept a context.
>
> ipi_flush_mm_and_page() in arch/alpha/mm/tlbflush.c still tests
> current->active_mm, so a lazy CPU allocates and publishes a new ASN on
> every migration rendezvous. The next flush then finds that slot, sends
> IPIs, and the lazy CPU clears it again. Nothing breaks, but with
> compaction running the shortcut is lost after each migrated page, which
> is the case this paragraph says is gone.
>
> I think the handler can take the same test as the other three:
>
> diff --git a/arch/alpha/mm/tlbflush.c b/arch/alpha/mm/tlbflush.c
> --- a/arch/alpha/mm/tlbflush.c
> +++ b/arch/alpha/mm/tlbflush.c
> @@ -66,7 +66,7 @@ static void ipi_flush_mm_and_page(void *x)
>         struct tlb_mm_and_addr *d =3D x;
>
>         /* Part 1: mm context side (Alpha uses ASN/context as a key
> mechanism). */
> -       if (d->mm =3D=3D current->active_mm && !asn_locked())
> +       if (d->mm =3D=3D current->mm && !asn_locked())
>                 __load_new_mm_context(d->mm);
>         else
>                 flush_tlb_other(d->mm);
>

Well, spotted! thanks!

> A lazy CPU then clears its slot and still does the tbi() below. Any way
> back to the mm from there gets a new ASN: ev5_switch_mm() sees version
> 0, and kthread_use_mm() goes through the next =3D=3D current path. I have
> not tested that change.
>
> The callers have the same asymmetry. flush_tlb_mm() and
> flush_icache_user_page() test current->active_mm, so a kernel thread
> that flushes an mm it only holds lazily publishes its own slot. That
> one also takes the shortcut in that branch, so I would leave it alone,
> but the changelog could say so.
>
> > Order the slot reads after the page-table changes with smp_mb(). On the
> > publishing CPU, the store in ev5_switch_mm() precedes the scheduler's
> > post-switch barrier in finish_lock_switch().
>
> The barrier there is the mb() in alpha's arch_spin_unlock(). The
> scheduler does not promise a full barrier when it drops the rq lock, so
> this is an alpha property, and nothing at the store says it is being
> relied on. Could the changelog name it, and the store get a comment?
> Something like:
>
>                 mmc =3D __get_new_mm_context(next_mm, cpu);
> +               /*
> +                * Ordered before any use of the mm by the mb() in
> +                * arch_spin_unlock(), when finish_lock_switch() drops
> +                * the rq lock.
> +                */
>                 WRITE_ONCE(next_mm->context[cpu], mmc);
>

Agree.

> The rest looks right to me. I went through the window between
> finish_lock_switch() and check_mmu_context(): an IPI there clears the
> slot under asn_lock, a flush on another CPU can then take the shortcut,
> and check_mmu_context() sees the zero and loads a new context behind
> the new smp_mb(). The three points from my v2 review are addressed.
>
> The fork numbers in the cover letter are from before the handler
> change. It would be good to have them again for this version, along
> with an SMP run under compaction.
>
> With ipi_flush_mm_and_page() changed, or the changelog reworded to
> match what it does:
>
> Reviewed-by: Matt Turner <mattst88@gmail.com>


Thanks

Magnus
