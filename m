Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794875962;
	b=SLaKH/wpHpdVseC3JZmGkO6J+Sv2knaojOFOIop4ZhAHJ/8XaF396U7vx4EbI5/NIb2/
	 5BDfzpICiNHGGSuJwiGtYCp05mPbJZw+DoOymDK7CzinbGfPnX6L2Nsi1FpEIcts+3cy5
	 9AHjG/KGnNeSi+KP5SnlD9egGrlIZMC+WeMIAYjsU7+nGGBefUVmFjBgURFpcf4gbHlKI
	 9Y9uy7KTQ1FX7dyeLQUH/Xf4NXzqFt64zc7n8Ae2MFxQoYjjSwPCfdmofz9K9ONkoIoKv
	 0ERXS+tX6aPwFe6I00XjaDMJIH/ZtIaR3zkT0ANzbRHM29+RJuxxvvQbopk0hgKPy8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794875962;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=yvgrNno9d5FQQl29xM4deIUmhIQOCFM5isagb92yiBg=;
	b=3WlVtiity4SwMfKemalaqi3qWPybVb/A0PcIzkNHI5ryGhm9lyJCc126g9tr0Olu+2Ch
	 COUEFTubxw9ARQFOhgF5HCOTkkqgG3R/eIESIVLrmVQAU4STyFNdbbAVaFyZ1K8DQVK0W
	 FFyhP64FOvtSzY7LJUO/ri6TI18uUEu4d7e7QMt+wNCikmmUb9K4z1Dx7vr9YkepRPvad
	 aft6OvAWK5giCHhSEvBvlfnPhB+TRehnzooZUgsRLP9+JWNjsqru9uZGTX91UbR8Z0aB/
	 JInnpSOqhJZAedN5gxZ5x07gCQvvZ5isBhpZny3HIQ84UbTevBDyroSmzVv+IcVjaEA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UxjOoZWP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E0B606A323
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 00:39:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3E0B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UxjOoZWP
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-49d64a88222so217483f8f.1
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 16:39:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794875960; cv=none;
        d=google.com; s=arc-20260327;
        b=ewN/XgOvgulvXOXDhiqtsycO40ndHlJi5s6xC0RtnkcAAKLTvtCSaJlUeVQ8Pp0hib
         u6QZEuC/ixb65ScgkhPOnOiqjj5vswjMMvNQQZKoq/S7CT0+Q4ycS2vcab+2f1fYqzya
         p34NIgU+6Up5C8BpKuzsmRNgKICK+ZJVTfy3t1P2S/GzjjkXQkkCxbQYxMzvccOXhQLo
         urqxr33lLfLKMRUNiP1jMNL6b7SG7t2NIYlVm+Uga1YiZWhVHTwFpAJAYbqvM/TFzqP6
         K8m1TraUah6dAC+EWo+UWdz+lD+GAi2y4DP2jhOMrcjsJaI+GPffAMz5DprZB2/E2vOH
         Cu5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yvgrNno9d5FQQl29xM4deIUmhIQOCFM5isagb92yiBg=;
        fh=LF/ZOvR6uc3FWkOTKQR+ekUnPatw3fnABvorAyv+HWM=;
        b=ZGVKHo/lKctL2St34GhLsCeegrikexJxvzn3QHz1q5Y5QkOU7uhhZIPEiDiWDW/TRn
         CtFpizn5/T1quFYqgfeFzPyTRaRz/A3zF+Qu6GnKSsXFe+C6eLWEb/jiti9gs9LoCAaC
         JFVuWVh3D7zX/kKSSlyEiWfvGnVsFaovXX5LkB5o4psnaIR7+xf1CEHS3HqHnkU/U4w2
         MwqcX/5PW/I2K/jEHcSNRnViAFeh5icNa2TE/kaeKcdJkyCj440XOxk5jIOFi3I1sN98
         qlzI+3Vg7eDXJAxQgvEjbhlNj+435+CAj2RZ1vDa+0QybYvwWWXMKRA/DKe+TuVuH5DO
         i7zA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794875960; x=1795480760; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yvgrNno9d5FQQl29xM4deIUmhIQOCFM5isagb92yiBg=;
        b=UxjOoZWPK3gElO2xI8h3eyeToRm3WQAYI2yCvgWBfAC3i18Y2DixhLZCbw2DYBXwmd
         KxvEaeuqC/pVb2O0hjaRK2b8NNzr73CGoAWXoKScfn2eGxJpvGlNp6AeG43JIcPUgQz/
         YxyS3rh4/od0j8osjXeuKW/23khVHst4qkvv7SZ80Y+xGLWZuYfh2MOjj8NP7rqMnrny
         O5LdpZm7z2V3nOXrd5L+x4QoXIE4WzyA1VGF9BcMMNKc+qbZinE9LBEx0TOk77x9z7tS
         ojmjiqOOKFvyFlaiayZuCsg1wIr0QGDurAtWMNwbOJMatgUAIsNtkvn6hgj0qIEEdaAl
         OyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794875960; x=1795480760;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yvgrNno9d5FQQl29xM4deIUmhIQOCFM5isagb92yiBg=;
        b=uD6uLg89DhVygVyYWClf/scq3g7pYE77GTK++8nykYv3xBkKCV5uyA0JtScsam5yTK
         dPnj91FWBJNDpuas/vbQ1tp5DoAykVx4v2zeDftVdY3vcql6/2klN6uQokzNwZNZOozl
         KmxSLD6FIaKiIuHrQeoB1edA7YIxYhbbJ5DR56UbntmMD8GIFl6Osan+/XCh9YNQ1TiC
         VArv3aGJEceCsMBXL7K7mVeMwDscazdP+vWNq6vLEl6BReX8GfggLsYWnizKWUT2/Mwp
         6W8BmgiYV9uNkQvc+nlTba8S55S7fJ10CGU8OQ/zjhzH8S8ewm4IIlqO4UyEB0ENDEDf
         2s3A==
