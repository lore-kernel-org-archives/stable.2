Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8718133F8BE;
	Sat,  5 Sep 2026 01:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788570607; cv=none; b=n9i66jNHGd1hq25aBzvxytseYCbtTVG+LrShPLTKgvucRrChtO3csCXJNR3nQIFBCzvaauDyfQuGiPnU73+Jw3XjWj7VDvCEWT7I0w0f42EAt+/YXuxeYRUJ7NJhfwNG4L3sJdcUw/7y9LYiL6kUCebldYsOgEqJSX7xXMj63bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788570607; c=relaxed/simple;
	bh=V46aAqNw3rel46rJ6D6Rm1dOvdxhSNoO2EX0etCF3ZY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=epWfUh3OrWKZ0JAqUmVT+biGF4a6uhPC5W/3MrRI+sZlNlS5EHLDJa9DpSUc7AKP3g0RoJsi9BYVUUmQbhuOLh+C17Tvh26nIGjkMZA7CJFeBndHKWZrxlQQlgl6QvG7HpcG9Fp1Q0npsOl4FPFHCUDM5ngm5zHudSDYBn7216I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8L8bu0/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8L8bu0/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 074CE1F00A3D;
	Sat,  5 Sep 2026 01:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788570605;
	bh=PsCtJK5U4aME92NyemkW5bw0sjJ/eLAjK+qjipZpMiM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=j8L8bu0/xbrYgR6hZ1bFVmfrY4ZOsOsfl+UpUZ602qjIjNErtEm5U5o6+/mFx7ka+
	 v3VMNhhAijWPuXUNIaE32F0ObqJICRHjoxnkkE7H0k+ZP6NCLo9oDzTM/G9aZn7IFI
	 xzg7dOgO2Xx0F5IQKf5bYrtHpRyUdqqIjs4VanRcWhugYTuGih6XS+4dwUt4VJybgy
	 ZUTM6KbOVP4AAon0q72gkz9GeySiu1rkWNZn4/E6krfFP6Vp9ACRJXnWja+on45F4s
	 BT2QI5nWeaMq4WpLSuuBYpI+1oWvovt7+oPIUCCuqaUE98ej7cpsATSm60No/s4CCm
	 rb6e8+tKEux2A==
Subject: Re: [PATCH net v2 1/3] net: cap tx_queue_len at S16_MAX to prevent
 oversized ring allocations
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, donald.hunter@gmail.com, xiyou.wangcong@gmail.com,
 shuah@kernel.org, vega@nebusec.ai, victor@mojatatu.com
Date: Sat, 05 Sep 2026 01:10:04 +0000
Message-ID: <178857060457.219967.5722102971339165062@kernel.org>
In-Reply-To: <QDISC-2899.v2.20260901233641@mojatatu.com>
References: <QDISC-2899.v2.20260901233641@mojatatu.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 2

- [Medium] Unconditional uAPI narrowing of tx_queue_len for every
  netdevice, justified in the commit message by a claim that is…
- [Low] RTM_NEWLINK device-creation bypass of the new S16_MAX cap.
- [Low] The new 32767 upper bound is not recorded in the sysfs ABI
  documentation.

--

net: cap tx_queue_len at S16_MAX to prevent oversized ring allocations

This replaces the unsigned-long truncation test in
netif_change_tx_queue_len() with a hard upper bound of S16_MAX, so that
values above 32767 are rejected with -ERANGE at set time instead of later
driving skb_array/ptr_ring allocations in pfifo_fast, tun and tap.

Closes: https://lore.kernel.org/netdev/20260828121902.66837-1-jhs@mojatatu.com/

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 290e0f099e6b..ecfbd72d5d1a 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -9982,7 +9982,7 @@ int netif_change_tx_queue_len(struct net_device *dev, unsigned long new_len)
>  	unsigned int orig_len = dev->tx_queue_len;
>  	int res;
>  
> -	if (new_len != (unsigned int)new_len)
> +	if (new_len > S16_MAX)
>  		return -ERANGE;

[Severity: Medium]
The commit message justifies the constant with:

  "32767 is chosen as the largest value NLA_POLICY_FULL_RANGE can express
   for the u32 IFLA_TXQLEN policy in patch 2/3"

