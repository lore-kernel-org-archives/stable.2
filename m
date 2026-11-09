Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794230193;
	b=0XmtOH2p8UjYXtOegls/lhVok9SLAug0zK9ijvpF3Pax0lbj5rcQhG3sJVoCGAwngOI8
	 Am6eoeEyYyopN20Uci/YPmdYmooBzmHWiryOP0R1MAvPAOkklbthJarY8BZJWNRFWTCaW
	 c3IwJSzD+eXLGrShmvuIHEwRVEugFRQ9xlbRRRjQVssL6g/rdquj7fXvXlZ/66zeHPT1E
	 j9YXE/AfaIwBe27zQ5ilIKRQAbMSEDEJlOpAqHLw15mDzgmd1renREd2hkw0ISePktGfG
	 7QlkKf3xGZpwYFxAXebFgh4F7ThkdJ4ZsGvAlq/ZSaROmvnEkD58pxZbK//ZR5T6D7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794230193;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=e8c7paxwL5tke+4A1jsRM0Wz3ZxVtSkYKKkM+0xB5tI=;
	b=udxpkX7jqQVsDRTuyjwIoSbvZwwbLkiknxm9wpYoSpQGNuyuAeHciGscuVBebT5ZL99x
	 1vcx/U7dNc02eSquO0AKJv07uTy+UPVH5/VRV5Qkn2e6VwUCaPBTbgP9D1kKXE2a8FXJL
	 U7xGQZoj1a0Lmz6vmjOSTcWBwoNFDSnd6bVTNHWRoCH4V9Alf2ziKhA+7CThlVCsCJC1Z
	 QkgWoNHulslYgugXmo24yeL5x1hE4JHYVURBehuJZcMSNqLx2mFVXTfiD7usPmHK9m4ay
	 V5xlebRca3b4uLveGH/g1NtEDUUJUsAKCyADDF+GMQ7Q39gU6zQe6xkfh5b/43mcqjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PYX+58IZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451A7606A321;
	Mon,  9 Nov 2026 13:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PYX+58IZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B951F008A1;
	Mon,  9 Nov 2026 13:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794230192;
	bh=e8c7paxwL5tke+4A1jsRM0Wz3ZxVtSkYKKkM+0xB5tI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PYX+58IZVuGhJf+vfDNJ6mRmgi1a6MydZE5XF4S4xpvC+zMOlqWzX8w5AX6K4hwA3
	 WMEiDZkPlC1G0ezUT3DJRqzhWgC59yhw9KAppblCnbpWo2ZNKWFoQI4WzkfUcuiH28
	 TgnD/kUbwh7b8OIz39MmZnk0CwFnGkD1qFfQE8ArIwQd6RNn2tkJrJp572Zo+53H5Y
	 NteXLQ1bTSlMSf8+bpJPXugg7ccUG4bsos/4ywnk3nws6yRW7gDQfJ4/olMilU16tS
	 Oeh/NWtjPUIEyW7t/aD5XxF4mkwMOD+CPc9UBWuSMCgVp6hXpT8JaCkZeCn2TFAHmu
	 chgg9kmxOUdxg==
Subject: Re: [PATCH v2 1/2] net: atlantic: AQC113: Fix
 hw_atl2_hw_acket_filter_set for L2 filter base index > 0
From: netdev-bot+sashiko@kernel.org
To: j@jannau.net
Cc: sukhdeeps@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Mon, 09 Nov 2026 13:16:31 +0000
Message-ID: <179423019192.994134.8909643387874030122@kernel.org>
In-Reply-To: <20261108-net-atlantic-aq113-apple-l2-filter-slots-v2-1-0b988d031c78@jannau.net>
References: <20261108-net-atlantic-aq113-apple-l2-filter-slots-v2-1-0b988d031c78@jannau.net>
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

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Off-by-one in the slot index of the new enable/disable loop in
  hw_atl2_hw_packet_filter_set()…
- [Medium] hw_atl2_hw_packet_filter_set() can write past the end of the
  38-entry L2 unicast filter table.
