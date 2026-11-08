Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794147859;
	b=Ne2XcJPzhee1X5F71Y+Jt0//XQ2N6+D1NZHh3+a2dc74oPiJiN9xkLwLryydhlfu5S8P
	 UsRWQZRSzmmEuJPnvxteJwsY4+5iJRMLmH6zXMER+c4nL/Z63Mm0CoAHfyBTtPwQgUseN
	 AiOUsvF8lDDvf2IyrFpgWZHcn+RK4pUsqn6XuorC2zDIcQyfh8UfVM7HU+a4yoj7QMHfe
	 TfxBlZIu415o5dLWnsj5mGe1e7Yb+aewDTu1D3DcS9ugp2D+cBxhzYw1BEJrGk6GUqjHo
	 K5cag03xYYI76lgVRWfcSn0felm6a5DvxSd6dSRmVPSsMY35mcB8v0JhjnfWRP17K8A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794147859;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=r5RsrNxAh7DgoouGJ4IC6isO+zYq6OCTwcMbp742YFM=;
	b=KHjcGYyzNwg+J5JUAzWrM0L3Y4naDz3mXiHMn8FLeRSLM6aPJSLXgOrKhhrD3ffzi1Qw
	 Azt0WCquXu3u7q0ZigcY01skDXTKXqnKTNXIQvA9mWOkKePlrDPiSwLIli/asSpsZZsxQ
	 XX48oNTwph7BLo4ayNyERrrgRHawUqonGW5eVy4tLcbKSYQ85phB4x+KEXKOtFdOA1HfE
	 /FT3IDK8GORnbHXdg4vuyY8m1pbVR0jYXqAMI5T4lDOjcDVmMEnShXaAC12I+iKKDCCd0
	 DuXddmRwhAnKJkv/TTO2jvOVULlUqUtqZuaaEBp1LH+2GPjm+qG+iRglcA6kDw6bAVA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DB+hGGel;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C0F606A31C
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 14:24:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33C0F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DB+hGGel
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c4c9abc1824so15208666b.1
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 06:24:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794147857; cv=none;
        d=google.com; s=arc-20260327;
        b=Wk7sH8qOM8yMLs2kIXBlJdLBp9lbrrmrig4Ll25WXKypnpeMh2hE9DmM/dZ3bpqTUr
         XHl0TvUAehoZ3/ZqJDVUs1acdQNqaFIvDWe2bxw6rzm+42nRzurbwTMCckd2Oo5NFFZ7
         CFxv4YtwiemZpel1TqL76aiGragq749aRj6LiJnwh7ywbGX0T1dJi+UrU+wRjyVRl9cR
         Nj67ohIHVpOMtRFiQuP04JdrYnjfGbG6v7UZ8cd3uOtRHgIh7WGZjeUYKVGfWun4wIei
         NzjNRl7TAbjT/wZbmCUTYkaJjVKeZt7nj7UOvSlLS0YrfAJ81P/+YJyVreF7RJwCom3f
         YHPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r5RsrNxAh7DgoouGJ4IC6isO+zYq6OCTwcMbp742YFM=;
        fh=ktvfpkTQygtZxCR71y0KDE1HYxsGOYmgQtxxitXWXKw=;
        b=BlED1NtRdTo5Murbw+KShuONFuXxjULYNr2ofBgn2m8HOxyt60YHQ/mAbF5rZufnCq
         auzBDSlBFm7182RgWpP0MrNjH+VqaShmDybeUqTW8bKsjv7wCMzIpCNWsypdaPuyNVvR
         blIG6Iw0scCUTWMYA65lGhJZB5WDjvpKPbsadUjBv70b0Fe4Lxwb1DS5FIDiwBv5fyPK
         bMtaSFbgwwjDzOaGC/vfzM3Y/Co3OtytDi/fHG9gjmzQJDNr3jqHst/BIGSmaEDMmgnt
         OFhrQvd22uqogtUIZH3tIw9OgRFZyG+sCzeQ+ZCYeIqLvSG3+ThQmKSyK4W+UOZaDvLV
         st3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794147857; x=1794752657; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r5RsrNxAh7DgoouGJ4IC6isO+zYq6OCTwcMbp742YFM=;
        b=DB+hGGelTuimW9Jk6S6fyUJv64EtwmjJNy/ZcsffOUmAM4XbIG765WxolnIvcUOih8
         8iXTo/jlplBIHduVmtrnLpO44ZUX1kzHukgMIYfyvqTVEze0iMVLT00v4YUb8z9qxHwx
         s05wDRh/HV6mlPX07sgeXfK3tLMKC61Jn/Nlh+wgCIQASwb8c0JUeslninqQQUpOO6e3
         ns4kGZ9MblZ+3TBnqyj7d3rvNGdClHRmPyyUCXKdrexjvS560tkrLEh46lFU066gi6es
         cVDdE+iOnurmI7CsJGpazXxDxM5HrvHla0teHpmfm8rdwdeqwCAJ2ekBmdds+gN6M4S5
         +60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794147857; x=1794752657;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r5RsrNxAh7DgoouGJ4IC6isO+zYq6OCTwcMbp742YFM=;
        b=kmoY666kEr0DH3eQm8U8rAXTs+6FDYq6FoMKphECNEOgaRspQouYVis+pBfQyQm1J+
         tge7na5/VW0O893exyej5tLTCAGcjKANQUiEHBUlHQLMMcHIz7TTPFe0aTL5TctXgJj8
         TYRdvlj1AqyK3dyAXIzCyY/xWFm9mSlDjIB92tQruxsAKtqRULicw5WdxTjnkyE2fR0g
         vh+FvuxSW3GVgvDTWEQEKC1eWeqlDTB0nCIsw8Gub5RenhbSC10fFNbD7FTNhVr3SdQh
         qiOUaACP+kumz6BAzYbNGl2e3Y0TWVejyh4tqXYcPW3GIxEIuu/AcS1FdBSw0n20q0zm
         7aJA==
