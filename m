Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A0F3CDBD7
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 06:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780555519; cv=pass; b=NuMBloE0FUsKHyWrEy5oCjlJhpSwjZB6LdgUTIFzJqSDGaUeyulZtf7TKNbtvFCyYVPKJd6WC236yR9kS+nzJ+Caqv8H9ZShR6wCoyazkWE0bDMVTb9ZKsXXjObtks+Fzj7OVbXzn4pvwyjoTMpbXwXqOaAzAojQVkaNzj9Z99I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780555519; c=relaxed/simple;
	bh=vanpS1yaGLVvjgX9OJUOk5+5XahkPs+IQUwZLe28efY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RGlbv6/nt+5pG2faWW8Xl/VQkjQU02Tokjnl01ORr3Pa1Td29+kosyPz5E5utrLMSv//AHPNsg4qcZ0BJ7XciKS4XFzhdY+22jRWf9vnYQUTr+p3sUyjbXZcs6qb57fArrROh4RWX0hh9wVHgsLQiEYYJlDn6BbBLwdC9U0Sq7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bqd1/HBu; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bqd1/HBu"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-137dd5161feso37179c88.1
        for <stable@vger.kernel.org>; Wed, 03 Jun 2026 23:45:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780555515; cv=none;
        d=google.com; s=arc-20240605;
        b=Ume3LF6Nwgw+735GVDwzwFlcXmr8Mo8+GU5e9sHD9vYpEpR0ymbR1EJTRWA7lTgGXR
         rIQ1PpCwdx/2IiAQ3jqj0tgMclTg/k0SNDcieduS/DwuhqG1mLVPsBjSy7kXLhtTmecc
         RU0O+/ZbDQI+NDJIfmeit1VcgSZsyE1qbwUreT2jAfc4hdRB4HTcSS9+agaq6dfTXzRm
         1l86wwvc2dtr+EKikd/0tuvMr5Eh5HK+2iytIrlKyQzr4Mxb1L7v/dIRiPotOY0KmSzs
         XQ2QDJ9uKRg3lxd+jE1mKRaeaAy6a4cSTHxLxQ5s/smOjzFAsJ5fCUy7WPtmpk67tTyh
         sRQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oqLC1ZyUbsrS8VIC+GHhJNOdtBNsT5LpOiDbY5gQx0o=;
        fh=fk/7iYp6uU3OA3PO9s+S7g5zLyoHZJR/jprW08RiYkE=;
        b=dE29PC9wPHbYXAVyMAkN4g4jjvUZahbmbUfQs7P0KKLQBWnoEKTZjmH1jH5YLkRws7
         IWSOe2k9SreINP3u/ote4JAH5KEqw8jUPBDctJwDhGOeBf7meZ5e5WfM2Pc0lIYYcVXK
         BMocKSXmVTXnaaDNnXOjA8gBhCPHkYWuMpXa8spqdPQaIA3HNxHDF6GjucPDVn/hNNf/
         T4hLGNjs6NTBnq4aCFaMT9n9RxUvbORsD/upoX8WXuIcuUEXcKWxOur11tWfp8eY5P0v
         UmmXFO62Jvl2Ct8ZcNWWJAg3xZRrk1pMhww3deR+kXU2dWYbheedxFRZiXPO5LcZzpqR
         JUgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780555515; x=1781160315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oqLC1ZyUbsrS8VIC+GHhJNOdtBNsT5LpOiDbY5gQx0o=;
        b=bqd1/HBuWsey45XVxRanYJLzPm6smQnqxsyGE6mSNNAmh+65Hzkz3cqZ7CRA1xRyf5
         jD7ilICaTagtZOB9oDOUHqGBpTPUP7/Y4mxKO5bNotL61OY4sRjcZQQQNI7DSHHZ6Ymv
         zYSk2LA9tp+cDaAPjZhlXCZ7J/5fCtIfiBbPY/hV3LloN+NO32Xm5MtL24yFh4GhSiGm
         5W7SRLhl2gya3Jqp8C+kFP+38Fiq2WnE0NcqumoIrMm5cRZlAizWaBJmYRUa1DyfHBeF
         /Ao2ERrmNhgYkg6fKKT0eSzIjrdaXq/gb+VIJ9LjwlXc3WKArcdu7tI+cpRoMz/YLnb1
         kjGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780555515; x=1781160315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oqLC1ZyUbsrS8VIC+GHhJNOdtBNsT5LpOiDbY5gQx0o=;
        b=mEbx1/NYJkVDJxzqGJNbJeNEoSkIvqcNY9Z6J1K8RLv0xw/wLZRxgzS4YQ2V6kwEjI
         34eo8sVNV9oOZqhDFOtsrUQ1zwiS4p7JmwcrxwXx0omn7fJa5LGhKtk1zojUVVwg/dpQ
         e8a+r0QBXpRFf8J8l9+ycnCpeONp8kAD3hw3z4C67NtD9MDOQ0w3KqCjxifbAr9kZcTW
         tklMIHYPCwAUralkRu814awr+4+4PeSFaU6yaD0XGzfEKT1wrDVW/RfNRFXZwlqesOdU
         vbhcajG0UNTrSwxDvZFy52dZpE1EjN0a0hI8ShgsTNEfjnRndGytucrOAaUZGGIknacB
         hdZA==
