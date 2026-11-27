Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795764912;
	b=f/lrc9WWxYBnnSEWq/Bq9gXFbUpO6K4Cd2UFtHcW+rRBbWyNfJzb7CzuDjzKY7dJuGPs
	 g3zjjVl7z1QWfpsURG2mh6KXbTfDro9Aunx19zCOrLCRJ325mD6q3o+jUMsEkJghAGwEa
	 xpYRy0TfDsF8f8E16jstDPNsjKmNhupWMv+1heOrdYmMm9fFuypkR1yVJM7V9AVQzLMYK
	 zhoIfIG19LECAej+NUFdja2m3vPAR3po93Zv8o2znng9FKeGYYDDZ0lF7L/idLDWrExNm
	 d2UgRzsLgT7/pnvqQoNAmQ8IeD9Zab6yYRy017ky6oeJg+YRQOgYxSLB82Mm6rMLPBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795764912;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=IugPK2g5DKsKQSCH6mUAfUSw+LY8vElRZfqJ+2+vSjc=;
	b=A/VWupbswEgyJl2DDbIL3UZdPgJINTANluWo6/YLkzkIZCSQBuuDNtSl7tPScldIAClV
	 bsBwoPdna41FRbaP1vIanCbsErkzBiH4tV3m76n6PUXSDIJ8OKQAyMstUpS1GOceZXLpt
	 8b1Mv6KfEuEU5jH1qS9sbUXI9yr+iLat4vk/vqN31hc0TXtHpx8SMTktPI/VeCE+Mu2V/
	 9NNiE5FqDLISrYMAtrJTrOaUp9wvwS71S++gY0Zx0v271tFR3ju6l+PzVKxu/rxAko2O7
	 /Wy1xddaFCyFZ8ELwxpTR6pf3sndGHUIklx7RGMR933+eC3gtc72jSXDGsU7Ykr38BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oYSYfN5h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B884E606A31E;
	Fri, 27 Nov 2026 07:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oYSYfN5h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0BE51F00893;
	Fri, 27 Nov 2026 07:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795764912;
	bh=IugPK2g5DKsKQSCH6mUAfUSw+LY8vElRZfqJ+2+vSjc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oYSYfN5hjHZC9W39jaAm2AyCf2iZYijfldI7DM6DA4DzotXCYo55yKZMlbeE1AU7S
	 aiMyIEgiVDzfTyXxtRWUB8MG4y0m+nzNFmUohejGeRwjcksRfLqvYcJdte84AdU0/z
	 9HeSp85zM7H9tNZ4Sq2w2DJutFS7MKSGw7JzvH0DMB/pM+2i2uBLeYEqbg4Lrux2a1
	 jX+IaWO1qOaEhUqzv3ymMoy6VOLJrqaaLJCJh84xQvQbEJ+1/LRuguoVMCObgG2zIt
	 h2lpPCSVtXQ6pcew29/umqBjlCRhnxeBjpka4ZyWVGmh99Lk6H3/yEA12BnjSflPYg
	 GjgCwOHpHuOuA==
Subject: Re: [PATCH v4 1/2] net/nfc: fix skb ownership on data exchange errors
From: netdev-bot+sashiko@kernel.org
To: luob87709@gmail.com
Cc: oe-linux-nfc@lists.linux.dev, johan@kernel.org, david@ixit.cz,
 kuba@kernel.org, netdev@vger.kernel.org, stable@vger.kernel.org
Date: Fri, 27 Nov 2026 07:35:11 +0000
Message-ID: <179576491145.3135.10392815197154160858@kernel.org>
In-Reply-To: <20261126063911.353-2-luob87709@gmail.com>
References: <20261126063911.353-2-luob87709@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says the NCI loopback and NCI-HCI callbacks
  leak the response skb on failed exchanges, and adds 'Fixes:…
- [Medium] The patch says it drops partial ndev->rx_data_reassembly
  fragments 'so stale fragments are neither leaked nor prepended to…
- [Medium] The commit says it drops partial NCI rx_data_reassembly
  fragments on interface errors.
- [Low] The commit message calls the patch a fix for skb leaks on error
  paths, but several hunks fix different and in one case more serious…

--

net/nfc: fix skb ownership on data exchange errors

This patch documents that a data_exchange_cb_t callback owns any
non-NULL skb regardless of err. It updates the rawsock, LLCP, HCI,
NCI, Digital DEP and several driver callbacks to free or complete on
error. It also drops partial NCI rx_data_reassembly fragments on
several error paths and reworks HCI fragment reassembly to use a
local queue.

