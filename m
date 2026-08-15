Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531CC2D7DCF
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 17:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786813562; cv=none; b=VqnYxZkmsyRGEsmRmGkv4OwOEL8/iVFfaA6N+wmVaSuU1srjZjvGNEfQpZoEE9zD3L6VKGf6FSPwdajAMQyZtBo0SssuV9uMnJu0be+zrMjuTrE3gd4wwT5YFUtP2Ca8viKsikbGTaTs+G5sXM74CSvufuh0fGSLtu4hvuQAhCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786813562; c=relaxed/simple;
	bh=A6PvZk+pSZLRvR1PMUUKeXFHnO6m31GeXD9y2pbQqFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EmVuc2/I/WH3BhAzn1NK8ihWKsZfZycfbCuWqk/upd9voxj7W34yLINx+zqCkjF+mzngmvD7i59NBt2OLn0r+/LUyEm0ggzItSU8yX6DGt0jkNb+NRZJtvG7p0zAip9rweW0C3MK3NSfjNsAkWXVMQFNq2tgzpa9hgLbcdZ1XiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YiVVEbSJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YiVVEbSJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F7A1F00ACF
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 17:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786813560;
	bh=IGcJjF4HqZWjZBlfYhpWdcCLsDd2mWif2jAJ3D7ZI2w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=YiVVEbSJN+tcRONFmq7Pya2FIPOROiLTOUQNpJE3r87FWWbfBf1eV5eVjpSryn5cd
	 JD/kJcWLu75l4SFsBPinrKWZ+DeFyAHQCgJr0zomv/L5hdtyeWhDImiGr07KwbLRcH
	 nzowfprgQJLgZ8b0GELAI6LIxDFVSDHKKmJGNunTNO1fcmkR11VUIsy1qOmH7hFmU+
	 Sp8VtnRWecKqEVb0ONHN1hN1v3syEMg5AgFTzlH/AGXSP4yr929QcHyMcIYTaWlB5S
	 LELxuncbAzmWCp1W+ZJPK3eL/sK3KBARwsHNgzPRAcbmMJ92ThMuKRANpL1P37OrPU
	 yil6QzU1GXBoA==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aebd52488cso2168910e87.2
        for <stable@vger.kernel.org>; Sat, 15 Aug 2026 10:05:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoJzkE38LrTdNjHAFQriLhjENaDFIKE8bCQ/phzWLcfzjSjIyK4MKdOsZ4PnYoKWTsWANW7KkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYK35HJkT8L0lXqYSgES7nqbnIbu54cqVVvh/1mmXF6rvxIvbw
	3enYVxhK5Bz4NGbT2zOC5INuy1QWhaRsj3oImLWe16phthS9nyGV7+zGOlH5ZHyOQ8Kos0uFUqT
	e+R+g6X8eUBGpPag7mv0OYvgWVZ/9/3g=
X-Received: by 2002:a05:6512:a91:b0:5b0:cce:da00 with SMTP id
 2adb3069b0e04-5b4596bbe02mr1836180e87.1.1786813558396; Sat, 15 Aug 2026
 10:05:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806142304.1761454-1-sh_def@163.com>
In-Reply-To: <20260806142304.1761454-1-sh_def@163.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Sat, 15 Aug 2026 19:05:32 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h=9nMsQU9nnYi-tVHPd7erHi-a+EEMAmTEq-ZueebZhA@mail.gmail.com>
X-Gm-Features: AcwNN1VEdYJltUSZDmqKZAs5I35hqRKI3UmUW2VuHtLfZki8wlVeLjxkq7PjIOA
Message-ID: <CAJZ5v0h=9nMsQU9nnYi-tVHPd7erHi-a+EEMAmTEq-ZueebZhA@mail.gmail.com>
Subject: Re: [PATCH v3] cpufreq: schedutil: Fix rate limit overflow
To: Hui Su <sh_def@163.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, zhongqiu.han@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 4:23=E2=80=AFPM Hui Su <sh_def@163.com> wrote:
>
> rate_limit_us is an unsigned int, while NSEC_PER_USEC is defined as
> 1000L. On 32-bit systems, the multiplication is therefore performed
> using 32-bit unsigned arithmetic before the result is assigned to
> freq_update_delay_ns.
>
> For example, writing 4294968 to rate_limit_us wraps the delay from
> 4294968000 ns to 704 ns. This makes schedutil update far more often
> than configured.
>
> Add sugov_update_rate_limit_us() to widen rate_limit_us to s64 before
> converting it to nanoseconds. Use the helper when updating the tunable
> through sysfs and when starting the governor, so both paths perform the
> conversion without overflow.
>
> Fixes: 9bdcb44e391d ("cpufreq: schedutil: New governor based on scheduler=
 utilization data")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hui Su <sh_def@163.com>
> Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>

Applied as 7.3 material, thanks!

> ---
> Changes in v3:
> - Add a comment explaining why rate_limit_us must be cast before
>   multiplication.
>
> v2: https://lore.kernel.org/r/20260806072656.1386351-1-sh_def@163.com
>
> Changes in v2:
> - Clarify why the multiplication uses 32-bit unsigned arithmetic on
>   32-bit systems.
> - Cast rate_limit_us to s64 to match freq_update_delay_ns.
> - Add Zhongqiu's Reviewed-by tag.
>
> v1: https://lore.kernel.org/r/20260805143942.805176-1-sh_def@163.com
>
>  kernel/sched/cpufreq_schedutil.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_sche=
dutil.c
> index dff4ee04694c..614ff0d33c01 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -61,6 +61,17 @@ static DEFINE_PER_CPU(struct sugov_cpu, sugov_cpu);
>
>  /************************ Governor internals ***********************/
>
> +static void sugov_update_rate_limit_us(struct sugov_policy *sg_policy)
> +{
> +       /*
> +        * Cast rate_limit_us before multiplication to force 64-bit arith=
metic.
> +        * Otherwise, on 32-bit platforms, both operands are converted to
> +        * 32-bit unsigned long and the multiplication may overflow.
> +        */
> +       sg_policy->freq_update_delay_ns =3D
> +               (s64)sg_policy->tunables->rate_limit_us * NSEC_PER_USEC;
> +}
> +
>  static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64=
 time)
>  {
>         s64 delta_ns;
> @@ -606,7 +617,7 @@ rate_limit_us_store(struct gov_attr_set *attr_set, co=
nst char *buf, size_t count
>         tunables->rate_limit_us =3D rate_limit_us;
>
>         list_for_each_entry(sg_policy, &attr_set->policy_list, tunables_h=
ook)
> -               sg_policy->freq_update_delay_ns =3D rate_limit_us * NSEC_=
PER_USEC;
> +               sugov_update_rate_limit_us(sg_policy);
>
>         return count;
>  }
> @@ -848,7 +859,7 @@ static int sugov_start(struct cpufreq_policy *policy)
>         void (*uu)(struct update_util_data *data, u64 time, unsigned int =
flags);
>         unsigned int cpu;
>
> -       sg_policy->freq_update_delay_ns =3D sg_policy->tunables->rate_lim=
it_us * NSEC_PER_USEC;
> +       sugov_update_rate_limit_us(sg_policy);
>         sg_policy->last_freq_update_time        =3D 0;
>         sg_policy->next_freq                    =3D 0;
>         sg_policy->work_in_progress             =3D false;
> --
> 2.43.0
>
