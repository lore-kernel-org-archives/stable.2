Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795500941;
	b=o85glrL8A80ge62hQo6uusBZBc49BkoIwpagubHahwcTSaLFgR1orLL0nAQQr6GcmoGa
	 YAQlF5Kzb9xkh2iMKaomvkDD2Xyparupcqrbr/ThbCJjDyC3Q1uS515q5hDaNoLUhXjDB
	 vmCU/TWQz74jNLfJVCUxvsv/j6A0Re1j7K326jqtfNk6mR17IWGQhQitpoZDZt38ZC/0l
	 dILRHoQicaeMXKIlVc1tRBaEimeqHgqLI2GZrIdT1jcLfzg+6HUEatT5Ag6RIhOF1opMM
	 8txjIToatiy+Y1ozq8RPMExA59tBN55QISgW/H/qHSECPZUPni8Le8kyOHmP5gyJxkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795500941;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=uDZC+P4Da5jRQcoboJ4MWG9rGRlHDkVqQQb00j1n3L0=;
	b=zZqRNaBEpZnzbwwuuJFtLTZEV9Io78qTVA18X74kPAKxdLg0ZvD7qkLKPQrioSo5YJMW
	 WLPHQcoWtiWQQHVczmRH3ShduAKym4HhPBzgsZqfqHZWepQQXxvkF9AAOryl0gRl2QTsm
	 HjJgi0dmk7Iq/CKdzqnbf54RISQGnWLE3x49vooWAFc61RuEZwjlYKLDtGvjjZKO1qRPz
	 oJb68Cz9Nyp7aqKE9X/sYUF4IOG8KrDe9IWKDA0w4IueLyZ4f4t0W58yiyKxkIbFVTf4N
	 6lM8D1JszwUZ5OIs9UFD/Z1pH7zEl+q0IwaFLy4lR64BE0qgHlTACwdOOMJmVZMui9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LzfJKbBc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE65606A321;
	Tue, 24 Nov 2026 06:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LzfJKbBc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159251F000CF;
	Tue, 24 Nov 2026 06:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795500941;
	bh=uDZC+P4Da5jRQcoboJ4MWG9rGRlHDkVqQQb00j1n3L0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LzfJKbBc75VmXtddN4h35tQmy1W3XgVh2bw1sQMWfUYdM09kTeNCfF2C/UghRZRZD
	 nMX8CXDQQ8lgv3kUBj/a+JwYIEauRfoXovtUZMFlmbZGojUCZJ4+vSUwve5/dZAaQR
	 GtyT6yUr2IHGrsa9Fp7bKKYplIst7ix5a8+JFxQpX9Q1drX9Vw2UhPSK4lHToRSH+K
	 s466FH06THGYWrjnxvfL7L9jZnhkUJA+C37N332JGTA+OMIn6hTN5khnIafNYQPG7X
	 xzfGvgYmiXlXEjxI/kT5K3kV+v1foI7POKm9V6iPaIjVZ7qzplk6hEUvTDPkCydIUo
	 pjKQ+k9sZsZ8A==
Subject:
 Re: [PATCH net] ip_gre: fix stale header length after erspan version change
From: netdev-bot+sashiko@kernel.org
To: bsdhenrymartin@gmail.com
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 yun.zhou@windriver.com, maoyixie.tju@gmail.com, luoxuanqiang@kylinos.cn,
 i.maximets@ovn.org, fnordahl@ubuntu.com, netdev@vger.kernel.org,
 stable@vger.kernel.org
Date: Tue, 24 Nov 2026 06:15:39 +0000
Message-ID: <179550093955.3135.12735380175451579748@kernel.org>
In-Reply-To: <20261120060254.3766851-1-bsdhenrymartin@gmail.com>
References: <20261120060254.3766851-1-bsdhenrymartin@gmail.com>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 0 · High: 3 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] erspan_changelink() (net/ipv4/ip_gre.c:1535) takes its 'old'
  header length from `int len = t->hlen;`.
- [High] erspan_netlink_parms() (net/ipv4/ip_gre.c:1271) writes
  `t->erspan_ver = nla_get_u8(data[IFLA_GRE_ERSPAN_VER])` straight into…
- [High] erspan_calc_hlen() (net/ipv4/ip_gre.c:1361) sets tun_hlen=8 for
  every v1/v2 tunnel without looking at t->parms.o_flags.
- [Medium] The recompute in erspan_changelink() only runs when
  `data[IFLA_GRE_ERSPAN_VER]` is present (net/ipv4/ip_gre.c:1534).
- [Medium] erspan_changelink() updates fields the lockless transmit path
  depends on in two separate steps.
- [Low] The new `dev->needed_headroom += len;` in erspan_changelink()
  (net/ipv4/ip_gre.c:1540) does not go through…
- [Low] The new `dev->needed_headroom += len;` in erspan_changelink()
  (net/ipv4/ip_gre.c:1540) is a plain read-modify-write under RTNL.

--

ip_gre: fix stale header length after erspan version change

