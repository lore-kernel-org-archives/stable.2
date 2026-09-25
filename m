Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475A442E435;
	Fri, 25 Sep 2026 11:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790334498; cv=none; b=srvZD+z/P0l4jS7hjW5y676wajW0hCgtiLa7/0pPaE+P+6ITvHDzf6C4bgb5urMzGx/id1eraKQnzBrpBo80/mNlK3jY2yuGAz4TVggIEwQojsa44bQqrx/GWEdB1rIyLSq7StnbUyVib1OkjgUCT77UuimIT/11rWIfsfTe5uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790334498; c=relaxed/simple;
	bh=zynoYMlMYbFj0swo4NPJyyb0szArdEdnmqbN18uz53c=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WhgKQHmlLB/1tnm5yk332xd03p9X5g6fUUL37dVetwEPf9GefGrGoFc07hqMW0ZbN9LVr+Dk1c15cIqDMHAFRKuuM4zGR9BBVSvxA+Nw8k8OFtsvsXnXWx3yS7K0Sm1fY52Gj7pcBA8sKGrW+JNat6zP3FGeJ+x8Hd0l/BG2ayo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0jCR2Eo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0jCR2Eo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25EC61F000FF;
	Fri, 25 Sep 2026 11:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790334496;
	bh=cD/4uhCoOFRj306klw+DrQVG0J2FFkNdJW/iXoErdyw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=J0jCR2EoFYOBhzAbE1fH1M1oR6qqBXewk4J6u1BsCTkUOmH8EOChKAB+gEcRu1wy1
	 rwecTRNgX6OK7lIlC9wewqw88Vwhz5LtY9jXgyTVpsDmDe5qdl73jzYyDfj8q9SdDm
	 g3zXbdKXkrb5AZ/hCLvOPzn2sbNu3tB62La5ljV5KclkwADucCCLu7GWP41btvi+rU
	 kaiiQVnl7otnYtZecQlus1qzdwvdtRE5P17h85TEdww5kb5UqD+1TVbeVBvzmBIAcV
	 nagCJAHh3Xi9aLI2Tx9snf9Ag+3OYNl/hKVZMAIvLmHPiIq3MIUI7P694VOFi2rC4u
	 RDNfsLCejd7+g==
Subject:
 Re: [PATCH v2] nfc: nci: ignore unexpected CORE_RESET_NTF and CORE_RESET_RSP
From: netdev-bot+sashiko@kernel.org
To: ndaugoing@gmail.com
Cc: horms@kernel.org, david@ixit.cz, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, oe-linux-nfc@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Fri, 25 Sep 2026 11:08:15 +0000
Message-ID: <179033449559.2160803.13021740404311036994@kernel.org>
In-Reply-To: <20260922080750.35929-1-ndaugoing@gmail.com>
References: <20260922080750.35929-1-ndaugoing@gmail.com>
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
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] nci_core_reset_ntf_packet() still rejects any CORE_RESET_NTF
  shorter than sizeof(struct nci_core_reset_ntf) (9 bytes) with -EINVAL…
- [Medium] Contradictory trigger semantics introduced by the same patch,
  plus dead constants.
