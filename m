Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF6E1D6DA9
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 17:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787851831; cv=pass; b=CiUmwl2JwkhV+6MvLAjh00Di7ZGFkoRHqWcEkVXZz2qX1Z3qe4Ko+4s2wT7AJMgonP7kGLCw6btQFUvfjkNYwmKjxfgXZIVJckNH/LFZbwZ0avibn4LOgUwgmWWAnQtgFQBpDFL1URyRBhBIL7nungBKTWG5+eUXTDRW0PONAyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787851831; c=relaxed/simple;
	bh=JHGHTCIHkS7ZtSd/nhPlvivP9R4MXEl6d74i8khb/Yg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DQkhL+Y1EnLANi5tCv3gUzw/vu3/5N8y/mzYa3438uxnGPvExfTymHJF9grewtL6dk705UGZ1/gP5cE3byjC9+eWoR8sMZLPBZjJO7BqXXBv+Y3D36Z1H4LrTs8E6HcDMgbHoVR7F7eZVAg7/tFINcVyetUZ3VECrv2MwxH0yBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=PE92KcBx; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="PE92KcBx"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso154013a12.0
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 10:30:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787851829; cv=none;
        d=google.com; s=arc-20260327;
        b=rX7wrK4DycVM6JxOUSYotwiXeooRUMSYovS8PVGLVRH5B05e19hQBvguZrpQ+7Kqld
         BdwZg3v1Xs0vDTmCsGD0+q6eSsfiLYb3kGummMSdU/VaIhLNuJKczDveYS+dvjGoOMcT
         Q7i9fB5glrB+KiGAswSPkko4KGh4P+AouXPS51dIEK2OWGMlndqKfrntvru4W10/Vc65
         WfAr6H2fCxfyIckq4DM2BBeSrel2QLWqMg/Eyxux2KTIwUcDDEVK5Ia1Eh/T2sNLZY+r
         9H56zYE3vJ7C+UeTHb71L1eYbuXE48q9p8fc76c5B0zGzS3KI1EwN+4UovtuSTPNrJNY
         oi+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iLLGcbVfuf7yTVoqHZ5vu3n3AKk5F6JdfA/5wggXb4w=;
        fh=jvzhawluuDEzGk84bB7w6AXG06cpC8i45AW66K3BBf4=;
        b=Ay5TlCB6a9xAJ/anozn2v0TKe1r4o+T/SIwogPpRh5MGG/Ttn0H1fe9lA4ypo2Tjve
         7u0F0+rA5uOVU8jQh6YDqBHxsGcrpaZgrb0Sy4IdEsq+cPm64FAt9x7YMfWaG/QM2LSc
         WtHjR9kvhmrkB/UYa73RO6nYlTAWmhdb32LdJ7I26aqOxKFvQXVmCgLYzKXzjYi/42Bl
         xXFq7DBJureQoft8YkXfco5/Z/SaeIFK4tl8aTQ32CNmFUqF2E3Y01vt48zDLOhn4m4l
         OX0YiFyG4flSBS/yob4sakiuLQssXoZbDRD7BXoUDxGm5U7RgPfGxEMqO9631CYZwlbM
         pJ1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787851829; x=1788456629; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iLLGcbVfuf7yTVoqHZ5vu3n3AKk5F6JdfA/5wggXb4w=;
        b=PE92KcBxaKBdKSIPDJ8c1DK1dY7foYtGGdx7Cybh3RXQGzUO/I8/AmmJo65cytftMc
         RxvfG3hVusk51XRvnpDKrCCln3wE5jIrV460l5N9zCxG61TZ/PBAyxXYLowdmb8AFy+y
         rr3745dDjaBJC8BuWOL4vS0ASRaxXdJcVdUCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787851829; x=1788456629;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iLLGcbVfuf7yTVoqHZ5vu3n3AKk5F6JdfA/5wggXb4w=;
        b=GKMjtwdE4jSNqHsRsEuel8LlHB2esoeklaBxRO1dQunXc36rmgtAdUE1FgM1vhDWd4
         cUeo/pRDGxO1n5aat6QWWock+S8YjK3Xc9fHzjYEUOWYzmiqyhZK/HJeEt4kSWrRb1af
         pBeXUSKdKraJqRgeT5vqyGeROTVDb/XRFtgYPSNeRRVVEpr2WN6SSyKu1ClyYoGYErYy
         y4mzH+djCbbg56YL3LBXa2KGm7nKyNVm0rE9Y5SUX7Fv49u2pIltC5BvmHKkY4Rn3I5m
         To2LDuSDLIPPq/87eIf+VPr1Ee7Es9qDrt8l+qi3xf7EEr0wvDtPT7RdpU5Jl0wHfhkc
         f0tw==
