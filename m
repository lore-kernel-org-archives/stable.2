Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793718755;
	b=xN+ZNIiEfh31AWeK4YjXt3gBTI9QC3fFNXQOfWbN1JsXxaELL7dO7ORz+nHbR4Whxwlg
	 MQmu9KVN5A2vXuM5sxH8HWHfZ5f8XkqzvwkaWweooPrFTaEBu7IXNOWgJ+R6SyEz7IS/T
	 OhwYThz6GyfAGbiacwR3SMfqVZlmPZ5c7lnmUfUSEsKc26Pmhc7QT6rwqeOTMvptfUwH4
	 r3cAy/t65jM2Rde36Tgr62DADX9zQfZUocEEnrTmNOEOqpq6N2PdLI2qd1hazqr3HQUGF
	 Z7unyNAa0ZB0dlRCleZEao3kc5PhuTz2eKr2yTY/WOmiEAbMte9Fl1KhXrpHStxv1GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793718755;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ioMKBloi8j06/Yuksq0fEoNgBEE/QiUcMtBCXHMawUc=;
	b=voTcZFwzQLAikCZshreAG/ILiolu0OROYpK3IPz6Le0UBQHbhPICX8pbclOLF6wlJe+Q
	 kk+silhP/y0BWL9Qm9IHYBLuSL07oGTc2hh5DEAMa/ua2S6c0NISnY2GrDV5RrpQ8gzi8
	 CcnRydLbbN9pQVvBKkUhRb1HG6wgz4GvD8votOM8lo8i/Bbx6yXA027UCDEqka1mR4Y8w
	 xV/bfvG+cFgnVyhnjMkVy9JjYRdCJBGjHnuYJ/e8lHkQV5w2HZ+1Npg7qUYwcsDI3mHlo
	 yVif18BEGWCUp8EChMOpHDVqWOHFlXG2UM/HEzlsj3hh25WTyky6SZMhwJl8Kx3ENAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q951GNkx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A07606FCC1;
	Tue,  3 Nov 2026 15:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q951GNkx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9611F00A1F;
	Tue,  3 Nov 2026 15:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793718754;
	bh=ioMKBloi8j06/Yuksq0fEoNgBEE/QiUcMtBCXHMawUc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Q951GNkxOpl1/PcNcViAxWh3/nNbZ89uA2kyZcgpgKjUQQAU5gvu2J5VgSyqPFGW1
	 zmS+WZwysxrhxwq93UbWToVQAH1tsSOQjzl8vw9t40ddcjitpB1f4dtThg1Qs8YFJ0
	 vBrmQfAEVZPE+eZbvAHeMfpmV/Xz5iDSuFrTJXKNFhwIQQl886mEe0brV+NQmykHDX
	 ilVbo36w72zQ3YaRAv6IL5dKCWFpg/gIlGyj+HUKYSb30T5XWo59vfzl9zgNdYrqeP
	 ITahDvk6MLVXEldGGrjKLv+dsvQzmfsVneeP6WeJxD7quR7VTfhwfk5OulcWUE0H8S
	 eZEjh9zSt2xSA==
Subject:
 Re: [PATCH net] ipv6: fix cached route reuse for SO_MARK control messages
From: netdev-bot+sashiko@kernel.org
To: yanxia@cmss.chinamobile.com
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, willemdebruijn.kernel@gmail.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, yana06070@163.com
Date: Tue, 03 Nov 2026 15:12:33 +0000
Message-ID: <179371875338.488856.4546363285391899557@kernel.org>
In-Reply-To: <20261030141435.779302-1-yanxia@cmss.chinamobile.com>
References: <20261030141435.779302-1-yanxia@cmss.chinamobile.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new check compares the per-message mark with the *current*
  `READ_ONCE(sk->sk_mark)`.
- [Low] The comment block in ip6_sk_dst_check()
  (net/ipv6/ip6_output.c:1105-1121) lists the validity conditions as '1.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch's
  own root-cause analysis covers it: ip6_sk_dst_lookup_flow() always…
- [Low] tools/testing/selftests/net/cmsg_so_mark.sh never exercises the
  connected-socket cached-route path this patch fixes.

--

ipv6: fix cached route reuse for SO_MARK control messages

This patch makes ip6_sk_dst_check() reject the socket's cached dst when
the per-message flowi6_mark differs from sk->sk_mark. The goal is for a
connected IPv6 UDP socket that sends with an SO_MARK control message to
get a fresh route lookup with the requested mark.

> A two-interface test also confirms that marked sends use the selected
> interface and subsequent sends without a control message still use the
> socket mark. cmsg_so_mark.sh passes before and after.

[Severity: Low]
This is a pre-existing issue, but does cmsg_so_mark.sh ever reach the
cached-route path this patch changes?

In tools/testing/selftests/net/cmsg_sender.c, main() only creates the
socket and then calls sendmsg() to an explicit destination. It never calls
connect():

	fd = socket(ai->ai_family, opt.sock.type, opt.sock.proto);

So no dst is ever cached for the socket mark. That matches the test
passing both before and after the fix.

The script also has a dead branch. The loop only iterates over:

	for ovr in setsock cmsg both; do

so this line never takes effect:

	    [ $ovr == "diff" ] && m="-M $((MARK + 1)) -m"

Would it make sense to add a connected-socket case to the selftest along
with this fix?

> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index 25fe0ba98b1a6..843bb95e635b9 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -1125,6 +1125,7 @@ static struct dst_entry *ip6_sk_dst_check(struct sock *sk,
>  	    ip6_rt_check(&rt->rt6i_src, &fl6->saddr,
>  			 np->saddr_cache ? &np->saddr : NULL) ||
>  #endif
> +	    fl6->flowi6_mark != READ_ONCE(sk->sk_mark) ||
>  	   (fl6->flowi6_oif && fl6->flowi6_oif != dst_dev(dst)->ifindex)) {

[Severity: Medium]
Can a concurrent setsockopt(SO_MARK) still let a cmsg-marked send reuse a
route that was looked up under the old mark?

The new check compares the per-message mark with the current sk->sk_mark.
It does not compare it with the mark the cached dst was looked up under.

The uncorked udpv6_sendmsg() path runs without the socket lock.
__sock_set_mark() runs under lock_sock() and does:

	WRITE_ONCE(sk->sk_mark, val);
	sk_dst_reset(sk);

Suppose the cache holds dst_A, looked up with mark M1, and sk_mark == M1:

CPU0 (sendmsg with SO_MARK cmsg M2)
udpv6_sendmsg()
    fl6->flowi6_mark = ipc6.sockc.mark;     /* M2 */
    ip6_sk_dst_lookup_flow()
        sk_dst_check()                       /* takes ref on dst_A */

CPU1
setsockopt(SO_MARK, M2)
    __sock_set_mark()
        WRITE_ONCE(sk->sk_mark, val);        /* M2 */
        sk_dst_reset(sk);

CPU0
        ip6_sk_dst_check()
            M2 == READ_ONCE(sk->sk_mark)     /* dst_A accepted */

The packet then goes out with skb->mark M2 on the route chosen for M1.
With the prohibit-route reproducer from the commit message, that send
would succeed instead of returning EACCES.

There is a related window as well. Suppose a send without a cmsg read M1
before the setsockopt(). It fails the new check, looks up a fresh route
with M1, and stores it with ip6_sk_dst_store_flow() after the reset.

The cache then holds an M1 route while sk_mark == M2, and later sends pass
the new check. That store-after-reset race predates this patch. Still, it
means sk_mark is not a reliable record of the mark used for the cached
dst's lookup.

Would it close both windows to skip the cache when a cmsg mark is
supplied, or to store the lookup mark next to the cached dst?

[Severity: Low]
This isn't a bug, but the comment block above this if() in
ip6_sk_dst_check() still lists only two conditions:

	 * 1. ip6_rt_check(): If route was host route,
	 ...
	 * 2. oif also should be the same.

Could it be updated to mention the mark comparison? The preamble also
still says "we do not support routing by source, TOS, and MSG_DONTROUTE".

[Severity: High]
This isn't a bug introduced by this patch, but the root cause in the
commit message seems to reach beyond the mark.

ip6_sk_dst_lookup_flow() always consults the socket dst cache. The
connected flag only decides whether a new lookup is stored:

	struct dst_entry *dst = sk_dst_check(sk, inet6_sk(sk)->dst_cookie);

	dst = ip6_sk_dst_check(sk, dst, fl6);
	if (dst)
		return dst;

fib6_rule_match() also routes on other per-message keys, and
ip6_sk_dst_check() still does not compare them:

	if ((r->dscp ^ ip6_dscp(fl6->flowlabel)) & r->dscp_mask)
		return 0;

	if ((r->flowlabel ^ flowi6_get_flowlabel(fl6)) & r->flowlabel_mask)
		return 0;

The destination port is matched too. With CONFIG_IPV6_SUBTREES=n, the
source address is not checked either.

For a connected socket, ip6_datagram_flow_key_init() looked up the cached
dst with ip6_make_flowinfo(np->tclass, np->flow_label) and inet_dport.
udpv6_sendmsg() can build fl6 from different values and still reuse that
dst:

  - an IPV6_TCLASS cmsg. ip6_datagram_send_ctl() accepts it with only a
    range check, and it is folded in by
    fl6->flowlabel = ip6_make_flowinfo(ipc6.tclass, fl6->flowlabel);
  - sin6_flowinfo with IPV6_FLOWINFO_SEND
  - sendto() to the connected daddr with a different port

In these cases, do fib6 rules keyed on dsfield, flowlabel or dport ever
get consulted? That includes rules with prohibit, blackhole or
other-table actions.

ping_v6_sendmsg() looks to have the same problem with IPV6_TCLASS:

	dst = ip6_sk_dst_lookup_flow(sk, &fl6, daddr, false);

An SO_MARK cmsg requires CAP_NET_RAW or CAP_NET_ADMIN. The IPV6_TCLASS
cmsg requires no capability. setsockopt(IPV6_TCLASS) already calls
sk_dst_reset(), so tclass is treated as a routing key elsewhere.

For comparison, IPv4 udp_sendmsg() clears connected on any cmsg or
explicit address. It only consults the socket cache when connected:

	if (connected)
		rt = dst_rtable(sk_dst_check(sk, 0));

Could the IPv6 path skip the socket cache whenever per-message routing
inputs are present, as IPv4 does? That would cover all of these keys at
once instead of adding them to ip6_sk_dst_check() one at a time.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261030141435.779302-1-yanxia%40cmss.chinamobile.com