X-Forwarded-Encrypted: i=1; AFNElJ+kMG389U+sdZj7aj8NRwON4gJHRdM17FlJy5lHwzfeuJTS2lL2gKEhwPxYb+F5MR1IxVBZebw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyceHOCgq4gxLqpEwle5ebxTf3CqOHlrkwpbyobBxchZi9BZz2o
	bVcxW1y8pFKREyFcOhHmEzaP7UAQtA0CN+VgwdEQRdEGhKotNkk7ozQkU2GPfBOj6NBTYWxdWAm
	mR/diOzv1yHFidWtLz/2zOQZQfq0MTAdkEWUhku0e
X-Gm-Gg: Acq92OHPDH9W+G4ck166HAs5POxI71eF6Uj8RgZ4rvuh9MI0zuqWRN8aIH7J5MDkhnw
	UKjcavxl+a92qwHInWDY2d9xJdAEidUveiMeaRTOC+WZQokAzbS8LVflbTzkh5TsJqQPr5yxQUG
	aMlfPKNjAWOWemoYU4txr7yUAs+E1xdJlobTwPlXrNdtpR/0A++sxl4NUUU4V8JaZb1BSULLSrA
	qF7CJiATjhYE59qx8zcN/N8Td8ukca2x38jiMRcEoQT+eK/wP8SPq2YuJ18xs+zYOfigK/5J1zF
	FHS5xrvWlBZHGLS8r40B3OiPg2HQrH8oLq0DnfSUV38VVNmMKF9FwocFk1N+Jgaa4AC1lZR661I
	ly6sItwFJHc0zj10Kd4lqREAhuIFue5ACYuNy6uOH2hHXO1ABfwQKdcMFPndcCgo=
X-Received: by 2002:a05:7022:628b:b0:137:699d:7b95 with SMTP id
 a92af1059eb24-137f6bc8a08mr2650501c88.19.1780555514624; Wed, 03 Jun 2026
 23:45:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601034148.1272080-1-maoyixie.tju@gmail.com>
In-Reply-To: <20260601034148.1272080-1-maoyixie.tju@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 3 Jun 2026 23:45:03 -0700
X-Gm-Features: AVHnY4IpoIBqL7O4an-vF8_7ewLRrxVC-xjimvQxF5gwh4Yh2qBo4D5NO5WQrCo
Message-ID: <CAAVpQUCUtPJuktP7gxbC02NtDWDFEHegPUPwyQoPGA==+d0Jfw@mail.gmail.com>
Subject: Re: [PATCH net v2] net: require CAP_NET_ADMIN in the device netns for
 tunnel changelink
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	David Ahern <dsahern@kernel.org>, Xiao Liang <shaw.leon@gmail.com>, 
	Nikolaos Gkarlis <nickgarlis@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 31, 2026 at 8:41=E2=80=AFPM Maoyi Xie <maoyixie.tju@gmail.com> =
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

Some attributes might have already changed before calling
ip_tunnel_changelink().

e.g. ipgre_netlink_parms() updates t->collect_md, which will
be visible once the device owner calls changelink.

Also, check net_eq(net, dev_net(dev)) to avoid unnecessary
LSM invocations.


> +               return -EPERM;
> +
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
