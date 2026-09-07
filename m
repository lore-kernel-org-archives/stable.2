Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B86E51D523
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 20:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788811331; cv=none; b=nq4rtH0bV2OxGflvBo/wPzyYS2w0N4I7Zy8GQoTTGJWnGY11kROc6XMH3mferRJsRqedyPLdp0MfjMINYnOp6Vg5Shkn3zfEoDZsLPC/C5niprryc7UKHmBwaw6BeoFNoEwGZYwsPf8Y6S6xkqrpx5G3JHL9dO4F2Szin6nOI6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788811331; c=relaxed/simple;
	bh=32e5Hq42eMbENhVQyuKVR9aB0aAxBUGCy1TPX6J6la8=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=cifnan2Z1aPuzAPg5/ycoH7HEvUXZqlHqYySVNr+Tc3inI+mmRNiUn/XWbBCsM8EiPTvM/BBQ53QjyJV2KwjJxGOQjfUsGp4rI9l1qEkyCicKAGeqTNx4kSNVdpuUhiQ2R5HDGS6InWWrl0p7ESffhC5jvbSI/xvw3kYChCvHFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ipkxgOAr; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipkxgOAr"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-46aef784ddcso1389878fac.2
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 13:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788811328; x=1789416128; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ngem6m2yG08mHgsLH9JWCZ0vrxKdp0QjFmiqcsYBtQw=;
        b=ipkxgOAr9TbDmqsS8Fc4B6E5afu20lBK6c+fnOnm1l2JUdgsKjLHTY31mA7j6sw3Dc
         9FhTFwfoZFwtqveB6OaamYtAeXx59vw5PGXezaqfxc+iwDmxP2IEY7mCBl+q/lqP8njf
         mDV3NbNcA2I3tC01Sq5cLKRmZnbOCdlytBVhf9SrOKRSbqZXxo74hH2pGl7sbeCAuaSS
         tDpcfbXd3C6xRtq+K6svHQ/9GK5b2qYshJ7e4y+e4Xa4dtz32Qq2GKOvJURMloytJnjc
         LaNwbf0uCnem/HLWQukQeYzUPF5zcs6l/Zupgu7XWQ88/G9K6Ddiw/Lofs49H4Y0Atx3
         ksIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788811328; x=1789416128;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ngem6m2yG08mHgsLH9JWCZ0vrxKdp0QjFmiqcsYBtQw=;
        b=fvcmTNG0OMih5B4jIhhxBKL5qTTn5LNHprwe4g2g00sqLZsTScMTM/zdg+2Tpqzwby
         IjwjFM42jFa21eZoAeVhGihJpnHDz6QHnl6LsjVz6Y9bDVAMdJj6ZpD2lmARLRD4peEV
         MIJWoU6AMA2KYrY5+C2uWq/2rQWe8or+s93yRqgYSBYBZrTrzPM9q0myx0q7QvcRmR8T
         wcTNWg8+woFE5KH98CUyflCl8x/TzxSoD2qcoYw+Ubj9z77jAcuk81p+UZnpOv9LqVt4
         Vb60Ai6C0SkCHiVXsk86rMZebu8BB4eiUSDVAo1uXk14Rsm/lrCdK5iPcjNPCmnuIUlB
         Zb5w==
X-Forwarded-Encrypted: i=1; AKwUvBx/bDh/8yuThsY2Bhu/vhJ3JxN4Mtz+IFhHt17zTqtA2nB0G40cKJZLERsLe+FGR8keqHS9jvw=@vger.kernel.org
X-Gm-Message-State: AFuF++mJncQr9QxcdZOB/4T+eQbwJpG1mj4IZTghbGOcWYfyzKaD+auO
	8GUvLhj82meOtqjrMUhvgC5Xfh/S1XWM2JHXGN+LwU9xMqePkdBNU6cC
X-Gm-Gg: AYBFou0aIVhEllFei1tU+v4R7WVFzYO5pkC+m9wk+PcKQRuLC5TcT5vEmgWF4Fg+Vsu
	159aCDIEEhgz1wrzDBF1vr8XqOGiV/o905H5tWAibIiewLxyjR2OihG+FeX50iEtOPskQfELeu6
	xrVFjC0SG2V6YAsz/lPrMto0awgVQLqCEfL0Uph53ijhLqFlIRY6rRd7byMXYp4HVjWWIxEksSS
	5BkJ844l+L8sRpOGvxecf2oEsOC1pnqM88eAzEsmBT3WE/bdUFXhAggFco15sXh6VaUO9lMlo+8
	Vu0SlggEnvF0Vvt+syBmLc06EXQ8fesHP1fKS2iLIzC1ent8/zTt+cMQgFX8/5r/u+wdjNOLLX5
	w5QmGYeOlMCBkyiBpcWTmFcdKjl4bIw3/KWSZDSlk0S0+XgVSOk9hR74EqWtV3z66GK1nUWN0n8
	A0w+tvRQtejO+sb6JMlp2Zousno/arO86o7pqqMijDadzgIrwGXGFPA9gM2ELlgbQnCc6YlyCXs
	1a3YzbaQoNoeVC/xHIbL5HzQ3nUnEJW30VIJKrSRV8gHO4WHllOj+A=
