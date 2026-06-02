Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AD4348C66
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 02:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780366214; cv=pass; b=TJdl9/XGUKiqBtZxZXavUiJLUcIc8SDWNBU3yt1Z0fKwaZZkjR0kLlKrW1p0grnD7abB3vFgL0X2nh+bERq2/6dHKQnDxLl4OGAVEu9j2aW9KU9/uyLtvvK2SfQli1nGy0Wpe93QlkDgz0tCPjCUJlLgJNyhh5nV5re+Nupx2Bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780366214; c=relaxed/simple;
	bh=LHS2lhZgKMmZxzsPYW2PXD0tEfpF49HGVgg6ty6nidU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tmhx2WFypamHLF6GX9KD826+V66J5GJLCV3vXL8jYF6+22bh9FPs7eS73WyS9WXN3YqfXorYVVysYe53ahR0xbKQZy7PC+NAHFSFAoP2+gjb0nYAR2GEV/oKoxjMizKy3BB8N8yWDWiqrcwjlhTLvFcfTCFeQufLQ1iHwtDzdbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SrZMVbgp; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrZMVbgp"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45ef1629ff4so2827475f8f.0
        for <stable@vger.kernel.org>; Mon, 01 Jun 2026 19:10:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780366211; cv=none;
        d=google.com; s=arc-20240605;
        b=VgyEctrYOdbsTEUF5Rh3Ba8LxedkjFs3KPUCM341HkICzU1aW3mqYOvuAj9QbJw46h
         9pW4zFn8Ol/tZ+iQ/VykFsWedi0fI9pdAbma7vHgoqu43SFEK7x5pLKIqpNqNAirmk+h
         Uvg8mxt39iaD6cRPYHhAIDBjtu8lpeNVoxll/mihm4gvqAiGUd8J944a4f2DSxByxww2
         Ty9D3XCKfTKU9+HNVLOva+yNrfSdsv7ihEU5g+0vZkjsI0y2/uOECg6KmGSNSzXIQT/C
         qXdQvYrtHDZtkYK6afHgfLWiy+Qjj5pltTq5loEFJQ9QdgJch6oBkDUpHiglumi+qy+U
         +/ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iTbhl9+TdhzGMasdKn19jki+NsU7h/pgqeVahMbDzwE=;
        fh=leiHlteL2RE28cJMvooWp3FJ4dYMkwzejRWkxZ+ZpQs=;
        b=GKYVgsKWLt3ED8kOhWqbDrB9qb9sW+F8LHIOrZGMrkf4+lFISBN82Pd18Z7YWtNdmt
         qaHD7oe9Ykv1EMmBjuljuYUstw68Hv25/L2KJkmr/3pfq27XUxVJQepPNip0/Pon6+7H
         reLET9svlyP0Rvwk600AMfpJts+vRzATwk3RBxG83sXFrc1MIVnKU5Xv8dcuA4QCJkK8
         oLU0yfCNNqCFcgu1iu+o5fPhvj2AWcrnZ7t7oNvczYGDPOZd65JvoMq878zFD2EZmX96
         yXkVG8//gvjbiU1tOOuepUiifVO7epFKs6mRrKwPIyU/wtUYhRlrp8fjC21aiGCYIara
         rAhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780366211; x=1780971011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTbhl9+TdhzGMasdKn19jki+NsU7h/pgqeVahMbDzwE=;
        b=SrZMVbgpw1M5vU+9LFvEOoMCKI4tPAMadPvqSSL5WHp/Bx2JA943ZyqY83NiH09jGZ
         UiNu+wzofGY2+4zrycSUgO2WlzPUB2Lmnvz0pj8YdfaukOIG0srKaQY57C26/Y5NVAre
         kejImo9RAS4Npx7psbFKp82fVd2de2tXrdpfRg205fHedqssdbtAQfm+n9pABYo1sGq2
         QuGw4XiTOGl5Gjm3Em63PnukQRcda2GQO+NV7lMNVZ6c1R8UFNbfdW1h810iVCAem+WM
         LkG1d12P2UJjqC1A5B6/9uZqP1FrG9+Cqjmwh8w6JMIKmPIZhRpjk72g9e/0iBSJjMi+
         vN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780366211; x=1780971011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iTbhl9+TdhzGMasdKn19jki+NsU7h/pgqeVahMbDzwE=;
        b=dOmqsv27Keh0KvShK3teiPmIS4DEPi0w8RTvVwqtUJx5fMZvR53uB4bYTDGwr/BRit
         FZ4ev6FBUBWoKtowDDqrfbDb39sc7WnPNg/P5b9TqdYvJYoiAceLfkrZgi95ZSmQupNQ
         HtL8Q6XHAy5MUH3mh6rLFmoSsP0auhEK4TE5g6oAKYOtJTmvXTpgqYm6s9OgQoWAdhbM
         41cWN88f5sxQNMEUmCOKdRdGJcgHMy9a8xLTr65/ckEAeo718j19MZFQclo3E0HdpyTo
         Rf9ZC8hkl16F05fFbAm3LOpYvesFu3/mdxce9a26FAx59kC3l02LWXf3Sw3IbfzzULWW
         +6oQ==
