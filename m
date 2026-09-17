Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94492519905;
	Thu, 17 Sep 2026 13:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789651480; cv=none; b=ZlMY4PkPGkorJrKcT36+NfWOeCQWQOBCf5zRodD+vUt9lI1CIQn5+8dgZcjvA9Ruy3+pTTU17qQ5IBR8guwOIclCPGoPeVwGx7QgZzaBSt7LvEe4+y48jfTiq3bdec5GoNSDDZy43bbGOWhB78OJ23wXblfBvLtrGqUtw8BY9Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789651480; c=relaxed/simple;
	bh=8SYrna0h7hy9G1HhESG+hr0L2dZ6q55slGve/8iQ1F4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4ZOox0DugpfIY/gftyE6liLeUNicvJ0jGy1bUmXDtMs2IhxKYdmsnt5WiJJyG91rWT9XkneJW70HhmtZMPmNi7bhE8+u2YZ2VGRZMol7mWU7nW2rzxg7vMxCZY5sqcgwamA9o0xtAUrps3RICYg7ugQWamldBNoGBoHV3W2Z2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXVdw/s1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXVdw/s1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 017B41F000FF;
	Thu, 17 Sep 2026 13:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789651478;
	bh=XVpEaO5zQhrxqsYxXWhqnm9w9AUITsTWiX4MH0lZy7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dXVdw/s1F4/q5VXDtCvo6NbprcH8bzPeUqgvZptvXozgx5JMBoGFdN9EVcz0kCf1H
	 SEBI/lm43Q70HsAA+zcGxiSHMtKETUrB6BnQSVbybzMPRy95AQGfqDtLTjEJ1ksA/q
	 AePTZl0ZpzB0zdM3NBp19SbQnwax/sqRwPlx1zgxn1zRxiAMoEgbOR+sYludXOp+5l
	 lH9pjOGgVUynoFBvOkCv5PRAvpr84bTmbyoq6PBhAz785ya0AtZPMAw22shz5RszH8
	 NdnOJlCCoyYjeAzLHRXGd03EegjcJIcZYRNQKp8TbamrVdSJ5oKTm39xveM66TTJh/
	 h1QDbdz5I2Z2w==
Date: Thu, 17 Sep 2026 14:24:33 +0100
From: Simon Horman <horms@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: liuc63@xiaopeng.com, david@ixit.cz, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	ilane@ti.com, linville@tuxdriver.com, oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] nfc: nci: avoid unbounded skb allocation when
 max_pkt_payload_len is zero
Message-ID: <20260917132433.GE51261@horms.kernel.org>
References: <20260913101309.891633-1-liuc63@xiaopeng.com>
 <178938411495.22033.4311942083485691702@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178938411495.22033.4311942083485691702@kernel.org>

On Mon, Sep 14, 2026 at 11:08:34AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 2 (1) · Medium: 0 · Low: 0

Hi Lin,

There is an expectation that AI-generated reviews forwarded to
the netdev ML are responded to. That can take a variety of forms
including an email response that agrees with or refutes the review,
or an updated version of the patch with an appropriate changelog.

The expectation is the patch author or submitter handles this.
But let me try to help by taking a stab at the first approach.

> - [High] Incomplete fix: a controller-supplied
>   `conn_info->max_pkt_payload_len` of 0 (or 1) is still consumed…
> - [High] TOCTOU: the new guard reads `conn_info->max_pkt_payload_len`
>   once (net/nfc/nci/data.c:117) but the fragmentation loop re-reads the…

It seems to me that both of the above are actually a pre-existing issues
that are not made worse by this patch.

> 
> Pre-existing issues:
> - [High] Use-after-free of `struct nci_conn_info`:
>   `nci_get_conn_info_by_conn_id()` (net/nfc/nci/core.c:43-54) walks…

It seems to me that although this is a pre-existing issue it may
actually be made worse than this patch.

Overall, my view is that bug fixes for NFC improve it's quality,
moving things in the right direction. I lean towards none of
the above warranting blocking the progress of this patch.
But I would appreciate your input.

