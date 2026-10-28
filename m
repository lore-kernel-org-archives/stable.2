Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793188496;
	b=Ayxaq5E2/mTewRTxnO03gC4D0BeUK4y1iFHifx2J72R2onu7ji7xzjET2N30HdrCsklZ
	 57Y6tfA2KFCAomU9qHVJRbr2DQtK6kYhkWI9TPT4sMXvdCOEXpgtJ5pTc13grh189D/aZ
	 +Hq0XZEvjWt8aD+w63aso0rWY1fDK+/W21XDzQzGDKPql3sEKsWzrDhJB00goQIyzD6UJ
	 NAsEFDo7wEXtOCNL6AX7MQ8s+N7UGkpR+i6wi4RgN2N0Go6uTPzxeoOZGTIYDMO1Vm7zr
	 otR+/dfW1AMUtxOOJQfMz25/leObLFXdl0R79QcVSq61Nli13mNjqCDHgESIxyMQ4wA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793188496;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=lx6Zbw4MgTbea9Oek/HKn7SBODwaBqEspj7Hz7Ai6x4=;
	b=q+aov67lkIkuPu4gdrK1aKs5+JU3iWQgqxpRy68SIj+YOhZnfLa/BnYNrhY84U5Lx56B
	 X6NdlAXxBZYLxixgNryYU/JsA8yjPw/FUUGKRXEIhxDcepSutfONPVYDBlIVz+LMRKAPN
	 IEwKjel2WXJwd8tfDR/PQcQDHN6pBxH+/wxHqkdHS9xny11lTauWzlWx0DAVXJtw41ASG
	 PHJZwH53CwotzV2eWb2VSFQjJLnF2Pj2BDTlxXUCpL2BOlX8BzQ/eZEBhkzXpIrWZflZ3
	 lUGrHjqZblf/DTv/51T8rnbl2WinvZlEc2KtAqOJi7gsEMEliiYUZktFhzb74Z6IXvA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=GepBUTsu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4B7606A31E
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 11:54:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D4B7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=GepBUTsu
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a0880a46e7so449004b3a.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 04:54:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793188496; cv=none;
        d=google.com; s=arc-20260327;
        b=VfCjYzgIG6a1wsapN7Plv7KFvreU60PTUGje4VsAg8/8WNg73TyDbCioEoO1QBRpIx
         IEocb5kbjHJjpLuaWTkixk33bUGW59EZ2QVGqv0+9Pg92oYCVW3mU0BN+qvBDXRmLoi1
         EgeIm7JL0fGw/plevFroFKLBlXNd/xxxE85c/cODT/C1KUuVDkh6jFhvQU1yPCDjS5WC
         hwrCzmyHYwwKsbscRybz9x/+P18eyVrNCI4/nBHk/5o3Auf80lZ1jnaN6mbBfa3lFwzX
         M9JJWV8mIMMhI1tZszyNS/5Zfvcb5tkX2FUvGgMQY5mjUZ9XJ+cib8fH5eAcjjuuSPl3
         pHdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lx6Zbw4MgTbea9Oek/HKn7SBODwaBqEspj7Hz7Ai6x4=;
        fh=veF3zsBGGHwyhB0+yXgQjJJvzLeDZBhpPuzOgQ0GmSY=;
        b=Rs+1DGJYZvYDSR000sJfOJ8JU7SmfOGszKKdEL+emkUmHq7MKBGizFDmoTKweaNRfp
         y1FFnmWDDS0B7lBcEnaMBjxJlKKEom8yhSkR3ks0FXnumWReuxfAX9KBnte25yTuN/4W
         ZPC7r88twov2Qonapeky3vO3LcNVa6pCOz35uUE6Z3VXbuInxZ1+/Bi/EsrP5DEN3WtN
         6s/aFFRNuDJorqb2A1doW4W3E/mrv+6pDeU427JQfb/jBSjfsUDgu5Hu2/CmHxVJmZDh
         k1FWt7coZ8AVWMr7pD0ox3NSEt78Sctic8PmkAjOVSVqf0xNw5EI9ZJe6jpMaW0A+oYR
         o5ng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793188496; x=1793793296; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lx6Zbw4MgTbea9Oek/HKn7SBODwaBqEspj7Hz7Ai6x4=;
        b=GepBUTsumw8B4jf7+5KsVIfO5khMkRoPJ6+MFUMalfeb4q/FoMETrLQTAanFOOmnMz
         Pqa8pZ4flYMTlyMDol2VB4cEXZ3yBtiPuZpBMkpM/MRee6V9hj6Vzn++AjQh7Yn9u5VU
         8B6nCqi2CkM96kUhqxa5KQ9foXclVftX4roG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793188496; x=1793793296;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lx6Zbw4MgTbea9Oek/HKn7SBODwaBqEspj7Hz7Ai6x4=;
        b=x9KKyWC1rLttwheKLyrQcTQEUMr/E/HmHVB4ovHkLAdXb48IQWTCsv2cqn+8ZOdeD/
         yiPEHCL+mLtxpJiyplczGMZ8F6crmaxndVsS4KhPCwIlQFa7twr3aVAUmRs7bzRRgXZG
         Y+TjMR80sIMi1Rn3TRW52rIHvA8fCg3cZjqaMZnJBOQN1SkQRMotqzRlYmwBLDMZtxjN
         Sa45cAcHEHGw7z5CZIrg1v4Qt9NgejTrLrW5Ub4Zu3dPKBZKqPwdGCAgag5V5V9H7b9c
         WkpKuicBYM/jL3hZzcElRZihlnYUtHjFcj3jnkfSPnioLw43Ub3T0BjLsJiCE6UE156L
         eX8Q==