X-Forwarded-Encrypted: i=1; AFNElJ/wOM4Aj4GKLDJaioYONpXEwk1hRX66tfmg1qFz7rouYSOAc/x0J9ZnSkt3Py6nF9TtK16Il5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIu1Y0i23cLoCdSYP8ByG3T46dQasbE1MZp/kxMC7wrsqBSibF
	G0eHRLYgHZJqx34g/8QtpjkxpMt/J0rUttW4win1kyo4kYFo0WQMqx2NlqdtQZORxXh8cSRYyUV
	HfE8ZxmgKwnrPE3rCB1JKKgK8X1bqM4E=
X-Gm-Gg: Acq92OEFpefysM7/SpSP+POjWPb2GTsfypdya3pdTt9L/8Mgro1W6ihui66QUgXA5LO
	C5Q0o+eV/1giA/n8akBApJeZmMjCNZhZ6aSmbKrDnyHuRh3lpVrzst0XLs94ue2iMsYRpqusGbr
	Wu6EWdp+s9RLmGRNaW+0A2714QtAaFwqfn9xCdLujs5/iTYLDSNQ11DioTPLmY4hJVv7q3kitBy
	b/6AA/Tau46gpJeIhf5UdyuWmaMW6jsjTIB0bEvcpJ4hKuByoAGMIS66ANv8pM+XoxgCf+mumwO
	zvv/C0gI20SmxM1PAQ58P6sRVGMooavbe9Uo5ayEc2K9gPRYGXUncqTHrZo=
X-Received: by 2002:adf:ea87:0:b0:45e:ec27:b4c2 with SMTP id
 ffacd0b85a97d-45ef6b9300fmr16473165f8f.36.1780366210708; Mon, 01 Jun 2026
 19:10:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601034148.1272080-1-maoyixie.tju@gmail.com>
