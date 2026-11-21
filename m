Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795284332;
	b=SryxcBmskxs7TyQN0Oxvr7aR3LDaQRFkX6Alt5aBIEDqVDBcDI4Wd7/SBxjFe5JTQ/Nz
	 PcpM4tBrCVYSqXSZdAY3BvmvuPbaYqIZUBRiBwk4kQglmmEt2CsoZsf3NO5q80y2KuKhh
	 0sozw61NdkA34mb4HWF6Puz80Q4S1iYR4oFb2zUDxBY4ZDtXYhJfHJyeR/aY10fJNt+dZ
	 gRZbdw2XQXJyeQVyB75QAjT9w8VIdmTEc85Fkpv1gzptck/rfqhAxLItviqypAbXtjJC5
	 63zuHZobzBFcRIkZp15DbtBJ6NqR//PdZ1ZgCueNURaQKPI9B0n156pCS6pQAW+SWlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795284332;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=pYt6gsq2OH3wlZNEVbjnaadPXz5Sn2AC2yTJX2nCaPA=;
	b=O3bS75wt+QMIeucFqBn+FVAuJ8p0vaQ9F4GU05NfMHODohZVjvCkfp306BnSo/Q4RAPD
	 4c3GcIjNpZ2V/nYfjH7rHIvqpCMpFlnDH6WUOFZAs8hwQNgGENduXbj4GeM7FA3Npl+BV
	 1m90JWi5PD8m7uDQApcaahN9GtNXxz8c/To40c069v1YDzY23hSqqG31iNcNHpHGrBpwp
	 gP/R5A7okRE5Nnm1L3LNAt0bEMywfeCb//CTnnJYKaRtzsRCeYRPWsSylEoywORxi9ee7
	 9HRQxdZDrLlQd2U1eH3RQLUeIHe0Pwj+pQa1glm59/pnC5PCLG5xVzt70PwuXDNbUqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GyhEwY5X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9A8606A32C;
	Sat, 21 Nov 2026 18:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GyhEwY5X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 413AF1F000C0;
	Sat, 21 Nov 2026 18:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795284332;
	bh=pYt6gsq2OH3wlZNEVbjnaadPXz5Sn2AC2yTJX2nCaPA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GyhEwY5XLGQoSMrD1HQGMj9zW4Rdym9pWExcDFB/ayobWxHFH7sIKfk3+rfnKXVB8
	 qYkSZ9eUBQbrtLtsM572AqKBwluP5rCBPSDHbAu48EZEmG51G9ROBO5Zcr9y9+FYxn
	 vQ1UOMKnDDEv+fUJEeC3URphLewaCrG2b4iZb7xbCEi/xNZJe/4WUjtuRKu6iiHZCm
	 2eDRg4CGWHOAY286LDDKC2SlsEQXZk5Tyt1k/SxSA5Zis6/iSvxTCvgOikdAmzm6mm
	 Zo2I0mkJyX0p+FqaFoFX8agcGTOuU4dJEyQGiOVGd24+s4XOYlKqHnUFkhJVoxfhix
	 S9mFo8P6WiQNg==
Subject:
 Re: [PATCH net v2 3/5] net: wwan: iosm: bound the ACBH command chain walk
From: netdev-bot+sashiko@kernel.org
To: fangxy@xiaopeng.com
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 johannes@sipsolutions.net, maoyixie.tju@gmail.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, zhugl3@xiaopeng.com
Date: Sat, 21 Nov 2026 18:05:30 +0000
Message-ID: <179528433079.3135.7229744100791190249@kernel.org>
In-Reply-To: <20261117173940.34970-4-fangxy@xiaopeng.com>
References: <20261117173940.34970-4-fangxy@xiaopeng.com>
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

- [Medium] This patch adds a new early return to ipc_mux_dl_acb_decode()
  in drivers/net/wwan/iosm/iosm_ipc_mux_codec.c: `if (block_length <…

--

net: wwan: iosm: bound the ACBH command chain walk

This patch reworks ipc_mux_dl_acb_decode() so that every command offset
in a received Aggregated Command Block is bounded by skb->len. It also
validates next_cmd_index so the walk always moves forward. It removes
the array_index_nospec() call and adds a sanity check on
acbh->block_length.

> diff --git a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
> index 65421f6b4c91e..a8448e273c021 100644
> --- a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
> +++ b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
> @@ -526,30 +526,60 @@ static void ipc_mux_dl_acbcmd_decode(struct iosm_mux *ipc_mux,
>  /* Decode an aggregated command block. */
>  static void ipc_mux_dl_acb_decode(struct iosm_mux *ipc_mux, struct sk_buff *skb)
>  {

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
Could this new check drop every downlink ACB without any message on
some modem firmware?

Before this patch, the DL ACB decoder never read acbh->block_length.
Firmware has never had to keep it between sizeof(struct mux_acbh) and
skb->len. If the check fails, the function returns without logging
anything and the whole block is thrown away.

The comment above says block_length cannot delimit the command chain.
The loop below already bounds every command offset by skb->len. So the
check doesn't seem to add memory safety. Its only effect is that
commands can be dropped.

The only evidence of what this field holds comes from the host's uplink
encoder:

drivers/net/wwan/iosm/iosm_ipc_mux_codec.c:ipc_mux_acb_init() {
    ...
	header->block_length = cpu_to_le32(sizeof(struct mux_acbh));
	header->first_cmd_index = header->block_length;
    ...
}

ipc_mux_acb_add_cmd() never updates it. That doesn't match the
kernel-doc for struct mux_acbh in iosm_ipc_mux_codec.h:

 * @block_length:       Length (in bytes) of the Aggregated Command Block.

It also suggests the modem doesn't rely on this field in UL ACBs.
Nothing in the tree shows what the modem writes in DL ACBs.

If a firmware writes 0 here, or a value larger than the transfer,
wouldn't every DL ACB be dropped? Some of the effects:

  MUX_CMD_OPEN_SESSION_RESP is never processed. ipc_mux_session_open()
  then times out waiting for acb->got_response and fails.

  IOSM_AGGR_MUX_CMD_FLOW_CTL_ENABLE/DISABLE are never applied.
  session->net_tx_stop and session->flow_ctl_mask are not updated, and
  no FLOW_CTL_ACK is sent.

  LINK_STATUS_REPORT is never answered.

The ADB path isn't really a precedent. mux_dl_process_dg() checks each
datagram index against adbh->block_length as well as skb->len. ACBH
block_length, by contrast, was never read on the DL path before this
patch.

The check is still there after the later patch in this series, "net:
wwan: iosm: validate the command parameter length".

Is the block_length check needed here, since skb->len already bounds
the command chain walk?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261117173940.34970-1-fangxy%40xiaopeng.com
