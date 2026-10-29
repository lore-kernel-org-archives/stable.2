Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793269700;
	b=cZqp4OJNXHsMCrB8j1W4lJOve3azRcOa4nCj9VM76ROcN/X/Ur+hPW+6v7aUgYwGwP2O
	 bUrctYStqdTOcJsvCRkMKJFqIUogrmgtA2Z90A1FudIhRgzNoEdu0B/ZSpnWphJauk4G9
	 AYPIiWE3lF4lhpEbvcdSX93M1eHj0RDIR7IRgSHSYByjB/MhDRFNNhH/kl8qOnsYF+j+K
	 XJgKYLT9G2LuNXjzcJ4P8dJMXK/qF7yGx6ro7PZxzhsaMQnRr2FEMYU7G4WS/va22RV3a
	 ypZ8hblLm6GUlf3NbkrbGZjkckvjAcy+PddvCGoAxUOS5oxwUsKgaFulZHP1+mtJGTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793269700;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=oGgcp45Z28OZUkne00IzmqyrvERg/7r7+ig1noWb8XM=;
	b=jSINiFt6LgxxYhA1Yvx59rI1GGGUcqXvac23ROZYrBYHbXsyJyWR7IVXpiDsPSECGKo+
	 NH2TH+PHrV3IwSx6Qyew9LjpJyp3cFLiOXJQl2rgwSaYD+mspezRjV+CHsFsddQeNJCWY
	 yqtAuVv+oEe7p2tmdKiPUKtE4oA0Mm4JVymQq4OYfyHDhtJ8KHT8ZfBWGXq5mapIEvhHA
	 favhD2ZUr+BFdEiOrfOk7No0dZVHsrpNlMehmdSSAgq8/+fb5F9CKH1lCwEdOOUWxNPm2
	 xS70G8DDkbvEvxbhuSEC8gXg2fAA4u/y6NFREit4SYp7Aq2IDIE00DnOr9vrpNPJxsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SxOO8QDe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D686606A31A;
	Thu, 29 Oct 2026 10:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SxOO8QDe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B324F1F01825;
	Thu, 29 Oct 2026 10:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793269699;
	bh=oGgcp45Z28OZUkne00IzmqyrvERg/7r7+ig1noWb8XM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SxOO8QDe1Hb/nl715BtM7+3ZAz7wbQALhn2l0p6aJhTgdxAXccRjdIVI2nNxHgjAh
	 M02TMHzB1rqSggcwM3PGppL4G8+Xiv+4lgVmQYKbKAasAHXepWcSvMb+AhqeM3S10s
	 pRMTY2ID8Ro0RM575bu9GTqKYUsihWQONNmjtiQl55WheP0sEpubcuGaC6Ru9qARnY
	 pdFtYvJ5Hj7J6d4oyAkWZKRkelqQ8KOqWNuR0vxWAW2E6cnegORfBYd0bG9Oa4iDbW
	 D8FXC/Sj/ycjIwqfDJ/4uWhQcK25mCehK+urGWFE6fEn3IhGSxTO6TF7KkXCAA+1V/
	 GM72ORz+TFgww==
Subject: Re: [PATCH 1/2] net: atlantic: AQC113: Fix hw_packet_filter_set for
 l2 filter base index > 0
From: netdev-bot+sashiko@kernel.org
To: j@jannau.net
Cc: sukhdeeps@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 29 Oct 2026 10:28:18 +0000
Message-ID: <179326969826.3134.7069126444531845723@kernel.org>
In-Reply-To: =?utf-8?q?=3C20261026-net-atlantic-aq113-apple-l2-filter-slots-?=
 =?utf-8?q?v1-1-d72e99b69583=40jannau=2Enet=3E?=
References: =?utf-8?q?=3C20261026-net-atlantic-aq113-apple-l2-filter-slots-v?=
 =?utf-8?q?1-1-d72e99b69583=40jannau=2Enet=3E?=
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete because the two functions use different
  slot numbering.

Pre-existing issues:
- [Medium] On the ATL2 path, hw_atl_b0_hw_packet_filter_set_int() still
  stops at HW_ATL_B0_MAC_MAX (33), but the AQC113 L2 filter table has…

--

net: atlantic: AQC113: Fix hw_packet_filter_set for l2 filter base index > 0

This adds a base_location argument to the B0 packet filter helper, now
hw_atl_b0_hw_packet_filter_set_int(). With it, the unicast filter enable
loop can start at a slot other than HW_ATL_B0_MAC_MIN.

