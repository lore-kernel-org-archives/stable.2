Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394A844998F
	for <stable@vger.kernel.org>; Sun, 11 Oct 2026 15:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791731367; cv=pass; b=Q9vJ9FOPrEkQ3IJ+z83UwMbRrMoRkxYjv6kmfK1liKV9+Eh6McK0byh3QTXAA0edV6F3peIWQQdFbFtGcG+F9h4lNGK9L3Mr8ettyj2Xexpx4AdLzkHnBaJo/TTLOXbHHXaANjDZqAFeXIKKYUdAT9oie7PgM7zk2V0b/EK5Dt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791731367; c=relaxed/simple;
	bh=K2AzJvWmFuXl8WjO1KJdfYR7kz6Z7a6AQW5/wUEyPLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kLUe2zKBT3aY50a2WTquW+e9sKJVuE4B0eZ11olfsEgcpvJViyoAlfmW2JpQ5KfcztRrM+VOFpdIJILtTZyI33jVKz3z4wzg70gBrY36wKbqdgOB3NHfXuL037fWaB5nuyUdaXJp9XKFwwa0Br8USZ0QQRrF/ejUDla3ZImxBNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLiUMiyM; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLiUMiyM"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6ae27f06c2fso1724681a12.3
        for <stable@vger.kernel.org>; Sun, 11 Oct 2026 08:09:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791731364; cv=none;
        d=google.com; s=arc-20260327;
        b=q1rjRnN8n5Zlx5k44Ab7Bra92jbWJmapQAlYOP4FtKPZPo7pQF+WO1QQOlXngqj9nX
         rBipKpojNfLJVT1JyOVDwypDDfmGiCtoueuvgsVpPhsCOzO2JgUPDKeXL5PgUq5/nZFZ
         f6UJxjWhwTYyLYWmUSJw7uHJcw77bKjoKbspVntNqxpfVPNk1wxWCbx8dWYXEJwwp7CA
         rbE0GFObhDd8mMwuiyOmh4JUk1i0WrrBh4Ey+TextcZlcLwuLWuMrkpg/OzJNfcpqO6Z
         WFUJh6u16us9etv5VUs7Ib3lIheEJj4UoTS+j3paA4i668a74jkxZMxmzdxJhHcVlwFl
         VwFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7EhW3wTNjaZ800qY5zEi7YbceixPkrVlHD9ZpRRBYLw=;
        fh=0GSUwn4cZF/CWMFHycwtedP363z9o4NuLIuwntMZqas=;
        b=pNh4Tumm8XhmQNLmA64ZdI9FJ1h75thLXjgU4WBVPPma/9f4gfvSHY5hX/bpqo3rzG
         vOod3018iOV5d3NutThAUacjuqpPL8JtNlfdv2RYLc2kgauSNWj6bSawnJmhYy3dkLDF
         KPV14+lC2v4ANEtQ1UPsC50YRcqyBdOrF3pFQzWfb9tXSAbdac4FrzBIFYDBK+z0mCYX
         n+wo63U9sguXF0lE6CftMLYh7jNVTCRc/kHXPcg9zHR30xCFAwq0sTgog6P+p63BQDgx
         5plheDBvB6nOGWNI5J6t6sbzfaSzU8s3A4W3jG4ct+h7u5ixELWoUeKsq3MDdXTDxelu
         ZCww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791731364; x=1792336164; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7EhW3wTNjaZ800qY5zEi7YbceixPkrVlHD9ZpRRBYLw=;
        b=SLiUMiyMYNurvQ680L3ZJ6V+ZKEf1XXqvua4B1/2rH2K2/FrfI434SD3YBgpTR3ETR
         GsbTPksS/99xr1/T8BQsabOhpdNsfXfsG/4oa1fUSZ4lwyYxiW+hGBNQiVQdAyPhJI+0
         pkmiVkKlniBBU3GW/CYWdys/5eCfE4NSaVBrXzctIRoWGtDAetLhRH1BTTiHXTw0Ct9Q
         7XTXf3cx+B7b6csmBgH/LBVpIwwlYhZwUrsY3AAiT6fwdcEAmJaiXtkzxp12dSqAacxF
         bpLZ7pI7WpFSD+PwOMz/RakkyUvKybCeVnUUVOFpilTDisBKfJJxRCQcwRgIsQH9GAys
         p/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791731364; x=1792336164;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7EhW3wTNjaZ800qY5zEi7YbceixPkrVlHD9ZpRRBYLw=;
        b=eShhm0f7sbolC9waiAfF05aDKA2A/U0RfZ98duSVgqIRihfcWtyovxLiXCxNfcRfjN
         v7LSb2HWit6u0398EA9kx5rtPVkm/aZchjZ1w6ZrT1W8sZjRmSMcBpFmF5tEt/UpRbig
         hKF/PyhJSBZFDC30DH2siyPsW4L1S19SIMOJll+km2c4vOpkGr/4eVecoyrw/VAkAuJ6
         ZlLX/eC8f9Q12zfBWnJytR413AoUgs7RVhjIVGb/XnmhJ8xmaoSc9q3SOz4fMwBFpOPh
         g0+WKCW81h4j7LX2lLWj75lotR9B6nimOP4BSOmARnH0olXX6HC3rrNTdI5IqD63Jem9
         fKzQ==