X-Forwarded-Encrypted: i=1; AHgh+RpxQUsY8Yj/l9nwP5WdDqBLIy3xjB02VXS4uZ2RRBupU56hJk9w55oJktfalChNegck+8A+218=@vger.kernel.org
X-Gm-Message-State: AFuF++m/Rr+Lo6UZTN4g4xzegyZD31/UxW2jwe+4lYSB0jPulEI/ye2u
	O5WdYk/+OXkWf0Thj/fcur7TBgMKWfBI0pU9dSqOpWOOztm9kZSU0dQrPuDmdDHzfAu3FmiZFFa
	nuotLcGp/QOqyf48lDQhnQauwVC4VSY2jfrT73TWm
X-Gm-Gg: AR+sD11q/wlj+wkzfFZ2e/IAXVJ/YRI1gJqGkF10uH04sw2aYJy9msPDa1SH4PYcQty
	SO5ZzS4aOq2EeVE2iSOUW02n3wJXoISpPbvYYIAVr8WFeiOVddP1caCXWqXhY55y5MUTIWSrv6p
	Vl/94b5jKkgA/VRtRBuQzyvN7wKRj9LycQ+A/ORgxVKDZs/a32SAed3c0f+ky7G4QG4YaqSAJuj
	/HFXFkP5jEqv+hNqSKcoq6ENyyM4srUxYTivhBbMZ9VqcvJPGFl0sy3fM+Y+htN5Pp16u4QSzxp
	hzFkw7PV3mo3KuTKmfg3ACEQqgKCL5CTSj58+i5ZA1X2Sg==
X-Received: by 2002:a05:6a00:1da4:b0:847:8acd:747c with SMTP id
 d2e1a72fcca58-8562ba7dcb8mr1537496b3a.13.1787851829194; Thu, 27 Aug 2026
 10:30:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825081052.133898-1-jhs@mojatatu.com> <81ad3c6c-85d3-4ba0-b36e-3db21138416d@redhat.com>
In-Reply-To: <81ad3c6c-85d3-4ba0-b36e-3db21138416d@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 27 Aug 2026 13:30:17 -0400
X-Gm-Features: AcwNN1W5MtHUvt907HbvKT0Wx9tpkEAYjM1m7_cW7ZJ1J38wEThkvR6LGeVp2lI
Message-ID: <CAM0EoMk1b8kFf_FNH5vJvT4g6Nc3+affDB1PrJcm=p8nyoaAeQ@mail.gmail.com>
Subject: Re: [PATCH net v3 1/2] net/sched: cls_u32: fix duplicate handle when
 node ID pool is exhausted
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, stable@vger.kernel.org, 
	vega@nebusec.ai, Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 6:30=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 8/25/26 10:10 AM, Jamal Hadi Salim wrote:
> > gen_new_kid() falls back to returning max (htid | 0xFFF) when both
> > idr_alloc_u32() ranges are full, instead of reporting an error.
> > u32_change() trusts that value and inserts a new knode with a handle
> > that is already live in the hash table, breaking handle uniqueness
> > within the table's node ID space.
> >
> > The handle was never reserved in ht->handle_idr, so every later error
> > path that does idr_remove(&ht->handle_idr, handle) removes the
> > reservation of a different, live knode, which is then reused =E2=80=94 =
one
> > failed add compounds into further duplicates.
> >
> > The 4095 limit is per (table, bucket) =E2=80=94 ht->handle_idr is per h=
ash
> > table and the range is derived from htid (bucketid), so a table with
> > divisor 256 can legitimately hold 256*4095 knodes.
> >
> > The sibling helper gen_new_htid() has the same silent in-band failure:
> > it returns 0 when the tp_c handle pool (1..0x7FF) is full, and
> > u32_init() publishes the root hash table with handle 0 without
> > checking.  Two root tables with handle 0 alias in u32_lookup_ht(),
> > allowing cross-tcf_proto knode add/lookup/delete.  Add the same
> > exhaustion check that the divisor path already has.
> >
> > Return an error so u32_change() fails with ENOSPC/ENOMEM when the
> > node ID space is exhausted, and so u32_init() fails with -ENOMEM
> > when the hash table ID space is exhausted.  The extack message
> > distinguishes pool exhaustion (-ENOSPC) from a transient allocation
> > failure (-ENOMEM).
> >
> > Conditions to recreate the bug:
> > - CONFIG_NET_SCHED=3Dy, CONFIG_CLS_U32=3Dy (or =3Dm with module loaded)
> > - Create a clsact qdisc on a device, then add 4095 u32 filters with
> >   auto-generated handles to fill the node ID space for the root hash
> >   table (single bucket). The 4096th auto-handle filter add triggers
> >   the duplicate handle (fh 800::fff reused). Reachable at Level 2
> >   (unshare -Urn, namespace-local CAP_NET_ADMIN).
> > - For gen_new_htid: create 2047 u32 proto entries on the same block
> >   to fill the tp_c handle pool, then create one more. The root table
> >   gets handle 0 and aliases with other handle-0 root tables.
> >
> > Fixes: 7801db8aec95 ("net_sched: avoid generating same handle for u32 f=
ilters")
> > Reported-by: vega@nebusec.ai
> > Tested-by: Victor Nogueira <victor@mojatatu.com>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > ---
> > v2 -> v3:
> > - Fixed tdc test that sashiko (correctly) pointed potential security
> >   issue on.
> > - extack: condition the "Hash table node ID pool exhausted" message on
> >   -ENOSPC; emit a neutral "Failed to allocate node ID" for -ENOMEM
> >   Introduce small extack helper. The v2 message was misleading for
> >   -ENOMEM (Sashiko nipa gpt-5-6-sol-1-2).
> It looks like that sashiko was able to think more about this patch and
> found new stuff:
>
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260825081052.133898=
-1-jhs%40mojatatu.com
>
> I'm unsure if that falls under the 'same bug' category and should
> addressed here or separately. WDYT?

Separately. The Sashiko findings on v3 are the same pre-existing
issues it flagged on v2.
All three are different root causes (IDR key mismatch, refcount
management) from the silent exhaustion failure this patch fixes.

I am tracking them as separate follow-up patches for net-next. Here's
the list just from this one patch from the sashikos, none of them
wrong, but none "regression" and worth fixing for net in my opinion:

1. handle2id() alloc/remove key asymmetry in the divisor path causes
hnode handle duplication
2. ht_down refcount leak on new knode hw offload failure errunbind cleanup
3. ht_down spurious refcount_inc on update knode hw offload failure

There's a bunch of minor ones, that may be worth fixing for niceness
but as you know no good deed goes unpunished with sashiko, the moment
i post a new patch it will find something to complain about.

These are:
- Commit message range "1..0x7FF"   being inaccurate - which is true.
- Extack should say "bucket" not "table"  - which is a minor refinement
- tdc test to check and assert for ENOSPC, i think the explanation it
made is sensible. We only check for failures not which exact return
code it made, but if i change this it will meaning changing a good
number of tdc tests to follow the same approach.

I could probably sneak some of these in in net-next or i could just
resend only fixing this. What says you?

cheers,
jamal

> /P
>
