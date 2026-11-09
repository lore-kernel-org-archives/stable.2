Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794230194;
	b=X0wSmsWK3XcrcflsW6tajg3WEloGlH8WEhQ3YvYtGBRJN1Goc8QnrGQGPSozlSgOlFXw
	 jLIkhuJvQjsgDJiIjL20x/OWFlsnTK1ZMbIv6a/CXfIK22Z6NJgKpSq/CusfcHyBbFv1q
	 71Ax3UlHq6+5PZwzsXR//7rqK7S5fnthJK/09+eSvXaW0EOgDxTqRQuztUDEmm2VqILfw
	 gKYgrxxWQHT+WpMHSPqrRb604tetk9kVrfj12BfaNGdgRsyqMsizgarOCwglW93ySx5VC
	 CU4uSXRM9WwaqaOf6CzKzV+0sDbNJZP0SSYoq1xRhw3Fo4w+M6s36i5Kq8RB4XryaVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794230194;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=jeokM8/W5XmFatmunaVWUhvCJd/ttjYtGG4nHYx10NI=;
	b=cAzx9wRi1r4eBojtFPpJiWCS/Ux4hB7DcVeVsPEWi99Ksc6nGPB28ztd0dsfkxA75y6g
	 6EvLvAAwS51EuSTCy4r6jyHLHbLAhduavrzWx1LINJejREJBEt9sonspOBjrxEqP+QxHc
	 6ZRYdedBXXCMVykP3Eov6AYpOR73fnIFvvsChAzBFIDmNsD2/eWhKOg1iHeitP05RGDNZ
	 8P0ev7JSIRNj9M6vh+iCIqbHdBlaVcZRNpO1duxCJghra16n4/wdso/+nlaF8TUhXQak6
	 8IwQ01ur3s2HXUlElOPAe4CTOEE0YJq/1aaHKzjnhyS5utEOEwnQiF5xVWjOEYGpQyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J0wwBc7d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6A1606A325;
	Mon,  9 Nov 2026 13:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J0wwBc7d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 834651F0089F;
	Mon,  9 Nov 2026 13:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794230194;
	bh=jeokM8/W5XmFatmunaVWUhvCJd/ttjYtGG4nHYx10NI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=J0wwBc7dIY6EN8ER9coT+VXGo14aBcUQZz3LbX2W7+TZBwor6dP1NSpHS0vbyMTqm
	 2WnHiZ/7ADt1b0V3cG58C7LnVl0pi2bpIbwmkIjl3t/5jY5pjIheh0yezxSfuvdeWr
	 U22ylj033cRHyOD1/V+cbbhWR58hjQMpiqoJ5D4/q1x9w0pQpfQjK4N8qRFYXCmlWR
	 VryqjlCA6H64HXb2SHm907DAyWIz8B/jDygCzyySp5+lJB2TQJnE8pQ8c1NCql9sAc
	 ciJzCJkXo+60/Ikz1oV/1P/cmsgkfxIQcPKOYUvDzsrbxRaXSRiBO1uSfUa1nzU1sV
	 5WN/lx22rDLjw==
Subject: Re: [PATCH v2 2/2] net: atlantic: AQC113: Limit multicast filters to
 available slots
From: netdev-bot+sashiko@kernel.org
To: j@jannau.net
Cc: sukhdeeps@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Mon, 09 Nov 2026 13:16:33 +0000
Message-ID: <179423019310.994134.7743580098620436662@kernel.org>
In-Reply-To: <20261108-net-atlantic-aq113-apple-l2-filter-slots-v2-2-0b988d031c78@jannau.net>
References: <20261108-net-atlantic-aq113-apple-l2-filter-slots-v2-2-0b988d031c78@jannau.net>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch swaps two constant bounds for values derived from the
  firmware-reported priv->l2_filter_count, and nothing validates that…
- [High] net: atlantic: off-by-one L2 filter index in
  hw_atl2_hw_packet_filter_set()