In-Reply-To: <20260601034148.1272080-1-maoyixie.tju@gmail.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Tue, 2 Jun 2026 10:09:34 +0800
X-Gm-Features: AVHnY4J9HcySFrlIHPpvZnAh5JRZtt7vCxk9UsX_ASk4WS58ydIafXR_8sRpNFU
Message-ID: <CABAhCOQ7Sd2G4ZVwNUK7i6cF7v=CwhcYosvYAgopb=32aNimZQ@mail.gmail.com>
Subject: Re: [PATCH net v2] net: require CAP_NET_ADMIN in the device netns for
 tunnel changelink
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Nikolaos Gkarlis <nickgarlis@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 11:41=E2=80=AFAM Maoyi Xie <maoyixie.tju@gmail.com> =
wrote:
>
> A tunnel changelink mutates the tunnel hash of the device's creation
> netns. ip_tunnel_changelink(), ip6_tnl_changelink(), vti6_changelink(),
> ip6gre_changelink(), ip6erspan_changelink() and xfrmi_changelink() all
> look up and update through t->net.
>
> The rtnl path into changelink only checks CAP_NET_ADMIN against
> tgt_net. After IFLA_NET_NS_FD migration the creation netns differs from
> the caller's netns. A caller with caps only in its current netns can
> then rewrite an entry in the creation netns hash. They pick the
> endpoint addresses. Commit 8b484efd5cb4 ("ip6: vti: Use ip6_tnl.net in
> vti6_siocdevprivate().") added the same check on the ioctl path. This
> adds it on the RTM_NEWLINK path.
>
> Check ns_capable(t->net->user_ns, CAP_NET_ADMIN) in each changelink
> before the lookup and update. The newlink path has long checked the
> capability in the link netns. The changelink path never did.
>
> Reported-by: Xiao Liang <shaw.leon@gmail.com>
> Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=3D87_CP=
jPVsTHbq905k8A+BuUg@mail.gmail.com/
> Fixes: d0f418516022 ("net, ip_tunnel: fix namespaces move")
> Fixes: 5311a69aaca3 ("net, ip6_tunnel: fix namespaces move")
> Fixes: 690afc165bb3 ("net: ip6_gre: fix moving ip6gre between namespaces"=
)
> Fixes: f203b76d7809 ("xfrm: Add virtual xfrm interfaces")
> Fixes: 11b326fb0a37 ("ip6: vti: Use ip6_tnl.net in vti6_changelink().")
> Cc: stable@vger.kernel.org
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
> ---
> v2: Reworked per Kuniyuki Iwashima's review. v1 gated the check on
>     dev->rtnl_link_ops->get_link_net in __rtnl_newlink(). That gate is
>     too broad. For peer types like netkit and veth get_link_net returns
>     the peer netns, which changelink does not mutate, so the core check
>     would wrongly require CAP_NET_ADMIN there. Move the check into the
>     changelink path of the tunnel types that mutate t->net, against
>     t->net->user_ns. This mirrors the ioctl side in 8b484efd5cb4.
>
> v1: https://lore.kernel.org/netdev/20260527070824.2677331-1-maoyixie.tju@=
gmail.com/
>
>  net/ipv4/ip_tunnel.c           | 3 +++
>  net/ipv6/ip6_gre.c             | 6 ++++++
>  net/ipv6/ip6_tunnel.c          | 3 +++
>  net/ipv6/ip6_vti.c             | 3 +++
>  net/xfrm/xfrm_interface_core.c | 3 +++
>  5 files changed, 18 insertions(+)
>
> diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
> index 50d0f5fe4e4c..51d8787318f3 100644
> --- a/net/ipv4/ip_tunnel.c
> +++ b/net/ipv4/ip_tunnel.c
> @@ -1251,6 +1251,9 @@ int ip_tunnel_changelink(struct net_device *dev, st=
ruct nlattr *tb[],
>         struct net *net =3D tunnel->net;
>         struct ip_tunnel_net *itn =3D net_generic(net, tunnel->ip_tnl_net=
_id);
>
> +       if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
> +               return -EPERM;
> +

Should modifying params that don't affect tunnel lookup (e.g. GRE_CSUM
and GRE_SEQ) require CAP_NET_ADMIN in link netns?

>         if (dev =3D=3D itn->fb_tunnel_dev)
>                 return -EINVAL;
>
> diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
> index 365b4059eb20..0de4994bc92f 100644
> --- a/net/ipv6/ip6_gre.c
> +++ b/net/ipv6/ip6_gre.c
> @@ -2047,6 +2047,9 @@ static int ip6gre_changelink(struct net_device *dev=
, struct nlattr *tb[],
>         struct ip6gre_net *ign =3D net_generic(t->net, ip6gre_net_id);
>         struct __ip6_tnl_parm p;
>
> +       if (!ns_capable(t->net->user_ns, CAP_NET_ADMIN))
> +               return -EPERM;
> +
>         t =3D ip6gre_changelink_common(dev, tb, data, &p, extack);
>         if (IS_ERR(t))
>                 return PTR_ERR(t);
> @@ -2266,6 +2269,9 @@ static int ip6erspan_changelink(struct net_device *=
dev, struct nlattr *tb[],
>         struct __ip6_tnl_parm p;
>         struct ip6gre_net *ign;
>
> +       if (!ns_capable(t->net->user_ns, CAP_NET_ADMIN))
> +               return -EPERM;
> +
>         ign =3D net_generic(t->net, ip6gre_net_id);
>         t =3D ip6gre_changelink_common(dev, tb, data, &p, extack);
>         if (IS_ERR(t))
> diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
> index 9d1037ac082f..2834004c7011 100644
> --- a/net/ipv6/ip6_tunnel.c
> +++ b/net/ipv6/ip6_tunnel.c
> @@ -2102,6 +2102,9 @@ static int ip6_tnl_changelink(struct net_device *de=
v, struct nlattr *tb[],
>         struct ip6_tnl_net *ip6n =3D net_generic(net, ip6_tnl_net_id);
>         struct ip_tunnel_encap ipencap;
>
> +       if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
> +               return -EPERM;
> +
>         if (dev =3D=3D ip6n->fb_tnl_dev) {
>                 if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
>                         /* iproute2 always sets TUNNEL_ENCAP_FLAG_CSUM6, =
so
> diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
> index df793c8bfffb..7b05e0c491db 100644
> --- a/net/ipv6/ip6_vti.c
> +++ b/net/ipv6/ip6_vti.c
> @@ -1044,6 +1044,9 @@ static int vti6_changelink(struct net_device *dev, =
struct nlattr *tb[],
>         struct __ip6_tnl_parm p;
>         struct vti6_net *ip6n;
>
> +       if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
> +               return -EPERM;
> +
>         ip6n =3D net_generic(net, vti6_net_id);
>         if (dev =3D=3D ip6n->fb_tnl_dev)
>                 return -EINVAL;
> diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_cor=
e.c
> index 330a05286a56..a1029a829406 100644
> --- a/net/xfrm/xfrm_interface_core.c
> +++ b/net/xfrm/xfrm_interface_core.c
> @@ -869,6 +869,9 @@ static int xfrmi_changelink(struct net_device *dev, s=
truct nlattr *tb[],
>         struct net *net =3D xi->net;
>         struct xfrm_if_parms p =3D {};
>
> +       if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
> +               return -EPERM;
> +
>         xfrmi_netlink_parms(data, &p);
>         if (!p.if_id) {
>                 NL_SET_ERR_MSG(extack, "if_id must be non zero");
> --
> 2.34.1
>
