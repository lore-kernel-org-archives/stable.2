Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A50625785C
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 17:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782410155; cv=pass; b=bFhmjpO3Kh2SpZF8rhEn5FXnVZTgMdnKFxpjaDVH74dGfWpWJhHE91M3gG/M8AYPejW6l59hHHXMfzSdk6wNylRaU74bCVUuiWpcENv1rUS/rwYcr0VEcwqpANSCU6NshvydaKV/CJigpAogbhMLEXU/sggRGjULQyluU7Tz4Dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782410155; c=relaxed/simple;
	bh=KL7OUqxN1KQ/RK0Z6x8GGRsQ1dDi9OfJ6FYOtkRv5cw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ncsqhumeFpAR7bFr1YhmgM9bg9/9u05s6KvlEWAlBxG686NAgIj2lvPP8QGnURrA5CFZjKuoUPqDB3COHS+pLYg+mvy8x2eVlUXNbgAAT5BZjcFSsmkZ9Ia9LdgeG5d78VwBC4sC7L6/MlFrEpwwkTmVMszopr575TeKEvC0UxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCmZW8m+; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCmZW8m+"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-37dedd9401eso61548a91.1
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 10:55:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782410153; cv=none;
        d=google.com; s=arc-20260327;
        b=B18tuj75sHcZnF5NAfrCiSiRCIDfLR8Y0zKku6e+dOvhg61wvfN2jvsikZHuPDmjCR
         K7oUZ6cNmnZ5vf0OiAfsPsGFFdhjrv3T+yhcbjDak9TpxyHiOMoN8nvVBfdn1tfKLMzi
         k0GCCZCADV6aS8M6JDNGPCkhzBdz/abVdAA2A0Uhqv71hc9Pw+xurLprAZaeZ9qdQknG
         PI/vYDouU88xDnV+IdwlEmVq4+XlyyfmljpMxzzjXYrt06uILuY7zMBfLCFYk2eOfGwV
         Jj4Gbvc6BA4iZ1vFMCm2VKC0HNUS3DT6WiQk7ZVtnRvrVUI1Hyd6RWNrqL9ve5M7AEpL
         fm3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=70lqxrDgx0O9fRvHia8p/z9fa6BrG/EerRGOH0ZlW+w=;
        fh=BpFyMBoE24qfNRywuuf2z+H2AN+TVISWBuPZo33uQyw=;
        b=glsZ2FXOec+Dybtd1/8HIHr4cLUJ/7MEsoU2ZxpD3fEHc2EzM2DQ6yXhaZa+YP1RQP
         5XOpHVs8O181k3bK3TA9RWuy22S6RwuDEYCUvLupnYUnmaw2TkV7EhL4OYlWVBaDPQWh
         R/HgdX8XEIAaDAKV2AxPyIxoRfzW2OnbrRsa09IoqkPlXsLuJOhZCLC7PY8jMikTOmUV
         6M2ktyBteCsfk6PLo4jFHmzkpxpG98uELu8sJjyQXg1efSFMXlUWRT3tv35BA61we1rC
         ziZPl8P29e4wOjWM62lqNDiwuK/0vrlOv5mzYeyYPbSb3rtcXk6ayW+8/9OCNHb+I62S
         RyDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782410153; x=1783014953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70lqxrDgx0O9fRvHia8p/z9fa6BrG/EerRGOH0ZlW+w=;
        b=dCmZW8m+tPSpcfvosK8NvfuqT9s7O6I4WW8Dq8VjgW7ReLiaGG4DlZtJN4qUSbf7Zx
         svAEmoQnm9ZtX8yToat+edfLEhhq9uZU+hHoKihlLx40IKkV58s+Pfk4lRrQflzYcf3V
         kq0uyGPxorRRcKJgcWrZMM4omrKZZs/a+yMDiSu9O8dYCsJ1F+5MpyBMgP0KcS98gpII
         b0Fvz0uCmAuFZ8zqHa2l8GoZN8XnyUlHebOFPoVjjnImSZow7ypOt75u+o91m+hOgjbg
         ioUX147vaDd2E5qz/ccRWmbkwif6SgLILarxYKad34TZsj5S17RXxvPC4tb1Tnem694o
         J9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782410153; x=1783014953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=70lqxrDgx0O9fRvHia8p/z9fa6BrG/EerRGOH0ZlW+w=;
        b=HSCwoO7N/RLqn0/eLmqTVrjd9qVawvA3KUpN7O0JJe6f0GlOX44cK3lxcV77iGw4uQ
         Ol/sXrzW95NiCCyVtoHaeFN9QxwVg6uwHNqzW5bNJ259gaEMweGR9rdppCsR/OaXHOB6
         5J2ivFDeAKFyl6krI1EiKxR6qme1rEYtUppBJkkF0IHEb3TyISe9U3seOqodPe3tJyug
         pN2bw5nEqtNnzRcqjjBjjJBk2kdTOTGd3M0ocDCuhOIG7JZVCAnR2u6Cx8aZGz5wQ9RK
         fGOZtNCaAth91qDyRywK/LmdDkDVxcjDN+nn40YYrvUzils6wbjK3QxaQ6q/69EwWMq0
         OyTQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr9aQhuQngpz3rOWHgUQejey8uwAPSE9Zq9w8EOoftHAMSL/Ee4ED69GJq360jX777ferpO3+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBxMb3hOXnTVNnbyyultp97UN08A2mTLbENG8vaiG+r2tO/8AP
	wUKm+mMGeEDHYKpg8nOAWgu+16LkDU0GqWg/F0WNOM3VK5ih+fwIT/TQyTT0SmLky4ChyA5488T
	nDNpZXszHDihLI+FicDy7gaWOMzpJ5xc=
