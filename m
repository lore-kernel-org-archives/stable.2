Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795875219;
	b=18vHYGndcrLb3jdhWlFkV2hZAbB/FOLL3HrlwqYPSFtCjqtBCadDL/6gZJqAiUzEFVvb
	 Hj7rOEDIKENjl/xEWyMY47jdP3xBIy4GqmWzNu6M+7BN68xTAOixVq4sjueVnW60qoG+0
	 mxiLcZsvYaTbwofK4bEBv892XVMNdCIqqtSFYXYk3bzxhpHsLxC3bu0E5kjskImNjx7F8
	 aFqvdlnGDnGav0kqc4Hi6N6MQKvngvPSDxAanGQ8Y+oOW5IKjxOsDqArjhqTQnoQl3em0
	 l+SOxqnUz/tqtktK9MC+zGvKMUwHJET3DsNCQtec1c/V0jur7xQbNCutcYFgwwd54IA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795875219;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=4yN/GfDemWaVUfkwJzvu8EdIMFv74s+rOsCzvToeLYA=;
	b=mLKDcvl+5FRUzyh1ncdJwl68XRDMIOGtzsBzg326W0ZiFT1iWwWi6yCiz8jQevLTukN6
	 OF9iE7j8g4blW1w3kKRi1FXSQimDkxqgdkUbuI6SqdgdSPhfkG/6qqQgGu89r/y5Oe3mu
	 nuRWEWSOGR7kspk3hMjbxVwbXc11baIcuUmzDppc5BZkzWw4NnUccIt9K2ALSKgTqKFCl
	 ZtTK1mhEzSj4I5CXel436Oqp2YoeFE3rEGtqu+4nETqTvK0P4+ZpDLvmW/DDbE1ndVSDF
	 nWg8OeOMAZ6Kvhn8CrTFqo1Pjq4sGWJS1yQnA54PrfdnLRms4Ftl6hDzBu/A8aEXZcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="CZ/U4g68";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E89606A31C;
	Sat, 28 Nov 2026 14:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CZ/U4g68
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D241F000C1;
	Sat, 28 Nov 2026 14:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795875219;
	bh=4yN/GfDemWaVUfkwJzvu8EdIMFv74s+rOsCzvToeLYA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CZ/U4g68Ho+12lkYFTfe+UFxTLDMoJyRaXWPhPfJJbZQlnc4gaKZVQ7OvGfsbjlOm
	 wa8KzRmIk22nGrM2gthaGT6Qc+uVEDHyViB3yRg74b8mguBk5i8s/XIVmCKsXfB/HV
	 uhaPNPg+XqAACfDnlGHOB8eTZZKUpwqsNK5g6mHx9yQLEHb1ol+039gdBlvV6OEdPx
	 v1hXSP+LpNuH+UIpAFc8ZAc3eK3tlCu7C4zvyODASacxkzuaBGyZObq8xX88Leie6N
	 IIm58aCXbv7cnO9sGcs2Lz1gJK0ymaND65AOna5sceuoQo+xHS/yzMD0/4TF1FlXpH
	 R1ojWjYlYUUVw==
Subject: Re: [PATCH v5 1/5] net/nfc: fix skb ownership on data exchange errors
From: netdev-bot+sashiko@kernel.org
To: luob87709@gmail.com
Cc: oe-linux-nfc@lists.linux.dev, johan@kernel.org, david@ixit.cz,
 kuba@kernel.org, netdev@vger.kernel.org, stable@vger.kernel.org
Date: Sat, 28 Nov 2026 14:13:38 +0000
Message-ID: <179587521832.3135.10557167189631525290@kernel.org>
In-Reply-To: <20261127134029.1813-2-luob87709@gmail.com>
References: <20261127134029.1813-2-luob87709@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch adds `skb_queue_purge(&hdev->rx_hcp_frags)` to
  `nfc_hci_failure()` in net/nfc/hci/core.c.
- [Low] net/nfc: Fixes trailers cite file-rename commits instead of bug
  introductions

--

net/nfc: fix skb ownership on data exchange errors

This commit documents that a data_exchange_cb_t callback owns any
non-NULL skb it receives, whatever the err value. It updates the rawsock,
LLCP, HCI, NCI-HCI, loopback, microread, pn544 and st21nfca callbacks to
free or consume the skb on error paths. It also makes HCI/NCI-HCI fragment
reassembly splice rx_hcp_frags onto a local list under the queue lock, and
purges partial fragments on error.

> diff --git a/net/nfc/hci/core.c b/net/nfc/hci/core.c
> index ba6f0310ffd7c..1b43f1e854071 100644
> --- a/net/nfc/hci/core.c
> +++ b/net/nfc/hci/core.c

[ ... ]

