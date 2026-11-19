Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795105213;
	b=d135aXMzoXsbbNTuESpeXeZQKy1UoLDqDOtgNZz3v/2PWHQe5ka6Ajjw0PIq4Y4UElVF
	 O5maxYQLy3XKrjV9eKyBxoy2hTz0otYWXJVDgHNZmerCmQoFEWGg/5pAFRKIMIN5K3Azi
	 WfDPmEDJ3cbkSIk/r9QjShm2Urs4f9bJjD3VfY+++aRdcFCUtc7OUedeWt2v/awKV3hr9
	 k7Qo0LjqLVcTptR8vWigXcViMKHHi2khLEgfnbdNLOaE3UtMc9A0eqF3ayIFAvCHYBCDM
	 XDPXTdMJGj6jPlxxQXgcUcCJvfdD+32q5Kpy5BXF+Oxcabhzi1HSZtmJBZJqPjz8K+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795105213;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ZolabUnXvz6ImLr//BVgpmB0l+6TSiy7CxBX8JYJRHg=;
	b=kvvMmiDnC7/NBEJtgo6b/Wvotg+dj/OQufmWDbSIbFwpI/JSUdHZ+C++IlQfr1jL0IkR
	 JtZ0qIWWsv+cmyrDik+wBxfdUJmjh7U45KLgrkLDh6XIsV7XCovGR8u4Qwi4XcKuaTIfj
	 8ku8v6kJEwbDT6RU2hIWPnhmEG98pAtK1PHbZ0K7Xm1a7R9n68U3W8vpvuRUVojcRTeNS
	 RK8XhmDZ3gCiRfEemiHgAkCu+rl/SLA6NGbcVZyDYyemV1Sdv800fYOECYdPNGy1cMlkt
	 raSn98JLyHHv3fRI7a3/mWSf3PHb/UDlsBu4PpsajheYI0m1h2E9fis7QnZMNTFaefQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=udoRXDmN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA39606A320
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 16:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAA39606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=udoRXDmN
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c4322d310e7so391898766b.0
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 08:20:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795105211; cv=none;
        d=google.com; s=arc-20260327;
        b=NGW+hwgCvaK/xi9qiav3RLt8Z495tzFKvltbR8E0DJWLNOKcDe3u1N+3DZ2JjxzzCh
         3pvBp039d7r1Sg3rgk0iBvzhCmLOmAddjVgxzv+zcjuVJP5o1pEPLgtF6XRTY/f/m0bP
         VOnI2aXzdKXHKRyLOi7/AKJ0j8FjoS0/Xi7XgvjhQ43MR1O0oSsmAr++PtaAlJhKeepr
         gsQPGubGUj/cVJuHfbtU6nsS+pPHANXerEo5cf8l8X+NTZ+bWmW++aLJ+MgkTWEM3w7u
         tLdzs0oM9UMpcC2jAy7FW2fT1EvxhstqRwW2KIovAjIaAZlLIWZDN+LuJjVdUsMcLfTb
         Gnzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZolabUnXvz6ImLr//BVgpmB0l+6TSiy7CxBX8JYJRHg=;
        fh=TeRIWUj5Y76FTOixrFk655RtVKQgcIuTzZgRmCFu1P4=;
        b=RZJvWgC2SsV2heBM911qImdmATNE4Sf+hw8F2Ukgvjs0Ix+e9f532V4d7HsnEsrN0/
         +97j6T8W6W9YBTkaKVUB8I0jrFuzV/aCV6DV3vfpk8yZ1JTppFQnbIg1SPt+MeeR08/6
         ZSNrsOhTCuj7SzkgJW4gkwicNOzsLFAvifDx84SuWDiJAhe4yXrRcY6KAZPnY7v7FwXE
         X6kZhZnuL6dj786Xtq5FHCd8r/Ls4B6Ug8KYC9nQzO4+FgvOtpiKflq2KXkf5W4mD/4m
         42n3RIJlaSv7xnOX2Fl49i9fXIIBBS+lwGw265QolZMdVZP/RfmJvRZQj0fMT881D2vx
         Zx4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795105211; x=1795710011; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZolabUnXvz6ImLr//BVgpmB0l+6TSiy7CxBX8JYJRHg=;
        b=udoRXDmNTG65E1KiAGRjenmA6hFUV76gTazdJNUKHywk5GHw/ef9ugc1cH6nprSuma
         c10B/Ci5dDnaqEG9zP0lRcs5sI2xVNsQIs9/VXo0QptmFv4FkiToNUB+nd4eVvYRWAE3
         c4nyREwZkJYJ7ozT86wiIrYu0I71J4cjOlmwShAQCf2wC16rEiQPpu9bqBG4MwI5EtEC
         JP5DPvjWixGAX//ZwvMDUQu+TX7qjIroQMj74Fzy1EvQtf4rPys+Dn4U0SQEPHb0y0CA
         Ku1KdL7wMinHo3FWFx2UXKu6YJZVJXVVk1ElQdRuhYMGseo33Q0TjoPvf/lu6NwU9AJY
         Js2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795105211; x=1795710011;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZolabUnXvz6ImLr//BVgpmB0l+6TSiy7CxBX8JYJRHg=;
        b=m8Lp3trkUMgBv2p5THhIAVorT8RhM4U8ANfCkk6js32Zv3E0AvHCrDXlrAYiM1fGGn
         lCIenvzsB3mgIW9jrUDuVdttIEY82Q8UzNJZ61iA8hXqYZVsq8lvRaEoWGEQ1xxx+XbD
         1vWNeU1Y7JtNJU4RJKvZaghPsY//iJ2UXEzLct//T3fjSfyLBHVSnTJS5VX/F7/0kheE
         gKiH0mzVfnJni9853xs7d1lxTO4zRFGPGUoPqYnMXlHsUz3DSE8AiJULjdYZ+B9ieboU
         A6orx1/BotYAWopMaUf86Q28PvkRbzulDmDqcUKYp6Syuu4P1U7MiwkMtP18dlW+2+8D
         9esQ==
