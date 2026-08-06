Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205B73A3E67
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 13:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786024209; cv=none; b=bs27+/kg9i4OSWvDTHZfNlrI0IncNFpu2sqX4UjWkd+Vb3WLjUzKXI7d9ryI61DBn+CiXyC/A8xRdZ7dCTcnzUXfaRD7hfGpuciUZFFjVY7DrGhwd0Y52oZaUGK+4ekNFkOtG/SurqX95GokPK5d9bkYnDaLVCArTwsEwVb6vQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786024209; c=relaxed/simple;
	bh=4zmohvVFMdY2tphIh4W1KhAI/DIn47w9dSxthkp6qjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B8KqCYjiPdo36oi+LDG9Im3aZ7EByHkrX9juTyB+95EgaVlwT/0F8FZpLeWkh2H0VguhrS+tt6b6E6+yusjWoLuRA4HZsvXvKHd7Stc11W1UknNkmGSyjomyX7fa7xAmyrQoOzGyw49VNTCp0ZsS1vEj4lhB/t1ME+D+CDvBMZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfxHvOwO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfxHvOwO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 474D01F00A3A;
	Thu,  6 Aug 2026 13:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786024208;
	bh=BClz1h0QqAD+Z7CpftTdmfOxOowHSN6LfLqwHrFVseQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MfxHvOwOwuOlMvgJI9iHShOd8ousgLqM4Ch2WJ88SgxYImi50mP6xrtSIFRYNiveO
	 k5mocAjD+VemFwdNikP9SEf8bX4phzPkSL8rjEKBb6eUDGuiK/bjNSlImj3PQU0f50
	 9Dt49/c4J7Xz9v+KDaIS5TBfqpdU4PBBDoRw6hPgcsBHxNULYV3zpCA1FAUBEAdmBO
	 e9hFjNthnQwMhbusJ368111qirZ79Nmj0GxAeQCYPktGc+Rwif1ep0wkvounqyXgrX
	 +AK+vaQNaiGt+6MufehkDh/sY8Yy06AgT/qaThpinkQXgms3bBe/AIT2iU/FEZjuWY
	 jc1jK4M/M4ebg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Simon Wilkinson <sxw@auristor.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/5] rxrpc: Fix the calculation and use of RTO
Date: Thu,  6 Aug 2026 09:50:01 -0400
Message-ID: <20260806135003.602726-3-sashal@kernel.org>
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

[ Upstream commit 5c0ceba23bb47085d6c9c53bff08a29634ee4e7e ]

Make the following changes to the calculation and use of RTO:

 (1) Fix rxrpc_resend() to use the backed-off RTO value obtained by calling
     rxrpc_get_rto_backoff() rather than extracting the value itself.
     Without this, it may retransmit packets too early.

 (2) The RTO value being similar to the RTT causes a lot of extraneous
     resends because the RTT doesn't end up taking account of clearing out
     of the receive queue on the server.  Worse, responses to PING-ACKs are
     made as fast as possible and so are less than the DATA-requested-ACK
     RTT and so skew the RTT down.

     Fix this by putting a lower bound on the RTO by adding 100ms to it and
     limiting the lower end to 200ms.

Fixes: c410bf01933e ("rxrpc: Fix the excessive initial retransmission timeout")
Fixes: 37473e416234 ("rxrpc: Clean up the resend algorithm")
Signed-off-by: David Howells <dhowells@redhat.com>
Suggested-by: Simon Wilkinson <sxw@auristor.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: e4d2878369d5 ("rxrpc: Fix irq-disabled in local_bh_enable()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rxrpc/call_event.c | 3 ++-
 net/rxrpc/rtt.c        | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index 1181976972a31..c85e89b371b2a 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -71,7 +71,8 @@ void rxrpc_resend(struct rxrpc_call *call, struct sk_buff *ack_skb)
 	struct rxrpc_skb_priv *sp;
 	struct rxrpc_txbuf *txb;
 	rxrpc_seq_t transmitted = call->tx_transmitted;
-	ktime_t next_resend = KTIME_MAX, rto = ns_to_ktime(call->peer->rto_us * NSEC_PER_USEC);
+	ktime_t next_resend = KTIME_MAX;
+	ktime_t rto = rxrpc_get_rto_backoff(call->peer, false);
 	ktime_t resend_at = KTIME_MAX, now, delay;
 	bool unacked = false, did_send = false;
 	unsigned int i;
diff --git a/net/rxrpc/rtt.c b/net/rxrpc/rtt.c
index dc26754ffd5fb..b5615401fc944 100644
--- a/net/rxrpc/rtt.c
+++ b/net/rxrpc/rtt.c
@@ -27,7 +27,7 @@ static u32 __rxrpc_set_rto(const struct rxrpc_peer *peer)
 
 static u32 rxrpc_bound_rto(u32 rto)
 {
-	return min(rto, RXRPC_RTO_MAX);
+	return clamp(200000, rto + 100000, RXRPC_RTO_MAX);
 }
 
 /*
-- 
2.53.0

