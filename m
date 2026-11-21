Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.212
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795294384;
	b=ugZ+S5sZc65tmgGT3gWsWsoqpJj6lRBG/vRIj8i8Xk9EdQTykOcvY3qkyS/6A92AwDlA
	 ELISRfTxQF2CfXP5GyL79iwuGO9cFMsHXcuwlM2UFudz4byqm+yWuU6y5yVLSE/+MpNHr
	 Rl29/8SLnGpnhxLtNOfDGNyz4LKK30HjIuV/SuTHzo/hG4sBYwfuMLfD89RgRuwczK60Y
	 ucP7AR9f0Di97GHLFhOlYWA2HyM2wbNyoafhRCrrjaz5xHLNnhkDpKLLtFVUCIBxnNkZP
	 SPB2P4e/O1hQ+uemgwaTaEnOzw51/7LY1KbYyyjTOgJ+hiSZ/1d7BhjhZAKNvSVm2aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795294384;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=cC872EySsMC8eMJI+Qe7C5GebioHolwF5sIbQy0Rd28=;
	b=dI9Pb382klI8OYqI9c792QQu2rq8L8TUlvfq39Ls+WJg71PwoGHrmJRDmIuBrG2ASDnr
	 v3HCA0OPY8FuVblMonKJpadmBqgpVFiNKLUv/IFQRY0qCm2VqMHcCR0zpwkDhYhgCMWhl
	 HQC/jwMQ8XEa5lDRRq4dkovZGjph/DoHpJXQl6kqYQ1pPB/rJLJF3UsayWRn7AnUVSQoa
	 KG+m2Kxbix0cuUAM7zXv3vn6mXRUw2t/7hpfGEC9tgQvqI096Z5eLXpgV9rXEXbVk+PRl
	 O4VhgBku2HAWuQDe5rsMNgVvR79DTrfPOvH2FmFfY32bOiLLP2hm+kqUF20tl44tdWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=N9iG+ZGZ;
	arc=none smtp.remote-ip=95.215.58.212
Received: from mta1.migadu.com (out-212.mta1.migadu.com [95.215.58.212])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBC3606A32C
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 20:53:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EBC3606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=N9iG+ZGZ
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=fTypxto2RUCo6/a5JpNf0L5VcBFjct/hjtzGvcTcedo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795294381; v=1; x=1795899181;
 b=N9iG+ZGZKWBhrj0qAGkiVJ8lnPVDTgkN+VlyoY2WfbqO/laH+7mP0TGlHrHlu6FHnwygbMI8
 /Ca9/2pyxrIKYhhphkCbqs4gj9+nvilfAJU5UE+03G6Tyy02E5CviJA6G30e72YbKKJ/1MWVtRY
 QOC86GJNVfngPZnXktSEdDhI=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a173131b567a5674;
	Sat, 21 Nov 2026 20:53:01 +0000
X-Mizu-Trace-ID: a173131b567a5674
X-Migadu-Flow: FLOW_OUT
Message-ID: <6f390b6c-b0d6-4b37-929b-a426282556b7@linux.dev>
Date: Sat, 21 Nov 2026 12:52:54 -0800
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
 "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
