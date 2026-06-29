Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E59B39A04F
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 18:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782758261; cv=pass; b=souB0GnvslKZd7+QQElB0FR1JWsY94PWj0tHsz95VvWCEVOhBlGjBXHSOfk/6Y0w0onLML9NoERqV/jWeCWa0Pw45IX/RzNujuKR4O2TUpCveP5aSjrQHIbPpzNKbfFUTnm/9nf0vB5WuWDQ7WlzQ81LdlV5uVmdQu5yfwnNz+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782758261; c=relaxed/simple;
	bh=8aAWH9rSKkLqi+1sE6zKTPYetQDRKFAsL6S7Z65BNdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kgPjhE0PpSM3Ev2w7EgaiJrIyvx8yv3TcKZy/k6kc44eelSEAnj6wV8kDZ4QsRCzCZKbGprMtV1Qf9/nHWvM0QOmrpxg3UqAR8n8/cSAHGBWA8Lmml7tQzDCHQRdSuTNABDCHrHjeCzkkXBZTT14Ni9lAf1+M2rpGtDbShb3wYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5Fp93nT; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5Fp93nT"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4938d5f86f3so15221275e9.1
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 11:37:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782758257; cv=none;
        d=google.com; s=arc-20260327;
        b=MPj6j8pFZ4q4vECuNOpm2uwRb0sBI1zP1RjRWAHizjOJzabChz6ECgmXvGapAHOT/n
         AdddHJ9rJqhNRooCrX7GBI1AMA0t6KwfW2uco1kC8jianhcwzJCJMEwn0BZ6reIfmJ5q
         RvDYq8rxqFJOMhlH3r5TP1Tlj+CBlhzpuc6ww8RhLBY+o6TzjShra5cOx9a1KYPMErp1
         abx9a0qqGwsZcUKs15uplwY0906ElC/D6tDJp/2XL1cDlW2ANIrLSrO7/M7sihBmrv3Q
         iP7ihtxXhEEtrNcJ8RPqRSJKgFvSG+RIu+Ah/mrtawP4VkJjBpwCzgOirOZlMlyBaiux
         ewjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=66IdtV4A4O3twwyEenTNgYY676iFrQKRg0yaSc+sXIk=;
        fh=E0nCF11lGGoIr0MInWabkua5VrF8c69GcO+ZS7KXsKo=;
        b=orYRy50/dW5C3yjPl4QsfIRPPboLE5aunPcg3MAAjEFTqCndryYBJbP4htQNpZ9QSA
         s0wQvGAPtyhINBQgs7gMAP6PtkmUZ5xrv6NSaw8jKkDHg3+2ZvH5IZGhMTOz+L29ebqS
         J2zf6siES7kjXWuXhak05DE1Faw2au9GcuoMsvo8tziES7CNi/gaRFntpXFSd2r6UX05
         780FrQOq7dv7AFaKdiN6rYzeqk8aVHYURSPs/Xt6yu2jLZDPIxwmLVoil1kcNz/xMQ6k
         SYYWc0g3QJnxde8XY1dzrMNs9lOzu3sShMuY34YIVE87jgdg8gWN7F1juK2Q4qlM++Ds
         0Epw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782758257; x=1783363057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66IdtV4A4O3twwyEenTNgYY676iFrQKRg0yaSc+sXIk=;
        b=U5Fp93nTXSbWZZCX2vfq+8hUv0N+r81FKZYkh4BVQtSTh+9asUjllfKaBOnSbste5H
         LcGUKugFN7YVsczAoPr73GXhXH7TwNUjpz9+1gBJca9w3D4DYgqmzzZeA30UDDN8hDV0
         AmdPxp1P6JZnjyvIu2QsLjNx0nDEZnL7ySTvHJE3SH9uuuPoB55iq+wAkj4hSAKhW+nT
         +DaM0sQisepBX609REXRWmwh6KNEzyFdkEB/2fwELanP4/WqtOlNqEvYAYnu9ooLL39r
         ybSn8GFPwUBxqC5wfk0A/cs8agheZEZXw8AMoyVDcJxk7XmOyPPFl0+S57ZsuVLPOoPM
         T2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782758257; x=1783363057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=66IdtV4A4O3twwyEenTNgYY676iFrQKRg0yaSc+sXIk=;
        b=TUa1MHiNblpJKJIEiVSAPkLKvd7n/EUIAbpDXLfNBWTz1+rJ2oQ1Mvq99K5IQKYXNV
         3d69IBQRfFD1zh3vfy2TxldTk7bkd3+yifYEgdCL3QUyV8hgtexcm61XMGZcwr+g/AY+
         mUEXej/Y1NBYOfyHUUBx0Jc6piTAExkgz3h1CsCXkUbYxVFnk+abq8yM4epSnGMGI3qS
         P/VddrPgAFnfWhrPD/Q5/E/Y4iVKwbqsJf00fj3YT2cZhgdUsorh2PG5r1lRJkGVi2xn
         6WVRgWfIl8D42fOcJW2rCu+HmRN8+6YmaK2T0Ip5KRlP5y4OvdDvp81hTFbqPHTDJnhJ
         0w1g==
