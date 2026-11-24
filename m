Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795503321;
	b=hBANhulhb6cLUgH/70iF+3gFrpfWZFakYY0muB0PjEjoGkQ4uGGCcUazoBx5tjo1TkPj
	 zCwNnWGu5h6xf9F0+fuOgZd3F4bTK8jm8Gvingoh9fXM104f7NI2LF4FsHslXBUadZtAM
	 /kZ9NojeUQZ12q/zdR1mIXINHlFnqmVLGcvfpNBgqrYSTEJVZBX5FOyQlUJnz3tCi5klo
	 714IvV6tU+uDX7dJo0I/d6cpEXSZgAVvPZwIhMSa5/39tLYscX+Psi7lPyUedDWIC4blR
	 VmwvdB0CY2G14vPqS1J3+V4r5j2UpOp+ya/0zRU6uyfhKiu5SFavZ3HnKXr5xcN//5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795503321;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=/am0Ui5O8ZgJjLefAk3WySAiMixFJOXgY5Mtdl343Ro=;
	b=P/0xLyUQNw9128FNd0/1HlMeSGNxsAXRVEDpf9hVAtWM9l7fQ+fMNTfKDvciwLriHxf6
	 YDHIeaIax9tAmPTMPCn+4c5BEfQiUfYnZwrQe1xxcdcNPZBQRYxJkNAY9UVv24a7U/4v4
	 ++/UCGsFXXaInV56/dLo6WWlYKA3dyEymJLM6dOngvaMr/a7V2zU9NeO4sqpcqUU4jBMi
	 vBjPxaj3oQhrhvIJCcE6ME716EfJYjoaspH/E0hYwT8XDuwAs7d2GeXsoD6Ox4BL7QL1a
	 dwmVR9EDHEPr5fp8wp+tNQAX+dWgV2NSnKY474kEF4CPvH+Yembwjz9+Z6mYiOgbefg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xkojbjj9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32F8606A31E;
	Tue, 24 Nov 2026 06:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xkojbjj9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC4F11F000E0;
	Tue, 24 Nov 2026 06:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795503321;
	bh=/am0Ui5O8ZgJjLefAk3WySAiMixFJOXgY5Mtdl343Ro=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Xkojbjj9LPS/RBIzqFJoRqYwgRfYUifDpRYD81FKZWBj+kfGNQDuTffiBwCYrJne1
	 EPnafCt6UisVKuehNGPYpdpkGsbtp79N6FyZfJA5wirpHSahkK2MWm1ZLOCeAEs5kN
	 9FldjhmEgkha4NHQymZNs2WadQQT/IHeVi2EBKx4JSQdqeF72sPmPpb0l5RB3BYCWw
	 rd+cT8b5wDpasHKzUwTtYirw4GYYDUlqfRZfHsFFDmwGB2+jsq8e2xlt2cfvs95qTL
	 dut5d+cHDo+lLKDT0RX538c04lTz7Hau7Hs8AOHRWtoADdBud4qN0an5IZkBxUCRMC
	 rRybRdSGzwEHA==
Subject: Re: [PATCH v3 1/2] net/nfc: fix skb ownership on data exchange errors
From: netdev-bot+sashiko@kernel.org
To: luob87709@gmail.com
Cc: oe-linux-nfc@lists.linux.dev, johan@kernel.org, david@ixit.cz,
 kuba@kernel.org, netdev@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 24 Nov 2026 06:55:20 +0000
Message-ID: <179550332031.3135.1368504949137850977@kernel.org>
In-Reply-To: <20261123063310.1267-2-luob87709@gmail.com>
References: <20261123063310.1267-2-luob87709@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 1 (2) · Medium: 4 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch adds `skb_queue_purge(&hdev->rx_hcp_frags)` at the top
  of nfc_hci_failure(), before any lock is taken.
- [Medium] The commit message describes the patch's most serious hunks
  inaccurately, and the single `Fixes: 98ff416f97c5` tag covers only the…
- [Medium] The patch routes terminal Digital DEP failures through the
  registered callback and edits the PN533 exchange state machine, but it…
- [Medium] The commit message says queued NCI/HCI fragments are dropped
  "when an exchange fails", but the timeout failure paths still keep…
- [Medium] The new `skb_queue_purge(&ndev->hci_dev->rx_hcp_frags)` in the
  `if (err)` branch of nci_hci_data_received_cb() can run in process…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  nci_nfcc_loopback_cb() ignores `err`.
- [High] This problem wasn't introduced by this patch, but
  nci_data_exchange_complete() only calls a connection's…
