Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794550807;
	b=A0aJsUrN9u1H0LdZrUqwaKtYmZW1sq7ddCJuhuIpw3YbjJ9esWpDywlsUbkISqOUQy+E
	 O2EZ1+VYM9ulFmuWUl3FmkXgQoTEYLoISPQVgxsrHQUsYX5N4lac3HwN+97hfeYLN9Zo+
	 FM3Zw1YDEy1l+iks5MMgPHxOG3JIjZlEBb0Dm2Blb6MFL6Ug9p3dPeX5AV5Dyah/uzjNj
	 Q8cgGl7YR6f2e6UuKRfrZN+2mAQlSxuzWjmBAW/bVypHZmNQwzOBn17v0l6yN5Ls/Ruhf
	 dM5xoer73s9Lu6rDqeFdHBe/xHvXqb7p4EdLCM03hIDzbOR+TnIMP+OWYy5INIu+ggg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794550807;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=xVG5t2W2o9XoVpp1CRKBgp0/TGk3mpdhcRA/ef2Xr2Y=;
	b=d8zSbS4dxnvOIXfzgXIbTNtWg2GfeyDJMWxkMgXEmyFZWQft8MrsToAajvmJDKfz6vEw
	 TR6uw4g3p64tN5P23s7+2IM3LSnfI4wEhPi94wGPhx2Sii+Mg9YL/Sv5HOKUQ/X8hJ8WN
	 cAppQAiDhOz/sSzXOZzxRpACdWa9yz56J47KPPpiz66IuK0mYBxvKklhHqLPWpVnxN4Pz
	 c5WTz78bBBDly2va5fRB9MC9Q3psdt4P61wBPziGSTc7+6Jz/mUfd6bW/2768gnnfFp7U
	 dyM0uLZKiaXccR6cf6pCUfWF2lrJX3yCrEnlf9jjr5LCVTa87u3dc+skMQTIYrYqbAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="kCJpktZ/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4544606A321;
	Fri, 13 Nov 2026 06:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kCJpktZ/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E511F000C6;
	Fri, 13 Nov 2026 06:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794550807;
	bh=xVG5t2W2o9XoVpp1CRKBgp0/TGk3mpdhcRA/ef2Xr2Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kCJpktZ/brLRFx365O/7CLatvdHGiQDETVGHsj14RQoZUjgnyqX6xwvT469bXm2Ol
	 xUdhMuGdml9yggDVsXsQcHi3UKjyeh3neAO2hBdRog7oZ9s223Bf82fZmx4VKs/N/3
	 qe2L+dYU9YX4WG0LZStX9AHeAGwYBO7eHEcj7OeY7A57bw+cxvr0w/PVQlKXdynTl8
	 mirWBQ61oq3P4ey32NJUs4GHIe5yXx+jOA5kbhXQF/0NsL0gov4ni03k2isrC9i4Ah
	 v30L4ArfdvlYKw+OJzRxDNpgXSIbfsXzxsWOBlLzIEQenaeIK4tVg4mBsuIR+CGfFy
	 Jcc6i0dwv+Czw==
Subject: Re: [PATCH v2 1/2] can: kvaser_usb: hydra: reject commands shorter
 than a standard command
From: netdev-bot+sashiko@kernel.org
To: joasantonio108@gmail.com
Cc: mkl@pengutronix.de, mailhol@kernel.org, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, kuba@kernel.org
Date: Fri, 13 Nov 2026 06:20:06 +0000
Message-ID: <179455080659.488853.16385124375169426280@kernel.org>
In-Reply-To: <20261111-kvaser-usb-validate-v2-1-193dc10ca19b@gmail.com>
References: <20261111-kvaser-usb-validate-v2-1-193dc10ca19b@gmail.com>
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

Critical: 0 · High: 2 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new 32-byte floor (cmd_len < sizeof(struct kvaser_cmd)) only
  covers the fixed part of an extended command.
- [High] The commit message says 'Treat a shorter length as a format
  error in both parsers', but the usb_rx_leftover reassembly path in…
- [Medium] The patch rejects every CMD_EXTENDED command whose len is
  below 32 bytes, including extended command numbers the driver doesn't…

--

can: kvaser_usb: hydra: reject commands shorter than a standard command

This commit treats any command length below sizeof(struct kvaser_cmd)
(32 bytes) as a format error. The check is added to both
kvaser_usb_hydra_wait_cmd() and kvaser_usb_hydra_read_bulk_callback().
The goal is to prevent an infinite loop on zero-length extended commands
and to stop handlers from reading past short extended commands.

> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> index 687911d764ded..9adb4eb36e394 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c

[ ... ]

