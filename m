Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792761449;
	b=SFtRJVsZMiQcwPDnp7NVb+z3XOMf6SaZVDvX3vzKuequpg+MTLMAeqghM58UJL6eH2DD
	 IDbhizfs5/Vo7fgO0wjT/FDi48FAnKNvMlsrNUBbaXBE30qqohDalgnASZb6M0FaOcVch
	 admVx+w5yyeyLWXIPwl4CvvmmDaqtiXUXYXJijY+u6Ij+OFXMV7Xzh/puCbRPp6MTH8Kn
	 UosAf+7Q0Knw0aPIYsFSoPzdbjQ3c4pZTUqxXUu3nOgsU+JAemqV6SJx3A8lKb/kRp6Fn
	 Aip6hpJCX0+KH7T5A+QZMTKA7do7IncLGBN8gzzPC3SBMpectY/9oCpXciZV5RYqryg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792761449;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=0Jy6ijYpplFo2RiXUuFInKZH7hvo63tpNLxOIF2GLhk=;
	b=gwlX6MS5wlJbVKsGRmqOgciH7EOSY8QzfUtbG7CTaEC1+Aq6B3kxe6R02LDofDIdQL6/
	 YfuF5fFl6ijkTZFe3VrfEOLFdFRN8yQ4J0mg+/slxIgyAImD6Y/3R0EanrOssZxlEWImW
	 7rMwsvmFhb32svepGM3ogyIe6TBkzbCOTt4YjAsNSnNs9Irgxr8E5mFbs0DEXpTbZQB/i
	 0J7OB31Cb/WSW0yp3YZWURa1rnjiAkphiHiroMhHvC/tIubLrcog0niSpyjcfD/ee8lOk
	 wLbMhrQKmkwDX3NLvDpdYwN0jmDchShiSsKQ47EnhD+z1T25Gno/n5NAjEHW+c3cwQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TuoEKRDi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2D5606A321
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 13:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TuoEKRDi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F2A1F031E3
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 13:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792761448;
	bh=0Jy6ijYpplFo2RiXUuFInKZH7hvo63tpNLxOIF2GLhk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=TuoEKRDiiVJWmH5b9pWfWrIsgHf65shVKDjuSIYA4XesIMlJB02G62UyJiTZ1gGR3
	 tXEjCjtc4VscULzJ6nRz4fp25LioqiE9aagE+gtCGrrMqqw591J4zcYf3PzkE8sFxI
	 zok04HlOAcn6QWrnhAxbuV2HhAfUwFy+gItZH8GCN1TelZXq7yDGyMeAIijQVGaJ9g
	 16c6gOBvvkWmM3aWItQ8sDWSGGI3JKdcobAX9xs2QaqESFKy91vISRr+yLPrfcqLPz
	 0cWmFwiYm6uvLbRSmkjH3K9X3tL5TocBtGQT3cIpW1TRK8BjtsgWCucWjDfCJAnHZ1
	 g3BEANfDP2k3A==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5bce4e278baso1169847e87.0
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 06:17:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxD85lwKB10y865zUX1Pq3GvJzePRwvxH6ADhcl7QposJjqsaMX2DO8DTnME3Ae/QC2NaTz6HA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKUeXl914yqByg6rXczJJJR5JtnzlHPn4iSc/BJJ+fkbwXTJxbk
	9G5NYWeKwnU6CxSUwdwr5rqc0cH+GQn/HEd/dURN4leJyJlGqPeeEhxE/kNwNUQ52d++0jD8bL8
	ZRwD/qgG2xqj2QqNb08HH4GUIGTSWsz8=
X-Received: by 2002:a05:6512:6683:20b0:5be:5994:7b8e with SMTP id
 2adb3069b0e04-5bfb0a777a8mr418611e87.16.1792761446868; Fri, 23 Oct 2026
 06:17:26 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <ACT-N6N4.v2.r0.20261022191829@mojatatu.com> <ACT-N6N4.v2.r0.20261022191829-1@mojatatu.com>
 <ACT-N6N4.v2.r0.20261022191829-2@mojatatu.com> <ACT-N6N4.v2.r0.20261022191829-3@mojatatu.com>
