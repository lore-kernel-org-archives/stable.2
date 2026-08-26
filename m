Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419FF353A9B
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 08:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787732757; cv=none; b=IGs8r6O8lD086YlRJk8QK91botXUHaaIYJouIUdtJaY3ZhoDEkWAZGGSVIt1o8olq4wXFwDJIByIjPPGuTHYrFrPLDP6Fe7RkmMuaerpeh8Oe9qI9xnhMzNfWJ3H5MKgz4RmyLpoGoCDwT48SQq6RfSQJJ97oKSxIuBr7uD/eq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787732757; c=relaxed/simple;
	bh=CUxQmTlZDyOSh9oqX7Gh3XkFj/6k2jnddqT0l60tsg0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YXaQesnWZ3fkNZib213rG2CEOVREFzIj1PFfXsUuBNiiF/Cj7uUGiX/7FGu2q4BbfDdkcT9o91ZN0XplSJ7yuUGK10JvqeOL3pN7tGqSn/EmXBbV/T312usFBqhlueENhY85CdyUy1JBoaDdQBFSES5qsO8A8L1NnX90R3Nsmls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sc84jrm8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dNCrcyBG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sc84jrm8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dNCrcyBG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787732754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kQLJj8ETQUQJUTHuNV0g4sHW8GntgKUbmfEJsFHCLyg=;
	b=Sc84jrm8c5rAm6N+sef6NBK6jH0oDXB0NTKqPTxjR6pNa1on342VTHClKRPrutMVpvO8xh
	8SLAHJMYl/FxDRUxBtPlSgSyaK9F6k2PmV/NGjKx09EA6W5iTw9ZiVY4y0hy5C4N6Dfb8S
	JTihgnjtBLWnMMyaheEBQs6Uvr68sCc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-C6Yn07DjPFeI2cWFyKQljg-1; Wed, 26 Aug 2026 04:25:52 -0400
X-MC-Unique: C6Yn07DjPFeI2cWFyKQljg-1
X-Mimecast-MFC-AGG-ID: C6Yn07DjPFeI2cWFyKQljg_1787732751
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c20e5890680so61080766b.1
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 01:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787732751; x=1788337551; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kQLJj8ETQUQJUTHuNV0g4sHW8GntgKUbmfEJsFHCLyg=;
        b=dNCrcyBG+pfUxKx+8uhRN7IT5hUgmIa+asQBo5j4Jl8EqQlOqp7Y+wbI3/yFoCmfAP
         gvPIc1fwN/p+xtLIZRmrBs5olglJz82kF87kHUQjJrPfFeFlFNSh+j5vuteFGU6gi7Jo
         mVcvunfKr9Fg5na6tXL4gFNBcHy+1Y2H9m/j4xKY3KkMP40N9M81hORmJ/TVyV4QedTy
         bGCg9aBpMr42iRMPh9gDTvvT3mzvVhJab1ylKalAAm/oQCCmihD7B5pRPIY9ebL3pXpq
         ru12mPMnQr9WO00O0tUtcYcj7+X6ohyM5I5pIGsyc6kOmLiDVtpVc8pjdRKtiIk7msZz
         xOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787732751; x=1788337551;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kQLJj8ETQUQJUTHuNV0g4sHW8GntgKUbmfEJsFHCLyg=;
        b=M1FUL4v91ZpCbHWZoq5BnN/Fcc0e3BmnkbZHlg8JosRP7sDceHw4z4VkfOdzmod1cm
         HJR5kRWBdgXdHAlNJ5vnB9K7kr1O9xuyVH+/2VeJiFWvzt5iOQdHQBcXP3RUcXsyPk7o
         +sCtxYvdafHy0DkR0lX/oaVUJ/UPQmbgNlsUb8uKTBp++wnkNttUtv8Qn+IEicYzYsj4
         2zy5q6z7RGZErd8QdPNZLp7tFbJBh6RThwIuEDEqXrbNnXG/5aIqRUGnlXhsdQDkFuzM
         7g+9PLou65NhGg8mL48AmbhjKF98NCdVvKL4Qrm+VMvh4HsBFaQnClPvp4jc4ffw8nQk
         dSZA==
