Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689083E3D98
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 22:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785451952; cv=pass; b=RNhnnBF2ImnOJ4Vx9nC8FJjWNd7K7sDvqY0syoyDvKND04LPpL4N5UpH5qCavxk+Iaa14ATDgm0hpr3zofkcItb32CtHuoW0NgGX1lV3FxAtGFcO1py12AHzNZAhGEr0pRbpVa73cE673dCNaj7bl3Gxoep4uJ/WVKhDqm9oV4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785451952; c=relaxed/simple;
	bh=xakOe7onQvx4wiZDCNi7JSD0SnMEIMMivTi6oZqsI8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aWTZ4CpglbDEjASTZNswxCKtzBN4TXseg0g9hLABF81N2j1IwmliIKL2rcmaJKHSeMONu7f8yPxevDti+Boa2H15he0v0Az2h97VsB9QvGq5nW1Twv4SXlTlG0lm7yfrSXt+YY41x2XhvApvjs36KhzWsGkR74x4yRXNiUjBLPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FO5vg3+T; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FO5vg3+T"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84847482584so140401b3a.0
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 15:52:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785451951; cv=none;
        d=google.com; s=arc-20260327;
        b=m7TbajE6MhC4eZ59z5u1+NFuHRjztfyEfCNNO9Ns/WO4sgmtTggejB9GY4z1/W3oBJ
         o3Z9fAU+Ow//5vWEjM/vbHhYh4eF4RnDLS1DrJwXv4res2vFg3vmR+D5KiUMNCiUvozZ
         ezhDwkkw/yVGkpRm2SSji4xu1xcEN/R1e7s4YPon4cGX7+rD0wHBJpmpvgsq0QraFw5K
         2zgG5EgLpvhfUcwlOV4WAGqE1T/l4BQwfQDbWpVaOq2vP/9ty2r8ydR9jWgPkq3Ol+vu
         9X32iohptR1TxNnTI5iSCyzvGx3Q5IwnlVnZRmo5LDYqjh+7UgB6ZCKtIXOTOL7s4S1p
         e7Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kK5U4QwGT9O9VQ+w4BY9Dom3H1xqRqoq0z8HNkQ4nwk=;
        fh=qiAIO8Y4Ing7BHT2e7yF7h8nAMUGRrNXY/Lh4Q5PW3A=;
        b=XylsHPGu2BsWO1DYSkS6UvKeOy4q5qHIAQTKx1B/ZigyfyZ+3WOaWklfUBoxvhjczp
         TEe+sB3Fe3echmj0yWanw+JLZfIh1qN3Lq1YIpnKwHiIUi5ebNNsUtxrcbenLQy68i7L
         fzrxungyokTunIZpuUvcHZIoVDeet96eIqAAG0E3t3mOw4n+bbuq+uO2pn5SMsqwhbDr
         Ypsgm39lJkxBXMKScSwDi/ZRObLJawxLWk3vJacpOe5gH19nq77AKY6FsZmpIUlySRPQ
         3vz+ajXbMXGTd092WVC6tgwd92n7xS6j66UGlUd0/dxhE73YOs7SR5wyCApWdyITjRoB
         97IQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785451951; x=1786056751; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kK5U4QwGT9O9VQ+w4BY9Dom3H1xqRqoq0z8HNkQ4nwk=;
        b=FO5vg3+TyGAVZMr43F51pzQdtfCSiJs/TIRpBFM6nJPe0jwHqNY0Mc9mt6t+GvPAXG
         aV86+NRYvPrFtotONJS5wxcCiaVaOrNBLq6yQt7UoS2xLF8Irr8cF7C49+FdcZH6Xp5o
         5CV/wCPENc5tr87+OD390TmxT2XeHdRynPhjKRVhT47L7DeOHBqYCaVYdu0+uZwDeNOh
         s9NCIL1LZLskAN0kxhh+PCRu5wJgpsM6DdKoNPU0P/nZM1l7KjIMso1ZpcL8C2xuSK/r
         jdeezhAi3ltYfzjLYdb1MEyKN91ZH9nHfxeZv5O8PXXEE9xWrDRODxMzZsq94Hi1oHMn
         8K0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785451951; x=1786056751;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kK5U4QwGT9O9VQ+w4BY9Dom3H1xqRqoq0z8HNkQ4nwk=;
        b=lBfLwexgv/pKq8jgVRyv3msryjBzH+HkZ8tHNJATs5wco5CS2n5nePqQ55lT8Fc9P1
         C4v/D16mSCuUd7PcCrLbOla8YXYOt+cX/Ofvb1RWcA/8hhcXyUfiTRrjeegrBt22Tv70
         EQJcDLv1K8Zup2pNtrU0gN4vDjf552yc83jzO29NlSNTHGaQOMFs+RvncLG4QpqhYQ8m
         JgltiLMf/N9sMmtJn3XlAyQdpPPoYM55j1iW7c+Yr/5MRYmoyqfoy3HcDhIiMDCruEER
         JK/My2ABfE+HweO39HTmzPrUFYWjmnDLHgp8qr6ModOtZKrKnS6QjIPxMiaMuocRBZTt
         l6jA==