In-Reply-To: <ACT-N6N4.v2.r0.20261022191829-3@mojatatu.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Fri, 23 Oct 2026 15:17:14 +0200
X-Gmail-Original-Message-ID: <CAL4Wiiq3h_OoVo9BpBy0pqFe=AeyN25QxsU86h63qEf05uCJRA@mail.gmail.com>
X-Gm-Features: AclHuK8mT9YHVFbj8FOssg3rGy-IseKbKzEOONylt4DKSKpO3uDQwyfRq5tC8W8
Message-ID: <CAL4Wiiq3h_OoVo9BpBy0pqFe=AeyN25QxsU86h63qEf05uCJRA@mail.gmail.com>
Subject: Re: [PATCH net v2 3/6] net/sched: act_mirred: reject redirects
 without a link-layer header
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Shmulik Ladkani <shmulik.ladkani@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 23 oct. 2026 =C3=A0 13:59, Jamal Hadi Salim <jhs@mojatatu.com> a =
=C3=A9crit :
>
> The issue:
> tcf_mirred_to_dev() may redirect a packet that has no link-layer header t=
o
> a device that expects one.  TUN builds a valid L3 skb with mac_len =3D=3D=
 0;
> mirred then pushes zero bytes and the IP header is parsed as Ethernet by
> eth_type_trans().  The same happens after a VLAN POP_ETH or MPLS POP chai=
n
> whose producer did not leave a full inner Ethernet header.
>
> The Fix:
> After the existing push/pull adjustment, when the target expects data at
> the MAC header, require a link-layer header of at least
> dev->min_header_len bytes and pull it into the linear area.  Drop the
> packet otherwise.  This mirrors the check bpf_redirect() already performs
> and keeps the legitimate push_eth-then-mirred case working.
>
> Conditions to recreate the bug:
> - create a TUN device with IFF_TUN | IFF_VNET_HDR | IFF_NO_PI;
> - attach egress mirred redirect to an Ethernet device (for example lo);
> - write a virtio_net_hdr with hdr_len=3D1 and an 8192-byte payload.
> The unfixed kernel parses the IP header as Ethernet and can BUG in
> eth_type_trans() via loopback_xmit.
>
> Fixes: 53592b364001 ("net/sched: act_mirred: Implement ingress actions")
> Suggested-by: Eric Dumazet <edumazet@kernel.org>
> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
>  net/sched/act_mirred.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
> index 553342c55cf7..e3e0e4aa70a1 100644
> --- a/net/sched/act_mirred.c
> +++ b/net/sched/act_mirred.c
> @@ -316,6 +316,11 @@ static int tcf_mirred_to_dev(struct sk_buff *skb, st=
ruct tcf_mirred *m,
>                 }
>         }
>
> +       if (!expects_nh &&
> +           (unlikely(skb_network_offset(skb_to_send) < dev->min_header_l=
en) ||
> +            !pskb_may_pull(skb_to_send, dev->min_header_len)))
> +               goto err_cant_do;
> +

Oops, sorry this breaks tools/testing/selftests/net/forwarding/tc_mpls_l2vp=
n.sh

My bad, the skb_network_offset() part I suggested in v1 is wrong.

Please remove it:

diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index b0390b08600c4a709b18f6d92aebe6629081c735..0bd73c5072a90d3e952d0a72446=
1adcf0307592e
100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -317,8 +317,7 @@ static int tcf_mirred_to_dev(struct sk_buff *skb,
struct tcf_mirred *m,
        }

        if (!expects_nh &&
-           (unlikely(skb_network_offset(skb_to_send) < dev->min_header_len=
) ||
-            !pskb_may_pull(skb_to_send, dev->min_header_len)))
+           !pskb_may_pull(skb_to_send, dev->min_header_len))
                goto err_cant_do;

        skb_to_send->skb_iif =3D skb->dev->ifindex;

Keep only the pskb_may_pull() which is enough to prevent
eth_type_trans() from crashing on a short linear part.

Thanks!
