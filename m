Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5291F57EDAA
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 17:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792172077; cv=none; b=DeyUAWqGTbHyKtynIKLso7jgCt0jOmhRpY9LBRVsGtqY0E83JnPauB7gvW4caZjAudBdRf17sdIsJz3wLe5WQyC2dhJh3jYO4OjW2KMbX+drk2ru1Hqul2y16dGHrZ/HS8wndS0nRf4PCJcc5YRy37wzxc6RaZI+FWU5jD3n270=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792172077; c=relaxed/simple;
	bh=k5Se0fr+jHx2N2vtFm2khL3JfsGB5anVwHoMSnoTXb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FXYPZP9RWpshtFrho9nVJ9KcIK7DOXhdYjucxNhuAqUctckUd9syA48K+1EESumcd5D8bQe5Be71foQtm3Kh4OpWQKXxQJMOsi9+ABpg5Mrr+5dW+9aIBZFNFmDUtOPaeIeyE+NMcujZjkZb+GxSG+DkE4KIBaHFy7v6Lg0pvRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0FjSCYh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0FjSCYh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378471F000CD
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 17:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792172076;
	bh=G1/GMtPfbdHXuRmiWXZLwN7EqaLU40tpo/H7Ritkxg8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=P0FjSCYhMWRNpCH+j7t9sqcHxs9SsM8otuBjw6hy1nZp6wM4AhjlWk9Jd1wgumSTp
	 ucPP/Q6oZDDjpH693y1Jx+o6c4TXTnBE2QNxHSF8FSZkbwuT177jzRLgQntWDipE5k
	 UuypV1HcoeCkSYEWmNey+5t3cE7Dv1AilqgBndd000ZEZ+yIx+t1W9CM3z0fxKAs5U
	 W2DGGotEQ6KQtMSO6XrIyS+Vs6doIdY160NhtbkPJoqDjLZ/gEIG2G3HR9nwYkQVyl
	 JcxnS0gVvArr+NjFw3Fg3GqGzNC9w+k9J6YVKKRFJP5/GTTADxY0LkIFOfOdk9CNcW
	 /VxJYLfUqysVA==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6cf995766a3so160322eaf.2
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 10:34:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxAM5jpIv/BEhvolARk6u+IZPuzMTzmLyljuMVAlhzg+6TG4sFt4klj6efiA7plzm7Lxd8uoEQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJrOr0cF+9mwH6cLkHruzbjUsC7YHFhj9yWNrBeXOY8ZdXVyxvM
	3jBWYRZeMV/uFQZHnXHUIMVqFXjSjBGtNTPFoNxPelU8VTyB5LnBLBh5LF7i9wf0obMFLedAPaK
	2ir6ZTnzhOQmyBchw8G1G+EL4sTg2c0Y=
X-Received: by 2002:a05:6820:161e:b0:6c3:2390:c293 with SMTP id
 006d021491bc7-70356387acemr95597eaf.32.1792172075473; Fri, 16 Oct 2026
 10:34:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261016-fraglist-csum-v1-1-93945be7bb5d@gmail.com>
In-Reply-To: <20261016-fraglist-csum-v1-1-93945be7bb5d@gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Fri, 16 Oct 2026 19:34:24 +0200
X-Gmail-Original-Message-ID: <CAL4WiirFAV5fAU_hgd53rLCGXfV0gOwm6-kgoi9YH707-ufE_g@mail.gmail.com>
X-Gm-Features: AclHuK_rkJWx30bjiv-C0gYh6_QefMmlynNsrkvx3wVskLaoWnFz3APnVdy-Gdo
Message-ID: <CAL4WiirFAV5fAU_hgd53rLCGXfV0gOwm6-kgoi9YH707-ufE_g@mail.gmail.com>
Subject: Re: [PATCH net] net: gso: complete partial checksums of fraglist segments
To: pylaterreur@gmail.com
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Willem de Bruijn <willemb@google.com>, 
	Felix Fietkau <nbd@nbd.name>, David Ahern <dsahern@kernel.org>, 
	Alice Mikityanska <alice.kernel@fastmail.im>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 16 oct. 2026 =C3=A0 19:10, Pierre-Yves Le Borgne via B4 Relay
