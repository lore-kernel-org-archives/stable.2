Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793975106;
	b=KTCByPuPTWdJcZhd0lnGY8hKOgSn5y9eZHs28/JhwYl83AQAUyKiLYKpOWnKBehJQOpe
	 /onofoQArYk/1MfpL4sMA4wWKQZ371PE6gIqvcG6RZySwb0I4gUhuXK1mW/bN4ORhCXcZ
	 /SVCYE5X7mn96D4WNSfzPUmCPUS1nNDliu7xtSeTg9Fcw/hWSNjHb1ocSb9VG9SmdRzPX
	 eI3pb44qbqHrkvwpdmY8UU5c2NIktMuHQT22uO+250jXgmVfrkC4EhIv6qi+wU4PAr4m7
	 IFj1DahobInmokK169pzmN9WNN7TNqyGK9b5lbcSoyQS6pyeZgkzqESc1BG9Vm7u8LQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793975106;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=bfsqRGhlipYfNzA5sToOoG4ijdsyQd2sXM0Uteq/zXE=;
	b=cLlImUr3UJItbeD2wR1Ewu32AutZSg3jRZXKKAiGo9FgLYxu63i9lPorXfjja+6hfESO
	 snyVpO/8ZP5tTZnOLiNafBCGMsE+wASiK/45QAzTDqDJqBIWHD4IsWXoDaSCArhG7Z5BZ
	 Erm9BKile6OodKULKGniiEzaMgFuNTM1FnPoLHPrbnzUUk7rPvJPSDQutzyppxjKnG+sf
	 xXhSXVnrUBemj2PapiWawL1Ygfa0yBIAc0mEQ+fdREWh7xCsLCxi0M1JKHZ/8hJihvSdZ
	 bEVWSCrwgnDcWsy3RLf454Ci8lNTfyvl6jV9QfEp346tm+F+rIqGubb0HGJdaCgqaPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aeMuFOKS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4266C606A32C
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 14:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aeMuFOKS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67D11F008AB
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 14:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793975104;
	bh=bfsqRGhlipYfNzA5sToOoG4ijdsyQd2sXM0Uteq/zXE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=aeMuFOKSRav4BeEJPhQGgO1L9NIv+wlzwxWBBa1RPTQ90egyChklBbvYMPl1tWjaW
	 8pqCt6ufjun22Vd4TYjDZCXToMdA9m+5YEiHbA0zhrny1wwKQ+7BejSNJChryax5ex
	 XjzFwoF1qBK8kRf8MQxwgjNK8HHxkbB1tyVFNeNSOLCUlTuc689tSNI8BLvFswV9u0
	 7HMxOZNf4E5h6+aB3lNWUy/K+eFQ28ZPiUwr3DzwM29hvbgSXtV02y30R4IrE/M1zE
	 E/SLHzlszLFEQJeXG1rxmRzbu/OlwaKg0fVT72hH177tU0kG1BH6E7encdnYaBAHAz
	 YxvHvCEQhOJ3w==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3ab01c46697so5551051fa.1
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 06:25:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxylaMysA5oVPJfC11Spnz8m1QnnziPeSdR/xRK/UhB8LreY3uQgJe+CmzsaeeUjdqI4mjexTY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+YlCL9wy6niVbVRVDX5CVucKf+ydRNeQ+eCr0F2k3V65jvfPr9
	XdNCQq43gc+IhJeh1GlqPAa2J/bkgOIvJHqf09fbumLVpZKr2Ak2pWHK8+lGKmcirnzGxN1Hfgu
	1AjyYb5W/8m8cyl+QLUhTXn17A7Y/ylA=
X-Received: by 2002:a05:6512:3c96:b0:5be:4d35:c4c1 with SMTP id
 2adb3069b0e04-5c00397e71amr894275e87.12.1793975103243; Fri, 06 Nov 2026
 06:25:03 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105140357.1331894-1-zhongqiu.han@oss.qualcomm.com>
 <CAJZ5v0gkRC53e+==9xBZh=ZFTkgU5v=fwNCgJCRTdKoxcOFhng@mail.gmail.com> <396aa96d-98f0-47fe-a4a7-b01376efd7ac@oss.qualcomm.com>
In-Reply-To: <396aa96d-98f0-47fe-a4a7-b01376efd7ac@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 6 Nov 2026 15:24:50 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jx00qAZefw3u0_qenO5M4SJ2XbEq3ibGicDhmPDEcrZw@mail.gmail.com>
X-Gm-Features: AclHuK_KXa13i8WXJYPjdluP2u0LSpoZFREWNWTLW2TeSnxtGZ8Nsi0Ix6Fx8uU
Message-ID: <CAJZ5v0jx00qAZefw3u0_qenO5M4SJ2XbEq3ibGicDhmPDEcrZw@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: Only cache resolved frequency in cpufreq_driver_resolve_freq()
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, viresh.kumar@linaro.org, vincent.donnefort@arm.com, 
	linux-pm@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 3:00=E2=80=AFPM Zhongqiu Han