X-Forwarded-Encrypted: i=1; AL+hErEPARe2uoqHzoAkqLHxj3g7vdm7gVaa3z2nae0X5R19/MG3K4jpFCZqxq3gnKL8xkRNSc82/gI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ScN1POuJHiH8Cf8yTVNPOkPfsKyTjcOS7l4k8qR6mFuMK/PS7
	3tdEjEodlHdDkR43rmDV7QiicLQXWQTVpF5nOzEmtM+81gvX2zSPowFB5tCLVrZ3UUAnSp/3ziG
	vOwNrK/9q6GUUSZ0jBOAbKraTqAk/HlI=
X-Gm-Gg: AYBFou1kfMjTB9JlEY58+DX0ZP/qomDoLjL52bA6Ef3sUwCGJ/YiaKaHg7X5hpvxbuV
	RS/SmcngFZfx7wbfgQXBQiipDr77dav3n2HB1tpXRxwJD6CuQUh1/13qbGUztTbkV5jEPITn3q6
	Pp1wioLTs5Qp3e3IkIQz6LVGIxM6ZkmxDYlRcOk6jmBYoig9LFJwPl4eH+wSBm+8wVJnfCS6I6W
	CGktxgwZZrhs+BBJlTf/ZibZ6FdUv/gLO9Pv0iNLBAhmyAoQ3nZY7Tuzd1D1/ZUfL9LYL+9ByE8
	QoetGnRx16eZhX5xWcoSMflMK7gNsbDZRXLPGrlIqMRFKkIqtVol/99VH6S1fR3pbw9WD6xXIao
	laUa3Ev+0PnJnLR6jOf4oqYSG9PgV6R52/C5A9ILfvuJISlrWqxCEtOPRvABNT/Z4yTO0kA==
X-Received: by 2002:a17:907:7b91:b0:c46:645f:cee2 with SMTP id
 a640c23a62f3a-c4d6d994688mr122085066b.4.1794147857304; Sun, 08 Nov 2026
 06:24:17 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108132634.2650642-2-bestswngs@gmail.com> <74b00dcc-113f-4532-81f5-e7e0814ddc4c@efficios.com>
In-Reply-To: <74b00dcc-113f-4532-81f5-e7e0814ddc4c@efficios.com>
From: Weiming Shi <bestswngs@gmail.com>
Date: Sun, 8 Nov 2026 06:23:40 -0800
X-Gm-Features: AclHuK-RDpsKHHqs6Zf5S8zaUfD4URbw08aTNu88KBVtWVm-WrJ2tV0BX7o5hF8
Message-ID: <CANgPUi1To9bPCj0WE95mLMSBjw9hG+0oxAAPrApLv7Pvijr_NQ@mail.gmail.com>
Subject: Re: [PATCH v2] sched/mmcid: Synchronize exec MM teardown with
 affinity updates
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	linux-kernel@vger.kernel.org, Marco Elver <elver@google.com>, 
	co+cab19e2ebe4d535a@bugs.sh, Xiang Mei <xmei5@asu.edu>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Mathieu Desnoyers <mathieu.desnoyers@efficios.com> =E4=BA=8E2026=E5=B9=B411=