- [Low] Concern: NCI data status errnos are truncated through a `__u8`
  parameter, so a positive value reaches data_exchange_cb_t and SO_ERROR…

--

net/nfc: fix skb ownership on data exchange errors

The patch documents that a data_exchange_cb_t callback owns a non-NULL
response skb whatever the value of err. It updates HCI, NCI, LLCP, rawsock
and several drivers to free or consume that skb on error. It also sends
terminal Digital DEP errors through the completion callback, purges
pending NCI/HCI fragments on failure, and clears the PN533 resp pointer
once resp has been queued.

> Document callback ownership and make affected paths release or consume
> the skb. Complete terminal Digital DEP failures through the registered
> callback, and drop queued NCI/HCI fragments when an exchange fails.
> Transfer PN533 responses to its queue before subsequent error handling.
>
> Fixes: 98ff416f97c5 ("NFC: nci: Add status byte management in case of error.")

[Severity: Medium]
The message seems to undersell what several hunks fix. Also, the single
Fixes tag only matches the status hunk in nci_add_rx_data_frag().

Before this patch, pn533_data_exchange_complete() queued resp on
dev->resp_q. If pn533_build_response() then failed alloc_skb(), its out:
label purged resp_q, which freed resp:

pn533_build_response()
    skb = alloc_skb(skb_len, GFP_KERNEL);
    if (skb == NULL)
        goto out;
    ...
out:
    skb_queue_purge(&dev->resp_q);

The caller then took goto error and called dev_kfree_skb(resp) on the
freed skb. The new resp = NULL fixes that double free, but the message only
says "Transfer PN533 responses to its queue".

In digital_in_recv_dep_res(), the old goto error paths skipped
data_exch->cb(). That meant rawsock_data_exchange_complete() never called
sock_put(), so the socket reference leaked and tx_work_scheduled stayed
true.

In st21nfca_im_recv_atr_res_cb(), only the default case freed the skb.
So the ATR_RES skb leaked on every successful READER_F exchange. The new
out: kfree_skb(skb) fixes that success-path leak, and the message doesn't
mention it.

None of these appear to come from 98ff416f97c5. Could the message
describe the double free, the socket reference leak and the success-path
leak? Could it also carry Fixes tags for the commits that introduced
them?

