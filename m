Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795498741;
	b=mBPpnkyas7Pe8ElSy9s8IHXE2WVx6OQ9iHkHZ0888249FY4Z+fsleMmLEag7Om5tJhIM
	 Hx3Z9KntnmMDD7WELP+9cJ6wItrz/M8OAeFts/LIhuuEOPMgrYzZzYTqdvfVPfQyxE0/Z
	 HK/UmrQ4TeFUk5RK7OIEUupO557DvN6klf02n6SEjq3NifMf5/tOxOGfhRKAhDYo7Eiu/
	 eMTxMj8faqhbEKHB3oBvg2r4MY8NaKTRnNt4GHq8r44JOdJh2hZcQeLgdPVjDoMYzqCxp
	 Rnmfxht4gox3ApiIpfVaKnOB1uaSD2rxqmwC8fnojZfIKE/i18aKvHXSv/hQSi04Arg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795498741;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=npJbQvk8UMz5QtPOfLc1/x+H4HQkgKEYsqkXjIBQhNg=;
	b=idiq9wudSBe83MMLOgQx5kIp02AQVeUemxfxrAHVAxH8mMhH4kc2liUu/q6bIRxfrb8M
	 3oDDWLsc5+72OLJ6F3unVm5p/A9ryYEN1AKdgu/BcDCkXeIs7u2FSvQVn0xkPZB695SEY
	 jYyDjEUXDsci4n4/u7JEyPf0lvlk155q1zuDoUY64QCXCi/Zl1GvtfC+9X3d+N+Txb6c2
	 O51RpBDwesjMh5LDsFZR0MGM2gLGbwleLenmn2u2EdfEjHoMnFK44CrnYGvRHhNDJVGlE
	 oak6YVD33UAckD16ACn0snR6/vPTq+yWbah4Q0/KpuksjoLw0m3XOgBXNEk/N9ETaug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FVAvy7OB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98B6606A699;
	Tue, 24 Nov 2026 05:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FVAvy7OB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F6751F000E0;
	Tue, 24 Nov 2026 05:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795498741;
	bh=npJbQvk8UMz5QtPOfLc1/x+H4HQkgKEYsqkXjIBQhNg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FVAvy7OBB5qzBMdYVNU4VCFlAeeYvHHERmIRBIk215KoerfyMA8tM4ZOH3lTW5jH+
	 rYIH3R7uZfCyO58/yGfJpvYMrgeuXoDT0XAlCoi1/GOzHuQh3e8weosFHjC3JgAnyg
	 5/BZhurBDy2o6cWWzbN3aApHFaKjdwRYtHnF971zentuesdtdk0V6lMO4X/7a9RIOU
	 inc1mg8MD00T9T1XnKq+UjO6EVYtdNTG076K5guueGNhC3SS3uLh/79dOAfNXtntt6
	 xqqwM7wGvJQWaQH9If879KK//d0q7ijlAAEHSZzLV6qrJbu5SrdO85voAX06OLNzqJ
	 4aaYD5/79tutw==
Subject: Re: [PATCH net] pfkey: fix kernel stack leak in pfkey_migrate()
From: netdev-bot+sashiko@kernel.org
To: bsdhenrymartin@gmail.com
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, ipsec@lists.linux.dev,
 stable@vger.kernel.org
Date: Tue, 24 Nov 2026 05:39:00 +0000
Message-ID: <179549874061.3135.6550381232746686569@kernel.org>
In-Reply-To: <20261120052814.3686573-1-bsdhenrymartin@gmail.com>
References: <20261120052814.3686573-1-bsdhenrymartin@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete: pfkey_migrate() (net/key/af_key.c) still
  leaks kernel stack through the uninitialized `struct xfrm_kmaddress k`.
- [Low] The commit message understates the leak and leaves out its most
  direct path.

--

pfkey: fix kernel stack leak in pfkey_migrate()

This commit zero-initializes the on-stack struct xfrm_migrate m[]
array in pfkey_migrate(). The unused 12 bytes of each AF_INET
xfrm_address_t then no longer carry stack residue into the cloned
xfrm_state or back to userspace.

