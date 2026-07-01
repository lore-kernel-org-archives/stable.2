Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BAF494A0E
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 18:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782929178; cv=pass; b=OqaeBoRlKDG0wG3BXlv2kmA3OhYCWLHP0Rv+M5Mz0ycA00hK5yjGPW3eaIGtHxEpdXJ11oIXZTHNQd4Sz38rOo/VAeNkGnuFlfoT2DTY+6dyif0z/JrB3t6IAcj5II7CvLv8A9EDMeDlEzqf49cLy4RXV5TL3wtBA0APFd97uqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782929178; c=relaxed/simple;
	bh=kPiqNE7xlfNV+ivs9rELOKqBb5P6MZfIfrGYF6zIOhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YMGO8leVQQPEWOD65zdZrgJw5oVuwVFI2uTWkOSnNOGvLNgy3AkwCqV8Jrbf18iUBzlZq4GEq8qoS1DKQvQ1nyE2wumQqmmabFfZgF3sNyd+eeIfvVAR61ftvKS+ecmcIxYp+tNP8OrCFR6KPBRZJM7CfD2Oi6chGm4DpHu8ztY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHGDoW01; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHGDoW01"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c9f10fa7a3so8766945ad.0
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 11:06:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782929175; cv=none;
        d=google.com; s=arc-20260327;
        b=T2QAf4Uhz+RoHLQhhK6Y7VwMcEsObEO9+QouZR22ewcLnpKh/9hkv27dwDILQ1c/lz
         J4Q65X2np1rGUQx7EZwNbis8osW7uSSBhO97UQCZdtjk2mIWsIaJkLDXEenZoeoQ79ME
         x5tkzF83z/+7NTy7fe/7bcFcXyGnOAyohC/af/xOsCQJlGVPBaw40dx1mHrkzNWGKiTH
         owUA5kjsKWBvPFqv/vNMhUtgjDoFtxzKmGMXdiy2Vl9Vdp/lXcpCAFuWgIiF08HRephO
         86r4ZUpr+yTU+TS1mmwtl3Zfk6uXYFvOSiGTtlEs6N46EtJ9FPFQ3zzmCY/aHjUd7w/i
         SpOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Scba/x/dCfB9JJzbY7WApPv7XEyMR8UN1JS/S3YUF78=;
        fh=ytZSfiKm9egGHHqXP/NlcCusu5fekKI6LDKYwPHRwRo=;
        b=LT49X97fp3l/lV50vrmhW85BhAyTrE/8ofTQEVgCImf8OfhHDw+OZ8zem8dctTTYHw
         Ta4LfDxeKw0URxDtc7PCCt09bncrXCfZvUCdSkI+k4L1eGjNH/rrso0+Ll/jIhVqwqX0
         ye+vj8WhkeISeXbkqgm42l8qJ0Zhpcbe4/LCThHEg4QRlxomdi23mz0SdNcdHdT1MfGu
         KM1/anaz2eHLwAUFq7Iv4ksvJGqccjmpqLI2rblai65HxaoimnReWoTg2Df9jfKNlzgI
         TiL+Nb6fnuldp8wv+ian6GPzvjlwSi1h1pe0tzOOl+mSYhJDCce6KDxrsAaxD1qEySFX
         /zVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782929175; x=1783533975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Scba/x/dCfB9JJzbY7WApPv7XEyMR8UN1JS/S3YUF78=;
        b=aHGDoW01Ug2bpSWuC3y1ZKZ4bt4VEeZvnikaXpwnM0fD3GCMJPPQ4b2yZOh+24VMdH
         CPXdCHcc8gkb+p8Lj03Dlg8qSSR++BeY/h0ihHZaiko5W+MTulL4AD8PJy/8QKuvzOoA
         CAAabCNXBzogxbc7MhwqT2/ZegN8uhgge+HpvOBTA5OUegzRySqC4tbuusapQvcH4LJl
         od7SEPGjRdNhAruuzwsee26EhK+0mJYbcphMS4EpxugiZiEav+Hk1uNliperLAGfHs2H
         dQiSa8Y+Mie/VBo8JSFYdIaa1axee5vxV6ZrCe4+5gH0f10SXkEn0sD/cAaTM2QxQ/Nk
         Bw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782929175; x=1783533975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Scba/x/dCfB9JJzbY7WApPv7XEyMR8UN1JS/S3YUF78=;
        b=iFJ5r4a5xRpaXiKXymNAEHcgbcfSX5itlKFdPlH0nUp1o8eVvKcR7O4ZccibKuzJl/
         Zxh99WUFU34zz+3fBdhvkvxNXCfZZ2pVCEp0udRy7bRlqGSpXNAF27zP0Bq+d7q6u67q
         piJUtKuAfL0r0hSdeCk8TvW0LJ+uoeU/8XOgB+hrhPhF1Vg3IycoiIdCTVb1sfwc+E5D
         JNhgLTb0UGhyIl9Rda4cWVX7XfKGGxCFiBetQlBDf19IikQFkhCf+Fx1EYLLcFzwSzfu
         U26pUKcR2M/ksAjj/yDfKcc6KQY/Ei1cGylDJAM9hiXNxaxAZXoT/PtmGsN9aYP5choM
         NI9w==