The ATL2 wrapper passes l2_filters_base_index + 1. On AQC113 parts with a
non-zero base index, the loop then no longer touches the reserved firmware
slots or the MAC address filter.

> diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
> index 6c25ad264b19d..5c67edf8030c7 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c

[ ... ]

> @@ -1065,7 +1066,7 @@ int hw_atl_b0_hw_packet_filter_set(struct aq_hw_s *self,
>  	hw_atl_rpfl2broadcast_en_set(self, IS_FILTER_ENABLED(IFF_BROADCAST));
>  
>  
> -	for (i = HW_ATL_B0_MAC_MIN; i < HW_ATL_B0_MAC_MAX; ++i)
> +	for (i = base_location; i < HW_ATL_B0_MAC_MAX; ++i)
>  		hw_atl_rpfl2_uc_flr_en_set(self,
>  					   (cfg->is_mc_list_enabled &&
>  					    (i <= cfg->mc_list_count)) ?

[Severity: High]
Now that base_location can differ from HW_ATL_B0_MAC_MIN, is the
i <= cfg->mc_list_count test still correct? Here i is an absolute slot
number that starts at base_location. cfg->mc_list_count is just a count
of entries.

hw_atl2_hw_multicast_list_set() programs and enables entries at
base_location + i, for i in 0..count-1:

hw_atl2.c:hw_atl2_hw_multicast_list_set() {
    u32 base_location = priv->l2_filters_base_index + 1;
    ...
		hw_atl_rpfl2_uc_flr_en_set(self, (cfg->is_mc_list_enabled),
					   base_location + i);
    ...
}

On the AQC113 with l2_filters_base_index = 9, base_location is 10:

- With mc_list_count = 3, i <= 3 is false for every i >= 10. Slots
  10..12 are disabled right after being enabled.

- With mc_list_count = n >= 10, slots 10..n stay enabled. The last 9
  programmed entries (n+1..n+9) are disabled.

aq_nic_set_multicast_list() calls hw_multicast_list_set() and then
hw_packet_filter_set() straight away:

aq_nic_set_multicast_list()
    hw_ops->hw_multicast_list_set()        /* enables slots 10.. */
    aq_nic_set_packet_filter()
        hw_atl2_hw_packet_filter_set()
            hw_atl_b0_hw_packet_filter_set_int()   /* disables them */

aq_nic_start() calls them in the same order. So this happens on every
interface start and every rx-mode change.

Unless ALLMULTI or PROMISC is set, hw_atl2_hw_new_rx_filter_promisc()
programs the ART to drop frames that have no UC/ALLMC tag.

Would that drop IPv6 solicited-node and all-nodes multicast, other joined
multicast groups, and secondary unicast MACs such as macvlan?

The commit message says the patch makes sure packet_filter_set:

  "neither touches reserved firmware filters or disables filters configured
  in hw_atl2.c."

These are filters configured in hw_atl2.c. The second patch in the series
does not seem to change this loop either.

Would a relative test such as i < base_location + cfg->mc_list_count fix
this? On B0, base_location == HW_ATL_B0_MAC_MIN, so behaviour there would
not change.

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch. The old
loop had the same B0 upper bound, and the shifted slot layout came from
6c1ca112a6e4.

Should the upper bound still be HW_ATL_B0_MAC_MAX (33) when this runs for
ATL2? The AQC113 L2 filter table has HW_ATL2_MAC_MAX (38) entries, and
hw_atl2_hw_init_rx_path() walks all 38.

With base_location = 10, a list of 24 or more entries makes
hw_atl2_hw_multicast_list_set() enable slot 33 or higher. The bound later
in the series is count <= l2_filter_count - 1.

This loop never reaches slots 33..37. hw_atl2_hw_multicast_list_set() only
rewrites the slots in the current list.

The list can shrink, IFF_MULTICAST can be cleared, or the count can drop
to 0, in which case aq_nic_set_multicast_list() skips
hw_multicast_list_set(). In any of these cases, can the enable bits in
slots 33..37 stay set? The NIC would then keep accepting frames for
addresses that are no longer subscribed.

The new helper only takes a start index. Could it also take an end or a
count, for example bounded by priv->l2_filter_count?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261026-net-atlantic-aq113-apple-l2-filter-slots-v1-0-d72e99b69583%40jannau.net