X-Gm-Gg: AfdE7clgQsP5Wkay7TiwuOpMk/C2Mq9ASKAiD2kWLPCNyy0mjqHBA7KJsBrz1YL57uX
	7xjRFDFMp8wi22hfQKXPdfSGqVmFC7M6Ah31EG5j04Hz++GS6sq0dgBVB3jByvJ6QSv6ptJ4nd8
	8hsJe1qO1soGlGZKxSeXG8rkW9FMXV1xP3mBcua007jBU6MA95P7RkgmoMhBHpax3JyIIOeI7mx
	+vvSnImbZmZS17FDFFX0CmFF50j2NYrjkOUq1O65MBbWq4F1CvzBcM2+JQsqX4M+MB1HDUUIAmR
	dV4Vq+qVByQKYdBTwKtp6++e3KYyFCJoXibMdjPfj6UZQJhNsZmMH5FJzYS7kL26h11nQQ==
X-Received: by 2002:a17:902:e544:b0:2c8:8f7:cc36 with SMTP id
 d9443c01a7336-2c808f7cf3amr17223595ad.17.1782410152652; Thu, 25 Jun 2026
 10:55:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623112533.1151502-1-vmalik@redhat.com> <DJGJ9F6WQZV9.2W4WBIHYLJQ97@gmail.com>
 <ajq98dm4gAwEzkMb@google.com> <c2f4e45e-d5c9-42e9-a46b-25fb0cacb267@redhat.com>
 <93e70dc7-e52f-444e-b57e-09d149dc4808@redhat.com> <CAEf4BzYWdsBDQ3D41=+n_oCO68bVOtKuqQCqZOEVo=j7nK9Ozg@mail.gmail.com>
 <82252ae0-133a-45dc-9622-315236a437ad@redhat.com>
In-Reply-To: <82252ae0-133a-45dc-9622-315236a437ad@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 Jun 2026 10:55:38 -0700
X-Gm-Features: AVVi8CfHmVjHnPKT82GCu2a4GZmhSlG7FqqlONu-C9MUDK52gjtj7DMiNoteTMQ
Message-ID: <CAEf4Bza8vFSkuiD_Vd47-eGuDS40kKvTcHQR=V3OY=c505a9=g@mail.gmail.com>
Subject: Re: [PATCH] perf trace: Refactor augmented_raw_syscalls using bpf_loop
To: Viktor Malik <vmalik@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Michael Petlan <mpetlan@redhat.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 4:58=E2=80=AFAM Viktor Malik <vmalik@redhat.com> wr=
ote:
>
> On 6/24/26 19:19, Andrii Nakryiko wrote:
> > On Wed, Jun 24, 2026 at 3:27=E2=80=AFAM Viktor Malik <vmalik@redhat.com=
> wrote:
> >>
> >> On 6/24/26 08:47, Viktor Malik wrote:
> >>> On 6/23/26 19:10, Namhyung Kim wrote:
> >>>> Hello,
> >>>>
> >>>> On Tue, Jun 23, 2026 at 08:27:39AM -0700, Alexei Starovoitov wrote:
> >>>>> On Tue Jun 23, 2026 at 4:25 AM PDT, Viktor Malik wrote:
> >>>>>> The loop for processing syscall args in augment_raw_syscalls has a
> >>>>>> history of breaking with Clang updates, see e.g. commit 013eb043f3=
7b
> >>>>>> ("perf trace: Fix BPF loading failure (-E2BIG)") from Clang 15 to =
16.
> >>>>>>
> >>>>>> Now, a similar thing happened between Clang 21 and 22. While the i=
ssue
> >>>>>> is mitigated on the main line by a recent verifier update, it rema=
ins
> >>>>>> broken on the 6.12 and 6.18 stable branches:
> >>>>>>
> >>>>>>     [linux-6.18.y]# sudo perf trace true
> >>>>>>     libbpf: prog 'sys_enter': BPF program load failed: -E2BIG
> >>>>>>     libbpf: prog 'sys_enter': -- BEGIN PROG LOAD LOG --
> >>>>>>     [...]
> >>>>>>     BPF program is too large. Processed 1000001 insn
> >>>>>>     processed 1000001 insns (limit 1000000) max_states_per_insn 40=
 total_states 37941 peak_states 232 mark_read 0