X-Forwarded-Encrypted: i=1; AHgh+RrOl3Zvf+lrQhkm/QxTo7cT2uodQvqX18ZG/emZqAaB7RZhsce0rb+Prcv3PagqTifxg/gv5Uc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Ab/eRrO7q2aesCJuucibTTXDg06yGvHwksaO0nGf1Uv9/jBK
	nKf0n6y3YIL3rofh5wLUZV9KObe2Tv6hGrcJ5bzQXDVPVhA4hOHjvFtz8RWtLlUaW3aok+YKmsU
	LWCf1HJDaBpKeKcDHWG+71IWAm/O0x9c=
X-Gm-Gg: AfdE7ck8L8OjW3sq1quOfKVK2MbuloAd9oGrXay6N/mLHUmn64lUINXS4B/12OM5uXc
	HSflxlcc6pwloyzuSaEbBpQl7sBDIwcGi4aJGBaW978Ax/ZpS4zIbz20OiOHC9RonOpleNZqn2l
	PJlNrfGXkDF6L3t1hadgbuxIAzp5IDbbTOjGKYkIW46Spyw5z9Hv5mJ0NG+xhg+eaI9MVJrKQD8
	2PC2WPHKfG474SNiH3UZfRxlFctRvAXj5BvPF++PM79JWHR+DLNFgAH2XR6Ltmr6AiT91h1wfjz
	uS6F5URBP9I16aHNCIMGaVebu0ZPxd5XhDZ5TOh/VAuqVA0nrANb8nl8nGNYbgZu
X-Received: by 2002:a17:902:d50a:b0:2c9:dc38:3ed7 with SMTP id
 d9443c01a7336-2ca7e882266mr28117815ad.36.1782929175268; Wed, 01 Jul 2026
 11:06:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623112533.1151502-1-vmalik@redhat.com> <DJGJ9F6WQZV9.2W4WBIHYLJQ97@gmail.com>
 <ajq98dm4gAwEzkMb@google.com> <c2f4e45e-d5c9-42e9-a46b-25fb0cacb267@redhat.com>
 <93e70dc7-e52f-444e-b57e-09d149dc4808@redhat.com> <CAEf4BzYWdsBDQ3D41=+n_oCO68bVOtKuqQCqZOEVo=j7nK9Ozg@mail.gmail.com>
 <82252ae0-133a-45dc-9622-315236a437ad@redhat.com> <CAEf4Bza8vFSkuiD_Vd47-eGuDS40kKvTcHQR=V3OY=c505a9=g@mail.gmail.com>
 <4f43e9aa-2444-407b-ae52-0f4bf889ec17@redhat.com>