- [Low] The commit message leaves out the concrete impact and part of the
  code change: - It only says the firmware count (29) is "unfortunately…

--

net: atlantic: AQC113: Limit multicast filters to available slots

This commit adds a hw_get_num_multicast_addresses() callback to struct
aq_hw_ops. It lets AQC113 report fewer usable L2 filter slots than
AQ_HW_MULTICAST_ADDRESS_MAX, based on the l2_filter_count that the firmware
reports. aq_nic_set_multicast_list() uses this value to decide when to fall
back, and hw_atl2_hw_multicast_list_set() now bounds the count by the same
firmware value.

> On Apple silicon systems with AQC113 the firmware returns
[ ... ]
> unfortunately less than AQ_HW_MULTICAST_ADDRESS_MAX (32).
[ ... ]
> Use this potentially smaller
> number in aq_nic_set_multicast_list() to decide when to switch to
> promiscuous mode.

[Severity: Low]
This isn't a bug, but could the commit message describe the impact and the
full change more precisely?

Before this fix, with a base index of 9 and more than 28 addresses,
hw_atl2_hw_multicast_list_set() writes L2 unicast filter indices 38..41
(0x5240..0x525C). That is past the end of the filter table, and it overlaps
HW_ATL_RPFL2MC_ENF_ADR(0..3) at 0x5250..0x525C. The message does not say
this.

The message also does not mention that the guard in
hw_atl2_hw_multicast_list_set() changes from
(HW_ATL2_MAC_MAX - HW_ATL2_MAC_MIN) to (priv->l2_filter_count - 1).

Also, for multicast the fallback in aq_nic_set_multicast_list() is
IFF_ALLMULTI, not promiscuous mode.

[ ... ]

> diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
> index 8d7a489aa5de4..d0dc72bd098f4 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
> @@ -810,7 +810,7 @@ static int hw_atl2_hw_multicast_list_set(struct aq_hw_s *self,
>  	struct aq_nic_cfg_s *cfg = self->aq_nic_cfg;
>  	int err = 0;
>  
> -	if (count > (HW_ATL2_MAC_MAX - HW_ATL2_MAC_MIN)) {
> +	if (count > (priv->l2_filter_count - 1)) {
>  		err = -EBADRQC;
>  		goto err_exit;
>  	}

[Severity: High]
This guard assumes hw_atl2_hw_packet_filter_set() uses the same slot
layout as this function. It doesn't look like it does.

hw_atl2_hw_multicast_list_set() sets base_location to
priv->l2_filters_base_index + 1. It writes ar_mac[0..count - 1] into
slots base_location + 0 through base_location + count - 1.

aq_nic_set_multicast_list() then calls aq_nic_set_packet_filter(),
which ends up in hw_atl2_hw_packet_filter_set(). That function computes
the same base_location, but its loop starts at i = HW_ATL2_MAC_MIN (1).
It enables base_location + i when i <= cfg->mc_list_count, so the +1
offset is applied a second time.

Take the values from the commit message (base index 9, count 29) and
mc_list_count == n:

  - slot 10 holds ar_mac[0], but hw_atl2_hw_packet_filter_set() never
    touches it. It stays enabled when the list shrinks to zero or
    IFF_MULTICAST is cleared.
  - slot 10 + n gets enabled even though no address was written to it
    on this pass, so frames for whatever stale address sits there are
    accepted.
  - the last iteration, i = 28, writes the enable bit of filter 38.
    That is HW_ATL2_MAC_MAX, past the end of the L2 unicast filter
    table.

The double offset happens on every AQC113, whatever the slot counts.
num_l2_filters is also only clamped to HW_ATL2_MAC_MAX, not to
HW_ATL2_MAC_MAX - base_location. So any base index that is large
enough relative to l2_filter_count walks off the end of the table.
This path also runs from aq_nic_start(), so every open hits it, not
only rx mode changes.

This patch is meant to keep the address list within the slots the
firmware reports. Should hw_atl2_hw_packet_filter_set() start at
i = 0, stop before l2_filter_count - 1 (clamped so base_location + i
stays below HW_ATL2_MAC_MAX), and test i < cfg->mc_list_count, to
match hw_atl2_hw_multicast_list_set()? The loop appears to come from
patch 1/2 of this series, so the fix probably belongs there.

[ ... ]

> @@ -1635,6 +1635,13 @@ static int hw_atl2_hw_vlan_ctrl(struct aq_hw_s *self, bool enable)
>  	return aq_hw_err_from_flags(self);
>  }
>  
> +static int hw_atl2_get_num_multicast_addresses(struct aq_hw_s *self)
> +{
> +	struct hw_atl2_priv *priv = self->priv;
> +
> +	return min_t(int, priv->l2_filter_count - 1, AQ_HW_MULTICAST_ADDRESS_MAX);
> +}

[Severity: High]
What happens here if the firmware reports l2_filter_count == 0?

priv->l2_filter_count is unsigned int, so priv->l2_filter_count - 1 wraps
to UINT_MAX, and min_t(int, ...) then returns -1.

hw_atl2_utils_get_filter_caps() stores the firmware value without any
check. The neighbouring art_count and l2_filters_base_index fields do get
sanitized:

drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c:hw_atl2_utils_get_filter_caps() {
    ...
	priv->art_count = filter_caps.rslv_tbl_count * 8;
	if (priv->art_count == 0)
		priv->art_count = HW_ATL2_ART_TOTAL_ENTRIES;
	priv->l2_filters_base_index = filter_caps.l2_filters_base_index;
	if (priv->l2_filters_base_index >= HW_ATL2_MAC_MAX)
		priv->l2_filters_base_index = HW_ATL2_MAC_UC;
	priv->l2_filter_count = filter_caps.l2_filter_count;
    ...
}

In aq_nic_set_multicast_list(), the unicast check is signed, so it sets
IFF_PROMISC and leaves i at 0. But i is unsigned int, so in the multicast
check the -1 is converted to UINT_MAX:

	if (i + netdev_mc_count(ndev) > num_multicast_addresses) {
		packet_filter |= IFF_ALLMULTI;
	} else {
		netdev_for_each_mc_addr(ha, ndev) {
			ether_addr_copy(self->mc_list.ar[i++],
					ha->addr);

Doesn't this mean the IFF_ALLMULTI fallback is never taken? Once more than
32 multicast addresses are joined, would the loop then overflow
self->mc_list.ar[] into the following fields of struct aq_nic_s?

The later "i <= num_multicast_addresses" check is also unsigned, so
hw_atl2_hw_multicast_list_set() gets called with count > 32. Its new guard,
"count > (priv->l2_filter_count - 1)", also compares against UINT_MAX and
rejects nothing. It would then read ar_mac[] out of bounds and program
filters at base_location + i beyond HW_ATL2_MAC_MAX.

There is also a separate case: a large l2_filter_count with a nonzero base
index. The value is clamped only to AQ_HW_MULTICAST_ADDRESS_MAX, never to
HW_ATL2_MAC_MAX - (l2_filters_base_index + 1). The guard in
hw_atl2_hw_multicast_list_set() used the hardware constant before, and now
it trusts the firmware count.

With a base of 9 and a count of 34, wouldn't slots 10..41 get programmed?
Filters 38..41 seem to land at 0x5240..0x525C, which overlaps
HW_ATL_RPFL2MC_ENF_ADR(0..3).

Would it make sense to validate l2_filter_count in
hw_atl2_utils_get_filter_caps()? That would mean handling zero and clamping
base + count to HW_ATL2_MAC_MAX, like the other fields there.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261108-net-atlantic-aq113-apple-l2-filter-slots-v2-0-0b988d031c78%40jannau.net