X-Forwarded-Encrypted: i=1; AHgh+RqdePLRnWjELEYSJi32cxgj8DQfThzdRpWkBw++TMGXMy6NJXLZcwIuKEmD1BFX4CVchUNosP4=@vger.kernel.org
X-Gm-Message-State: AFuF++njboiaM4a/SCylyKpON8UwpqriHAALsMXBAfWl5+Pl7S3I5aGM
	aZohMDRioKokLuse6vTrPRl80NL32Pr0dSfLMZYU4q/dzaRbMgB23p5HOL9i1dP2c52qJt/RwKW
	O7UjRvEtkVtAOq4X6pe51bF5VS+CJqDpaJUW023FIy04rFlILkXDsDT71GA==
X-Gm-Gg: AR+sD113ojsa8NUmaXJnb3NeDq+zWa9AjqgJ1c05XV1T3ilSjDjnTNvCNcvgX2NjmN5
	OkE0LAfHbsQLkM9uV7ukQEBdfSk3SKILsKsqVNUWFrV1p6QuXHjdwt7euBzVxduJlaHfIbIXTXw
	YxhOcJjfS+Nns67o8by5bv456vfFtAAHXS5DNecnkwmdykSZ+4ekIw3HHhL3Db1nuQxG6TF45vO
	xMx/Qz6Ra+x9aricS6pB6KZlwGDac7fnzVYxNDjxsta6YAL81W7y4uUVVhAtscgHhFxq/7EbUfL
	VHIjLYNzdFBk3+3xaEyClDh9u/DEmXMVyPwEu/YNrDqA+6IqTMAChozpeuF7j4ZzzvQX8j2sfS+
	8eBC0QESTEmnwm8VCiRU1bBUQ
X-Received: by 2002:a17:907:3ea8:b0:c24:6445:d19 with SMTP id a640c23a62f3a-c250c32b5e2mr605030866b.17.1787732751130;
        Wed, 26 Aug 2026 01:25:51 -0700 (PDT)
X-Received: by 2002:a17:907:3ea8:b0:c24:6445:d19 with SMTP id a640c23a62f3a-c250c32b5e2mr605021266b.17.1787732750603;
        Wed, 26 Aug 2026 01:25:50 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a6fcdd5sm405194166b.20.2026.08.26.01.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 01:25:49 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id C48FA979BE9; Wed, 26 Aug 2026 10:25:48 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Victor Nogueira
 <victor@mojatatu.com>, vtahiliani@nitk.edu.in,
 chia-yu.chang@nokia-bell-labs.com, subramanian.vijay@gmail.com,
 vega@nebusec.ai, stable@vger.kernel.org
Subject: Re: [PATCH net] net/sched: clamp quantum and psched_mtu in change
 paths and missed siblings
In-Reply-To: <20260826074056.7873-1-jhs@mojatatu.com>
References: <20260826074056.7873-1-jhs@mojatatu.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 26 Aug 2026 10:25:48 +0200
Message-ID: <87qzjl47ar.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jamal Hadi Salim <jhs@mojatatu.com> writes:

