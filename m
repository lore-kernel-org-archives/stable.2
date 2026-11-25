Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795617999;
	b=QMR053J8kA0QkWvtIbz7YUvVSWjBJztLaOyHZ7cgN//GGqiVgFXYFgjl7Bh/2CpkPMFU
	 cdW2v+Y0ENA3Hw9zF2TMYRSfBHmctQwCTewvd/LBxNkGe2VOl1Uay8ZbcbtjkU3MAuawP
	 DMMnliSNMGwVQZnb/ZZdqvusngNX+UAhpDtyarWzbYvzrsfx5l49n8JwtO8IL23+rWMwM
	 uTB4/5hT6a/KHei3C+qnWhxPbOFHmCFq90iGDJ74k1pDiKQ4TQ3M2kaYelyMFeOtZ1iit
	 JW4p5fn4gF7hWeu0ogqZF6dSPoLYKbV1MrxH6twGRzEfTlA3crq9P3JAx2ABpRMGkbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795617999;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=b9kKcVig7H0iZ/2XHKm7Sh1wjiLoMyVkdbjeEKEr+ec=;
	b=KkB0D/TYvSOB4NTIuhCq6rCfSb7ruYzGhI/dyGZNNq7dD4Hb87d/u8t0uRQtEyDYzv5b
	 9TB9XYe+1aL7d16TrDFiovgZziSL0VRGrPTXIaAo+X7Taq/du6aAmDetjIUjkLL74Ztau
	 F9tjgvv8fqqKijw4wLlOMYlDAZBeU7ZQLf09+vCwfBPqfgUKk2AvlJJLbBvgbXtcJDIZt
	 sXRGcPY2u7Dtzq4oSpN9jDrkAHOFziqM9pjcjEySCISGB8WjcU+IioYdDqZnvgCbCsvwg
	 LoEflzM6x6OiwM113YXx7JD6xC1NXUwyvnn9GfQe7A3EKfDLPl7trzZMnsSRG/IEnIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KP76lbip;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5CD606A687;
	Wed, 25 Nov 2026 14:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KP76lbip
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF771F000C0;
	Wed, 25 Nov 2026 14:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795617998;
	bh=b9kKcVig7H0iZ/2XHKm7Sh1wjiLoMyVkdbjeEKEr+ec=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KP76lbipDeb/PW4wJXqDQQ4iuiHoNaLs55ljwYkFpKSkSohkfjU9BRfhjZHq6U9yd
	 rmQf5H/wUGz/cNZvhBBA1vK9iGLhE0MfOnITpyxtErUqEJKfuJW2TRyiI7eYp23QFH
	 ZV4NVH55IhALmIN9fG9onSaiRbF4TWxpPz+BMXnD+ZG6wQSqD5THOwjFsmPfXfR3bE
	 prt0XqqkyZr+Yr1CyqJl35Rb8V+yEvE947KOOCHaQCsI7bk1LgmzrNhIiKvBCzsGZN
	 jpKE94alGxGgVBSmZ3RAhsNAuOcr0rGDJUcXtND0yJC3HkE89UD17XaJzA1iojqPz2
	 BJ7qCYLy2KN+A==
Subject:
 Re: [PATCH net v4 5/5] net: wwan: iosm: validate the command parameter length
From: netdev-bot+sashiko@kernel.org
To: fangxy@xiaopeng.com
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 johannes@sipsolutions.net, maoyixie.tju@gmail.com, zhugl3@xiaopeng.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Wed, 25 Nov 2026 14:46:37 +0000
Message-ID: <179561799736.3135.13611936052638387312@kernel.org>
In-Reply-To: <20261121141850.73754-6-fangxy@xiaopeng.com>
References: <20261121141850.73754-6-fangxy@xiaopeng.com>
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

- [Medium] The new parameter-length check never uses the device-supplied
  cmdh->cmd_len, which is what delimits a command in this wire format.

--

net: wwan: iosm: validate the command parameter length

This patch passes a parameter length to the iosm MUX command decoders.
Each decoder checks it against the parameter union member its command
type uses and returns -EMSGSIZE when the member does not fit. The length
comes from skb->len for MUX Lite, and from next_cmd_index or skb->len for
commands in an aggregated command block.

> diff --git a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
> index 3f93d72937858..b2bd53c5ba30f 100644
> --- a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
> +++ b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c

[ ... ]

> @@ -315,18 +329,26 @@ static int ipc_mux_dl_cmds_decode_process(struct iosm_mux *ipc_mux,
>  static void ipc_mux_dl_cmd_decode(struct iosm_mux *ipc_mux, struct sk_buff *skb)
>  {
>  	struct mux_lite_cmdh *cmdh = (struct mux_lite_cmdh *)skb->data;
> +	size_t hdr_len = offsetof(struct mux_lite_cmdh, param);
> +	size_t param_len = skb->len > hdr_len ? skb->len - hdr_len : 0;

[Severity: Medium]
Should param_len also be limited by cmdh->cmd_len here?

The kernel-doc for struct mux_lite_cmdh defines cmd_len as the length of
the command:

 * @cmd_len:		Length (in bytes) of the command. This length shall
 *			include the header size. Minimum value: 0x10

The encoders, ipc_mux_lite_add_cmd() and ipc_mux_acb_add_cmd(), also set
it to the header plus the parameter size, and skb_put() exactly that
much:

	cmdh->cmd_len = cpu_to_le16(offsetof(struct mux_lite_cmdh, param) +
				    param_size);
	...
	skb_put(acb->skb, le16_to_cpu(cmdh->cmd_len));

Take an OPEN_SESSION_RESP that arrives with cmd_len = hdr_len + 4, so it
carries only the response code, with more bytes after it in the received
buffer. Would it still pass the new check in
ipc_mux_dl_cmdresps_decode_process()?

	if (param_len < sizeof(param->open_session_resp))
		return -EMSGSIZE;

	/* Resume the control application. */
	acb->got_param.open_session_resp = param->open_session_resp;

The reads now stay within skb->len. But the bytes after the command would
still be copied into acb->got_param. Then complete(&ipc_mux->channel->ul_sem)
would wake ipc_mux_session_open(), which uses those bytes as the response
and as ul_head_pad_len. A short FLOW_CTL would also have its mask read
from bytes beyond cmd_len.

ipc_mux_dl_acb_decode() seems to have the same gap. Each aggregated
command's extent comes from next_cmd_index or skb->len, not from its own
cmd_len:

	cmd_end = next_cmd_index ? next_cmd_index : skb->len;
	param_len = cmd_end - cmd_index - hdr_len;

So padding before the next command counts as parameter. For the last
command, the rest of the skb does too.

The commit message names this case as the bug being fixed:

  "a truncated OPEN_SESSION_RESP copies bytes past the command into
   acb->got_param"

It also says:

  "cmd_len is passed to the decoder unchanged."

Would bounding the length by something like min(param_len, cmd_len -
hdr_len), when cmd_len >= hdr_len, be needed to cover the truncated
command case completely?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261121141850.73754-1-fangxy%40xiaopeng.com
