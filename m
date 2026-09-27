Received: from mail-ed2-f34.google.com (mail-ed2-f34.google.com [74.125.228.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AF842046E
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 22:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790546417; cv=pass; b=jgMJ58hIbk1ys++pXJ94F/VlNuP09OCM9atR6UJ1KnAFViU8FoVWNf00eltJQhHnrD+6NyQxlrA96jWr3DEvJsTpHj/EkiHiVJThTvT7lHsXYyIkK99XNYRTblV32dySeC3OPn6/WzYmO409VyYdcQ8+uBWMHcg7bas9mgFYxxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790546417; c=relaxed/simple;
	bh=ojnNpFAcs+aJppljgRUBBPbKoV50tBwIukLugjIhzxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GntmrPjIYnjeL7n0f1IhG37ZpytLkTLXLsJnTMdnwsdJPTZQMHTMXPmG5Ybj0lkrISLkM+e9v/xU5a08fqUvmJpIMUtBmO3wb7ekf6qwtI+WrfVf3GberHF1YeMyFVibZyTsMdQ/56zvH86E9fGdeT4UEMutVRBW9mdHrlP5xSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLTqNPvj; arc=pass smtp.client-ip=74.125.228.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLTqNPvj"
Received: by mail-ed2-f34.google.com with SMTP id 4fb4d7f45d1cf-6aaf688ebb0so2355197a12.0
        for <stable@vger.kernel.org>; Sun, 27 Sep 2026 15:00:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790546411; cv=none;
        d=google.com; s=arc-20260327;
        b=OUzbcz/jsNDNVIbK+G4O0VgKri/qH2PzD/EjpIlfGVZ51xsOeJQWQ0u9Sly/KmDqFR
         ANaqRByDBIErn+NaU2usOrPNNBo6sw+G9UNTJJkMEFJwCkJvdMW9rD8DCfbS6jPewrhy
         1g2jVVqKunbEd+Ng97nNrhoT2gY2hvvSCGxF2ad7cl4lveq09D+krR9oySQNtKVPQNVu
         U9tJLdmyZcbITxGJoMDN7T+PZaWPZw/Gw+sxa3fYgNZb5eDYDgTbC0m3QufkP9sl7wW1
         0tu3JfsYc3NcotZCHVotqHIMLBfPfzygiS8Na+o+A+aOJ/cnZRy66cCMFkbsnwuJg2hv
         bVtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w75/rsx/tttnCbPtKQAiCIgV7C32qVgicTV8Ei4olls=;
        fh=vI8oTg7A3Gsqkzf1bn68+teTFKz/FFMD93BWFLgWQIE=;
        b=cUB//HLDV+u6rS5laHzDvv8b2UrMORCnUwp/mRFIhBkd+eCZg1GgSFvk2OCM2P6RE9
         syZqjwh4EZFdhU9fBqU84Xi9+0gXtPum6zeVXPw/9d6TZ+2oQ692C/C2Bt0WBImIKEy2
         2Rm+yM49JJB/ueFWCyeGJeb3TBwI7ck5JaUbLUAmmj5FMM5jGK79wXmVNpRgMfKsui65
         HgdpI3+0HBsg2KzpNz2dv1VvEXQav8pyB8jIcMsd+10dhfjeN3BUuWvSbfVmbqdRpo/0
         rukylvDk5cc5+9caSEci7wVxqQ1+zTS5cvoMZNolPoKaM22SCBbkgp5C2ZRe+1xYkjvt
         wb7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790546411; x=1791151211; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w75/rsx/tttnCbPtKQAiCIgV7C32qVgicTV8Ei4olls=;
        b=NLTqNPvj3qzZbMUP3ZtdtDhCOXB1ElkeZ7kkKY45sAQqy1m+EDcaEy6NDHyX/yShCO
         /TRlsiWtUTSpU3rC0xS/PBFa3QeD8VqdkEpMtig2M8h8X8bGezkYrbbwYRmmlE5y8aXE
         l5RzIY+NTSSYjp172r5KVKw9XfA82emUfRxQ3ggZyOlydIMUQBfnAmLesYs27Ymxfk34
         Yx4CX5wbESfpRuyzzNxEGkJW8vxfyki3sh0CaeGn+iVx82BQ2KRqg0xy0+FxvW2NSGku
         vXJbXwfPH+IxGrZhusqyyulYNthPpbRqk7fIB4RWLUy67s1Mtc5bu13RrPUU1G6Yp1Pe
         Vfxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790546411; x=1791151211;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w75/rsx/tttnCbPtKQAiCIgV7C32qVgicTV8Ei4olls=;
        b=g2PZbBeVK6L6m8ruQTw/eK2f3kXt7TY5RdLY+rUx0/0uHMqV/rUO8LCq9tOAQdXCGo
         AbANELzyyniv3hHpzTszfbL/4PFmCldzsa4BbiRthdNu/+21GY6BK9vcBOoRSu//V9OR
         +3e2OuDp3FhxRoLbRGd3/xBtG4M2Ziz37EX3+Trk0UFl7QYtWHCOhhnJcj4fyCrBX7CG
         Fsczyz65OxRJLn1O4u8URfBP8o1FHB4hYfbryiuLhyF6s9dBoct4JMoFGIHuA1hkxUte
         E45ZVzuCfmdpL77Zm2wXcyhKICCHheQr2IYNhbdOKB+LeQHwh614jK+FHBCbmXFKsVxB
         wk6Q==
X-Forwarded-Encrypted: i=1; AKwUvByxP5qEhHD2DoDyJYNlm2RFyHLaYjaPsMYSITmatyWZZVPnfLjEgbesvn+nqnEeFW1agoQvJ70=@vger.kernel.org
X-Gm-Message-State: AFq9FYI7m8p62VP2JKjT+Zz19EZtT0528zw64v5GFwUyWU5m8kcodoWs
	ha/hk+v/ekIsIbUKkMYP5s/HnululajEqem3n3qhxsn+igN5CDpdE3SuNkVu29WPYMzEGGmDJIY
	d7b/pQaqpsC5DHJ7z77GQ0Da+kj4G7pyDp7is
X-Gm-Gg: AYBFou08W8ZH0gJrJwl3FKwWZ9y1MQgSgqrzNDy6idF90VIwQ0ePuuSmjyH1PBoW2ul
	Y5OpgiJz8qOtIEsA9Toqd3Ii4tLLwIc8x2l6jV1ThSc8RJ5cCNhTekkNFcftgs7H56B9jZ1MfMB
	mWlHOifuRtIgI7Pl/3cEWcv5xxrleOiQ9GLHcoXpYeFa+J2vSlFbjYtgEpKWWXYCds9/kX8cOjC
	z7egsd/0mF5vLEOq8KrrJajgMhYWsftdYHa5bTeCLpOokvJgd/kDCPjx9lHS15LKzewer8mPdRs
	d9n/Qo6J0ck9+zKa5KCovSEDqgHrJKKrAvu/cdGJSwUcMPtMkfAs2fy7kgUcBdr3Lu1IG0zYprY
	nroJYH7/C19GYbIjx1fMEi43ODIk17XQr4KHJu4H76A==
X-Received: by 2002:a05:6402:e96:b0:6aa:924d:900 with SMTP id
 4fb4d7f45d1cf-6aac90efbf1mr9690769a12.38.1790546410412; Sun, 27 Sep 2026
 15:00:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927005743.8299-1-kaloz@kernel.org>
In-Reply-To: <20260927005743.8299-1-kaloz@kernel.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 27 Sep 2026 23:59:59 +0200
X-Gm-Features: AclHuK-6m-r_7jB5HpKM72-JdYXDgtlwLzDmRV3LgFit-40iHT3z-9gejMq9kFI
Message-ID: <CA+=Fv5RjY_7VHh-aqPrwPd99hUVrQQWiScbPAjAgXAHtSJWsnA@mail.gmail.com>
Subject: Re: [PATCH] sparc32: add the CPU to mm_cpumask in switch_mm
To: Imre Kaloz <kaloz@kernel.org>
Cc: Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Imre,

On Sun, Sep 27, 2026 at 2:58=E2=80=AFAM Imre Kaloz <kaloz@kernel.org> wrote=
:
>
> The SMP TLB and cache flushes in srmmu.c cross-call only the CPUs in
> mm_cpumask(), which only switch_to() updates. exec reaches switch_mm()
> through activate_mm(), so the exec'ing CPU is missing from the new mm's
> mask until its next context switch.
>
> If a thread created meanwhile unmaps memory on another CPU, only that
> CPU's TLB is flushed, and stores through the first CPU's stale
> translations land in freed pages, as when a detached thread frees its
> own stack. Only sun4m cross-calls its TLB flushes.
>
> Set the bit in switch_mm() as well. Tested on a dual-SuperSPARC
> SPARCstation 20.
>
> This has been broken since 2.3.35.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Imre Kaloz <kaloz@kernel.org>
> ---
>
> Notes:
>     No Fixes: tag: this has been broken since 2.3.35, before the git
>     history.
>
>  arch/sparc/mm/srmmu.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
> index 9a74902ad181..7d423e5fdc94 100644
> --- a/arch/sparc/mm/srmmu.c
> +++ b/arch/sparc/mm/srmmu.c
> @@ -466,6 +466,13 @@ void switch_mm(struct mm_struct *old_mm, struct mm_s=
truct *mm,
>  {
>         unsigned long flags;
>
> +       /*
> +        * The SMP TLB flushes cross-call only the CPUs in mm_cpumask().
> +        * switch_to() sets this CPU there, but activate_mm() at exec com=
es
> +        * straight here, and a CPU left out keeps stale user translation=
s.
> +        */
> +       cpumask_set_cpu(smp_processor_id(), mm_cpumask(mm));
> +
>         if (mm->context =3D=3D NO_CONTEXT) {
>                 spin_lock_irqsave(&srmmu_context_spinlock, flags);
>                 alloc_context(old_mm, mm);
>
> base-commit: 62f4c998b297cf233997a2b4cd6fc2d2df0319c9
> --
> 2.47.3
>
>

Nice catch! This looks correct, and it matches what I have been seeing
here.  I think
this is one of three mm_cpumask problems on sparc32, the other two are in a
HyperSPARC series I am preparing: smp_flush_tlb_mm() narrows the mask under
active_mm and can drop a CPU that is still running the mm, and the cache
cross-calls are gated on the mask as well.

The last one does not go away once the mask is accurate. mm_cpumask records=
 TLB
residency, but on a virtually indexed write-back cache a dirty line outlive=
s the
TLB entry, so the mask cannot gate a cache flush at all. Broadcasting it
unconditionally took a fork-heavy reproducer from 70 faults in 6258 forks t=
o 0
in 5798  for about 7% fork throughput.

I'll build and test this on my SS-20.

Magnus