Cc: Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261113230831.2682071-1-mkhalfella@purestorage.com>
 <e432178a-6e73-4096-9f59-5c5d2bc9d682@linux.dev>
 <20261115173618.GD34016-mkhalfella@purestorage.com>
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20261115173618.GD34016-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/11/15 9:36, Mohamed Khalfella 写道:
> On Sat 2026-11-14 11:05:39 -0800, Zhu Yanjun wrote:
>> 在 2026/11/13 15:08, Mohamed Khalfella 写道:
>>> Local operations (IB_WR_REG_MR, IB_WR_LOCAL_INV, IB_WR_BIND_MW) are
>>> executed inline by rxe_requester() through rxe_do_local_ops(), which
>>> marks the wqe wqe_state_done and advances qp->req.wqe_index past it.
>>> Unlike wire operations, nothing is posted to the network and no ack is
>>> expected.
>>>
>>> The completer only consumes wqes from the head of the send queue, in
>>> order. A done local op wqe therefore stays in the queue until every
>>> older wqe has completed, so it can sit behind a SEND or RDMA WRITE that
>>> is still waiting for an ack. With nvme-rdma, which posts REG_MR + SEND
>>> for every I/O, the queue regularly looks like:
>>>
>>>     SEND(A) pending, REG_MR(B) done, SEND(B) pending, REG_MR(C) done ...
>>>
>>> When a retransmit timeout fires or a NAK arrives, req_retry() rewinds
>>> qp->req.wqe_index to the consumer so that every unacked wqe is resent.
>>> Its loop skips wqe_state_done entries when resetting DMA state, but
>>> rxe_requester() itself has no such check. After the rewind it walks
>>> forward through the queue, reaches REG_MR(B), sees WR_LOCAL_OP_MASK and
>>> calls rxe_do_local_ops() on it a second time.
>>>
>>> rxe_reg_fast_mr() rejects the repeated registration because the MR is
>>> already RXE_MR_STATE_VALID, not FREE. The wqe is given
>>> IB_WC_LOC_QP_OP_ERR and the QP is moved to the error state. The
>>> completer then flushes the entire send queue with IB_WC_WR_FLUSH_ERR,
>>> including the wqe that failed, so the consumer never sees the real
>>> error status. nvme-rdma logs only "SEND ... failed with status WR
>>> flushed (5)" and tears down the controller.
>>>
>>> Any packet loss that triggers a retry while a later request is queued
>>> is enough to hit this. On a soft-RoCE setup with a few hundred lost
>>> frames per run every controller reconnect traced back to the same
>>> rxe_dbg_mr() line:
>>>
>>>     rxe1: mr#776 rxe_reg_fast_mr:  mr->lkey = 0x3084c not free
>>>
>>> Skip local op wqes that are already done when the requester reaches
>>> them again after a rewind. Advance wqe_index past them exactly as a
>>> successful execution would and continue with the next wqe. The MR keeps
>>> its registered state and the completer still reports the wqe in order
>>> with its original status. Only local ops can be in wqe_state_done ahead
>>> of the consumer on an RC QP, since wire operations stay pending until
>>> acked, so the check cannot match anything else.
>>>
>>> Fixes: 001345339f4c ("RDMA/rxe: Separate HW and SW l/rkeys")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
>>> ---
>>>    drivers/infiniband/sw/rxe/rxe_req.c | 14 ++++++++++++++
>>>    1 file changed, 14 insertions(+)
>>>
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
>>> index 4f353abd76f5..fdb55366d668 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_req.c
>>> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
>>> @@ -723,6 +723,20 @@ int rxe_requester(struct rxe_qp *qp)
>>>    		goto err;
>>>    	}
>>>    
>>> +	/*
>>> +	 * A retry rewinds wqe_index to the send queue consumer. Local
>>> +	 * operations that were already executed may still sit in the
>>> +	 * queue behind an unacked wqe waiting for in-order completion.
>>> +	 * Re-executing them fails (e.g. REG_MR on an MR that is no
>>> +	 * longer free) and would move the QP to the error state, so
>>> +	 * skip them instead.
>>> +	 */
>>> +	if ((wqe->mask & WR_LOCAL_OP_MASK) &&
>>> +	    wqe->state == wqe_state_done) {
>>> +		qp->req.wqe_index = queue_next_index(q, qp->req.wqe_index);
>>> +		goto done;
>>> +	}
>> I understand the need for this check to prevent already-completed local
>> operations from
>>
>> being re-executed after a retry rewinds the WQE index.
>>
>> However, this check is currently placed in the common `rxe_requester()`
>> path, so it is evaluated
>>
>> for every WQE, including normal SEND and RDMA WRITE operations.
>>
>> Since this condition is only relevant when a retry causes the requester
>> to revisit an already-completed
>>
>> local operation, it is expected to be very rare in the normal execution
>> path.
>>
>> Could we move this check into the existing `WR_LOCAL_OP_MASK` handling
>> path, or at least mark
>>
>> the condition with `unlikely()`?
>>
>> I would prefer moving it into the local operation handling path, if the
>> control flow allows it, so that normal wire
>>
>> operations do not pay the cost of an additional state check.
>>
>> This would keep the fix while minimizing its impact on the common fast path.
> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
> index 12d03f390b09..8bd1f9b1ce06 100644
> --- a/drivers/infiniband/sw/rxe/rxe_req.c
> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> @@ -707,6 +707,13 @@ int rxe_requester(struct rxe_qp *qp)
>   	}
>   
>   	if (wqe->mask & WR_LOCAL_OP_MASK) {
> +		/* Retry rewinds wqe_index, skip it if already done */
> +		if (unlikely(wqe->state == wqe_state_done)) {
> +			qp->req.wqe_index = queue_next_index(q,
> +						qp->req.wqe_index);
> +			goto done;
> +		}
> +
>   		err = rxe_do_local_ops(qp, wqe);
>   		if (unlikely(err))
>   			goto err;
>
> Does something like the diff above work?
>
> Also, sashiko marked a high severity issue [1] in this version of the
> patch. I am not familiar with this codebase enough to know if this is a
> real issue introduced by this change or not.
>
> Is the issue reported by sashiko real?
> If yes, is it introduced by this patch?
Hi Mohamed,

I reviewed sashiko-bot's comments and agree they are valid.

Please update the patch accordingly:

Consumer index overtaking wqe_index: Consider looping/batch-advancing

qp->req.wqe_index past consecutive completed local ops so rxe_completer()

cannot overtake it after a retry.

Fence & IB_QPS_SQD stall/deadlock: Check send queue boundaries and

concurrency/state ordering around req_next_wqe() and fence checks so

completed local ops are skipped before those checks block or deadlock.

And please do not add overhead in the fast path since this will make bad

difference on the whole system's performance.


Thanks,
Yanjun Zhu
>
> 1- https://lore.kernel.org/all/sashiko-outbox-213867@kernel.org/
>
> Thanks,
> Mohamed Khalfella

-- 
Best Regards,
Yanjun.Zhu

