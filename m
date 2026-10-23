Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792757848;
	b=VLwSZWvr5Tc2mcINT/SWHeZEukNtlzoDzL6X4jJ0K/Ehur1pi9XYigsW+Yoj2UqDYnej
	 2E/tzXUKdmymC01ar/t0cQx4fbwDx3YyopYvqXjZ3H0LIQpPmQFHskVkvxnwdd5Ph56P1
	 LCNBNBeBKDx67QOTvWQ5uyBfNe69si9JFRE1kI65HRp2tDw/6dBdTXSv/ETUFtCOA4O0R
	 HvQ+WfLTfv3aC/ZPSBVSiKfeziUYajOXBTjEt8idI5U4QgKc/jGrAAgEHCI5RllE2dKJL
	 N5z8tFV1OPZgNzk4SnHHhvu4wCp2D+cCVlQ5G5rmMymByoUhKMjqzatBh5/rztQ5rLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792757848;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=lxYi6lYgPezmPFyKxvqAdM5ywA+AGWlloT6U0eWiBso=;
	b=ysoiAZTRe/UyZLSwX1M9z7W3tpTlTBXPsZYxaF6hTvW6ysqD0uCIfJ5AubLcTs8wQ3i7
	 XSSJVz+VvzHBXRm8pDn4iLJIYXj2pXzjC+eWY0lSj5/TpSeRb4XctMljPm4uSPE8Jm+F1
	 PSHFhbjnrv6l1gyInVLznCqDbxvfDfkaVscCSqNoCF0VfMHk/mNGMlx2SJcIwwZ/twTfr
	 EsFCNX7zilf8WnlcyKRTEuQFAqcURpJ2HJUOAUG8rQs/+K6+VYNRMr5YIc2ruLiFTvuRS
	 klsQ8YA0Vje2cqaavjZGJ+fIOegKdjPQC0w+avIAEAr1EnOfYV2UgsDPZdrc2Fq8w+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dMn1x0lY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040D9606A323;
	Fri, 23 Oct 2026 12:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dMn1x0lY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4FC1F01825;
	Fri, 23 Oct 2026 12:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792757847;
	bh=lxYi6lYgPezmPFyKxvqAdM5ywA+AGWlloT6U0eWiBso=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dMn1x0lYN4tEAqwyM4/kfiA9V3zPfVzDUcgWvwlJNIQAdJgUj8LnvDw0gFPXAikEb
	 nClGqDqrqXx+bVJpAJSxC18xROpnfUs9EhJfmOy65G0bRd4Y5KEoTIUX9wNTpSWB8L
	 ZUGD2s4Suz6npLUXH9mbxJQb97pMYucDOG47d97B0Uil+WiglZll5oehkSTb73eYMM
	 Sc4UbK0VKaf49QkffjNHK/HRlLccObzR4ml7Ckt7pOU52Hft6li3HJXqP9mxhXmu0+
	 baCGDfb1hkf2rqXyp59bopzr4hyxT9GoJQdWL0jKat55txhm8K5WJ8q0z+pLvSeh3Z
	 cRdpTkc11le7w==
Subject:
 Re: [PATCH net 3/7] ovpn: reject UDP remotes incompatible with socket family
From: netdev-bot+sashiko@kernel.org
To: antonio@openvpn.net
Cc: netdev@vger.kernel.org, ralf@mandelbit.com, sd@queasysnail.net,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, stable@vger.kernel.org
Date: Fri, 23 Oct 2026 12:17:26 +0000
Message-ID: <179275784657.3134.14079628149115069764@kernel.org>
In-Reply-To: <20261022121606.732029-4-antonio@openvpn.net>
References: <20261022121606.732029-4-antonio@openvpn.net>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] In this commit, ovpn_nl_udp_remote_compatible()
  (drivers/net/ovpn/netlink.c) checks sk->sk_family and…