<zhongqiu.han@oss.qualcomm.com> wrote:
>
> On 11/6/2026 1:07 AM, Rafael J. Wysocki (Intel) wrote:
> > On Thu, Nov 5, 2026 at 3:04=E2=80=AFPM Zhongqiu Han
> > <zhongqiu.han@oss.qualcomm.com> wrote:
> >>
> >> Commit e3c062360870 ("cpufreq: add cpufreq_driver_resolve_freq()") add=
ed
> >> policy->cached_resolved_idx so that "a subsequent fast_switch operatio=
n
> >> can avoid repeating the same lookup", and made cpufreq_set_policy()
> >> invalidate the cache instead of filling it. That is, the cached index =
is
> >> only meant to be used by the frequency switch immediately following th=
e
> >> resolution that has produced it.
> >>
> >> However, two other places now access the cache without synchronizing
> >> with its other users:
> >>
> >>   * Since commit f9ccdec24d91 ("cpufreq: Reuse cpufreq_driver_resolve_=
freq()
> >>     in __cpufreq_driver_target()"), __cpufreq_driver_target() reads th=
e
> >>     resolved index back from the cache before calling ->target_index()=
.
> >>     sugov_work() calls it without sg_policy->update_lock, so the sched=
uler
> >>     path (a tick on the policy CPU or a remote update) can overwrite t=
he
> >>     index via cpufreq_driver_resolve_freq() meanwhile. This matters wh=
en
> >>     sugov_hold_freq() discards the lower frequency resolved there, lea=
ving
> >>     the CPU below the frequency schedutil has kept for it.
> >>
> >>    CPU0 (sugov_work())                  CPU0 (tick interrupt)
> >>    __cpufreq_driver_target(f_i)
> >>      __resolve_freq()
> >>        cached_resolved_idx =3D i
> >>                                         sugov_update_single_freq()
> >>                                           get_next_freq()
> >>                                             cpufreq_driver_resolve_fre=
q(f_k)
> >>                                               cached_resolved_idx =3D =
k
> >>      __target_index(cached_resolved_idx)
> >>        ->target_index(policy, k)
> >>
> >>   * Since commit 151717690694 ("cpufreq: Make policy min/max hard
> >>     requirements"), cpufreq_set_policy() updates the cache as a side e=
ffect
> >>     of __resolve_freq(), which can race with governors switching frequ=
encies
> >>     without policy->rwsem (schedutil, ondemand, conservative), and a s=
imilar
> >>     race was addressed by commit 7491cdf46b5c ("cpufreq: Avoid using
> >>     inconsistent policy->min and policy->max"). qcom-cpufreq-hw and
> >>     apple-soc-cpufreq ->fast_switch() read the cached index directly t=
oo.
> >>
> >>    CPU0 (sugov_work(), work_lock held)  CPU1 (handle_update(), rwsem h=
eld)
> >>    __cpufreq_driver_target(f_i)
> >>      __resolve_freq()
> >>        cached_resolved_idx =3D i
> >>                                         cpufreq_set_policy()
> >>                                           __resolve_freq(min)
> >>                                             cached_resolved_idx =3D j_=
min
> >>      __target_index(cached_resolved_idx)
> >>        ->target_index(policy, j_min)
> >>
> >> In both cases, schedutil does not call the driver again until its
> >> selection changes, so the CPU can get stuck at a frequency it has not
> >> selected. All drivers implementing ->target_index() are affected.
> >>
> >> The cache is only consumed by ->fast_switch() right after
> >> cpufreq_driver_resolve_freq(), so only update it there and use a local
> >> index in __cpufreq_driver_target().
> >>
> >> Fixes: f9ccdec24d91 ("cpufreq: Reuse cpufreq_driver_resolve_freq() in =
__cpufreq_driver_target()")
> >> Fixes: 151717690694 ("cpufreq: Make policy min/max hard requirements")
> >> Cc: stable@vger.kernel.org # 5.14+
> >> Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
> >> ---
> >> v1 -> v2:
> >> - Initialize idx in __cpufreq_driver_target() to avoid a
> >>    -Wmaybe-uninitialized warning with W=3D2, as reported by Sashiko.
> >> - Link to V1: https://lore.kernel.org/all/20261104153042.3987338-1-zho=
ngqiu.han@oss.qualcomm.com/
> >>
> >>   drivers/cpufreq/cpufreq.c | 38 ++++++++++++++++++++++++++++++-------=
-
> >>   1 file changed, 30 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> >> index 54dde8419bdc..68009918e80a 100644
> >> --- a/drivers/cpufreq/cpufreq.c
> >> +++ b/drivers/cpufreq/cpufreq.c
> >> @@ -471,10 +471,17 @@ void cpufreq_disable_fast_switch(struct cpufreq_=
policy *policy)
> >>   }
> >>   EXPORT_SYMBOL_GPL(cpufreq_disable_fast_switch);
> >>
> >> +/*
> >> + * Note that this does not update the cached frequency lookup in @pol=
icy,
> >> + * because it may be running in parallel with a frequency switch carr=
ied out by
> >> + * the governor that uses the cached index.  If @resolved_idx is not =
NULL, the
> >> + * index of the resolved frequency in the frequency table is stored i=
n the
> >> + * location pointed to by it instead.
> >> + */
> >>   static unsigned int __resolve_freq(struct cpufreq_policy *policy,
> >>                                     unsigned int target_freq,
> >>                                     unsigned int min, unsigned int max=
,
> >> -                                  unsigned int relation)
> >> +                                  unsigned int relation, unsigned int=
 *resolved_idx)
> >>   {
> >>          unsigned int idx;
> >>
> >> @@ -484,8 +491,8 @@ static unsigned int __resolve_freq(struct cpufreq_=
policy *policy,
> >>                  return target_freq;
> >>
> >>          idx =3D cpufreq_frequency_table_target(policy, target_freq, m=
in, max, relation);
> >> -       policy->cached_resolved_idx =3D idx;
> >> -       policy->cached_target_freq =3D target_freq;
> >> +       if (resolved_idx)
> >> +               *resolved_idx =3D idx;
> >>          return policy->freq_table[idx].frequency;
> >>   }
> >>
> >> @@ -505,6 +512,7 @@ unsigned int cpufreq_driver_resolve_freq(struct cp=
ufreq_policy *policy,
> >>   {
> >>          unsigned int min =3D READ_ONCE(policy->min);
> >>          unsigned int max =3D READ_ONCE(policy->max);
> >> +       unsigned int freq, idx;
> >>
> >>          /*
> >>           * If this function runs in parallel with cpufreq_set_policy(=
), it may
> >> @@ -517,7 +525,20 @@ unsigned int cpufreq_driver_resolve_freq(struct c=
pufreq_policy *policy,
> >>          if (unlikely(min > max))
> >>                  min =3D max;
> >>
> >> -       return __resolve_freq(policy, target_freq, min, max, CPUFREQ_R=
ELATION_LE);
> >> +       target_freq =3D clamp_val(target_freq, min, max);
> >> +       freq =3D __resolve_freq(policy, target_freq, min, max, CPUFREQ=
_RELATION_LE,
> >> +                             &idx);
> >> +
> >> +       /*
> >> +        * Cache the lookup result for the subsequent ->fast_switch() =
call, which
> >> +        * is the only user of it.
> >> +        */
> >> +       if (policy->freq_table) {
> >> +               policy->cached_resolved_idx =3D idx;
> >> +               policy->cached_target_freq =3D target_freq;
> >> +       }
> >
> > The extra clamping of target_freq above the __resolve_freq() call
> > above is not nice.
>
> Agreed, it was only there to get the clamped value for
> cached_target_freq.
>
> >
> > Also, all of this can be rearranged to avoid passing NULL pointers to
> > __resolve_freq().
>
> Right, splitting it into three levels (get_index_and_freq() for the
> table lookup, resolve_freq() adding the clamping, and
> cpufreq_driver_resolve_freq() as the only one updating the cache)
> is much cleaner.
>
> >
> > Moreover, if I'm not mistaken, the direct policy->cached_target_freq
> > update in cpufreq_set_policy() needs to be moved to the point where
> > the governor has been stopped or it will still be racing with fast
> > switching.
>
> You're right, I missed that one. Moving it after stopping the governor
> also means the limits-only path no longer resets it, which looks fine
> to me because schedutil always calls cpufreq_driver_resolve_freq()
> right before fast switching anyway.
>
> >
> > Overall, the attached (untested) patch is what I would do, so please
> > let me know if it works for you (sorry for the attachment, but GMail
> > isn't good at handling appended patches).
>
> Yes, that looks good to me, thanks!
> (If needed, I'd be happy to test it once I'm back from my business trip)

Thanks for the input, but there's a new data point.

I ran this patch through Sashiko internally and it found a
pre-existing problem in __resolve_freq() which is that
__resolve_freq() should cache the post-resolution frequency instead of
the clamped pre-resolution one (the only user of the cached frequency
compares it to a post-resolution frequency value).  When this is
addressed beforehand, the $subject patch becomes much more
straightforward.

I'll post the series of two patches, one addressing the issue flagged
by Sashiko and a modification of $subject patch on top of it shortly.
