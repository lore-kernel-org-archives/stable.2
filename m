Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D2B552920
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 15:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788881805; cv=pass; b=WqHdtvV8FXhH+OEIr5sn+zv5x39YkHYyclqtnO4JPedQZV9W4sLvds4GnhCxoxv+zu2vQjTs0x8ZWL7h4Mwyx3tFQzQoANajjOdrjEBN2hzdDafB7dgZGjnwProIFvcbOLT/wnr5F87VxyS8vFQThrs9uaBjkqIyKpzLTmV/0R4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788881805; c=relaxed/simple;
	bh=qv5CqAwUxGe/iJwgzvl6/jdT2pRBccudl+MNJGYvjwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IWf/VX55dPXQBU5+jXnw7h9Rh6dzUmrQpQeMbRGk6ANQNANyVTYGiHkYcvfDkILImxlhV3U147hlfK2zDP0p44IVkbeKfmGVg9mepQtq+NhEzWmN3IvLUUq40Mx1Bq9ZDLpSWProhWbfOj+peuR9t6hDt7Sl+rTQdg78YYVAqcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZYqLaX5; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZYqLaX5"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a60591ae45so95826a12.2
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 08:36:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788881795; cv=none;
        d=google.com; s=arc-20260327;
        b=s433e73GkzZnQr+ohjYhcBxFVUkgE5rutjT9GjL3noOtaCENN7hCaV1uNUvKKAyQYy
         L3YS6OxX6vHAbjQYvvvx8tfvRPbfx0nCmxCttEuCZp9Im1EjVVhB5Zu9WNvHaYQIgsms
         amtlSzWXwSNVPyA5hyTUdNvOVyg1KEBiyoJNlUkcXCKyntUc0G3M73pHwENMZXlNG25H
         Rw33q+SuPnRbJ95JvZAznCmIvgA8c05ey1FH3gl8+PapuDOmndpjJEILFo/ZA9cqWVSd
         +LhE8lNqDPAsciOxfAkH+E27CeyCI+rBvu7pVS/Tis8vbvKoGCXSKbGUwkiM+3JuamUO
         ZT4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S8FzMS8SqyHbEwR/vnXKxYqgMS5+hpscCzqtpdIcwKA=;
        fh=M8Qd8cFKr6pLwW26hsRDTIbYqxtS8UuHBZC8Q+kwFjU=;
        b=MJiGBOJEXSCJu6Ysf8b8xLF2vEfQtxariF0POOlSTdCf+uHoLmDXlX4wCOEqHoyJ69
         hYxIKl+5MyljtDqJ75iIjGXPeyrKtZDvsShDrPcxVPwJmLktt4Uo7bZ8Ta+FmDWWoHWG
         4BWe6dxFiX0Ms7i08EDXkASXo8u9kUx683yRktXDmKaSfvsjtyQTcXiAdMn07Imlf4+Y
         jnM2iCKIJEU3j09rGlhQHms9Vtw5k/xoz++MLUAaMA+3vdUOmUXzD+rSc38X/nBFJbMC
         AdF0sPQMc8CgIBRlPDxcW/Z5WNePg5HDv90yY6VAz1PJcZe3VCVHX1toko6xwecIEZek
         f6EA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788881795; x=1789486595; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S8FzMS8SqyHbEwR/vnXKxYqgMS5+hpscCzqtpdIcwKA=;
        b=nZYqLaX5BXCpimJ5YPSSNzwd7qXrNrxmBbj9qM4TK+XzEI8Rtbu7j4KODLUyfpvccK
         XVJAxKw6Z/8Cnmgm4mx+vkHBbqDp/BAMPbpfaQZsGb53qnxhK7le1nTsK1reaqFZAAC5
         c+3SSlVdGlF4w9o905ACadgpB0Cpat3FmP5taLwdFKHhtf8RQGmjrs4sDJp8ZK0TxcuR
         fDue5lLygKI81g/Ha7XxA6sCTNCCSHnhurRb4O0/KTRYmicKDLCCxpMGPyL+AhvF8CfR
         Xu3wzVEeQnejMG9aKdS6qBm3BJe0JDmFgo43q0IxkY0GNiROXX3TJoxEA0oljdEMw7OI
         g4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788881795; x=1789486595;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S8FzMS8SqyHbEwR/vnXKxYqgMS5+hpscCzqtpdIcwKA=;
        b=a7a8+98EFdJAgfxme1wDhF+YCRKgEkjWaVXvNsdW9ROgriZK7iO/8ytvLqD+szFVWN
         YWp6ewRzMzOb/VCVKTIY9S7OF0xrsOoElzMRkWM5jBCf1XlObMeB3GhxAlMqvaXoPFSq
         kM0WT7GJn2nYVVA14Gg4XMv96kETLllXdcwP9bDrl24dIVycUTSzIdm7MgZgYwwp+f5t
         njVamAimHAuk4Xiti8GquG4cE5EBXCLLr1dENKiK0X7tHnGyTroqI+pgMnptmI3fkSJg
         4/0eR/e0/XLsev3aLw92pgkfncmBTeWDcgrPlXRstP6eW5f5qn9ckvYrrEz7rQCuR/qe
         /64Q==
