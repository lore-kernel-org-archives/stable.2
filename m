Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22B72F6596
	for <stable@vger.kernel.org>; Sat, 30 May 2026 15:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780153665; cv=none; b=tTZyp2YQqV12v4LF40SBUJmCRTxZbIlqTsev+3KUtgX/mzVtkscKP531EQLM5UIrzLOGSbIpf6YY2qfFFykVnk99rx+k9FMLoRyXwppVRg+PRFnlYGtQwbkrG9beWDK9kFepptdp1MOlBUjv7/Kuop3WrbW1JwRG1cwt+D0Tbgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780153665; c=relaxed/simple;
	bh=D0JZZjtlSaf5IW0k4HZAXEh6TYjj0rkAuM1sAEi5xlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sH5+5REfIi1cBXb433OmBjTMJVPD2bxEiSnW33VbpVLfLYTThgLfKudSkMUF/TMjJ/eNlkNjnU5g5dTknJuJKcAzOYYafuZaBwEKQoZ8T2UmbKMRWj8LAwxpyS0likT/eirv9NSEOjJSaKZjBEX+frgKfrjLsDCcdzVx2w+JsFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOeOJnz5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOeOJnz5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15B71F00898;
	Sat, 30 May 2026 15:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780153664;
	bh=S2seu65oFiWgutipHR8gNHg/HFaeREsyKqeb6A+uMmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aOeOJnz561EaAsBSltLKOXsQwER2iNjbyurMdyI5saZ2d1Ecv/sCcPJx3MVSLJdGE
	 xHYMJAIPJX9E7x8bFOZl4w1AUmhm1qcpu/vGUw+hml1bWjiPEqdEX6Cvr3xW0ymuQS
	 H9pjxomL4VSL5o+4SBxqCillOpQjV8HcKT9TLeMQJ97XjyLQbmQtTy1b84mxeBjPbm
	 t9A5H0O2DNtUa/TFyouDtrvIPcGITAIL2V21lNuvhQqXsomzdKEYgwhv4WipK+BwOy
	 s4aqTrQdv/8ufHLT/x9h98UAQZUOl9u5jk/d3gnn+Ww5j13a6G3c6yLokhGkzJXa9c
	 9GHYMpz0+irOQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shardul Bankar <shardul.b@mpiricsoftware.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] mptcp: do not drop partial packets
Date: Sat, 30 May 2026 11:07:40 -0400
Message-ID: <20260530150740.2598142-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530150740.2598142-1-sashal@kernel.org>
References: <2026052837-repave-immovable-cfa4@gregkh>
 <20260530150740.2598142-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/protocol.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 959385b1e564c..a933d61488c80 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -392,12 +392,26 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
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
-	mptcp_drop(sk, skb);
-	return false;
+	copy_len = MPTCP_SKB_CB(skb)->end_seq - msk->ack_seq;
+	MPTCP_SKB_CB(skb)->offset += msk->ack_seq - MPTCP_SKB_CB(skb)->map_seq;
+	MPTCP_SKB_CB(skb)->map_seq += msk->ack_seq -
+				      MPTCP_SKB_CB(skb)->map_seq;
+	msk->bytes_received += copy_len;
+	WRITE_ONCE(msk->ack_seq, msk->ack_seq + copy_len);
+
+	skb_set_owner_r(skb, sk);
+	__skb_queue_tail(&sk->sk_receive_queue, skb);
+	return true;
 }
 
 static void mptcp_stop_rtx_timer(struct sock *sk)
-- 
2.53.0