X-Forwarded-Encrypted: i=1; AHgh+RraeLYL8jgidLz95yzRvst9h3VsilPCleMiC3Jiq6z6D5AQV3e3nYZxIoAc4JbphSTJGmsIDBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEJflnyUyMm/l6/Hrp+XB4T+nBzn24ad/gEQYbmwohxmAddpsy
	UIZ4o13Dk5BwZMoedWg/0PGNqOe3wSZYhO+T8UUkIK9DOCyBG8oqUH7r6TfrlbY/+pB6SzLQ/TS
	22qsEqpo04mPTxVbvpqDofOiVCjzsmgI=
X-Gm-Gg: AR+sD12gpSZ1K6vyAABhTyIG/wjqUx4NBeFEYW0Yc8hRxWxqKY5Ol78/B13gZbKMxG7
	wq9unbkgmgGT70kuKy1CO6Wj0ClaoNUHu4hgTQ1+0+n6nN/Xjgg2eFm4jqmlh+ugbprvhZ1Pc3K
	8n02oRUKzbwGRvLEaQZDIFzHIvkkF7fTiRgeuYUynRg4+yKIBDIRzUGxsGEQIq7samiBNMvraQ+
	UZSTSAgXm+6+nGneYfo01F/0vqbqkEvae5OsmBvzsc3ia8/XbKFX1qjYGN3PHzh6OuU0h7nWWDG
	VR5KoZwpZNVFiX3NV6iNMWDYkxIyBfkRGEieNxu90HpqnDnv77MVem3fHAa41lJn5PE844oC8YU
	klRwvHe9nVoZjWotBRX2BexvWjYEudCKy/4O5vlgiMsGEGwEHyk4I
X-Received: by 2002:a05:6a00:ad2:b0:847:8d0e:5d83 with SMTP id
 d2e1a72fcca58-84eca755e6bmr1544377b3a.26.1785451950568; Thu, 30 Jul 2026
 15:52:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729083807.1588544-1-jolsa@kernel.org> <20260729083807.1588544-6-jolsa@kernel.org>
 <78c72a5b-0db5-47da-8b35-e6a2e6976d7c@linux.dev> <ams3yHvqyXrWAbBV@krava> <6a20bbdd-2557-4db8-8839-e2f53857ced9@linux.dev>
In-Reply-To: <6a20bbdd-2557-4db8-8839-e2f53857ced9@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 30 Jul 2026 15:52:14 -0700
X-Gm-Features: AUfX_myM53Q2L3UJ-nKNITC_joYJHuC0YcFLOr-SZmQSfciKfcDnBLGJiXibq7g
Message-ID: <CAEf4Bzbe1tETVtVMxkaURSoW1PmVfWnR9Kd9iwaPskzCwij7rA@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 05/11] bpf: Disable preemption in bpf_get_stackid
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, stable@vger.kernel.org, 
	Tao Chen <chen.dylane@linux.dev>, bpf@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, Quentin Monnet <qmo@kernel.org>, 
	STAR Labs SG <info@starlabs.sg>, Arnaud Lecomte <contact@arnaud-lcm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 6:43=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> On 2026/7/30 19:38, Jiri Olsa wrote:
> > On Wed, Jul 29, 2026 at 06:30:26PM +0800, Leon Hwang wrote:
> >> On 29/7/26 16:38, Jiri Olsa wrote:
> >>> The get_perf_callchain call needs disabled preemption plus we need
> >>> it disabled as long as we access its returned trace entries buffer.
> >>>
> >>> Note the bpf_get_stackid_pe function is executed already with
> >>> preemption disabled.
> >>>
> >>> Cc: stable@vger.kernel.org
> >>> Fixes: d5a3b1f69186 ("bpf: introduce BPF_MAP_TYPE_STACK_TRACE")
> >>> Reported-by: Tao Chen <chen.dylane@linux.dev>
> >>> Closes: https://lore.kernel.org/bpf/20260206090653.1336687-2-chen.dyl=
ane@linux.dev/
> >>> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> >>> ---
> >>>  kernel/bpf/stackmap.c | 19 +++++++++++++------
> >>>  1 file changed, 13 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> >>> index 43b1e5436047..e48ddb4edd47 100644
> >>> --- a/kernel/bpf/stackmap.c
> >>> +++ b/kernel/bpf/stackmap.c
> >>> @@ -624,30 +624,37 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, r=
egs, struct bpf_map *, map,
> >>>     struct perf_callchain_entry *trace;
> >>>     struct stackid stackid;
> >>>     bool kernel =3D !user;
> >>> +   int err =3D -EFAULT;
> >>>     u32 max_depth;
> >>> -   int err;
> >>>
> >>>     if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
> >>>                            BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID=
)))
> >>>             return -EINVAL;
> >>>
> >>>     max_depth =3D stack_map_calculate_max_depth(map->value_size, elem=
_size, flags);
> >>> +
> >>> +   preempt_disable();
> >>
> >> Better to use the guard-style guard(preempt)() in this series.
> >
> > we prefer to call stackid_install with preemption enabled
>
>
> Understand.
>
> I wonder if we could avoid the "goto out".
>
> scoped_guard(preempt) { ... } might work here.

+1, came here to say the same, I think it should be

scoped_guard(preempt) {
   ... do all the things with direct return ...
}

/* we got new bucket here */

return stackid_install(...);

>
> But "goto out" is fine with me as well.
>
> Thanks,
> Leon
>
> >
> > jirka
> >
> >>
> >> Thanks,
> >> Leon
> >>
> >>>     trace =3D get_perf_callchain(regs, kernel, user, max_depth,
> >>>                                false, false, 0);
> >>>
> >>>     if (unlikely(!trace))
> >>>             /* couldn't fetch the stack trace */
> >>> -           return -EFAULT;
> >>> +           goto out;
> >>>
> >>>     err =3D stackid_fastpath(&stackid, map, trace, flags);
> >>>     if (err !=3D -ENOENT)
> >>> -           return err;
> >>> +           goto out;
> >>>
> >>>     new_bucket =3D stackid_new_bucket(&stackid, map);
> >>> -   if (!new_bucket)
> >>> -           return -ENOMEM;
> >>> +   if (new_bucket) {
> >>> +           preempt_enable();
> >>> +           return stackid_install(&stackid, map, new_bucket, flags);
> >>> +   }
> >>> +   err =3D -ENOMEM;
> >>>
> >>> -   return stackid_install(&stackid, map, new_bucket, flags);
> >>> +out:
> >>> +   preempt_enable();
> >>> +   return err;
> >>>  }
> >>>
> >>>  const struct bpf_func_proto bpf_get_stackid_proto =3D {
> >>
>