X-Forwarded-Encrypted: i=1; AFNElJ/SRlKt7NKH+u2bO4f86VKVJe/x/pLHfq0jpGrdMd6SwokVdSsZoxbKBBUuazpVXNdXlefqjj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD+sQ05XQWSHuhDD35tTbK9776jqmVox8FW+8YlCdOoo8ggksU
	1qxs8d72BHifAfCJCRS0dmWzEFkbwzivocX8OzcHLzvyX7G+dZ95yQ/WZ0njdIY1wO+CffJ6ASt
	AHWjII1KZrPfyW+C8hGaDXWuRxb7Jy6g=
X-Gm-Gg: AfdE7cn1kNYScENI9keeFVQnSv7f2diRe/wnV+lLNH/UE2nghO5XawS/7nhqgXy4KXS
	4rwYEf8lRAckMKNRCA8V8NQ4zCEbOy6byzSbKrGV0PAZVG7tvi5AnuBGPwkJQgMAmRy6+s2bAr0
	PTjIQHBm8kbRTPj4O7CFA5O8kPRu+D5x1Q+Rarx+qcgxgIVE9wwAKH7x90WiTbnSSjxD7B4PNkq
	hkNrYLZioc2Ocy+OoEUS8geJjXP7eiv+2A7lhIyxpu9Ufv0epykwZjasSNihOcUrIYE1V9QzZaI
	OTgD0knNlWl6BlAqFGkHonKi7SWQ
X-Received: by 2002:a05:600c:524e:b0:48f:e230:29f5 with SMTP id
 5b1f17b1804b1-493b8ce540fmr4782905e9.16.1782758257412; Mon, 29 Jun 2026
 11:37:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629112032.20423-1-jiahao.kernel@gmail.com> <20260629112032.20423-2-jiahao.kernel@gmail.com>
In-Reply-To: <20260629112032.20423-2-jiahao.kernel@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 29 Jun 2026 11:37:24 -0700
X-Gm-Features: AVVi8CeUNnnZ1b5gr34nY8C8rkHWBFp3tMR1RyjfkvKK-T1UYPS0l8SmSsuAXg0
Message-ID: <CAKEwX=MniM-4-aV17aH3UiDd_Xd2RH743fFZaxEnYX9qvnokeA@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] mm/zswap: Fix global shrinker when memory cgroup
 is disabled
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: akpm@linux-foundation.org, tj@kernel.org, hannes@cmpxchg.org, 
	shakeel.butt@linux.dev, mhocko@kernel.org, yosry@kernel.org, mkoutny@suse.com, 
	chengming.zhou@linux.dev, muchun.song@linux.dev, roman.gushchin@linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Hao Jia <jiahao1@lixiang.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 4:20=E2=80=AFAM Hao Jia <jiahao.kernel@gmail.com> w=
rote:
>
> From: Hao Jia <jiahao1@lixiang.com>
>
> When memory cgroup is disabled, mem_cgroup_iter() always returns NULL.
> Therefore, the global shrinker shrink_worker() always takes the !memcg
> branch. After MAX_RECLAIM_RETRIES empty walks, the worker simply gives up=
,
> so it fails to write back anything.
>
> Therefore, when memory cgroup is disabled, fall through with the !memcg
> branch and shrink the root memcg directly. Stop the loop once
> shrink_memcg() reports -ENOENT, since the root LRU is the only target and
> -ENOENT means it has been exhausted.
>
> Fixes: a65b0e7607cc ("zswap: make shrinking memcg-aware")
> Cc: stable@vger.kernel.org
> Reported-by: Yosry Ahmed <yosry@kernel.org>
> Closes: https://lore.kernel.org/all/CAO9r8zPVzMKFbCixxD-qgtRrkFxWVrHiZZeL=
c=3DeyTPKPVQgX4g@mail.gmail.com
> Signed-off-by: Hao Jia <jiahao1@lixiang.com>

Ah good catch.



> ---
>  mm/zswap.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 761cd699e0a3..0f8f04f22888 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1356,7 +1356,12 @@ static void shrink_worker(struct work_struct *w)
>                 } while (memcg && !mem_cgroup_tryget_online(memcg));
>                 spin_unlock(&zswap_shrink_lock);
>
> -               if (!memcg) {
> +               /*
> +                * Reaching a NULL memcg means a full hierarchy pass comp=
leted.
> +                * Exclude the memcg-disabled case, where it is always NU=
LL, and
> +                * fall through to shrink the root LRU directly.
> +                */
> +               if (!memcg && !mem_cgroup_disabled()) {
>                         /*
>                          * Continue shrinking without incrementing failur=
es if
>                          * we found candidate memcgs in the last tree wal=
k.

nit: I wonder if we can just merge this comment with the new comment
you just added.

> @@ -1378,8 +1383,15 @@ static void shrink_worker(struct work_struct *w)
>                  * with pages in zswap. Skip this without incrementing at=
tempts
>                  * and failures.
>                  */
> -               if (ret =3D=3D -ENOENT)
> +               if (ret =3D=3D -ENOENT) {
> +                       /*
> +                        * With memcg disabled the root LRU is the only t=
arget, so
> +                        * we should abort if it has no writeback-candida=
te pages.
> +                        */
> +                       if (mem_cgroup_disabled())
> +                               break;

Hmm do we need to do this? Consider a system with cgroup enabled but
with just one cgroup (root?). The behavior would just be trying that
cgroup for MAX_RECLAIM_RETRIES failure attempts, correct?

In that case, we don't need to do this check, and we would get the
same behavior. The loop would terminate after MAX_RECLAIM_RETRIES :)

Could you fact-check me? :)
