Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794336887;
	b=X1OX9UqPegpErC/nlB9fANGtklbD6xMzRakK8ZDBGNmbcftvPcH5GPHS/2VWtWDIiLjP
	 fGZW/As+3kjTSgGpR/dOi5W8w/3PEetXK3GSx5W92Ab/VAjMqJxNfIjOZtWgSyziJLKEU
	 24x9SV94QHEHjqoHaC3vl7k5vKv5+ZJb+ITYkpMCbf5jbVGpnDfqw5ikznVGppy/WYPA+
	 KKidMrtuzu+m2Xdaw6EvLG2YaWX6QwlRsP3oxAl82Bz3OkaDu/MobigbrH752TmaLjJJE
	 lPvgFzUAN4qQD0/suPf4edTEiyCZ3qJ0Y4g3dutxXWlnR0StIDtdkjrgMAgA9ahAFkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794336887;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=52NDmUlT/C1NnGu+Dq/AZOz+hWzBvu1Wfp+thafpfXc=;
	b=2vu9OZ/qgZvR1285OtpTLlTuQxE2d8XXt7yYp0JrWEDvRFOKHTBC+RGfCI0ZabvELmtV
	 cUfMlnb38e4PrilQp4TzuVj6I5Ibll2T1CAA4vg9MMDt+LHrJo1K3C7GmW/nT7BgcYlPl
	 HWawY/zAbH/brTLH0VRt/C/GwAtzg9M/lMc+3QVZ69FtulvnDj3vwEezPCmbq4zcFwvPi
	 1bkVBZxJrSmGnfpR21dAtrCg6dHdSugRHWqwRLwXHnUgASovSsPynIwICue41X0RDsung
	 2+63rcae7J2pVHm2UExsedfKR9lhM+LSoKb2TkpZeE343Na9xHa+4rT+IymQkI7vUjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LOn77Q1Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E16260A261E
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LOn77Q1Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 276211F008BC
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794336886;
	bh=52NDmUlT/C1NnGu+Dq/AZOz+hWzBvu1Wfp+thafpfXc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=LOn77Q1Q4FdQNPQHTCyBLDRVJc2OVxlu3IQSi3abYY96Yq71PSG7F/TEVoy/NyWzb
	 6ZZ8JMgypJzK/cI+aPJQtG8QxRq27xYLoUexcHQhssamVujEko5pL2j8l9Xk5r1UDF
	 fg6EMW/hpUVwdlWj7P/7r/PpqnxM7CCUEq2B3KCS3fXmKrU0AeKB0kcNol6YvVtkWD
	 EFe51t8kzprPyw9dxOkb+SBmRlpAFlmtMn1G2VVZLzW8IioMKG9Lg58zzRg3ECHbNw
	 U2ea60g7BU9XProPMSBPhJSPrIB34HlnYgmh7yz/2ywg+yhLuIaLkQP2PocVVzj3fq
	 vxNvvUWxQIgJg==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3accd1ff4c3so18424631fa.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 10:54:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEf8A7HdudX3XP+yzyvesLcyCZK7nIlogiZ9UBm0gZOjqOU+Jf+S7A4x6kVjm1lrv/aj6T70sE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8sBDvV17u0OywO/EOiCK3MkvTU4cXkmXjW67RGqlgiz+mAEZNa
	BhjWw9KAWP+sl6ElZDUop3UvESyktueesw9wD4Edtu89AXFWGNErDBwCc1iLazPHGz8fX0adLKf
	YlnZXLGM1KmzdSueWto/GojtPtTtR4b0=
X-Received: by 2002:a05:651c:1606:b0:3ac:4da3:864f with SMTP id
 38308e7fff4ca-3ae0961bddcmr8184521fa.4.1794336884424; Tue, 10 Nov 2026
 10:54:44 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110135814.621355-1-zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20261110135814.621355-1-zhongqiu.han@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 10 Nov 2026 19:54:32 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hHLdd0X-r7HG24TrALGccHNZ37JUyeu=rHg9-6YAR7gQ@mail.gmail.com>
X-Gm-Features: AclHuK9AWEuL5vf0QrXIUa41RCa4KBaWPSXD-wUP0068_a0rEgmBvhB9KueRF5I
Message-ID: <CAJZ5v0hHLdd0X-r7HG24TrALGccHNZ37JUyeu=rHg9-6YAR7gQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Skip inactive policies in cpufreq_driver_target()
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, andrew-sh.cheng@mediatek.com, 
	rex-bc.chen@mediatek.com, jia-wei.chang@mediatek.com, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 2:58=E2=80=AFPM Zhongqiu Han
<zhongqiu.han@oss.qualcomm.com> wrote:
>
> A policy obtained with cpufreq_cpu_get() may become inactive before
> cpufreq_driver_target() acquires its rwsem, which may lead to a NULL
> pointer dereference:
>
>   CPU X                      CPU Y (last CPU in policy)
>   cpufreq_cpu_get()
>                              cpufreq_offline()
>                                __cpufreq_offline()
>                                  ->exit()  /* frees freq_table */
>                                  policy->freq_table =3D NULL
>   cpufreq_driver_target()
>     __cpufreq_driver_target()
>       __target_index()
>         policy->freq_table[index]  /* NULL dereference */
>
> Before commit 2372784542cb ("cpufreq: Drop 'freq_table' argument of
> __target_index()"), __cpufreq_driver_target() returned an error if
> policy->freq_table was NULL. Since the offline path clears it under the
> policy rwsem, which cpufreq_driver_target() also holds, that check was
> sufficient to prevent the crash.
>
> The race has been reachable in-tree since commit c210063b40ac
> ("cpufreq: mediatek: Add opp notification support"), which added the
> first caller of cpufreq_driver_target() that can run concurrently with
> CPU offline.
>
> Address this by making cpufreq_driver_target() return -EBUSY if the
> policy is inactive after acquiring its rwsem, in analogy with the checks
> in cpufreq_get(), refresh_frequency_limits() and the sysfs show() and
> store() callbacks.
>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20261104153042.3987338-1-zhongqiu.=
han%40oss.qualcomm.com
> Fixes: 2372784542cb ("cpufreq: Drop 'freq_table' argument of __target_ind=
ex()")
> Fixes: c210063b40ac ("cpufreq: mediatek: Add opp notification support")
> Cc: stable@vger.kernel.org # v5.19+
> Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
> ---
> Fix the issue discussed at:
> https://lore.kernel.org/all/a4b320d9-ade6-4f39-9e9a-e9a82b13152e@oss.qual=
comm.com/
>
>  drivers/cpufreq/cpufreq.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 54dde8419bdc..352ee4a1f085 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2403,6 +2403,14 @@ int cpufreq_driver_target(struct cpufreq_policy *p=
olicy,
>  {
>         guard(cpufreq_policy_write)(policy);
>
> +       /*
> +        * The last CPU in the policy may have gone offline after the cal=
ler
> +        * obtained it, in which case the policy is inactive and must not=
 be
> +        * used for changing the frequency.
> +        */
> +       if (unlikely(policy_is_inactive(policy)))
> +               return -EBUSY;
> +
>         return __cpufreq_driver_target(policy, target_freq, relation);
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_driver_target);
> --

Applied as 7.4-rc material, thanks!