> @@ -833,6 +832,7 @@ static int hci_se_io(struct nfc_dev *nfc_dev, u32 se_idx,
>  
>  static void nfc_hci_failure(struct nfc_hci_dev *hdev, int err)
>  {
> +	skb_queue_purge(&hdev->rx_hcp_frags);
>  	mutex_lock(&hdev->msg_tx_mutex);

[Severity: Medium]
Can this purge drop the first fragments of a message that is still being
reassembled, and cause the last fragment to be misparsed?

nfc_hci_failure() is not only reached from the reassembly path. It is also
reached from msg_rx_work through nfc_hci_event_received():

net/nfc/hci/core.c:nfc_hci_event_received() {
    ...
	default:
		pr_info("Discarded unknown event %x to gate %x\n", event, gate);
		r = -EINVAL;
		break;
	}
    ...
exit_noskb:
	if (r)
		nfc_hci_driver_failure(hdev, r);
}

It is also reached from nfc_hci_llc_failure() and from drivers that call
the exported nfc_hci_driver_failure().

In the no-pending-command case, nfc_driver_failure() only calls
nfc_targets_found(dev, NULL, 0), so the link keeps receiving frames after
this.

Consider a message larger than the LLC payload. nfc_hci_recv_from_llc() has
queued the first fragments on rx_hcp_frags. Then, before the last fragment
arrives, msg_rx_work handles an unknown event. The resulting call chain
empties rx_hcp_frags:

nfc_hci_event_received()->nfc_hci_driver_failure()->nfc_hci_failure()

The window is the whole gap between fragment arrivals, so no tight race
seems to be needed.

> @@ -873,12 +876,19 @@ static void nfc_hci_recv_from_llc(struct nfc_hci_dev *hdev, struct sk_buff *skb)
>  	}
>  
>  	/* it's the last fragment. Does it need re-aggregation? */
> -	if (skb_queue_len(&hdev->rx_hcp_frags)) {
> +	__skb_queue_head_init(&frags);
> +	spin_lock_irqsave(&hdev->rx_hcp_frags.lock, flags);
> +	if (!skb_queue_empty(&hdev->rx_hcp_frags)) {
> +		__skb_queue_tail(&hdev->rx_hcp_frags, skb);
> +		skb_queue_splice_init(&hdev->rx_hcp_frags, &frags);
> +	}
> +	spin_unlock_irqrestore(&hdev->rx_hcp_frags.lock, flags);
> +
> +	if (!skb_queue_empty(&frags)) {

[ ... ]

> -		skb_queue_purge(&hdev->rx_hcp_frags);
> +		__skb_queue_purge(&frags);
>  	} else {
>  		packet->header &= NFC_HCI_FRAGMENT;
>  		hcp_skb = skb;

When the last fragment arrives after such a purge, the queue is empty. It
then takes this else branch and is handled as a complete HCP message.

The byte after the packet header is continuation payload, not a message
header. HCP_MSG_GET_TYPE() and HCP_MSG_GET_CMD() would then decode
payload bytes as the type and instruction.

The tail fragment would then either complete the pending command with the
wrong data and status, or be queued to msg_rx_queue as a bogus command or
event.

The splice under rx_hcp_frags.lock keeps skb_queue_walk() memory-safe. It
does not record that a reassembly was in progress, though. Is the commit
message right that this makes concurrent error purges safe?

Before this patch, rx_hcp_frags was only purged by the reassembly context
itself and by nfc_hci_unregister_device(). This cross-context reset appears
to be new.

Would it be better to purge partial fragments only from the reassembly path
in nfc_hci_recv_from_llc()? Another option is to track the reassembly state
so that an orphaned last fragment is dropped instead of dispatched.

[ ... ]

> diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
> --- a/net/nfc/llcp_core.c
> +++ b/net/nfc/llcp_core.c
> @@ -1636,8 +1636,10 @@ void nfc_llcp_recv(void *data, struct sk_buff *skb, int err)
>  {
>  	struct nfc_llcp_local *local = (struct nfc_llcp_local *) data;
>  
> -	if (err < 0) {
> +	if (err) {
>  		pr_err("LLCP PDU receive err %d\n", err);
> +		if (skb)
> +			kfree_skb(skb);
>  		return;
>  	}
>  

[Severity: Low]
Three of the Fixes: tags seem to point at commits that only moved or
renamed files. They do not point at the commits that introduced the
code being fixed.

30cc4587659e ("NFC: Move LLCP code to the NFC top level diirectory")
only renamed net/nfc/llcp/llcp.c to net/nfc/llcp_core.c, and did not
touch nfc_llcp_recv(). That function was added by d646960f7986 ("NFC:
Initial LLCP support"). It started taking the skb directly, without
skb_get(), in 1727cf937401 ("NFC: llcp: Fix Rx memory leak").

1c54795da05a ("NFC: st21nfca: Align st21nfca driver with other nfc
driver") only renamed st21nfca.c to core.c and st21nfca_dep.c to
dep.c. st21nfca_hci_data_exchange_cb() was added by 7974728094d3
("NFC: st21nfca: Add ISO15693 Reader/Writer support"). The dep.c
callbacks are already covered by the 1892bf844ea0 tag.

97f18414af39 ("NFC: Separate pn544 hci driver in HW dependant and
independant parts") moved pn544_hci_data_exchange_cb() unchanged from
drivers/nfc/pn544_hci.c to drivers/nfc/pn544/pn544.c. The function
itself came from f3e8fb552789, which is already listed. That makes
this tag look redundant.

This has no effect at runtime. However, the stable tooling uses these
tags to decide how far back the fix should go, and rename commits make
that range harder to work out. Could you replace them with the commits
that introduced the code, and drop the ones already covered by another
tag?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261127134029.1813-1-luob87709%40gmail.com
