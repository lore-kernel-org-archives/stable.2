Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DD6231829
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 23:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791675285; cv=pass; b=d3DiqVIefegB0l6vcORtVWf7UUsTynYxTJ92V8UUJmKaYjSiZpn8sv2Ypb869ceJlJD2qhMq9BH3tv9EoMt8hxU5/xJbNJb7lbaHTN8XLd1s2M6K9c+v3Qqb+QZTegDaHb6Nzdt6bUBTFdWPfKoBAKkUCZvqv2BPjBHtLl07uS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791675285; c=relaxed/simple;
	bh=cKoxBc8OwSXHhNz7B2JU/p9iKVamOJWx79yNaew5iLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RSK5w0ZSrge0kmRUbXgdkl1gVpOgHOukCAZlWz5hmoYGMKU3G0zkAB7A6Mhu3Cqex8cLiU1okbblt22WXRm4ABtdAPg0LrPuZcxMdgf/MYgEPjsoO0G8We/GibKKzQ2XcndvDzweYYo7Vo2Dkg/x6PnIXwsJ1AQqeW9wxWt9K0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmHL4DSg; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmHL4DSg"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3a7858d3a20so7020581fa.0
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 16:34:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791675282; cv=none;
        d=google.com; s=arc-20260327;
        b=Y8c2oPeX+dWlNb5gfED0HYnzofoHIHZoe2hzlKvm9UhiTpQUznly4jK7cxkgYK+fpH
         LToPtX70rQAp2PmzB4RkRbdhK4101HlFSuT3tIhKFZ5i8pJ8E7W3Y2vzNvlX3/QRS0kk
         rgBMkVB3GeiV94w2+OVjbVCScGgMfe8QcA5pfNpRs5GQgqitXmTaf2ecWh2ZZsCqRXXX
         /8CJQEl8ibGmTqbD5exf5R6v6WLzWKteNn3R+LOL0wHyw8aj49HOkxy08mHhqxIyzsKh
         U0HxlfU7x0ikKWqfB7kDHNYePl8mFJHcyki2IRZG4STwR5ZuMUGRcbtTVe0cdm6OgKCO
         E1TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=feaWuaZZCYs3rhB8MCR/+Wo/5xzqgKKqMklPyeWAgMw=;
        fh=aSV/mHvvs4yCJm9k7lPGSiSO/UoX386c+DR8Sfsrd+E=;
        b=Vgyxahc0mnFIdDI3FoINyY4vozcMb1VEzZ322mpFNLQmCwUjlZF4+aHj16ipz6iAfF
         Z6Gs+bPzelUVXM7P1Rabj8H2ytNJNUlOQ/iL+WclO3Fg7JZv3cjPSk3VO+dMJYzDFBgB
         fpTv7AAqHUNE/mOvbwcEdp82vIYWOPDCCpIYicJIZ456/nZQ9A9/pZEGv5uQMB4VU+ef
         ERQdbcwOZTH5ZluIRp5Zu7iLYhGpRwvGMtHDsTfY1arSzFfTNtCIySTUhg7tXe3ihqNd
         +1UCJNm4L5/trkS4wMhOseirobq1d0rj/nli63e9Ni2HJPOv1SkcaUl1d+1hKQwOl/qk
         HRKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791675282; x=1792280082; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=feaWuaZZCYs3rhB8MCR/+Wo/5xzqgKKqMklPyeWAgMw=;
        b=bmHL4DSghHuZ7XQ3jdECRR+i9hdWexkN9bDtZu10oph5xghouphz2KaEgyEKcVH59V
         s7JD81NzNxhhPKujC+E/lYkm7dRQXoXMkTYAphaOTqWjfzud3675t5JWvPZKNjgrOsUb
         iWevaTvrt50eHtVfWYvXnbSaVpm+ZMH2qZIIhdG+FjO9GB8sLjcmx45VnWeYlRvkWuaR
         gitlYeSEzo6g3AN7lRfSekMqLew9fSX+83+PyeMH4ms5W73ZgTPk0v7Iap5I3/OVMFYX
         ZrqusnoAw+PwrfADMcUdbwSbFwA1OoMWuuvaKX9ZVN5wjFcghO1RxRQDzpoQhyAIr0+k
         nb0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791675282; x=1792280082;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=feaWuaZZCYs3rhB8MCR/+Wo/5xzqgKKqMklPyeWAgMw=;
        b=c80Wugfz0ZpqANeLMgm6UazMLB3lGleDbGflvK+DVsaMKJorFqaTOUbbNcpPgs4J5T
         TxyRjuSqdmxXT9/qlcbfMCsgUiuWAZEKsVeN2Z6RPjiYKstZ6At1etxKvBvT6tvo5Ifj
         XojPxuILRVkvRXdG1f/sXYoKiAhA7JWOEOLQHWTW1NZNj5Umf9VVNcy16OUMVxVN0AuS
         0JoBQOn7+jGwxhSktq5NcN7P9q8DDTFlLWVEzCk0soxfHsS9hOqr+e/Po74lYIBIW1xS
         lULVRDkVrPwuPbsF0kp3qLrr9PTiihWBHzumFvDAsUB4ct/r8Cydhf0aW1OvPmaayDwY
         6Q6A==
