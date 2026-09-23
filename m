Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C50F3A782D;
	Wed, 23 Sep 2026 11:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790161269; cv=none; b=VnK0nRCMQuWtQ6CrmVtsVfRwduIB0KROEwkAgGWwXT0EcCp1DPD91j5rPD1sOmCWKsHuSfkKHtNyYcGKk/QMsFqGNvurGXhZ4lbyLd9+YxFLGUJ4HD2wGKZRWMRKjg9BZvZaWhIBncbB97RtXYtzV0JsBsulNrTsb0wrpfh1ktM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790161269; c=relaxed/simple;
	bh=9yll0nn5e5lV+1in9Vhvnllsql337KFRc3hbJLB4hqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pUvVZvACiusOLm3LGBdn3j8qJQbeX5acNMCdmrFEt9kZnC5KQwTaTo7/P2KJAuPBdEp6O4dgYKxiG8DPuMB4Xea7MIOv+A3ea9WFHL5wVej4gvKMBGS0Avkmsvul7AlVbgnTTtO7cIiKaWwJAWKYEkJfmb1n8coN/txpEbdZkv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WK+LYWEi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WK+LYWEi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 239121F0089B;
	Wed, 23 Sep 2026 11:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790161258;
	bh=CSemoiGK8C8HIrpj1CQTjAtJI5ZavOEHMhvENOxUUaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WK+LYWEin48HI9L180eak8SkVQ64uMjyXAc/Cs+xSEk8qWULRn+1VCCWasa+p99kD
	 m9bDLawyUyN9yU909W7e6OTtyBytFg79fb5XnuibeEPizzJJSb4OfthnsA5trI0QB6
	 DlGwu+YRS4Hrt8Epg204Ub/aXWkYEVjuqzvdcXZ07gOQoKqGHUvmXtE2I8OeytaUQg
	 Xhpvv0u5Z0kEjccOApu8CCt0YSUpDgELN3mLEy53KcvOtoRArieIa1dV1wwX+F4gqj
	 FB7Kunt4TZswebcQSok9lntXrxA+KnR3q1cI9hJzkISTDQjJo6XKk48CHOMdUvqeOy
	 kCW3Zps0q/XcQ==
Date: Wed, 23 Sep 2026 12:00:53 +0100
From: Simon Horman <horms@kernel.org>
To: Liu Chao <liuc63@xiaopeng.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, ilane@ti.com, david@ixit.cz,
	linville@tuxdriver.com, oe-linux-nfc@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] nfc: nci: avoid unbounded skb allocation when
 max_pkt_payload_len is zero
Message-ID: <20260923110053.GT13925@horms.kernel.org>
References: <20260913101309.891633-1-liuc63@xiaopeng.com>
 <20260918185458.2711284-1-liuc63@xiaopeng.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918185458.2711284-1-liuc63@xiaopeng.com>

