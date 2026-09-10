Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B93737E5C9;
	Thu, 10 Sep 2026 03:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789011488; cv=none; b=D4kJKUl/5f23MIeJNANGMj/PYp3/4yzX6hK9PtjDKoYlfsdqPosmUY2Lwu/1KLHeRBRG4VsKkBqh758g08jvrNcYlMasY3vJUAgFvMaCj8uOabWnT2I6AUGqT0THzVBfSJ3oXTTuAvM3uH9nTgwKK/b3yX4A4iDQ8hdo5xe9vBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789011488; c=relaxed/simple;
	bh=Hr3oZU2DGTaJF7RYY8SHEQiTy9FvjwzGSb7rHZ3HIUo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rW0h6IsgNWxuBwf5j4LVZ/ZTGmUp43u8U2TrG7K1DtiMHjKMDVdTGvdHJq14WDqGyDW4uKqBZKjlpX8+/Zpra8BeSWeeoPsxaBeWGLJaIx/tXVvUhh8ypE3UCJ0b4BIZz2xqS4zdVye1D1odp66vZ3tSPl8eim7OtTlHOzFOYvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FaAKqWyo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FaAKqWyo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 918931F000FF;
	Thu, 10 Sep 2026 03:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789011487;
	bh=4CSDVEKhvI/miVbVmt/K0SX2SLNYpqDTjFSavY1zd+c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FaAKqWyoNsz0qLMCX3xXwnnbqOb9qQ3w/JzzC3+VPyJTSUp36+/sdtbuWaxikt0SS
	 0olodx8qn0NcUVNICHB/c4IyT7OoEqgDwSMklGPoANR/lksWR4mVJuiy2PsJEeCJCy
	 mYk8AXnFb+MoYq/yX/PMaALGkLtvUdn+5crILdImIJZLUvE+LC0PLIpvojN1Myz6X6
	 1fnABXBf7PbPLxM4IGj8p3Ep2icWTBlmVLC4+JZBDxcCu4yhAGdHGrHCin189e0MSG
	 lhsybP4Hy5ASCkINS3CDT10QcKZfkahKkj5MG+pOggF0lyaefEpLYjmwzPqIthaeNq
	 KLt2RptIXSjHA==
Subject: Re: [PATCH] wifi: mwifiex: validate scan response TLV lengths
From: netdev-bot+sashiko@kernel.org
To: elb12345@hotmail.co.uk
Cc: briannorris@chromium.org, kvalo@kernel.org, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 kuba@kernel.org
Date: Thu, 10 Sep 2026 03:38:06 +0000
Message-ID: <178901148617.219967.9577139649619803564@kernel.org>
In-Reply-To: =?utf-8?q?=3CAS8P251MB0001DD15CC44F76B4BBD2853C8B32=40AS8P251MB?=
 =?utf-8?q?0001=2EEURP251=2EPROD=2EOUTLOOK=2ECOM=3E?=
References: =?utf-8?q?=3CAS8P251MB0001DD15CC44F76B4BBD2853C8B32=40AS8P251MB0?=
 =?utf-8?q?001=2EEURP251=2EPROD=2EOUTLOOK=2ECOM=3E?=
X-sashiko-severity: High
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

Critical: 0 · High: 2 · Medium: 1 · Low: 0

- [High] Incomplete fix: the new bound check in mwifiex_ret_802_11_scan()
  (drivers/net/wireless/marvell/mwifiex/scan.c:2143-2150) validates the…
- [High] The newly added `chan_band_tlv = NULL` invalidation
  (drivers/net/wireless/marvell/mwifiex/scan.c:2182-2185) creates a…
- [Medium] The new bss_descript_size validation
  (drivers/net/wireless/marvell/mwifiex/scan.c:2143-2150) and the…

--

wifi: mwifiex: validate scan response TLV lengths

This adds three checks to mwifiex_ret_802_11_scan(): a bound check on the
firmware-supplied bss_descript_size against the response size, and
invalidation of the TSF and channel-band TLVs when their reported lengths
are too short for number_of_sets entries.  A few questions on the new
checks below.

> diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
> index 97c0ec3b822e7..4d0f3c412a900 100644
> --- a/drivers/net/wireless/marvell/mwifiex/scan.c
> +++ b/drivers/net/wireless/marvell/mwifiex/scan.c
> @@ -2137,11 +2137,18 @@ int mwifiex_ret_802_11_scan(struct mwifiex_private *priv,
>  	bss_info = scan_rsp->bss_desc_and_tlv_buffer;
>  
>  	/*
> -	 * The size of the TLV buffer is equal to the entire command response
> -	 *   size (scan_resp_size) minus the fixed fields (sizeof()'s), the
> -	 *   BSS Descriptions (bss_descript_size as bytesLef) and the command
> -	 *   response header (S_DS_GEN)
> +	 * Validate that bss_descript_size fits within the response to
> +	 * prevent an underflow in the TLV buffer size computation below.
>  	 */
> +	if (bytes_left + sizeof(scan_rsp->bss_descript_size) +
> +	    sizeof(scan_rsp->number_of_sets) + S_DS_GEN > scan_resp_size) {
> +		mwifiex_dbg(adapter, ERROR,
> +			    "SCAN_RESP: bss_descript_size %u exceeds resp size %u\n",
> +			    bytes_left, scan_resp_size);
> +		ret = -1;
> +		goto check_next_scan;
> +	}
> +

[Severity: High]
Does this check actually bound the parse to the received buffer?  The
reference used here is scan_resp_size, which comes from
le16_to_cpu(resp->size) a few lines above, and resp->size is itself a
firmware-supplied field.

The dispatcher never reconciles it with the length of the skb that was
actually received:

drivers/net/wireless/marvell/mwifiex/cmdevt.c:mwifiex_process_cmdresp() {
	...
	resp = (struct host_cmd_ds_command *)adapter->curr_cmd->resp_skb->data;
	...
}

A grep for resp_skb->len in drivers/net/wireless/marvell/mwifiex/ returns
no matches, and the only clamp against MWIFIEX_SIZE_OF_CMD_BUFFER is on the
CMD_F_HOSTCMD copy path, which does not apply to the scan handler.  On PCIe
the response buffer is allocated at MWIFIEX_UPLD_SIZE and then trimmed to
the transport length:

drivers/net/wireless/marvell/mwifiex/pcie.c:mwifiex_pcie_process_cmd_complete() {
	...
	rx_len = get_unaligned_le16(skb->data);
	skb_put(skb, MWIFIEX_UPLD_SIZE - skb->len);
	skb_trim(skb, rx_len);
	...
}

and on USB only an upper bound on skb->len is enforced in
mwifiex_usb_recv().

So can a response that carries only a couple of kilobytes but declares
resp->size = 0xFFFF (with a small bss_descript_size) pass this new check
and leave tlv_buf_size at roughly 64 KB?

	tlv_buf_size = scan_resp_size - (bytes_left
					 + sizeof(scan_rsp->bss_descript_size)
					 + sizeof(scan_rsp->number_of_sets)
					 + S_DS_GEN);

mwifiex_ret_802_11_scan_get_tlv_ptrs() then walks TLV headers with that
bound, and mwifiex_parse_single_response_buf() consumes bytes_left
descriptor bytes, both past the end of the real allocation.  If that is
correct, the "TLV search to read past the response buffer" case described
in the changelog is still reachable, just bounded at ~64 KB rather than
unbounded.  Would it be better to anchor the check on
adapter->curr_cmd->resp_skb->len (or validate/clamp resp->size against it
in mwifiex_process_cmdresp()) instead of on resp->size?

[Severity: Medium]
Is the fixed-header term correct for the background-scan variant?  Earlier
in mwifiex_ret_802_11_scan() the response can be the nested bgscan form:

	if (is_bgscan_resp)
		scan_rsp = &resp->params.bg_scan_query_resp.scan_resp;
	else
		scan_rsp = &resp->params.scan_resp;

and fw.h defines that variant with an extra 32-bit field ahead of the
nested structure:

struct host_cmd_ds_802_11_bg_scan_query_rsp {
	__le32 report_condition;
	struct host_cmd_ds_802_11_scan_rsp scan_resp;
} __packed;

Since resp->size counts from the start of struct host_cmd_ds_command, the
fixed part for a HostCmd_CMD_802_11_BG_SCAN_QUERY response is
S_DS_GEN + 4 + 3, not S_DS_GEN + 3.  Does that mean the new check accepts a
bss_descript_size that extends four bytes past the firmware-declared
response, and that tlv_buf_size is likewise four bytes too large, so
mwifiex_ret_802_11_scan_get_tlv_ptrs() can accept a TLV header that lies
partly outside the declared payload?  The resulting header.len is then
trusted as the upper bound by the two new TSF/chan-band checks.  Would
deriving the fixed size from the selected response variant be preferable to
carrying the existing S_DS_GEN-only formula into the new guard?

>  	tlv_buf_size = scan_resp_size - (bytes_left
>  					 + sizeof(scan_rsp->bss_descript_size)
>  					 + sizeof(scan_rsp->number_of_sets)

[ ... ]

> @@ -2165,6 +2178,12 @@ int mwifiex_ret_802_11_scan(struct mwifiex_private *priv,
>  					     (struct mwifiex_ie_types_data **)
>  					     &chan_band_tlv);
>  
> +	/* Validate chan-band TLV has enough entries for all reported BSS */
> +	if (chan_band_tlv &&
> +	    le16_to_cpu(chan_band_tlv->header.len) <
> +	    scan_rsp->number_of_sets * sizeof(struct chan_band_param_set))
> +		chan_band_tlv = NULL;
> +

[Severity: High]
Can clearing chan_band_tlv here leave adapter->nd_info in an inconsistent
state?  n_matches is published from number_of_sets regardless:

	if (nd_config) {
		adapter->nd_info =
			kzalloc_flex(*adapter->nd_info, matches,
				     scan_rsp->number_of_sets, GFP_ATOMIC);

		if (adapter->nd_info)
			adapter->nd_info->n_matches = scan_rsp->number_of_sets;
	}

but the per-entry allocation in the loop below is gated on chan_band_tlv:

		if (chan_band_tlv && adapter->nd_info) {
			adapter->nd_info->matches[idx] =
				kzalloc(sizeof(*pmatch) + sizeof(u32),
					GFP_ATOMIC);

So with a short chan-band TLV, n_matches is non-zero while every
matches[i] stays NULL.  mwifiex_ret_wakeup_reason() then hands that object
to cfg80211:

drivers/net/wireless/marvell/mwifiex/cfg80211.c:mwifiex_ret_wakeup_reason() {
	...
	if (wiphy->wowlan_config->nd_config)
		wakeup_report.net_detect = adapter->nd_info;
	...
}

and nl80211 dereferences the entries without a NULL check:

net/wireless/nl80211.c:cfg80211_net_detect_results() {
	...
	for (i = 0; i < nd->n_matches; i++) {
		struct cfg80211_wowlan_nd_match *match = nd->matches[i];
		...
		if (nla_put(msg, NL80211_ATTR_SSID, match->ssid.ssid_len,
			    match->ssid.ssid)) {
	...
}

Before this hunk a short chan-band TLV still produced a non-NULL
chan_band_tlv (with the out-of-bounds read of chan_band_param[idx] the
changelog describes), so does this trade that read for a NULL dereference
on the wowlan wakeup report path?

The same inconsistency looks reachable without this patch as well, when
firmware omits the chan-band TLV entirely, when the GFP_ATOMIC kzalloc of a
match fails, or when the loop exits early on bytes_left == 0 or the parse
error goto.  Would setting n_matches after the loop to the number of
entries actually populated, or dropping nd_info when the chan-band TLV is
unusable, cover all of those?

>  #ifdef CONFIG_PM
>  	if (priv->wdev.wiphy->wowlan_config)
>  		nd_config = priv->wdev.wiphy->wowlan_config->nd_config;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/AS8P251MB0001DD15CC44F76B4BBD2853C8B32%40AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
