Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAFE381EBB
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 15:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783955972; cv=pass; b=JYiaZxSg7JpMfqus3U68wOSCz4I5jkU/WiTiIx86OSo8LNSkegaQQ/bpWr/TdMTVW9hTYlaKg1FvqyEXwIeANKRbmfzirHu48umcizTPX4mw55o3VH6fdxW/8jXAXBXamlKt7fJl7JoIGzLibDONemQdPxmNFMRPPNMPZUAKzFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783955972; c=relaxed/simple;
	bh=sEE3FMqOqkgJ0LjaW8o88lS57GWwQKCfWUiiHh0s0hA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hvYunOR1t9AfSlHoYJYdajvZxO0KvkmBTjWF9tDXV3S3ts/9rioTg9lN1aDLLU2LBhVrm9lfE33fL7LX1VW8q8Hbv4IXXECaac/QffdIeR8LHdxxm1n/0Rg/wgDqy7Z0dFBow/kkZZbJuKchdtOFsAuOdUUwnOazdcKKcTkX5Gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kFt3PI1Q; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kFt3PI1Q"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-698b78c05b0so5897a12.1
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 08:19:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783955969; cv=none;
        d=google.com; s=arc-20260327;
        b=f3Zi3xxR720tJu5FYYK8dseaDXCPM1iN2Jka9hueIBFPT7LisvKvtLoUDVg3FdmO5Y
         stTQ+aWeL3LPTGyLbYkVMaoOCjFRiH3L2zkNVxb95pJZV0nRuC4FNzKWBxTATtlba8Yb
         jGI/Zqe4geMu/yerWlzY8xiqiUw5b/LkFL5L/O67eZJI03qDFMPSyCH08TZ2+9ALowt9
         XgoJpFON66g4h+6NzhDeWNr5PAdyTaZDgQrWwjW/Ysc1YgqwI6Lt5SLaR5mxNWlerQ6L
         UHULRddO8MHpkGswEKbGpVFHjS3SAKA1CcGfzkJUvzBKgievCWZdPP2R2qc2x3oVjwNa
         jPfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FG71CBoheueQ+381OlVy9pD30LVk3nyO1mhdOYTqr5E=;
        fh=0mlf7SB5gGQ8F5GZtaB3O5LjDeQG3chLQnYT5PIoP0E=;
        b=QvhfD33nNYZMZuG0FymtbcVDX2nUQi551mfUKqAJIIogJhlag3f9YyZXEX9/g+PQWp
         hAryi7gg6O+ue8/S/BH8ia185NcWNCVjeIbMrCQM7ix/aFh9dlexPbGR8WKp4Q799O/3
         AxEpbmqVhlXGeUWVATuSoFhShw9CBsOUSDxekx1OBzI9s4klSN9GyJtMRy1QMCH7lyjR
         +I7yNP1RfaWUKbCXpAQat6SGLTDfbseANFrPOJAHzj14Oc0zHYfGqIW2itbxCfHxTYFj
         5QErP+LGYwkZviyzpsqfKPASApgQ0GiRz4/dMoYZFOtoGO0YiulZI0BM71gNgqqByqMr
         TeHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783955969; x=1784560769; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FG71CBoheueQ+381OlVy9pD30LVk3nyO1mhdOYTqr5E=;
        b=kFt3PI1QZw9DhboebyXuep+pJfRL8F396BztJKrxxhrAeQxzZSE8ligQkAk4PSz8Vn
         FKncFxU+Mu1cUE8efVmT9G01ku3WBjzY2BTMdSBUicG8paHVFxL2FoRCc7qNtIzQ6y69
         RP3ATif6Ex4uJOnnZHOFLGjDX11p4vOK5kehWNBvDek6uLZz6p7c4K2KDWhhZ/32ut5b
         MbXuqUXjyEaF/P0G7sqjWmcw2siHyneJ+HKJHyis1AkIMHQfcWhT1QU7KojlG6TQ22Rc
         5uLEZe8mOUc2LNXkGtzf7sKVrxl5Z0WNBu5P/B/15BWYmBEcbTAR1V3JWFZmwvDBQd/h
         +Zvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783955969; x=1784560769;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FG71CBoheueQ+381OlVy9pD30LVk3nyO1mhdOYTqr5E=;
        b=F2BAUnPKLM+fOXhmgW2eR6GbAf1yJ9TsRQEHOwI7IZjJcOroRPm/jcDOzDMA20peKt
         5ISdGtwDnAS+H02MJJ+CdIHQXCHH5PzMsW++SCPLASgFoL2oS665mdlS7lS5Bfd2Pj4w
         FwZoIB/lo38s3zqFAyTzJhmBC4tLsrVsREtGNLpUNqtsI1Ao3yG0+fwVmxhrdKr938W/
         kQS+kNuX2BsxE0Lj20Md4QdR6NEOq/yR3cqm+rAvMnjQifd+Ct1mCF2iHlYMHw0/O86t
         VUlkpz5tgiDMAONlowdF9pQF2tdvV+CFjwkvkLtQy8YgJbZMK+ttDOJot2BauzxpifT5
         sU3Q==
