Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A987A1BBBE5
	for <stable@vger.kernel.org>; Sat, 30 May 2026 19:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780170468; cv=none; b=jlxWDqelvVJ7U516pGQd+ZOhp/O7mrqdUKoO3tj/JR3Rhf9/0IJXwAGPwAc6BCt7y9rqNzbYIGf2OTuLiVDz/aN8COrWvMrdO99RmS+Nl90+ycHI7/AXr+RzlP7XBN1YuA39sBVZ+BgYMgR8Q2wFDeZ6x4MTWKk/XvBzDUcWo6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780170468; c=relaxed/simple;
	bh=YMbxRjwJpba/0TLPoRedTHTg0b6d6VrzhpDSdVt9UHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hNG5FPCGUxBYlw6CUJCBA9EAG5E3W1HpWjIUN19Y/5kUH/asKVeaKD5B66jR6YG9PlZdFTrL7WrdhwALAdt4xqjcY3AWwbiAnaZGdl37p3plqN3kODPlA2FPSns2hdzzOoXhglWGWcPjDBjIwnZDIPF8tnSltDy884qMq7RNxXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSYet9rU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSYet9rU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4FDB1F00898;
	Sat, 30 May 2026 19:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780170467;
	bh=UQTXcnvCMgCQtPVcx1YzD7U9hRgg2MsQzOgC/u23xSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DSYet9rUCITTOpY2LtrhYRiKWELzqOteotlo8/D37JmgTqJLzmQxSbGzU6dz0qLPr
	 z4iPNLDM8JcWNZPY38tADDIBrgGy5OKAANeoiCyoa+rcOFe/raqtAsL/0nX/61vnQb
	 qdViCzATXHX045g7EZFhJRHb6sAJRjiq96WBdlFY40EpT3diLzoMNFzjRqzaAFNTBX
	 eQfJQBAlqfwZ7Ed7mFtzCjVwCJADH+kXj3+giCJ9qiYrXiq9uaPLVeerE0mQUxqbeL
	 Ii18X+Lp+D2XdGPk6RLEspECFebnaW1XCoF3DgQ3W+CQFObN/6hykxQ7F+Dkrrchnb
	 8GMUxnVdzf/Mw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shardul Bankar <shardul.b@mpiricsoftware.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mptcp: do not drop partial packets
Date: Sat, 30 May 2026 15:47:45 -0400
Message-ID: <20260530194745.3257532-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052838-unsterile-jailhouse-1f0f@gregkh>
References: <2026052838-unsterile-jailhouse-1f0f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shardul Bankar <shardul.b@mpiricsoftware.com>

[ Upstream commit 50c2d91c5dfa0e465826ec1f8dbad9cdc254bd85 ]

When a packet arrives with map_seq < ack_seq < end_seq, the beginning
of the packet has already been acknowledged but the end contains new
data. Currently the entire packet is dropped as "old data," forcing
the sender to retransmit.

Instead, skip the already-acked bytes by adjusting the skb offset and
enqueue only the new portion. Update bytes_received and ack_seq to
reflect the new data consumed.

A previous attempt at this fix has been sent by Paolo Abeni [1], but had
issues [2]: it also added a zero-window check and changed rcv_wnd_sent
initialization, which caused test regressions. This version addresses
only the partial packet handling without modifying receive window
accounting.

Fixes: ab174ad8ef76 ("mptcp: move ooo skbs into msk out of order queue.")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/c9b426a4e163aa3c4fe8b80c79f1a610f47ae7d8.1763075056.git.pabeni@redhat.com [1]
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/600 [2]
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
[pabeni@redhat.com: update map]
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260515-net-mptcp-misc-fixes-7-1-rc4-v2-1-701e96419f2f@kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ dropped `msk->bytes_received += copy_len;` and relocated the `drop:` label to the function end for the existing RCVPRUNED `goto drop;` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/protocol.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2f679ad0f15b6..2e8921068f569 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -329,10 +329,26 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
 		return false;
 	}
 
-	/* old data, keep it simple and drop the whole pkt, sender
-	 * will retransmit as needed, if needed.
+	/* Completely old data? */
+	if (!after64(MPTCP_SKB_CB(skb)->end_seq, msk->ack_seq)) {
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
+		mptcp_drop(sk, skb);
+		return false;
+	}
+
+	/* Partial packet: map_seq < ack_seq < end_seq.
+	 * Skip the already-acked bytes and enqueue the new data.
 	 */
-	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
+	copy_len = MPTCP_SKB_CB(skb)->end_seq - msk->ack_seq;
+	MPTCP_SKB_CB(skb)->offset += msk->ack_seq - MPTCP_SKB_CB(skb)->map_seq;
+	MPTCP_SKB_CB(skb)->map_seq += msk->ack_seq -
+				      MPTCP_SKB_CB(skb)->map_seq;
+	WRITE_ONCE(msk->ack_seq, msk->ack_seq + copy_len);
+
+	skb_set_owner_r(skb, sk);
+	__skb_queue_tail(&sk->sk_receive_queue, skb);
+	return true;
+
 drop:
 	mptcp_drop(sk, skb);
 	return false;
-- 
2.53.0

