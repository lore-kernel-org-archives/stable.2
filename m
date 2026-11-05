Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898485;
	b=mo1EvWCOmJGLLhJ++TWcoqHlGzUI54YwcIcK+6Mrqsjpw0HpPKqjYI6CwUN2mWrVv/j1
	 Gi/0BYanGeu2BR+JdqASmFXLJsZMoAVUeOg2lPYcqCW5gBMUdcDuOx+fYO57zuNjwD4qZ
	 Vn+VplagOWfbQeHmjak1NrmaTX+hZIQmxGdkflZNp4KywqdFWbDxVppi7iyUAGg6jzxLg
	 5Cwwcbo1rVdlkXE04yjQdE+ALFKJi5cVjRi8aOtT7+uEUjz+WrUK5oKPmzyyVTM9E/YuH
	 BPH6oUkAPHqYQnl//iRxOX1EwU8bZ9/mcHX41P7gw9QwXRJxD6pNEUag2ghVbP0H4lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898485;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=unpU2o0zWc/AsDEneSNeZzhchF2sV91HMnvUV4zyUMA=;
	b=p8Up1bPpwiFAhvvvACWNL643NtlCRjGEXMUZgHAX9PYf0AdEGPEx9tvK+1fBq0vU7iVB
	 S/GCoUWlxZYzVuq9jk6dh18+X7QJnWid3ozB1u6nNE2+kYvXLY9p0mj1jLA9qXrvL1x6P
	 QFUibijgGmr72Y58882WCIS7gT74ARHjyHmJBKxasMD9gONNgCTFtbR/l2nFjUKd09tZn
	 Ov6LZGnD3Nck9LAq2nh7gVlbLFSHsyjk4foUmKoKQhRamp5/3STCVz1PMPBPwMDcrWrrA
	 O+digVOhZ8uSQrmuWXI6CShXB2OOJdGUm1jyRvWnqy9a+hwWPGxQ6WiVt7PKwCFXJCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="c9/xKHdl";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9810606A329
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 17:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c9/xKHdl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315D11F00919
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 17:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793898484;
	bh=unpU2o0zWc/AsDEneSNeZzhchF2sV91HMnvUV4zyUMA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=c9/xKHdl+HM4V8XvLn+cBfws9k8acCiVHXXPdDhpItmXZZ3VVCfDqRVyVseZ/HBN+
	 kLGmjkmrl/kzQa2gwLqVZIQ6nW4xxuZR7+Kz8sBEhNjSb0j5TD6kmqVGW6VVj2tudf
	 G/ekdFP09zLXStyg8fNL5l0U/C1LS/kUGz1+aRbYvvyve5cF9z5WCEdd+eROpncvb9
	 ZQbG5a2nMX0eAgNdHxibQ6dtecf3HosB1rIG9ECWTaOATfCewF/4Wt07bMYJJPYlPq
	 HNT0/m01wuvQVor2nrp3KMiJWy2ELJnt3fHYcTxIYcHTro7mgSiZwML5gtgcl2aP2+
	 vEYFsqU+3LBUw==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5bcb4f23ddeso1998911e87.3
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 09:08:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwTLvY5FnKfpJuZVnraYhuCMJjKc5E4a2Rp+KG27j5Ncm6fIVlkkclLYhNF/1vKSxYBfQUNUpg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8PGYfh95jqbE9hSwFaO7xZGe+33bc98DsD+WuCet3pujZ63prm
	kLJBgrB+Vw9ZRoKBHadzsTxWi5Ss6WSZMuBqkvGLJJqPb7xvAnZcg076tQL+waHNLvGMw+w80ed
	0xy3mOidrwX/7OSJsHGNF8Bkie74ugHg=
