Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312952;
	b=HYPfxz2hOmDnZ7Zp/uV+Z7Hm7KNscJFub2zp30OttoUvRB37ItRIABc+piwAR94qnnKU
	 jnYR0438HykTw8KyHLEds804sE8lOTOe5bnJ74B0JWAjrqnzFKYHiIwDF/aqfzvafsBoi
	 5hSAIsqNFD3t54XOmtSUAD4EMqNWZ906ao/kNl1U/SV9l+107wgmGd1yG08uX13tu1i3n
	 A+AmCZLJV5bG1P4dhQAa1IFg9A/D3/n+H6ddOLbp5pGDxLq0LGLzKU3/hmmAzAn+Q1/fy
	 XUoRXzMTFPq6AvxWxI0DpkpvR7dIUKneBIcA6Kt9mN9S/ASgz+8lAerIKcTB36FkK6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312952;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=5hOITWXir7kny7IKdUAWvpDSOoIC1UGozOF9nqauv6I=;
	b=xqvYWciASd7wD3BGkN0pc0ogyxR1GgfoxGKqEvvzj5GB/KJHPzuV5qDSRbzSmqSFajdL
	 O5Id3mPlt4Jw1RaOSU5alzsrtUOyL/dYdJlkseL7+y1F0MTkO4H7gSYR5FHmzaK/JIN/Y
	 TglvKLblwms4otxS4vlsfx82U9NxcjExO1/J7VYXhczSnl0NZxPHaeiIpr1sfFRURpFUm
	 W1g5aM6FUATSrsTQVQ09l2kIq1xutPRr2g0draMSZdYHYVP2CcYRkVEiIS7Lv8wvXO2ZE
	 /VruUmHvIcQ4cPeW+X2uN0NmyDeAwvr1vzpXDAEHjjZ3E0GuAU3KwvqY9HM3O/gDF3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zz3fdush;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFF2606A326
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zz3fdush
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F341F008A3
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794312952;
	bh=5hOITWXir7kny7IKdUAWvpDSOoIC1UGozOF9nqauv6I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Zz3fdushU502exI+atrd9blr+XX1n00PdrDajjxMg4DuEerrCBwvfTANY9vmqedyl
	 YRY90Wh09uTB3iirUfqQTfYe2YcNc6NqfTvG2BMF/WhkxsFSMzWfQLh7qpwqyHD0ju
	 EKsjes9HfdBToTgmUzyGloO7RvMV8I/GMjQr9DGLliAMKNYig991wAtCrc9OZoS2ob
	 lrjArMK9oqFzOfqSjYDke/104n/dM3kie3VBfRT7ffGpUZzYV8RDA9cT4/M1B7rLyA
	 1sKHdXHMSi0y+fv/8E95CXRcWTPpgdNYIHX5qukkjcgJKDix/CPU2P+AggUR1XPDbt
	 pda14wS8L9+Xw==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5c1593fd141so499627e87.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 04:15:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHjdks0lxqcwICPvfaz0p76/xE4ihm3mN+uZAUEikI4cn3QfLs21+Iub6i6kR9nc3soOTSW6lQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+sZH0BjCeUgMQB6t4ZkqNQmGaufiVDz6i9YE07iY+QMu8DFkFh
	DQKS+8bsiqfeE6uLhhYULbweE786RcahaDlNefIF8MRbKovPMINQPcscJyLiYRPWa49p/fZQ5Fz
	GIpzMoDJWK5P024e6h5jOm1pjacSRzP0=
X-Received: by 2002:a05:6512:3b21:b0:5bf:e7af:8dc8 with SMTP id
 2adb3069b0e04-5c156ece655mr949807e87.58.1794312950826; Tue, 10 Nov 2026
 04:15:50 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103-em-rank-boost-separately-v2-1-5a13d1b38d37@oss.qualcomm.com>
 <CAJZ5v0hy1D7anTe=CXNXZyMNSN_yHh5hOt6B0bEHTEONRJFMhQ@mail.gmail.com>
 <3e7c3a82-6a99-4c2f-9568-2382ea77ba0e@oss.qualcomm.com> <1dadcd02-19b0-482b-b16d-293430227c5c@arm.com>
 <901516c9-d1be-4918-840e-e3617f2a1782@oss.qualcomm.com> <6b0ee061-38b9-413e-9a83-90446b484859@arm.com>