X-Forwarded-Encrypted: i=1; AL+hErE33+3I3FF2xVgDzH8lPN6JBANWezQ+5YGjFQ+zBikYrf2BOwT67VnV61HHihOKwObUiHxuBtQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8CH0F1APSirAJT/krwE5gdIvai2xLMbZYVKfhwAPVF56RXRDu6
	5A1oB99NguQwGC5jzifE+cdxVR190IQLtcLtfduNOwKFduGzNqXvwCEcIo+CnVEuJDVh3EZ/Vvh
	SrSNTnBu41QqvQ7VsHRTC7rcBitjivKs=
X-Gm-Gg: AYBFou1eMdzVqBzR2JVtwpztDdiykT4+uVg6kGso0SbLbaIp1k1DLwCGvGWzpHgzRVG
	Rs9GI0em5/2hyuCKBB5AXGkYfjt+u/lCQxm71ZhSwe5Xd/kfweoej5clA6G9tuXcvLANN8jiJY0
	cjcdvLkMcrXf2uf98HTM77d7KmiUcpawNCHF0XMyIzD9XYMiEe6E1MsO5NrI/VmZMSQJ22pNYFP
	Wejf+HZ2yVV/E1FngJrOU/W8/KBXEHoiksNLs+BajomvjxWtV7QFA0qqnWUG75Obfi+uzv6vvEG
	Nj62rE4kUxreS6Z1oq0smaDYeELb8hStqCoztw7PdoLxB9Mkw3rSDjArO6sIznashgfzFFBwNu3
	xswPVITO9AKVGkQ2Jkv9cbFqSa55zpY3pVzHmf5sfdeeyErDEUOsyniHdbbFsB7Nj4ddmmg==
X-Received: by 2002:a17:907:948a:b0:c49:9383:a28 with SMTP id
 a640c23a62f3a-c513ab42e45mr43644866b.35.1795105210777; Thu, 19 Nov 2026
 08:20:10 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103175832.3374540-1-bestswngs@gmail.com> <20261103175832.3374540-2-bestswngs@gmail.com>
 <20261118134914.7991e6b1@gandalf.local.home>
In-Reply-To: <20261118134914.7991e6b1@gandalf.local.home>
From: Weiming Shi <bestswngs@gmail.com>
Date: Thu, 19 Nov 2026 08:19:33 -0800
X-Gm-Features: AclHuK9sUubrXMbtZoru3ca1x99Tv3LOsVjfMh6ZmB9yzu1gZ0xBg5L0ucnEaiI
Message-ID: <CANgPUi198k=YWAk_Y0=0XBEHmmHHBxmHCc3QedGVUH5dC2AJZg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ftrace: Complete subops teardown after hash update failure
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, co+bba0c6b49150bef3@bugs.sh, 
	Xiang Mei <xmei5@asu.edu>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Steven Rostedt <rostedt@goodmis.org> =E4=BA=8E2026=E5=B9=B411=E6=9C=8818=E6=
