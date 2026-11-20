Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795212909;
	b=wWu53PzbG6F/S1xVFhkQgYCK5swIfJxrjvvHIvUHKL9Y6ujWF6kmB6TKMty+qsmvNyXN
	 GW4UVzQUNr0pM0Ncr7GPQNBDDU7qC5wqUtA/crXvLqruU6LA6MoMdguRU70jNFwmRWRbc
	 76jJusf+YbAUDPqAIe9wG2zkfOMeGMtPl8X8cb8V15CR5AACx18rcnsg4qHMPsFqhbQ9T
	 xm7wuDwpu8+D1C5TQPnNkZcDgfQXHBtU+Tt4LgFIDEO2tPBvVVzAa41vhE7y4208UxkL4
	 yUrVoSygeihMUqk3Sgig7/H8IlC30eCctThU/oWD6ytg0VqaNg5W+c3pAEJxqqKtuHw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795212909;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=S8E5/bKsqcml1NiDKuxtkXF2hepTan04xWFr5FhLnOc=;
	b=Ca5yYBK4T2ULFjEiqTvvBneI7HA9L/AOIzBvxDZRUGv4GpvVVDlsrY6w7sHu7CLAxmXL
	 N8kYZPXQYXNxrwnUmXaz5zA1/Do/8DQOhFeBUxIcOfNrZy4ZrKxvHemFBaSX7Pdgwpww4
	 MxLt/XSv4LOCkqWhMgjLmVvJB69imel0fjMsHUoG3X2UC8tmS7S2RHVW9aJfT59uu9rBk
	 nxRdQoAW1h8708C1LJV3lfziIGTmjUvqFo0JA1eyqpOX1U4rSj8Q+Gz9PVEc1+fnqfy3k
	 FUAoWmFSZ70sVv5xOZwW3eSzlK4o7g9x1kRivn6QI2EqCDMWC4+AkB7N4f8npwolBjA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l3SOdlg4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.42
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C70606A6BD
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 22:15:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4C70606A6BD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l3SOdlg4
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-70059e4dab6so851053eaf.3
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 14:15:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795212902; cv=none;
        d=google.com; s=arc-20260327;
        b=BY9ySfY5m+Dnb7dUDB+600lV9JU/nAw4KHvpoQPu8c8C+kvfM6H3wP0Ms967mD/L2O
         t03MH6NhQlXL8meYVB3PjsPNCcfMP0lUxXqLX6GrHfSfCskuUoyH3N8iaTD1dNT3jaNd
         ZexqoVonIdpUxalUPPOXICZGilKWI6QhIHfEOAWdQsf06d6rT8rFJGUlCQx2a3r5Cdom
         Bsaw64LqWImBB1YHtvIZ+HtS/yyEmHJH1z8w53CcHi2FDiSH79fcky3/JhDNxRPKopJn
         D9dMXbPDGRa1b5gh2u0uZevUwsvZ1DnORD9m7K5GiztKWsRnnP/jV6JKAeh812o1zyqM
         y43Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S8E5/bKsqcml1NiDKuxtkXF2hepTan04xWFr5FhLnOc=;
        fh=BSzLFvZovQxYGkl6hMT1Tf0xAmy3LEVRw1WpJVXPELk=;
        b=h6nKW35YmfsZcwFN9Y0378XYa2sg5/eorAoiQHD5rvR3W1Vqbu3KsA6wmuP36FJOUi
         tGLWaCBDQSnyoI0GIL0XP/Eoj4dQi/V2t8NoELejY4S5zS5wdXThNX28MMBwgbxbv5Bb
         u4xIfwHls1UZ/RgCOBl+AAfP+XEdryUw3NR+gprkhTyusyyGUEC2G0rb4WaVcmRUr/Q+
         ZdlMU2D+vpvLff5YSFuOonIaAz2pBm0NIOgEYkxeTfqNpanF943hw0WuxaBP4Thde4kZ
         Uy3i8JP3CpWt9rY2bXgU6rkDTxrV5WtKl0P79kKKicfjSnKWlCr+/VzZOgEoeJ8O/ZJz
         mkdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795212902; x=1795817702; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S8E5/bKsqcml1NiDKuxtkXF2hepTan04xWFr5FhLnOc=;
        b=l3SOdlg42qbKIlI9+Ac4MBHXRldrvquCDkj/z4faFkQvuVq4q6ueXT7hGjf1x2DZ6J
         xr0kGpYWy6XzLMIYfaRXYEt32hzwIUIh5GcDjS5qMo+NTm/W2h4QLrWT0vjrrNJqAY/V
         DaHg/hTmuXLf/SbZgeXG7LYeRhLX6xEIsHTO6045XjdtPDKJm9dClJoHuo7IikmLqZyI
         LHip8V4qxMZCOM5nMYFwgXFSqKhOQGq15asHuhcCUR+1HQYSdRVD1FRKEvvrmiwEApWn
         r/Lj6QL4JWoSFYjlCjmkEgRPT9oWf0bS7UiyNNPJvMB1PL+uXio1JWvcqawJCFSR4NEc
         ME/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795212902; x=1795817702;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S8E5/bKsqcml1NiDKuxtkXF2hepTan04xWFr5FhLnOc=;
        b=LfvUrVQNOHMqJq3SXn377edugWjMuPsuhKi6guQmg9E1NjiqMiHTGzcb+8LHgF91hx
         jHkM3LJ6mHNyKErCZLKxUNUsJx+GJ9xDWBldvFLvSWv8j6BktJZIffa9IgVuyooYD/UM
         AmOUjpcy8qdtsdWhR4+JUICoQD/pPkX8SWue8NRrMpyrjnZWIzLkVpJmU8k4lxD+AdJY
         cOTSd/tst7sgP78oHRfXKjCnwO7DL+ntxSZ9iVBq3T0Z4RiYuZAvSaaNEZCBCtRxdMKE
         8sHgYQC/8e9gNeOdHrifKqxKxjkyrJPa4EQfi9dQGilELpSTyOqwj4RpOQPCYMMid/7n
         tCJA==
