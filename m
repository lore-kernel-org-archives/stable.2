Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7721948489A;
	Mon, 21 Sep 2026 12:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789995512; cv=none; b=a80wYGYnJ27XguWtWTq9rHuGlb546nM9v+y0PiZuW6reWdXmZXGnOrW93+gg0YX7cRnDPjWIudUQLY9lxvPdVzpcDXo/1Mp2MWqsJKl39IfDlmMBaVNFoF2p2X9JU8RL3RVpO9VHX47vl8ybISUtNqxH+0e9En5Q0i/3dHlG5j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789995512; c=relaxed/simple;
	bh=sUhi2Ch9NoqqgkVvsuujv9VvZNPuX5qdTpLWx68YrFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eW0Ur6N7k7QweCw2kLqjOfIxpb+2cI1/oUYaQoVzMzlTvEv4sDGbCWHBe0JwzyQx7O/Iqr5wHQM4HXAQCjWizlGSan/wVVcdZ7gWxgqqeESyOl9x+KGS2PIQdQPuIN+EpBtIGDsgOxEZTOqRDg/niEUZpOOYyUM0jKvoth5Nefc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DaQos/5m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DaQos/5m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F341F000FF;
	Mon, 21 Sep 2026 12:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789995511;
	bh=BKetCXM0e1QFwG/bJEslpS24s3ux7sl0isVvIPFjwTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DaQos/5m1m9wR9jnlklzCZP7HPlxrG0ZEy9/fcMxPN1b+xDaLu3+xvCxSzBs29zdt
	 bLyFaRVIh60RXL6isnYI226G3ZHdt4wZnI/PpSYzLWwpdZ49Gh7/z0f1O6RhcEMVE1
	 795fEZg6NoHNZ30EUqXsrhQ5NoxNPOF2i+djVbfw8+4ARJF3AUW0kp+hqQLmo2G1rg
	 v8GuQ+43Vm3xl+v4J9tzPnmZFv4gDlzjcKA2CTV/eTk8GLVwM7MDdtE+ryhcI3eRdq
	 adxngh8mBc2n8+/wRf+t+QCuVCrPxohLMnZsveL7kislapq0Po3qiws2JLgoaZ1t/R
	 9Q2NdDq+Sqo8w==
From: Simon Horman <horms@kernel.org>
To: ndaugoing@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	david@ixit.cz,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/1] nfc: nci: ignore unexpected CORE_RESET_NTF
Date: Mon, 21 Sep 2026 13:58:05 +0100
Message-ID: <20260921125805.224979-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918013337.82214-2-ndaugoing@gmail.com>
References: <20260918013337.82214-2-ndaugoing@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918013337.82214-2-ndaugoing@gmail.com?part=1
---
nfc: nci: ignore unexpected CORE_RESET_NTF

This adds an NCI_RESET_PENDING flag that is set when CORE_RESET_CMD is sent
and cleared on request completion, so that CORE_RESET_NTF is only handled
while a reset request is outstanding. Unexpected notifications are dropped
with a ratelimited warning.

A few questions about the new gate below.

> diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
> index 5f46c4b5720f6..5a90591cd9af7 100644
> --- a/net/nfc/nci/core.c
> +++ b/net/nfc/nci/core.c
> @@ -134,6 +134,7 @@ static int __nci_request(struct nci_dev *ndev,
>  	}
>  
>  	ndev->req_status = ndev->req_result = 0;
> +	clear_bit(NCI_RESET_PENDING, &ndev->flags);
>  
>  	return rc;
>  }

[Severity: Medium]
Since the flag carries no generation or sequence identity, can a
CORE_RESET_NTF belonging to an abandoned reset be matched against a later
reset attempt?

If reset attempt #1 times out here, the flag is cleared, but the
notification may already be sitting in nci_rx_work. The failure path in
nci_open_device() purges the queue but does not drain the worker:

	/* Init failed, cleanup */
	skb_queue_purge(&ndev->cmd_q);
	skb_queue_purge(&ndev->rx_q);
	skb_queue_purge(&ndev->tx_q);

	ndev->ops->close(ndev);

Only nci_close_device() flushes ndev->rx_wq, and it does that after dropping
req_lock; the exported nci_core_reset() path purges nothing.

If userspace then retries NFC_CMD_DEV_UP (or a driver calls
nci_core_reset()), nci_reset_req() sets the same bit again and the stale
frame is accepted by test_and_clear_bit() in nci_core_reset_ntf_packet(),
overwriting ndev->nci_ver / manufact_* from the old frame and completing
reset #2 with NCI_STATUS_OK before its own CORE_RESET_RSP has been seen.
The later real response can then complete the following CORE_INIT request.

