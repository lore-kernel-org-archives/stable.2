Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.210.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793453540;
	b=nV3MdtAfvluAT3V+Be/QDgETJZ0BsMcrtaAGHcxJP/HAwaNSmy8NkAkwLyrcoLuZMNaa
	 B6Usn6kSX+BVVjnw6letTITRiU+1LDeJck4+IPeFpXo0GNGaIHSHc1JGWkeLCr2JZ31gF
	 84aPYU3TC89NaaYgTuw0yr6d5YgZluVHcVAZc09HQAKGYzorKvHDJl7393yZv5n9xQaRo
	 97T1OZunKuXCDchMOk74GKNm3caDhcnEO2pV6dBJ8AQBeWmYdRkgVnuNQyt9SkxZNyzm5
	 8KigLTOgoW4LngTTcXx7/L655n2t5/2zM3Ewy8NkLgO8BpusrIqPJOUIW3Zjr5fovGA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793453540;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=QrhJINBYjJTT5louKFAwSUTUsf/5n1vYlK1qTtlzMCY=;
	b=ofz5aBg/qZcvzHsitLAc4/7q6x8qbYAb8HdSsEI1MEFGUqsqoBniCsM5MY34/Q0bpU75
	 Xltw+CRFzu0WJyAkPt9gNPCBZFPqHiyrWzt+stdzqrpG/L6FJKhRxo0JNBpjz1GZvmZpK
	 4/undfpQz4FsbZTT52FNAZDIAUMeycjUclPhwtu9R3SK5bkYBlVKRAGycn/xVjLuDM/aE
	 6bl+v7EbhKF4ohdH0C9sBzVLYFp8magE7KE6psPMKojgHdwIRJMafs0eOP5Vjvqr7mPmq
	 yNWQbqmAmSrVE1BsA8K3RbF5sOzqR2kZMclrPWThPDw9EvyCeiKi2vJ28GNrWhJWYYQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=XKnOjMRP;
	arc=fail smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF33606A31D
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 13:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FF33606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=XKnOjMRP
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8a07078200fso668429b3a.2
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 06:32:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793453538; cv=none;
        d=google.com; s=arc-20260327;
        b=lmNxdhBUsB9gwbmntrN4aJZ4I30yDaRVzSq38KO/xY4pjfO6p3K7guq3SvNB1fAAvE
         JD5fMz+4hMw90sSlqX9Kdw2BatTtdyCSC/4keODMYO4pjEdR/hDVAXuR8K7W2Jo9Ku4y
         DvU17KkIFxOltJdMi7ZMY98rtBO71fZswu562w//ksBZq/i2jGRaGBFCXYTmYfzS/eol
         iNcbdWmMT/WejYF2F11ATnlncooXVR14oTbhGjpSIAibtRjzz4d3i8x0wueFC53DZ8p4
         SkHLzV9ORIrkD/NL3OHeHkxNlnYL7s62rvLm1M1mfW030Nz54DUo9lDjhuY1k54vnPLW
         RWZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QrhJINBYjJTT5louKFAwSUTUsf/5n1vYlK1qTtlzMCY=;
        fh=6kw9Le1ORvEk46KKQUS6MpVvnANfKTZ5nbepd6MZQzE=;
        b=ZW6MyQ1jxqlw2308IJrm5yVtSgzKXKiWGIeuI1tinWJ/KPgVbtYJE87rabbV5YzQXV
         ydy7ciS14850koXRJs9LTtPppdHgH+CWrq80jhTTSgXwBWAFcQUAny9dO6oDdu1JHMCs
         56iml+czGA03f+LmoR8JX2u+FkpxACdCsYmKM8FImj1XRZABEGdKUAED6hj2y3PNr6Hb
         Md7NN7fmj6+xPWU5AE0QG7orGyJiIbF1ShRkjxi5qE8croEBLI5QFI+pWXiHDMWwxhJ2
         ho85XCnhvgl9dUxclZl7LGTmwnEHyV35oXmj5Dg/2I6BBB+vB6UbBjHg/O8p7qqOSkXg
         8IzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793453538; x=1794058338; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QrhJINBYjJTT5louKFAwSUTUsf/5n1vYlK1qTtlzMCY=;
        b=XKnOjMRPi1xowFEnisIR1z4LU2wkmPn460uIbnYFo262VHWeQFoTh/HoQdkw60dc1a
         1zdDrd+OqzuW41lm62mCj7dcoHFjgW2MOlHyj83i9lgrOZCcxL6XKUo55Ov0N0HUDQ5d
         EdoSbP9yfU2qWOluiS20Xn3hWPcx7/ZppJ26A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793453538; x=1794058338;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QrhJINBYjJTT5louKFAwSUTUsf/5n1vYlK1qTtlzMCY=;
        b=FTJpQ/mzAdulh/DFzgKZQFjqVLyveaZAiKw+1WYqrdx4wc6AjlxqUIGS09cFz3gWng
         G+WdS5RsTumvseMcV3gIv+L+Z8MSdXwZwZzoiNn5srAKHjCZ1Dni7oidYQ9N8W+yUOEP
         FSHXcwbokW01kFfdE2mJGsO9drvsSI32ovLO1DtP1Sg3FUHZ3Gy3oUrP0WJXrmO+ScLw
         Drb59FJp9VUcjEbkP6BS4dTwmXnAzs7ZRcJw/4/Z4SxyvPSVXSeBvVPXJUHkaJp0EmnY
         UtkNJh2QNB9GIUQhL7oJk8UTlAJz410i8TcxSBQKxTc5sjlZ5Q7YJq8FhlkZ6fIBJ8bu
         1srQ==