> - Clear resp after queueing it to dev->resp_q in PN533 so subsequent
>   error handling cannot free an already queued skb.

[Severity: Low]
Is the PN533 case a double free rather than an ownership cleanup?

In pn533_data_exchange_complete(), resp has already been queued on
dev->resp_q. If pn533_build_response() then fails its alloc_skb(), it
purges that queue:

drivers/nfc/pn533/pn533.c:pn533_build_response() {
    ...
	skb = alloc_skb(skb_len, GFP_KERNEL);
	if (skb == NULL)
		goto out;
    ...
out:
	skb_queue_purge(&dev->resp_q);
    ...
}

That frees resp, and the old error path then called dev_kfree_skb(resp)
on it a second time.

Some other hunks also fix bugs other than skb leaks. The old goto error
sites in digital_in_recv_dep_res() skipped data_exch->cb(), so rawsock
never got a completion. It kept its sock reference and left
tx_work_scheduled set. That is a hang plus a refcount leak.

The st21nfca changes also fix success-path leaks.
st21nfca_im_recv_atr_res_cb() did not free the skb on the READER_F path
or on the r < 0 returns. st21nfca_im_recv_dep_res_cb() leaked it on an
unknown PFB type.

> Fixes: 98ff416f97c5 ("NFC: nci: Add status byte management in case of error.")
> Fixes: 1c53855f6be2 ("nfc: nci: Add nci_nfcc_loopback to the nci core")
> Fixes: c4bf98b220cb ("NFC: Add NCI data exchange timer")
> Cc: stable@vger.kernel.org

All three Fixes tags point at NCI commits. Could tags be added for the
commits that introduced the PN533, digital DEP, HCI, st21nfca, microread
and pn544 issues? Most of the diff lands there, and the patch is going
to stable.

> diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
> index 73e3a96470ace..f2b3137cb121e 100644
> --- a/net/nfc/nci/core.c
> +++ b/net/nfc/nci/core.c
> @@ -411,8 +411,18 @@ static void nci_nfcc_loopback_cb(void *context, struct sk_buff *skb, int err)
>  	struct nci_dev *ndev = (struct nci_dev *)context;
>  	struct nci_conn_info *conn_info;
>  
> +	if (err) {
> +		kfree_skb(skb);
> +		if (err < 0)
> +			nci_req_cancel(ndev, -err);
> +		else
> +			nci_req_complete(ndev, NCI_STATUS_FAILED);
> +		return;
> +	}
> +

[Severity: Medium]
Can this new error path in nci_nfcc_loopback_cb() actually run?

nci_data_exchange_complete() only calls the callback if it can claim
NCI_DATA_EXCHANGE:

net/nfc/nci/data.c:nci_data_exchange_complete() {
    ...
	if (!test_and_clear_bit(NCI_DATA_EXCHANGE, &ndev->flags)) {
		kfree_skb(skb);
		return;
	}
    ...
}

