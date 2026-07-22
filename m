Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3C633E37A
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 13:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784726545; cv=none; b=qz0dXd8pbq0QLwdASbnNRrHLX2bcIbX6nlLexPencwX8/Q0HvsIKkdoXpoR8mMjX/D6Af/DWOTH5phIr+7g4T5sDi30fsa9x1XKXkuekkV1FybIbmebCHcZLevitqt8rpL4EXLcnGli+MMIuaP5Rgx+PLD+lVk2596s0efoqtlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784726545; c=relaxed/simple;
	bh=VLsp+Nu7L6KRnHUlSECtDsXG17bVTWCS0JQbx581Cms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aDMrjdFOYVcY5nFmHg2WL7vHIM6LCc1i5FZ1G0yyGdsfbg1C1BGD7D1fyBG7VbgY9U7UaFs88+o1MrT7xoyB1roFjtB1DI4fTz7yoO0xdPEP25LKlZ+dagAoszRcUcczndPi5S0JTJb7tEO357Q0HcW3WjpgRXQTVhtVQdrhutQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kj7KPPRn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kj7KPPRn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14021F00A3D
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 13:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784726543;
	bh=eFshNarXKv9K8RpS7rwMQi510UoRuGYi/scoSC5EK8o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kj7KPPRnUVDXrXZ/R0946paF7dwEW4rmqbbYb6ndbeufZWQsErBW79ghjFRBYX3yP
	 nJj/Vgo6V88IGSDnW0IoNcLks8w/v/EXA1ljPMZFycjBAZ7VcRPCGDhypEIkZRm6Rl
	 5KyYJl/0u6HiCQBkwITUgdAa8HJEhNNpBI0TzAzg+jRwhsvGEdK6+FG1BKnw0h6HQc
	 bbNr1N6MEdPQMjzIEegA1MK+Kn86vLw8gwUA9JCCQ6wLP5MyNde7yM/6f3LsyjLkEH
	 m3+0meRGMLPpHp9+RJXcTKobkfNmcpelhFkGTZ1UISmZAVOj4HQwS15jxmlOrCI9Zf
	 8oscRRSn1iCJA==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5b0f19bea2fso8334229e87.1
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 06:22:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoSZHzvw1g4M+6G5yIL7OL07RrgCgfBemwx1Ra6pzgbIALy9pJAn4dK0rONHXdJ6shKbCqnU4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXkhYkWpN9Q2KCabX74a3QjjSPS4ADrUhRLAc+QEkjUKI9NeQ/
	1rcuZpqmvk8BQ35FKOyU9/cfDfq7CDCosOYPvCZ38bMpUhXsJmVz+fFnBZGJjDJAlyTNaxM9rSI
	h+Di9Lmh1PK8X3SPf4kyq4FUnmQdJCzw=
X-Received: by 2002:a05:6512:1092:b0:5ae:b86b:71eb with SMTP id
 2adb3069b0e04-5b28f9a7c9emr5722582e87.36.1784726542227; Wed, 22 Jul 2026
 06:22:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716115159.848403-1-zhongqiu.han@oss.qualcomm.com> <6abab7b9-71cf-47d4-b7dd-def43be935bc@arm.com>
In-Reply-To: <6abab7b9-71cf-47d4-b7dd-def43be935bc@arm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 22 Jul 2026 15:22:10 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hp5OYTXjJfbbGAbkrVLqQWU2f_NH7eALQ2xJ7L4j=igA@mail.gmail.com>
X-Gm-Features: AUfX_mwSx8uCeK3t7nmaLm_dlOOftM-G5e4ZGVJOSe7wBnfzYHkFihddEzblGJ0
Message-ID: <CAJZ5v0hp5OYTXjJfbbGAbkrVLqQWU2f_NH7eALQ2xJ7L4j=igA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: schedutil: Publish util hooks only after all
 sg_cpu are initialized
To: Christian Loehle <christian.loehle@arm.com>, Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, liaochang1@huawei.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 2:25=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 7/16/26 12:51, Zhongqiu Han wrote:
> > Commit 16a03c71bba0 ("cpufreq: schedutil: Merge initialization code of
> > sg_cpu in single loop") merged the per-CPU initialization and the
> > utilization-hook registration into a single loop in sugov_start().
> >
> > For a shared cpufreq policy this re-introduces the race originally fixe=
d
> > by commit ab2f7cf141aa ("cpufreq: schedutil: Fix sugov_start() versus
> > sugov_update_shared() race").
> >
> > The scheduler's util path reaches the hook under RCU-sched and never ta=
kes
> > policy->rwsem, so the rwsem held across sugov_start() cannot serialize =
the
> > two. Once the first CPU's hook is published, sugov_update_shared() may =
run
> > and, via sugov_next_freq_shared(), read/write each sibling sugov_cpu
> > (iowait_boost, util, bw_min, ...) concurrently with the memset() still
> > initializing them, with no lock common to both sides: the update side h=
olds
> > sg_policy->update_lock while the init side holds only policy->rwsem, wh=
ich
> > the scheduler's util path never takes.
> >
> > The walk only accesses scalar members, never a pointer like ->sg_policy=
,
> > so it does not crash today; it merely uses stale (or zero on first star=
t)
> > values that skew the frequency selection and tracepoints. It is still a
> > genuine data race, and a latent crash once any pointer member is
> > dereferenced there.
> >
> > Restore the two-phase approach: initialize all per-CPU structures first=
,
> > and only then publish the per-CPU utilization update hooks.
> >
> > Fixes: 16a03c71bba0 ("cpufreq: schedutil: Merge initialization code of =
sg_cpu in single loop")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
> > ---
> >  kernel/sched/cpufreq_schedutil.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_sc=
hedutil.c
> > index dc0835ceee98..6ad080de8644 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -872,8 +872,19 @@ static int sugov_start(struct cpufreq_policy *poli=
cy)
> >               memset(sg_cpu, 0, sizeof(*sg_cpu));
> >               sg_cpu->cpu =3D cpu;
> >               sg_cpu->sg_policy =3D sg_policy;
> > +     }
> > +
> > +     /*
> > +      * Publish the hooks only after all per-CPU data is initialized, =
so a
> > +      * shared policy's sugov_update_shared() never reads an uninitial=
ized
> > +      * sibling sugov_cpu.
> > +      */
> > +     for_each_cpu(cpu, policy->cpus) {
> > +             struct sugov_cpu *sg_cpu =3D &per_cpu(sugov_cpu, cpu);
> > +
> >               cpufreq_add_update_util_hook(cpu, &sg_cpu->update_util, u=
u);
> >       }
> > +
> >       return 0;
> >  }
> >
>
>
> Good catch!
> Reviewed-by: Christian Loehle <christian.loehle@arm.com>

Applied as 7.2-rc material, thanks!
