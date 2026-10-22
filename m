Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792642487;
	b=Ar0H1TEONkBT+zkE9tR+zvWbOxAkCd2DIWEPhqQx8i3Wf4doVBdfQxbi+e7zPUtTuYvo
	 X+FJs0hSZH3LmxM4o1YAjwRzcORDPjynkdxha3cVzgXH9GnskEyHhF+njFOvi2p+sA4+j
	 DzfVyMP41KZtfZq3gSdixR0P47hqRthXqCBPd3LqYaUaooiPbfy4tiLD5Z3X2DaNLE3yr
	 Z4LpSVgrS4s+g7W6Sfb84O1Lb6jUPYmCyki0w34rb97x/TNehl7rDYyt8MllpDvobVks1
	 BLBkjjLw2X3QhwszVeLBUtbb1+RmaYtqg0pTI7Ic/bOkk+3NMAK0lghPu6jbpAcpcHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792642487;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=YZjboky+GQgVL4lwRvMRR6hTyGlQu2N7RmoF2P95Nzo=;
	b=OZX8s7KXrtr71YlUCtuyf7K+k1II//iPIiMdaMrCRy0WLellI5HCErwcEEk1clm12VzO
	 zDi2+i6l5NZIbztRzD18hz9S13rApG/1ZWEe62iZmPlSH+tWVgHQxkAedB73XCnBWt77x
	 fT9PYEcJOqiiEHwL1VXa43BJhnTLJv91/kt3yuTUdzi+0nVAffrmG57xjyf8o0eUN07+H
	 h/Q+V+Ec64z4sDnPbkU6KimhrhP95hZ3cw9sJTt7lu2Dlj03pahMbsGntiQHwoOSTKNBZ
	 Rt8DGv2N30PostP0zwcMIpasxTbEWAYPgFTB10403KWDTEsti9/rJHIvafPSdzfsSYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QBYYMTYC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1876606A31A;
	Thu, 22 Oct 2026 04:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QBYYMTYC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10321F000C1;
	Thu, 22 Oct 2026 04:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792642486;
	bh=YZjboky+GQgVL4lwRvMRR6hTyGlQu2N7RmoF2P95Nzo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QBYYMTYCsaVayqoZySFOSC66YM7q5fQQhzoKd09JRMAS7ZL6bVSC2L+cErtbXttoy
	 Aa8pYLqu+9Nls7X1xW2gTcbJUHkRZEtge5fxvJPQSdlIjV80BOuPMdxRrOo/WlOru7
	 Cx/uUM0Cz+1+dSFiT17u1q3pgGvR9kpaJ5vpdrpGiGODlbUziF60ewOkhPrSZA3a9m
	 x478Yv93+pEkrzXB6xtX27HpHiytucEW7ilGMI+QK6G1XfG9iNsl+61aQv0GUyDpAd
	 404I7I6o4yChajpPIFq5BXVD+mocwLcXIrE6jlnVOrmDwaQ2cIHNwktsF0cOcRQDGa
	 iRs4aW7QxyzKg==
Subject: Re: [PATCH] net: wwan: iosm: fix NULL skb deref in ul_td_process
From: netdev-bot+sashiko@kernel.org
To: liuc63@xiaopeng.com
Cc: m.chetan.kumar@intel.com, loic.poulain@oss.qualcomm.com,
 ryazanov.s.a@gmail.com, johannes@sipsolutions.net, zhugl3@xiaopeng.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 kuba@kernel.org
Date: Thu, 22 Oct 2026 04:14:45 +0000
Message-ID: <179264248532.3135.6948322337342491907@kernel.org>
In-Reply-To: <20261020101150.16967-1-liuc63@xiaopeng.com>
References: <20261020101150.16967-1-liuc63@xiaopeng.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix does not handle the 'already consumed' case that its
  commit message says it covers.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but UL completion
  processing in the IRQ tasklet is not synchronized with pipe teardown.

--

net: wwan: iosm: fix NULL skb deref in ul_td_process

This commit adds a NULL check on the skb taken from the UL ring slot in
ipc_protocol_ul_td_process() before IPC_CB(skb) is dereferenced. The
goal is to avoid a NULL pointer dereference when the slot was never
populated or has already been consumed.