This patch moves the ERSPAN header length calculation out of
erspan_tunnel_init() into a new helper, erspan_calc_hlen(). The helper is
then called from erspan_changelink() when IFLA_GRE_ERSPAN_VER is present.
The change in t->hlen is applied as a delta to dev->needed_headroom and,
unless IFLA_MTU is given, to dev->mtu.

> diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
> index 5485586fa0e62..8acaefca64dad 100644
> --- a/net/ipv4/ip_gre.c
> +++ b/net/ipv4/ip_gre.c
> @@ -1351,7 +1351,7 @@ static const struct net_device_ops gre_tap_netdev_ops = {
>  	.ndo_fill_metadata_dst	= gre_fill_metadata_dst,
>  };
>  
> -static int erspan_tunnel_init(struct net_device *dev)
> +static void erspan_calc_hlen(struct net_device *dev)
>  {
>  	struct ip_tunnel *tunnel = netdev_priv(dev);
>  
> @@ -1360,9 +1360,16 @@ static int erspan_tunnel_init(struct net_device *dev)
>  	else
>  		tunnel->tun_hlen = 8; /* 8-byte GRE hdr. */

[Severity: High]
Can a v1/v2 tunnel end up with tun_hlen = 8 while gre_build_header() only
writes 4 bytes?

erspan_calc_hlen() picks tun_hlen from the version alone. The number of
bytes actually written depends on the flags erspan_xmit() passes, which
are o_flags with KEY always cleared:

net/ipv4/ip_gre.c:erspan_xmit() {
    ...
	__clear_bit(IP_TUNNEL_KEY_BIT, flags);
	__gre_xmit(skb, dev, &tunnel->parms.iph, proto, flags);
    ...
}

erspan_validate() only checks the OR of IFLA_GRE_OFLAGS and
IFLA_GRE_IFLAGS, so o_flags can lack SEQ. Two ways to get there:

- OFLAGS=KEY with IFLAGS=SEQ|KEY (iproute2 "iseq okey")
- OFLAGS absent, where ipgre_netlink_parms() memsets parms and o_flags
  ends up 0

erspan_changelink() then copies p.o_flags into t->parms.o_flags.

With SEQ missing, erspan_xmit() passes no flags. gre_build_header(skb, 8,
...) then pushes 8 bytes but writes only greh->flags and greh->protocol.
Bytes 4-7 are uninitialized headroom and are sent to the peer.

Before this patch, a v0 -> v1/v2 changelink with such flags kept
tun_hlen = 4. Now erspan_calc_hlen() sets tun_hlen = 8, which leads to
the same leak the commit message describes. The same state can also be
set up at newlink time.

Would it be better to compute tun_hlen from the emitted flags, as
gre_calc_hlen() does, or to force SEQ for v1/v2?

> -	tunnel->parms.iph.protocol = IPPROTO_GRE;
>  	tunnel->hlen = tunnel->tun_hlen + tunnel->encap_hlen +
>  		       erspan_hdr_len(tunnel->erspan_ver);
> +}

[ ... ]

