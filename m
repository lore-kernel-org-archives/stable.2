Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795875221;
	b=vdRhvqG9RKv72eWvGokPAwNfvyeWM4BlLV3i0v1CYUPbLvvGBwQxdvtDO8bi17ZaoRCZ
	 oWzIGkPBZmJUl/1yzRkmTc41c1JYuqYy+EzChLvuMF/yAEkW+N96kxFl7CfKq3geEGsQn
	 GpqaC0orXYNXsIxOtBbLewJ8HW/Yi/gh2yET67+vivlGe+fza4VUla3Z+5/rH9xvMPMha
	 /17ahiRZZ1z8uakYJ4Qz92/2L636voNY6viYVRJFglFqAsakGcwTxn3p6N7pkRy0+N8hC
	 BDCIlqP613fxo5adeRk8+0BlTkVweFHvlGrVdXPBspYYnwkfW33cl2CheMaDEO3+x6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795875221;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=GYrgUyRVneZDfW/CyAAKO17GPac2XqtRmzjmqW0C5S8=;
	b=lXshZCdCpHTy/4zNIuXnT7rVpoqAtGIOQKYCKBQai0Qu6xa13YfZj3g1gZPuaDVg6Wa8
	 /wepih/nOYySL4GaALxfy8giydEo1EAsGWczEF5rz+tWus8sSKP058JA6Z6dhHXw5aMjB
	 D9Qc69RZcq+v7a6jIq/6kQSHj/PDZ9pltGZMddCuQVjKNe6fCfmeya2/M04gTkdzf62dv
	 rBubJKBo3aLEdpEzEba3cvVw6a+NccP4bFrTtqIZcdKqvHIOItBYPuWfiKgcBpDeZrJec
	 VqLrWpk0tkGcHzSyIgIETUUGAt4WcfV54AbTmyiLhj+7s0QGXXPOTFNVIc+pNdxdD0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aToQ2ykk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B3E606A329;
	Sat, 28 Nov 2026 14:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aToQ2ykk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B780B1F000C1;
	Sat, 28 Nov 2026 14:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795875221;
	bh=GYrgUyRVneZDfW/CyAAKO17GPac2XqtRmzjmqW0C5S8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aToQ2ykkHEMZCV1S2ccctBJPGk1ZjBEiQNJMszQkh+mZrm8i6PfPk7HQaOBR8Q5Kj
	 dMXarQSiInR6AmV4KFXLs5w3RWJBIEnOHBhUZ0kG1Au0IFG6RcEvUWK7k2ASIb8lJK
	 8BTehyI8gGxNecLCzBwH+anjAui/UHdZM2rVxc3VydEnvXJX2zygcY5SjhFg3tD7dV
	 VGKCiRb/8TnlHxzpV+9j0jeoAfBU4PeN4AA+ssGrlNMFGdWdIIvFB0vB26h6qtlLfv
	 oJ0YGWw5rhKI9mMnsFhyH9PCrmpE4JT2v4x9ASdoh6+YNXeeX9slkgr2pPnId4tSdP
	 UaHcygVuWosbA==
Subject: Re: [PATCH v5 4/5] nfc: nci: drop stale rx_data_reassembly on errors,
 timeout, and close
From: netdev-bot+sashiko@kernel.org
To: luob87709@gmail.com
Cc: oe-linux-nfc@lists.linux.dev, johan@kernel.org, david@ixit.cz,
 kuba@kernel.org, netdev@vger.kernel.org, stable@vger.kernel.org
Date: Sat, 28 Nov 2026 14:13:40 +0000
Message-ID: <179587522029.3135.18031920907160557003@kernel.org>
In-Reply-To: <20261127134029.1813-5-luob87709@gmail.com>
References: <20261127134029.1813-5-luob87709@gmail.com>
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

Critical: 0 · High: 1 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] nci_close_device() (net/nfc/nci/core.c) now frees
  ndev->rx_data_reassembly at lines 629-634, after…
- [Medium] The commit says it stops stale reassembly bytes from surviving
  a close/reopen cycle, but it only frees ndev->rx_data_reassembly in…
- [Medium] nci_core_conn_intf_error_ntf_packet()
  (net/nfc/nci/ntf.c:135-137) now drops ndev->rx_data_reassembly on…
- [Low] The patch changes the early `return 0` in the already-down branch
  of nci_close_device() (net/nfc/nci/core.c:585) to `goto flush_rx`.