X-Forwarded-Encrypted: i=1; AL+hErFeKPk13z63uXLchZt01CxqxF8fdVGEpB3ogNnNNbgp/KYWgPqlvOnZVxqAen8N1WQVh//KljU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+oe2/I2uR8bVHBU+jNPTZTs/sCGOMzCbPKctiP/JK+/qnvQwXL
	NOOB2CyGig1a9yXe1ZRl4dmnnC8LcZxWh8w1P+ardBJYrKVUEIdSrQgrTFwnzmryyJhzgElYFE3
	FbJQtajpGVZDfacnD2MdWmMeUUuZ8c0w=
X-Gm-Gg: AYBFou2MH5dtfOp4zb81pe4ktAe0a/HhhJJP4tIU9KOnR3E0/LyKyDu4TNPiFTQJzpx
	w66x77va8HWXVpWl5/8GrSZRa0vSIo7fffKe5m7ghQo+Uc4D24MmKj8/DqmFL5k2o2sLGPLbW6i
	j45DRIJnTOz89wwQIA/SPbctKUzbCYO5OofsHDT0U28jz4C5o7tqx3d15v0RqRqkybVuSiM4KvA
	MmPcDpDd5vVSDq8VGVuHaWkgyeJOIGyGLrZb9VFYFb6yQ5Wt97go2crtW0A1zKwXN/17bTsh/q/
	OdJkUA8FtU7YffwfRemgAuB6UbevpdBSMFswBUHwqijgdaCQT+hBZxeP4IHhJHHqwMw8FByRNet
	Yen51/6La7FdHbITE9vdN0yfxpGCX3jAi7sXH
X-Received: by 2002:a05:6820:4615:b0:6f8:8385:52a with SMTP id
 006d021491bc7-71b395ac078mr3579653eaf.58.1795212902477; Fri, 20 Nov 2026
 14:15:02 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CORE-5IQX.v1.r0.20261120050801-1@mojatatu.com>
In-Reply-To: <CORE-5IQX.v1.r0.20261120050801-1@mojatatu.com>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Fri, 20 Nov 2026 14:14:24 -0800
X-Gm-Features: Aa3M54rA3AVclKtpTsDBdZrwTvIcM9OP1ypUCaxAnAe_aZyVGm-fhga0xkyXQgY
Message-ID: <CAHsH6Gt7RkR1kKXQaQUdz-_8VYXfW7NcwPxNtzwaHtBYWgRuqA@mail.gmail.com>
Subject: Re: [PATCH net] net: xfrm: interface: restore dst_orig on every xfrm interface
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, ipsec@lists.linux.dev, 
	bpf@vger.kernel.org, stable@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 20, 2026 at 6:09=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> Found while auditing the xfrm metadata consumers of a steered packet. One
> of them is an xfrm interface, which restores the original route before th=
e
> xfrm lookup; the swap warned on the metadata dst still installed in the
> skb, and only the collect_md arm restored the route at all.
>
> The issue:
> An xfrm interface takes the if_id and the underlying device either from i=
ts
> configuration or, in collect_md mode, from the xfrm metadata on the skb.
> When that metadata also carries the route the packet arrived through,
> xfrmi_xmit2() puts the route back on the skb, because the xfrm lookup tak=
es
> the address family from it. skb_dst_set() expects the dst slot to be empt=
y
> for a reference counted dst and warns when it is not, so the route landed
> over a metadata dst that was still there; a kernel built with
> CONFIG_DEBUG_NET=3Dy panics on the first packet that takes this path when
> panic_on_warn is set.
>
> Two more defects sit in the same place. An interface with a configured
> if_id never restores the route: it takes the metadata dst as it is, whose
> address family is AF_UNSPEC, so the lookup finds no policy and the packet
> is dropped as a link failure instead of being transformed. And the restor=
e
> moved the route out of the metadata dst, which a clone of the skb shares,
> so the clone that reached the interface first left the original packet wi=
th
> nothing to restore.
>
> The same slot overwrite is in the unstable helper a tc-bpf program uses t=
o
> attach that metadata: bpf_skb_set_xfrm_info() records the route as dst_or=
ig
> and installs a per-cpu metadata dst over it. The per-cpu dst is shared by
> every invocation of the program, so the restore cannot keep anything in i=
t.
>
> The Fix:
> Restore dst_orig in both arms of xfrmi_xmit2(), taking a reference with
> dst_clone() so the metadata dst keeps its own, and empty the counted slot
> with skb_dst_drop() before the route is installed. The helper allocates a
> metadata dst per skb instead of a per-cpu one, so the route it records
> belongs to that skb and is released with it; the per-cpu allocation is no
> longer used and goes away.
>
> Conditions to recreate the bug:
> A tc-bpf program that records the route as dst_orig with
> bpf_skb_set_xfrm_info() is self-contained: the overwrite is in the helper=
,
> so the first packet that calls it panics inside bpf_skb_set_xfrm_info() o=
n
> a CONFIG_DEBUG_NET=3Dy build with panic_on_warn=3D1.
>
> An interface with a configured if_id shows its own defect without any
> other patch: it drops the packet as a link failure without consulting the
> outbound policy. And a clone made after the metadata was attached consume=
s
> the route before the original packet arrives.

Thank you for the fix!

Reviewed-by: Eyal Birger <eyal.birger@gmail.com>