X-Forwarded-Encrypted: i=1; AL+hErHhvp4ZZgXvmXdIT/34PJ+Wy1Z19ZEV55PyqjkJKDzNZI9njv1X+O7wv8Lm89QcWzF7mHoSdlI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9HyxJRQ23wHw9IsLw3I/WiFGWrYw4RXTNjHB9KtMcL8QOpRlG2
	MGRcvJtJxoToGexYpOCiFAjSNAWvT2a9z1XBKmD9dTK6YYDIl79Xacc1bgwi/+a/WsgTChWrAyx
	hMRXxguDiaDzOnSwEhusnTaAnQtQWr1VbDXnUqL4v
X-Gm-Gg: AYBFou2OF0P+WrNYAG1LHleX0rC4XxD186qMLl7FfqSLzbKVZ130fAz8Zcr073C5ahl
	83Dc5W05oYubTzYoBNMHU/YNlxXPdmeut/ZJxNazQBkA/jj4Y89e2hhoh6VPh26Js3xjDAzoMOJ
	K3ziH/G1bOzRWEnHx0+32cDskvTmszw+JlmbWUeDf7Dy+U5j0SV05EDVYsIG6bBiG43tCB+zG87
	VLpwn9hDSSYz+M2oBBqg1InV2r2DwhneypTaNrU0BB515j9xz9hi5lez1suN3GQhz/2WxXbnz3h
	0b0H3O6YdkWxmOBJB3Sy1k2Te8IwvdpGD/x6duckgFbY0BKecbwuHafpOFU/QETETtUBwkWf0uy
	VCK7DZfXS9ORhnOJDsysOUr7YR2nuVInIhDTmLQL/jErgcEtZGxMOU7bsoxmS9AyVio/jRpp/oQ
	nRbm04vOjC9hLrlAqGD8TJAN0DG4BlERPSJJWkJg1FrnYMWnEM8pqsm36myjpUZMziNcjjZSACO
	mzDXO4LPgIPA7u2DZ2e2eXQ3dSfcvDVSCRfgY4=
X-Received: by 2002:a05:600c:4f4f:b0:4a0:20b4:ba93 with SMTP id
 5b1f17b1804b1-4bb7839996emr21077405e9.16.1794875959604; Mon, 16 Nov 2026
 16:39:19 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116-topology-wunsequenced-v2-1-54611119172b@kernel.org>
In-Reply-To: <20261116-topology-wunsequenced-v2-1-54611119172b@kernel.org>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 16 Nov 2026 16:39:08 -0800
X-Gm-Features: Aa3M54rJVfSiPNSBUbY2jPJp90xuwKIoyFDAlZrLrZLvvd_WyhIWPKbXZui3s68
Message-ID: <CAKwvOdkJzq8V1hO9SCDcANha5Tofk7EKao=c7pMv_LUji9vTJw@mail.gmail.com>
Subject: Re: [PATCH v2] sched/topology: Avoid unsequenced accesses to jiffies
 in sd_init()