The only place that sets the bit appears to be nci_transceive():

	if (test_and_set_bit(NCI_DATA_EXCHANGE, &ndev->flags)) {

Neither nci_nfcc_loopback() nor the NCI-HCI send path sets it. The
NCI-HCI path is nci_hci_send_cmd()->nci_request(nci_hci_send_data_req)
->nci_send_data(). So loopback and NCI-HCI responses seem to be dropped
inside nci_data_exchange_complete() before nci_nfcc_loopback_cb() or
nci_hci_data_received_cb() is reached. That makes the new err branches
in both callbacks unreachable.

If so, loopback and NCI-HCI requests on this tree would always time out.
The commit message does not mention this.

The commit message also says the loopback callback leaked the response
skb. The old nci_nfcc_loopback_cb() ignored err, stored the skb in
conn_info->rx_skb and completed with NCI_STATUS_OK. A non-NULL skb was
handed to the caller and freed there, not leaked.

The old defect looks like a different one. An -EIO or -ETIMEDOUT
completion with a NULL skb was reported as success with a NULL *resp.
st_nci_loopback() then dereferences skb->len on it.

Should the commit message and the Fixes: 1c53855f6be2 tag describe this
as a NULL pointer dereference instead of a leak?

>  	conn_info = nci_get_conn_info_by_conn_id(ndev, ndev->cur_conn_id);
>  	if (!conn_info) {
> +		kfree_skb(skb);
>  		nci_req_complete(ndev, NCI_STATUS_REJECTED);
>  		return;
>  	}
> @@ -1597,10 +1607,13 @@ static void nci_rx_work(struct work_struct *work)
>  	/* check if a data exchange timeout has occurred */
>  	if (test_bit(NCI_DATA_EXCHANGE_TO, &ndev->flags)) {
>  		/* complete the data exchange transaction, if exists */
> -		if (test_bit(NCI_DATA_EXCHANGE, &ndev->flags))
> +		if (test_bit(NCI_DATA_EXCHANGE, &ndev->flags)) {
> +			kfree_skb(ndev->rx_data_reassembly);
> +			ndev->rx_data_reassembly = NULL;
>  			nci_data_exchange_complete(ndev, NULL,
>  						   ndev->cur_conn_id,
>  						   -ETIMEDOUT);
> +		}

[Severity: Medium]
The commit message says partial fragments are now dropped "so stale
fragments are neither leaked nor prepended to later responses". Does
nci_close_device() still keep them?

Both close paths complete the exchange and clear the flags, but neither
touches ndev->rx_data_reassembly:

net/nfc/nci/core.c:nci_close_device() {
    ...
	if (test_bit(NCI_DATA_EXCHANGE, &ndev->flags))
		nci_data_exchange_complete(ndev, NULL, ndev->cur_conn_id,
					   -ENODEV);

	/* Clear flags except NCI_UNREG */
	ndev->flags &= BIT(NCI_UNREG);
    ...
}

nci_open_device() does not reset it either. The only other place it is
freed is nci_free_device().

In listen/target mode this looks reachable:

1. nfc_tm_activated() clears dev->polling and never sets
   dev->active_target.
2. nfc_dev_down() only checks those two fields, so the device can be
   closed while an NCI_PBF_CONT segment from the remote initiator is
   buffered.
3. The device is brought back up and activated again.
4. The first data packet in nci_add_rx_data_frag() finds
   rx_data_reassembly non-NULL.
5. The previous session's bytes are prepended before the packet goes
   to nfc_tm_data_received(), or to the transceive callback in poll
   mode.

Should nci_close_device() free rx_data_reassembly as well? It would need
to come after the flush_workqueue(ndev->rx_wq) at the end of the
function, because rx_work may still be running before that point.

>  
>  		clear_bit(NCI_DATA_EXCHANGE_TO, &ndev->flags);
>  	}

[ ... ]

> diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
> index f5c9a8ab7ec10..2149383889338 100644
> --- a/net/nfc/nci/ntf.c
> +++ b/net/nfc/nci/ntf.c
> @@ -133,8 +133,11 @@ static int nci_core_conn_intf_error_ntf_packet(struct nci_dev *ndev,
>  	pr_debug("status 0x%x, conn_id %d\n", ntf->status, ntf->conn_id);
>  
>  	/* complete the data exchange transaction, if exists */
> -	if (test_bit(NCI_DATA_EXCHANGE, &ndev->flags))
> +	if (test_bit(NCI_DATA_EXCHANGE, &ndev->flags)) {
> +		kfree_skb(ndev->rx_data_reassembly);
> +		ndev->rx_data_reassembly = NULL;
>  		nci_data_exchange_complete(ndev, NULL, ntf->conn_id, -EIO);
> +	}

[Severity: Medium]
Should the rx_data_reassembly drop sit outside the test_bit() check?

NCI_DATA_EXCHANGE is only set by nci_transceive(). In listen/target
mode (rf_mode == NFC_RF_TARGET) the bit is never set, but
nci_add_rx_data_frag() still stores NCI_PBF_CONT segments in
ndev->rx_data_reassembly.

Suppose the NFCC sends a CORE_INTERFACE_ERROR_NTF in target mode after
forwarding a partial segment. The stale partial stays in place. The
next segment from the remote initiator gets those bytes prepended
before it reaches nfc_tm_data_received().

nci_rf_deactivate_ntf_packet() already drops the reassembly without
any condition:

	/* drop partial rx data packet */
	if (ndev->rx_data_reassembly) {
		kfree_skb(ndev->rx_data_reassembly);
		ndev->rx_data_reassembly = NULL;
	}

	/* complete the data exchange transaction, if exists */
	if (test_bit(NCI_DATA_EXCHANGE, &ndev->flags))

>  
>  	return 0;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261126063911.353-1-luob87709%40gmail.com