On Sat, Sep 19, 2026 at 02:54:58AM +0800, Liu Chao wrote:
> nci_queue_tx_data_frags() uses conn_info->max_pkt_payload_len as the
> fragment size.  When that value is zero, frag_len is always zero and
> total_len never decreases.  The loop then allocates skbs without
> bound: none of them are freed inside the loop, they accumulate on
> frags_q, and there is no cond_resched() in the loop body.  A single
> sendmsg() can therefore consume all allocatable memory, and on
> CONFIG_PREEMPT_NONE it occupies the CPU long enough to trip the
> softlockup watchdog:
> 
>   watchdog: BUG: soft lockup - CPU#3 stuck for 26s! [kworker/3:1:57]
>   Workqueue: events rawsock_tx_work [nfc]
>   Call Trace:
>    nci_send_data+0x1ca/0x6b0 [nci]
>    nci_transceive+0xbb/0x170 [nci]
>    rawsock_tx_work+0xb5/0x1a0 [nfc]
> 
> max_pkt_payload_len comes straight from controller-supplied fields,
> with no check for zero:
> 
>   ntf.c: conn_info->max_pkt_payload_len = ntf.max_data_pkt_payload_size;
>   rsp.c: conn_info->max_pkt_payload_len = rsp->max_ctrl_pkt_payload_len;
> 
> Reject the zero value in the fragmentation path rather than at the
> assignment sites.  nci_queue_tx_data_frags() is the only place that
> loops over the RF data path's conn_info, and nci_send_data() takes
> the non-fragmenting branch only for skb->len <= max_pkt_payload_len,
> which for a zero limit means empty skbs alone.  Validating on
> assignment would not be sufficient either, because
> nci_rf_disc_rsp_packet() allocates ndev->rf_conn_info with
> devm_kzalloc(), so max_pkt_payload_len is already zero before any
> notification arrives.
> 
> No legitimate configuration is affected: where the NCI spec does
> mandate a zero Max Data Packet Payload Size -- the NFCEE Direct RF
> Interface -- nci_rf_intf_activated_ntf_packet() takes the "goto
> listen" shortcut, bypassing the assignment entirely.
> 
> Snapshot the field once with READ_ONCE() and use the snapshot for
> both the check and the min_t() bound: the rx workqueue updates the
> field without any lock held against this path, so without the
> snapshot the check could validate a value the loop no longer
> consumes.
> 
> nci_hci_send_data() also loops over the same field, but on a
> different conn_info instance (ndev->hci_dev->conn_info) created by
> nci_core_conn_create_rsp_packet(); a zero or one there underflows
> the loop arithmetic and will be addressed in a separate patch.  This
> guards the path carrying the reported bug.
> 
> Fixes: 6a2968aaf50c ("NFC: basic NCI protocol implementation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Liu Chao <liuc63@xiaopeng.com>

A note on process: Please send new patch revisions in new email threads,
not as a response to an earlier revision. Thanks!

> 
> ---
> 
> v1 claimed that nci_queue_tx_data_frags() is "the only place that
> loops" over max_pkt_payload_len.  That holds for the RF data path
> (ndev->rf_conn_info) but was overstated as a blanket claim: the
> Sashiko review of v1 pointed out that nci_hci_send_data() loops over
> the same field as well, albeit on a separate conn_info instance
> (ndev->hci_dev->conn_info) -- pre-existing and unchanged here; it
> will be fixed separately.
> 
> The READ_ONCE() snapshot follows the same review: with the check and
> the loop reading the field independently, a store from the rx
> workqueue in between would let the loop spin on a value the check
> had just rejected.

There is a fresh AI-generated review of this patchset at
https://netdev-ai.bots.linux.dev/sashiko/#/message/20260918185209.2675909-1-liuc63%40xiaopeng.com

It raises a concern that the snapshot may not be broad enough.
Please take a look.

  The comment documents that the rx workqueue can update the field
  concurrently, but the only caller still reads the same field of the same
  conn_info with a plain load, and it is that read which decides whether
  fragmentation happens at all:

  net/nfc/nci/data.c:nci_send_data() {
	/* check if the packet need to be fragmented */
	if (skb->len <= conn_info->max_pkt_payload_len) {

  Should this read be part of the same snapshot?  Two things follow from
  leaving it as is.  The plain-versus-marked access pair on the field is
  still KCSAN-reportable, and the decision and the loop can consume
  different values: if nci_rf_intf_activated_ntf_packet() in
  net/nfc/nci/ntf.c lowers the limit (255 -> 64, say) right after
  nci_send_data() read the old value, nci_send_data() queues an
  unfragmented packet larger than the controller's current maximum, a
  transition the callee's snapshot cannot observe.  Would snapshotting once
  in nci_send_data() and passing the validated value down be preferable?


It also raises a concern regarding logging.  And while I do agree that the
logging in question should be rate limited, because it occurs on the data
path and is controlled by remote data, I am not convinced that it isn't a
pre-existing problem.

In any case, I think it should been addressed sooner or later.

  Does this new return value make the caller's log line reachable once per
  transmit attempt?

  net/nfc/nci/data.c:nci_send_data() {
		rc = nci_queue_tx_data_frags(ndev, conn_id, skb);
		if (rc) {
			pr_err("failed to fragment tx data packet\n");
			goto free_exit;

  Before the patch this input never returned from the helper, so the site
  was effectively unreachable for it.  With a controller reporting
  max_pkt_payload_len == 0, every sendmsg() on an NFC raw socket
  (rawsock_tx_work -> nfc_data_exchange -> nci_transceive -> nci_send_data)
  now logs a line, and so does every received HCP command, since
  nci_hci_cmd_received() answers each one with nci_hci_send_data(ndev, pipe,
  status, NULL, 0) -> nci_send_data().  Neither side is rate limited.
  Would pr_err_ratelimited(), or a ratelimited message at the new check
  itself, be a better fit for a controller-data-driven error path?

...