- [Medium] The new NCI_RESET_PENDING gate is a single boolean token, and
  in nci_core_reset_rsp_packet() it is consumed non-atomically (plain…

--

nfc: nci: ignore unexpected CORE_RESET_NTF and CORE_RESET_RSP

This adds a new NCI_RESET_PENDING flag that is set when CORE_RESET_CMD is
sent and checked in the CORE_RESET_RSP and CORE_RESET_NTF handlers, so
that unsolicited or delayed reset packets no longer complete an unrelated
in-flight request or overwrite ndev->nci_ver and the manufacturer info.
A few questions on the new gating logic below.

> diff --git a/include/net/nfc/nci.h b/include/net/nfc/nci.h
> index 09efcaed7c3f6..2ac45adba0886 100644
> --- a/include/net/nfc/nci.h
> +++ b/include/net/nfc/nci.h
> @@ -140,6 +140,11 @@
>  #define NCI_RESET_TYPE_KEEP_CONFIG				0x00
>  #define NCI_RESET_TYPE_RESET_CONFIG				0x01
>  
> +/* NCI Reset Triggers */
> +#define NCI_RESET_TRIGGER_ERROR					0x00
> +#define NCI_RESET_TRIGGER_POWER_ON				0x01
> +#define NCI_RESET_TRIGGER_RESET_CMD				0x02
> +

[Severity: Medium]
Are these two descriptions of trigger 0x00 consistent?  Here 0x00 is named
NCI_RESET_TRIGGER_ERROR, while the comment added to
nci_core_reset_ntf_packet() in the same patch says 0x00 is the
CORE_RESET_CMD trigger for NCI 1.0:

	 * revision-dependent (0x00 in NCI 1.0, 0x02 in NCI 2.0), so both

Only one of those can hold.

Also, NCI_RESET_TRIGGER_ERROR and NCI_RESET_TRIGGER_RESET_CMD are not
referenced anywhere; only NCI_RESET_TRIGGER_POWER_ON has a single use in
nci_core_reset_ntf_packet().  Would it be clearer to either use the
constants in the trigger check or drop the unused ones?

>  /* NCI Static RF connection ID */
>  #define NCI_STATIC_RF_CONN_ID					0x00
>  

[ ... ]

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
> @@ -163,6 +164,8 @@ static void nci_reset_req(struct nci_dev *ndev, const void *opt)
>  {
>  	struct nci_core_reset_cmd cmd;
>  
> +	set_bit(NCI_RESET_PENDING, &ndev->flags);
> +
>  	cmd.reset_type = NCI_RESET_TYPE_RESET_CONFIG;
>  	nci_send_cmd(ndev, NCI_OP_CORE_RESET_CMD, 1, &cmd);
>  }
> diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
> index f5c9a8ab7ec10..57f99bf46a221 100644
> --- a/net/nfc/nci/ntf.c
> +++ b/net/nfc/nci/ntf.c
> @@ -36,7 +36,22 @@ static int nci_core_reset_ntf_packet(struct nci_dev *ndev,
>  	if (skb->len < sizeof(struct nci_core_reset_ntf))
>  		return -EINVAL;
       ^^^^^^^^^^^^^^^^^^^^

[Severity: High]
This isn't a length check introduced by this patch (it came in with
9c328f54741bd5), but does it undermine the commit message's stated
premise?

The changelog says:

    If unexpected, log a warning and return 0 so driver-specific handlers
    (such as fdp firmware patch handling) still receive the notification.

struct nci_core_reset_ntf is 9 bytes, so any shorter notification returns
-EINVAL here, and nci_ntf_packet() then takes:

	case NCI_OP_CORE_RESET_NTF:
		if (nci_core_reset_ntf_packet(ndev, skb))
			goto end;

which skips nci_core_ntf_packet() entirely, the only dispatcher for the
per-driver .ntf callbacks.  Shorter notifications look common: an NCI 1.x
CORE_RESET_NTF carries 2 payload octets, and drivers/nfc/nfcmrvl/fw_dnld.c
documents such a frame:

drivers/nfc/nfcmrvl/fw_dnld.c:
static const u8 nci_pattern_core_reset_ntf[] = {
	0x60, 0x00, 0x02, 0xA0, 0x01
};

A conformant NCI 2.0 notification with manufacturer_specific_len == 0 is
5 octets and is rejected as well.

For fdp, the skipped hook is the only thing that wakes the firmware setup
path:

drivers/nfc/fdp/fdp.c:fdp_nci_core_reset_ntf_packet() {
	info->setup_reset_ntf = 1;
	wake_up(&info->setup_wq);
}

and fdp_nci_patch_ram()/fdp_nci_patch_otp() block with no timeout:

drivers/nfc/fdp/fdp.c:fdp_nci_patch_ram() {
	...
	wait_event_interruptible(info->setup_wq, info->setup_reset_ntf);
}

So if such a controller emits a short CORE_RESET_NTF after applying the
patch, does the setup path sleep indefinitely (only a signal breaks it)?
Would capping the field reads at the received length be preferable to
rejecting short notifications outright?

> -	ntf = (struct nci_core_reset_ntf *)skb->data;
> +	ntf = (const struct nci_core_reset_ntf *)skb->data;
> +
> +	/*
> +	 * A power-on notification must not update core protocol state nor
> +	 * complete a pending request.  The CORE_RESET_CMD trigger value is
> +	 * revision-dependent (0x00 in NCI 1.0, 0x02 in NCI 2.0), so both
> +	 * are let through to the reset-pending gate below instead.
> +	 * Return 0 so driver-specific notification hooks can still run.
> +	 */
> +	if (ntf->reset_trigger == NCI_RESET_TRIGGER_POWER_ON)
> +		return 0;
> +
> +	if (!test_and_clear_bit(NCI_RESET_PENDING, &ndev->flags)) {
> +		pr_warn_ratelimited("unexpected CORE_RESET_NTF\n");
> +		return 0;
> +	}

[Severity: Medium]
Only trigger 0x01 is filtered here.  Every other value reaches the pending
gate, including 0x00 (which the new header names
NCI_RESET_TRIGGER_ERROR), the RFU range 0x03-0x9F and the proprietary
range 0xA0-0xFF, and real hardware does use the proprietary range
(drivers/nfc/nfcmrvl/fw_dnld.c uses trigger 0xA0).

When a reset is pending, is it intended that an error or proprietary
trigger notification stamps ndev->nci_ver, ndev->manufact_id and
ndev->manufact_specific_info and completes the request with
NCI_STATUS_OK?  The notification content comes from the controller, and
/dev/virtual_nci (virtual_ncidev_write() -> nci_recv_frame()) lets
userspace supply any trigger value.

>  
>  	ndev->nci_ver = ntf->nci_ver;
>  	pr_debug("nci_ver 0x%x, config_status 0x%x\n",
> diff --git a/net/nfc/nci/rsp.c b/net/nfc/nci/rsp.c
> index b0ab4f5acbce8..3a2491497e4b3 100644
> --- a/net/nfc/nci/rsp.c
> +++ b/net/nfc/nci/rsp.c
> @@ -32,14 +32,26 @@ static void nci_core_reset_rsp_packet(struct nci_dev *ndev,
>  
>  	pr_debug("status 0x%x\n", rsp->status);
>  
> +	/*
> +	 * If no reset request is pending, ignore unexpected responses to avoid
> +	 * prematurely completing an unrelated request.
> +	 */
> +	if (!test_bit(NCI_RESET_PENDING, &ndev->flags))
> +		return;
> +

[Severity: Medium]
Should this be test_and_clear_bit() for consistency with the notification
handler?  As written the flag is tested here and only cleared further down,
so the window in between is open to the request thread:

nci_rx_work() -> nci_rsp_packet() -> nci_core_reset_rsp_packet()
	test_bit(NCI_RESET_PENDING) -> true   /* stale response */

request thread, timing out in __nci_request():
	ndev->req_status = ndev->req_result = 0;
	clear_bit(NCI_RESET_PENDING, &ndev->flags);

next reset, nci_reset_req():
	set_bit(NCI_RESET_PENDING, &ndev->flags);

back in nci_core_reset_rsp_packet():
	clear_bit(NCI_RESET_PENDING, &ndev->flags);
	nci_req_complete(ndev, rsp->status);

Can the stale response then complete the new request?

More generally, a single boolean carries no information about which reset
a packet belongs to.  A delayed or duplicated CORE_RESET_RSP/CORE_RESET_NTF
from an earlier reset passes the gate of a later one, for example the
nci_core_reset() issued from fdp_nci_post_setup() after the reset done in
nci_open_device().  That completes the later request with stale status and
nci_ver while the NFCC is still resetting, and the genuine response is
then dropped as unexpected.

Would a per-request generation or sequence number be a better match for
what the gate needs to express?

>  	/* Handle NCI 1.x ver */
> -	if (skb->len != 1) {
> -		if (rsp->status == NCI_STATUS_OK) {
> -			ndev->nci_ver = rsp->nci_ver;
> -			pr_debug("nci_ver 0x%x, config_status 0x%x\n",
> -				 rsp->nci_ver, rsp->config_status);
> -		}
> +	if (skb->len >= sizeof(*rsp)) {
> +		ndev->nci_ver = rsp->nci_ver;
> +		pr_debug("nci_ver 0x%x, config_status 0x%x\n",
> +			 rsp->nci_ver, rsp->config_status);
>  
> +		clear_bit(NCI_RESET_PENDING, &ndev->flags);
>  		nci_req_complete(ndev, rsp->status);
>  	}
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922080750.35929-1-ndaugoing%40gmail.com
