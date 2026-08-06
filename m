Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213303A1A22
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 13:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786024208; cv=none; b=rh4h61oq4XrvFYUdK6OzvVnrdrhjkb2trWyY49YlfoE4UQG/jH19ZPkrdVNTXtA96YtPj5ay4f50LSafim7Bed46OQMiFOS79ixncbEOZO0ejp/PCUNdNtl+wVCP4PS3AQQwgf829muGe9wo9xb7k5x0kSLmc8xJTSnqBhH4um0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786024208; c=relaxed/simple;
	bh=6/7GITPyCLYTdF3Nml5uhNfcC4kG3nDH8nGFPDa9Xds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DuBeZvaEDvVeF+xEJdmmd9z5vOa/AQG45+0NcToQQK4ou/+cMMv4ufJQVJUiROaQiusGYrb3f8Dz54jY4s0IPPaLrDkH77oHTLM6+LzZLibV/iza2BKW0SipbXCGCpi3MarspecrOwS57VJ2hNpM8/dOH6D6vKWxauRDpNCMQqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MP4HEHvF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MP4HEHvF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA471F00A3D;
	Thu,  6 Aug 2026 13:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786024207;
	bh=jDk+w1SMHQepVc70rKLqFDqwAB3qwIY1LYA4DHZo7ts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MP4HEHvF+AuGxRkwtofSfyRkp6EVQdatOCeG63WStdfEjm00seJLKbfOnC5FjDizk
	 sZAkymy8o8Wgl3817RfDkVtIXyi91j8YkaF1eFN3P+Ab5TN2/aopBYVL54bn/pxiNH
	 abL/DECeoFDR45vMYZi5xctPKcUdhzX4syh4mXzlYQrDgFKo/XYobygwE3/X0v+bs3
	 bJer/wyBrkV7eZQOoZtto+4iRoR4iLt8jXEo9hsVS/PYY7mS4IPcD1FcuyCtvXl9c8
	 o1J5J016IW9aQBtM1dTWo4Dr/q7VB5muXcl306qn5p3/R1M7pwNGxmENwsDnkehW27
	 4aIcYZpigAD4w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/5] rxrpc: Adjust the rxrpc_rtt_rx tracepoint
Date: Thu,  6 Aug 2026 09:50:00 -0400
Message-ID: <20260806135003.602726-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806135003.602726-1-sashal@kernel.org>
References: <2026073013-sanding-unlined-9b91@gregkh>
 <20260806135003.602726-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Howells <dhowells@redhat.com>

[ Upstream commit 93dfca65a1df42a3c8b1094299dc42ab8f18e5c8 ]

Adjust the rxrpc_rtt_rx tracepoint in the following ways:

 (1) Display the collected RTT sample in the rxrpc_rtt_rx trace.

 (2) Move the division of srtt by 8 to the TP_printk() rather doing it
     before invoking the trace point.

 (3) Display the min_rtt value.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: e4d2878369d5 ("rxrpc: Fix irq-disabled in local_bh_enable()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/trace/events/rxrpc.h | 14 ++++++++++----
 net/rxrpc/input.c            |  4 ++--
 net/rxrpc/rtt.c              |  2 +-
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index fd913d7f79b87..c398897052a2a 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -1308,9 +1308,9 @@ TRACE_EVENT(rxrpc_rtt_rx,
 	    TP_PROTO(struct rxrpc_call *call, enum rxrpc_rtt_rx_trace why,
 		     int slot,
 		     rxrpc_serial_t send_serial, rxrpc_serial_t resp_serial,
-		     u32 rtt, u32 rto),
+		     u32 rtt, u32 srtt, u32 rto),
 
-	    TP_ARGS(call, why, slot, send_serial, resp_serial, rtt, rto),
+	    TP_ARGS(call, why, slot, send_serial, resp_serial, rtt, srtt, rto),
 
 	    TP_STRUCT__entry(
 		    __field(unsigned int,		call)
@@ -1319,7 +1319,9 @@ TRACE_EVENT(rxrpc_rtt_rx,
 		    __field(rxrpc_serial_t,		send_serial)
 		    __field(rxrpc_serial_t,		resp_serial)
 		    __field(u32,			rtt)
+		    __field(u32,			srtt)
 		    __field(u32,			rto)
+		    __field(u32,			min_rtt)
 			     ),
 
 	    TP_fast_assign(
@@ -1329,17 +1331,21 @@ TRACE_EVENT(rxrpc_rtt_rx,
 		    __entry->send_serial = send_serial;
 		    __entry->resp_serial = resp_serial;
 		    __entry->rtt = rtt;
+		    __entry->srtt = srtt;
 		    __entry->rto = rto;
+		    __entry->min_rtt = minmax_get(&call->peer->min_rtt)
 			   ),
 
-	    TP_printk("c=%08x [%d] %s sr=%08x rr=%08x rtt=%u rto=%u",
+	    TP_printk("c=%08x [%d] %s sr=%08x rr=%08x rtt=%u srtt=%u rto=%u min=%u",
 		      __entry->call,
 		      __entry->slot,
 		      __print_symbolic(__entry->why, rxrpc_rtt_rx_traces),
 		      __entry->send_serial,
 		      __entry->resp_serial,
 		      __entry->rtt,
-		      __entry->rto)
+		      __entry->srtt / 8,
+		      __entry->rto,
+		      __entry->min_rtt)
 	    );
 
 TRACE_EVENT(rxrpc_timer_set,
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index c2a2fb7210c3d..501a049b42f86 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -674,7 +674,7 @@ static void rxrpc_complete_rtt_probe(struct rxrpc_call *call,
 		 */
 		if (after(acked_serial, orig_serial)) {
 			trace_rxrpc_rtt_rx(call, rxrpc_rtt_rx_obsolete, i,
-					   orig_serial, acked_serial, 0, 0);
+					   orig_serial, acked_serial, 0, 0, 0);
 			clear_bit(i + RXRPC_CALL_RTT_PEND_SHIFT, &call->rtt_avail);
 			smp_wmb();
 			set_bit(i, &call->rtt_avail);
@@ -682,7 +682,7 @@ static void rxrpc_complete_rtt_probe(struct rxrpc_call *call,
 	}
 
 	if (!matched)
-		trace_rxrpc_rtt_rx(call, rxrpc_rtt_rx_lost, 9, 0, acked_serial, 0, 0);
+		trace_rxrpc_rtt_rx(call, rxrpc_rtt_rx_lost, 9, 0, acked_serial, 0, 0, 0);
 }
 
 /*
diff --git a/net/rxrpc/rtt.c b/net/rxrpc/rtt.c
index bce6e8f32d334..dc26754ffd5fb 100644
--- a/net/rxrpc/rtt.c
+++ b/net/rxrpc/rtt.c
@@ -175,7 +175,7 @@ void rxrpc_peer_add_rtt(struct rxrpc_call *call, enum rxrpc_rtt_rx_trace why,
 	spin_unlock(&peer->rtt_input_lock);
 
 	trace_rxrpc_rtt_rx(call, why, rtt_slot, send_serial, resp_serial,
-			   peer->srtt_us >> 3, peer->rto_us);
+			   rtt_us, peer->srtt_us, peer->rto_us);
 }
 
 /*
-- 
2.53.0

