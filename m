Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADCB3B05AC;
	Mon, 14 Sep 2026 11:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789384126; cv=none; b=uKCdGxhL9czAyWso/0SJY1Y8SW2h4dDrumONt0BvyEfUtPeN0ZZ3lwKqE2jCrKxiasA3rFZyfQeGMDPVd20VCK17MHqlS8q4oBPt00kG/EMAdg9Az1fGpxsOnZ6EPmEDH++7SoDPvx55j+6ww2ePbsu0ukv2y3+fjU8ObArLSo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789384126; c=relaxed/simple;
	bh=e2GBgFGC4Z8fuwShT8cfZGck5rtcRrwp9c0nNK396nA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tK3HISuw6L1QwwyZ+ZBBRNACC0FnOcnbPFJ5iknktNBEMreqsIPqaKyFFuqoxy6YMWfXO+XPdol2Wrx5o+/H7NVdJFOJqNCSCBBzSF2qpApw838WDr1or8XaGogOteWlKOwQNc1fGxFMyReOS57nbNBk8bTnbLj+L5JE83dI+oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCoKhohe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCoKhohe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6002D1F000FF;
	Mon, 14 Sep 2026 11:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789384116;
	bh=A05JHSfMHgGRLetcooxsD01qb3+vTPfHuve5cO2TZLk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KCoKhohetNSeLytWbRALrVEIoRDwaWNOOzgN67BFgniHHBR2CL3kCQkMNvyx9ZyOd
	 BjuL5KI9p1Ile75x7yai1yqitRFQ4YqPEI7emm0Tv4AQgsosbkjrjMSFc6L7d+DAFD
	 L520OBXbopvC7FhZMZEdGQZbnUUmG2tAb2TPWpMpGi2RdKvs/YbFAPJ0UU97FjB0Xh
	 7ydb12eUiJhCuS8YLITXvNbPt7iP80clZoidYKdf3i+oDaDzZDQxBeYooHYaiUi9CI
	 VhD8svlE9MhYXzxalmIW8IrREuQCRF4FywdR9ofDzsZFD1fIVmwziJQiK2rQFsfsaV
	 7HdD0Gn27EG0Q==
Subject: Re: [PATCH net] nfc: nci: avoid unbounded skb allocation when
 max_pkt_payload_len is zero
From: netdev-bot+sashiko@kernel.org
To: liuc63@xiaopeng.com
Cc: david@ixit.cz, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, ilane@ti.com, linville@tuxdriver.com,
 oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Mon, 14 Sep 2026 11:08:34 +0000
Message-ID: <178938411495.22033.4311942083485691702@kernel.org>
In-Reply-To: <20260913101309.891633-1-liuc63@xiaopeng.com>
References: <20260913101309.891633-1-liuc63@xiaopeng.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 2 (1) · Medium: 0 · Low: 0

- [High] Incomplete fix: a controller-supplied
  `conn_info->max_pkt_payload_len` of 0 (or 1) is still consumed…
- [High] TOCTOU: the new guard reads `conn_info->max_pkt_payload_len`
  once (net/nfc/nci/data.c:117) but the fragmentation loop re-reads the…

Pre-existing issues:
- [High] Use-after-free of `struct nci_conn_info`:
  `nci_get_conn_info_by_conn_id()` (net/nfc/nci/core.c:43-54) walks…

--

nfc: nci: avoid unbounded skb allocation when max_pkt_payload_len is zero

This adds a check in nci_queue_tx_data_frags() that rejects a
conn_info->max_pkt_payload_len of zero with -EPROTO, so the fragmentation
loop cannot spin forever allocating skbs.  The commit message explains why
the check was placed in the fragmentation path instead of at the two
assignment sites in ntf.c and rsp.c.

A few questions below about the placement of the check and about how the
field is read.

> diff --git a/net/nfc/nci/data.c b/net/nfc/nci/data.c
> index 4253edea5c8db..b549cef7dc2e4 100644
> --- a/net/nfc/nci/data.c
> +++ b/net/nfc/nci/data.c
> @@ -114,6 +114,11 @@ static int nci_queue_tx_data_frags(struct nci_dev *ndev,
>  		goto exit;
>  	}
>  
> +	if (!conn_info->max_pkt_payload_len) {
> +		rc = -EPROTO;
> +		goto exit;
> +	}
> +

[Severity: High]
The commit message says:

  "nci_queue_tx_data_frags() is the only place that loops"

Is that accurate?  nci_hci_send_data() in net/nfc/nci/hci.c also loops over
the same field, and it runs before nci_send_data() gets a chance to reject
anything:

net/nfc/nci/hci.c:nci_hci_send_data() {
	skb = nci_skb_alloc(ndev, conn_info->max_pkt_payload_len +
			    NCI_DATA_HDR_SIZE, GFP_ATOMIC);
	...
	skb_reserve(skb, NCI_DATA_HDR_SIZE + 2);
	*(u8 *)skb_push(skb, 1) = data_type;

	do {
		/* If last packet add NCI_HFP_NO_CHAINING */
		if (i + conn_info->max_pkt_payload_len -
		    (skb->len + 1) >= data_len) {
			cb |= NCI_HFP_NO_CHAINING;
			len = data_len - i;
		} else {
			len = conn_info->max_pkt_payload_len - skb->len - 1;
		}

		*(u8 *)skb_push(skb, 1) = cb;

		if (len > 0)
			skb_put_data(skb, data + i, len);

		r = nci_send_data(ndev, conn_info->conn_id, skb);
	...
}

skb->len is unsigned int, so i + max_pkt_payload_len - (skb->len + 1) is
evaluated unsigned.  With max_pkt_payload_len == 0, i == 0 and skb->len == 1
that is 0 - 2 == 0xfffffffe, which is >= any realistic data_len, so the
"last packet" branch is always taken and len becomes the whole payload.  The
same underflow happens for max_pkt_payload_len == 1.

The skb was only sized for 0 + NCI_DATA_HDR_SIZE plus tx_headroom/tx_tailroom,
so the usable tailroom is just the kmalloc/SKB_DATA_ALIGN slack.  Can
skb_put_data() then run past skb->end and hit skb_over_panic() -> BUG()
before the new check in nci_queue_tx_data_frags() is ever consulted?

The value fed into that arithmetic is stored verbatim in
nci_core_conn_create_rsp_packet():

net/nfc/nci/rsp.c:nci_core_conn_create_rsp_packet() {
	...
	if (ndev->cur_params.id == ndev->hci_dev->nfcee_id)
		ndev->hci_dev->conn_info = conn_info;

	conn_info->conn_id = rsp->conn_id;
	conn_info->max_pkt_payload_len = rsp->max_ctrl_pkt_payload_len;
	...
}

and the payload length on the other side is user controlled:
nfc_genl_se_io() takes NFC_ATTR_SE_APDU as NLA_BINARY with no maximum, and
st_nci_se_io() -> nci_hci_send_event() -> nci_hci_send_data() carries it
straight into the loop above.  nci_hci_cmd_received() also calls
nci_hci_send_data() directly from the rx work.

Would it make more sense to validate at the assignment sites
(nci_core_conn_create_rsp_packet() and nci_rf_intf_activated_ntf_packet()),
or to additionally fix the arithmetic in nci_hci_send_data()?  A plain
!= 0 test would still leave the max_pkt_payload_len == 1 underflow in place.

[Severity: High]
The new check reads conn_info->max_pkt_payload_len once, but the loop below
re-reads the same field on every iteration:

net/nfc/nci/data.c:nci_queue_tx_data_frags() {
	...
	while (total_len) {
		frag_len =
			min_t(int, total_len, conn_info->max_pkt_payload_len);
	...
}

The field is a plain __u8 with no READ_ONCE/WRITE_ONCE, no atomic and no
lock, and it is written from the rx workqueue with controller-supplied data
in nci_rf_intf_activated_ntf_packet() and nci_core_conn_create_rsp_packet().

The reader side is rawsock_tx_work -> nfc_data_exchange() -> nci_transceive()
-> nci_send_data() -> nci_queue_tx_data_frags(); the only lock it holds is
device_lock(&dev->dev), plus ndev->tx_q.lock after the loop.  The writer side
is nci_rx_work() -> nci_ntf_packet()/nci_rsp_packet() -> the assignments, and
neither takes device_lock.

CPU0 (rawsock_tx_work)                        CPU1 (nci_rx_work)
conn_info = nci_get_conn_info_by_conn_id()
if (!conn_info->max_pkt_payload_len)  /* nonzero, passes */
frag_len = min_t(int, total_len,
		 conn_info->max_pkt_payload_len);
                                              conn_info->max_pkt_payload_len = 0;
/* next iteration */
frag_len = 0 -> total_len never decreases

Can the store land between the check and a later re-read, leaving the loop in
exactly the unbounded nci_skb_alloc(GFP_ATOMIC) state the commit describes?

Would snapshotting the field into a local, e.g.

	u8 max_len = READ_ONCE(conn_info->max_pkt_payload_len);

and using that for both the validation and the min_t() close the window?

[Severity: High]
This isn't a bug introduced by this patch, but the conn_info pointer that the
new check dereferences has no lifetime guarantee.
nci_get_conn_info_by_conn_id() walks the list with no lock, no RCU and no
lockdep assertion:

net/nfc/nci/core.c:nci_get_conn_info_by_conn_id() {
	list_for_each_entry(conn_info, &ndev->conn_info_list, list) {
		if (conn_info->conn_id == conn_id)
			return conn_info;
	}

	return NULL;
}

while the rx work frees the same object immediately, with no grace period:

net/nfc/nci/rsp.c:nci_core_conn_close_rsp_packet() {
	if (status == NCI_STATUS_OK) {
		conn_info = nci_get_conn_info_by_conn_id(ndev,
							 ndev->cur_conn_id);
		if (conn_info) {
			list_del(&conn_info->list);
			if (conn_info == ndev->rf_conn_info)
				ndev->rf_conn_info = NULL;
			devm_kfree(&ndev->nfc_dev->dev, conn_info->dest_params);
			devm_kfree(&ndev->nfc_dev->dev, conn_info);
		}
	}
	...
}

nci_rsp_packet() dispatches CORE_CONN_CLOSE_RSP without checking that a
matching command was outstanding, and the tx path holds only
device_lock(&dev->dev), which the rx worker never takes.  Can an unsolicited
CORE_CONN_CLOSE_RSP with status OK for ndev->cur_conn_id free the conn_info
while nci_queue_tx_data_frags() is still reading
conn_info->max_pkt_payload_len, both in the new check and in the min_t() in
the loop?  The list walk itself can also follow a freed node's linkage.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260913101309.891633-1-liuc63%40xiaopeng.com