X-Received: by 2002:a05:6871:6315:b0:447:4fc:1da1 with SMTP id 586e51a60fabf-475526ec139mr16680060fac.12.1788811327749;
        Mon, 07 Sep 2026 13:02:07 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:1e::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-476ed51dd64sm7220292fac.18.2026.09.07.13.02.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 13:02:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 07 Sep 2026 13:02:04 -0700
Message-Id: <DL9COXZQXX4V.1FN45QO2Q77ZH@gmail.com>
To: "Weiming Shi" <bestswngs@gmail.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "John Fastabend" <john.fastabend@gmail.com>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Alexei Starovoitov" <ast@kernel.org>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>
Cc: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <co+adfca3e91be95776@bugs.sh>, "Xiang Mei"
 <xmei5@asu.edu>, <stable@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf: refresh seg6local SRH pointer after skb pull
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc
References: <20260907192129.557377-2-bestswngs@gmail.com>
In-Reply-To: <20260907192129.557377-2-bestswngs@gmail.com>

On Mon Sep 7, 2026 at 12:21 PM PDT, Weiming Shi wrote:
> An LWT_SEG6LOCAL program can invalidate its cached SRH with
> bpf_lwt_seg6_adjust_srh() and then call bpf_skb_pull_data(). The latter
> may reallocate skb->head, leaving the per-CPU SRH pointer dangling.
> Post-program SRH validation then writes through that pointer.
>
> BUG: KASAN: slab-use-after-free in seg6_bpf_has_valid_srh (net/ipv6/seg6_=
local.c:1411)
> Write of size 1
>  seg6_bpf_has_valid_srh (net/ipv6/seg6_local.c:1411)
>  input_action_end_bpf (net/ipv6/seg6_local.c:1463)
>  seg6_local_input_core (net/ipv6/seg6_local.c:1630)
>  seg6_local_input (net/ipv6/seg6_local.c:1639)
>  lwtunnel_input (net/core/lwtunnel.c:466)
>  ipv6_rcv (net/ipv6/ip6_input.c:351)
>
> Give LWT_SEG6LOCAL its own bpf_skb_pull_data() implementation. Save
> the cached SRH offset before the skb operation and rebuild the pointer
> from the current skb->data afterwards. Since pulling data can replace
> storage but does not change packet layout, this preserves the identity
> of the cached SRH even when multiple Routing Headers are present.
>
> Refresh the pointer even on error because __pskb_pull_tail() can replace
> the head before a later step fails. Preserve the pending hdrlen and valid
> state so SRH validation semantics remain unchanged.
>
> Fixes: 004d4b274e2a ("ipv6: sr: Add seg6local action End.BPF")
> Reported-by: co+adfca3e91be95776@bugs.sh
> Closes: https://lore.kernel.org/all/GCy0KRM2IcQGoJQTjJEU9D0maBxXzEDHuQpq@=
bugs.sh/
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:gpt-5
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>  net/core/filter.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 61940e7535523..e61f9e9226b10 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -7162,6 +7162,32 @@ static const struct bpf_func_proto bpf_lwt_seg6_ad=
just_srh_proto =3D {
>  	.arg2_type	=3D ARG_ANYTHING,
>  	.arg3_type	=3D ARG_ANYTHING,
>  };
> +
> +BPF_CALL_2(bpf_lwt_seg6_pull_data, struct sk_buff *, skb, u32, len)
> +{
> +	struct seg6_bpf_srh_state *srh_state =3D
> +		this_cpu_ptr(&seg6_bpf_srh_states);
> +	unsigned int srhoff;
> +	int ret;
> +
> +	lockdep_assert_held(&srh_state->bh_lock);
> +	if (!srh_state->srh)
> +		return ____bpf_skb_pull_data(skb, len);
> +
> +	srhoff =3D (unsigned char *)srh_state->srh - skb->data;
> +	ret =3D ____bpf_skb_pull_data(skb, len);
> +	srh_state->srh =3D (struct ipv6_sr_hdr *)(skb->data + srhoff);
> +
> +	return ret;
> +}
> +
> +static const struct bpf_func_proto bpf_lwt_seg6_pull_data_proto =3D {
> +	.func		=3D bpf_lwt_seg6_pull_data,
> +	.gpl_only	=3D false,
> +	.ret_type	=3D RET_INTEGER,
> +	.arg1_type	=3D ARG_PTR_TO_CTX,
> +	.arg2_type	=3D ARG_ANYTHING,
> +};
>  #endif /* CONFIG_IPV6_SEG6_BPF */
> =20
>  #ifdef CONFIG_INET
> @@ -9052,6 +9078,8 @@ lwt_seg6local_func_proto(enum bpf_func_id func_id, =
const struct bpf_prog *prog)
>  		return &bpf_lwt_seg6_action_proto;
>  	case BPF_FUNC_lwt_seg6_adjust_srh:
>  		return &bpf_lwt_seg6_adjust_srh_proto;
> +	case BPF_FUNC_skb_pull_data:
> +		return &bpf_lwt_seg6_pull_data_proto;

Instead of adding new support that no one will use, just disallow this help=
er from lwt_seg6.

pw-bot: cr