- [Medium] hw_atl2_hw_packet_filter_set() now bounds its secondary-filter
  loop by priv->l2_filter_count.
- [Low] The commit message does not match the change.
- [Low] After this patch, hw_atl_b0_hw_packet_filter_set() has no
  external user.

--

net: atlantic: AQC113: Fix hw_atl2_hw_acket_filter_set for L2 filter base index > 0

This patch replaces the call from hw_atl2_hw_packet_filter_set() to
hw_atl_b0_hw_packet_filter_set() with an open-coded copy. The copy takes
l2_filters_base_index into account, so it no longer disables the L2
filters that hw_atl2.c programs, including the one for the MAC address.
This fixes broken networking on Apple silicon systems whose firmware
reports l2_filters_base_index = 9.

> net: atlantic: AQC113: Fix hw_atl2_hw_acket_filter_set for L2 filter base index > 0

[ ... ]

> Copy the formerly wrapped `hw_atl_b0_hw_packet_filter_set()` to handle
> this additional complexity.

[Severity: Low]
This isn't a bug, but there's a typo in the subject line
(hw_atl2_hw_acket_filter_set).

Also, the new code is not a plain copy of hw_atl_b0_hw_packet_filter_set().
The loop bound used to be the fixed HW_ATL_B0_MAC_MIN..HW_ATL_B0_MAC_MAX
range. It now depends on the l2_filter_count that firmware reports. The
slot index is also rebased onto l2_filters_base_index. Both changes affect
AQC113 systems with a base index of 0 too.

Could the commit message mention these differences?

> diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
> index 25dd7150aaaf2..8d7a489aa5de4 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
> @@ -759,9 +759,42 @@ static int hw_atl2_hw_ring_tx_init(struct aq_hw_s *self,
>  static int hw_atl2_hw_packet_filter_set(struct aq_hw_s *self,
>  					unsigned int packet_filter)
>  {
> +	struct aq_nic_cfg_s *cfg = self->aq_nic_cfg;
> +	struct hw_atl2_priv *priv = self->priv;
> +	u32 base_location = priv->l2_filters_base_index + 1;
> +	unsigned int num_l2_filters = min_t(unsigned int, HW_ATL2_MAC_MAX,
> +					    priv->l2_filter_count);

[Severity: Medium]
What happens here if firmware reports l2_filter_count == 0? Then
num_l2_filters is 0 and the loop further down never runs. The secondary
filter enables would stop following IFF_MULTICAST and mc_list_count.

For example, clearing IFF_MULTICAST when there are no secondary unicast
addresses would leave enabled the slots that
hw_atl2_hw_multicast_list_set() wrote.

hw_atl2_utils_get_filter_caps() gives a zero art_count a default, but
l2_filter_count gets no fallback:

hw_atl2_utils_get_filter_caps() {
    ...
	if (priv->art_count == 0)
		priv->art_count = HW_ATL2_ART_TOTAL_ENTRIES;
    ...
	priv->l2_filter_count = filter_caps.l2_filter_count;
    ...
}

The b0 loop covered slots 1..32 no matter what the firmware reported.

Later in the series this gets worse. hw_atl2_get_num_multicast_addresses()
returns min_t(int, l2_filter_count - 1, 32), which is -1 when the count is
0. The num_multicast_addresses check in aq_nic_set_multicast_list() is an
unsigned comparison, so -1 becomes UINT_MAX. Wouldn't the check then never
fire, so that every multicast address is copied into the 32 entry
mc_list.ar?

> +	unsigned int i = 0U;
> +	u32 vlan_promisc;
> +	u32 l2_promisc;
> +
>  	hw_atl2_hw_new_rx_filter_promisc(self, IS_FILTER_ENABLED(IFF_PROMISC));
>  
> -	return hw_atl_b0_hw_packet_filter_set(self, packet_filter);

[Severity: Low]
This isn't a bug, but once this call is removed,
hw_atl_b0_hw_packet_filter_set() is not used anywhere outside
hw_atl_b0.c. Could it be made static again, and its prototype dropped
from hw_atl_b0.h?

[ ... ]

> +	hw_atl_rpfl2broadcast_en_set(self, IS_FILTER_ENABLED(IFF_BROADCAST));
> +
> +	for (i = HW_ATL2_MAC_MIN; i < num_l2_filters; ++i)
> +		hw_atl_rpfl2_uc_flr_en_set(self,
> +					   (cfg->is_mc_list_enabled &&
> +					    (i <= cfg->mc_list_count)) ?
> +					   1U : 0U, base_location + i);

[Severity: High]
Is the slot index off by one here? base_location already equals
l2_filters_base_index + 1, and the loop starts at HW_ATL2_MAC_MIN (1).
The loop therefore manages slots base + 2 .. base + num_l2_filters. It
enables slots base + 2 .. base + 1 + mc_list_count.

hw_atl2_hw_multicast_list_set() writes entry k (counting from 0) to
base_location + k:

hw_atl2_hw_multicast_list_set() {
    ...
	u32 base_location = priv->l2_filters_base_index + 1;
    ...
		u32 i = cfg->mc_list_count;
    ...
		hw_atl_rpfl2unicast_dest_addresslsw_set(self, l,
							base_location + i);
    ...
}

Its entries therefore occupy base + 1 .. base + mc_list_count. In the b0
original, the enable loop used slot i for 1 <= i <= mc_list_count, which
matches the slots its own list_set writes.

With the new indexing, nothing here ever clears slot base + 1. When the
address count drops to 0, aq_nic_set_multicast_list() skips
hw_multicast_list_set() and only calls aq_nic_set_packet_filter(). That
happens when the last secondary unicast address or multicast group is
removed, or when multicast is turned off. Would the NIC keep accepting the
stale first secondary address in those cases?

The loop also enables slot base + 1 + mc_list_count, which was not
programmed in this round. If the list shrinks from N to M entries, that
slot still holds the old entry M. Can the hardware keep accepting an
address the stack has already removed?

This happens for every l2_filters_base_index, including 0. AQC113 boards
that worked before could regress, and Cc: stable would carry that to
them. Should the index be priv->l2_filters_base_index + i instead? The
final patch of the series doesn't seem to change this loop.

[Severity: Medium]
Can this loop also write past the end of the 38 entry L2 unicast filter
table? The highest slot it touches is
l2_filters_base_index + min(HW_ATL2_MAC_MAX, l2_filter_count). Nothing
checks that value against HW_ATL2_MAC_MAX, and
hw_atl2_utils_get_filter_caps() clamps only the base index:

hw_atl2_utils_get_filter_caps() {
    ...
	priv->l2_filters_base_index = filter_caps.l2_filters_base_index;
	if (priv->l2_filters_base_index >= HW_ATL2_MAC_MAX)
		priv->l2_filters_base_index = HW_ATL2_MAC_UC;
	priv->l2_filter_count = filter_caps.l2_filter_count;
    ...
}

The commit message of the next patch in the series ("net: atlantic:
AQC113: Limit multicast filters to available slots") says Apple firmware
reports base 9 and count 29. With those values the loop reaches slot 38.
Each call then does a read-modify-write of bit 31 at
HW_ATL_RPFL2UC_ENF_ADR(38) = 0x5244, which is beyond the last table entry
at 0x523C.

Firmware that reports a larger count with a nonzero base would go further,
into HW_ATL_RPFL2MC_ENF_ADR(1) at 0x5254 and the VLAN TPID register at
0x5284. Bit 31 of those registers would then follow mc_list_count. The b0
loop never went beyond slot 32.

Should the bound also enforce
l2_filters_base_index + l2_filter_count <= HW_ATL2_MAC_MAX?

> +
> +	return aq_hw_err_from_flags(self);
>  }
>  
>  #undef IS_FILTER_ENABLED

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261108-net-atlantic-aq113-apple-l2-filter-slots-v2-0-0b988d031c78%40jannau.net