> >>>>>>     -- END PROG LOAD LOG --
> >>>>>>     libbpf: prog 'sys_enter': failed to load: -E2BIG
> >>>>>>     libbpf: failed to load object 'augmented_raw_syscalls_bpf'
> >>>>>>     libbpf: failed to load BPF skeleton 'augmented_raw_syscalls_bp=
f': -E2BIG
> >>>>>>     Error: failed to get syscall or beauty map fd
> >>>>>>     [...]
> >>>>>>
> >>>>>> The reason is that the loop is quite complex and the BPF verifier =
often
> >>>>>> struggles to prove that it terminates.
> >>>>>>
> >>>>>> Fix the issue by refactoring the loop body into a callback functio=
n and
> >>>>>> calling the bpf_loop helper. This should prevent future breakages =
of
> >>>>>> this kind since the callback function has no loops. It also allows=
 to
> >>>>>> drop a few artificial checks to help the verifier, including the c=
hanges
> >>>>>> introduced by 013eb043f37b.
> >>>>
> >>>> Thanks for working on this.  I encountered this issue before and nev=
er
> >>>> found time to take a deeper look yet.
> >>>>
> >>>>>>
> >>>>>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> >>>>>> Fixes: a68fd6a6cdd3 ("perf trace: Collect augmented data using BPF=
")
> >>>>>> Fixes: 013eb043f37b ("perf trace: Fix BPF loading failure (-E2BIG)=
")
> >>>>>> Cc: stable@vger.kernel.org
> >>>>>> ---
> >>>>>>  .../bpf_skel/augmented_raw_syscalls.bpf.c     | 157 +++++++++++--=
-----
> >>>>>>  1 file changed, 96 insertions(+), 61 deletions(-)
> >>>>>>
> >>>>>> diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c=
 b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> >>>>>> index 2a6e61864ee0..6d553ed3ac23 100644
> >>>>>> --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> >>>>>> +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> >>>>>> @@ -429,15 +429,96 @@ static bool pid_filter__has(struct pids_filt=
ered *pids, pid_t pid)
> >>>>>>    return bpf_map_lookup_elem(pids, &pid) !=3D NULL;
> >>>>>>  }
> >>>>>>
> >>>>>> +struct args_loop_ctx {
> >>>>>> +  struct syscall_enter_args *args;
> >>>>>> +  unsigned int *beauty_map;
> >>>>>> +  void *payload_offset;
> >>>>>> +  int value_size;
> >>>>>> +  u64 *output;
> >>>>>> +  bool *do_output;
> >>>>>> +};
> >>>>>> +
> >>>>>> +static long process_arg_cb(u64 i, void *ctx)
> >>>>>> +{
> >>>>>> +  /*
> >>>>>> +   * Determine what type of argument and how many bytes to read f=
rom user space, using the
> >>>>>> +   * value in the beauty_map. This is the relation of parameter t=
ype and its corresponding
> >>>>>> +   * value in the beauty map, and how many bytes we read eventual=
ly:
> >>>>>> +   *
> >>>>>> +   * string: 1                          -> size of string
> >>>>>> +   * struct: size of struct             -> size of struct
> >>>>>> +   * buffer: -1 * (index of paired len) -> value of paired len (m=
aximum: TRACE_AUG_MAX_BUF)
> >>>>>> +   */
> >>>>>> +  struct augmented_arg *augmented_arg;
> >>>>>> +  struct args_loop_ctx *loop_ctx;
> >>>>>> +  int aug_size, size, index;
> >>>>>> +  bool augmented;
> >>>>>> +  void *arg;
> >>>>>> +
> >>>>>> +  /* Bounds check for the below map access to help the verifier *=
/
> >>>>>> +  if (i < 0 || i >=3D 6)
> >>>>>> +          return 1;
> >>>>>> +
> >>>>>> +  loop_ctx =3D (struct args_loop_ctx *)ctx;
> >>>>>> +  arg =3D (void *)loop_ctx->args->args[i];
> >>>>>> +  augmented =3D false;
> >>>>>> +  size =3D loop_ctx->beauty_map[i];
> >>>>>> +  aug_size =3D size; /* size of the augmented data read from user=
 space */
> >>>>>> +  augmented_arg =3D (struct augmented_arg *)loop_ctx->payload_off=
set;
> >>>>>> +
> >>>>>> +  if (size =3D=3D 0 || arg =3D=3D NULL)
> >>>>>> +          return 0; /* continue */
> >>>>>> +
> >>>>>> +  if (size =3D=3D 1) { /* string */
> >>>>>> +          aug_size =3D bpf_probe_read_user_str(augmented_arg->val=
ue, loop_ctx->value_size, arg);
> >>>>>> +          augmented =3D true;
> >>>>>> +  } else if (size > 0 && size <=3D loop_ctx->value_size) { /* str=
uct */
> >>>>>> +          if (!bpf_probe_read_user(augmented_arg->value, size, ar=
g))
> >>>>>> +                  augmented =3D true;
> >>>>>> +  } else if (size < 0 && size >=3D -6) { /* buffer */
> >>>>>> +          index =3D -(size + 1);
> >>>>>> +          barrier_var(index); // Prevent clang (noticed with v18)=
 from removing the &=3D 7 trick.
> >>>>>> +          index &=3D 7;         // Satisfy the bounds checking wi=
th the verifier in some kernels.
> >>>>>> +          aug_size =3D loop_ctx->args->args[index];
> >>>>>> +
> >>>>>> +          if (aug_size > TRACE_AUG_MAX_BUF)
> >>>>>> +                  aug_size =3D TRACE_AUG_MAX_BUF;
> >>>>>> +
> >>>>>> +          if (aug_size > 0) {
> >>>>>> +                  if (!bpf_probe_read_user(augmented_arg->value, =
aug_size, arg))
> >>>>>> +                          augmented =3D true;
> >>>>>> +          }
> >>>>>> +  }
> >>>>>> +
> >>>>>> +  /* Augmented data size is limited to sizeof(augmented_arg->unna=
med union with value field) */
> >>>>>> +  if (aug_size > loop_ctx->value_size)
> >>>>>> +          aug_size =3D loop_ctx->value_size;
> >>>>>> +
> >>>>>> +  /* write data to payload */
> >>>>>> +  if (augmented) {
> >>>>>> +          int written =3D offsetof(struct augmented_arg, value) +=
 aug_size;
> >>>>>> +
> >>>>>> +          if (written < 0 || written > sizeof(struct augmented_ar=
g))
> >>>>>> +                  return 1; /* break */
> >>>>>> +
> >>>>>> +          augmented_arg->size =3D aug_size;
> >>>>>> +          *loop_ctx->output +=3D written;
> >>>>>> +          loop_ctx->payload_offset +=3D written;
> >>>>>> +          *loop_ctx->do_output =3D true;
> >>>>>> +  }
> >>>>>> +
> >>>>>> +  return 0;
> >>>>>> +}
> >>>>>> +
> >>>>>>  static int augment_sys_enter(void *ctx, struct syscall_enter_args=
 *args)
> >>>>>>  {
> >>>>>> -  bool augmented, do_output =3D false;
> >>>>>> -  int zero =3D 0, index, value_size =3D sizeof(struct augmented_a=
rg) - offsetof(struct augmented_arg, value);
> >>>>>> +  bool do_output =3D false;
> >>>>>> +  int zero =3D 0, value_size =3D sizeof(struct augmented_arg) - o=
ffsetof(struct augmented_arg, value);
> >>>>>>    u64 output =3D 0; /* has to be u64, otherwise it won't pass the=
 verifier */
> >>>>>> -  s64 aug_size, size;
> >>>>>>    unsigned int nr, *beauty_map;
> >>>>>>    struct beauty_payload_enter *payload;
> >>>>>> -  void *arg, *payload_offset;
> >>>>>> +  void *payload_offset;
> >>>>>> +  long iters;
> >>>>>>
> >>>>>>    /* fall back to do predefined tail call */
> >>>>>>    if (args =3D=3D NULL)
> >>>>>> @@ -457,63 +538,17 @@ static int augment_sys_enter(void *ctx, stru=
ct syscall_enter_args *args)
> >>>>>>    /* copy the sys_enter header, which has the syscall_nr */
> >>>>>>    __builtin_memcpy(&payload->args, args, sizeof(struct syscall_en=
ter_args));
> >>>>>>
> >>>>>> -  /*
> >>>>>> -   * Determine what type of argument and how many bytes to read f=
rom user space, using the
> >>>>>> -   * value in the beauty_map. This is the relation of parameter t=
ype and its corresponding
> >>>>>> -   * value in the beauty map, and how many bytes we read eventual=
ly:
> >>>>>> -   *
> >>>>>> -   * string: 1                          -> size of string
> >>>>>> -   * struct: size of struct             -> size of struct
> >>>>>> -   * buffer: -1 * (index of paired len) -> value of paired len (m=
aximum: TRACE_AUG_MAX_BUF)
> >>>>>> -   */
> >>>>>> -  for (int i =3D 0; i < 6; i++) {
> >>>>>> -          arg =3D (void *)args->args[i];
> >>>>>> -          augmented =3D false;
> >>>>>> -          size =3D beauty_map[i];
> >>>>>> -          aug_size =3D size; /* size of the augmented data read f=
rom user space */
> >>>>>> -
> >>>>>> -          if (size =3D=3D 0 || arg =3D=3D NULL)
> >>>>>> -                  continue;
> >>>>>> -
> >>>>>> -          if (size =3D=3D 1) { /* string */
> >>>>>> -                  aug_size =3D bpf_probe_read_user_str(((struct a=
ugmented_arg *)payload_offset)->value, value_size, arg);
> >>>>>> -                  /* minimum of 0 to pass the verifier */
> >>>>>> -                  if (aug_size < 0)
> >>>>>> -                          aug_size =3D 0;
> >>>>>> -
> >>>>>> -                  augmented =3D true;
> >>>>>> -          } else if (size > 0 && size <=3D value_size) { /* struc=
t */
> >>>>>> -                  if (!bpf_probe_read_user(((struct augmented_arg=
 *)payload_offset)->value, size, arg))
> >>>>>> -                          augmented =3D true;
> >>>>>> -          } else if ((int)size < 0 && size >=3D -6) { /* buffer *=
/
> >>>>>> -                  index =3D -(size + 1);
> >>>>>> -                  barrier_var(index); // Prevent clang (noticed w=
ith v18) from removing the &=3D 7 trick.
> >>>>>> -                  index &=3D 7;         // Satisfy the bounds che=
cking with the verifier in some kernels.
> >>>>>> -                  aug_size =3D args->args[index] > TRACE_AUG_MAX_=
BUF ? TRACE_AUG_MAX_BUF : args->args[index];
> >>>>>> -
> >>>>>> -                  if (aug_size > 0) {
> >>>>>> -                          if (!bpf_probe_read_user(((struct augme=
nted_arg *)payload_offset)->value, aug_size, arg))
> >>>>>> -                                  augmented =3D true;
> >>>>>> -                  }
> >>>>>> -          }
> >>>>>> -
> >>>>>> -          /* Augmented data size is limited to sizeof(augmented_a=
rg->unnamed union with value field) */
> >>>>>> -          if (aug_size > value_size)
> >>>>>> -                  aug_size =3D value_size;
> >>>>>> -
> >>>>>> -          /* write data to payload */
> >>>>>> -          if (augmented) {
> >>>>>> -                  int written =3D offsetof(struct augmented_arg, =
value) + aug_size;
> >>>>>> -
> >>>>>> -                  if (written < 0 || written > sizeof(struct augm=
ented_arg))
> >>>>>> -                          return 1;
> >>>>>> -
> >>>>>> -                  ((struct augmented_arg *)payload_offset)->size =
=3D aug_size;
> >>>>>> -                  output +=3D written;
> >>>>>> -                  payload_offset +=3D written;
> >>>>>> -                  do_output =3D true;
> >>>>>> -          }
> >>>>>> -  }
> >>>>>> +  struct args_loop_ctx loop_ctx =3D {
> >>>>>> +          .args =3D args,
> >>>>>> +          .beauty_map =3D beauty_map,
> >>>>>> +          .payload_offset =3D payload_offset,
> >>>>>> +          .value_size =3D value_size,
> >>>>>> +          .output =3D &output,
> >>>>>> +          .do_output =3D &do_output
> >>>>>> +  };
> >>>>>> +  iters =3D bpf_loop(6, process_arg_cb, &loop_ctx, 0);
> >>>>>
> >>>>> bpf_loop() is old and generally not recommended.
> >>>>> Please use bpf_for() then the diff will be one line change and
> >>>>> can scale to any number of args. Not just 6.
> >>>
> >>> Thanks Alexei, I didn't know about this preference.
> >>>
> >>>> One thing we should take care is to support old kernels.  The oldest
> >>>> LTS kernel in the kernel.org is 5.10 and bpf_loop() was introduced i=
n
> >>>> 5.17 and bpf_for (bpf_iter_num) was 6.4.
> >>>
> >>> The problematic loop was introduced in 6.12 by a68fd6a6cdd3 ("perf
> >>> trace: Collect augmented data using BPF") so we should be good using
> >>> bpf_for. Or is perf from 7.2 supposed to work on 5.10 LTS kernels?
> >>>
> >>> I'll refactor with bpf_for and will send v2.
> >>
> >> Or I won't. It turns out that just swapping the for loop for bpf_for
> >> leads to -E2BIG from the verifier again. Looking at the verifier log, =
it
> >> fails to find equivalence between states at the loop head:
> >>
> >>     [...]
> >>     78: (85) call bpf_iter_num_next#84922 [...]
> >> fp-56=3Dmap_value(map=3Dbeauty_payload_,ks=3D4,vs=3D24688,imm=3D112)
> >>     [...]
> >>     78: (85) call bpf_iter_num_next#84922 [...]
> >> fp-56=3Dmap_value(map=3Dbeauty_payload_,ks=3D4,vs=3D24688,imm=3D120)
> >>     [...]
> >>
> >> IMHO, the reason is that payload_offset, which points to the
> >> beauty_payload_enter_map entry, gets updated in every iteration.
> >>
> >> This could be probably fixed on the perf side by reworking how augment=
ed
> >> args are stored but at this point, bpf_loop sounds like an easier and
> >> more reliable approach.
> >>
> >> Let me know if anyone has objections, otherwise I'll send v2 of the
> >> bpf_loop approach, with suggestions from Sashiko incorporated.
> >>
> >
> > I'd still try to adapt bpf_for(), it's a much better code structure.
> > You probably need to add a bounding checking/confirming `if ()`
> > condition validating that offset at which you access map_value is
> > always correct. And/or you might need barrier_var() before using i,
> > because bpf_for() macro does bounds checking (check the macro itself),
> > but compiler often will reorder instructions leading to verifier
> > complaints.
>
> I gave it a try but wasn't successful so far. I think that the problem
> is that while it would be possible to add an upper bound condition for
> `payload_offset`, the verifier tracks the value of `payload_offset` too
> precisely (as map_value(..., imm=3DX) with a concrete offset) and never
> merges states with different offsets. And since there are multiple
> branches inside the loop, each incrementing `payload_offset` by a
> different value, the verifier seems to fork its state on each branch,
> effectively leading to the amount of states growing exponentially and
> hitting the jump limit.
>
> To me, bpf_loop sounds like a more reliable choice in this situation.

correctly verified bpf_loop would basically have to follow the same
logic, so if it works with bpf_loop, it should work with bpf_for. Is
it possible to share your bpf_for-based code in some branch to try
locally? I'm sure it can be done one way or another.

> It's also older, which is good in this case, since compatibility with
> older kernels seems to be important for perf (see other messages in the
> thread).
>
> I'm also wondering if the verifier could be improved to handle these
> cases but that's a different discussion.
>
> >
> >> Thanks,
> >> Viktor
> >>
> >>> It should be then
> >>> backported to stable kernels down to 6.12 LTS.
> >>>
> >>> Viktor
> >>>
> >>>>
> >>>> Maybe we can factor out the loop body and call it from different
> >>>> mechanisms like open-coded loop, bpf_loop or bpf_for depending on th=
e
> >>>> kernel version.  But not sure it'd fix the verifier issue though.
> >>>>
> >>>> Thanks,
> >>>> Namhyung
> >>>>
> >>
> >>
> >
>