> diff --git a/drivers/net/wwan/iosm/iosm_ipc_protocol_ops.c b/drivers/net/wwan/iosm/iosm_ipc_protocol_ops.c
> index f2f86f41fd10..dee2e6607f77 100644
> --- a/drivers/net/wwan/iosm/iosm_ipc_protocol_ops.c
> +++ b/drivers/net/wwan/iosm/iosm_ipc_protocol_ops.c
> @@ -302,6 +302,11 @@ struct sk_buff *ipc_protocol_ul_td_process(struct iosm_protocol *ipc_protocol,
>  	if (pipe->old_tail >= pipe->nr_of_entries)
>  		pipe->old_tail = 0;
>  
> +	if (!skb) {
> +		dev_err(ipc_protocol->dev, "skb is null");
> +		return NULL;
> +	}
> +

[Severity: High]
Does this check catch the "already consumed" case that the commit message
mentions?

The UL path never resets the ring slot after taking the skb:

drivers/net/wwan/iosm/iosm_ipc_protocol_ops.c:ipc_protocol_ul_td_process() {
	struct ipc_protocol_td *p_td = &pipe->tdr_start[pipe->old_tail];
	struct sk_buff *skb = pipe->skbr_start[pipe->old_tail];

	pipe->nr_of_queued_entries--;
	pipe->old_tail++;
    ...
}

The DL sibling does reset it, so a NULL there really does mean "already
consumed":

drivers/net/wwan/iosm/iosm_ipc_protocol_ops.c:ipc_protocol_dl_td_process() {
    ...
	/* Reset the ring elements. */
	pipe->skbr_start[pipe->old_tail] = NULL;
    ...
}

The only place that writes a UL slot is ipc_protocol_ul_td_send(). It
also sets td->buffer.address = IPC_CB(skb)->mapping, and nothing clears
that field on completion. The caller, ipc_imem_ul_pipe_process(), then
frees each returned skb with ipc_pcie_kfree_skb() or passes it to
ipc_mux_ul_encoded_process().

So a consumed UL slot keeps a stale, non-NULL skb pointer and a non-zero
TD address. If the slot is processed again, the new !skb check passes.
IPC_CB(skb)->mapping is then read from freed memory. If the stale mapping
still matches the stale TD address, the freed skb is returned and freed a
second time.

Slots can be processed again because the loop count in
ipc_imem_ul_pipe_process() comes straight from the device-written tail:

	if (pipe->old_tail != tail) {
		if (pipe->old_tail < tail)
			cnt = tail - pipe->old_tail;
		else
			cnt = pipe->nr_of_entries - pipe->old_tail + tail;
	}

cnt is never checked against nr_of_queued_entries. A misbehaving
endpoint, which is the case this patch is meant to guard against, can
reach this path.

Would it be better to clear pipe->skbr_start[pipe->old_tail] after
reading it, the way the DL path does, and/or to cap cnt by
pipe->nr_of_queued_entries?

[Severity: High]
This is a pre-existing issue and was not introduced by this patch, but
the new check does not protect against it. Is UL completion processing in
the IRQ tasklet synchronized with pipe teardown?

ipc_imem_handle_irq() checks is_open without holding a lock:

	if (ul_pipe->is_open)
		ipc_imem_ul_pipe_process(ipc_imem, ul_pipe);

It then goes on into ipc_protocol_ul_td_process(), which reads
pipe->tdr_start[] and pipe->skbr_start[].

ipc_imem_sys_devlink_close() runs in process context. It waits on
ul_pend_sem with a timeout but never sets app_notify_ul_pend, so the wait
just times out. It then frees the pipes directly:

	ipc_imem_pipe_cleanup(ipc_imem, &channel->ul_pipe);
	ipc_imem_pipe_cleanup(ipc_imem, &channel->dl_pipe);

ipc_protocol_pipe_cleanup() frees the in-flight skbs, kfree()s
skbr_start and dma_free_coherent()s tdr_start. No lock or tasklet
quiescing waits for a tasklet that has already passed the is_open check.

ipc_imem_cleanup() has the same ordering:

	ipc_imem_channel_reset(ipc_imem);

	ipc_protocol_deinit(ipc_imem->ipc_protocol);
	ipc_task_deinit(ipc_imem->ipc_task);

Here the channels are freed before tasklet_kill() in ipc_task_deinit(),
and the IRQ is still live until ipc_pcie_cleanup() runs afterwards.

Can a running tasklet then dereference freed or NULL tdr_start and
skbr_start, or free the same skb that the cleanup loop frees? The local
skb pointer it holds would be non-NULL, so the new !skb check would not
catch it.

>  	if (!p_td->buffer.address) {
>  		dev_err(ipc_protocol->dev, "Td buffer address is NULL");
>  		return NULL;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020101150.16967-1-liuc63%40xiaopeng.com