X-Forwarded-Encrypted: i=1; AKwUvBxCVf2Ar1lVN5B5ZyQcU/VuP5B3kMFF6LsjY0vgVrihTkc5FCJAAls9IPLxsNdy3QPOe/YBKtA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIsKYsT9aCy3w2++KWCuLtsP3PTMCFflj/3W8Ujd0dtibh8J1Gu
	5TISpKPMhMyH2iNEmu3yajyQoHW8TzliHdiMGMVMK4I0f2GiV1dfCKVwgBsn2jS0+FkRbNnxhdk
	O+M8BZ3kTaQKAgILf/luP8y4oimWAL47JENYuOeH6
X-Gm-Gg: AYBFou0m5vUCRNUgp78xrrsL+rcQuLPlAuUMpjnOBEmYvmYvh14j8tWRPPLz7Fn5CTp
	7h3QwkJ+3lPYQR782Ef17yjiujhnm0h3il3JqZYcrg6IMAXT283iEFgGmqXoty5cMWSa6IywTDf
	8q0KFtXy/Egl96KHXYt9uWf0J91Inj2Ii/xjzMs6+UVqiWPTi8FgY3V/uvSF4/7eB6Bi5p4lFyy
	F65xZI1ZYSe2BHK2td/xlVfm6BXntOIVcsAIV4XdkcfVCxq3ZGShiyHyR6/27TVJWE5/XgIVOBc
	6J0vXJeMy6jHK4h9dfkT57V1PjKJ62UpGPZRKksUYEBkjl3kD8hruNP3kHSKdKTHNI9kenBXel2
	6pYRxyl9pXUNtpf+cXtFCuo4McxKUGc+C5gLue1X92Xa9W7jq45C8dO4/1PKMToWnBmcyTZ65e7
	XR1CA4XY+vure4MYA=
X-Received: by 2002:a05:6a00:4b12:b0:89e:fc56:a25e with SMTP id
 d2e1a72fcca58-8a9bfa02bd4mr4056675b3a.41.1793453538349; Sat, 31 Oct 2026
 06:32:18 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <bpf_redirect_neigh_short_linear.v2.r0.20261028080316-1@mojatatu.com>
 <DMII4JGTEUEG.2WRJPT6ODT6J0@gmail.com>
In-Reply-To: <DMII4JGTEUEG.2WRJPT6ODT6J0@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 31 Oct 2026 09:32:06 -0400
X-Gm-Features: AclHuK-ddqUaxwQGu_QsdsX_5VreQz3XrjlPaOLjbuJHGuyWX_YBYrjskp5eDDg
Message-ID: <CAM0EoMn7kvsfZbsOdU3jHiT1Ypc6OHHu_+empy=Fmu33Etfhug@mail.gmail.com>
Subject: Re: [PATCH net v2] bpf: Fix skb_pull() BUG in __bpf_redirect_neigh()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@kernel.org>, bpf@vger.kernel.org, 
	bot+bpf-ci@kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	David Ahern <dsahern@gmail.com>, Martin KaFai Lau <kafai@fb.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>, linux-kselftest@vger.kernel.org, 
	Shuah Khan <shuah@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 5:47=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Oct 29, 2026 at 02:36 AM Jamal Hadi Salim <jhs@mojatatu.com> wrot=
e:
> > Add egress coverage to tc_redirect_neigh: the existing test only attach=
es
> > redirect_neigh at ingress, where mac_len is populated.
>
> This test cannot hit the BUG.