- [Low] The From:/Signed-off-by: names do not match.

--

nfc: nci: drop stale rx_data_reassembly on errors, timeout, and close

This patch frees and clears ndev->rx_data_reassembly in four cases where
a data exchange ends: a nonzero data status, CORE_INTERFACE_ERROR_NTF, a
data exchange timeout, and device close. The goal is to stop a partial
NCI_PBF_CONT fragment from being leaked or prepended to later data.

> Signed-off-by: Bin Luo (University of Electronic Science and Technology of China) <luob87709@gmail.com>

[Severity: Low]
This isn't a bug, but the author and Signed-off-by names don't match.

The author name is recorded as the bare email address,
"luob87709@gmail.com <luob87709@gmail.com>". The Signed-off-by name is
"Bin Luo (University of Electronic Science and Technology of China)".

checkpatch reports this as FROM_SIGN_OFF_MISMATCH. Could this be resent
with a proper From: header and a plain "Bin Luo <luob87709@gmail.com>"
sign-off? The other patches in this series have the same metadata.

> diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
> index efd4e5e0290d4..f832251589f33 100644
> --- a/net/nfc/nci/core.c
> +++ b/net/nfc/nci/core.c
> @@ -582,7 +582,7 @@ static int nci_close_device(struct nci_dev *ndev)
>  						   ndev->cur_conn_id,
>  						   -ENODEV);
>  		mutex_unlock(&ndev->req_lock);
> -		return 0;
> +		goto flush_rx;
>  	}

[Severity: Low]
Before this patch, the already-down branch of nci_close_device() returned
here without touching rx_wq. With the goto, it now also runs
flush_workqueue(ndev->rx_wq) and then takes req_lock a second time. This
branch is mostly reached from nci_unregister_device() when the device is
already down.

The commit message says:

  - In nci_close_device() after flush_workqueue(ndev->rx_wq) on both
    close paths, guarded by req_lock and !NCI_UP.

It doesn't say that the rx_wq flush is new on the down path.

The change looks harmless, because destroy_workqueue() drains rx_wq right
after this during unregister. Could the commit message still mention
this behaviour change, since the patch is tagged for stable?

>  
>  	/* Drop RX and TX queues */
> @@ -622,9 +622,17 @@ static int nci_close_device(struct nci_dev *ndev)
>  
>  	mutex_unlock(&ndev->req_lock);
>  
> +flush_rx:
>  	/* rx_work may take req_lock via nci_deactivate_target */
>  	flush_workqueue(ndev->rx_wq);
>  
> +	mutex_lock(&ndev->req_lock);
> +	if (!test_bit(NCI_UP, &ndev->flags)) {
> +		kfree_skb(ndev->rx_data_reassembly);
> +		ndev->rx_data_reassembly = NULL;
> +	}
> +	mutex_unlock(&ndev->req_lock);

[Severity: High]
Can this free ndev->rx_data_reassembly while nci_add_rx_data_frag() is
still using it?

Holding req_lock here doesn't keep rx_work out. The chain
nci_rx_work()->nci_rx_data_packet()->nci_add_rx_data_frag() reads,
copies from, frees and reassigns ndev->rx_data_reassembly without ever
taking req_lock.

The flush before this also doesn't stop rx_work from being queued again.
In nci_recv_frame(), the flag test and the queueing are not atomic with
respect to close:

net/nfc/nci/core.c:nci_recv_frame() {
	if (!ndev || (!test_bit(NCI_UP, &ndev->flags) &&
	    !test_bit(NCI_INIT, &ndev->flags))) {
		kfree_skb(skb);
		return -ENXIO;
	}

	/* Queue frame for rx worker thread */
	skb_queue_tail(&ndev->rx_q, skb);
	queue_work(ndev->rx_wq, &ndev->rx_work);
	...
}

The normal close path sets NCI_INIT again while
__nci_request(nci_reset_req) runs. Could this sequence happen?

CPU1 (driver rx path)
nci_recv_frame()
    passes the NCI_INIT test during the reset request
    <preempted>

CPU2
nci_close_device()
    clear_bit(NCI_INIT, &ndev->flags);
    ...
    flush_workqueue(ndev->rx_wq);

CPU1
    skb_queue_tail(&ndev->rx_q, skb);
    queue_work(ndev->rx_wq, &ndev->rx_work);