> @@ -2156,6 +2157,11 @@ static void kvaser_usb_hydra_read_bulk_callback(struct kvaser_usb *dev,
>  
>  		cmd_len = kvaser_usb_hydra_cmd_size(cmd);
>  
> +		if (cmd_len < sizeof(struct kvaser_cmd)) {

[Severity: High]

Does a 32-byte floor cover the whole extended RX command? The fixed part
of struct kvaser_cmd_ext_rx_can ends at byte 32. kcan_payload[64] and
err_frame_data come after it, and kvaser_usb_hydra_rx_msg_ext() never
checks the payload size against the command's len:

kvaser_usb_hydra_rx_msg_ext() {
    ...
	if (flags & KVASER_USB_HYDRA_CF_FLAG_FDF) {
		cf->len = can_fd_dlc2len(dlc);
    ...
		memcpy(cf->data, cmd->rx_can.kcan_payload, cf->len);
    ...
}

Take a device that sends CMD_EXTENDED / CMD_RX_MESSAGE_FD with len == 32,
KVASER_USB_HYDRA_CF_FLAG_FDF set and DLC 15 in kcan_header. That command
passes the new check, and the memcpy() then reads bytes 32..95 of a
32-byte command.

An error frame reads err_frame_data at bytes 32..39. A classic frame
reads up to 8 bytes past the end.

In this function the buffer is the 3072-byte URB buffer. Suppose the
32-byte extended command ends exactly at byte 3072, for example after 95
standard commands. Can the memcpy() then read up to 64 bytes past the end
of that allocation?

For HCDs without DMA, such as vhci_hcd, hcd_buffer_alloc() uses
kmalloc(). The bytes read end up in a CAN FD frame passed to netif_rx(),
where any CAN socket can read them.

The commit message says:

  "so a shorter extended command makes the handlers read bytes that are
  not part of the command."

That kind of read still looks reachable here. The TX side sets len to
include the payload:

kvaser_usb_hydra_frame_to_cmd_ext() {
    ...
	*cmd_len = ALIGN(sizeof(struct kvaser_cmd_ext) -
			 sizeof(cmd->tx_can.kcan_payload) + nbr_of_bytes,
			 8);
    ...
}

Should the handler, or the parser using cmd_len, check the offset of
kcan_payload plus cf->len (or plus sizeof(err_frame_data)) against
cmd_len?

> +			dev_err(&dev->intf->dev, "Format error\n");
> +			return;

[Severity: Medium]

Does this floor also reject well-formed extended commands that the driver
just doesn't handle? The extended format only needs the 8-byte header.
kvaser_usb_hydra_handle_cmd_ext() already has a default branch for
unknown commands, and that branch only reads header bytes:

kvaser_usb_hydra_handle_cmd_ext() {
    ...
	default:
		dev_warn(&dev->intf->dev, "Unhandled extended command (%d)\n",
			 cmd->header.cmd_no);
		break;
    ...
}

Before this patch, an unknown extended command of 8 to 31 bytes was
skipped with pos += cmd_len, and the rest of the transfer was still
parsed. The commit message only shows that the extended commands the
driver handles or sends are at least 32 bytes.

With the return here, everything after such a command in the URB is
dropped, including CMD_TX_ACKNOWLEDGE / CMD_TX_ACKNOWLEDGE_FD and RX
frames. A following command that crosses the URB boundary is not saved
as leftover either.

kvaser_usb_hydra_tx_acknowledge() is the only place that does these
things:

- releases the echo skb
- resets context->echo_index
- decrements active_tx_contexts
- wakes the queue

Could each lost ACK leak a TX context, until the TX queue stays stopped?

It isn't clear that any shipping Kvaser firmware sends extended commands
shorter than 32 bytes, so this may only be theoretical.

Would it be safer to abort only on lengths that can't be skipped (shorter
than the 8-byte header)? The 32-byte requirement could then apply only to
CMD_TX_ACKNOWLEDGE_FD and CMD_RX_MESSAGE_FD.

> +		}
> +

[Severity: High]

The commit message says:

  "Treat a shorter length as a format error in both parsers."

Does that also cover the usb_rx_leftover reassembly path at the top of
kvaser_usb_hydra_read_bulk_callback()? There, cmd_len is computed from
usb_rx_leftover before the remaining bytes are copied in, and it is
never compared with sizeof(struct kvaser_cmd):

kvaser_usb_hydra_read_bulk_callback() {
    ...
	if (usb_rx_leftover_len) {
		...
		cmd_len = kvaser_usb_hydra_cmd_size(cmd);
		...
		if (remaining_bytes + usb_rx_leftover_len == cmd_len) {
			kvaser_usb_hydra_handle_cmd(dev, cmd);
    ...
}

What happens if a transfer ends 1 to 5 bytes into a CMD_EXTENDED header,
before the le16 len field at bytes 4-5 has fully arrived?

In the main loop, the new check reads ext->len from bytes past len. The
URB buffer is reused, so those bytes are stale data from an earlier
transfer. If they give cmd_len >= 32, the partial header is saved as
leftover.

On the next callback, bytes 4-5 of usb_rx_leftover are stale as well.
For example, with 5 bytes saved, usb_rx_leftover[4] == 8 and
usb_rx_leftover[5] == 0 give cmd_len = 8 and remaining_bytes = 3. Since
3 + 5 == cmd_len, kvaser_usb_hydra_handle_cmd() runs on an 8-byte
extended command.

If cmd_no_ext is CMD_RX_MESSAGE_FD or CMD_TX_ACKNOWLEDGE_FD, the handlers
read fixed fields and payload up to byte 96 of usb_rx_leftover. That
stays inside the 128-byte array. The data is stale and not part of the
command, though, so it can produce bogus CAN frames or bogus TX
acknowledgements.

The new main-loop check can also reject a legitimately split command,
because it decides based on bytes that have not been received yet.

Would it make sense to add the minimum length check to the leftover
branch too? In both branches, ext->len could also be ignored until
offsetof(struct kvaser_cmd_ext, cmd_no_ext) bytes have arrived.

>  		if (pos + cmd_len > len) {
>  			/* We got first part of a command */
>  			int leftover_bytes;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111-kvaser-usb-validate-v2-0-193dc10ca19b%40gmail.com
