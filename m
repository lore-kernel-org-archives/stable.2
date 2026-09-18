Received: from mta0.migadu.com (out-110.mta0.migadu.com [91.218.175.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445234CA27E
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 11:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789732742; cv=none; b=hf43BKeV6pCuV/Up0lPu5+ntO4YHovAUwrAJJLPRUeXPzWwXzUoUNjV+omvd+o9VGVhd0BGz62g62KRfev3kJeSG/IQjFVoQQZ8ViVrho4mkpoVF8hKijaEcOXzxLR3lXviBALQhPcoT1uYHC8u/Vjc6x/MdE0We2g3kGuhpQj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789732742; c=relaxed/simple;
	bh=dZ+UU0cW7lO7sc/YWjbCFQdvW29aK3TMctUKE8s0RwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jUEqo36pem7VB1VDyClzyulFpKV1ZpJQbAE20BZ3TsvKA/PV0SRsK5ZgG5YOSX8Gb0zqzDYO67IXoET1utFTlST7lWjSKOdttAOlfmXpn9iWLhujUnUutaNFjDLXYcI3qRudOYA55gbA1GaD5l+F11Wzec+RPQeerFmutqrMeTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ldKEMTrF; arc=none smtp.client-ip=91.218.175.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ldKEMTrF"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=dZ+UU0cW7lO7sc/YWjbCFQdvW29aK3TMctUKE8s0RwA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789732738; v=1; x=1790337538;
 b=ldKEMTrFEy3fmKEVUcGHUBddV4/P9fTB3fA8AVfBU/OtKa+YViYhDrOqfKBcA9/FzLerUcYJ
 +WhO1hmKDnphOMGOEVszkvAVYumPbFtorQCdA9scFqpQNrsH5Uulh7crREiWacPSIwLET2M83hc
 sPs+LPXMFcMv7RpKzp/+P5DU=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 92bd7e6bfd46f09c;
	Fri, 18 Sep 2026 11:58:58 +0000
X-Mizu-Trace-ID: 92bd7e6bfd46f09c
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5b83c1421ecso6311e87.1
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 04:58:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBz70lS6H0gp1UPscJEdWfj3HSJYh3cAtOrFq0HRITm2vzn8/lJXb+rS7YVOw/Kcc1xzuQjN/io=@vger.kernel.org
X-Gm-Message-State: AFuF++liyhQ/fWDa6xMQvi6vw5jPf+5HIj8b9A76VVghqxmSACT3lnfu
	/1DK1lk7u6O/WVwdarosUT8/NHNtRRW3s7NpTchQ+D4oX9cTOqTUlRfkMaAtz4VH24/2yRHUEz0
	sEQpQfLYnJ+QSgbvr4lwhlpi+/PTOFJkXpyAZq9ZK
X-Received: by 2002:a05:6512:3c9f:b0:5b2:a967:c0e1 with SMTP id
 2adb3069b0e04-5b8c0fcad95mr166760e87.0.1789732733287; Fri, 18 Sep 2026
 04:58:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918040214.85580-1-ndaugoing@gmail.com> <20260918040214.85580-2-ndaugoing@gmail.com>
 <CA+EHjTx8zzvgqj99TKWfRD58X-M8v+hs9358_r_1zZonFNEsgw@mail.gmail.com> <CAC2BP3K-fvW2s2j2ys+kPMuxrzeMw9yc6MrAk7U7CqCpb2WePQ@mail.gmail.com>
In-Reply-To: <CAC2BP3K-fvW2s2j2ys+kPMuxrzeMw9yc6MrAk7U7CqCpb2WePQ@mail.gmail.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Fri, 18 Sep 2026 12:58:17 +0100
X-Gmail-Original-Message-ID: <CA+EHjTx9bTDuTnGgkrCcaAG+1S1Lx6+1BZnuhJcWNTJxWXkAHw@mail.gmail.com>
X-Gm-Features: AcwNN1W8n3dmMVZr53drbRK261wAXv8qWFmrNE31MdA1aY5Yy24oy1p3VG9UCp8
Message-ID: <CA+EHjTx9bTDuTnGgkrCcaAG+1S1Lx6+1BZnuhJcWNTJxWXkAHw@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: arm64: vgic: Do not remove in-flight LPIs from AP
 list on disable
To: Yuchao Zhang <ndaugoing@gmail.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yuchao,

On Fri, 18 Sept 2026 at 12:51, Yuchao Zhang <ndaugoing@gmail.com> wrote:
>
> Hi Fuad,
>
> Thanks a lot for pointing me to that thread! I was not aware of
> Hyunwoo's earlier report and the discussion with Oliver and Marc.
>
> I'll read through the thread and their rationale on the ap_list_lock
> approach. I'm happy to defer to Hyunwoo's effort to avoid duplicate
> work.

I'm not sure you should defer to their effort. It doesn't seem like
Hyunwoo has done any work on this for a while. I just wanted to point
you to the existing discussion.

Cheers,
/fuad

> Thanks again for the pointer!
>
> Best regards,
> Yuchao
>
> Fuad Tabba <fuad.tabba@linux.dev> =E4=BA=8E2026=E5=B9=B49=E6=9C=8818=E6=
=97=A5=E5=91=A8=E4=BA=94 15:22=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Hi Yuchao,
> >
> > On Fri, 18 Sep 2026 12:02:14 +0800, Yuchao Zhang <ndaugoing@gmail.com> =
wrote:
> >
> > [...]
> >
> > > Note: this closes the primary race (the last_lr_irq node itself is no
> > > longer unlinkable while in-flight), but the fold traversal can still
> > > race with a remote flush unlinking a subsequent non-LR node in the
> > > ap_list tail. Fully closing that window needs the fold side to take
> > > references before dropping locks (in the spirit of the prune-side fix
> > > in commit 7258770e5814 ("KVM: arm64: vgic: Handle race between
> > > interrupt affinity change and LPI disabling")) and is left as a
> > > follow-up.
> >
> > This is the same race Hyunwoo reported back in June [1]. You might
> > want to have a look at that thread first: Oliver and Marc's view there
> > was that the fix is to take the ap_list_lock in
> > vgic_v3_fold_lr_state() [2][3], and Hyunwoo posted a draft of that
> > [4].
> >
> > Cheers,
> > /fuad
> >
> > [1] https://lore.kernel.org/r/aiHrGM1f8czcUby4@v4bel
> > [2] https://lore.kernel.org/r/aiJi5a3JJ-TbWL-s@kernel.org
> > [3] https://lore.kernel.org/r/87a4t99z9n.wl-maz@kernel.org
> > [4] https://lore.kernel.org/r/aiXvwGD1hS6vwLEd@v4bel