=E6=9C=888=E6=97=A5=E5=91=A8=E6=97=A5 05:33=E5=86=99=E9=81=93=EF=BC=9A
>
> On 2026-11-08 08:26, Weiming Shi wrote:
> > set_cpus_allowed_common() passes a remote task's p->mm to
> > mm_update_cpus_allowed(), but the scheduler locks do not stabilize that
> > pointer against exec. A same-owner sched_setaffinity() can race the tar=
get
> > replacing and freeing its old mm. Current kernels are only incidentally
> > serialized by futex_exec_done() taking p->pi_lock when CONFIG_FUTEX=3Dy=
;
> > valid CONFIG_FUTEX=3Dn builds remain vulnerable.
> >
> >    BUG: KASAN: slab-use-after-free in set_cpus_allowed_common (kernel/s=
ched/core.c:10835 kernel/sched/core.c:2829)
> >    Read of size 4 at addr ffff88810991b04c by task poc/5127
> >    Call Trace:
> >     set_cpus_allowed_common (kernel/sched/core.c:10835 kernel/sched/cor=
e.c:2829)
> >     set_cpus_allowed_fair (kernel/sched/fair.c:10046)
> >     __set_cpus_allowed_ptr_locked (kernel/sched/core.c:2842 kernel/sche=
d/core.c:3224)
> >     __set_cpus_allowed_ptr (kernel/sched/core.c:3258)
> >     __sched_setaffinity (kernel/sched/syscalls.c:1161)
> >     sched_setaffinity (kernel/sched/syscalls.c:1239)
> >     __x64_sys_sched_setaffinity (kernel/sched/syscalls.c:1275)
> >     do_syscall_64 (arch/x86/entry/syscall_64.c:84)
> >     entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
> >
> >    Freed by task 5128:
> >     kmem_cache_free (mm/slub.c:6757)
> >     __mmput (kernel/fork.c:1204)
> >     mmput (kernel/fork.c:1215)
> >     setup_new_exec (fs/exec.c:1395)
> >     load_elf_binary (fs/binfmt_elf.c:1024)
> >     bprm_execve (fs/exec.c:1865)
> >     do_execveat_common.isra.0 (fs/exec.c:1963)
> >     __x64_sys_execve (fs/exec.c:2036)
> >     do_syscall_64 (arch/x86/entry/syscall_64.c:84)
> >     entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
> >
> > After exec publishes the new p->mm, acquire and release the task's runq=
ueue
> > lock before the old mm can be dropped. Affinity updates already hold th=
at
> > lock across set_cpus_allowed_common(), so the barrier waits for any upd=
ate
> > that loaded the old mm. Updates that start afterwards observe the new m=
m.
> >
> > This keeps allowed-mask updates synchronous, including transient affini=
ty
> > expansions, without changing the MM-CID fork, exit, or scheduling paths=
.
> >
> > This change was developed with assistance from an LLM.
> >
> > Fixes: 7e019dcc470f ("sched: Improve cache locality of RSEQ concurrency=
 IDs for intermittent workloads")
> > Cc: stable@vger.kernel.org
> > Reported-by: <co+cab19e2ebe4d535a@bugs.sh>
> > Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> > ---
> > Changes in v2:
> > - Replace the schedule-in deferral with an exec-side runqueue-lock barr=
ier.
> > - Keep affinity expansions synchronous, including expansions narrowed b=
efore
> >    the next schedule-in.
> > - Avoid changes to the MM-CID fork, exit, and scheduling state machine.
> >
> >   fs/exec.c             | 1 +
> >   include/linux/sched.h | 2 ++
> >   kernel/sched/core.c   | 6 ++++++
> >   3 files changed, 9 insertions(+)
> >
> > diff --git a/fs/exec.c b/fs/exec.c
> > index 8d2b14e1d455..2e1cac6a3de7 100644
> > --- a/fs/exec.c
> > +++ b/fs/exec.c
> > @@ -905,6 +905,7 @@ static int exec_mmap(struct linux_binprm *bprm)
> >               BUG_ON(active_mm !=3D old_mm);
> >               /* Defer teardown to setup_new_exec(), outside the exec l=
ocks. */
> >               bprm->old_mm =3D old_mm;
> > +             sched_mm_cid_exec_mmap(tsk);
> >       } else {
> >               mmdrop_lazy_tlb(active_mm);
> >       }
> [...]
> >
> > +/* Wait for affinity updates that may still be using the old MM. */
> > +void sched_mm_cid_exec_mmap(struct task_struct *t)
> > +{
> > +     guard(task_rq_lock)(t);
> > +}
>
> Using a lock side-effect as synchronization of what sits _outside_
> of the lock is an interesting synchronization pattern. If this actually
> works, it should be thoroughly documented.
>
> It should come with at least one sequence diagram explaining why this
> works, along with acquire-release MO explanation.
>
> Thanks,
>
> Mathieu
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com


Hi Mathieu,

Thanks for the feedback.

I will include the requested documentation, sequence diagram,
acquire-release memory order explanation, and reproduction code in v3.

Best regards,
Weiming Shi