=97=A5=E5=91=A8=E4=B8=89 10:49=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue,  3 Nov 2026 09:58:31 -0800
> Weiming Shi <bestswngs@gmail.com> wrote:
>
> > When removing a graph operation while other operations remain,
> > ftrace_shutdown_subops() rebuilds the manager hashes. Memory allocation=
s
> > in rebuild_hashes() or ftrace_update_ops() can fail with -ENOMEM.
> >
> > On a rebuild failure, the subop has been removed from the list but stil=
l
> > has FTRACE_OPS_FL_ENABLED and FTRACE_OPS_FL_SUBOP set. On an update
> > failure, it is added back to the list. Neither outcome matches
> > unregister_ftrace_graph(), which has already removed the graph slot.
> >
> > For example, enable a function_graph tracer with a nonempty filter and =
a
> > return fprobe. Fail an allocation in rebuild_hashes() while disabling t=
he
> > fprobe, disable the tracer, then re-enable the fprobe. The stale SUBOP
> > state routes its filter update through the now-empty manager list.
> > rebuild_hashes() leaves its output pointers uninitialized, and ops_equa=
l()
> > can crash when dereferencing them.
>
> Please show the example that can cause the above situation.
>
> >
> > Complete non-final subop removal on both error paths by clearing its
> > enabled/subop flags and manager pointer without adding it back to the
> > list. Initialize the rebuild outputs to EMPTY_HASH as well.
> >
> > A failed manager hash update may leave functions enabled that only the
> > removed operation traced. Keep per-subop filtering in that case, since
> > direct graph dispatch skips those checks. Restore direct dispatch after
> > a successful removal from two graph operations to one, or after a
> > successful first registration.
> >
> > This depends on the reader synchronization in the preceding patch.
>
> Every patch needs to be stand alone, and not mention other patches.
>
> > Clearing the enabled flag after a failure allows the caller to release =
the
> > subop filter, while an existing graph callback may still hold it. Backp=
ort
> > both patches together.
> >
> > Oops: general protection fault, probably for non-canonical address 0xdf=
fffc0000000802: 0000 [#1] SMP KASAN NOPTI
> > KASAN: probably user-memory-access in range [0x0000000000004010-0x00000=
00000004017]
> > RIP: ops_equal (kernel/trace/trace.h:1011 kernel/trace/ftrace.c:3416)
> > Call Trace:
>
> What were the commands that caused the above?
>
> -- Steve
>
> >  ftrace_update_ops (kernel/trace/ftrace.c:3464)
> >  ftrace_hash_move_and_update_subops.isra.0 (kernel/trace/ftrace.c:3795)
> >  ftrace_hash_move_and_update_ops (kernel/trace/ftrace.c:5095)
> >  ftrace_set_hash (kernel/trace/ftrace.c:6006)
> >  ftrace_set_filter_ips (kernel/trace/ftrace.c:6020 kernel/trace/ftrace.=
c:6769)
> >  register_fprobe_ips (kernel/trace/fprobe.c:290 kernel/trace/fprobe.c:1=
020)
> >  register_fprobe (kernel/trace/fprobe.c:979)
> >  enable_trace_fprobe (kernel/trace/trace_fprobe.c:838 kernel/trace/trac=
e_fprobe.c:1480)
> >  fprobe_register (kernel/trace/trace_fprobe.c:1555)
> >  __ftrace_event_enable_disable (kernel/trace/trace_events.c:913)
> >  event_enable_write (kernel/trace/trace_events.c:943 kernel/trace/trace=
_events.c:1995)
> >  vfs_write (fs/read_write.c:685)
> >  ksys_write (fs/read_write.c:739)
> >  do_syscall_64 (arch/x86/entry/syscall_64.c:61 arch/x86/entry/syscall_6=
4.c:84)
> >  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
> > Kernel panic - not syncing: Fatal exception
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 0ae6b8ce200d ("ftrace: Fix accounting of subop hashes")
> > Reported-by: <co+bba0c6b49150bef3@bugs.sh>
> > Assisted-by: LLM
> > Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> > ---
> >  kernel/trace/fgraph.c | 10 +++++++---
> >  kernel/trace/ftrace.c | 22 ++++++++++++++--------
> >  2 files changed, 21 insertions(+), 11 deletions(-)
> >
> > diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> > index 14733f519..48521bc33 100644
> > --- a/kernel/trace/fgraph.c
> > +++ b/kernel/trace/fgraph.c
> > @@ -1406,8 +1406,11 @@ int register_ftrace_graph(struct fgraph_ops *gop=
s)
> >       gops->ops.flags |=3D FTRACE_OPS_FL_GRAPH;
> >
> >       ret =3D ftrace_startup_subops(&graph_ops, &gops->ops, command);
> > -     if (!ret)
> > +     if (!ret) {
> >               fgraph_array[i] =3D gops;
> > +             if (ftrace_graph_active =3D=3D 1)
> > +                     ftrace_graph_enable_direct(true, gops);
> > +     }
> >
> >  error:
> >       if (ret) {
> > @@ -1435,6 +1438,7 @@ int register_ftrace_graph(struct fgraph_ops *gops=
)
> >  bool unregister_ftrace_graph_start(struct fgraph_ops *gops)
> >  {
> >       int command =3D 0;
> > +     int ret =3D -EINVAL;
> >       bool removed =3D false;
> >
> >       if (WARN_ONCE(!(gops->ops.flags & FTRACE_OPS_FL_GRAPH),
> > @@ -1461,9 +1465,9 @@ bool unregister_ftrace_graph_start(struct fgraph_=
ops *gops)
> >       if (!ftrace_graph_active)
> >               command =3D FTRACE_STOP_FUNC_RET;
> >
> > -     ftrace_shutdown_subops(&graph_ops, &gops->ops, command);
> > +     ret =3D ftrace_shutdown_subops(&graph_ops, &gops->ops, command);
> >
> > -     if (ftrace_graph_active =3D=3D 1)
> > +     if (ftrace_graph_active =3D=3D 1 && !ret)
> >               ftrace_graph_enable_direct(true, NULL);
> >       else if (!ftrace_graph_active)
> >               ftrace_graph_disable_direct(false);
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index c7d74b33d..7c712d99f 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -3672,6 +3672,8 @@ static int rebuild_hashes(struct ftrace_hash **fi=
lter_hash, struct ftrace_hash *
> >       bool first =3D true;
> >       int ret;
> >
> > +     *filter_hash =3D EMPTY_HASH;
> > +     *notrace_hash =3D EMPTY_HASH;
> >       temp_hash.filter_hash =3D EMPTY_HASH;
> >       temp_hash.notrace_hash =3D EMPTY_HASH;
> >
> > @@ -3713,7 +3715,13 @@ static int rebuild_hashes(struct ftrace_hash **f=
ilter_hash, struct ftrace_hash *
> >   * will not affect functions that are being traced by other subops tha=
t
> >   * still exist in @ops.
> >   *
> > - * If the last subops is removed from @ops, then @ops is shutdown norm=
ally.
> > + * If @subops is the last subop, @ops is shut down normally. Otherwise=
,
> > + * @subops is detached even if the manager hash update fails. The mana=
ger
> > + * hashes may be partially updated, but still cover all functions requ=
ired by
> > + * the remaining subops.
> > + *
> > + * Return: 0 on success, or a negative error code on shutdown or hash =
update
> > + * failure.
> >   */
> >  int ftrace_shutdown_subops(struct ftrace_ops *ops, struct ftrace_ops *=
subops, int command)
> >  {
> > @@ -3753,15 +3761,13 @@ int ftrace_shutdown_subops(struct ftrace_ops *o=
ps, struct ftrace_ops *subops, in
> >       /* Rebuild the hashes without subops */
> >       ret =3D rebuild_hashes(&filter_hash, &notrace_hash, ops);
> >       if (ret < 0)
> > -             return ret;
> > +             goto out;
> >
> >       ret =3D ftrace_update_ops(ops, filter_hash, notrace_hash);
> > -     if (ret < 0) {
> > -             list_add(&subops->list, &ops->subop_list);
> > -     } else {
> > -             subops->flags &=3D ~(FTRACE_OPS_FL_ENABLED | FTRACE_OPS_F=
L_SUBOP);
> > -             subops->managed =3D NULL;
> > -     }
> > +
> > +out:
> > +     subops->flags &=3D ~(FTRACE_OPS_FL_ENABLED | FTRACE_OPS_FL_SUBOP)=
;
> > +     subops->managed =3D NULL;
> >       free_ftrace_hash(filter_hash);
> >       free_ftrace_hash(notrace_hash);
> >       return ret;
>
Hi Steven,

Thanks for the feedback. I will address this in v2 and include the
reproduction PoC to show how the issue occurs.

Best regards,
Weiming