In-Reply-To: <6b0ee061-38b9-413e-9a83-90446b484859@arm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 10 Nov 2026 13:15:37 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i8a98rjFdQ2Jhu_Xk=qCGiNafMfhzNs26cEJNCYB6Xdg@mail.gmail.com>
X-Gm-Features: AclHuK9ZLEAPkvvEAm9cRuOlTdQ1KKTPJ64KYDiiOwhZqZAGkBN8s4gQExD7A8I
Message-ID: <CAJZ5v0i8a98rjFdQ2Jhu_Xk=qCGiNafMfhzNs26cEJNCYB6Xdg@mail.gmail.com>
Subject: Re: [PATCH v2] PM: EM: Exclude boost frequencies from inefficiency ranking
To: Lukasz Luba <lukasz.luba@arm.com>, Guo Chen <guo.chen@oss.qualcomm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Vincent Donnefort <vincent.donnefort@arm.com>, 
	Matthias Kaehlcke <mka@chromium.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, xin.liu@oss.qualcomm.com, aiqun.yu@oss.qualcomm.com, 
	tengfei.fan@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com, 
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 10:58=E2=80=AFAM Lukasz Luba <lukasz.luba@arm.com> =
wrote:
>
>
>
> On 11/10/26 09:49, Guo Chen wrote:
> >
> > On 11/9/2026 5:40 PM, Lukasz Luba wrote:
> >>
> >>
> >> On 11/9/26 06:47, Guo Chen wrote:
> >>>
> >>> On 11/6/2026 11:15 PM, Rafael J. Wysocki (Intel) wrote:
> >>>> On Tue, Nov 3, 2026 at 12:21=E2=80=AFPM Guo Chen <guo.chen@oss.qualc=
omm.com>
> >>>> wrote:
> >>>>> em_compute_costs() ranks all the frequencies of the table, boost on=
es
> >>>>> included. A non-boost frequency can be marked inefficient only beca=
use
> >>>>> a faster boost frequency has a lower or equal cost, e.g.
> >>>>>
> >>>>>    3.9 GHz  4.0 GHz (cost C)  4.1 GHz (boost, cost C)
> >>>>>
> >>>>> With boost disabled 4.1 GHz cannot be selected, but 4.0 GHz is stil=
l
> >>>>> skipped by governors rounding down to efficient frequencies (e.g.
> >>>>> ondemand with CPUFREQ_RELATION_HE), which land on 3.9 GHz instead o=
f
> >>>>> the best selectable frequency. Several frequencies can be affected.
> >>>>>
> >>>>> Exclude the boost frequencies from the ranking in
> >>>>> em_compute_costs() and
> >>>>> keep them all efficient, using the highest non-boost frequency of t=
he
> >>>>> CPUFreq table, returned by the new helper
> >>>>> cpufreq_table_max_nonboost_freq(), as the boundary.
> >>>>>
> >>>>> Fixes: c8ed99533dbc ("PM: EM: Mark inefficient states")
> >>>>> Signed-off-by: Guo Chen <guo.chen@oss.qualcomm.com>
> >>>> Please see Sashiko's feedback regarding this patch
> >>>>
> >>>> https://sashiko.dev/#/patchset/20261103-em-rank-boost-separately-
> >>>> v2-1-5a13d1b38d37%40oss.qualcomm.com
> >>>>
> >>>> and tell me what you think about it.
> >>>>
> >>>> Thanks!
> >>>
> >>> Thanks for the review.
> >>>
> >>> I did consider this case. If no policy is found, max_nonboost stays 0
> >>> and
> >>> the new logic is bypassed, i.e. the ranking falls back to the old
> >>> behaviour, which looked like the least intrusive option. I also thoug=
ht
> >>> about warning and returning an error, but most of the in-tree callers=
 of
