Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8033CC334;
	Mon, 28 Sep 2026 10:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790592496; cv=none; b=U7In8aDwaKXAui7K5P0fcvHbx/tDzsXBr0k8nxeGKJQPYKzeg6WbOeaBrF1cRTVfCLqf6HSVtkPXgEhVBWVpmbK0BEo2vM8f7J2Z+8n/Vjr/osDCMuwj5Uw4SHpbunU9kqxSbbQICMyZtrk/pWQcGerJaB0flpra8+hBhM6IE8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790592496; c=relaxed/simple;
	bh=+Bz5ZeKI9p9R4K5LDmd15LdmSkiP+x186YnkCdjn8kQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7iGv8Tgls5lsFZTK6aW4P/ED6TEMqb8NcumSsCdXbVow918otaOiuhrFhSwfjkAqROaIDl38Jk/MMSyMvGXNfLZUW7utbbzdaxUjc41wlWYykaAYcUDUxDhSJzZg9Vcz2NfAmpZ/e5ndZ7Mu0J4BGSmWBkjUKdN+BC4wdLhqAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aaYuW3r7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aaYuW3r7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F9E1F00893;
	Mon, 28 Sep 2026 10:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790592494;
	bh=o0g1CTOhWsATgMjJJ9x3ioR0OzxIZWhzc5jdJqF125k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aaYuW3r7P81i1FZlPVggltd7iVCSBNe48IAgpPH3sq6vWALUuZ3HdfvzPlKVbAKL1
	 yZxhZPFBJm3JaF7lhvHDuFXihH5qPS42+gpQd9pVQxMnVwgWKaSAm9H6BVTXlPf6G1
	 eweXZdXJSQelEK8epp7QmdhAhlzMqUbit6LH+7b55U0VFdqEbtM1d8rUwEAkiESSWB
	 Xzgt1johJzWOECXLdUTR7sQgrDF7kwASnNcUueE1mAOC7ktUhZRO7iTwJT23Lv8UBF
	 s2HS1xiqTitu6/ScNRbl1f8ukLMpf2VmujI5LNvGqusvrG6ln41tVO9efPQqp5/ynP
	 FAIMHHgYIbVTw==
Date: Mon, 28 Sep 2026 11:48:09 +0100
From: Simon Horman <horms@kernel.org>
To: Liu Chao <liuc63@xiaopeng.com>
Cc: netdev@vger.kernel.org, david@ixit.cz, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	oe-linux-nfc@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v3] nfc: nci: avoid unbounded skb allocation when
 max_pkt_payload_len is zero
Message-ID: <20260928104809.GQ13925@horms.kernel.org>
References: <20260927115940.3817019-1-liuc63@xiaopeng.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927115940.3817019-1-liuc63@xiaopeng.com>

On Sun, Sep 27, 2026 at 07:59:40PM +0800, Liu Chao wrote:
> nci_queue_tx_data_frags() uses conn_info->max_pkt_payload_len as the
> fragment size.  When that value is zero, frag_len is always zero and
> total_len never decreases.  The loop then allocates skbs without bound:
> none of them are freed inside the loop, they accumulate on frags_q, and
> there is no cond_resched() in the loop body.  A single sendmsg() can
> therefore consume all allocatable memory, and on CONFIG_PREEMPT_NONE it
> occupies the CPU long enough to trip the softlockup watchdog:
> 
>   watchdog: BUG: soft lockup - CPU#3 stuck for 26s! [kworker/3:1:57]
>   Workqueue: events rawsock_tx_work [nfc]
>   Call Trace:
>    nci_send_data+0x1ca/0x6b0 [nci]
>    nci_transceive+0xbb/0x170 [nci]
>    rawsock_tx_work+0xb5/0x1a0 [nfc]
> 
> max_pkt_payload_len comes straight from controller-supplied fields with
> no check for zero, and it is read several times along the TX path while
> the rx workqueue can update it without any lock held against this path.
> 
> Take a single READ_ONCE() snapshot of the limit in nci_send_data(),
> reject a zero limit there, and pass the snapshot down to
> nci_queue_tx_data_frags().  The fragmentation decision and the
> fragmentation loop then consume the same value, so the loop cannot spin
> on a limit that differs from the one just validated, and no plain read
> of the field is left in nci_send_data() or nci_queue_tx_data_frags().
> 
> Rejecting the zero limit at the entry of the TX data path covers the RF
> connection as well: ndev->rf_conn_info is allocated with devm_kzalloc(),
> so its max_pkt_payload_len is zero from the moment the object exists and
> only becomes usable when an activation notification assigns a
> controller-supplied value.  Checking where the value is consumed catches
> every producer of a zero limit -- the initial state, the notification,
> and any future writer.
> 
> The two producers of the field are annotated with WRITE_ONCE() to match
> the snapshot read; the remaining plain accesses on the HCI path are
> untouched here, since nci_hci_send_data() loops over a different
> conn_info instance (ndev->hci_dev->conn_info) and needs its own fix,
> which is sent separately.
> 
> The "failed to fragment tx data packet" print sits on a data path driven
> by controller/remote data and can fire on every transmit once
> fragmentation keeps failing.  Rate-limit it so a misbehaving controller
> cannot flood the log.  Note that with the zero-limit rejection moved into
> nci_send_data(), a rejected zero limit returns before this print, so the
> per-sendmsg flood does not occur through that path.
> 
> No legitimate configuration is affected: where the NCI spec does mandate
> a zero Max Data Packet Payload Size -- the NFCEE Direct RF Interface --
> nci_rf_intf_activated_ntf_packet() takes the "goto listen" shortcut,
> bypassing the assignment entirely.
> 
> While at it, drop the conn_info lookup in nci_queue_tx_data_frags():
> the caller has already validated the connection, the function now takes
> everything it needs as arguments, and the lookup was the only use of
> conn_info left in it.
> 
> Fixes: 6a2968aaf50c ("NFC: basic NCI protocol implementation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
> ---
> Changes in v3:
>   - Snapshot max_pkt_payload_len once in nci_send_data() with
>     READ_ONCE() and pass it down to nci_queue_tx_data_frags(), as
>     suggested by Simon Horman, so the fragmentation decision and the
>     fragmentation loop consume the same value and no plain read of the
>     field remains on this path (review:
>     https://lore.kernel.org/netdev/20260925155040.GP13925@horms.kernel.org/)
>   - Move the zero-limit rejection from nci_queue_tx_data_frags() into
>     nci_send_data(), so the check runs on the same snapshot the loop
>     consumes; this also means a rejected zero limit returns before the
>     "failed to fragment" print rather than triggering it per sendmsg
>   - Annotate the two producers of the field (RF activation NTF and
>     CORE_CONN_CREATE_RSP) with WRITE_ONCE() to match the snapshot read
>   - Drop the now-redundant conn_info lookup in nci_queue_tx_data_frags();
>     the caller already validated the connection
>   - Rate-limit the "failed to fragment tx data packet" print, which sits
>     on a data path driven by remote data, as discussed in the review of
>     the v2 series
>   - Keep the v1/v2 subject so the revision is tracked as the same fix
> 
> Changes in v2:
>   - READ_ONCE() snapshot of max_pkt_payload_len in
>     nci_queue_tx_data_frags(): with the check and the loop reading the
>     field independently, a store from the rx workqueue in between
>     could let the loop spin on a value the check had just rejected

Thanks for the updates.

Reviewed-by: Simon Horman <horms@kernel.org>