> This is a followup to commit 709f34f7c28d ("net/sched: fq: add
> overflow bounds to quantum and initial quantum").
> The quantum_backlog_overflow series and the five siblings that followed
> clamped the init-path quantum to in fq, fq_codel, fq_pie, hhf, sfq.
> The change() paths with the same pattern, same writer of q->quantum,
> same privilege level (CAP_NET_ADMIN in a user namespace) were not clamped.
> A user can override the init clamp via tc qdisc change, restoring the
> small-quantum deficit spin that the init clamp was meant to prevent.
>
> This follow-up also covers two siblings that were missed entirely by
> the original series: sch_dualpi2 and sch_pie call psched_mtu() without
> any clamp at all. With a crafted size table qdisc_pkt_len reaches ~2
> GiB, so quantum=3D1 (or a zero psched_mtu on a headerless device) makes
> the deficit-refill loop spin ~2^31 times under the qdisc lock (a soft
> lockup / denial of service).
>
> Fixes based on review of 709f34f7c28d:
>
> 1. fq_pie_change() accepts quantum=3D1 (NLA policy fq_pie_q_range.min=3D1=
).
>    Add max(256U, ...) matching fq_codel_change()
>    (Sashiko nipa gpt-5-6-sol-3-8 and gpt-5-6-sol-6-7)
>
> 2. sfq_change() accepts any non-negative quantum (only rejects
>    (int)ctl->quantum < 0). Add max(256U, ...) matching fq_codel_change().
>    Reject quantum > 1<<20 with -EINVAL, matching fq_codel_change() and
>    the init clamp.
>    (Internal review noticing same pattern)
>
> 3. hhf_change() accepts quantum=3D1 (only checks non_hh_quantum product).
>    Add max(256U, ...) matching fq_codel_change()
>    (Sashiko nipa v1 review + vega@nebusec.ai independent bug)
>
> 4. fq_change() accepts TCA_FQ_INITIAL_QUANTUM up to INT_MAX (iq_range.max
>    =3D INT_MAX) while fq_init() now clamps to 1<<20.  Narrow iq_range.max
>    to 1<<20, rejecting at parse time.  (Eric Dumazet)
>
> 5. sch_dualpi2: dualpi2_calculate_c_protection() and get_memory_limit()
>    call psched_mtu() with no clamp. A huge MTU makes (s32)psched_mtu()
>    overflow in the signed multiply for c_protection_init, and 2 *
>    psched_mtu() wraps in get_memory_limit(). Clamp to [1, 1<<20] at
>    all three call sites. (Sashiko nipa main-6-4)
>
> 6. sch_pie: pie_drop_early() calls psched_mtu() with no clamp.  With
>    mtu=3D0x80000000 the bytemode divide silently zeroes the drop
>    probability, disabling AQM. Clamp to [1, 1<<20] (Sashiko gemini)
>
> 7. sch_drr: drr_change_class() rejects explicit quantum=3D=3D0 but falls
>    back to psched_mtu() with no floor. Add max(256U, ...) after the
>    zero reject and on the fallback path
>   (vega@nebusec.ai independent bug)
>
> 8. sch_ets: ets_qdisc_change() falls back to psched_mtu() with no floor
>    for bands without an explicit quantum.  Add max(256U, ...) on the
>    fallback path (vega@nebusec.ai independent bug)
>
> The init paths of fq_pie, sfq, and hhf delegate to their _change() when
> opt is present, so the floor covers tc qdisc add ... quantum 1 as well
> as change. The zero-quantum-from-psched_mtu case on a headerless device
> (mtu=3D=3D0) is also covered by the 256 floor in drr and ets; the
> explicit-zero reject in drr_change_class() is preserved.
>
> The sfq_change() silent clamp is user-visible: sfq_dump() reports the
> clamped quantum, so a previously accepted quantum < 256 now reads back
> as 256. Idempotent config managers that read back and compare will
> see drift. fq_codel_change() made the same trade, so this is consistent.
>
> Conditions to recreate the bug: create a fq_pie, sfq, hhf, dualpi2, or
> pie qdisc (or a drr class / ets band), then tc qdisc change ... quantum 1
> with a STAB size table inflating qdisc_pkt_len, e.g.:
>
>   tc qdisc add dev dummy0 root fq_pie
>   tc qdisc change dev dummy0 root fq_pie quantum 1 \
>     stab data 32768 size_log 15 cell_log 0
>
> Requires CAP_NET_ADMIN in a user namespace (unshare -Urn).
>
> Fixes: 709f34f7c28d ("net/sched: fq: add overflow bounds to quantum and i=
nitial quantum")
> Fixes: ec97ecf1ebe4 ("net: sched: add Flow Queue PIE packet scheduler")
> Fixes: e4650d7ae425 ("net_sched: sch_sfq: handle bigger packets")
> Fixes: 10239edf86f1 ("net-qdisc-hhf: Heavy-Hitter Filter (HHF) qdisc")
> Fixes: 320d031ad6e4 ("sched: Struct definition and parsing of dualpi2 qdi=
sc")
> Fixes: d4b36210c2e6 ("net: pkt_sched: PIE AQM scheme")
> Fixes: 13d2a1d2b032 ("pkt_sched: add DRR scheduler")
> Reported-by: vega@nebusec.ai
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