X-Forwarded-Encrypted: i=1; AKwUvBx7CQl/HvuUuoO2/OZfod4wLtqiIlT7kL8ooR4663c4Ei93Gb96HjhCTu0T053bllzESVjtAFQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKQXKkPlAsquD3hOhkhhf9e26D3p9Drpe7UevlAd3N1e89b4N/9
	fHneYlPZigdB+6xikqQpVuew4+jUtD+N08YbItumZPPCXjMpFGudkEWmefHX1VCvhbM4H2hWg6E
	S+e2W5M6yB9+ACOB7zgsymC3CDjjnAo08eV3EQkQ=
X-Gm-Gg: AYBFou0u5YRCUUdLtlzmnrRGmJI/uyZ+WDJDRn5RKnYBhuHDbXBNge8YP4B94HnLQUW
	ifYrdYQdv1RzJ02yhMDK7HwZd+9GPn1mQvDD9+PEBMuGn1KWTo9XHnlbB73ZVqUvX/XE095R4ph
	aJiFsmqSQozbe4kjPKWTFOMTDLoelsQE8Zou0M7EVdzx9ogDqYbXbLCUg/hBSIlX2lhRTdzhPq0
	WgYJsjyjwo0ED4M2p8EA84IoEk8Te5EZaDwJ+cK4C31IrgRQsesszwYIdjzI9RvuMXqiiixdT+D
	vE71alJXIE1Den0NeJq7LNaZCSrTLy1Uy4h8byGH70sSwdnlFgLxK/+Pppsy49njEqFjQlfdp7c
	CwKhL29uVwK+Rp5rv2RXH83cAiu96J5JgGCDGrpgKh/kAhdP3Afu1aW8qYcP5dF80ybqcdc4=
X-Received: by 2002:a05:651c:31c4:b0:3a7:713b:245b with SMTP id
 38308e7fff4ca-3a9c53852b2mr14841731fa.18.1791675282027; Sat, 10 Oct 2026
 16:34:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010144621.974850-1-linmag7@gmail.com> <20261010144621.974850-3-linmag7@gmail.com>
In-Reply-To: <20261010144621.974850-3-linmag7@gmail.com>
From: Matt Turner <mattst88@gmail.com>
Date: Sat, 10 Oct 2026 19:34:29 -0400
X-Gm-Features: AclHuK_YN5BbixM1IaQoBobT0UPvBKLfq6NBtNaSR9PNTTL89qZ7WbJcHOjtcBg
Message-ID: <CAEdQ38Hqj9+5vui4j6s2-5OihgtiQGSM9L93RTYdp-PfGK0_mQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] alpha: do not skip TLB shootdown IPIs for
 kthread-borrowed mms
To: Magnus Lindholm <linmag7@gmail.com>
Cc: richard.henderson@linaro.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, Oct 10, 2026 at 16:33 +0200, Magnus Lindholm wrote:
> This requires the preceding removal of remote slot clearing from
> migrate_flush_tlb_page(). It also requires the stale-TLB series to set
> need_new_asn on both the reused and newly allocated ASN paths.
[...]
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org

With that Fixes tag this will be tried on every stable tree, and the
dependency is only in the prose. The hunk context includes comments the
stale-TLB series adds, so it will fail to apply rather than misapply,
which is the safe outcome. Naming the prerequisites on the Cc: stable
line would still save a round of FAILED mails.

> +             /*
> +              * Ordered before any use of the mm by the mb() in
> +              * arch_spin_unlock(), when finish_lock_switch() drops
> +              * the rq lock.
> +              */
> +             WRITE_ONCE(next_mm->context[cpu], mmc);

"Any use of the mm" is slightly too strong: swpctx loads the new ptbr
and ASN in switch_to(), before the unlock. What the ordering has to
precede is the first TLB fill for a user address, so maybe:

                /*
                 * Ordered before any user access through the mm by the
                 * mb() in arch_spin_unlock(), when finish_lock_switch()
                 * drops the rq lock.
                 */

Fine as a fixup, no need for a v5 on my account.

> +             if (atomic_read(&mm->mm_users) <= 1 &&
> +                 !mm_context_elsewhere(mm)) {

Not for this series: once every slot has a single writer, I think the
slot test is sufficient by itself and mm_users only narrows the
shortcut. Dropping it later would extend the shortcut to a
multithreaded process whose threads all sit on one CPU. Worth a look
after this has had some soak time.

Nit: the changelog paragraph starting "Order the slot reads" has a short
line at "Also issue smp_mb() after" that wants refilling.