It was reachable _before_ the fix, normally useful to include such tests.
I will drop it, but if you think it is still useful and you catch me
before i send v3 i can include it (or can be sent afterwards).


> Just drop it and respin as [PATCH bpf v3].
>

Will do a v3 sometimes today for below...

cheers,
jamal
> >  static int __bpf_redirect_neigh(struct sk_buff *skb, struct net_device=
 *dev,
> >                               struct bpf_nh_params *nh)
> >  {
> > -     struct ethhdr *ethh =3D eth_hdr(skb);
> > +     struct ethhdr *ethh;
> >
> >       if (unlikely(skb->mac_header >=3D skb->network_header))
> >               goto out;
> > +     if (unlikely(skb_mac_header_len(skb) < ETH_HLEN ||
> > +                  !pskb_may_pull(skb, ETH_HLEN)))
> > +             goto out;
> > +     ethh =3D eth_hdr(skb);
>
> ETH_HLEN is not enough.
> __bpf_redirect_neigh_v4() and __bpf_redirect_neigh_v6() read ip_hdr()
> and ipv6_hdr() right after the pull. Nothing makes these headers linear.
> Take the AF_PACKET frame from the commit log without pop_eth and
> bpf_skb_change_head():
>
>   packet_snd()                     headlen =3D=3D 14, IP header in frags
>   skb_pull(skb, ETH_HLEN)          headlen =3D=3D 0
>   skb_reset_network_header(skb)    network header =3D=3D skb->tail
>   ip4h->daddr, ip4h->saddr         read past skb->tail
>
> The route lookup runs on garbage.
>
> Eric's skb_network_offset() check also covers
> mac_header >=3D network_header. No need for two checks.
>
> Something like this:
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2290,10 +2290,14 @@ static int bpf_out_neigh_v6(struct net *net, stru=
ct sk_buff *skb,
>  static int __bpf_redirect_neigh_v6(struct sk_buff *skb, struct net_devic=
e *dev,
>                                    struct bpf_nh_params *nh)
>  {
> -       const struct ipv6hdr *ip6h =3D ipv6_hdr(skb);
>         struct net *net =3D dev_net(dev);
>         int err, ret =3D NET_XMIT_DROP;
> +       const struct ipv6hdr *ip6h;
> +
> +       if (unlikely(!pskb_may_pull(skb, sizeof(*ip6h))))
> +               goto out_drop;
> +       ip6h =3D ipv6_hdr(skb);
>
>         if (!nh) {
>                 struct dst_entry *dst;
>                 struct flowi6 fl6 =3D {
> @@ -2399,10 +2403,14 @@ static int bpf_out_neigh_v4(struct net *net, stru=
ct sk_buff *skb,
>  static int __bpf_redirect_neigh_v4(struct sk_buff *skb, struct net_devic=
e *dev,
>                                    struct bpf_nh_params *nh)
>  {
> -       const struct iphdr *ip4h =3D ip_hdr(skb);
>         struct net *net =3D dev_net(dev);
>         int err, ret =3D NET_XMIT_DROP;
> +       const struct iphdr *ip4h;
> +
> +       if (unlikely(!pskb_may_pull(skb, sizeof(*ip4h))))
> +               goto out_drop;
> +       ip4h =3D ip_hdr(skb);
>
>         if (!nh) {
>                 struct flowi4 fl4 =3D {
>                         .flowi4_flags =3D FLOWI_FLAG_ANYSRC,
> @@ -2451,15 +2459,14 @@ static int __bpf_redirect_neigh_v4(struct sk_buff=
 *skb, struct net_device *dev,
>  static int __bpf_redirect_neigh(struct sk_buff *skb, struct net_device *=
dev,
>                                 struct bpf_nh_params *nh)
>  {
> -       struct ethhdr *ethh =3D eth_hdr(skb);
> -
> -       if (unlikely(skb->mac_header >=3D skb->network_header))
> +       if (unlikely(skb_network_offset(skb) < ETH_HLEN ||
> +                    !pskb_may_pull(skb, ETH_HLEN)))
>                 goto out;
>         bpf_push_mac_rcsum(skb);
> -       if (is_multicast_ether_addr(ethh->h_dest))
> +       if (is_multicast_ether_addr(eth_hdr(skb)->h_dest))
>                 goto out;
>
> -       skb_pull(skb, sizeof(*ethh));
> +       skb_pull(skb, ETH_HLEN);
>         skb_unset_mac_header(skb);
>         skb_reset_network_header(skb);
>
>
> pw-bot: cr