X-Forwarded-Encrypted: i=1; AKwUvBx6CA1oF1hUuHwmQMGSIgORolYrzJvF6hYxhP8LKuLwD2hKDZ7ycvZsWDvkw7Or3aU+Dq2sc68=@vger.kernel.org
X-Gm-Message-State: AFq9FYImPHCbgdV65XWQTdJFaswqTEkGSOmP6zXFwdgO2xM/xPNBmNDT
	+8ba7IYmu5xB7TDrHLvc9F13Nm4uUA/gd6vVyic6z+L36/o8sA1fp9eKSLp6YCUXj3pzeproAXr
	7gzDNUFPevOc4Wz83d71vXdqw4tILyvU=
X-Gm-Gg: AYBFou3UtN8l4joVDM33t9NS74Q1uxWEaD9++BUa/I3s6GIlisq9GvkOJlNgICc4KP0
	4ot6730Ia71yP+2eqH98eNgSWKrIfJWc3AmfAuqdxto6oO3DZluIe4wpf77VrAXWPF2ZLEQ+pvj
	E3J90ys7BmsPBhwKmrzjojJDZd8SdkiKlwE+P1zkXtyaLgEITx6QAVnBYdrzFJ1x6RM3WZWz7r3
	S+M9hk5q3C1KnSWGXaK3gcA3SuB2KgJRtPgbXHlygruqKtyK+nBPh6ZEC5h0j48V5Tu0GSCv69X
	nd7cC4+SIG1oFr+IwEvGBlLrEBmUjKsL6hTUBNrEUsYYukEjpPcO+/pzpuSbtV3EdWn9O68CH+1
	0DLr0uHftMfESXG4NloEVxuitAIGYneVEknnvQr932g==
X-Received: by 2002:a05:6402:4490:b0:6aa:ea1f:7e64 with SMTP id
 4fb4d7f45d1cf-6b17c25d5acmr6953116a12.15.1791731364388; Sun, 11 Oct 2026
 08:09:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010144621.974850-1-linmag7@gmail.com> <20261010144621.974850-3-linmag7@gmail.com>
 <CAEdQ38Hqj9+5vui4j6s2-5OihgtiQGSM9L93RTYdp-PfGK0_mQ@mail.gmail.com>
In-Reply-To: <CAEdQ38Hqj9+5vui4j6s2-5OihgtiQGSM9L93RTYdp-PfGK0_mQ@mail.gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 11 Oct 2026 17:09:13 +0200
X-Gm-Features: AclHuK8wAlJ2w8Hi5NCVzVlnkDCQzMFOzN9OC3Lxue_fENNRoRcIedsjd9ZKdVs
Message-ID: <CA+=Fv5Rxgc_9Q=b+7hj5w=hY5-CWx7aKsSAs4vcCAo2xGedDuw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] alpha: do not skip TLB shootdown IPIs for
 kthread-borrowed mms
To: Matt Turner <mattst88@gmail.com>
Cc: richard.henderson@linaro.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

On Sun, Oct 11, 2026 at 1:34=E2=80=AFAM Matt Turner <mattst88@gmail.com> wr=
ote:
>
> On Sat, Oct 10, 2026 at 16:33 +0200, Magnus Lindholm wrote:
> > This requires the preceding removal of remote slot clearing from
> > migrate_flush_tlb_page(). It also requires the stale-TLB series to set
> > need_new_asn on both the reused and newly allocated ASN paths.
> [...]
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Cc: stable@vger.kernel.org
>
> With that Fixes tag this will be tried on every stable tree, and the
> dependency is only in the prose. The hunk context includes comments the
> stale-TLB series adds, so it will fail to apply rather than misapply,
> which is the safe outcome. Naming the prerequisites on the Cc: stable
> line would still save a round of FAILED mails.
>

Thanks, fixed in for-next. I've added the prerequisite commits to the
Cc: stable annotations.


> > +             /*
> > +              * Ordered before any use of the mm by the mb() in
> > +              * arch_spin_unlock(), when finish_lock_switch() drops
> > +              * the rq lock.
> > +              */
> > +             WRITE_ONCE(next_mm->context[cpu], mmc);
>
> "Any use of the mm" is slightly too strong: swpctx loads the new ptbr
> and ASN in switch_to(), before the unlock. What the ordering has to
> precede is the first TLB fill for a user address, so maybe:
>
>                 /*
>                  * Ordered before any user access through the mm by the
>                  * mb() in arch_spin_unlock(), when finish_lock_switch()
>                  * drops the rq lock.
>                  */
>
> Fine as a fixup, no need for a v5 on my account.
>

I've changed the comment to "before any user access
through the mm" as suggested, and refilled the changelog paragraph.
No functional changes, your Reviewed-by is retained.

> > +             if (atomic_read(&mm->mm_users) <=3D 1 &&
> > +                 !mm_context_elsewhere(mm)) {
>
> Not for this series: once every slot has a single writer, I think the
> slot test is sufficient by itself and mm_users only narrows the
> shortcut. Dropping it later would extend the shortcut to a
> multithreaded process whose threads all sit on one CPU. Worth a look
> after this has had some soak time.
>

Interesting, that is for sure worth looking into.

>
> Nit: the changelog paragraph starting "Order the slot reads" has a short
> line at "Also issue smp_mb() after" that wants refilling.

The combined TLB v5 and MMU v4 stack has now completed an SMP compaction
soak on the ES40 with three CPUs online and CONFIG_COMPACTION=3Dy.

Regards

Magnus
