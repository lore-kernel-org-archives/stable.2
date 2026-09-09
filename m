Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D2C39AD55;
	Wed,  9 Sep 2026 18:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788979349; cv=none; b=uUShRbr88fz5f+WbLaXP3EQzBVFrh31aD2pbknFYa/DQiW52bOZnP83rPMmGgClnhVfHCpiNMuMLLuZIjtK0WBwY2cPa5v7+O+iijPoVO7EBmph4Ru0xW8oGltKJzjzxmPlWFtc47j7vQzukur4bBgEWBh4C0jN9wuEAltYXQ9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788979349; c=relaxed/simple;
	bh=vishV5fuTs5iBOtlLv8W5MtQa9iD8lEiA5+8KhLHHAo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S5sjODJcZFiNpPkTx2JZRAiGb2UMe+/7h94Ghd6rYZeTNSEmAVDIsRzsztNi7b7RTqrWWzoXe9QHirWa9TukPldTz0xSuboIW6AexTfk8BDICvZacPQqg2F8YDA17LroHrDgve9AynKWrGt9YQI4p/IxxVmfw1NsPW/7/yBtNfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXdpqJJ7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXdpqJJ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B5A1F000FF;
	Wed,  9 Sep 2026 18:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788979347;
	bh=1X1pJMZ491RdYGpH9hzqiianfRrvhBC5mGwVqdCjDhM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XXdpqJJ7XOnfHxBwy+NBy5dvDtDLnA7ThQDzMz6e6gXB4y7mOkCula21VPnbp3q/C
	 iHaGj2dCMygKLVXF6ocXyfe0RhOiKodkPKW1uvNki4RzedBM/d0Q6F8GrO8nxDhpWr
	 FfzUPhO/LU92NFPNMSdrOwwOAD+Z7VvUh0ybzC8ociprM8l25j/lmd/qAUYd0a7o7z
	 ekcLF9VijbG/fdP1bD0vKrOaQDccpd/jUljzmaPJ+6mjE3te2acd+XH+rAV5T4Yawz
	 LP+kJB8B333hM16w9qR7m3p10ddlwBpvaQ1FqiDTSeYfDHkL2yUO7XTJqEcC3/PdnF
	 i88PqEagP101Q==
Subject:
 Re: [PATCH] wifi: mm81x: validate packet length in mm81x_yaps_read_pkt()
From: netdev-bot+sashiko@kernel.org
To: elb12345@hotmail.co.uk
Cc: lachlan.hodges@morsemicro.com, dan.callaghan@morsemicro.com,
 kvalo@kernel.org, arien.judge@morsemicro.com, johannes@sipsolutions.net,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 stable@vger.kernel.org, kuba@kernel.org
Date: Wed, 09 Sep 2026 18:42:26 +0000
Message-ID: <178897934638.219967.5289393639495920738@kernel.org>
In-Reply-To: =?utf-8?q?=3CAS8P251MB0001B650C31E9F37C3B7907BC8B32=40AS8P251MB?=
 =?utf-8?q?0001=2EEURP251=2EPROD=2EOUTLOOK=2ECOM=3E?=
References: =?utf-8?q?=3CAS8P251MB0001B650C31E9F37C3B7907BC8B32=40AS8P251MB0?=
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 1 (1) · Medium: 0 (2) · Low: 0

- [High] Incomplete fix / wrong ordering: the header-claimed-length
  validation added by this patch runs ~30 lines AFTER…

Pre-existing issues:
- [High] Missing minimum-payload validation lets an undersized device
  command response reach mm81x_cmd_resp_process()…
- [Medium] Two RX parse sites disagree on the meaning of struct
  mm81x_skb_hdr's `offset` field.
- [Medium] skb leak on the -ENOMEM path of mm81x_yaps_hw_read_pkts().

--

wifi: mm81x: validate packet length in mm81x_yaps_read_pkt()

