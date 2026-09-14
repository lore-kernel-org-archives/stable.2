Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA06046E019;
	Mon, 14 Sep 2026 13:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789393785; cv=none; b=bIT7kKj8Ou24VotcHt3XiRSW1a0w/biAIfThc0hx4tx3goFD2j7X8awSNnvr9VL/Orw3xLRGYh11t9PIey3SXxrCRm9d5RZS1cob4o0RoMUOjybkypLcm8yAlTMPlyTwO0/RxEVAC2tFXQUCgJMUnk4KCTFOAonYQ9PHRJLCHfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789393785; c=relaxed/simple;
	bh=PQsRjkbtS3bGSyGoCVk5IXnmbVOziKcboJ8bfEmHExo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gA2BgD+FoXOhfTtr8HB+i2KGUBdSS2UvthzVGvj73dhCjJyEw3by0lzFj4cHROvA5rtJyz+Zv6QyWNA3isxUchaALwe/IctzTmMHCVDai1kCE5yPZcYrn/BjvDVtC46PLdtHzPz1BOFtz6h5JYHEpGCqbMLlP9hUxgkKwD0T5PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0e13BoI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0e13BoI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D308F1F000FF;
	Mon, 14 Sep 2026 13:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789393783;
	bh=PHXVki05iLaDnULABNT+AN8hkm5YZP+M5u9nks4OR7I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=a0e13BoIBDlNZjL6FHOjrws63c8kT6Nked4A38J8ximDVpkdQ4W6jV0LEaqzd5FnO
	 U+yWxM1lJ2xW32yEzGLFb3Yvlf6gejZ9MlUH5HIgZ/fylewbJbmNztWq2SulC0M+L8
	 GKu5/cWrk+/QBT6A5qmj5DXd9ON4qsz0MvlTWU56xZlD3BbLyMuSLWF3qIrek0KS6A
	 puiG3CdHkMJRVgDI3wf4cwHL1nu0NwmnXoPoXxKzKZP1uGjJXsqbyiW75j8vo3ec31
	 Dkn4ag0eZJDdhEHjG9bmpXy0JAYc4xLx/J8wuUBPmLlYjxLMERskn4TQtBgL4Xx/DX
	 UBFwT7eYVHb9Q==
Subject: Re: [PATCH] bonding: alb: Fix overflow in TLB gap calculation
From: netdev-bot+sashiko@kernel.org
To: lirongqing@baidu.com
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Mon, 14 Sep 2026 13:49:42 +0000
Message-ID: <178939378242.22033.14019495121039776230@kernel.org>
In-Reply-To: <20260913125859.2349-1-lirongqing@baidu.com>
References: <20260913125859.2349-1-lirongqing@baidu.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 · Low: 0 (1)

- [High] compute_gap() (drivers/net/bonding/bond_alb.c:163) now widens
  slave->speed to 64 bits before shifting, but slave->speed is a u32…

Pre-existing issues:
- [Low] The comment retained on the rewritten line, `/* Convert to
  Megabit per sec */` (drivers/net/bonding/bond_alb.c:163), mislabels…

--

bonding: alb: Fix overflow in TLB gap calculation

This changes compute_gap() in the TLB/ALB balancer so that slave->speed and
the per-slave TLB load are cast to s64 before being shifted, rather than
being shifted in 32-bit width and cast afterwards. The stated goal is to
avoid overflow of the gap value on high speed devices.

> diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
> index 43ac8e28e4182..b52004030a4b0 100644
> --- a/drivers/net/bonding/bond_alb.c
> +++ b/drivers/net/bonding/bond_alb.c
> @@ -160,8 +160,8 @@ static void tlb_deinitialize(struct bonding *bond)
>  
>  static long long compute_gap(struct slave *slave)
>  {
> -	return (s64) (slave->speed << 20) - /* Convert to Megabit per sec */
> -	       (s64) (SLAVE_TLB_INFO(slave).load << 3); /* Bytes to bits */
> +	return ((s64)slave->speed << 20) - /* Convert to Megabit per sec */

[Severity: High]
What happens here when slave->speed holds SPEED_UNKNOWN?

slave->speed is a u32, and bond_update_speed_duplex() in bond_main.c stores
the sentinel on its failure path:

drivers/net/bonding/bond_main.c:bond_update_speed_duplex() {
	...
speed_duplex_unknown:
	slave->speed = SPEED_UNKNOWN;
	slave->duplex = DUPLEX_UNKNOWN;
}

That is (u32)-1, so after the new pre-shift cast the first term becomes
((s64)0xFFFFFFFF << 20), roughly 4.5e15. The load term can never offset
that: ((s64)U32_MAX << 3) is only about 3.4e10, and even a real 100 Gbit/s
slave reaches only about 1.05e11.

Does that make tlb_get_least_loaded_slave() pick the unknown-speed slave
permanently?

	bond_for_each_slave_rcu(bond, slave, iter) {
		if (bond_slave_can_tx(slave)) {
			long long gap = compute_gap(slave);

			if (max_gap < gap) {
				least_loaded = slave;
				max_gap = gap;
			}
		}
	}

bond_slave_can_tx() in include/net/bonding.h only checks up/link/active and
never looks at speed:

	return bond_slave_is_up(slave) && slave->link == BOND_LINK_UP &&
	       bond_is_active_slave(slave);

so the sentinel reaches the comparison and every newly hashed TLB client
lands on that slave. Since the periodic rebalance clears assignments, would
this end up steering effectively all clients onto it?

Before this change the sentinel was shifted in 32-bit width, giving
0xFFFFFFFF << 20 == 0xFFF00000 (about 4.29e9), which the load term could
grow past, so the imbalance corrected itself. Does widening the arithmetic
remove that accidental cap and make it permanent?

Some paths where a tx-eligible TLB slave can carry SPEED_UNKNOWN:

- bond_enslave() sets new_slave->link = BOND_LINK_DOWN when the speed query
  fails and bond_needs_speed_duplex(), but a few lines later does
  new_slave->link = BOND_LINK_NOCHANGE, and the final else branch sets
  BOND_LINK_UP when both miimon and arp_interval are 0.
- bond_slave_netdev_event() on NETDEV_UP/NETDEV_CHANGE only forces a
  down/fail state for BOND_MODE_8023AD:

	if (bond_update_speed_duplex(slave) &&
	    BOND_MODE(bond) == BOND_MODE_8023AD) {

- bond_ethtool_get_link_ksettings() re-runs bond_update_speed_duplex() on an
  already tx-capable slave and can latch SPEED_UNKNOWN without touching
  slave->link:

	bond_update_speed_duplex(slave);
	netdev_unlock_ops(slave->dev);
	if (slave->speed != SPEED_UNKNOWN) {

Would it make sense to also clamp or skip SPEED_UNKNOWN in compute_gap()
(treat it as 0, or exclude the slave) alongside the widening?

> +	       ((s64)SLAVE_TLB_INFO(slave).load << 3); /* Bytes to bits */
>  }
>  
>  static struct slave *tlb_get_least_loaded_slave(struct bonding *bond)

[Severity: Low]
This isn't a bug introduced by this patch, but since the line is being
rewritten anyway: is the retained comment /* Convert to Megabit per sec */
accurate?

slave->speed is already in Mbit/s. It is copied straight from ethtool in
bond_update_speed_duplex():

	slave->speed = ecmd.base.speed;

and bond_procfs.c prints it as:

		seq_printf(seq, "Speed: %d Mbps\n", slave->speed);

So the << 20 goes from Mbit/s to bit/s, matching the second term whose
comment already says /* Bytes to bits */ (load_history is documented in
include/net/bond_alb.h as being in Bps). As written, a reader auditing units
would conclude the two subtracted terms are in different units. Would
something like /* Mbit/s to bit/s */ be clearer?

Also, << 20 scales by 1048576 while a megabit is 10^6 bits, about a 4.9%
bias. Presumably that is intentional, but nothing in the code says so.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260913125859.2349-1-lirongqing%40baidu.com