X-Forwarded-Encrypted: i=1; AKwUvBwmmCWRoXvhIh86NxylDnpmJmEsKjSadvc4fyl3te33NouS01sbUDawiaMqkyTsXjjRh9D+Cx4=@vger.kernel.org
X-Gm-Message-State: AFuF++n75J5YIpMRspnTS32jz4K1nuAavhM1uCTQ46Yk0DChfYDMIXtA
	lMa5eq4McHtJZXSAjfuC4KSU7Y3HZ356ZBGn75RrJL5ky47K4gbg14yjn0qUA1SAfhWGaYt3+W9
	sdlREaSm8GnhGvLAc3/tGPuWo1FeqKJk=
X-Gm-Gg: AYBFou2UvSQ/1itOUY3DlD9QDYgNtU8glDYgVN28nVq7IRfMNwV/pTtbsD6zfte5u8m
	ZZdRDJdrzZPE+6YZUyonmLihyhB70OzJwoLSBd/ESuk5gSHVwVYk0Q+NumIt7nZ58PQfgEIvzNL
	XybMjA+TB2sVbRDrgj7F7RQ0lhUDlwpEBCA0YF1SKBlkASDomiVN45wV7YdiZazam8I2Shh962q
	Cc5wQFtqmcMOI3CdNs5VU6yV4wASAOZYnYmACJ3hUFJgGEcSDeNC4H3F/BaNtVAVYdZL6zsuxHi
	t7P27irTVUynCbwxKhIkjI1Y1isZzPcLbvHZmiCntlowynzaFaWXkLxUp47UELUz4zJiIUIAnzf
	q4A==
X-Received: by 2002:a17:907:3f9c:b0:c25:c979:e76a with SMTP id
 a640c23a62f3a-c292b1dfb94mr62951066b.22.1788881794799; Tue, 08 Sep 2026
 08:36:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907192129.557377-2-bestswngs@gmail.com> <DL9COXZQXX4V.1FN45QO2Q77ZH@gmail.com>