The patch adds two length checks to mm81x_yaps_read_pkt(): a minimum
length check before the struct mm81x_skb_hdr cast, and a check that the
header-claimed total length does not exceed skb->len before the packet is
trimmed and enqueued.  A few questions about the placement of the second
check and about the paths that consume the validated packet.

> diff --git a/drivers/net/wireless/morsemicro/mm81x/yaps.c b/drivers/net/wireless/morsemicro/mm81x/yaps.c
> index e98a2a58726f5..da2c88901d64c 100644
> --- a/drivers/net/wireless/morsemicro/mm81x/yaps.c
> +++ b/drivers/net/wireless/morsemicro/mm81x/yaps.c
> @@ -147,6 +147,13 @@ static int mm81x_yaps_read_pkt(struct mm81x_yaps *yaps, struct sk_buff *skb)
>  
>  	__skb_queue_head_init(&skbq);
>  
> +	if (skb->len < sizeof(*hdr)) {
> +		dev_err(mors->dev, "packet too short for header (%u < %zu)",
> +			skb->len, sizeof(*hdr));
> +		ret = -EINVAL;
> +		goto exit_return_page;
> +	}
> +
>  	hdr = (struct mm81x_skb_hdr *)skb->data;
>  	if (hdr->sync != MM81X_SKB_HEADER_SYNC) {
>  		dev_err(mors->dev, "sync value error [0xAA:%d], hdr.len %d",

> @@ -186,6 +193,14 @@ static int mm81x_yaps_read_pkt(struct mm81x_yaps *yaps, struct sk_buff *skb)
>  	}
>  
>  	skb_len = sizeof(*hdr) + hdr->offset + le16_to_cpu(hdr->len);
> +	if (skb_len > skb->len) {
> +		dev_err(mors->dev,
> +			"header claims %d bytes but packet is only %u",
> +			skb_len, skb->len);
> +		ret = -EINVAL;
> +		goto exit_return_page;
> +	}
> +

[Severity: High]
Does this check come too late to protect the checksum walk?  In
mm81x_yaps_read_pkt() the checksum helper is called earlier, between the
sync check and the channel switch, while hdr->len is still unvalidated:

	if (yaps->mors->hif.validate_skb_checksum &&
	    !mm81x_skbq_validate_checksum(skb->data)) {

mm81x_skbq_validate_checksum() in skbq.c takes no buffer length at all and
derives its read extent from the device-supplied header:

	u16 len = le16_to_cpu(skb_hdr->len) + sizeof(*skb_hdr);
	u32 *data_to_xor = (u32 *)data;
	...
	for (i = 0; i < len; i += 4) {
		xor ^= *data_to_xor;
		data_to_xor++;
	}

The real bound on the buffer is the YAPS delimiter size, which is
independent of hdr->len, in mm81x_yaps_hw_read_pkts():

	pkts[i].skb = dev_alloc_skb(pkt_size);
	...
	skb_put(pkts[i].skb, pkt_size);

So with pkt_size == sizeof(struct mm81x_skb_hdr) and hdr->len == 0xFFFF,
can this read roughly 64 KiB past the end of the skb data allocation before
the new skb_len check runs?

Separately, the same helper dereferences an 802.11 header placed just after
the mm81x header:

	struct ieee80211_hdr *hdr =
		(struct ieee80211_hdr *)(data + sizeof(*skb_hdr));
	...
	    (ieee80211_is_data(hdr->frame_control) ||

with the new minimum check accepting skb->len == sizeof(*hdr) exactly, is
that frame_control read (and the clamped span sizeof(*skb_hdr) +
sizeof(struct ieee80211_qos_hdr) + IEEE80211_CCMP_HDR_LEN) also outside the
packet data?

The path looks live: mors->hif.validate_skb_checksum is set from the
firmware host table in mm81x_fw_update_validate_skb_checksum():

	mors->hif.validate_skb_checksum =
		validate_checksum->insert_and_validate_checksum;

Would computing and validating skb_len before the
mm81x_skbq_validate_checksum() call, or passing the available length into
that helper and bounding its loop there, close this?

[Severity: High]
This isn't a bug introduced by this patch, but since these checks are the
new choke point for RX length validation: is a minimum payload length also
needed per channel?  hdr->len == 0 passes both new checks, and
mm81x_skbq_dispatch_work() then strips the header entirely:

	/* Remove mm81x header and padding */
	__skb_pull(pfirst, sizeof(*hdr) + hdr->offset);

	switch (channel) {
	case MM81X_SKB_CHAN_COMMAND:
		mm81x_cmd_resp_process(mors, pfirst);

mm81x_cmd_resp_process() in command.c dereferences the response header with
no skb->len check at all:

	struct host_cmd_resp *src_resp = (struct host_cmd_resp *)(skb->data);
	...
	u16 resp_message_id = le16_to_cpu(src_resp->hdr.message_id);
	u16 resp_host_id = le16_to_cpu(src_resp->hdr.host_id);

and on the matched-response path the memcpy source length is bounded only
by the destination size and a second device-supplied length:

	length = min_t(int, length,
		       le16_to_cpu(src_resp->hdr.len) +
			       sizeof(struct host_cmd_header));
	memcpy(dest_resp, src_resp, length);

For a zero-length command payload with a large embedded hdr.len, does this
copy adjacent slab memory into the driver's command response structure?

[Severity: Medium]
This is a pre-existing issue, but the length formula being validated here
includes hdr->offset while the checksum helper does not.  The dispatch path
and the TX producer both treat offset as padding between the header and the
payload:

skbq.c:mm81x_skbq_dispatch_work()
	__skb_pull(pfirst, sizeof(*hdr) + hdr->offset);

skbq.c:mm81x_skbq_skb_tx()
	hdr.len = cpu_to_le16(skb->len);
	hdr.offset = data - (aligned_head + sizeof(hdr));

whereas mm81x_skbq_validate_checksum() ignores offset:

	struct ieee80211_hdr *hdr =
		(struct ieee80211_hdr *)(data + sizeof(*skb_hdr));
	u16 len = le16_to_cpu(skb_hdr->len) + sizeof(*skb_hdr);

For an RX packet with hdr->offset != 0, does the helper then read padding
bytes as frame_control and XOR a byte range shifted by offset, producing a
checksum verdict over the wrong bytes?

>  	skb_bytes_remaining = mm81x_skbq_space(mq);
>  
>  	if (skb_len > skb_bytes_remaining) {

[Severity: Medium]
This isn't a bug introduced by this patch, but while looking at the caller
of mm81x_yaps_read_pkt(): can the -ENOMEM path of
mm81x_yaps_hw_read_pkts() leak the already allocated RX skbs?

yaps_hw.c:mm81x_yaps_hw_read_pkts() bumps the count after each successful
packet and bails out on allocation failure:

		if (pkts[i].skb)
			dev_err(yaps->mors->dev, "yaps packet leak");

		/* SKB doesn't want padding */
		pkts[i].skb = dev_alloc_skb(pkt_size);
		if (!pkts[i].skb) {
			ret = -ENOMEM;
			dev_err(yaps->mors->dev, "yaps no mem for skb");
			goto exit;
		}

yaps.c:mm81x_yaps_rx_handler() then skips the only loop that takes
ownership of them:

	if (ret && ret != -EAGAIN) {
		dev_err(yaps->mors->dev, "YAPS read_pkts fail: %d", ret);
		goto exit;
	}

	for (i = 0; i < num_pks_received; ++i) {
		mm81x_yaps_read_pkt(yaps, yaps->hw.from_chip_pkts[i].skb);
		yaps->hw.from_chip_pkts[i].skb = NULL;
	}

Since ownership is only released inside mm81x_yaps_read_pkt() (enqueue or
dev_kfree_skb()), and rx_handler returns true for -ENOMEM so it is called
again, does the next pass simply hit the "yaps packet leak" dev_err and
overwrite the stale pointers?  The same appears to apply to the
mm81x_dm_read() overhang error path.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/AS8P251MB0001B650C31E9F37C3B7907BC8B32%40AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
