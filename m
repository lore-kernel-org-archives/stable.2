Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328042;
	b=j2/R1d6+ssfwENt8c7Uoid94lHfWhO1kH7zjAdeUEw3Hsh+eNdMDDI5DmWziNczUrHoO
	 68MmVwU3YY0v4xg72LrTuNK9ZbUUzttE/ii4hD4w43zT0XTarzTOkLgA4c2snX88SmQMp
	 S4LzNvepu7YRlCipQBiVjPdHJcAdMPxluAuyOPFtqLeQWz2cm+/ndF/n5gbhw3MBSgRKU
	 o0t+7BtWOJinIyhXVtNXpFj0rDw/mh8g7xgY87gMiMMTPOhISbjKPOy5ermn2A9U17w6Z
	 AJiggtN+BqHF8Ln7mAlUKPugVYjyy3T+BEHsl7IOz8Ys5FBcUDqobUINxrM5RNI2shw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328042;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vK4LWpRDwU7vNhS6EBeO98N4nUu+oxzJNpxEVGaHkMk=;
	b=Lq+KzDwqTrRNhZjnnLYp67Ewvxfi2ZaJZzvCIp1Ba2FpHPBtph6DOMEMBafRv1HKnsP2
	 njcpS2bbOMRU5uq1b6G3cirbQu0Aqhqei40ZLFMFqQ4FWTs0+bkv/ierNadcgU+d2ogcg
	 dxWql0ieOcFVU//ZUk5m65Do3+2bj9LF0SUaPTdvfIEo/z42hRiTW1uHAXjq+tVVmW/Qa
	 uOuxS3nrQ118/lZ7xGUVnc4s3C/0ftsnVsgRP9rjZl6/CkQjBKgVjk57XLI+FXjINSbyK
	 4cAMeSCUqs8cRqC3oT/ftshqaHs7fQcA0aQMke4R5uJf++uXGoqlFaCrEFp08ij/udw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jxYOOxCc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F038860A6F69
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jxYOOxCc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A521F008A2;
	Tue, 10 Nov 2026 16:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794328039;
	bh=vK4LWpRDwU7vNhS6EBeO98N4nUu+oxzJNpxEVGaHkMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jxYOOxCcqBEJGY6S1m2nmLWNZ7DTKVtwyt6+xHFqQBfJN1r6S45lFtR0BkcmUAT+0
	 8SWtiYGxNXVIO+M72L2DxsJpmuMaPfUOjvXU0+ILugvdQ79PrksGqxsadelTJCg4Zm
	 0M+MKsVlGTAr6AY5ilQB2O09c+pzs1AxZyBT6+Le1i5oiHy0EjKqTl0MBOt9QcYn+I
	 4aYR8SXUFyK/vCkYfFdhcB8VIwwQJL6NohQ45PyMAuNN1OPytI69hY0r0Rt9uCN6Ql
	 g0H8tOBFPh+g6Vfk98/MEJffn6P2PxfXM9Aqb8UbWv4WFUw45fQhmsBJVZMgcpnX9K
	 u7gMCu0K9v5yg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] xprtrdma: Remove the RPC/RDMA QP event handler
Date: Tue, 10 Nov 2026 11:27:16 -0500
Message-ID: <20261110162636.2501729-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062106-failed-5.10-0b5bb4e586f7@kernel.org>
References: <20261107062106-failed-5.10-0b5bb4e586f7@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit e1648eb23d839bd4b9f2999296d5e81dcd93311f ]

Clean up: The handler only recorded a trace event. If indeed no
action is needed by the RPC/RDMA consumer, then the event can be
ignored.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Stable-dep-of: 0b5bb4e586f7 ("xprtrdma: prevent disconnect feedback during endpoint teardown")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/trace/events/rpcrdma.h | 32 --------------------------------
 net/sunrpc/xprtrdma/verbs.c    | 18 ------------------
 2 files changed, 50 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index bf1065772228f..3bdea1600e8b1 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -485,38 +485,6 @@ TRACE_EVENT(xprtrdma_op_set_cto,
 	)
 );
 
-TRACE_EVENT(xprtrdma_qp_event,
-	TP_PROTO(
-		const struct rpcrdma_ep *ep,
-		const struct ib_event *event
-	),
-
-	TP_ARGS(ep, event),
-
-	TP_STRUCT__entry(
-		__field(unsigned long, event)
-		__string(name, event->device->name)
-		__array(unsigned char, srcaddr, sizeof(struct sockaddr_in6))
-		__array(unsigned char, dstaddr, sizeof(struct sockaddr_in6))
-	),
-
-	TP_fast_assign(
-		const struct rdma_cm_id *id = ep->re_id;
-
-		__entry->event = event->event;
-		__assign_str(name, event->device->name);
-		memcpy(__entry->srcaddr, &id->route.addr.src_addr,
-		       sizeof(struct sockaddr_in6));
-		memcpy(__entry->dstaddr, &id->route.addr.dst_addr,
-		       sizeof(struct sockaddr_in6));
-	),
-
-	TP_printk("%pISpc -> %pISpc device=%s %s (%lu)",
-		__entry->srcaddr, __entry->dstaddr, __get_str(name),
-		rdma_show_ib_event(__entry->event), __entry->event
-	)
-);
-
 /**
  ** Call events
  **/
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 257acdb5bf56e..8c05fc11d79e5 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -114,22 +114,6 @@ static void rpcrdma_xprt_drain(struct rpcrdma_xprt *r_xprt)
 	rpcrdma_ep_put(ep);
 }
 
-/**
- * rpcrdma_qp_event_handler - Handle one QP event (error notification)
- * @event: details of the event
- * @context: ep that owns QP where event occurred
- *
- * Called from the RDMA provider (device driver) possibly in an interrupt
- * context. The QP is always destroyed before the ID, so the ID will be
- * reliably available when this handler is invoked.
- */
-static void rpcrdma_qp_event_handler(struct ib_event *event, void *context)
-{
-	struct rpcrdma_ep *ep = context;
-
-	trace_xprtrdma_qp_event(ep, event);
-}
-
 /* Ensure xprt_force_disconnect() is invoked exactly once when a
  * connection is closed or lost. (The important thing is it needs
  * to be invoked "at least" once).
@@ -428,8 +412,6 @@ static int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt)
 
 	r_xprt->rx_buf.rb_max_requests = cpu_to_be32(ep->re_max_requests);
 
-	ep->re_attr.event_handler = rpcrdma_qp_event_handler;
-	ep->re_attr.qp_context = ep;
 	ep->re_attr.srq = NULL;
 	ep->re_attr.cap.max_inline_data = 0;
 	ep->re_attr.sq_sig_type = IB_SIGNAL_REQ_WR;
-- 
2.53.0