> >>> em_recalc_and_update() ignore the return value (e.g.
> >>> em_adjust_new_capacity() and exynos_asv_update_opps()), so the update
> >>> would
> >>> just be dropped without anyone noticing.
> >>>
> >>>>> ---
> >>>>> Changes in v2:
> >>>>> - Drop prev_boost and keep all boost states efficient by resetting
> >>>>>    prev_cost for them, as suggested by Lukasz. Boost states are no
> >>>>>    longer ranked against each other.
> >>>>> - Retitle the patch to match the new behaviour (was "Rank boost and
> >>>>>    non-boost frequencies separately") and reword the commit message=
.
> >>>>>
> >>>>> Link to v1: https://lore.kernel.org/all/20261030-em-rank-boost-
> >>>>> separately-v1-1-238a6b2bb888@oss.qualcomm.com/
> >>>>> ---
> >>>>>   include/linux/cpufreq.h     | 24 ++++++++++++++++++++++++
> >>>>>   kernel/power/energy_model.c | 16 ++++++++++++++++
> >>>>>   2 files changed, 40 insertions(+)
> >>>>>
> >>>>> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> >>>>> index d3d0d9d02aa4..c93316141a11 100644
> >>>>> --- a/include/linux/cpufreq.h
> >>>>> +++ b/include/linux/cpufreq.h
> >>>>> @@ -1155,6 +1155,24 @@ cpufreq_table_set_inefficient(struct
> >>>>> cpufreq_policy *policy,
> >>>>>          return -EINVAL;
> >>>>>   }
> >>>>>
> >>>>> +static inline unsigned int
> >>>>> +cpufreq_table_max_nonboost_freq(struct cpufreq_policy *policy)
> >>>>> +{
> >>>>> +       struct cpufreq_frequency_table *pos;
> >>>>> +       unsigned int max =3D 0;
> >>>>> +
> >>>>> +       if (!policy->freq_table)
> >>>>> +               return 0;
> >>>>> +
> >>>>> +       /* The table may be unsorted, scan all of it for the
> >>>>> highest one. */
> >>>>> +       cpufreq_for_each_valid_entry(pos, policy->freq_table) {
> >>>>> +               if (!(pos->flags & CPUFREQ_BOOST_FREQ) && pos-
> >>>>> >frequency > max)
> >>>>> +                       max =3D pos->frequency;
> >>>>> +       }
> >>>>> +
> >>>>> +       return max;
> >>>>> +}
> >>>>> +
> >>>>>   static inline int parse_perf_domain(int cpu, const char *list_nam=
e,
> >>>>>                                      const char *cell_name,
> >>>>>                                      struct of_phandle_args *args)
> >>>>> @@ -1219,6 +1237,12 @@ cpufreq_table_set_inefficient(struct
> >>>>> cpufreq_policy *policy,
> >>>>>          return -EINVAL;
> >>>>>   }
> >>>>>
> >>>>> +static inline unsigned int
> >>>>> +cpufreq_table_max_nonboost_freq(struct cpufreq_policy *policy)
> >>>>> +{
> >>>>> +       return 0;
> >>>>> +}
> >>>>> +
> >>>>>   static inline int of_perf_domain_get_sharing_cpumask(int pcpu,
> >>>>> const char *list_name,
> >>>>>                                                       const char
> >>>>> *cell_name, struct cpumask *cpumask,
> >>>>>                                                       struct
> >>>>> of_phandle_args *pargs)
> >>>>> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_mode=
l.c
> >>>>> index d19a65461ae8..5b1d095fd376 100644
> >>>>> --- a/kernel/power/energy_model.c
> >>>>> +++ b/kernel/power/energy_model.c
> >>>>> @@ -255,15 +255,24 @@ static int em_compute_costs(struct device
> >>>>> *dev, struct em_perf_state *table,
> >>>>>                              unsigned long flags)
> >>>>>   {
> >>>>>          unsigned long prev_cost =3D ULONG_MAX;
> >>>>> +       struct cpufreq_policy *policy;
> >>>>> +       unsigned int max_nonboost =3D 0;
> >>>>>          int i, ret;
> >>>>>
> >>>>>          /* This is needed only for CPUs and EAS skip other devices=
 */
> >>>>>          if (!_is_cpu_device(dev))
> >>>>>                  return 0;
> >>>>>
> >>>>> +       policy =3D cpufreq_cpu_get(dev->id);
> >>>>> +       if (policy) {
> >>>>> +               max_nonboost =3D
> >>>>> cpufreq_table_max_nonboost_freq(policy);
> >>>>> +               cpufreq_cpu_put(policy);
> >>>>> +       }
> >>>>> +
> >>>
> >>> The lookup can be made more robust though: on the update paths dev-
> >>> >id may
> >>> be offline while other CPUs of the performance domain are online. In
> >>> v3, if
> >>> dev->id has no policy and the performance domain already exists, I
> >>> will use
> >>> an active CPU of the performance domain instead, as
> >>> em_cpufreq_update_efficiencies() does, and only warn and fall back to
> >>> the
> >>> old behaviour if that fails as well.
> >>>
> >>> I did not use the performance domain for every lookup because at
> >>> registration time dev->em_pd is not assigned yet (it is set after
> >>> em_create_perf_table() has returned):
> >>>
> >>> policy =3D cpufreq_cpu_get(dev->id);
> >>> if (!policy && dev->em_pd) {
> >>>      cpu =3D cpumask_first_and(em_span_cpus(dev->em_pd), cpu_active_m=
ask);
> >>>      if (cpu < nr_cpu_ids)
> >>>          policy =3D cpufreq_cpu_get(cpu);
> >>> }
> >>>
> >>> if (policy) {
> >>>      max_nonboost =3D cpufreq_table_max_nonboost_freq(policy);
> >>>      cpufreq_cpu_put(policy);
> >>>   } else {
> >>>      dev_warn(dev, "EM: no CPUFreq policy, boost states are "
> >>>                          "not excluded from the ranking\n");
> >>> }
> >>>
> >>> This makes it much less likely to miss the policy, but cannot rule it
> >>> out:
> >>> the CPU can still go offline between picking it and calling
> >>> cpufreq_cpu_get(). em_cpufreq_update_efficiencies() has the same
> >>> limitation.
> >>>
> >>> Would that work for you?
> >> I also thought about that possible racy corner case, where
> >> CPU can go offline (or already be offline). Although, in current
> >> usage this should be OK, since we do this in boot phase and
> >> platforms are sane.
> >>
> >> We can can add that step with 'cpu_active_mask' to play safe,
> >> but no hard promises it would be atomic.
> >>
> >> The warning also would help, for bring-up phase, so engineers would
> >> notice it and address the racy hot-plug booting system when it's there=
.
> >
> > Thanks Lukasz,
> >
> > I=E2=80=99ll add the 'cpu_active_mask' check and the warning in v3. As =
the
> > overall approach is unchanged, I=E2=80=99ll keep your reviewed-by.
> > Please let me know if you=E2=80=99d rather have it removed.
>
> That's fine, please continue.

I have a couple of questions though.

First, why is the ondemand governor mentioned in the changelog?  In
the mainline, the ondemand governor cannot work with EAS, so it
shouldn't matter for this issue, should it?

Second, why is the issue regarded as a defect in the code and not in
the energy model?  Arguably, boost frequencies should be more costly
than the non-boost ones.  At least the idea behind the boost is making
higher-cost OPPs temporarily available.  If they are sustainable,
treating them as boost OPPs is rather pointless.

TBH, I'm too comfortable with looking at cpufreq frequency from within
the EM code.  If that needs to be done, something is amiss at the
design level.
