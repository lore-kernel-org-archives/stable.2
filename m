Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793269701;
	b=nUdD03+3S8kj2JrclBaVhi1f+SvbQB1q2JHTuFvKEIfaMWMiv7XwIhCO8RvDs4vwDWqZ
	 qSiZPadjJnXJipkGj95DQ9w29yKH0vvTsT+Ce7uxmjG9dQVebkXLgIJkpITW7kw9PCaPt
	 OTz9P17kgsdO0ym0vYfgL3J9vT3qrt7FgOomYYtewd4K1GFV/+DLgxesz1kB8RTxF3oSc
	 3VLDQ2RWPzgu2yKyGGHbAghiI+QCpb4R1IZ9Z2vDm8Y5inX59k7fWXMeG8p6dn/jMq2MW
	 mAuD61mv3U9wMOgaDWSmHlQMOKSs1Wjk6gBXzuD8asx164wzxI391BpX15IAbNiyp8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793269701;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=fBNFZdt83poB+vWK3RH+fH/Du4zaUdYMvSCheFF+r4g=;
	b=c84gBExtKiMwvS2EWqxOCSBeRFi9HLCrxtKkiT51Xg81ZDJC+E8iVMGuIfbmSD7xhwM3
	 gCvjAbKUyMWjL5tb7A76LOFMaaN7IrFtDcBPvgU4y3DGTxOLIrNspPPKgGO/TRLz2Bqm0
	 yypQe4TaU53paJXcTgCBsuujG4Ao7H9jWfFzbHeMutHKLr0X02GzRTtKEFfI3GnJZWU9X
	 bXodzcJkA6jVGzGym2O2ogf8ucjE8evO9C2DzmfEBwNRBw7XhLn/JzB1hUXTyFaE6tclO
	 z/LHt+lQ3zUYXbmli9q0hHJPsi/dmbJFMVGLpvdC6d1SRE3Ot/uFcQcCBH2Tku1qbfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IpLAjoHM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A816A606A322;
	Thu, 29 Oct 2026 10:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IpLAjoHM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDA8F1F01828;
	Thu, 29 Oct 2026 10:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793269700;
	bh=fBNFZdt83poB+vWK3RH+fH/Du4zaUdYMvSCheFF+r4g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IpLAjoHMpgJ223v9a7892cnz9I0FhSOu1kk3OPik/LUFkB52LRySawUqUDS8jtgKX
	 /01QFvqmm4eB+uoFbKxLr0/QsDCeM28mGw/1WBlqjkDpByWxr1Q0AeCiZXXoU0Gvve
	 Fb33Nhn56UH4WgZQSTF+MpVgEd4KFKVP48Db3FJVydFIpxEBCVmVfFRRFwUFSG11dA
	 QrX4JQf3PoPkGhdRUuHshhfVT3UNiIh5T8OyttbSRg2hmDWbbX+DRcFDGIpH7U+cWT
	 yj0Au4D3MSm3E3DZhSUEFemE5wzl7zsZw1Cz97cLV8Prl6uMKjW82bfErho/fsvGdy
	 bba2WlxxDBh9A==
Subject: Re: [PATCH 2/2] net: atlantic: AQC113: Limit multicast filters to
 avaiable slots
From: netdev-bot+sashiko@kernel.org
To: j@jannau.net
Cc: sukhdeeps@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 29 Oct 2026 10:28:19 +0000
Message-ID: <179326969938.3134.798759730911402864@kernel.org>
In-Reply-To: =?utf-8?q?=3C20261026-net-atlantic-aq113-apple-l2-filter-slots-?=
 =?utf-8?q?v1-2-d72e99b69583=40jannau=2Enet=3E?=
References: =?utf-8?q?=3C20261026-net-atlantic-aq113-apple-l2-filter-slots-v?=
 =?utf-8?q?1-2-d72e99b69583=40jannau=2Enet=3E?=
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] hw_atl2_hw_multicast_list_set() (hw_atl2.c:783) now rejects any
  count above `priv->l2_filter_count - 1` with -EBADRQC.