X-Forwarded-Encrypted: i=1; AHgh+RrKDLdc4VvQeR8cmEikBcVK3qD3aheDcMvG8GoE4rCCMfZPh/DuMp4y96zqc6pPRN5CzbHeuxo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0RE/ZtVMThhJun+fPpPeu+dUDdRXttZWJjogH4VCzJqvl7DBf
	wLq+mARcLqoqD4vboPgxjP/4eV0BHUxtP85Ne9mNNVXNRsjt3A28P5giRwVTJxtt3+PdBky9lp/
	0NE4wFWXOiuvcIfInDLj/zNyV/vmWq61z5y5Tzfqr
X-Gm-Gg: AfdE7ckJtVANLNGJomXcRS96p+3I8q1oidpkUsiZXzIrH/7s/b9phGZdRgf0rHSFBfK
	G6gPIhaW4WVQgmh/+Tka2zVgIsRS/hDvU7pF3tSknStxGWXwWbXMtoaoSzgCt+d5CNSIJx0vR+j
	TL/YWZXkjdhiH5D0/bDdsF7TvcyUBTUsmOeA1qNWmTJ7ZN7ifkawq8TS/vhuD6H2mQr4s4aqJl4
	M7fJsdqEEEWSyr24Ntr1/1V5yNt0viQbpbfqr/KVjFdDyKG4Lik9sC2ynPt4nSfoxb+VgY=
X-Received: by 2002:a05:6402:5612:b0:697:be5e:3c26 with SMTP id
 4fb4d7f45d1cf-69ccf0e109dmr30478a12.7.1783955968197; Mon, 13 Jul 2026
 08:19:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260712174619.3553231-1-tj@kernel.org> <20260712174619.3553231-2-tj@kernel.org>
 <alTsERFTlUKCLw4C@matt-Precision-5490>
In-Reply-To: <alTsERFTlUKCLw4C@matt-Precision-5490>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 13 Jul 2026 08:19:12 -0700
X-Gm-Features: AUfX_mwJphU_f7-jLqu_Z_Ua6JyGkcwumDuVDobQYNKxyxoqyxOYbk8wQ-qoTzY
Message-ID: <CAJuCfpGAx3t_ur3gkpvr8uxooM5=1pbA+ap_qtUvu=CjNzaYzQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] sched/psi: Create the psimon kthread outside of cgroup_mutex
To: Matt Fleming <matt@readmodwrite.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Peter Zijlstra <peterz@infradead.org>, Edward Adam Davis <eadavis@qq.com>, 
	Chen Ridong <chenridong@huaweicloud.com>, Zhaoyang Huang <zhaoyang.huang@unisoc.com>, 
	"ziwei . dai" <ziwei.dai@unisoc.com>, "ke . wang" <ke.wang@unisoc.com>, 
	Matt Fleming <mfleming@cloudflare.com>, sched-ext@lists.linux.dev, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 6:48=E2=80=AFAM Matt Fleming <matt@readmodwrite.com=
> wrote:
>
> On Sun, Jul 12, 2026 at 07:46:18AM -1000, Tejun Heo wrote:
> > a5b98009f16d ("sched/psi: fix race between file release and pressure wr=
ite")
> > made pressure_write() hold cgroup_mutex across psi_trigger_create(), wh=
ich
> > forks the psimon kthread for the first rtpoll trigger. As kthread creat=
ion
> > depends on the whole fork path, the commit inadvertently created a lot =
of
> > unwanted locking dependencies from cgroup_mutex.
> >
> > sched_ext got hit by one: its enable path blocks forks and then grabs
> > cgroup_mutex, so a pressure write racing a scheduler enable deadlocks, =
with
> > every other fork piling up behind.
> >
> > Fix it by splitting trigger creation so that the worker is forked with
> > cgroup_mutex dropped and the kernfs active reference left broken. The l=
atter
> > matters because rmdir and cgroup.pressure writes drain active reference=
s
> > under cgroup_mutex. Publishing the trigger last keeps error reporting
> > synchronous and preserves the of->priv lifetime rules.
> >
> > The trigger registered in the first stage pins the group's rtpoll machi=
nery
> > across the unlocked window, leaving only creation races to resolve. The
> > catch-up poll on installation covers scheduling attempts dropped while =
there
> > was no worker.
> >
> > v2: Retagged sched/psi (was cgroup).
> >
> > Fixes: a5b98009f16d ("sched/psi: fix race between file release and pres=
sure write")
> > Cc: stable@vger.kernel.org
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Edward Adam Davis <eadavis@qq.com>
> > Cc: Chen Ridong <chenridong@huaweicloud.com>
> > Reported-by: Matt Fleming <mfleming@cloudflare.com>
> > Closes: https://lore.kernel.org/all/20260710100441.2653477-1-matt@readm=
odwrite.com/
> > Signed-off-by: Tejun Heo <tj@kernel.org>
> > ---
> >  include/linux/psi.h    |  4 ++-
> >  kernel/cgroup/cgroup.c | 23 +++++++++++++-
> >  kernel/sched/psi.c     | 69 ++++++++++++++++++++++++++++++++----------
> >  3 files changed, 78 insertions(+), 18 deletions(-)
>
> Tested-by: Matt Fleming <mfleming@cloudflare.com>

Acked-by: Suren Baghdasaryan <surenb@google.com>