rf_conn_info survives close, so the requeued rx_work accepts a data
packet on conn 0. It then runs nci_add_rx_data_frag() while CPU2 does
this:

    mutex_lock(&ndev->req_lock);
    if (!test_bit(NCI_UP, &ndev->flags)) {
        kfree_skb(ndev->rx_data_reassembly);

That could result in:

- a use-after-free in the memcpy() from rx_data_reassembly->data
- a double kfree_skb() of rx_data_reassembly
- a fragment stored after the close-time free, which survives into the
  next open (the stale data problem this patch is meant to fix)

virtual_ncidev_write() calls nci_recv_frame() without a lock and without
checking vdev->running. That lets userspace on /dev/virtual_nci time
frames against close.

Before this patch, only two places touched this field. One was rx_work,
which is single-threaded. The other was nci_free_device(), which runs
after destroy_workqueue().

[Severity: Medium]
Does this cover a reopen after nci_open_device() fails?

The init failure branch of nci_open_device() purges the queues and calls
ops->close(). It doesn't flush rx_wq or drop rx_data_reassembly:

net/nfc/nci/core.c:nci_open_device() {
	...
	} else {
		/* Init failed, cleanup */
		skb_queue_purge(&ndev->cmd_q);
		skb_queue_purge(&ndev->rx_q);
		skb_queue_purge(&ndev->tx_q);

		ndev->ops->close(ndev);
		ndev->flags &= BIT(NCI_UNREG);
	}
	...
}

nci_recv_frame() accepts frames while NCI_INIT is set. rf_conn_info for
conn 0 is created on CORE_INIT_RSP and persists. So nci_add_rx_data_frag()
can store a CONT data fragment that arrives during init.

Suppose a later init step then fails (post_setup, init_complete_req, or a
timeout). dev_up stays false and nfc_dev_down() returns -EALREADY, so
nci_close_device() and this new cleanup never run.

Nothing clears the buffer on the next successful open either. The first
data packet in initiator or target mode would then be reassembled on top
of the stale fragment.

Could the init failure branch flush rx_wq and drop the buffer? Another
option is to drop it once at the start of nci_open_device().

> +
>  	return 0;
>  }

[ ... ]

> diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
> index f5c9a8ab7ec10..3ca1009ecb335 100644
> --- a/net/nfc/nci/ntf.c
> +++ b/net/nfc/nci/ntf.c
> @@ -132,6 +132,10 @@ static int nci_core_conn_intf_error_ntf_packet(struct nci_dev *ndev,
>  
>  	pr_debug("status 0x%x, conn_id %d\n", ntf->status, ntf->conn_id);
>  
> +	/* drop partial rx data packet */
> +	kfree_skb(ndev->rx_data_reassembly);
> +	ndev->rx_data_reassembly = NULL;
> +

[Severity: Medium]
Should this drop be limited to the connection that owns the partial
message?

CORE_INTERFACE_ERROR_NTF reports an error on one logical connection,
ntf->conn_id. The reassembly buffer is shared by the static RF connection
and the dynamic HCI/NFCEE connections, which use
nci_hci_data_received_cb() as their data_exchange_cb.

Consider this sequence:

1. The NFCC sends a CONT segment on RF conn 0, which is stored in
   rx_data_reassembly.
2. The NFCC sends CORE_INTERFACE_ERROR_NTF for a different HCI/NFCEE
   connection, and this code frees the RF partial message.
3. The NFCC sends the LAST segment on conn 0.
   nci_add_rx_data_frag() finds no reassembly and treats the tail as a
   complete frame.

In target mode, the truncated tail is passed on with no error:

net/nfc/nci/data.c:nci_add_rx_data_frag() {
	...
	if (ndev->nfc_dev->rf_mode == NFC_RF_TARGET) {
		/* Data received in Target mode, forward to nfc core */
		err = nfc_tm_data_received(ndev->nfc_dev, skb);
	...
}

So LLCP would receive a truncated PDU. In initiator mode, the same
notification also clears NCI_DATA_EXCHANGE, so the tail is mostly
dropped rather than delivered.

nci_rf_deactivate_ntf_packet() can drop the buffer unconditionally
because RF deactivation ends the whole RF interface. This notification
is per connection. Could the drop first check ntf->conn_id, for example
against NCI_STATIC_RF_CONN_ID or ndev->cur_conn_id?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261127134029.1813-1-luob87709%40gmail.com