- [High] At the end of the series, multicast filters on AQC113 parts with
  l2_filters_base_index > 0 are still disabled, by…
- [Medium] The new bound `count > (priv->l2_filter_count - 1)` in
  hw_atl2_hw_multicast_list_set() uses a firmware-reported u8 that is…
- [Low] The commit message has a typo in the subject ('avaiable' should
  be 'available') and a garbled sentence in the body ('which could in…

--

net: atlantic: AQC113: Limit multicast filters to avaiable slots

This commit changes the count check in hw_atl2_hw_multicast_list_set().
The check now uses the firmware-supplied l2_filter_count instead of
HW_ATL2_MAC_MAX - HW_ATL2_MAC_MIN. The goal is to keep the multicast
entries, which sit above the firmware-assigned MAC address slot, within
the available L2 filter slots.

> net: atlantic: AQC113: Limit multicast filters to avaiable slots

[Severity: Low]
This isn't a bug, but there's a typo in the subject (avaiable).

> HW_ATL2_MAC_MIN) which could in setting out of bounds filter slots.

This sentence seems to be missing a word ("which could result in ...").

Could the message also describe the concrete case? The old bound of 37,
combined with the caller's cap of AQ_HW_MULTICAST_ADDRESS_MAX (32) and a
firmware base index such as 9, lets base_location + i reach slot 41. That
is past HW_ATL2_MAC_MAX (38).

It would also help to mention the l2_filter_count the affected hardware
reports. Oversized lists now fail with -EBADRQC instead of being clamped,
and the message could say so.

> diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
> index 82be3bb2e76d4..41c653c14e5af 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
> @@ -780,7 +780,7 @@ static int hw_atl2_hw_multicast_list_set(struct aq_hw_s *self,
>  	struct aq_nic_cfg_s *cfg = self->aq_nic_cfg;
>  	int err = 0;
>  
> -	if (count > (HW_ATL2_MAC_MAX - HW_ATL2_MAC_MIN)) {
> +	if (count > (priv->l2_filter_count - 1)) {

[Severity: High]
Can lists that aq_nic_set_multicast_list() still treats as valid now hit
this limit?

The caller only falls back to IFF_ALLMULTI / IFF_PROMISC based on
AQ_HW_MULTICAST_ADDRESS_MAX (32):

drivers/net/ethernet/aquantia/atlantic/aq_nic.c:aq_nic_set_multicast_list() {
    ...
		if (i + netdev_mc_count(ndev) > AQ_HW_MULTICAST_ADDRESS_MAX) {
			packet_filter |= IFF_ALLMULTI;
    ...
	if (i > 0 && i <= AQ_HW_MULTICAST_ADDRESS_MAX) {
		self->mc_list.count = i;
		err = hw_ops->hw_multicast_list_set(self->aq_hw,
						    self->mc_list.ar,
						    self->mc_list.count);
		if (err < 0)
			return err;
	}

	return aq_nic_set_packet_filter(self, packet_filter);
}

Some firmware reports l2_filter_count <= 32. One example is the base
index 9 case, which leaves at most 29 slots below HW_ATL2_MAC_MAX. With
that firmware, a uc+mc count between l2_filter_count and 32 now gets
-EBADRQC.

Before this patch the check was count > 37. With the caller capped at 32,
this path could not be reached.

When it is hit, no address gets programmed and IFF_ALLMULTI is not set.
aq_nic_set_packet_filter() is also skipped, so any IFF_PROMISC /
IFF_ALLMULTI change in the same rx_mode update is lost.

aq_ndev_set_multicast_settings() throws away the return value with
(void), so nothing reports the failure.

The early return also leaves the oversized value in self->mc_list.count.
Would the next aq_nic_start() fail as well?

drivers/net/ethernet/aquantia/atlantic/aq_nic.c:aq_nic_start() {
    ...
	err = self->aq_hw_ops->hw_multicast_list_set(self->aq_hw,
						     self->mc_list.ar,
						     self->mc_list.count);
	if (err < 0)
		goto err_exit;
    ...
}

ndo_set_rx_mode does not run while the device is down, so nothing seems
to reset mc_list.count. aq_ndev_open() and atl_resume_common() would then
keep failing until the driver is reloaded.

An unprivileged user can grow the list with IP_ADD_MEMBERSHIP /
IPV6_JOIN_GROUP.

Should the core know the real capacity instead of getting an error back?
For example, it could fall back to IFF_ALLMULTI when the count exceeds
that capacity.

[Severity: Medium]
hw_atl2_utils_get_filter_caps() copies priv->l2_filter_count, an unsigned
int, straight from firmware:

drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c:hw_atl2_utils_get_filter_caps() {
    ...
	priv->l2_filters_base_index = filter_caps.l2_filters_base_index;
	if (priv->l2_filters_base_index >= HW_ATL2_MAC_MAX)
		priv->l2_filters_base_index = HW_ATL2_MAC_UC;
	priv->l2_filter_count = filter_caps.l2_filter_count;
    ...
}

If firmware reports 0, doesn't l2_filter_count - 1 wrap to UINT_MAX, so
the check never fires? Only the caller's cap of 32 would then limit
base_location + i, and that can go well past the 38 physical L2 filters.

Nothing checks that l2_filters_base_index + l2_filter_count <=
HW_ATL2_MAC_MAX either. Take base 9 with a reported count of 32. Could
the loop still write slots >= 38 through these functions?

hw_atl_rpfl2unicast_dest_addresslsw_set()
hw_atl_rpfl2unicast_dest_addressmsw_set()
hw_atl2_rpfl2_uc_flr_tag_set()
hw_atl_rpfl2_uc_flr_en_set()

The neighbouring fields are already sanitised: art_count,
l2_filters_base_index, and the VLAN and L3 counts. Should l2_filter_count
also be clamped against HW_ATL2_MAC_MAX - l2_filters_base_index, with 0
handled too?

>  		err = -EBADRQC;
>  		goto err_exit;
>  	}

[Severity: High]
Do the slots this patch bounds actually stay enabled once the series is
applied?

hw_atl2_hw_multicast_list_set() programs entry n into slot
base_location + n and enables it. Both aq_nic_set_multicast_list() and
aq_nic_start() then call hw_packet_filter_set right away.

That reaches hw_atl_b0_hw_packet_filter_set_int() with base_location =
l2_filters_base_index + 1:

drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c:hw_atl_b0_hw_packet_filter_set_int() {
    ...
	for (i = base_location; i < HW_ATL_B0_MAC_MAX; ++i)
		hw_atl_rpfl2_uc_flr_en_set(self,
					   (cfg->is_mc_list_enabled &&
					    (i <= cfg->mc_list_count)) ?
					   1U : 0U, i);
    ...
}

This predicate compares an absolute slot index with a count, which only
works when base_location == 1.

Take base index 9 (base_location 10) and a typical count of about 5. Since
10 > 5, wouldn't slots 10..14 all be disabled? With larger counts, only
slots 10..count would stay enabled.

The loop also runs up to the fixed HW_ATL_B0_MAC_MAX, whatever
base + l2_filter_count is. That writes enable bits outside the
firmware-assigned range.

The earlier patch in this series, "net: atlantic: AQC113: Fix
hw_packet_filter_set for l2 filter base index > 0", says
hw_packet_filter_set will no longer disable filters configured in
hw_atl2.c. This predicate still seems to disable them.

Is something like i < base_location + mc_list_count needed, with the loop
bounded by base + l2_filter_count (clamped to HW_ATL2_MAC_MAX)? Without
it, multicast reception, including IPv6 solicited-node groups, looks
broken on this hardware.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261026-net-atlantic-aq113-apple-l2-filter-slots-v1-0-d72e99b69583%40jannau.net
