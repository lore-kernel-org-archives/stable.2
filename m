Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794764190;
	b=oyhK65VE5Yn/QtMy276m2TwQ2TPlP811YO5sWPgS8jHqWYBz9iGE6YnjiTolvo+JZwKo
	 8/w5GdMpjjHaANRIhR14nzDkKGufwe4Avk1lVXDQhcb68fwDwGUg6xQpgDf+iZZzhwEnI
	 xdKLLnOyiK6USSr/BU51qVSj6MncLUPWHmSp3BF0NURe0/3gZ8bNPfsDxLVgBPCkzQ/Z9
	 l0FFXrQxs394TzFz/G+tk/qvjl6iX8K1H8d6GH+2rgEUkv/ggwHP5u4oFTYJjWdlE8M0E
	 GLFv5h9kZRAr8gwtim6D4Nc+iVPQUEazuFTAS1IhHVT79XYNJhkDgZVBaTGh49adN7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794764190;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=GRWYSuLQP9sZfKWWqP+UL8TabCKmkxKc6qkoZFoAHOo=;
	b=emqSvV4pg1jbsOBn0x8Qg9GFgixJ+iQjfY+c04QHXJ6MbW/V5RvaDq/egar4Bch6AdH4
	 yorKJ24ukcbHu1YdyWIYa2Nsea0ysYR2DA7/OSRYBu/aCVvIanJ7rG9SBjaNQ5JtBQ5y5
	 PnXCEjxZ8x5d7Lz0hMCOFmMq3+LFVMqn6gdgd84Ckx94/NRLCFrVVCdeb84yWL/Ptb1+6
	 CYBWEpldjcPCIG+2oK0dj5vNOH5yS+NQ/1CKQ68/zgMZJjq5pbAM+Y2m18g3CPwVt1LKq
	 +4y4DhcFfI/JASm5GC6xYByswXpuv9Od5cqNbYRc7OmhTO97jYEGWASnbVjU2ku0lfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=Ut76e44E;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F1F606A31D
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 17:36:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94F1F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=Ut76e44E
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso2225054eec.0
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 09:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1794764188; x=1795368988; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GRWYSuLQP9sZfKWWqP+UL8TabCKmkxKc6qkoZFoAHOo=;
        b=Ut76e44Eer+SVkzm7j6VbbdgAJUYEtAvHPQkRWwmhc8sTzHTEX2gX9c8INz0D3UkTZ
         c5Q8nQf/Ja72N6pQ86DzQVnTj7X9LvwZf/XCdcLhHU9cldDr65Uuqd+XNN2qCKkJd+tQ
         Gaf0IGiVv3s+DiUjMKfKgvGIFS/EYzaldtN5cACuzLuYRIse2xyhxfiY6mUSuQAaohM/
         6LbmQmF7zIL3DEh/wKcmfNrxcCEs2LG+fMzejSLo5cjQ01LLrGBeO11vcy9Q5loUR4q9
         j2x+QU/H9bYI7aQH6Ns7oqnPpudKbrq0uK7bpL9fHm9EI+HBMMzh/LX9Hk8/odxHIohu
         z3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794764188; x=1795368988;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GRWYSuLQP9sZfKWWqP+UL8TabCKmkxKc6qkoZFoAHOo=;
        b=BYa6y5kLDtgvj6RLNd2k5kC73Ftc7QgVFTb7ocU6ElaGts1SnF09dEmRpeMHLwr6yx
         mtl2fLf6nxL2D0IKXp8O7TOYt8a59MY3d1t3LRLQP1/MYbJ/uSHu5cOh3GRsnL9K10yh
         pa6giaawUpk7eVfElMH5NmOTq+7Ice79rW/i4UdwkRbmvzGNlqHmnZjBg9N5MSzcPk3u
         g9d2n0UgCAxp1KzOGeGtRyNg5ZKrCoOnbilyTASJYz8zrL/6TWbuKXTr6rlLQe73dDpL
         vLcTkrNPZY1pRfalbn/t+obcu2y0HVuykcQy6wTICL/yfoEvQKrXptfixi0iiwZCcWZF
         OSsg==