> pfkey_migrate() declares struct xfrm_migrate m[XFRM_MAX_DEPTH] on the
> stack without initializing it. For AF_INET endpoints
> pfkey_sockaddr_extract() writes only the 4-byte a4 member, leaving
> the remaining 12 bytes of each xfrm_address_t as stack residue.
> xfrm_state_clone_and_setup() then memcpy()s the full 16-byte
> new_daddr and new_saddr into the cloned xfrm_state, and a subsequent
> XFRM_MSG_GETSA dump copies them back to userspace as-is. Each
> migrated SA leaks 24 bytes of kernel stack, which can contain kernel
> pointers.

[Severity: Low]
Is this description of the leak complete? Every successful migrate
also goes through the key manager notification path:

xfrm_migrate()
  km_migrate()
    xfrm_send_migrate()
      build_migrate()
        copy_to_user_migrate()

net/xfrm/xfrm_user.c:copy_to_user_migrate() {
    ...
	memcpy(&um.old_daddr, &m->old_daddr, sizeof(um.old_daddr));
	memcpy(&um.old_saddr, &m->old_saddr, sizeof(um.old_saddr));
	um.new_family = m->new_family;
	memcpy(&um.new_daddr, &m->new_daddr, sizeof(um.new_daddr));
	memcpy(&um.new_saddr, &m->new_saddr, sizeof(um.new_saddr));
    ...
}

The result is multicast to XFRMNLGRP_MIGRATE listeners without any
GETSA request. For AF_INET, that was 48 uninitialized bytes per m[]
entry (old_daddr, old_saddr, new_daddr and new_saddr). This included
entries that matched no SA.

The = {} change does close this path for m[], so the code looks fine
for m[].

Could the commit message describe the multicast path and the
per-entry size as well?

> diff --git a/net/key/af_key.c b/net/key/af_key.c
> index d215b33b7492c..6d116862b20d8 100644
> --- a/net/key/af_key.c
> +++ b/net/key/af_key.c
> @@ -2571,7 +2571,7 @@ static int pfkey_migrate(struct sock *sk, struct sk_buff *skb,
>  	struct sadb_x_policy *pol;
>  	struct sadb_x_ipsecrequest *rq;
>  	struct xfrm_selector sel;
> -	struct xfrm_migrate m[XFRM_MAX_DEPTH];
> +	struct xfrm_migrate m[XFRM_MAX_DEPTH] = {};
>  	struct xfrm_kmaddress k;

[Severity: High]
Can pfkey_migrate() still leak kernel stack through k here?

When the request carries a SADB_X_EXT_KMADDRESS extension, only
parse_sockaddr_pair() fills k.local and k.remote:

	ret = parse_sockaddr_pair((struct sockaddr *)(kma + 1),
				  8*(kma->sadb_x_kmaddress_len) - sizeof(*kma),
				  &k.local, &k.remote, &k.family);

That call goes through pfkey_sockaddr_extract(). For AF_INET it writes
only 4 of the 16 bytes:

	case AF_INET:
		xaddr->a4 =
			((struct sockaddr_in *)sa)->sin_addr.s_addr;
		return AF_INET;

pfkey_migrate() then passes kma ? &k : NULL to xfrm_migrate(). On
success, the key manager path copies out the full addresses:

xfrm_migrate()
  km_migrate(sel, dir, type, m, num_migrate, k, net, encap)
    xfrm_send_migrate()
      build_migrate()
        copy_to_user_kmaddress()

net/xfrm/xfrm_user.c:copy_to_user_kmaddress() {
	...
	memset(&uk, 0, sizeof(uk));
	uk.family = k->family;
	uk.reserved = k->reserved;
	memcpy(&uk.local, &k->local, sizeof(uk.local));
	memcpy(&uk.remote, &k->remote, sizeof(uk.remote));

	return nla_put(skb, XFRMA_KMADDRESS, sizeof(uk), &uk);
}

xfrm_send_migrate() then multicasts this to XFRMNLGRP_MIGRATE. For an
AF_INET kmaddress, would 24 bytes of uninitialized stack (12 from
k.local and 12 from k.remote) still reach userspace?

On the netlink side, xfrm_do_migrate() and copy_from_user_migrate()
fill the kmaddress with full 16-byte copies. pfkey appears to be the
only producer that passes in a partially written k.

pfkey_create() only checks ns_capable(net->user_ns, CAP_NET_ADMIN).
That is the same privilege level needed for the GETSA leak described
in the commit message.

Should this also be struct xfrm_kmaddress k = {}; ?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261120052814.3686573-1-bsdhenrymartin%40gmail.com
