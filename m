Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795617997;
	b=JhO43Nj6hGLWckJZC4t++7KDJzrmaSVVCGBMvM1ndnZnpqQkWbzNlVk0yFu9A0kZcZNk
	 0S9hOF7C69/rPIY8Tf8UOFl9kt1CqiVac9QdazR6oSbiX29hRmAlTLHwJcK3fsvZ1OVTo
	 01gKSOVzBF7jpnQ/WbxdcS5nR5z3OuuVxliH0Gj1mjlx8cd5kmmuBf9VpxocmDhMb82qT
	 CVp9SoI+06VAO8aACOuxpI9vXUaApqtmwPmeAyHRi4kqElo6jELX2tbNPPxILOhXu7Jwm
	 1S+CLPjLDi6yOgC4apHn2eOe2Or+kFC9YJDTFw8CUY2fobEV+v5/DwkbToNwXKIatng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795617997;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=nJk16XJtGG6xY9CI4OfDBArJJDLGHRkzPsBIni1jdaI=;
	b=LVrDxIda4+IVHo3DTPLWPRmPZv2p18x94BpYoOk0J58uGdbbKJ8R4flTEG6RWM8xrp8j
	 XLuyrSvv2U38PbfYvGp+XFXiKkIFoxfvy4FvJAvVKAmlCnapZIf3IcmUxRpRozAjv8orh
	 B0//NkJ8WJB7OACB3l+NqQ3cCw6yh7CwTm5esYGII/ho3mPBqrU4Ih2nczkQYERnDWBZb
	 ehDfWhBe0/21k3705RDxV0EkhPIV+wYZgDRRFOWfVOs1IWFwyqSgM8qBxg+bXMXxLklLe
	 V476eOmVT+6/rIWkIklTbe/AqjNH7FOXMG5KFc8Yr1hHLgmahjFIQzlB2P+W7BCQqCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="kGqG/avY";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7C8606A330;
	Wed, 25 Nov 2026 14:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kGqG/avY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B6E21F000C0;
	Wed, 25 Nov 2026 14:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795617996;
	bh=nJk16XJtGG6xY9CI4OfDBArJJDLGHRkzPsBIni1jdaI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kGqG/avY6dGh6ZIq3dBAADn7NH8KSYi4urJrV7fc0OzmFSHyQc5zrnTthDj10rKcN
	 ckZPXkACdYbO1y3YstCIfgtBWMnPUULqEGNqMnryUqfvK+2OXfGhDxBvZC8ht5dZDB
	 hoIRlBN4Kce8N4Sr6/lCH1HDLLu+ji5Y+6yuvd29u1QiuyTcJ8ENzzcwsby+eqGt8s
	 rfj4zn4dcJtnDc7q9YmZrFSCI9LvEaV+bvgiinUky3GBnMBP70b1gv8GqSJ3oyM0vZ
	 8TwWgXWADCuO1RtHzlL6rjWIZ1jYT69VD42IFsAtzRE9JLYC9mjkbHW64Gjj2rkIUm
	 cIN8HROmS14fg==
Subject:
 Re: [PATCH net v4 3/5] net: wwan: iosm: bound the ACBH command chain walk
From: netdev-bot+sashiko@kernel.org
To: fangxy@xiaopeng.com
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 johannes@sipsolutions.net, maoyixie.tju@gmail.com, zhugl3@xiaopeng.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Wed, 25 Nov 2026 14:46:35 +0000
Message-ID: <179561799575.3135.6479440863275898585@kernel.org>
In-Reply-To: <20261121141850.73754-4-fangxy@xiaopeng.com>
References: <20261121141850.73754-4-fangxy@xiaopeng.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] ipc_mux_dl_acb_decode()
  (drivers/net/wwan/iosm/iosm_ipc_mux_codec.c:548-549) adds a new early…

--

net: wwan: iosm: bound the ACBH command chain walk

This patch rewrites the ACB command chain walk in ipc_mux_dl_acb_decode().
Every command offset is now bounded by skb->len, and next_cmd_index is
validated before each command is processed. The array_index_nospec() clamp
is removed and a sanity check on acbh->block_length is added.

> diff --git a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
> index 65421f6b4c91e..a8448e273c021 100644
> --- a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
> +++ b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
> @@ -526,30 +526,60 @@ static void ipc_mux_dl_acbcmd_decode(struct iosm_mux *ipc_mux,

[ ... ]

>  	acbh = (struct mux_acbh *)(skb->data);
>  	block = (u8 *)(skb->data);
> +	block_length = le32_to_cpu(acbh->block_length);
>
> -	next_cmd_index = le32_to_cpu(acbh->first_cmd_index);
> -	next_cmd_index = array_index_nospec(next_cmd_index,
> -					    sizeof(struct mux_cmdh));
> +	/*
> +	 * The uplink encoder leaves block_length at the ACBH header size.
> +	 * It cannot delimit the command chain, so use skb->len to bound
> +	 * the command offsets.
> +	 */
> +	if (block_length < sizeof(struct mux_acbh) || block_length > skb->len)
> +		return;

[Severity: Medium]
Could this new check end up dropping every downlink ACB?

Before this patch, ipc_mux_dl_acb_decode() never read acbh->block_length.
The comment just above says the field cannot delimit the command chain.
Every later bound uses skb->len, so the check does not seem to protect any
of the reads.

The only in-tree code that writes this field is the uplink encoder, and it
leaves the field at the header size:

drivers/net/wwan/iosm/iosm_ipc_mux_codec.c:ipc_mux_acb_init() {
    ...
	header->block_length = cpu_to_le32(sizeof(struct mux_acbh));
	header->first_cmd_index = header->block_length;
    ...
}

That value passes the check. However, nothing in the driver shows what the
7360 CP firmware writes to block_length in DL ACBs. If it writes 0, or any
value outside [sizeof(struct mux_acbh), skb->len], the whole ACB is
dropped without any message.

That would include MUX_CMD_OPEN_SESSION_RESP, so the blocking wait in
ipc_mux_session_open_send() would time out:

drivers/net/wwan/iosm/iosm_ipc_mux.c:ipc_mux_session_open_send() {
    ...
	acb->wanted_response = MUX_CMD_OPEN_SESSION_RESP;
	if (ipc_mux_dl_acb_send_cmds(ipc_mux, MUX_CMD_OPEN_SESSION, if_id, 0,
				     &param, sizeof(param.open_session), true,
				 false) ||
	    acb->got_response != MUX_CMD_OPEN_SESSION_RESP) {
    ...
}

FLOW_CTL_ENABLE, FLOW_CTL_DISABLE and LINK_STATUS_REPORT commands would be
dropped too. No FLOW_CTL_ACK would go back to the CP, and
session->net_tx_stop and session->flow_ctl_mask would never be updated.

This patch is tagged for stable, and the block_length check is still
present in the final state of the series. Would it be safer to drop the
check, or at least log when it fires?

A smaller related point: the new next_cmd_index check later in the loop
drops the current command even when its own header is valid:

	if (next_cmd_index != 0 &&
	    (next_cmd_index <= cmd_index ||
	     next_cmd_index - cmd_index < hdr_len ||
	     next_cmd_index > skb->len ||
	     skb->len - next_cmd_index < hdr_len))
		break;

None of the new rejection paths in ipc_mux_dl_acb_decode() log anything.
The ADGH change in the same series does add a dev_err(). Would a
ratelimited dev_err() on these paths help make a firmware mismatch
visible?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261121141850.73754-1-fangxy%40xiaopeng.com
