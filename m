Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.249
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794683151;
	b=iyrHunIKAnY8eHFVm3gqqyVTtgIjrfj5yaJTt9mDVAGLeUrCVXxP6u6jN08++KGXOgwU
	 E1xoI5HSm/V1Y33gugp/ICOv1lDmnR7SDo7iCW8Fxd5bvYM3PipzCTZQ1BoLZEH+gFw/D
	 /J0zlbRuULjMakkui4d9FBGzUtBC8kcxceGxx/BikDTKFVDTV9g9w413/63U6o0TWx5jb
	 fpAAIZc04AobrgNrWp7mrLgB8E3EkU4hspU1OBOePZGnm5ld0jyKFez3UtLg91iaaNEIg
	 MEbPiW7B2f/ZAyJRnFX8qtYqWjEPWKKWGQYhwNOAKbcXHmMMZ9EHyZS/X9K6jJZBsUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794683151;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=e7GiEdV+M4w33yXVYVq40C8MJ64RngQUxjIK2ouCYGk=;
	b=y/fLsPoPX4QnX3GnXOR84yNZdfySXgRBXcZN7lmdGFYfPCKLeMZiL5bnPm19SPT0J61u
	 4p+v4NcGPzK6PFKyh+orJ0U33w5k9tC9yPOLO0tx4EEYc46z/qrzz2r8OZeJF8IjqThyw
	 3EKGBfGIVwG4TOqOSP7swvCexJBHq4H5QrCg9mPNNLjHISEFewL1L3iaa2V87wK/gICux
	 liao4CQC/kNTuSkXx45TFjVb9qP4FJPL5Nnza47z0doLlxnsMEZVv5P2jvp7RqrHGRhtt
	 b+oHipphqDGMq6Ee/epvPu4HNvyii9mrrEj8w+bSGaGp1iWFG3ObkoFBpSyM03Ewopw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=bZrpjGce;
	arc=none smtp.remote-ip=95.215.58.249
Received: from mta1.migadu.com (out-249.mta1.migadu.com [95.215.58.249])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0D3606A332
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 19:05:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E0D3606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=bZrpjGce
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=6Lbt2fLwe0vyCFAL3T0HWQHDAyyClHtPtKKASVzf5Oo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794683147; v=1; x=1795287947;
 b=bZrpjGceXtb+LOnuMBd0iwDlUQkjwmNZZGDXuqnSoNG6yuhIWra8xVH9saKlIy9o2RbHRfCj
 DZEgrRVGcgPYX7FfXntBQZ9U1ygMIYTHRPTwKwrraj3VFSXHaTGuwtTpIYiGNArdHk06AMaoqm1
 A8cKnMiupq70BWYOmNemxUaA=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4775a52cce20f54a;
	Sat, 14 Nov 2026 19:05:45 +0000
