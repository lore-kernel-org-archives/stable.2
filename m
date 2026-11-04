Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793819074;
	b=UfkahTRWNx+RBAXVqS+BUJgyRtTD1E+D6t1LOas375lNaRkNVCLMyxLwHCGTiqkgwasQ
	 4SSVJl3fT/6lBW9VAoLdPs9kttAKJgEywSxBuC/+/4j37Cqs2d+FAJTnh6wYlmlIH02HG
	 vVVPMLKcmim0N1TPC7OvCwuNlZ3NqbpFWrPD2bLFxAaqZiEdAs7+UWYOamOQzG6XL54I5
	 Ke94wpNyLy4u79waUntr/C3pOL1cYFK8KAzwgvzTqktrEgt2p7f4EcDJeJhNvKdTjFEqo
	 ZmNJznO6W/uF7XEua84T8d/R4NiRRlYfKD7rMK10wYUdoz/vRCLHj/nE7bz/vai23Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793819074;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ZUguZxPIWfc3oegcmJL0PTwqxra4HiHF93TR12uo4NY=;
	b=V5oEC/DSkJuw8LNnNRZVvEKEJ7069L4trojBI/LpqR2KqSJ03sCgflwyQEB+J5Ql9M9X
	 4yBOH7D8wcwXHAKl0Aue4BQtkuiymUdDwwvBibx6HzbYIkBis6jMo+SbZOnzodipbT2gR
	 y29kBdulTbq6Mn1fGox9/P9GEeId/5S0vhUBfsp9pAeGfZ3NJ2LXPE7yvSu6e3NQ9rmiH
	 D/9LbEns3asymdJUXEyzQ9IaXdjy2cfluQsVU96hwZB7PUow5FZ+PFdcb0vlQUy4/7BWI
	 cv7OmFyO7I87QSAbS7zy3ojJpRB8KmdN1ILgiiRqKRdP1yjj4ChXQJZz4Kv3YthD8Bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RkLX6UzX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF19606EE8D
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 19:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RkLX6UzX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55621F00A17
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 19:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793819073;
	bh=ZUguZxPIWfc3oegcmJL0PTwqxra4HiHF93TR12uo4NY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=RkLX6UzXZYGOL3yPDk5XnTlpcTuWaAB95EoNpOuCFIxMOvenFNdBr5MqJyRM7wvJq
	 +6kbz26PK97fWncppi3V7SzqH27X/V5xN+Ts2m1HD/iPnTF7Dos4DuzWsZvpI85QiO
	 B2ONFAgnldPsqR9UhwHNeB2lArrV6DYRVuLRDEPfTZFNVEQ5cjXtvq3PcwV50xN/xc
	 XQGhbJ8Hguo3rFNFphXCW9AtsraK5pAMh3NsV5BM+2CUykbUrs5DHWLGvQwKKD0ll5
	 crCA8pS9ThREZXb9ZAvbWvYHzCTNRkxY5GxqFbuMJIVARrN2qmwhEr/r/xq6yEAXkp
	 YXjfuo3pWMH/g==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5ba3ac592faso1204139e87.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 11:04:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBy+6GKR8XFoySa1gNo13XBlypKqxb72Bn3vk3SPswQl2Q/fjXCh2PLAIujgdLGbSsO7A2YfqMg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8CFlkaxfScgWTemhZqoR6LiDKuR/EV/8oIDtuYKAto8aqy6ft4
	lIqnjGk0duo2M42BXJOAOZbKitZTSUb6aaXUzIIIhsmwFGY254ncsKNvPi8hKyMNpgs15GzAEGb
	ElEpQI4xO5rnMaRLHVFBe1Ha556MFUoc=
X-Received: by 2002:a05:6512:308a:b0:5bf:c9c6:b079 with SMTP id
 2adb3069b0e04-5bfd957e2c8mr5502741e87.60.1793819072177; Wed, 04 Nov 2026
 11:04:32 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104153042.3987338-1-zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20261104153042.3987338-1-zhongqiu.han@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 4 Nov 2026 20:04:19 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gAXT+gEF7_dpJuDZDxB1hu7+Tq5dacZZhGz=X+VKDNwQ@mail.gmail.com>