X-Received: by 2002:a05:6512:3c8e:b0:5bf:9fc1:393f with SMTP id
 2adb3069b0e04-5bfd957cee8mr7858819e87.52.1793898482589; Thu, 05 Nov 2026
 09:08:02 -0800 (PST)
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
In-Reply-To: <20261105140357.1331894-1-zhongqiu.han@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 5 Nov 2026 18:07:49 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gkRC53e+==9xBZh=ZFTkgU5v=fwNCgJCRTdKoxcOFhng@mail.gmail.com>
X-Gm-Features: AclHuK9b7f_CFGXeNM0N0dqJJ-bH3TkwROr7iA6_cC8OH3jaaB2F2CRCtxINtFA
Message-ID: <CAJZ5v0gkRC53e+==9xBZh=ZFTkgU5v=fwNCgJCRTdKoxcOFhng@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: Only cache resolved frequency in cpufreq_driver_resolve_freq()
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, vincent.donnefort@arm.com, 
	linux-pm@vger.kernel.org, stable@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000d17d01065f8a8928"

--000000000000d17d01065f8a8928
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 3:04=E2=80=AFPM Zhongqiu Han
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
> ---
> v1 -> v2:
> - Initialize idx in __cpufreq_driver_target() to avoid a
>   -Wmaybe-uninitialized warning with W=3D2, as reported by Sashiko.
> - Link to V1: https://lore.kernel.org/all/20261104153042.3987338-1-zhongq=
iu.han@oss.qualcomm.com/
>
>  drivers/cpufreq/cpufreq.c | 38 ++++++++++++++++++++++++++++++--------
>  1 file changed, 30 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 54dde8419bdc..68009918e80a 100644
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

The extra clamping of target_freq above the __resolve_freq() call
above is not nice.

Also, all of this can be rearranged to avoid passing NULL pointers to
__resolve_freq().

Moreover, if I'm not mistaken, the direct policy->cached_target_freq
update in cpufreq_set_policy() needs to be moved to the point where
the governor has been stopped or it will still be racing with fast
switching.