X-Forwarded-Encrypted: i=1; AL+hErG/v5jNeFrRD8eDh64S+xxIinmH3HeN9DOr58exUj/9Wq1h0JzHaDtsPt82tjSDi3lyycm3t2Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z8x0S5lgT4BaCZPRvGcedeDYwvIZoJP1mekkqo+7A+mueSKCUnn
	QWBlPKhhmrNjRaZW7R5sPxLHdQC+BYT7/CtTaE9aO4ihGVhB/kAPY0McM1vAXzPP7Yk=
X-Gm-Gg: AYBFou2PNiKqXScMYF9Cprq7oP7Uy9xj18KkaMqqJTkzWQt9hDuYviOr+mabTCWowlZ
	i3HQRNrvX0mgKv9CPM5/JcH8df33Rp85vQiEyfZYaErNEIsjPWTTPjA+S0yE2KXn4acVN5fqgZJ
	WIoJy8rD9i4bvqFWbWZr+0+A9ks/bVEZ1Kpr2O/H6FbrGmyCQPvvxWsVgeV4andtcIMxmbvybjS
	4OMbQ1Pa5IL9PfXhD22y2hEn7frShhKtO0vf1cGZGoQBrZT7Y7XiwKIXgHR2stvVuarEmXbSVVg
	QCnsucD6GIWha4EJ/kQ030h7HrxtFtpqnv6p4af6cDzoXu5M2aqp6YwACCseuudfoHfABtyw1WC
	0ErKcRoY7OyXLLhg29JZ0jJBfufFJmhTAId4ELzHNBK38IQtWpobozmOC2NBAIR0QqPHn5K9O4k
	E+o6wsgp4odFRTikK4KJFhl32SztAq7cmA9qJuwEjeNVPj/D01M8rRYY82oGypWuCask8dY4t53
	rjvzDwyEhqpu4h/B60E7Th0uLlbR5o0as0L3sFm9EalJAXgAlDI0K9OZz0+FOVm9Ylw7gu+0b3M
	bxlYFSKAoJ/b40IqsRYXFhrL0rTEJswGc+Bup/ER2OvDc57SJYdAxkKQ+t8=
X-Received: by 2002:a05:7301:2024:b0:36a:18e2:64c with SMTP id 5a478bee46e88-379655d3d12mr9319544eec.11.1794764187185;
        Sun, 15 Nov 2026 09:36:27 -0800 (PST)
Received: from medusa.lab.kspace.sh ([2607:fb90:9c20:35a5::cb18])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-379560f5e06sm35343144eec.19.2026.11.15.09.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 09:36:26 -0800 (PST)
Date: Sun, 15 Nov 2026 09:36:18 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] RDMA/rxe: Do not re-execute completed local ops after a
 retry
Message-ID: <20261115173618.GD34016-mkhalfella@purestorage.com>
References: <20261113230831.2682071-1-mkhalfella@purestorage.com>
 <e432178a-6e73-4096-9f59-5c5d2bc9d682@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e432178a-6e73-4096-9f59-5c5d2bc9d682@linux.dev>