> @@ -163,6 +164,8 @@ static void nci_reset_req(struct nci_dev *ndev, const void *opt)
>  {
>  	struct nci_core_reset_cmd cmd;
>  
> +	set_bit(NCI_RESET_PENDING, &ndev->flags);
> +
>  	cmd.reset_type = NCI_RESET_TYPE_RESET_CONFIG;
>  	nci_send_cmd(ndev, NCI_OP_CORE_RESET_CMD, 1, &cmd);
>  }

[Severity: Medium]
Is a single bit enough synchronisation between the two contexts here?
nci_reset_req()/__nci_request() run in process context under
ndev->req_lock, while nci_core_reset_ntf_packet() runs from nci_rx_work on
ndev->rx_wq, and the two share no lock.

The check and the use are not atomic. After test_and_clear_bit() succeeds in
nci_core_reset_ntf_packet(), the worker can be preempted before it reaches:

	ndev->nci_ver = ntf->nci_ver;
	...
	nci_req_complete(ndev, NCI_STATUS_OK);

If the reset it belonged to times out in that window, __nci_request() zeroes
req_status and returns -ETIMEDOUT, and a new request can be armed
(req_status = NCI_REQ_PEND). nci_req_complete() only looks at the global
status:

	if (ndev->req_status == NCI_REQ_PEND) {
		ndev->req_result = result;
		ndev->req_status = NCI_REQ_DONE;
		complete(&ndev->req_completion);
	}

so the resumed worker completes the new request as successful, and writes
ndev->nci_ver while nci_open_device() may be reading it:

	if (ndev->nci_ver & NCI_VER_2_MASK)
		opt = &nci_init_v2_cmd;

Would tying the notification to a request generation, or serialising the
flag test with request start/teardown, close this?

> diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
> index f5c9a8ab7ec10..b7fa8980804da 100644
> --- a/net/nfc/nci/ntf.c
> +++ b/net/nfc/nci/ntf.c
> @@ -36,6 +36,11 @@ static int nci_core_reset_ntf_packet(struct nci_dev *ndev,
>  	if (skb->len < sizeof(struct nci_core_reset_ntf))
>  		return -EINVAL;
>  
> +	if (!test_and_clear_bit(NCI_RESET_PENDING, &ndev->flags)) {
> +		pr_warn_ratelimited("unexpected CORE_RESET_NTF\n");
> +		return -EINVAL;
> +	}
> +

[Severity: High]
Does returning -EINVAL here break the fdp firmware update handshake?

In nci_ntf_packet() a non-zero return skips the driver dispatch:

	case NCI_OP_CORE_RESET_NTF:
		if (nci_core_reset_ntf_packet(ndev, skb))
			goto end;
		break;
	...
	nci_core_ntf_packet(ndev, ntf_opcode, skb);
end:
	kfree_skb(skb);

nci_core_ntf_packet() is the only dispatcher for driver core_ops handlers,
and drivers/nfc/fdp registers one for exactly this notification:

	static const struct nci_driver_ops fdp_core_ops[] = {
		...
		{
			.opcode = NCI_OP_CORE_RESET_NTF,
			.ntf = fdp_nci_core_reset_ntf_packet,
		},
	};

That hook is what wakes the patch path:

	static int fdp_nci_core_reset_ntf_packet(struct nci_dev *ndev,
						  struct sk_buff *skb)
	{
		struct fdp_nci_info *info = nci_get_drvdata(ndev);

		info->setup_reset_ntf = 1;
		wake_up(&info->setup_wq);

The notification it waits for is unsolicited, as the comment in
fdp_nci_send_patch() describes:

	 * command with NCI_PATCH_TYPE_EOT parameter. The device will send a
	 * NFCC_PATCH_NTF packet and a NCI_OP_CORE_RESET_NTF packet.

At that point the last request was nci_prop_cmd(NCI_OP_PROP_PATCH_OID),
whose completion also clears NCI_RESET_PENDING in __nci_request(), so the
flag is clear and the notification is dropped. Would
fdp_nci_patch_otp()/fdp_nci_patch_ram() then block forever in

	wait_event_interruptible(info->setup_wq, info->setup_reset_ntf);

with no timeout? That wait runs inside ndev->ops->setup(), which
nci_open_device() calls while holding ndev->req_lock, so a stalled task
would also block nci_close_device()/nci_unregister_device() and keep the
request_firmware() buffers pinned because fdp_nci_release_firmware() is
never reached.

Would it be enough to skip only the core-level bookkeeping (drop the state
update and break) instead of aborting the whole notification pipeline?

[Severity: Medium]
Should the decision use ntf->reset_trigger rather than a host-side flag?

The notification carries the discriminator itself:

	struct nci_core_reset_ntf {
		u8	reset_trigger;
		u8	config_status;
		...

but the accept/reject decision is taken before the packet is even parsed,
and reset_trigger is never read in the handler.

That cuts both ways. A genuine NFCC-initiated reset arriving outside a reset
request is discarded with only a warning, even though the controller has
returned to its initial state (RF discovery stopped, logical connections and
credits destroyed, routing table cleared), and the driver hook does not run
either.

Conversely, a spontaneous notification (reset_trigger not indicating
CORE_RESET_CMD) that happens to land inside the reset window is still
accepted, still overwrites ndev->nci_ver / manufact_id /
manufact_specific_info, and still calls:

	nci_req_complete(ndev, NCI_STATUS_OK);

Is the intended bug class actually eliminated, or only narrowed by timing?

> diff --git a/net/nfc/nci/rsp.c b/net/nfc/nci/rsp.c
> index b0ab4f5acbce8..a4bfe14372a81 100644
> --- a/net/nfc/nci/rsp.c
> +++ b/net/nfc/nci/rsp.c
> @@ -32,14 +32,19 @@ static void nci_core_reset_rsp_packet(struct nci_dev *ndev,
>  
>  	pr_debug("status 0x%x\n", rsp->status);
>  
> +	if (rsp->status != NCI_STATUS_OK) {
> +		clear_bit(NCI_RESET_PENDING, &ndev->flags);
> +		nci_req_complete(ndev, rsp->status);
> +		return;
> +	}
> +

[Severity: Medium]
Should the response handler test NCI_RESET_PENDING too, rather than only
clearing it?

nci_rsp_packet() dispatches purely by opcode with no correlation to the
outstanding command:

	switch (rsp_opcode) {
	case NCI_OP_CORE_RESET_RSP:
		nci_core_reset_rsp_packet(ndev, skb);
		break;

and nci_req_complete() only checks the global status, so a stray or delayed
CORE_RESET_RSP still completes whatever unrelated request is in flight
(CORE_INIT, RF_DISCOVER, CONN_CREATE) - the desynchronisation the commit
message sets out to remove.

This new block also widens that surface. Before the patch a 1-byte (NCI 2.x)
response completed nothing at all; now the status test runs before any length
discrimination, so a single 3-byte control frame (header plus a non-OK
status, accepted by nci_valid_size() since the declared payload is non-zero)
completes an unrelated request with a controller-chosen status.

There is also a mirror case: because the flag is cleared here without being
validated, a stray CORE_RESET_RSP during a genuine NCI 2.x reset disarms the
new guard, and the real CORE_RESET_NTF is then rejected as unexpected, so
the reset stalls until NCI_RESET_TIMEOUT.

>  	/* Handle NCI 1.x ver */
>  	if (skb->len != 1) {
> -		if (rsp->status == NCI_STATUS_OK) {
> -			ndev->nci_ver = rsp->nci_ver;
> -			pr_debug("nci_ver 0x%x, config_status 0x%x\n",
> -				 rsp->nci_ver, rsp->config_status);
> -		}
> +		ndev->nci_ver = rsp->nci_ver;
> +		pr_debug("nci_ver 0x%x, config_status 0x%x\n",
> +			 rsp->nci_ver, rsp->config_status);
>  
> +		clear_bit(NCI_RESET_PENDING, &ndev->flags);
>  		nci_req_complete(ndev, rsp->status);
>  	}
>  }

[Severity: Low]
This is a pre-existing issue and not introduced by this patch, but does
"skb->len != 1" read rsp->config_status past the received payload?

config_status is the third byte:

	struct nci_core_reset_rsp {
		__u8	status;
		__u8	nci_ver;
		__u8	config_status;
	} __packed;

and nci_valid_size() only requires the declared payload to be present and
non-zero:

	if (skb->len < hdr_size ||
	    skb->len < hdr_size + nci_plen(skb->data)) {
		return false;
	}

	if (!nci_plen(skb->data)) {

so a CORE_RESET_RSP with plen == 2 and status == NCI_STATUS_OK reaches this
block and the pr_debug() reads one byte beyond the payload. The patch keeps
the same condition (status == OK and len != 1), so this is unchanged
behaviour; would an explicit length check for the 3-byte form be worth
adding while this function is being touched?