- [Low] The concern says the new rejection in
  ovpn_nl_udp_remote_compatible() (AF_INET6 socket + ipv6_only_sock() +…
- [Low] The concern says the NULL inet6_sk(sk) dereference the commit
  message describes is still reachable through the RX float path.

--

ovpn: reject UDP remotes incompatible with socket family

This commit adds ovpn_nl_udp_remote_compatible(). It rejects UDP remotes
that the attached socket cannot use when a peer is created or modified
over netlink: an IPv6 remote on an AF_INET socket, or an IPv4 remote on an
IPv6-only socket. The remote endpoint is now parsed once in the new/set
paths and passed to ovpn_nl_peer_modify(), and the commit message notes
that the transmit path still has to re-check the socket later.

> diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
> index 1af7e0e624ba6..bf27a7a89f76b 100644
> --- a/drivers/net/ovpn/netlink.c
> +++ b/drivers/net/ovpn/netlink.c

[ ... ]

> @@ -383,12 +385,45 @@ static int ovpn_nl_peer_modify(struct ovpn_peer *peer, struct genl_info *info,
>  	return ret;
>  }
>  
> +/**
> + * ovpn_nl_udp_remote_compatible - check if a UDP socket can use a remote

[ ... ]

> +static int ovpn_nl_udp_remote_compatible(const struct sock *sk,
> +					 const struct sockaddr_storage *remote,
> +					 struct netlink_ext_ack *extack)
> +{
> +	const unsigned short sock_family = READ_ONCE(sk->sk_family);

[Severity: Low]
This check reads sk->sk_family and ipv6_only_sock(sk) once, without
lock_sock(), while the PEER_NEW/PEER_SET request is handled. In
ovpn_nl_peer_set_doit() it runs under rcu_read_lock(), and that lock is
dropped before ovpn_nl_peer_modify() installs the new bind.

The commit message says:

  The transmit path therefore still has to re-check socket/remote
  compatibility before sending.

At this commit, ovpn_udp_output() still picks ovpn_udp4_output() or
ovpn_udp6_output() based only on bind->remote.in4.sin_family. A later
IPV6_V6ONLY or IPV6_ADDRFORM change is therefore not caught on TX.

Is this patch meant to be complete on its own for stable? The next patch
in the series, "ovpn: recheck UDP socket family before transmit", adds the
sock_family check in ovpn_udp_output() and closes this gap. It looks like
the two patches need to be backported together.

> +
> +	if (sock_family == AF_INET && remote->ss_family == AF_INET6) {
> +		NL_SET_ERR_MSG_FMT_MOD(extack,
> +				       "UDP socket is IPv4 but remote is IPv6");
> +		return -EAFNOSUPPORT;
> +	}

[Severity: Low]
This rejects an IPv6 remote on an AF_INET socket when the remote comes from
netlink. Can the same mismatched bind still be installed through the RX
float path, which does not go through this helper?

drivers/net/ovpn/io.c:ovpn_recv() {
    ...
	if (sock && sock->sk->sk_protocol == IPPROTO_UDP)
		/* check if this peer changed local or remote endpoint */
		ovpn_peer_endpoints_update(peer, skb);
    ...
}

ovpn_peer_endpoints_update() updates the bind from the received packet and
does not look at the socket family. If the bind becomes AF_INET6 on a peer
whose socket is AF_INET, the next transmit would take this path:

ovpn_udp_output()
  ovpn_udp6_output()
    ip6_dst_lookup_flow(sock_net(sk), sk, &fl, NULL)

That path reaches the inet6_sk(sk) NULL dereference described in the
commit message.

At the end of the series, "ovpn: recheck UDP socket family before transmit"
covers this case. Before calling ovpn_udp6_output(), ovpn_udp_output() now
rejects AF_INET6 binds when sock_family != AF_INET6. With that patch, the
only remaining effect is that the floating peer is deleted with a transport
error.

Without that patch, does this commit alone prevent the crash it describes?

> +
> +	if (sock_family == AF_INET6 && ipv6_only_sock(sk) &&
> +	    remote->ss_family == AF_INET) {
> +		NL_SET_ERR_MSG_FMT_MOD(extack,
> +				       "UDP socket is IPv6-only but remote is IPv4");
> +		return -EAFNOSUPPORT;
> +	}

[Severity: Low]
This isn't a bug, but I have a question about this part of the commit
message:

  An IPv4 UDP socket cannot be used with an IPv6 remote endpoint, and an
  IPv6-only UDP socket cannot send to an IPv4 remote endpoint.

At this commit, ovpn_udp4_output() gets the route with
ip_route_output_flow(sock_net(sk), &fl, sk) and does not check
ipv6_only_sock(sk). So ovpn's own TX path would still send in this
configuration.

What actually makes the configuration unusable is the receive side, since
compute_score() in net/ipv4/udp.c skips IPv6-only sockets. The regular
udpv6_sendmsg() behaviour for v4-mapped destinations points the same way.

The next patch in the series adds the matching ipv6_only_sock() check in
ovpn_udp_output(), so the netlink and TX rules agree by the end of the
series. Since this patch rejects a configuration that used to be accepted,
would it be worth making the reasoning clearer here?

> +
> +	return 0;
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261022121606.732029-2-antonio%40openvpn.net