> 
> --
> 
> nfc: nci: avoid unbounded skb allocation when max_pkt_payload_len is zero
> 
> This adds a check in nci_queue_tx_data_frags() that rejects a
> conn_info->max_pkt_payload_len of zero with -EPROTO, so the fragmentation
> loop cannot spin forever allocating skbs.  The commit message explains why
> the check was placed in the fragmentation path instead of at the two
> assignment sites in ntf.c and rsp.c.
> 
> A few questions below about the placement of the check and about how the
> field is read.
> 
> > diff --git a/net/nfc/nci/data.c b/net/nfc/nci/data.c
> > index 4253edea5c8db..b549cef7dc2e4 100644
> > --- a/net/nfc/nci/data.c
> > +++ b/net/nfc/nci/data.c
> > @@ -114,6 +114,11 @@ static int nci_queue_tx_data_frags(struct nci_dev *ndev,
> >  		goto exit;
> >  	}
> >  
> > +	if (!conn_info->max_pkt_payload_len) {
> > +		rc = -EPROTO;
> > +		goto exit;
> > +	}
> > +
> 
> [Severity: High]
> The commit message says:
> 
>   "nci_queue_tx_data_frags() is the only place that loops"
> 
> Is that accurate?  nci_hci_send_data() in net/nfc/nci/hci.c also loops over
> the same field, and it runs before nci_send_data() gets a chance to reject
> anything:
> 
> net/nfc/nci/hci.c:nci_hci_send_data() {
> 	skb = nci_skb_alloc(ndev, conn_info->max_pkt_payload_len +
> 			    NCI_DATA_HDR_SIZE, GFP_ATOMIC);
> 	...
> 	skb_reserve(skb, NCI_DATA_HDR_SIZE + 2);
> 	*(u8 *)skb_push(skb, 1) = data_type;
> 
> 	do {
> 		/* If last packet add NCI_HFP_NO_CHAINING */
> 		if (i + conn_info->max_pkt_payload_len -
> 		    (skb->len + 1) >= data_len) {
> 			cb |= NCI_HFP_NO_CHAINING;
> 			len = data_len - i;
> 		} else {
> 			len = conn_info->max_pkt_payload_len - skb->len - 1;
> 		}
> 
> 		*(u8 *)skb_push(skb, 1) = cb;
> 
> 		if (len > 0)
> 			skb_put_data(skb, data + i, len);
> 
> 		r = nci_send_data(ndev, conn_info->conn_id, skb);
> 	...
> }
> 
> skb->len is unsigned int, so i + max_pkt_payload_len - (skb->len + 1) is
> evaluated unsigned.  With max_pkt_payload_len == 0, i == 0 and skb->len == 1
> that is 0 - 2 == 0xfffffffe, which is >= any realistic data_len, so the
> "last packet" branch is always taken and len becomes the whole payload.  The
> same underflow happens for max_pkt_payload_len == 1.
> 
> The skb was only sized for 0 + NCI_DATA_HDR_SIZE plus tx_headroom/tx_tailroom,
> so the usable tailroom is just the kmalloc/SKB_DATA_ALIGN slack.  Can
> skb_put_data() then run past skb->end and hit skb_over_panic() -> BUG()
> before the new check in nci_queue_tx_data_frags() is ever consulted?
> 
> The value fed into that arithmetic is stored verbatim in
> nci_core_conn_create_rsp_packet():
> 
> net/nfc/nci/rsp.c:nci_core_conn_create_rsp_packet() {
> 	...
> 	if (ndev->cur_params.id == ndev->hci_dev->nfcee_id)
> 		ndev->hci_dev->conn_info = conn_info;
> 
> 	conn_info->conn_id = rsp->conn_id;
> 	conn_info->max_pkt_payload_len = rsp->max_ctrl_pkt_payload_len;
> 	...
> }
> 
> and the payload length on the other side is user controlled:
> nfc_genl_se_io() takes NFC_ATTR_SE_APDU as NLA_BINARY with no maximum, and
> st_nci_se_io() -> nci_hci_send_event() -> nci_hci_send_data() carries it
> straight into the loop above.  nci_hci_cmd_received() also calls
> nci_hci_send_data() directly from the rx work.
> 
> Would it make more sense to validate at the assignment sites
> (nci_core_conn_create_rsp_packet() and nci_rf_intf_activated_ntf_packet()),
> or to additionally fix the arithmetic in nci_hci_send_data()?  A plain
> != 0 test would still leave the max_pkt_payload_len == 1 underflow in place.
> 
> [Severity: High]
> The new check reads conn_info->max_pkt_payload_len once, but the loop below
> re-reads the same field on every iteration:
> 
> net/nfc/nci/data.c:nci_queue_tx_data_frags() {
> 	...
> 	while (total_len) {
> 		frag_len =
> 			min_t(int, total_len, conn_info->max_pkt_payload_len);
> 	...
> }
> 
> The field is a plain __u8 with no READ_ONCE/WRITE_ONCE, no atomic and no
> lock, and it is written from the rx workqueue with controller-supplied data
> in nci_rf_intf_activated_ntf_packet() and nci_core_conn_create_rsp_packet().
> 
> The reader side is rawsock_tx_work -> nfc_data_exchange() -> nci_transceive()
> -> nci_send_data() -> nci_queue_tx_data_frags(); the only lock it holds is
> device_lock(&dev->dev), plus ndev->tx_q.lock after the loop.  The writer side
> is nci_rx_work() -> nci_ntf_packet()/nci_rsp_packet() -> the assignments, and
> neither takes device_lock.
> 
> CPU0 (rawsock_tx_work)                        CPU1 (nci_rx_work)
> conn_info = nci_get_conn_info_by_conn_id()
> if (!conn_info->max_pkt_payload_len)  /* nonzero, passes */
> frag_len = min_t(int, total_len,
> 		 conn_info->max_pkt_payload_len);
>                                               conn_info->max_pkt_payload_len = 0;
> /* next iteration */
> frag_len = 0 -> total_len never decreases
> 
> Can the store land between the check and a later re-read, leaving the loop in
> exactly the unbounded nci_skb_alloc(GFP_ATOMIC) state the commit describes?
> 
> Would snapshotting the field into a local, e.g.
> 
> 	u8 max_len = READ_ONCE(conn_info->max_pkt_payload_len);
> 
> and using that for both the validation and the min_t() close the window?
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but the conn_info pointer that the
> new check dereferences has no lifetime guarantee.
> nci_get_conn_info_by_conn_id() walks the list with no lock, no RCU and no
> lockdep assertion:
> 
> net/nfc/nci/core.c:nci_get_conn_info_by_conn_id() {
> 	list_for_each_entry(conn_info, &ndev->conn_info_list, list) {
> 		if (conn_info->conn_id == conn_id)
> 			return conn_info;
> 	}
> 
> 	return NULL;
> }
> 
> while the rx work frees the same object immediately, with no grace period:
> 
> net/nfc/nci/rsp.c:nci_core_conn_close_rsp_packet() {
> 	if (status == NCI_STATUS_OK) {
> 		conn_info = nci_get_conn_info_by_conn_id(ndev,
> 							 ndev->cur_conn_id);
> 		if (conn_info) {
> 			list_del(&conn_info->list);
> 			if (conn_info == ndev->rf_conn_info)
> 				ndev->rf_conn_info = NULL;
> 			devm_kfree(&ndev->nfc_dev->dev, conn_info->dest_params);
> 			devm_kfree(&ndev->nfc_dev->dev, conn_info);
> 		}
> 	}
> 	...
> }
> 
> nci_rsp_packet() dispatches CORE_CONN_CLOSE_RSP without checking that a
> matching command was outstanding, and the tx path holds only
> device_lock(&dev->dev), which the rx worker never takes.  Can an unsolicited
> CORE_CONN_CLOSE_RSP with status OK for ndev->cur_conn_id free the conn_info
> while nci_queue_tx_data_frags() is still reading
> conn_info->max_pkt_payload_len, both in the new check and in the min_t() in
> the loop?  The list walk itself can also follow a freed node's linkage.
> 
> -- 
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260913101309.891633-1-liuc63%40xiaopeng.com