> diff --git a/drivers/nfc/pn533/pn533.c b/drivers/nfc/pn533/pn533.c
> index b0133e51dce96..f7bdc07951741 100644
> --- a/drivers/nfc/pn533/pn533.c
> +++ b/drivers/nfc/pn533/pn533.c
> @@ -2138,6 +2138,7 @@ static int pn533_data_exchange_complete(struct pn533 *dev, void *_arg,
>  	}
>  
>  	skb_queue_tail(&dev->resp_q, resp);
> +	resp = NULL;
>  
>  	if (mi) {
>  		dev->cmd_complete_mi_arg = arg;

[Severity: Medium]
While this state machine is being changed, what happens to arg when the
multi-frame workers fail?

pn533_data_exchange_complete() hands arg to mi_rx_work or mi_tx_work and
returns -EINPROGRESS. If pn533_send_cmd_direct_async() fails in
pn533_wq_mi_recv(), it does:

    dev_kfree_skb(skb);
    kfree(dev->cmd_complete_mi_arg);

error:
    dev->phy_ops->send_ack(dev, GFP_KERNEL);
    queue_work(dev->wq, &dev->cmd_work);

pn533_wq_mi_send() does the same with kfree(dev->cmd_complete_dep_arg).
A pn533_alloc_skb() failure in mi_recv, or skb == NULL in mi_send, jumps
to error: without freeing arg at all.

Neither path calls arg->cb, and neither purges dev->resp_q. Doesn't that
mean rawsock_data_exchange_complete() never runs, so the sock_hold()
reference from rawsock_tx_work() leaks and tx_work_scheduled stays set?

The partial responses left in resp_q would also be joined into the next
exchange's response by pn533_build_response().

This patch fixes the same kind of problem for Digital DEP.

[ ... ]

> diff --git a/net/nfc/hci/core.c b/net/nfc/hci/core.c
> index ba6f0310ffd7c..0557fa3fd42b6 100644
> --- a/net/nfc/hci/core.c
> +++ b/net/nfc/hci/core.c

[ ... ]

> @@ -833,6 +832,7 @@ static int hci_se_io(struct nfc_dev *nfc_dev, u32 se_idx,
>  
>  static void nfc_hci_failure(struct nfc_hci_dev *hdev, int err)
>  {
> +	skb_queue_purge(&hdev->rx_hcp_frags);
>  	mutex_lock(&hdev->msg_tx_mutex);
>  
>  	if (hdev->cmd_pending_msg == NULL) {

[Severity: High]
Can this purge race with the fragment reassembly in
nfc_hci_recv_from_llc()?

nfc_hci_failure() is reached through nfc_hci_driver_failure() from
nfc_hci_event_received(). That function runs in hdev->msg_rx_work,
because every non-response HCP message is queued to msg_rx_queue. Any
event handling error ends up here, for example an unknown event (-EINVAL)
or a TARGET_DISCOVERED event with a non-zero status (-EPROTO):

nfc_hci_msg_rx_work()
  nfc_hci_event_received()
    nfc_hci_driver_failure()
      nfc_hci_failure()
        skb_queue_purge(&hdev->rx_hcp_frags)

At the same time, nfc_hci_recv_from_llc() runs in the LLC receive
context: shdlc sm_work, or the driver's receive thread for llc_nop. It
walks rx_hcp_frags without the queue lock and does a sleeping allocation
between the two walks:

    skb_queue_walk(&hdev->rx_hcp_frags, frag_skb) {
        msg_len += (frag_skb->len -
                    NFC_HCI_HCP_PACKET_HEADER_LEN);
    }

    hcp_skb = nfc_alloc_recv_skb(NFC_HCI_HCP_PACKET_HEADER_LEN +
                                 msg_len, GFP_KERNEL);
    ...
    skb_queue_walk(&hdev->rx_hcp_frags, frag_skb) {
        msg_len = frag_skb->len - NFC_HCI_HCP_PACKET_HEADER_LEN;
        skb_put_data(hcp_skb,
                     frag_skb->data + NFC_HCI_HCP_PACKET_HEADER_LEN,
                     msg_len);
    }

msg_tx_mutex is only taken after the purge, so nothing orders the two
sides. Could the purge free frag_skb while the walk is still reading
frag_skb->len, frag_skb->data and frag_skb->next?

Before this patch, rx_hcp_frags was only changed at runtime from the
receive context.

[ ... ]

> diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
> index 73e3a96470ace..678f744a20795 100644
> --- a/net/nfc/nci/core.c
> +++ b/net/nfc/nci/core.c
> @@ -413,6 +413,7 @@ static void nci_nfcc_loopback_cb(void *context, struct sk_buff *skb, int err)
>  
>  	conn_info = nci_get_conn_info_by_conn_id(ndev, ndev->cur_conn_id);
>  	if (!conn_info) {
> +		kfree_skb(skb);
>  		nci_req_complete(ndev, NCI_STATUS_REJECTED);
>  		return;
>  	}

[Severity: High]
This is a pre-existing issue, but since this callback is being touched:
nci_nfcc_loopback_cb() ignores err. When conn_info is found, it still
does this even if skb is NULL:

    conn_info->rx_skb = skb;

    nci_req_complete(ndev, NCI_STATUS_OK);

Three paths can call the callback with a NULL skb and an error:

- nci_core_conn_intf_error_ntf_packet(), with a conn_id supplied by the
  NFCC and -EIO
- the skb_cow_head() failure in nci_add_rx_data_frag(), with -ENOMEM
- the data timeout path

nci_nfcc_loopback() then does:

    if (r == NCI_STATUS_OK && resp)
        *resp = conn_info->rx_skb;

It returns 0 with *resp == NULL, and st_nci_loopback() only checks
r < 0:

    r = nci_nfcc_loopback(ndev, data, data_len, &skb);
    if (r < 0)
        return r;

    msg = nfc_vendor_cmd_alloc_reply_skb(dev, ST_NCI_VENDOR_OUI,
                                         LOOPBACK, skb->len);

Can this dereference a NULL skb in the st-nci LOOPBACK vendor command?
It needs a pending RF nci_transceive() so that NCI_DATA_EXCHANGE is set.

Should the callback pass on err instead of reporting NCI_STATUS_OK?

> diff --git a/net/nfc/nci/data.c b/net/nfc/nci/data.c
> index 4253edea5c8db..3bbebb9505545 100644
> --- a/net/nfc/nci/data.c
> +++ b/net/nfc/nci/data.c
> @@ -220,6 +220,8 @@ static void nci_add_rx_data_frag(struct nci_dev *ndev,
>  
>  	if (status) {
>  		err = status;
> +		kfree_skb(ndev->rx_data_reassembly);
> +		ndev->rx_data_reassembly = NULL;
>  		goto exit;
>  	}
>  

[Severity: Medium]
The commit message says queued fragments are dropped "when an exchange
fails". Do the timeout paths still keep them, though?

In nci_rx_work(), the data timeout completes the exchange without
touching ndev->rx_data_reassembly:

    if (test_bit(NCI_DATA_EXCHANGE, &ndev->flags))
        nci_data_exchange_complete(ndev, NULL,
                                   ndev->cur_conn_id,
                                   -ETIMEDOUT);

Suppose the NFCC sent PBF_CONT segments and never sent the final one.
The stale partial skb then stays in rx_data_reassembly, and later in
nci_add_rx_data_frag() it is prepended to the first segment of the next
exchange:

    if (ndev->rx_data_reassembly) {
        reassembly_len = ndev->rx_data_reassembly->len;

Only a later deactivate notification clears it.

In the same way, the command timeout in nfc_hci_msg_tx_work() completes
with this and leaves hdev->rx_hcp_frags alone:

    hdev->cmd_pending_msg->cb(hdev->cmd_pending_msg->cb_context, NULL, -ETIME);

> diff --git a/net/nfc/nci/hci.c b/net/nfc/nci/hci.c
> index c03e8a0bd3bd6..a67bf6a72a706 100644
> --- a/net/nfc/nci/hci.c
> +++ b/net/nfc/nci/hci.c
> @@ -435,11 +435,14 @@ void nci_hci_data_received_cb(void *context,
>  	int msg_len;
>  
>  	if (err) {
> +		skb_queue_purge(&ndev->hci_dev->rx_hcp_frags);

[Severity: Medium]
Can this purge run at the same time as the reassembly further down in
this function?

nci_close_device() completes a pending exchange under req_lock, but it
only flushes rx_wq after unlocking:

    if (test_bit(NCI_DATA_EXCHANGE, &ndev->flags))
        nci_data_exchange_complete(ndev, NULL, ndev->cur_conn_id,
                                   -ENODEV);
    ...
    mutex_unlock(&ndev->req_lock);

    /* rx_work may take req_lock via nci_deactivate_target */
    flush_workqueue(ndev->rx_wq);

If cur_conn_id is the HCI connection, this calls
nci_hci_data_received_cb(ndev, NULL, -ENODEV) from process context. The
new skb_queue_purge() could then free fragments while rx_work is in the
lockless skb_queue_walk() / nfc_alloc_recv_skb(GFP_KERNEL) sequence of
the same function.

Getting there takes a contrived sequence. rx_work has to win the
NCI_DATA_EXCHANGE bit for HCI data, another nci_transceive() has to set
the bit again, and cur_conn_id has to move back to the HCI connection.
Nothing seems to prevent it, though.

> +		kfree_skb(skb);
>  		nci_req_complete(ndev, err);

[Severity: Low]
This isn't a bug introduced by this patch, but err is already an errno at
this point. nci_req_complete() stores it in req_result, and
__nci_request() then passes it through nci_to_errno() a second time.

This only changes which errno gets reported. Is that intended?

The original concern, that NCI data status errnos were truncated through
a __u8 parameter, looks to be fixed by the follow-up patch in this
series, "nfc: preserve NCI data status error codes", which changes the
parameter to int err.

>  		return;
>  	}

[Severity: High]
This is a pre-existing issue, but how often does this callback actually
run? nci_data_exchange_complete() only calls the connection's
data_exchange_cb when it wins the NCI_DATA_EXCHANGE bit:

    if (!test_and_clear_bit(NCI_DATA_EXCHANGE, &ndev->flags)) {
        kfree_skb(skb);
        return;
    }

Commit 8265a626cc14 added that gate. The only place the bit is set is
nci_transceive(), for the RF connection:

    if (test_and_set_bit(NCI_DATA_EXCHANGE, &ndev->flags)) {

NCI HCI traffic (nci_hci_send_data()->nci_send_data()) never sets it,
and neither does NFCC loopback (nci_send_data_req()->nci_send_data()).
So their responses are freed, nci_hci_data_received_cb() and
nci_nfcc_loopback_cb() never run, and the nci_request() callers time out.

If an RF transceive happens to be pending, an HCI or loopback completion
takes the RF exchange's bit instead, and the RF exchange loses its
completion.

It also means the new error-path cleanup here is only reachable in that
cross-connection case.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261123063310.1267-1-luob87709%40gmail.com
