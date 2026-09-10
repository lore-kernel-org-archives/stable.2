Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F633BBFCB;
	Thu, 10 Sep 2026 06:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789022305; cv=none; b=NW0VprgXDzbOaHZDdeknoS+JFLDrUbozZW/eToqL94Qb4dLhU8fZBmTJzsnMyDxP7l5GUvEvCaYr/0KHHPqg1QTMwB9Iapc+48FadSvgJIE19W3xL3MSfdrO67nO9sHUx4Db9m08qZHKJPU7Rh6w40VLHriVIZbvKFsBHFpVNBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789022305; c=relaxed/simple;
	bh=Xa++H7v6qEgzzdyfPyOcE5bKef4SLwZKaPl0D8ZKFaY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mgnzCDEBh/oT562edIxIVOFjGTxU1fuXt2xJNiqJfSAznTBRHOtEDEhXlBrmw/DOIEtHp0470gG17AkAgNiU3o8jqwgPq27mbG1/sHRnbS/aDR1E0RoK2G8p7CA1zA5239jBZfSLWffqMwiL2PvhSm+lein4uENcKj47f5z3WdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHrQgRYL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHrQgRYL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC481F000FF;
	Thu, 10 Sep 2026 06:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789022303;
	bh=PgBCmpi9wIbpt8bE7nm61uWUm4ngcd2ZYPDryY49W1w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FHrQgRYL7RGlmlauPePOIBZIx6Sp9yD3oqZHcOafkPPWEjE1LQ2JjGSco5lIWVBUn
	 yB3aj4Mu6wZVOrVCXJ2ow3iMYKEaWay1CnJXd13GaQGLfgT+XsKx/58HfLktwizuPp
	 ZrJGJpqhPr42k0yEjjFLY2xo7wp2GnGb1jzjQkOvUt5RVzy76zC0wNXvN7L0pb2hCt
	 u08DO9XMGlbUtTyJpaR8agJUY6xdXh6EeWy0AHUfxnJlN5NmWP2irGmniB11g8RlHj
	 Qe67yhfjR4KbzUzmFXLknjsnMhgTd3csraeTBWcmpK5aXAmoPEt0MP3w4Qbso+0jVF
	 kJizgsLlf6sdg==
Subject:
 Re: [PATCH] wifi: wilc1000: validate packet bounds in RX buffer parsing
From: netdev-bot+sashiko@kernel.org
To: elb12345@hotmail.co.uk
Cc: kvalo@kernel.org, ajay.kathat@microchip.com,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, kuba@kernel.org
Date: Thu, 10 Sep 2026 06:38:22 +0000
Message-ID: <178902230252.219967.10764605657139372266@kernel.org>
In-Reply-To: =?utf-8?q?=3CAS8P251MB0001BF71A8397CE77A82E7E2C8B32=40AS8P251MB?=
 =?utf-8?q?0001=2EEURP251=2EPROD=2EOUTLOOK=2ECOM=3E?=
References: =?utf-8?q?=3CAS8P251MB0001BF71A8397CE77A82E7E2C8B32=40AS8P251MB0?=
 =?utf-8?q?001=2EEURP251=2EPROD=2EOUTLOOK=2ECOM=3E?=
X-sashiko-severity: Critical
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

Critical: 1 · High: 1 (1) · Medium: 1 · Low: 0

- [Critical] The `size` that the patched parser now treats as its
  authoritative bound is a raw device-supplied length that is never…
- [High] The new checks bound only the upper end of a record
  (pkt_len/pkt_offset against tp_len, tp_len against size - offset) and…
- [Medium] The new validation still accepts transport records that cannot
  contain their own 4-byte header, and payload offsets that point inside…

Pre-existing issues:
- [High] Short public-action management frames underflow the vendor-IE
  length in wilc_wfi_p2p_rx() (cfg80211.c).

--

wifi: wilc1000: validate packet bounds in RX buffer parsing

The patch converts the record loop in wilc_wlan_handle_rx_buff() from a
do-while into a while loop that requires four header bytes to remain, and
adds checks of tp_len against the remaining buffer plus pkt_len/pkt_offset
against tp_len.  A few questions about how complete the new bounds are.

> diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
> index 4b116fe6f9ea9..3ebcd688f2dd5 100644
> --- a/drivers/net/wireless/microchip/wilc1000/wlan.c
> +++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
> @@ -1111,7 +1111,7 @@ static void wilc_wlan_handle_rx_buff(struct wilc *wilc, u8 *buffer, int size)
>  	int is_cfg_packet;
>  	u8 *buff_ptr;
>  
> -	do {
> +	while (offset + sizeof(u32) <= size) {
>  		buff_ptr = buffer + offset;
>  		header = get_unaligned_le32(buff_ptr);
>  
> @@ -1123,11 +1123,19 @@ static void wilc_wlan_handle_rx_buff(struct wilc *wilc, u8 *buffer, int size)
>  		if (pkt_len == 0 || tp_len == 0)
>  			break;
>  
> +		if (tp_len > size - offset)
> +			break;

[Severity: Critical]
Is "size" itself known to describe memory inside the RX allocation?  The
only producer is wilc_wlan_handle_isr_ext():

drivers/net/wireless/microchip/wilc1000/wlan.c:wilc_wlan_handle_isr_ext() {
	size = FIELD_GET(WILC_INTERRUPT_DATA_SIZE, int_status) << 2;
	...
	if (size <= 0)
		return;

	if (WILC_RX_BUFF_SIZE - offset < size)
		offset = 0;

	buffer = &wilc->rx_buffer[offset];
	...
	ret = wilc->hif_func->hif_block_rx_ext(wilc, 0, buffer, size);
	...
	offset += size;
	wilc->rx_buffer_offset = offset;
	...
	rqe->buffer = buffer;
	rqe->buffer_size = size;
}

WILC_INTERRUPT_DATA_SIZE is GENMASK(14, 0) and the field is word scaled, so
the chip can advertise 32767 << 2 = 131068 bytes, while wilc->rx_buffer is a
single WILC_RX_BUFF_SIZE (96 * 1024 = 98304) byte allocation.  Since size is
u32 the "size <= 0" test never fires, and for size > 98304 the code only
rewinds offset to 0 and still issues hif_block_rx_ext() for the full size;
wilc_sdio_read() and wilc_spi_read() only reject size <= 4, so nothing clamps
the transfer.  Can this write past the end of wilc->rx_buffer?

There also seems to be a second-order effect: rx_buffer_offset is then set to
offset + size (up to 131068), and on the next interrupt
"WILC_RX_BUFF_SIZE - offset" is evaluated in unsigned arithmetic, so
98304 - 131068 wraps to a huge value that is never < size and the rewind
never triggers again.  Would that leave buffer pointing entirely outside the
allocation for every subsequent block read?

Because rqe->buffer_size carries that same unvalidated length, every new
check added here ("tp_len > size - offset" and friends) can pass while the
parser walks memory outside the allocation.  Would clamping size to
WILC_RX_BUFF_SIZE in wilc_wlan_handle_isr_ext() be needed for the new bounds
in this function to mean anything?

>  		if (pkt_offset & IS_MANAGMEMENT) {
> +			if (tp_len < HOST_HDR_OFFSET || pkt_len > tp_len - HOST_HDR_OFFSET)
> +				break;
>  			buff_ptr += HOST_HDR_OFFSET;
>  			wilc_wfi_mgmt_rx(wilc, buff_ptr, pkt_len,
>  					 pkt_offset & IS_MGMT_AUTH_PKT);
>  		} else {

[Severity: High]
This isn't a bug introduced by this patch, but since the management check
here only caps pkt_len from above, short management frames still reach
wilc_wfi_p2p_rx() in cfg80211.c, where the vendor IE length underflows:

drivers/net/wireless/microchip/wilc1000/cfg80211.c:wilc_wfi_p2p_rx() {
	...
	if (!ieee80211_is_action(mgmt->frame_control) ||
	    !ieee80211_is_public_action((struct ieee80211_hdr *)buff, size))
	...
	d = (struct wilc_p2p_pub_act_frame *)(&mgmt->u.action);
	if (d->oui_subtype != GO_NEG_REQ && d->oui_subtype != GO_NEG_RSP &&
	...
	vendor_ie = cfg80211_find_vendor_ie(WLAN_OUI_WFA, WLAN_OUI_TYPE_WFA_P2P,
					    buff + ie_offset, size - ie_offset);
}

ie_offset is offsetof(struct ieee80211_mgmt, u) + sizeof(*d) = 24 + 8 = 32,
but ieee80211_is_public_action() only guarantees
IEEE80211_MIN_ACTION_SIZE(category), i.e. 25 bytes.  For a 31 byte frame
d->oui_subtype (frame offset 30) is still in bounds, and "size - ie_offset"
with u32 size wraps to roughly 4 GiB.  Does that let cfg80211_find_vendor_ie()
scan far past the RX buffer?

A "size >= ie_offset" guard in wilc_wfi_p2p_rx(), and/or a minimum pkt_len
check for management records here, would close it.

> +			if (pkt_offset > tp_len ||
> +			    pkt_len > tp_len - pkt_offset)
> +				break;

[Severity: High]
The new checks bound the upper end of a record but never require a minimum
length, since only zero pkt_len/tp_len is rejected.  Do the consumers still
read past what has been validated?

For the data path, tp_len = pkt_len = 1 with pkt_offset = 0 passes both
checks, and then:

drivers/net/wireless/microchip/wilc1000/netdev.c:wilc_frmw_to_host() {
	...
	wilc_netdev = get_if_handler(wilc, buff);
	if (!wilc_netdev)
		goto out;

	buff += pkt_offset;
}

get_if_handler() is called with the record start, before pkt_offset is added,
and does:

drivers/net/wireless/microchip/wilc1000/netdev.c:get_if_handler() {
	struct ieee80211_hdr *h = (struct ieee80211_hdr *)mac_header;
	...
			if (ether_addr_equal_unaligned(h->addr2, vif->bssid)) {
}

That touches bytes 4..15 of the record.  With the loop guard only requiring
offset + 4 <= size, a record at offset == size - 4 would read up to 12 bytes
beyond the region described by size.

For the config path, pkt_len == 1 is accepted, but:

drivers/net/wireless/microchip/wilc1000/wlan_cfg.c:wilc_wlan_cfg_indicate_rx() {
	msg_type = frame[0];
	msg_id = frame[1];	/* seq no */
	frame += 4;
	size -= 4;
}

size goes negative, and the info handlers then do:

drivers/net/wireless/microchip/wilc1000/hif.c:wilc_gnrl_async_info_received() {
	id = get_unaligned_le32(&buffer[length - 4]);
}

with a u32 length, so length < 4 indexes at 0xFFFFFFFD.  The same pattern
appears in wilc_network_info_received(), which additionally does
kmemdup(&buffer[9], get_unaligned_le16(&buffer[6]) - 1) and can copy up to
65534 bytes out of a record validated as 1..8 bytes.

On the management side, pkt_len == 1 with tp_len == 5 passes, yet
wilc_wfi_mgmt_rx() reads two bytes:

drivers/net/wireless/microchip/wilc1000/netdev.c:wilc_wfi_mgmt_rx() {
		struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)buff;
		u16 type = le16_to_cpup((__le16 *)buff);
}

Would per-branch minimum lengths be needed here, at least
sizeof(struct ieee80211_hdr) before the data classifier, 4 plus the subtype
requirements for config frames, and the parsed header size for management
frames?

[Severity: Medium]
Can a record smaller than its own header still be accepted?  tp_len is only
rejected when zero or larger than the remaining bytes, so tp_len in 1..3
passes even though four header bytes were already consumed, and this branch
accepts pkt_offset in 0..3.

With tp_len = 1, pkt_offset = 0, pkt_len = 1, one byte of the framing header
itself is handed to wilc_frmw_to_host() as packet data, and

		offset += tp_len;

advances by 1, so the next iteration parses a header overlapping the record
just consumed.  Even with a large tp_len, pkt_offset = 0 makes the four byte
receive header the first bytes of the Ethernet or configuration frame, which
wilc_wlan_cfg_indicate_rx() then reads as msg_type/msg_id.

Should the checks require tp_len >= sizeof(u32), and pkt_offset >=
HOST_HDR_OFFSET for non-management records?

>  			if (!is_cfg_packet) {
>  				wilc_frmw_to_host(wilc, buff_ptr, pkt_len,
>  						  pkt_offset);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/AS8P251MB0001BF71A8397CE77A82E7E2C8B32%40AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