On Sat 2026-11-14 11:05:39 -0800, Zhu Yanjun wrote:
> 
> 在 2026/11/13 15:08, Mohamed Khalfella 写道:
> > Local operations (IB_WR_REG_MR, IB_WR_LOCAL_INV, IB_WR_BIND_MW) are
> > executed inline by rxe_requester() through rxe_do_local_ops(), which
> > marks the wqe wqe_state_done and advances qp->req.wqe_index past it.
> > Unlike wire operations, nothing is posted to the network and no ack is
> > expected.
> >
> > The completer only consumes wqes from the head of the send queue, in
> > order. A done local op wqe therefore stays in the queue until every
> > older wqe has completed, so it can sit behind a SEND or RDMA WRITE that
> > is still waiting for an ack. With nvme-rdma, which posts REG_MR + SEND
> > for every I/O, the queue regularly looks like:
> >
> >    SEND(A) pending, REG_MR(B) done, SEND(B) pending, REG_MR(C) done ...
> >
> > When a retransmit timeout fires or a NAK arrives, req_retry() rewinds
> > qp->req.wqe_index to the consumer so that every unacked wqe is resent.
> > Its loop skips wqe_state_done entries when resetting DMA state, but
> > rxe_requester() itself has no such check. After the rewind it walks
> > forward through the queue, reaches REG_MR(B), sees WR_LOCAL_OP_MASK and
> > calls rxe_do_local_ops() on it a second time.
> >
> > rxe_reg_fast_mr() rejects the repeated registration because the MR is
> > already RXE_MR_STATE_VALID, not FREE. The wqe is given
> > IB_WC_LOC_QP_OP_ERR and the QP is moved to the error state. The
> > completer then flushes the entire send queue with IB_WC_WR_FLUSH_ERR,
> > including the wqe that failed, so the consumer never sees the real
> > error status. nvme-rdma logs only "SEND ... failed with status WR
> > flushed (5)" and tears down the controller.
> >
> > Any packet loss that triggers a retry while a later request is queued
> > is enough to hit this. On a soft-RoCE setup with a few hundred lost
> > frames per run every controller reconnect traced back to the same
> > rxe_dbg_mr() line:
> >
> >    rxe1: mr#776 rxe_reg_fast_mr:  mr->lkey = 0x3084c not free
> >
> > Skip local op wqes that are already done when the requester reaches
> > them again after a rewind. Advance wqe_index past them exactly as a
> > successful execution would and continue with the next wqe. The MR keeps
> > its registered state and the completer still reports the wqe in order
> > with its original status. Only local ops can be in wqe_state_done ahead
> > of the consumer on an RC QP, since wire operations stay pending until
> > acked, so the check cannot match anything else.
> >
> > Fixes: 001345339f4c ("RDMA/rxe: Separate HW and SW l/rkeys")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> > ---
> >   drivers/infiniband/sw/rxe/rxe_req.c | 14 ++++++++++++++
> >   1 file changed, 14 insertions(+)
> >
> > diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
> > index 4f353abd76f5..fdb55366d668 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_req.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> > @@ -723,6 +723,20 @@ int rxe_requester(struct rxe_qp *qp)
> >   		goto err;
> >   	}
> >   
> > +	/*
> > +	 * A retry rewinds wqe_index to the send queue consumer. Local
> > +	 * operations that were already executed may still sit in the
> > +	 * queue behind an unacked wqe waiting for in-order completion.
> > +	 * Re-executing them fails (e.g. REG_MR on an MR that is no
> > +	 * longer free) and would move the QP to the error state, so
> > +	 * skip them instead.
> > +	 */
> > +	if ((wqe->mask & WR_LOCAL_OP_MASK) &&
> > +	    wqe->state == wqe_state_done) {
> > +		qp->req.wqe_index = queue_next_index(q, qp->req.wqe_index);
> > +		goto done;
> > +	}
> 
> I understand the need for this check to prevent already-completed local 
> operations from
> 
> being re-executed after a retry rewinds the WQE index.
> 
> However, this check is currently placed in the common `rxe_requester()` 
> path, so it is evaluated
> 
> for every WQE, including normal SEND and RDMA WRITE operations.
> 
> Since this condition is only relevant when a retry causes the requester 
> to revisit an already-completed
> 
> local operation, it is expected to be very rare in the normal execution 
> path.
> 
> Could we move this check into the existing `WR_LOCAL_OP_MASK` handling 
> path, or at least mark
> 
> the condition with `unlikely()`?
> 
> I would prefer moving it into the local operation handling path, if the 
> control flow allows it, so that normal wire
> 
> operations do not pay the cost of an additional state check.
> 
> This would keep the fix while minimizing its impact on the common fast path.

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 12d03f390b09..8bd1f9b1ce06 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -707,6 +707,13 @@ int rxe_requester(struct rxe_qp *qp)
 	}
 
 	if (wqe->mask & WR_LOCAL_OP_MASK) {
+		/* Retry rewinds wqe_index, skip it if already done */
+		if (unlikely(wqe->state == wqe_state_done)) {
+			qp->req.wqe_index = queue_next_index(q,
+						qp->req.wqe_index);
+			goto done;
+		}
+
 		err = rxe_do_local_ops(qp, wqe);
 		if (unlikely(err))
 			goto err;

Does something like the diff above work?

Also, sashiko marked a high severity issue [1] in this version of the
patch. I am not familiar with this codebase enough to know if this is a
real issue introduced by this change or not.

Is the issue reported by sashiko real?
If yes, is it introduced by this patch?

1- https://lore.kernel.org/all/sashiko-outbox-213867@kernel.org/

Thanks,
Mohamed Khalfella