In-Reply-To: <DL9COXZQXX4V.1FN45QO2Q77ZH@gmail.com>
From: Weiming Shi <bestswngs@gmail.com>
Date: Tue, 8 Sep 2026 23:35:58 +0800
X-Gm-Features: AcwNN1Xx6MilZKeliQoX9rpQOnWJ-qcSuSLe7P-XiShCEHYGUlHmCV_1KNJCP8E
Message-ID: <CANgPUi21BF7yAVGhb83sikiK96KE02X_JbVWL=OxXqWOc9uXbw@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: refresh seg6local SRH pointer after skb pull
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	co+adfca3e91be95776@bugs.sh, Xiang Mei <xmei5@asu.edu>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Alexei Starovoitov <alexei.starovoitov@gmail.com> =E4=BA=8E2026=E5=B9=B49=
=E6=9C=888=E6=97=A5=E5=91=A8=E4=BA=8C 04:02=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon Sep 7, 2026 at 12:21 PM PDT, Weiming Shi wrote:
> > An LWT_SEG6LOCAL program can invalidate its cached SRH with
> > bpf_lwt_seg6_adjust_srh() and then call bpf_skb_pull_data(). The latter
> > may reallocate skb->head, leaving the per-CPU SRH pointer dangling.
> > Post-program SRH validation then writes through that pointer.
> >
> > BUG: KASAN: slab-use-after-free in seg6_bpf_has_valid_srh (net/ipv6/seg=
6_local.c:1411)
> > Write of size 1
> >  seg6_bpf_has_valid_srh (net/ipv6/seg6_local.c:1411)
> >  input_action_end_bpf (net/ipv6/seg6_local.c:1463)
> >  seg6_local_input_core (net/ipv6/seg6_local.c:1630)
> >  seg6_local_input (net/ipv6/seg6_local.c:1639)
> >  lwtunnel_input (net/core/lwtunnel.c:466)
> >  ipv6_rcv (net/ipv6/ip6_input.c:351)
> >
> > Give LWT_SEG6LOCAL its own bpf_skb_pull_data() implementation. Save
> > the cached SRH offset before the skb operation and rebuild the pointer
> > from the current skb->data afterwards. Since pulling data can replace
> > storage but does not change packet layout, this preserves the identity
> > of the cached SRH even when multiple Routing Headers are present.
> >
> > Refresh the pointer even on error because __pskb_pull_tail() can replac=
e
> > the head before a later step fails. Preserve the pending hdrlen and val=
id
> > state so SRH validation semantics remain unchanged.
> >
> > Fixes: 004d4b274e2a ("ipv6: sr: Add seg6local action End.BPF")
> > Reported-by: co+adfca3e91be95776@bugs.sh
> > Closes: https://lore.kernel.org/all/GCy0KRM2IcQGoJQTjJEU9D0maBxXzEDHuQp=
q@bugs.sh/
> > Cc: stable@vger.kernel.org
> > Assisted-by: Claude:gpt-5
> > Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> > ---
> >  net/core/filter.c | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 61940e7535523..e61f9e9226b10 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -7162,6 +7162,32 @@ static const struct bpf_func_proto bpf_lwt_seg6_=
adjust_srh_proto =3D {
> >       .arg2_type      =3D ARG_ANYTHING,
> >       .arg3_type      =3D ARG_ANYTHING,
> >  };
> > +
> > +BPF_CALL_2(bpf_lwt_seg6_pull_data, struct sk_buff *, skb, u32, len)
> > +{
> > +     struct seg6_bpf_srh_state *srh_state =3D
> > +             this_cpu_ptr(&seg6_bpf_srh_states);
> > +     unsigned int srhoff;
> > +     int ret;
> > +
> > +     lockdep_assert_held(&srh_state->bh_lock);
> > +     if (!srh_state->srh)
> > +             return ____bpf_skb_pull_data(skb, len);
> > +
> > +     srhoff =3D (unsigned char *)srh_state->srh - skb->data;
> > +     ret =3D ____bpf_skb_pull_data(skb, len);
> > +     srh_state->srh =3D (struct ipv6_sr_hdr *)(skb->data + srhoff);
> > +
> > +     return ret;
> > +}
> > +
> > +static const struct bpf_func_proto bpf_lwt_seg6_pull_data_proto =3D {
> > +     .func           =3D bpf_lwt_seg6_pull_data,
> > +     .gpl_only       =3D false,
> > +     .ret_type       =3D RET_INTEGER,
> > +     .arg1_type      =3D ARG_PTR_TO_CTX,
> > +     .arg2_type      =3D ARG_ANYTHING,
> > +};
> >  #endif /* CONFIG_IPV6_SEG6_BPF */
> >
> >  #ifdef CONFIG_INET
> > @@ -9052,6 +9078,8 @@ lwt_seg6local_func_proto(enum bpf_func_id func_id=
, const struct bpf_prog *prog)
> >               return &bpf_lwt_seg6_action_proto;
> >       case BPF_FUNC_lwt_seg6_adjust_srh:
> >               return &bpf_lwt_seg6_adjust_srh_proto;
> > +     case BPF_FUNC_skb_pull_data:
> > +             return &bpf_lwt_seg6_pull_data_proto;
>
> Instead of adding new support that no one will use, just disallow this he=
lper from lwt_seg6.
>
> pw-bot: cr

Thanks for the review. I will incorporate your feedback and send v2.