X-Mizu-Trace-ID: 4775a52cce20f54a
X-Migadu-Flow: FLOW_OUT
Message-ID: <e432178a-6e73-4096-9f59-5c5d2bc9d682@linux.dev>
Date: Sat, 14 Nov 2026 11:05:39 -0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/rxe: Do not re-execute completed local ops after a
 retry
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Zhu Yanjun <zyjzyj2000@gmail.com>,
 "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261113230831.2682071-1-mkhalfella@purestorage.com>
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20261113230831.2682071-1-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/11/13 15:08, Mohamed Khalfella 写道:
> Local operations (IB_WR_REG_MR, IB_WR_LOCAL_INV, IB_WR_BIND_MW) are
> executed inline by rxe_requester() through rxe_do_local_ops(), which
> marks the wqe wqe_state_done and advances qp->req.wqe_index past it.
> Unlike wire operations, nothing is posted to the network and no ack is
> expected.
>
> The completer only consumes wqes from the head of the send queue, in
> order. A done local op wqe therefore stays in the queue until every
> older wqe has completed, so it can sit behind a SEND or RDMA WRITE that
> is still waiting for an ack. With nvme-rdma, which posts REG_MR + SEND
> for every I/O, the queue regularly looks like:
>
>    SEND(A) pending, REG_MR(B) done, SEND(B) pending, REG_MR(C) done ...
>
> When a retransmit timeout fires or a NAK arrives, req_retry() rewinds
> qp->req.wqe_index to the consumer so that every unacked wqe is resent.
> Its loop skips wqe_state_done entries when resetting DMA state, but
> rxe_requester() itself has no such check. After the rewind it walks
> forward through the queue, reaches REG_MR(B), sees WR_LOCAL_OP_MASK and
> calls rxe_do_local_ops() on it a second time.
>
> rxe_reg_fast_mr() rejects the repeated registration because the MR is
> already RXE_MR_STATE_VALID, not FREE. The wqe is given
> IB_WC_LOC_QP_OP_ERR and the QP is moved to the error state. The
> completer then flushes the entire send queue with IB_WC_WR_FLUSH_ERR,
> including the wqe that failed, so the consumer never sees the real
> error status. nvme-rdma logs only "SEND ... failed with status WR
> flushed (5)" and tears down the controller.
>
> Any packet loss that triggers a retry while a later request is queued
> is enough to hit this. On a soft-RoCE setup with a few hundred lost
> frames per run every controller reconnect traced back to the same
> rxe_dbg_mr() line:
>
>    rxe1: mr#776 rxe_reg_fast_mr:  mr->lkey = 0x3084c not free
>
> Skip local op wqes that are already done when the requester reaches
> them again after a rewind. Advance wqe_index past them exactly as a
> successful execution would and continue with the next wqe. The MR keeps
> its registered state and the completer still reports the wqe in order
> with its original status. Only local ops can be in wqe_state_done ahead
> of the consumer on an RC QP, since wire operations stay pending until
> acked, so the check cannot match anything else.
>
> Fixes: 001345339f4c ("RDMA/rxe: Separate HW and SW l/rkeys")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_req.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
> index 4f353abd76f5..fdb55366d668 100644
> --- a/drivers/infiniband/sw/rxe/rxe_req.c
> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> @@ -723,6 +723,20 @@ int rxe_requester(struct rxe_qp *qp)
>   		goto err;
>   	}
>   
> +	/*
> +	 * A retry rewinds wqe_index to the send queue consumer. Local
> +	 * operations that were already executed may still sit in the
> +	 * queue behind an unacked wqe waiting for in-order completion.
> +	 * Re-executing them fails (e.g. REG_MR on an MR that is no
> +	 * longer free) and would move the QP to the error state, so
> +	 * skip them instead.
> +	 */
> +	if ((wqe->mask & WR_LOCAL_OP_MASK) &&
> +	    wqe->state == wqe_state_done) {
> +		qp->req.wqe_index = queue_next_index(q, qp->req.wqe_index);
> +		goto done;
> +	}

I understand the need for this check to prevent already-completed local 
operations from

being re-executed after a retry rewinds the WQE index.

However, this check is currently placed in the common `rxe_requester()` 
path, so it is evaluated

for every WQE, including normal SEND and RDMA WRITE operations.

Since this condition is only relevant when a retry causes the requester 
to revisit an already-completed

local operation, it is expected to be very rare in the normal execution 
path.

Could we move this check into the existing `WR_LOCAL_OP_MASK` handling 
path, or at least mark

the condition with `unlikely()`?

I would prefer moving it into the local operation handling path, if the 
control flow allows it, so that normal wire

operations do not pay the cost of an additional state check.

This would keep the fix while minimizing its impact on the common fast path.

Thanks a lot.

Yanjun.Zhu

> +
>   	if (rxe_wqe_is_fenced(qp, wqe)) {
>   		qp->req.wait_fence = 1;
>   		goto exit;

-- 
Best Regards,
Yanjun.Zhu