Is that accurate?  NLA_POLICY_FULL_RANGE() takes a pointer to:

include/net/netlink.h:
	struct netlink_range_validation {
		u64 min, max;
	};

so a u32 bound such as U16_MAX or U32_MAX is expressible there.  The s16
limitation applies to NLA_POLICY_RANGE()/MIN()/MAX(), which embed the
bounds in the policy entry, not to the FULL_RANGE variant.

Since the new check in netif_change_tx_queue_len() applies to all callers
(sysfs tx_queue_len_store(), SIOCSIFTXQLEN, RTM_SETLINK via do_setlink()),
previously accepted configurations such as

	ip link set dev X txqueuelen 65535
	echo 100000 > /sys/class/net/X/tx_queue_len

now return -ERANGE, including for consumers that allocate nothing at set
time and only use the value as a packet-count limit:

net/sched/sch_fifo.c:fifo_init() {
	...
	limit = qdisc_dev(sch)->tx_queue_len;
	...
}

along with gred/plug/sfb limits, htb direct_qlen, qfq max_classes and
teql.  Could the reasoning for narrowing the shared knob be restated
without the FULL_RANGE constraint, or could the bound instead be applied
in the allocating consumers (pfifo_fast_init(), tun/tap ring sizing)?

The same paragraph also says:

  "a negative ifr_qlen from the ioctl lands far above the cap after
   conversion, so both old failure modes are covered by the one
   comparison."

The ioctl path already rejects negatives before the helper is reached:

net/core/dev_ioctl.c:dev_ifsioc() {
	...
	case SIOCSIFTXQLEN:
		if (ifr->ifr_qlen < 0)
			return -EINVAL;
		return dev_change_tx_queue_len(dev, ifr->ifr_qlen);
	...
}

so is the claim about that failure mode being covered here still needed?

[Severity: Low]
The commit message says netif_change_tx_queue_len() "is the single entry
point for IFLA_TXQLEN, sysfs, and the SIOCSIFTXQLEN ioctl", and that on the
fixed kernel RTM_NEWLINK create is also rejected.  With only this patch
applied, does the device creation path still bypass the cap?

net/core/rtnetlink.c:rtnl_create_link() {
	...
	if (tb[IFLA_TXQLEN])
		dev->tx_queue_len = nla_get_u32(tb[IFLA_TXQLEN]);
	...
}

and at this commit the policy imposes no range:

net/core/rtnetlink.c:
	[IFLA_TXQLEN]		= { .type = NLA_U32 },

so ip link add dev X txqueuelen 500000 type dummy stores the oversized
value directly, which pfifo_fast_init() and tap_init()/tun queue attach
then use for ring sizing.

This is closed later in the same series: the follow-up commit "net: reject
oversized tx_queue_len at netlink parse time" changes the policy entry to
NLA_POLICY_FULL_RANGE(NLA_U32, &txqlen_range) with .max = S16_MAX, so all
netlink parse paths reject the attribute before rtnl_create_link() runs.
Mentioning that dependency here would make a partial backport of patch 1
alone less likely to leave the create path uncapped.

[Severity: Low]
Should the sysfs ABI documentation be updated for the new maximum?

Documentation/ABI/testing/sysfs-class-net still describes the attribute
without any upper bound:

	What:		/sys/class/net/<iface>/tx_queue_len
	...
			Indicates the interface transmit queue len in number
			of packets, as an integer value.

while writes above 32767 through tx_queue_len_store() ->
dev_change_tx_queue_len() -> netif_change_tx_queue_len() now fail with
-ERANGE.  The kernel-doc for the exported wrapper dev_change_tx_queue_len()
in net/core/dev_api.c likewise only states "Return: 0 on success, -errno on
failure" and does not mention the 32767 limit.

The netlink half of this is handled inside the series: the follow-up commit
"net: reject oversized tx_queue_len at netlink parse time" adds
checks: max: 32767 to Documentation/netlink/specs/rt-link.yaml, so only the
sysfs ABI text and the wrapper kernel-doc remain unamended.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-2899.v2.20260901233641%40mojatatu.com
