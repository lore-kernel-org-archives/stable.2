Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453274189AD
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 18:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783360838; cv=pass; b=UhyLvNoGsZiCnMrMQ5bOtvafm4bMTlWe9uMwDzbGaIES6orY+PSc5q9mHqC5Jin/pZ8a7eqTGPPrWnYSBYRgtmkRpdYXQG0C5k1No5zv/fcxp/x3EEudBF0ZolsbvExFYQjpJiO+38F7M9+pBauiibrbK4zJ9Us+U0h0X/Vxmiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783360838; c=relaxed/simple;
	bh=dr60ISvk84gw7E2mdn+ZAgXT0Fcp3MJN+kcAT8jJdSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jwW8LiOeYHtUw7oD5LpUsFk9saT+0Pfg96943gLuQKJhe4vzbBQl81EB30ozIc5FAd8rl8XrVxkSfk2lVrfdHDu/hEl6VvEsmpqvJY35nkQwekqDhHVgxuxczLB5a3vxOJS46wQNGuA5zTcPvMTikcvTu5KiNnTjE9rg6fZ9YQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n4Y2zJF4; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n4Y2zJF4"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6976b0c5adbso6146730a12.2
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 11:00:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783360836; cv=none;
        d=google.com; s=arc-20260327;
        b=JfmqPrOVd6FTnkGYbdPW25RoxMTZ4SfSVpTtmuwg87IdSPIUbIOlTUYja7XgbcrnyH
         /XM4ZajgPdxba9bFwqzDU7lxV3gzOMfbcz1L8mvH4J3EfIar4ny2FYgt0mDjEV+rNLDP
         eZ1rZjV86A5Z2zKW4sW9HS13ezdjY4Arog5qzKue0B6o9ZKsn5FL47ZyCXntmxaf3cCL
         LqV3+EQkwf+RA/yR3JpGsMMbwPC6NE/CvqmZVZ/wU4p+3x43ZikhiPTteWbRylvx8WbO
         UfRNl4L1hD7Eoyze/pCkMRDDWDa0Tn/yvYfepGX9MNlVGqPJR7i752EUC2GoVPLw5B6I
         tg3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=dr60ISvk84gw7E2mdn+ZAgXT0Fcp3MJN+kcAT8jJdSE=;
        fh=5A0PIiE2Is20dfys+Ke7QGHP8hrHnrbdrN4io2zzzLM=;
        b=AafbHNnsAZfywb+ucSC+JbDLyrvFY645zt5365NaiEu084811vaQxHB2MYrv5K+QpU
         PW6Q0kS8GlloGHG+g6m7u1ivCrlcfyeSj9vqnQZ41CTQKYQjNSpfRaAzd6spRutg8zH+
         +INtBP6iTNeTNO5jjBtr/CuQUDoM62aBVSP9JV4B1+OnSSiQG3BakwtLlYG5vf/dA6gR
         iZVIcGgCYXIa643t5BvaO2atlKx3lRIyIxuuPIUdMvAKfeyo4g+TOw6+7NYeiCixYIYh
         8CALzpkQZt/tDoiqTLSOD1bcevewmpGRaS6Mww6NdWmNCs/qLBbUesfCQlw7mZFDukkE
         5O/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783360836; x=1783965636; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dr60ISvk84gw7E2mdn+ZAgXT0Fcp3MJN+kcAT8jJdSE=;
        b=n4Y2zJF4yy1vvJ78/rR6r2s35rcoM8E1TXUvZuK+NFOYMarPRx+FoySpZxA75Akd6l
         j4ZZwEHQ4Lawu4fvxT9pGvpXhNPWuXErgjvHIba+WVlcAcX5dQDVYz3us9Mrth6fvT4W
         bxs/Xxzon83AvN1gpSo7DZdN4o6dEKaxNDsK0dtUGPkNDb4LIbTxu8LJQNjfmOvJ9OXn
         ZumiE/8ASyutgnqlEhR3KKe8XeFMNyC+bwTgdmb35vLRwaHv9ySVGVPqbGjRIctOaD8D
         Zr1Zc3lHeMaodIxzqITWTL3/y1iLBsC8KtsKQCnIGbNdyNZ/9p5bBtBOpd2vDbP3cH6y
         gcyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783360836; x=1783965636;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dr60ISvk84gw7E2mdn+ZAgXT0Fcp3MJN+kcAT8jJdSE=;
        b=bCFOlPxGhMn3xcXCbm6X37uGaHgywksog6ItyVMQtReTkTRK1yWIZFZwp+OS3N1dCe
         8i0ihOJouKi1lJykrQ3RqoedG0FQhxIt/0y9b1Xv1HAokqNT7ODA+/GxCyNzh80ujzwQ
         jmpMdaeWNEMlbpM8cRxznef+WkcntnAw+qJI47clIKuXj23N6rmLcWfbvr4WJwaYCrKu
         QDgT2qVdRjp3kgt6Gd4eaU/1PeU3y/VEUplnyLgvScphVEgOWpUKYMuMrAN5gPv+FlDU
         IK96YzlPrnwc64aboNntf1yR4e10IFJgNkSZJ8nDTjPOTJB+41jxUXze/jOHj4RB0bf0
         t1yg==