In-Reply-To: <4f43e9aa-2444-407b-ae52-0f4bf889ec17@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 1 Jul 2026 11:06:03 -0700
X-Gm-Features: AVVi8CdJLWsVd93IAAyHqimLkNG-LKWJDclAXvnosyzScFpuqT5IgLm4V0nYlJo
Message-ID: <CAEf4Bzb4niXoqLDWvD211M9eJ+Wo5KT2ezVYtTVABVOGOLe=Ug@mail.gmail.com>
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

On Thu, Jun 25, 2026 at 11:04=E2=80=AFPM Viktor Malik <vmalik@redhat.com> w=
rote:
>
> On 6/25/26 19:55, Andrii Nakryiko wrote:
> > On Thu, Jun 25, 2026 at 4:58=E2=80=AFAM Viktor Malik <vmalik@redhat.com=
> wrote:
> >>
> >> On 6/24/26 19:19, Andrii Nakryiko wrote:
> >>> On Wed, Jun 24, 2026 at 3:27=E2=80=AFAM Viktor Malik <vmalik@redhat.c=
om> wrote:
> >>>>
> >>>> On 6/24/26 08:47, Viktor Malik wrote:
> >>>>> On 6/23/26 19:10, Namhyung Kim wrote:
> >>>>>> Hello,
> >>>>>>
> >>>>>> On Tue, Jun 23, 2026 at 08:27:39AM -0700, Alexei Starovoitov wrote=
:
> >>>>>>> On Tue Jun 23, 2026 at 4:25 AM PDT, Viktor Malik wrote:
> >>>>>>>> The loop for processing syscall args in augment_raw_syscalls has=
 a
> >>>>>>>> history of breaking with Clang updates, see e.g. commit 013eb043=
f37b
> >>>>>>>> ("perf trace: Fix BPF loading failure (-E2BIG)") from Clang 15 t=
o 16.
> >>>>>>>>
> >>>>>>>> Now, a similar thing happened between Clang 21 and 22. While the=
 issue
> >>>>>>>> is mitigated on the main line by a recent verifier update, it re=
mains
> >>>>>>>> broken on the 6.12 and 6.18 stable branches:
> >>>>>>>>
> >>>>>>>>     [linux-6.18.y]# sudo perf trace true
> >>>>>>>>     libbpf: prog 'sys_enter': BPF program load failed: -E2BIG
> >>>>>>>>     libbpf: prog 'sys_enter': -- BEGIN PROG LOAD LOG --
> >>>>>>>>     [...]
> >>>>>>>>     BPF program is too large. Processed 1000001 insn
> >>>>>>>>     processed 1000001 insns (limit 1000000) max_states_per_insn =
40 total_states 37941 peak_states 232 mark_read 0
> >>>>>>>>     -- END PROG LOAD LOG --
> >>>>>>>>     libbpf: prog 'sys_enter': failed to load: -E2BIG
> >>>>>>>>     libbpf: failed to load object 'augmented_raw_syscalls_bpf'
> >>>>>>>>     libbpf: failed to load BPF skeleton 'augmented_raw_syscalls_=
bpf': -E2BIG
> >>>>>>>>     Error: failed to get syscall or beauty map fd
> >>>>>>>>     [...]
> >>>>>>>>
> >>>>>>>> The reason is that the loop is quite complex and the BPF verifie=
r often
> >>>>>>>> struggles to prove that it terminates.
> >>>>>>>>
> >>>>>>>> Fix the issue by refactoring the loop body into a callback funct=
ion and
> >>>>>>>> calling the bpf_loop helper. This should prevent future breakage=
s of
> >>>>>>>> this kind since the callback function has no loops. It also allo=
ws to
> >>>>>>>> drop a few artificial checks to help the verifier, including the=
 changes