Overall, the attached (untested) patch is what I would do, so please
let me know if it works for you (sorry for the attachment, but GMail
isn't good at handling appended patches).

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
> +       unsigned int idx =3D 0;
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

--000000000000d17d01065f8a8928
Content-Type: text/x-patch; charset="US-ASCII"; name="cpufreq-cached-resolved-idx.patch"
Content-Disposition: attachment; 
	filename="cpufreq-cached-resolved-idx.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mw3srv9w0>
X-Attachment-Id: f_mw3srv9w0

LS0tCiBkcml2ZXJzL2NwdWZyZXEvY3B1ZnJlcS5jIHwgICA1NiArKysrKysrKysrKysrKysrKysr
KysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMzUgaW5zZXJ0aW9u
cygrKSwgMjEgZGVsZXRpb25zKC0pCgotLS0gYS9kcml2ZXJzL2NwdWZyZXEvY3B1ZnJlcS5jCisr
KyBiL2RyaXZlcnMvY3B1ZnJlcS9jcHVmcmVxLmMKQEAgLTQ3NCwyMiArNDc0LDI3IEBAIHZvaWQg
Y3B1ZnJlcV9kaXNhYmxlX2Zhc3Rfc3dpdGNoKHN0cnVjdAogfQogRVhQT1JUX1NZTUJPTF9HUEwo
Y3B1ZnJlcV9kaXNhYmxlX2Zhc3Rfc3dpdGNoKTsKIAotc3RhdGljIHVuc2lnbmVkIGludCBfX3Jl
c29sdmVfZnJlcShzdHJ1Y3QgY3B1ZnJlcV9wb2xpY3kgKnBvbGljeSwKLQkJCQkgICB1bnNpZ25l
ZCBpbnQgdGFyZ2V0X2ZyZXEsCi0JCQkJICAgdW5zaWduZWQgaW50IG1pbiwgdW5zaWduZWQgaW50
IG1heCwKLQkJCQkgICB1bnNpZ25lZCBpbnQgcmVsYXRpb24pCisKK3N0YXRpYyB1bnNpZ25lZCBp
bnQgZ2V0X2luZGV4X2FuZF9mcmVxKHN0cnVjdCBjcHVmcmVxX3BvbGljeSAqcG9saWN5LAorCQkJ
CQkgdW5zaWduZWQgaW50IG1pbiwgdW5zaWduZWQgaW50IG1heCwKKwkJCQkJIHVuc2lnbmVkIGlu
dCByZWxhdGlvbiwgdW5zaWduZWQgaW50ICpmcmVxKQogewogCXVuc2lnbmVkIGludCBpZHg7CiAK
LQl0YXJnZXRfZnJlcSA9IGNsYW1wX3ZhbCh0YXJnZXRfZnJlcSwgbWluLCBtYXgpOworCWlkeCA9
IGNwdWZyZXFfZnJlcXVlbmN5X3RhYmxlX3RhcmdldChwb2xpY3ksICpmcmVxLCBtaW4sIG1heCwg
cmVsYXRpb24pOworCSpmcmVxID0gcG9saWN5LT5mcmVxX3RhYmxlW2lkeF0uZnJlcXVlbmN5Owor
CXJldHVybiBpZHg7Cit9CiAKLQlpZiAoIXBvbGljeS0+ZnJlcV90YWJsZSkKLQkJcmV0dXJuIHRh
cmdldF9mcmVxOworc3RhdGljIHVuc2lnbmVkIGludCByZXNvbHZlX2ZyZXEoc3RydWN0IGNwdWZy
ZXFfcG9saWN5ICpwb2xpY3ksCisJCQkJIHVuc2lnbmVkIGludCBtaW4sIHVuc2lnbmVkIGludCBt
YXgsCisJCQkJIHVuc2lnbmVkIGludCByZWxhdGlvbiwgIHVuc2lnbmVkIGludCAqZnJlcSkKK3sK
KwkqZnJlcSA9IGNsYW1wX3ZhbCgqZnJlcSwgbWluLCBtYXgpOworCWlmIChwb2xpY3ktPmZyZXFf
dGFibGUpCisJCXJldHVybiBnZXRfaW5kZXhfYW5kX2ZyZXEocG9saWN5LCBtaW4sIG1heCwgcmVs
YXRpb24sIGZyZXEpOwogCi0JaWR4ID0gY3B1ZnJlcV9mcmVxdWVuY3lfdGFibGVfdGFyZ2V0KHBv
bGljeSwgdGFyZ2V0X2ZyZXEsIG1pbiwgbWF4LCByZWxhdGlvbik7Ci0JcG9saWN5LT5jYWNoZWRf
cmVzb2x2ZWRfaWR4ID0gaWR4OwotCXBvbGljeS0+Y2FjaGVkX3RhcmdldF9mcmVxID0gdGFyZ2V0
X2ZyZXE7Ci0JcmV0dXJuIHBvbGljeS0+ZnJlcV90YWJsZVtpZHhdLmZyZXF1ZW5jeTsKKwlyZXR1
cm4gMDsKIH0KIAogLyoqCkBAIC01MjAsNyArNTI1LDE2IEBAIHVuc2lnbmVkIGludCBjcHVmcmVx
X2RyaXZlcl9yZXNvbHZlX2ZyZXEKIAlpZiAodW5saWtlbHkobWluID4gbWF4KSkKIAkJbWluID0g
bWF4OwogCi0JcmV0dXJuIF9fcmVzb2x2ZV9mcmVxKHBvbGljeSwgdGFyZ2V0X2ZyZXEsIG1pbiwg
bWF4LCBDUFVGUkVRX1JFTEFUSU9OX0xFKTsKKwl0YXJnZXRfZnJlcSA9IGNsYW1wX3ZhbCh0YXJn
ZXRfZnJlcSwgbWluLCBtYXgpOworCisJaWYgKCFwb2xpY3ktPmZyZXFfdGFibGUpCisJCXJldHVy
biB0YXJnZXRfZnJlcTsKKworCXBvbGljeS0+Y2FjaGVkX3RhcmdldF9mcmVxID0gdGFyZ2V0X2Zy
ZXE7CisJcG9saWN5LT5jYWNoZWRfcmVzb2x2ZWRfaWR4ID0gZ2V0X2luZGV4X2FuZF9mcmVxKHBv
bGljeSwgbWluLCBtYXgsCisJCQkJCQkJIENQVUZSRVFfUkVMQVRJT05fTEUsCisJCQkJCQkJICZ0
YXJnZXRfZnJlcSk7CisJcmV0dXJuIHRhcmdldF9mcmVxOwogfQogRVhQT1JUX1NZTUJPTF9HUEwo
Y3B1ZnJlcV9kcml2ZXJfcmVzb2x2ZV9mcmVxKTsKIApAQCAtMjM5OCwxMiArMjQxMiwxMiBAQCBp
bnQgX19jcHVmcmVxX2RyaXZlcl90YXJnZXQoc3RydWN0IGNwdWZyCiAJCQkgICAgdW5zaWduZWQg
aW50IHJlbGF0aW9uKQogewogCXVuc2lnbmVkIGludCBvbGRfdGFyZ2V0X2ZyZXEgPSB0YXJnZXRf
ZnJlcTsKKwl1bnNpZ25lZCBpbnQgaW5kZXg7CiAKIAlpZiAoY3B1ZnJlcV9kaXNhYmxlZCgpKQog
CQlyZXR1cm4gLUVOT0RFVjsKIAotCXRhcmdldF9mcmVxID0gX19yZXNvbHZlX2ZyZXEocG9saWN5
LCB0YXJnZXRfZnJlcSwgcG9saWN5LT5taW4sCi0JCQkJICAgICBwb2xpY3ktPm1heCwgcmVsYXRp
b24pOworCWluZGV4ID0gcmVzb2x2ZV9mcmVxKHBvbGljeSwgcG9saWN5LT5taW4sIHBvbGljeS0+
bWF4LCByZWxhdGlvbiwgJnRhcmdldF9mcmVxKTsKIAogCXByX2RlYnVnKCJDUFUgJXU6IGN1ciAl
dSBrSHogLT4gdGFyZ2V0ICV1IGtIeiAocmVxICV1IGtIeiwgcmVsICV1KVxuIiwKIAkJcG9saWN5
LT5jcHUsIHBvbGljeS0+Y3VyLCB0YXJnZXRfZnJlcSwgb2xkX3RhcmdldF9mcmVxLCByZWxhdGlv
bik7CkBAIC0yNDMzLDcgKzI0NDcsNyBAQCBpbnQgX19jcHVmcmVxX2RyaXZlcl90YXJnZXQoc3Ry
dWN0IGNwdWZyCiAJaWYgKCFjcHVmcmVxX2RyaXZlci0+dGFyZ2V0X2luZGV4KQogCQlyZXR1cm4g
LUVJTlZBTDsKIAotCXJldHVybiBfX3RhcmdldF9pbmRleChwb2xpY3ksIHBvbGljeS0+Y2FjaGVk
X3Jlc29sdmVkX2lkeCk7CisJcmV0dXJuIF9fdGFyZ2V0X2luZGV4KHBvbGljeSwgaW5kZXgpOwog
fQogRVhQT1JUX1NZTUJPTF9HUEwoX19jcHVmcmVxX2RyaXZlcl90YXJnZXQpOwogCkBAIC0yNzEx
LDE2ICsyNzI1LDE2IEBAIHN0YXRpYyBpbnQgY3B1ZnJlcV9zZXRfcG9saWN5KHN0cnVjdCBjcHUK
IAkgKiBjb21waWxlciBvcHRpbWl6YXRpb25zIGFyb3VuZCB0aGVtIGJlY2F1c2UgdGhleSBtYXkg
YmUgYWNjZXNzZWQKIAkgKiBjb25jdXJyZW50bHkgYnkgY3B1ZnJlcV9kcml2ZXJfcmVzb2x2ZV9m
cmVxKCkgZHVyaW5nIHRoZSB1cGRhdGUuCiAJICovCi0JZnJlcSA9IF9fcmVzb2x2ZV9mcmVxKHBv
bGljeSwgbmV3X2RhdGEubWF4LCBuZXdfZGF0YS5taW4sIG5ld19kYXRhLm1heCwKLQkJCSAgICAg
IENQVUZSRVFfUkVMQVRJT05fSCk7CisJZnJlcSA9IG5ld19kYXRhLm1heDsKKwlyZXNvbHZlX2Zy
ZXEocG9saWN5LCBuZXdfZGF0YS5taW4sIG5ld19kYXRhLm1heCwgQ1BVRlJFUV9SRUxBVElPTl9I
LCAmZnJlcSk7CiAJaWYgKGZyZXEgIT0gcG9saWN5LT5tYXgpIHsKIAkJV1JJVEVfT05DRShwb2xp
Y3ktPm1heCwgZnJlcSk7CiAJCWlmIChuZWVkX3VwZGF0ZV9saW1pdHMpCiAJCQlwb2xpY3ktPmZv
cmNlX3RhcmdldCA9IHRydWU7CiAJfQogCi0JZnJlcSA9IF9fcmVzb2x2ZV9mcmVxKHBvbGljeSwg
bmV3X2RhdGEubWluLCBuZXdfZGF0YS5taW4sIG5ld19kYXRhLm1heCwKLQkJCSAgICAgIENQVUZS
RVFfUkVMQVRJT05fTCk7CisJZnJlcSA9IG5ld19kYXRhLm1pbjsKKwlyZXNvbHZlX2ZyZXEocG9s
aWN5LCBuZXdfZGF0YS5taW4sIG5ld19kYXRhLm1heCwgQ1BVRlJFUV9SRUxBVElPTl9MLCAmZnJl
cSk7CiAJZnJlcSA9IG1pbihmcmVxLCBwb2xpY3ktPm1heCk7CiAJaWYgKGZyZXEgIT0gcG9saWN5
LT5taW4pIHsKIAkJV1JJVEVfT05DRShwb2xpY3ktPm1pbiwgZnJlcSk7CkBAIC0yNzMyLDggKzI3
NDYsNiBAQCBzdGF0aWMgaW50IGNwdWZyZXFfc2V0X3BvbGljeShzdHJ1Y3QgY3B1CiAKIAljcHVm
cmVxX3VwZGF0ZV9wcmVzc3VyZShwb2xpY3kpOwogCi0JcG9saWN5LT5jYWNoZWRfdGFyZ2V0X2Zy
ZXEgPSBVSU5UX01BWDsKLQogCXByX2RlYnVnKCJuZXcgbWluIGFuZCBtYXggZnJlcXMgYXJlICV1
IC0gJXUga0h6XG4iLAogCQkgcG9saWN5LT5taW4sIHBvbGljeS0+bWF4KTsKIApAQCAtMjc1OSw2
ICsyNzcxLDggQEAgc3RhdGljIGludCBjcHVmcmVxX3NldF9wb2xpY3koc3RydWN0IGNwdQogCQlj
cHVmcmVxX2V4aXRfZ292ZXJub3IocG9saWN5KTsKIAl9CiAKKwlwb2xpY3ktPmNhY2hlZF90YXJn
ZXRfZnJlcSA9IFVJTlRfTUFYOworCiAJLyogc3RhcnQgbmV3IGdvdmVybm9yICovCiAJcG9saWN5
LT5nb3Zlcm5vciA9IG5ld19nb3Y7CiAJcmV0ID0gY3B1ZnJlcV9pbml0X2dvdmVybm9yKHBvbGlj
eSk7Cg==
--000000000000d17d01065f8a8928--