X-Gm-Features: AclHuK8mJ90pxjEPp4xsBeFllT55SQ_eiEDNIK21ZANAR6oYOCZeJ4k8y1kLIN4
Message-ID: <CAJZ5v0gAXT+gEF7_dpJuDZDxB1hu7+Tq5dacZZhGz=X+VKDNwQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Only cache resolved frequency in cpufreq_driver_resolve_freq()
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, vincent.donnefort@arm.com, 
	linux-pm@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 4:30=E2=80=AFPM Zhongqiu Han
<zhongqiu.han@oss.qualcomm.com> wrote:
>
> Commit e3c062360870 ("cpufreq: add cpufreq_driver_resolve_freq()") added
> policy->cached_resolved_idx so that "a subsequent fast_switch operation
> can avoid repeating the same lookup", and made cpufreq_set_policy()
> invalidate the cache instead of filling it. That is, the cached index is
> only meant to be used by the frequency switch immediately following the
> resolution that has produced it.
>
> However, two other places now access the cache without synchronizing
> with its other users:
>
>  * Since commit f9ccdec24d91 ("cpufreq: Reuse cpufreq_driver_resolve_freq=
()
>    in __cpufreq_driver_target()"), __cpufreq_driver_target() reads the
>    resolved index back from the cache before calling ->target_index().
>    sugov_work() calls it without sg_policy->update_lock, so the scheduler
>    path (a tick on the policy CPU or a remote update) can overwrite the
>    index via cpufreq_driver_resolve_freq() meanwhile. This matters when
>    sugov_hold_freq() discards the lower frequency resolved there, leaving
>    the CPU below the frequency schedutil has kept for it.
>
>   CPU0 (sugov_work())                  CPU0 (tick interrupt)
>   __cpufreq_driver_target(f_i)
>     __resolve_freq()
>       cached_resolved_idx =3D i
>                                        sugov_update_single_freq()
>                                          get_next_freq()
>                                            cpufreq_driver_resolve_freq(f_=
k)
>                                              cached_resolved_idx =3D k
>     __target_index(cached_resolved_idx)
>       ->target_index(policy, k)
>
>  * Since commit 151717690694 ("cpufreq: Make policy min/max hard
>    requirements"), cpufreq_set_policy() updates the cache as a side effec=
t
>    of __resolve_freq(), which can race with governors switching frequenci=
es
>    without policy->rwsem (schedutil, ondemand, conservative), and a simil=
ar
>    race was addressed by commit 7491cdf46b5c ("cpufreq: Avoid using
>    inconsistent policy->min and policy->max"). qcom-cpufreq-hw and
>    apple-soc-cpufreq ->fast_switch() read the cached index directly too.
>
>   CPU0 (sugov_work(), work_lock held)  CPU1 (handle_update(), rwsem held)
>   __cpufreq_driver_target(f_i)
>     __resolve_freq()
>       cached_resolved_idx =3D i
>                                        cpufreq_set_policy()
>                                          __resolve_freq(min)
>                                            cached_resolved_idx =3D j_min
>     __target_index(cached_resolved_idx)
>       ->target_index(policy, j_min)
>
> In both cases, schedutil does not call the driver again until its
> selection changes, so the CPU can get stuck at a frequency it has not
> selected. All drivers implementing ->target_index() are affected.
>
> The cache is only consumed by ->fast_switch() right after
> cpufreq_driver_resolve_freq(), so only update it there and use a local
> index in __cpufreq_driver_target().
>
> Fixes: f9ccdec24d91 ("cpufreq: Reuse cpufreq_driver_resolve_freq() in __c=
pufreq_driver_target()")
> Fixes: 151717690694 ("cpufreq: Make policy min/max hard requirements")
> Cc: stable@vger.kernel.org # 5.14+
> Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>

Please see Sashiko's feedback on this one:

https://sashiko.dev/#/patchset/20261104153042.3987338-1-zhongqiu.han%40oss.=
qualcomm.com

and let me know what you think about it.

> ---
>  drivers/cpufreq/cpufreq.c | 38 ++++++++++++++++++++++++++++++--------
>  1 file changed, 30 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 54dde8419bdc..ffde75dab91d 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -471,10 +471,17 @@ void cpufreq_disable_fast_switch(struct cpufreq_pol=
icy *policy)
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_disable_fast_switch);
>
> +/*
> + * Note that this does not update the cached frequency lookup in @policy=
,
> + * because it may be running in parallel with a frequency switch carried=
 out by
> + * the governor that uses the cached index.  If @resolved_idx is not NUL=
L, the
> + * index of the resolved frequency in the frequency table is stored in t=
he
> + * location pointed to by it instead.
> + */
>  static unsigned int __resolve_freq(struct cpufreq_policy *policy,
>                                    unsigned int target_freq,
>                                    unsigned int min, unsigned int max,
> -                                  unsigned int relation)
> +                                  unsigned int relation, unsigned int *r=
esolved_idx)
>  {
>         unsigned int idx;
>
> @@ -484,8 +491,8 @@ static unsigned int __resolve_freq(struct cpufreq_pol=
icy *policy,
>                 return target_freq;
>
>         idx =3D cpufreq_frequency_table_target(policy, target_freq, min, =
max, relation);
> -       policy->cached_resolved_idx =3D idx;
> -       policy->cached_target_freq =3D target_freq;
> +       if (resolved_idx)
> +               *resolved_idx =3D idx;
>         return policy->freq_table[idx].frequency;
>  }
>
> @@ -505,6 +512,7 @@ unsigned int cpufreq_driver_resolve_freq(struct cpufr=
eq_policy *policy,
>  {
>         unsigned int min =3D READ_ONCE(policy->min);
>         unsigned int max =3D READ_ONCE(policy->max);
> +       unsigned int freq, idx;
>
>         /*
>          * If this function runs in parallel with cpufreq_set_policy(), i=
t may
> @@ -517,7 +525,20 @@ unsigned int cpufreq_driver_resolve_freq(struct cpuf=
req_policy *policy,
>         if (unlikely(min > max))
>                 min =3D max;
>
> -       return __resolve_freq(policy, target_freq, min, max, CPUFREQ_RELA=
TION_LE);
> +       target_freq =3D clamp_val(target_freq, min, max);
> +       freq =3D __resolve_freq(policy, target_freq, min, max, CPUFREQ_RE=
LATION_LE,
> +                             &idx);
> +
> +       /*
> +        * Cache the lookup result for the subsequent ->fast_switch() cal=
l, which
> +        * is the only user of it.
> +        */
> +       if (policy->freq_table) {
> +               policy->cached_resolved_idx =3D idx;
> +               policy->cached_target_freq =3D target_freq;
> +       }
> +
> +       return freq;
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_driver_resolve_freq);
>
> @@ -2355,12 +2376,13 @@ int __cpufreq_driver_target(struct cpufreq_policy=
 *policy,
>                             unsigned int relation)
>  {
>         unsigned int old_target_freq =3D target_freq;
> +       unsigned int idx;
>
>         if (cpufreq_disabled())
>                 return -ENODEV;
>
>         target_freq =3D __resolve_freq(policy, target_freq, policy->min,
> -                                    policy->max, relation);
> +                                    policy->max, relation, &idx);
>
>         pr_debug("CPU %u: cur %u kHz -> target %u kHz (req %u kHz, rel %u=
)\n",
>                 policy->cpu, policy->cur, target_freq, old_target_freq, r=
elation);
> @@ -2393,7 +2415,7 @@ int __cpufreq_driver_target(struct cpufreq_policy *=
policy,
>         if (!cpufreq_driver->target_index)
>                 return -EINVAL;
>
> -       return __target_index(policy, policy->cached_resolved_idx);
> +       return __target_index(policy, idx);
>  }
>  EXPORT_SYMBOL_GPL(__cpufreq_driver_target);
>
> @@ -2666,14 +2688,14 @@ static int cpufreq_set_policy(struct cpufreq_poli=
cy *policy,
>          * concurrently by cpufreq_driver_resolve_freq() during the updat=
e.
>          */
>         freq =3D __resolve_freq(policy, new_data.max, new_data.min, new_d=
ata.max,
> -                             CPUFREQ_RELATION_H);
> +                             CPUFREQ_RELATION_H, NULL);
>         if (freq !=3D policy->max) {
>                 WRITE_ONCE(policy->max, freq);
>                 policy->update_limits =3D true;
>         }
>
>         freq =3D __resolve_freq(policy, new_data.min, new_data.min, new_d=
ata.max,
> -                             CPUFREQ_RELATION_L);
> +                             CPUFREQ_RELATION_L, NULL);
>         freq =3D min(freq, policy->max);
>         if (freq !=3D policy->min) {
>                 WRITE_ONCE(policy->min, freq);
> --
> 2.43.0
>
>