> >>>>>>>> introduced by 013eb043f37b.
> >>>>>>
> >>>>>> Thanks for working on this.  I encountered this issue before and n=
ever
> >>>>>> found time to take a deeper look yet.
> >>>>>>
> >>>>>>>>
> >>>>>>>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> >>>>>>>> Fixes: a68fd6a6cdd3 ("perf trace: Collect augmented data using B=
PF")
> >>>>>>>> Fixes: 013eb043f37b ("perf trace: Fix BPF loading failure (-E2BI=
G)")
> >>>>>>>> Cc: stable@vger.kernel.org
> >>>>>>>> ---
> >>>>>>>>  .../bpf_skel/augmented_raw_syscalls.bpf.c     | 157 +++++++++++=
-------
> >>>>>>>>  1 file changed, 96 insertions(+), 61 deletions(-)

[...]

> >>>>>>>> +  struct args_loop_ctx loop_ctx =3D {
> >>>>>>>> +          .args =3D args,
> >>>>>>>> +          .beauty_map =3D beauty_map,
> >>>>>>>> +          .payload_offset =3D payload_offset,
> >>>>>>>> +          .value_size =3D value_size,
> >>>>>>>> +          .output =3D &output,
> >>>>>>>> +          .do_output =3D &do_output
> >>>>>>>> +  };
> >>>>>>>> +  iters =3D bpf_loop(6, process_arg_cb, &loop_ctx, 0);
> >>>>>>>
> >>>>>>> bpf_loop() is old and generally not recommended.
> >>>>>>> Please use bpf_for() then the diff will be one line change and
> >>>>>>> can scale to any number of args. Not just 6.
> >>>>>
> >>>>> Thanks Alexei, I didn't know about this preference.
> >>>>>
> >>>>>> One thing we should take care is to support old kernels.  The olde=
st
> >>>>>> LTS kernel in the kernel.org is 5.10 and bpf_loop() was introduced=
 in
> >>>>>> 5.17 and bpf_for (bpf_iter_num) was 6.4.
> >>>>>
> >>>>> The problematic loop was introduced in 6.12 by a68fd6a6cdd3 ("perf
> >>>>> trace: Collect augmented data using BPF") so we should be good usin=
g
> >>>>> bpf_for. Or is perf from 7.2 supposed to work on 5.10 LTS kernels?
> >>>>>
> >>>>> I'll refactor with bpf_for and will send v2.
> >>>>
> >>>> Or I won't. It turns out that just swapping the for loop for bpf_for
> >>>> leads to -E2BIG from the verifier again. Looking at the verifier log=
, it
> >>>> fails to find equivalence between states at the loop head:
> >>>>
> >>>>     [...]
> >>>>     78: (85) call bpf_iter_num_next#84922 [...]
> >>>> fp-56=3Dmap_value(map=3Dbeauty_payload_,ks=3D4,vs=3D24688,imm=3D112)
> >>>>     [...]
> >>>>     78: (85) call bpf_iter_num_next#84922 [...]
> >>>> fp-56=3Dmap_value(map=3Dbeauty_payload_,ks=3D4,vs=3D24688,imm=3D120)
> >>>>     [...]
> >>>>
> >>>> IMHO, the reason is that payload_offset, which points to the
> >>>> beauty_payload_enter_map entry, gets updated in every iteration.
> >>>>
> >>>> This could be probably fixed on the perf side by reworking how augme=
nted
> >>>> args are stored but at this point, bpf_loop sounds like an easier an=
d
> >>>> more reliable approach.
> >>>>
> >>>> Let me know if anyone has objections, otherwise I'll send v2 of the
> >>>> bpf_loop approach, with suggestions from Sashiko incorporated.
> >>>>
> >>>
> >>> I'd still try to adapt bpf_for(), it's a much better code structure.
> >>> You probably need to add a bounding checking/confirming `if ()`
> >>> condition validating that offset at which you access map_value is
> >>> always correct. And/or you might need barrier_var() before using i,
> >>> because bpf_for() macro does bounds checking (check the macro itself)=
,
> >>> but compiler often will reorder instructions leading to verifier
> >>> complaints.
> >>
> >> I gave it a try but wasn't successful so far. I think that the problem
> >> is that while it would be possible to add an upper bound condition for
> >> `payload_offset`, the verifier tracks the value of `payload_offset` to=
o
> >> precisely (as map_value(..., imm=3DX) with a concrete offset) and neve=
r
> >> merges states with different offsets. And since there are multiple
> >> branches inside the loop, each incrementing `payload_offset` by a
> >> different value, the verifier seems to fork its state on each branch,
> >> effectively leading to the amount of states growing exponentially and
> >> hitting the jump limit.
> >>
> >> To me, bpf_loop sounds like a more reliable choice in this situation.
> >
> > correctly verified bpf_loop would basically have to follow the same
> > logic, so if it works with bpf_loop, it should work with bpf_for.
>
> Are you sure about that? My perception is that the bpf_loop callback is
> only verified once in a single pass. On the contrary, bpf_for is a
> normal loop, for which the verifier needs to prove that after some
> iteration, we get to the state seen in a previous iteration (to prune
> the state). Which never happens here because the offset to
> beauty_payload_enter_map (the payload_offset var) is tracked precisely
> and causes state forks on every condition inside the loop.

Hey Viktor,

Sorry for taking so long to get back.

Answering your question about bpf_loop() vs bpf_for() they are
conceptually the same from verifier POV, so they are verified
similarly. Earlier (buggier) versions of verifier did have a loophole
where we verifier bpf_loop() in more laxed single-shot way, but that's
not correct. We have since fixed that and it (bpf_loop) now has to
"prove" convergence just like bpf_for().

Anyways, the biggest issue with "normal" unrolled BPF loop is that
people tend to write it such that there is some carry-over state
between each iteration (like output variable which tracks advancing
but bounded offset) which, with fixed number of iterations allows
verifier to prove everything is bounded.

This model is really-really bad for bpf_for() because it doesn't allow
convergence. The trick is to structure each iteration as independent
piece of calculation where the state outside of bpf_for() loop stays
as unspecific/imprecise as possible, which at the beginning of the
loop you revalidate invariants, if necessary (e.g., reestablish
map_value offset boundaries).

Anyways, it needed a bit of persuasion, but here's the verification
result and gmail-butchered diff below. The trick is in making output
imprecise (force verifier to forget its tracked range), so it doesn't
differ between iterations from verifier POV. That's what the global
ZERO allows to do. (We've discussed w/ Alexei and Eduard adding
special instruction to force scalar register into imprecise, it would
be a cleaner solution here, alas we never got anywhere with this,
unfortunately).

Processing 'augmented_raw_syscalls.bpf.o'...
PROCESSING ./util/bpf_skel/.tmp/augmented_raw_syscalls.bpf.o/sys_enter,
DURATION US: 1129, VERDICT: success, VERIFIER LOG:
verification time 1129 usec
stack depth 64
processed 547 insns (limit 1000000) max_states_per_insn 4 total_states
38 peak_states 67 mark_read 0

File                          Program    Verdict  Duration (us)  Insns
 States  Program size  Jited size
----------------------------  ---------  -------  -------------  -----
 ------  ------------  ----------
augmented_raw_syscalls.bpf.o  sys_enter  success           1129    547
     38           172         917
----------------------------  ---------  -------  -------------  -----
 ------  ------------  ----------

The diff:

diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index 2a6e61864ee0..8436368ba203 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -429,15 +429,17 @@ static bool pid_filter__has(struct pids_filtered
*pids, pid_t pid)
        return bpf_map_lookup_elem(pids, &pid) !=3D NULL;
 }

+u64 ZERO =3D 0;
+
 static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
 {
        bool augmented, do_output =3D false;
-       int zero =3D 0, index, value_size =3D sizeof(struct augmented_arg)
- offsetof(struct augmented_arg, value);
+       int i, zero =3D 0, index, value_size =3D sizeof(struct
augmented_arg) - offsetof(struct augmented_arg, value);
        u64 output =3D 0; /* has to be u64, otherwise it won't pass the
verifier */
        s64 aug_size, size;
        unsigned int nr, *beauty_map;
        struct beauty_payload_enter *payload;
-       void *arg, *payload_offset;
+       void *arg;

        /* fall back to do predefined tail call */
        if (args =3D=3D NULL)
@@ -449,7 +451,6 @@ static int augment_sys_enter(void *ctx, struct
syscall_enter_args *args)

        /* set up payload for output */
        payload        =3D bpf_map_lookup_elem(&beauty_payload_enter_map, &=
zero);
-       payload_offset =3D (void *)&payload->aug_args;

        if (beauty_map =3D=3D NULL || payload =3D=3D NULL)
                return 1;
@@ -466,7 +467,7 @@ static int augment_sys_enter(void *ctx, struct
syscall_enter_args *args)
         * struct: size of struct             -> size of struct
         * buffer: -1 * (index of paired len) -> value of paired len
(maximum: TRACE_AUG_MAX_BUF)
         */
-       for (int i =3D 0; i < 6; i++) {
+       bpf_for(i, 0, 6) {
                arg =3D (void *)args->args[i];
                augmented =3D false;
                size =3D beauty_map[i];
@@ -475,6 +476,11 @@ static int augment_sys_enter(void *ctx, struct
syscall_enter_args *args)
                if (size =3D=3D 0 || arg =3D=3D NULL)
                        continue;

+               if (output > sizeof(payload->aug_args) -
sizeof(payload->aug_args[0]))
+                       break; /* can't/shouldn't happen */
+               barrier_var(output);
+               void *payload_offset =3D (void *)&payload->aug_args + outpu=
t;
+
                if (size =3D=3D 1) { /* string */
                        aug_size =3D bpf_probe_read_user_str(((struct
augmented_arg *)payload_offset)->value, value_size, arg);
                        /* minimum of 0 to pass the verifier */
@@ -510,7 +516,7 @@ static int augment_sys_enter(void *ctx, struct
syscall_enter_args *args)

                        ((struct augmented_arg *)payload_offset)->size
=3D aug_size;
                        output +=3D written;
-                       payload_offset +=3D written;
+                       output +=3D ZERO; /* forget range */
                        do_output =3D true;
                }
        }


>
> > Is
> > it possible to share your bpf_for-based code in some branch to try
> > locally? I'm sure it can be done one way or another.
>
> The change is super-simple, I can as well share it here. It's just the
> matter of using bpf_for with two additional suggested mechanisms,
> barrier_var and a bounds check for payload_offset:
>
> diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tool=
s/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> index 2a6e61864ee0..341d77a78949 100644
> --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> @@ -432,7 +432,7 @@ static bool pid_filter__has(struct pids_filtered *pid=
s, pid_t pid)
>  static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
>  {
>         bool augmented, do_output =3D false;
> -       int zero =3D 0, index, value_size =3D sizeof(struct augmented_arg=
) - offsetof(struct augmented_arg, value);
> +       int zero =3D 0, i, index, value_size =3D sizeof(struct augmented_=
arg) - offsetof(struct augmented_arg, value);
>         u64 output =3D 0; /* has to be u64, otherwise it won't pass the v=
erifier */
>         s64 aug_size, size;
>         unsigned int nr, *beauty_map;
> @@ -466,12 +466,16 @@ static int augment_sys_enter(void *ctx, struct sysc=
all_enter_args *args)
>          * struct: size of struct             -> size of struct
>          * buffer: -1 * (index of paired len) -> value of paired len (max=
imum: TRACE_AUG_MAX_BUF)
>          */
> -       for (int i =3D 0; i < 6; i++) {
> +       bpf_for(i, 0, 6) {
> +               barrier_var(i);
>                 arg =3D (void *)args->args[i];
>                 augmented =3D false;
>                 size =3D beauty_map[i];
>                 aug_size =3D size; /* size of the augmented data read fro=
m user space */
>
> +               if (payload_offset + sizeof(struct augmented_arg) > (void=
 *)payload + sizeof(struct beauty_payload_enter))
> +                       break;
> +
>                 if (size =3D=3D 0 || arg =3D=3D NULL)
>                         continue;
>
>
> Thanks a lot for the help!
> Viktor
>
