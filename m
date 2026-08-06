Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95412DC783
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 12:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786021002; cv=none; b=RqqJGzJL1O7g/uDK1o/PSio/8kamBK9/r1+SDRBhehT1RL7tQS44hg8ccqT8zEHttWLRpJvoLC/r0vqL/nS+i6TLSWTIX4D2nR+p4cZtC8fl2jCdWLcxNA8sVGdqG3ygJ63Ga0ziMRyQzieYn1e3y9RfUwoS7JBF9IZJ8sMDeH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786021002; c=relaxed/simple;
	bh=QCQe6V7fsK9rYzZ1ujueP23Ip5K9q3t050Z97x+nXKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fvUOhEmBu5m402TbihH1AixWVicHyP5o3PkNKyfJgZMNtVrq7CmWynl7gd6Axs1Bi+hKOdSPvZVGZv/4l0nOx1f5rNliAsBQ/4zNOR+rlPcMNYydi0oGEvQ9jMHfjcG6kGz7Yxwd7AA7l25i0IMZ1W+Dr0dCd1g+WExpoDVlQnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxbnSI16; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxbnSI16"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D18A1F00ACF
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 12:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786021001;
	bh=4hboTcTVAq68vsN4PT4ENqfM/2qs0WVFAG1Tw3ymRrc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=dxbnSI16rtMEeAsf7Kef/HfGw2OsKmS3n7FzzsOa8KiOec9QGXOulcBL7RnQT4Zhx
	 9adMQdtC3yNIp6SaABIt+9CSpaWVCzntuPQw0HIVcBAkbBcF5ns9jloXyFBjJBHV6p
	 Ilfhg6DzhozsbfJ6GMmE00cN4McHP1zgj8CJX9UR1ic3vGdtEV9S3rqN5qB3XrJC4I
	 gBce7jMqB3q4dY/f7XvwBwQiugDJodSQDhM55N42VMDLeoTGT5Q+UQpUP2U1Khcula
	 bFmVw3OUyjLc4j+Y7C8uv+xgbs8Obv71qvLCCoyG89BrRTAUnmcQqhUgxay7mhY4dS
	 If1pO/qZty89Q==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b2a22c52c1so2238467e87.3
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 05:56:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp83/wHTwhBMCVrP2xWcEwB+HU3YOOr5F3wmaYMaX4pOaZ7cA6Pp5EINIR2SO1i+Gu84qVL+wY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmwN9BlLCO8og9yXWXOW4j+//Szm+mVa9HxD5X5Ddv8+AXQLAE
	TkxKIxdtasXS0g7ZUIKUd6wjo0SHH52vAbTh7qH+mEbiQeW8Yg85b/NwL4yu0hPt7L4yacoYjuq
	Sryh4PO/+ODh4nJsRQy4VJahlXIGzFZg=
X-Received: by 2002:a05:6512:258b:b0:5ae:a93c:a993 with SMTP id
 2adb3069b0e04-5b2f4ccc8e5mr1957621e87.52.1786020999929; Thu, 06 Aug 2026
 05:56:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806072656.1386351-1-sh_def@163.com>
In-Reply-To: <20260806072656.1386351-1-sh_def@163.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 6 Aug 2026 14:56:28 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iKPxKqEsd7MD_d2FcQmb7PrGVNkC4PHH0Psswyf-ZKsg@mail.gmail.com>
X-Gm-Features: AUfX_mww1yVSsM0DViczYUTnhyrlCJ_TCjmcAT04zb5jUN5MhtopY9dVE2SYKiU
Message-ID: <CAJZ5v0iKPxKqEsd7MD_d2FcQmb7PrGVNkC4PHH0Psswyf-ZKsg@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: schedutil: Fix rate limit overflow
To: Hui Su <sh_def@163.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, zhongqiu.han@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 9:28=E2=80=AFAM Hui Su <sh_def@163.com> wrote:
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
> ---
> Changes in v2:
> - Clarify why the multiplication uses 32-bit unsigned arithmetic on
>   32-bit systems.
> - Cast rate_limit_us to s64 to match freq_update_delay_ns.
> - Add Zhongqiu's Reviewed-by tag.
>
> v1: https://lore.kernel.org/r/20260805143942.805176-1-sh_def@163.com
>
>  kernel/sched/cpufreq_schedutil.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_sche=
dutil.c
> index dff4ee04694c..51910b30c8da 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -61,6 +61,12 @@ static DEFINE_PER_CPU(struct sugov_cpu, sugov_cpu);
>
>  /************************ Governor internals ***********************/
>
> +static void sugov_update_rate_limit_us(struct sugov_policy *sg_policy)
> +{

Please add a comment here to explain why the direct type cast is
necessary or people will be sending patches to remove it.

> +       sg_policy->freq_update_delay_ns =3D
> +               (s64)sg_policy->tunables->rate_limit_us * NSEC_PER_USEC;
> +}
> +
>  static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64=
 time)
>  {
>         s64 delta_ns;
> @@ -606,7 +612,7 @@ rate_limit_us_store(struct gov_attr_set *attr_set, co=
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
> @@ -848,7 +854,7 @@ static int sugov_start(struct cpufreq_policy *policy)
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