X-Forwarded-Encrypted: i=1; AKwUvByyVQ4ZSCMaDJrsn3a/AWUv6KUQlE3ltgAY2pbmMLrU0urP+8g5FTAr46yKxWbaXuGrlHH/poY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLdmkYNUwbhG9CvcbNyV39UuUgj6EDVrTOG8srD6HkxqKw05nB1
	F66a0SpfOSewP2BIX44+OMJj2d6ohDGrVAN7woZ17rKtaqM9fWjC2+LkZo+f7Fs7o2BKJy40UQK
	+GnZ8XjUGm0tUCmKD1VvH4YHs6SMVdi5RCrs06tT7
X-Gm-Gg: AYBFou12atVS6evRoBdqa7RJUqzk6QQ8rok1pDSM/vF1b8GS7kbymSAqojZx/WMagy2
	/nf8oFRWXzr4oJm1vDf7qNXu2LqZ/wR6zRHXst8rPSanJdzXbAPXHVqZyC1m9o/9lkVM/YAe/IV
	slvhT9LBsmpZT1fEFRBEGRHYbVyxaAObyQt4TodovquyGfAU4KlIX1Wchyq+UDwXPWwYHX9JPQ4
	AFws4KE1ipgb3YvnUzTjkZDnSEv3Kj0U82SYREHTBSLJtHgGg0IJoNeaIUuitBkIugl0urO5FbF
	xu9WknPR00TEBwwFgLuoDHOEQ9rzcEpduV7sHmhmv2+P2xSFzN5t0DsgidCK1aUSOZdj7lxJxCU
	WTfSvLq+epMSutpE15JislkXLk6Z1vv0fSb7MlD/BZRiCq6KatudB05XvggqRkW2htuAk2ETFqB
	hxlWOGXu6Yoo2VgxA=
X-Received: by 2002:a05:6a00:298d:b0:8a0:4e73:7e1e with SMTP id
 d2e1a72fcca58-8a5a61d5a21mr3166982b3a.44.1793188495937; Wed, 28 Oct 2026
 04:54:55 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <bpf_redirect_neigh_short_linear.v1.r0.20261028033717-1@mojatatu.com>
In-Reply-To: <bpf_redirect_neigh_short_linear.v1.r0.20261028033717-1@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 28 Oct 2026 07:54:42 -0400
X-Gm-Features: AclHuK8FFpZ2c_Jj5uxJu1FiuE7Oufyw0mcohrzYGLVHSyYoRc0o8GsFlrm80gs
Message-ID: <CAM0EoMnuCin5C_ZJa2Mx+VT9CFSEznG-9hWjkBz7=Ntwi-AUxA@mail.gmail.com>
Subject: Re: [PATCH net] bpf: Fix skb_pull() BUG in __bpf_redirect_neigh()
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@kernel.org>, bpf@vger.kernel.org, stable@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, David Ahern <dsahern@gmail.com>, 
	Martin KaFai Lau <kafai@fb.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 5:19=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> The issue:
> This is a follow-up to the short link-layer header fixes[Link].  After
> vlan pop_eth, a privileged SCHED_ACT BPF program can call
> bpf_skb_change_head(skb, 1, 0) and then bpf_redirect_neigh().
>
> __bpf_redirect_neigh() calls skb_pull(skb, sizeof(*ethh)) after checking
> only that mac_header < network_header.  It does not check that the MAC
> header is long enough or that it is linear.
>
> A SCHED_ACT BPF program can do:
>
>     bpf_skb_change_head(skb, 1, 0);
>     bpf_redirect_neigh(lo, NULL, 0, 0);
>
> after vlan pop_eth.  The skb then has mac_len =3D=3D 1 and only one byte =
of
> linear data; skb_pull(ETH_HLEN) trips the skb->len < skb->data_len BUG in
> __skb_pull():
>
>     kernel BUG at include/linux/skbuff.h:2839
>     RIP: skb_pull+0xc5/0x100
>     Call Trace: skb_do_redirect -> ...
>
> The Fix:
> Drop skbs whose MAC header is shorter than ETH_HLEN, and use
> pskb_may_pull() to ensure the Ethernet header is linear before reading or
> pulling it.  Re-read ethh after pskb_may_pull(), which may reallocate
> skb->head.
>

pw-bot: cr


cheers,
jamal

> Fixes: b4ab31414970 ("bpf: Add redirect_neigh helper as redirect drop-in"=
)
> Link: https://lore.kernel.org/netdev/20261027082604.1485903-1-edumazet@ke=
rnel.org/
> Cc: stable@vger.kernel.org
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
>  net/core/filter.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 70dc621672f2..4d344ec09736 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2432,10 +2432,14 @@ static int __bpf_redirect_neigh_v4(struct sk_buff=
 *skb, struct net_device *dev,
>  static int __bpf_redirect_neigh(struct sk_buff *skb, struct net_device *=
dev,
>                                 struct bpf_nh_params *nh)
>  {
> -       struct ethhdr *ethh =3D eth_hdr(skb);
> +       struct ethhdr *ethh;
>
>         if (unlikely(skb->mac_header >=3D skb->network_header))
>                 goto out;
> +       if (unlikely(skb->mac_len < ETH_HLEN ||
> +                    !pskb_may_pull(skb, ETH_HLEN)))
> +               goto out;
> +       ethh =3D eth_hdr(skb);
>         bpf_push_mac_rcsum(skb);
>         if (is_multicast_ether_addr(ethh->h_dest))
>                 goto out;
> --
> 2.43.0
>