> @@ -1524,6 +1531,19 @@ static int erspan_changelink(struct net_device *dev, struct nlattr *tb[],
>  	ip_tunnel_flags_copy(t->parms.i_flags, p.i_flags);
>  	ip_tunnel_flags_copy(t->parms.o_flags, p.o_flags);
>  

[Severity: High]
What happens to erspan_ver if ip_tunnel_changelink() fails?

erspan_netlink_parms() writes the new version into the live tunnel
before ip_tunnel_changelink() runs:

net/ipv4/ip_gre.c:erspan_netlink_parms() {
    ...
	if (data[IFLA_GRE_ERSPAN_VER]) {
		t->erspan_ver = nla_get_u8(data[IFLA_GRE_ERSPAN_VER]);
    ...
}

On error, erspan_changelink() returns before it reaches the new
erspan_calc_hlen() block:

	err = ip_tunnel_changelink(dev, tb, &p, fwmark);
	if (err < 0)
		return err;

ip_tunnel_changelink() can fail in three ways:

- -EEXIST when the new parameters match another tunnel in
  ip_tunnel_find()
- -EINVAL on the erspan0 fallback device
- -ENODEV while the device is unregistering

Take a v1 tunnel that receives ERSPAN_VER=0 with remote/key matching
another tunnel. It gets -EEXIST but keeps erspan_ver = 0 and
tun_hlen = 8. erspan_xmit() then clears SEQ and KEY, and __gre_xmit()
pushes 8 bytes but writes only 4. That sends 4 bytes of uninitialized
headroom to the peer in every packet.

In the other direction, a failed v0 -> v1/v2 changelink leaves
tun_hlen = 4 while the larger ERSPAN header is built.

Isn't this the same leak the commit message says it fixes?

> +	if (data && data[IFLA_GRE_ERSPAN_VER]) {

[Severity: Medium]
Should this recompute run on every changelink, not only when
IFLA_GRE_ERSPAN_VER is present?

A changelink with only IFLA_GRE_ENCAP_* attributes (plus the flags
erspan_validate() requires) still runs ip_tunnel_encap_setup(). That
drops the ERSPAN header length from t->hlen:

net/ipv4/ip_tunnel.c:ip_tunnel_encap_setup() {
    ...
	WRITE_ONCE(t->encap_hlen, hlen);
	WRITE_ONCE(t->hlen, hlen + t->tun_hlen);
    ...
}

The truncation predates this patch, but the new delta logic builds on
it. A later changelink with only ERSPAN_VER=1 and no encap attributes
reads the truncated baseline (8 + enc) and recomputes 8 + enc + 12. It
then adds 12 to needed_headroom and subtracts 12 from the MTU, even
though nothing changed.

The IPv6 code cited in the commit message,
ip6erspan_tnl_change()->ip6erspan_tnl_link_config()->ip6erspan_calc_hlen(),
recomputes hlen and assigns needed_headroom absolutely on every
changelink:

	tunnel->dev->needed_headroom = LL_MAX_HEADER + t_hlen;

Would following that model remove the dependency on the previously
stored t->hlen?

> +		int len = t->hlen;

[Severity: High]
Is t->hlen still the old ERSPAN header length at this point?

ipgre_newlink_encap_setup() runs earlier in erspan_changelink(). If any
IFLA_GRE_ENCAP_TYPE/FLAGS/SPORT/DPORT attribute is present,
ip_tunnel_encap_setup() has already overwritten t->hlen without the
erspan_hdr_len() term:

	WRITE_ONCE(t->hlen, hlen + t->tun_hlen);

erspan_calc_hlen() then adds erspan_hdr_len() back, so the delta becomes
(tun_new - tun_old) + erspan_hdr_len(new_ver). In practice:

- an unchanged v1 tunnel gains 12 in needed_headroom and loses 12 from
  the MTU on every changelink (16 for v2), until the MTU reaches 68
- a v1 -> v0 change applies -4 instead of -16

iproute2's "ip link set DEV type erspan ..." sends all ENCAP_* attributes
and ERSPAN_VER on every changelink, so a routine change such as ttl
triggers this.

needed_headroom is an unsigned short and the add is not clamped. After
repeated calls it goes past the 512 cap and eventually wraps.
erspan_xmit() then passes that value to
skb_cow_head(skb, dev->needed_headroom).

Before this patch, erspan_changelink() never changed mtu or
needed_headroom. ipgre_link_update() avoids this problem by taking its
delta from tun_hlen, which encap setup does not overwrite.

> +
> +		erspan_calc_hlen(dev);

[Severity: Medium]
Can erspan_xmit() see the new erspan_ver together with the old tun_hlen?

erspan_netlink_parms() sets t->erspan_ver well before this call. In
between, ip_tunnel_changelink() takes tunnels_lock, re-hashes the
tunnel, may call ip_tunnel_bind_dev(), and runs netdev_state_change().

erspan devices are lltx. The transmit path reads tunnel->erspan_ver and
then, separately, tunnel->tun_hlen, without RTNL or tunnels_lock:

net/ipv4/ip_gre.c:erspan_xmit() {
    ...
	if (tunnel->erspan_ver == 0) {
		proto = htons(ETH_P_ERSPAN);
		__clear_bit(IP_TUNNEL_SEQ_BIT, flags);
    ...
}

net/ipv4/ip_gre.c:__gre_xmit() {
    ...
	gre_build_header(skb, tunnel->tun_hlen,
    ...
}

During a v1 -> v0 downgrade, packets sent in that window have SEQ/KEY
cleared while tun_hlen is still 8, so 4 bytes of uninitialized headroom
leak. During v0 -> v1/v2, packets carry the new ERSPAN header with the
old 4-byte GRE header.

The window is much narrower than before. Could the xmit path compute the
GRE length from the same erspan_ver snapshot it uses to build the
header, the way erspan_fb_xmit() computes tunnel_hlen locally?

> +		len = t->hlen - len;
> +		if (len) {
> +			dev->needed_headroom += len;

[Severity: Low]
Should this go through ip_tunnel_limit_headroom()?

The other writers on these paths clamp the value to 512, for example
ip_tunnel_bind_dev():

	dev->needed_headroom = ip_tunnel_limit_headroom(t_hlen + hlen);

ip6gre_tnl_link_config_route() on the IPv6 ERSPAN side does the same.

If needed_headroom is already at the 512 cap, a v0 -> v2 change pushes
it to 532. Combined with the wrong delta above, nothing limits how far
this unsigned short field can grow.

ipgre_link_update() already has the same unclamped pattern, but this
patch adds a new instance on the ERSPAN path.

[Severity: Low]
Can this read-modify-write race with the transmit path?

ip_tunnel_xmit() updates the same field without a lock, from BH, via
ip_tunnel_adj_headroom():

	if (headroom > READ_ONCE(dev->needed_headroom))
		WRITE_ONCE(dev->needed_headroom, headroom);

Suppose xmit reads N, changelink stores N + len, and xmit then stores Y
with N < Y < N + len. The increase from changelink is lost. The plain
access here is also an unannotated data race that KCSAN would report.

> +			if (!tb[IFLA_MTU])
> +				WRITE_ONCE(dev->mtu, max_t(int, dev->mtu - len,
> +							   68));
> +		}
> +	}
> +
>  	return 0;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261120060254.3766851-1-bsdhenrymartin%40gmail.com