To: Nathan Chancellor <nathan@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 12:55=E2=80=AFPM Nathan Chancellor <nathan@kernel.o=
rg> wrote:
>
> After a recent improvement in clang to warn on unsequenced accesses to
> volatile variables [1], an instance appears in sd_init(), which can
> break the build with CONFIG_WERROR=3Dy / W=3De:
>
>   In file included from kernel/sched/build_utility.c:86:
>   kernel/sched/topology.c:2008:29: error: unsequenced accesses to volatil=
e qualified 'jiffies' [-Werror,-Wunsequenced]
>    1998 |                 .last_balance           =3D jiffies,
>         |                                           ~~~~~~~
>    1999 |                 .balance_interval       =3D sd_weight,
>    2000 |
>    2001 |                 /* 50% success rate */
>    2002 |                 .newidle_call           =3D 512,
>    2003 |                 .newidle_success        =3D 256,
>    2004 |                 .newidle_ratio          =3D 512,
>    2005 |                 .newidle_stamp          =3D now,
>    2006 |
>    2007 |                 .max_newidle_lb_cost    =3D 0,
>    2008 |                 .last_decay_max_lb_cost =3D jiffies,
>         |                                           ^
>
> Per C11 5.1.2.3.2, accessing a volatile object is a side effect. Per C11
> 6.5.2, unsequenced side effects on the same scalar object are undefined
> behavior. Per C11 6.7.9.23, the evaluation of the initialization list
> expressions in a designated initializer is indeterminately sequenced
> relative to each other, meaning any side effects in the initialization
> list are unsequenced.
>
> Add a local variable to hold the value of jiffies before the designated
> initializer so that there are no unsequenced side effects while using a
> consistent value, clearing up the warning.
>
> Cc: stable@vger.kernel.org
> Closes: https://github.com/ClangBuiltLinux/linux/issues/2190
> Fixes: 2b4cfe64dee0 ("sched/numa: Initialize newidle balance stats in sd_=
numa_init()")
> Link: https://github.com/llvm/llvm-project/commit/955715460eaf9188c241c74=
750637fc82dfcc423 [1]
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
> Changes in v2:
> - Use a local variable with one access to jiffies before designated
>   initializer (Nick)
> - Link to v1: https://patch.msgid.link/20261114-topology-wunsequenced-v1-=
1-686a36fe61f5@kernel.org
> ---
>  kernel/sched/topology.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 99878da03bce..60fad1690894 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1956,6 +1956,7 @@ sd_init(struct sched_domain_topology_level *tl,
>         int sd_id, sd_weight, sd_flags =3D 0;
>         struct cpumask *sd_span;
>         u64 now =3D sched_clock();
> +       unsigned long j;
>
>         sd_span =3D sched_domain_span(sd);
>         cpumask_and(sd_span, cpu_map, tl->mask(tl, cpu));
> @@ -1973,6 +1974,7 @@ sd_init(struct sched_domain_topology_level *tl,
>  #endif
>         sd_flags |=3D asym_cpu_capacity_classify(sd_span, cpu_map);
>
> +       j =3D jiffies;
>         *sd =3D (struct sched_domain){
>                 .min_interval           =3D sd_weight,
>                 .max_interval           =3D 2*sd_weight,
> @@ -1994,7 +1996,7 @@ sd_init(struct sched_domain_topology_level *tl,
>                                         | sd_flags
>                                         ,
>
> -               .last_balance           =3D jiffies,
> +               .last_balance           =3D j,
>                 .balance_interval       =3D sd_weight,
>
>                 /* 50% success rate */
> @@ -2004,7 +2006,7 @@ sd_init(struct sched_domain_topology_level *tl,
>                 .newidle_stamp          =3D now,
>
>                 .max_newidle_lb_cost    =3D 0,
> -               .last_decay_max_lb_cost =3D jiffies,
> +               .last_decay_max_lb_cost =3D j,
>                 .child                  =3D child,
>                 .name                   =3D tl->name,
>         };
>
> ---
> base-commit: d7e670601af6c564ccf6d3b2ddf70ee4f41a6d1c
> base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.=
git master
> change-id: 20261114-topology-wunsequenced-18f1d3b9167c
>
> Best regards,
> --
> Cheers,
> Nathan
>


--=20
Thanks,
~Nick Desaulniers
