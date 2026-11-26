Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795653657;
	b=ogR0vx92aRIRmPlLpXcYfUPlneZrY0i/CYX9budBEw0YQ5rfBAVHpyyOjtGCK0KHN3hk
	 Grstw6NV0k2fmVOSyr8eo4I81LvlOsb+dGv25p9r58LTaqsuJ0QJgUQ23Y583/2keqKgg
	 HP9hSQ8eNRZrASk//aaKrv+PGSHxBqbf2OM3vStW85Is1M8DOAoOwJbnKa0CHnaVVKdo8
	 UpN5Zx89BaQ2BHc+vTmkP1BIlv6QxLkXtBEpECgFDXqFcORqmHmTsp0Xr/x5ji2z/qBcU
	 95E2W4g/ERtV9WRSGSiIbkVAFTt2qT1LFtlVeO0uA+wj966t54LCU8Sfvv60o+nPmtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795653657;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ROqfz97ZpfUHHWsM2JzaOj+b4tvNFO3hHXdoi3R6Bx4=;
	b=jQ1uOUor89xUQbe3gdROnQU7wYuSD/LJ8wRKAK/8osrh/sfmt8CBWKWdpZKM7XRGQWUd
	 LZTKwgLXCRtDKYlmJ8vDQusoIq7u5mXuq0YbRPUPbh/FXdOiHagWao1csFqTgCipkMuH9
	 fdLAVYCh8h8YN0HZI25LLQlyJcK0dzEW68ODv4KrAAABtR6/o0tKP5YeW9OznujbYPFOi
	 RdRCSglqzEsCCBM7eax1dKZyJ0aOdLPUPpxN50R7rMovZzaa96CGwdKNm1Nm88Nlz07UF
	 bL/9KpfMw617kptSlpSoRhZLn/GRs8juE0z+qH61X/kMVX2FnzjXF4L9vi7aKUwzvzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IIsSkvRm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE21A606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 00:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IIsSkvRm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB4EB1F000D1
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 00:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795653656;
	bh=ROqfz97ZpfUHHWsM2JzaOj+b4tvNFO3hHXdoi3R6Bx4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=IIsSkvRmrxVpdt2ZNq7F8YmH1k07rPBBHdA5/CYaWIJydO+J973A1KWLslA0i1DP6
	 599Mgk4greqpc6ghIkzL1gYqthcINWxidXMeQExEnYWGXUC/E8gG3nW2JSL89c/QfX
	 cta3o4lZoFQXL5a9p7W85owYHhIEQxQOmJ4qHMNUqC2mamkDo1zjLccYvzeMKdVtvx
	 qtsYtcHaMX4Ds+6vPOZXLfEuwJC1pEJQDCgmnmySrWpTS+6dh+x+0GWhvjSCZv8YA7
	 NUSm3Yla6h+UqGg6vVPxJnYmzaTEJloHEuZmC7nDrrLG1Ghj7A4Iac5yMU1nj9IgWN
	 0EuiwHOVnDk5w==
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-949680e6d83so578781185a.3
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:40:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErG5Ki/3TLqUNquXB9KBlAjP3CNtljlTfXeC5CX1/BHaUKisurbkhkrsGcbUjp6oAhyzKk78Ub4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9HFn/r32SeTYXctsNjZmtsYv12BHn/7/mXfuVJFfCfV2q3UnfZ
	L3O748LaK4GyqkS8b94MADAHTk4xRqJRX085ZZLolXBV77WOYReAbqS3pFSXIvkSU/YXfCH7PSR
	dW+BrxTV7iign3rTvGNudX7Oyr6SDw24=
X-Received: by 2002:a05:620a:17ab:b0:93f:6e05:22eb with SMTP id
 af79cd13be357-949ba9e1425mr3467128985a.48.1795653656141; Wed, 25 Nov 2026
 16:40:56 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261125-fix-mglru-kswapd-age-v2-1-4cc37437af9b@tencent.com>
 <CAGsJ_4z-UdXQg0LYqymEZdoHALPmAZC7eGcXbGad6f0sdjmkcw@mail.gmail.com> <awarDrT/DT7tQu+U@lima-default>
In-Reply-To: <awarDrT/DT7tQu+U@lima-default>
From: Barry Song <baohua@kernel.org>
Date: Thu, 26 Nov 2026 08:40:44 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zf5NabZJanr2_Czr3oVQe6tTTdXmddx+PxowbKBN9M8Q@mail.gmail.com>
X-Gm-Features: Aa3M54qqdItbwgjoEHWn9-crdqoWLQnJV4aNvDHtTbWqBrdWHNaBEhfxmdXesaw
Message-ID: <CAGsJ_4zf5NabZJanr2_Czr3oVQe6tTTdXmddx+PxowbKBN9M8Q@mail.gmail.com>
Subject: Re: [PATCH v2] mm/mglru: skip oom killing for order != 0 allocs in kswapd
To: Bingfang Guo <bfguo@icloud.com>
Cc: bingfangguo@tencent.com, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@kernel.org>, Michal Hocko <mhocko@kernel.org>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 5:32=E2=80=AFPM Bingfang Guo <bfguo@icloud.com> wro=
te:
[...]
> You are right. Maybe we can start from skipping aging in reclaim path if =
the
> youngest gen is still too young? And maybe for this path, min_ttl can hav=
e a
> default value? Is that a good idea?
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index d891ae46baf49..7f9b14b772d14 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -5136,8 +5136,11 @@ static bool should_run_aging(struct lruvec *lruvec=
, unsigned long max_seq,
>                 return false;
>
> +       /* avoid excessive aging for huge allocations */
> +        if (unlikely(sc->order)) {
> +               int gen =3D lru_gen_from_seq(max_seq);
> +               unsigned long birth =3D READ_ONCE(lruvec->lrugen.timestam=
ps[gen]);
> +               return !time_is_before_jiffies(birth + min_ttl);
> +        }

I'm not convinced that we need to couple the aging decision with
min_ttl protection.

This has been a long-standing problem: high-order allocations can
trigger excessive reclaim and still fail to obtain contiguous
memory.

I've tried to address this twice, but haven't found a satisfactory
solution yet:

https://lore.kernel.org/linux-mm/20260422021842.78495-1-baohua@kernel.org/

Johannes shared some thoughts on this here:

https://lore.kernel.org/linux-mm/aejtfpBUu7gNV6Tk@cmpxchg.org/

Do you have any traces showing how many pages kswapd scans and
reclaims while kcompactd makes little progress toward satisfying
order-9 allocations?

Basically, I think we need some form of throttling to prevent
kswapd from freeing more and more memory when there is already
plenty of free memory, yet compaction is making little progress
toward satisfying order-9 allocations.

>
>         /* better to run aging even though eviction is still possible */
>         return evictable_min_seq(min_seq, swappiness) + MIN_NR_GENS =3D=
=3D max_seq;
>
> I will give this a test later and share more findings.

Thanks,
Barry