<devnull+pylaterreur.gmail.com@kernel.org> a =C3=A9crit :
>
> From: Pierre-Yves Le Borgne <pylaterreur@gmail.com>
>
> Since commit f0b8c3034556 ("udp: do not transition UDP GRO fraglist
> partial checksums to unnecessary"), fraglist GRO keeps CHECKSUM_PARTIAL
> on the packets it aggregates, and skb_segment_list() gives every segment
> the ip_summed of the head. Before it, UDP fraglist GRO turned them into
> CHECKSUM_UNNECESSARY, which left their checksums unfinished whatever the
> output device. Packets arrive with CHECKSUM_PARTIAL from veth, or from
> virtio-net when the host sets VIRTIO_NET_HDR_F_NEEDS_CSUM, which it does
> for packets that the host itself or another VM on the same bridge sent
> with checksum offload.
>
> validate_xmit_skb() completes CHECKSUM_PARTIAL checksums only for packets
> that need no segmentation, and relies on the GSO callbacks for the
> others: skb_segment() computes the checksums of its segments when the
> device can't. The fraglist path doesn't, so when the output device has no
> checksum offload, e.g. a tun device without TUN_F_CSUM, the segments leav=
e
> with only the pseudo-header sum in their TCP or UDP checksum field and ar=
e
> dropped by the receiver. Only the packets that GRO aggregated are hit, so
> sparse traffic gets through while bulk transfers stall.
>
> This was seen with OpenWrt running as a VM, as OpenWrt turns rx-gro-list
> on by default: WireGuard packets from the host, which the VM routed into
> a VPN tun device, reached the VPN peer with unfinished UDP checksums, all
> with the same value. TCP is affected the same way.
>
> Complete the checksums of the segments once the protocol code has fixed
> their headers up, as validate_xmit_skb() does for unsegmented packets.
> skb_segment_list() itself is too early for UDP, as
> __udp_gso_segment_list() restores the length in the head's UDP header
> only after it. Segments that are GSO packets themselves, which TCP
> fraglist GRO can chain, are left as they were: skb_checksum_help()
> refuses GSO packets.
>



I do not think TCP fraglist GRO can chain GSO packets:
tcp4_check_fraglist_gro() / tcp6_check_fraglist_gro() set
is_flist =3D !sk && !skb_is_gso(skb), and a GSO skb arriving on a flist
flow gets is_flist =3D 0 and is flushed by the is_flist mismatch check in
tcp_gro_receive(). If you know of a path where this happens, please
describe it, otherwise please drop the skb_is_gso() test and this part
of the changelog.


> Fixes: 9fd1ff5d2ac7 ("udp: Support UDP fraglist GRO/GSO.")
> Fixes: bee88cd5bd83 ("net: add support for segmenting TCP fraglist GSO pa=
ckets")
> Cc: stable@vger.kernel.org
> Closes: https://github.com/Ysurac/openmptcprouter/issues/4402
> Assisted-by: LLM
> Signed-off-by: Pierre-Yves Le Borgne <pylaterreur@gmail.com>
> ---
> Tested on net/main 191aa41548b2 in UML: frames written with
> VIRTIO_NET_HDR_F_NEEDS_CSUM to a tap opened with IFF_NAPI | IFF_VNET_HDR
> (virtio_net_hdr_to_skb() and napi_gro_receive(), as on virtio-net RX),
> rx-gro-list on, routed with and without SNAT to a tun device read
> without vnet header. Packets that left the tun with the bare
> pseudo-header sum as checksum, with 2000 frames written per case:
>
>                     UDPv4  TCPv4  UDPv6  TCPv6
>   without, no NAT    1030    836   1106   1424
>   without, SNAT       250    721    683    196
>   with, either          0      0      0      0
>
> With rx-gro-list off, both kernels complete every checksum. TCP from a
> TSO veth sender through a router with rx-gro-list on, out of a veth with
> and without tx checksum offload, still works. The error path was
> exercised by injecting failures into 1 in 8 checksummed segments, under
> KASAN, kmemleak and lockdep. The same reproducer showed the problem, and
> an earlier version of this fix working, on an OpenWrt 6.18 kernel in a
> VM.
>
> Callers of skb_gso_segment() that pass no offload features (xfrm,
> nfnetlink_queue, wireguard, ovpn) now get completed checksums from the
> fraglist path too, as they already do from skb_segment().
>
> Not done: allyesconfig and full allmodconfig builds (not enough disk
> here); the changed objects build without new warnings on x86_64
> allmodconfig with W=3D1 and sparse (GCC 15). No selftest: the
> reproducer needs a NAPI tap fed with virtio_net_hdr frames and a tun
> reader that checks checksums, about 300 lines of C. I can turn it into
> one under tools/testing/selftests/net if that is wanted.
>
> This patch was developed with an LLM coding agent (Claude Code). It was
> asked to find out why forwarded WireGuard traffic got bad UDP checksums
> in the OpenMPTCProuter report linked above, then to fix that and test
> the fix; it did the analysis, wrote the fix and this changelog, and ran
> the tests above.
> ---
>  include/linux/skbuff.h   |  2 ++
>  net/core/skbuff.c        | 40 ++++++++++++++++++++++++++++++++++++++++
>  net/ipv4/tcp_offload.c   |  4 +++-
>  net/ipv4/udp_offload.c   |  6 ++++--
>  net/ipv6/tcpv6_offload.c |  4 +++-
>  5 files changed, 52 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index a3ff380d43f0..9c3dbbeb1e6e 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -4288,6 +4288,8 @@ void skb_scrub_packet(struct sk_buff *skb, bool xne=
t);
>  struct sk_buff *skb_segment(struct sk_buff *skb, netdev_features_t featu=
res);
>  struct sk_buff *skb_segment_list(struct sk_buff *skb, netdev_features_t =
features,
>                                  unsigned int offset);
> +struct sk_buff *skb_segment_list_csum_help(struct sk_buff *segs,
> +                                          netdev_features_t features);
>  struct sk_buff *skb_vlan_untag(struct sk_buff *skb);
>  int skb_ensure_writable(struct sk_buff *skb, unsigned int write_len);
>  int skb_ensure_writable_head_tail(struct sk_buff *skb, struct net_device=
 *dev);
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 41beaf625421..be3fa938e1da 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -4782,6 +4782,46 @@ struct sk_buff *skb_segment_list(struct sk_buff *s=
kb,
>  }
>  EXPORT_SYMBOL_GPL(skb_segment_list);
>
> +/**
> + * skb_segment_list_csum_help - finish the checksums of fraglist segment=
s
> + * @segs: segments built by skb_segment_list(), with their final headers
> + * @features: features of the output path
> + *
> + * The segments built by skb_segment_list() all have the ip_summed of th=
e
> + * GRO head. If the aggregated packets were CHECKSUM_PARTIAL, e.g. recei=
ved
> + * from virtio-net or veth, compute the checksums that the output device
> + * can't offload, as skb_segment() does for the segments it builds.
> + * Segments that are GSO packets themselves (TCP fraglist GRO can chain
> + * those) are left alone, as skb_checksum_help() can't handle them.
> + *
> + * Return: @segs, or an error pointer after freeing the segments.
> + */
> +struct sk_buff *skb_segment_list_csum_help(struct sk_buff *segs,
> +                                          netdev_features_t features)
> +{
> +       struct sk_buff *seg;
> +       int err;
> +
> +       if (segs->ip_summed !=3D CHECKSUM_PARTIAL)
> +               return segs;

Common case is a device able to checksum these packets. Please add an
early return when @features allows it, instead of calling
skb_csum_hwoffload_help() on up to 64 segments for nothing.


> +
> +       for (seg =3D segs; seg; seg =3D seg->next) {
> +               if (skb_is_gso(seg))
> +                       continue;
> +
> +               err =3D skb_csum_hwoffload_help(seg, features);

This relies on seg->csum_start being correct. skb_segment_list() adjusts
nskb->transport_header by len_diff, but not csum_start. len_diff should
be 0 in practice, but validate_xmit_skb() resets the transport header
from csum_start before calling skb_csum_hwoffload_help(), this path
does not.

> +               if (err) {
> +                       kfree_skb_list(segs->next);
> +                       segs->next =3D NULL;
> +                       /* drop the extra reference skb_segment_list() to=
ok */
> +                       kfree_skb(segs);

This is correct, but it depends on the skb_get() done at the end of
skb_segment_list(). Please make this coupling more visible (a comment
in skb_segment_list(),


> +                       return ERR_PTR(err);
> +               }
> +       }
> +
> +       return segs;
> +}
> +
>  /**
>   *     skb_segment - Perform protocol segmentation on skb.
>   *     @head_skb: buffer to segment
> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> index e74d99ca9fac..0bb73e7eeff0 100644
> --- a/net/ipv4/tcp_offload.c
> +++ b/net/ipv4/tcp_offload.c
> @@ -92,7 +92,9 @@ static struct sk_buff *__tcp4_gso_segment_list(struct s=
k_buff *skb,
>         if (IS_ERR(skb))
>                 return skb;
>
> -       return __tcpv4_gso_segment_list_csum(skb);
> +       skb =3D __tcpv4_gso_segment_list_csum(skb);
> +
> +       return skb_segment_list_csum_help(skb, features);
>  }
>
>  static struct sk_buff *tcp4_gso_segment(struct sk_buff *skb,
> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index cf07c3c6611a..4a90cdb1a9eb 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -473,9 +473,11 @@ static struct sk_buff *__udp_gso_segment_list(struct=
 sk_buff *skb,
>         udp_set_len_short(udp_hdr(skb), sizeof(struct udphdr) + mss);
>
>         if (is_ipv6)
> -               return __udpv6_gso_segment_list_csum(skb);
> +               skb =3D __udpv6_gso_segment_list_csum(skb);
>         else
> -               return __udpv4_gso_segment_list_csum(skb);
> +               skb =3D __udpv4_gso_segment_list_csum(skb);
> +
> +       return skb_segment_list_csum_help(skb, features);
>  }
>
>  struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
> diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
> index eec3778855eb..e664904020e7 100644
> --- a/net/ipv6/tcpv6_offload.c
> +++ b/net/ipv6/tcpv6_offload.c
> @@ -162,7 +162,9 @@ static struct sk_buff *__tcp6_gso_segment_list(struct=
 sk_buff *skb,
>         if (IS_ERR(skb))
>                 return skb;
>
> -       return __tcpv6_gso_segment_list_csum(skb);
> +       skb =3D __tcpv6_gso_segment_list_csum(skb);
> +
> +       return skb_segment_list_csum_help(skb, features);
>  }
>
>  static struct sk_buff *tcp6_gso_segment(struct sk_buff *skb,
>
> ---
> base-commit: 191aa41548b2d2b6af534a6d5cf84a552435c74c
> change-id: 20261016-fraglist-csum-9851f352f634
>
> Best regards,
> --
> Pierre-Yves Le Borgne <pylaterreur@gmail.com>
>
>