X-Forwarded-Encrypted: i=1; AHgh+Royt+jilqP/1+x5TxhyWZGewxTBRObR2hgO/NskuAPXY+Q9+8RICC2kQsNfNAlG9NOnri4F3go=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqeDbT7bTEc9du955S8RgKPcOClfIt5OhDJcX5iHkKgeYaNMME
	2dhofOcD6El5jY9zy7YIMP+aHg9jiG57qi0RhjNfGkYkHuEk4FJ6DXU/gMFe7lJDu8sRtOHVyEV
	XXe7jAVtCycEWw5unWyVZdnrm+bFYls4=
X-Gm-Gg: AfdE7cks6vVopGAECadl15XV07dO42GQxWx5zufXrKweJvpVym2d6Sm/YXW+hZDWE2W
	bku9S0X1h3lJ80QP4lJ4syUrF2xlHyYE/V5IV9k+AonTnyXXO8QceYnC3Dc+DR3ZySi1q1Tjjfj
	Kt+SW81sVQzIjaPuikSnIuOzvH/HU8ESIPLUVHGuIA21GGRdNHkDXg+nZXyqocSwS8qXcHO6fik
	lGYM1Hh7hFdkvBHK3ODJ3qtFNCYPJI+hpe2ftb1xhZa5PUbXCQIw85D7Wrxh2RiW1lrOrHy1BvU
	Z7klWZT2XlQ9qbHPSpWuaM/1/AC09aQ=
X-Received: by 2002:a05:6402:321e:b0:698:1504:e3d9 with SMTP id
 4fb4d7f45d1cf-69a85bd8accmr1044410a12.29.1783360835438; Mon, 06 Jul 2026
 11:00:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518-procfs-lockfix-part1-v1-1-5c3d20e0ac33@google.com>
 <20260706170735.2941493-1-linmag7@gmail.com> <CAG48ez0ebrMy8QGKLuz0Qwao_Eiav6e5pAJ5f6GrUPJLRkwNnw@mail.gmail.com>
In-Reply-To: <CAG48ez0ebrMy8QGKLuz0Qwao_Eiav6e5pAJ5f6GrUPJLRkwNnw@mail.gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Mon, 6 Jul 2026 20:00:23 +0200
X-Gm-Features: AVVi8CcS3SKBXiRqnUEVp14psIAYY_ciJjhgFTNlSKDvmnRbNTK-HfNc6gtZ-qI
Message-ID: <CA+=Fv5R=mUW_p_AFFr-588F_b1hB=7RhMbtODya-gby=_fjBgg@mail.gmail.com>
Subject: Re: [PATCH] proc: protect ptrace_may_access() with exec_update_lock
 (part 1)
To: Jann Horn <jannh@google.com>
Cc: arjan@linux.intel.com, brauner@kernel.org, ebiederm@xmission.com, 
	jack@suse.cz, jake@lwn.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	stable@vger.kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hi Jann,

>
> and that is wrong because previously, the ptrace_may_access() check
> relied on "error" still being "error = -EACCES" from the
> initialization at the top of the function, but now it is 0 from
> down_read_killable(), so now a ptrace permission check failure causes
> us to return with 0 without actually having called nd_jump_link(),
> which I think means we end up staying in /proc/$pid/ns?
>
> Sigh, I will send a fix.


Thanks for looking into this. That explanation makes sense, and it matches
what I was seeing from strace: /proc/<pid>/ns/pid could be opened, but the
NS_* ioctls then failed with ENOTTY and strace disabled pidns translation.

I'll retest the strace pidns-translation tests once your fix is available.

Thanks,
Magnus
