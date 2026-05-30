Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D6131CA4E
	for <stable@vger.kernel.org>; Sat, 30 May 2026 16:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780159718; cv=none; b=ux6u93v7PaI8KmVHAzvw/c/N4Sh9bs86WuLWzqomdBrmMgNL0lId/125zlOVv1qLljTtspazikh0Nl81aE5LL/bvrifdomPdba1/IBvujbivflwEO0ZCDsifotduELWQns9wuj/6D4mIuVhgX4AmHN2C1WjGziLbPlVZ4+M9aXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780159718; c=relaxed/simple;
	bh=DSTJ9e+AlWZnQAHYe0XkOy2nHkvrzisWL6iR7Ivh0DY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tjgRXJ3478P3JUPiNEWwUkZVF6WI6+sPvMhjBhEubv8PithF+89nAlCcqd50rQUKFNauDkk19KBstZVNCowLSIZOliQnSCRtLJN24A2Ac0BG7SSIboDpztzqsbOrO8umYLrMTNgubx6bK17+l/VsrDth2Ov9vIgamJicLohwJv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocEz8YJ7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocEz8YJ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F0E1F00893;
	Sat, 30 May 2026 16:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780159717;
	bh=X85/8XpPQGuZmdXVRMhBwo+MrhtW4QslCMmhVU7ESYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ocEz8YJ7CEVsqWwZ0TUxpKpExDZ7sehnA8yyvkgPxx/hVIhTI/jEkno2yMZc0XtHX
	 XuEycQT2vy/f8TipG01PSmvy5NL8pdpLOoHZS8GT2tgfpqEl5K2EWtYWtRORicUCwj
	 vIniX14kyHkQL81f4lOWI4lcM89ubItN/1aoem6O/0mwNjwH7ok8NoSouPLcgTNDvK
	 Uc9/x8A7p7srPa9gUTt3XcDZk+M7AD+AMV0RUIcp3okpjWyzFxjpXnFf7Dptga+EMd
	 2qJx1TO/HSqqqv1EU7ce73iDmLDqGXd4fPGrqeYF43sJ0RtwssjGMPnBjVvrvozKKw
	 L79a1MZV0R6nQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shardul Bankar <shardul.b@mpiricsoftware.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mptcp: do not drop partial packets
Date: Sat, 30 May 2026 12:48:34 -0400
Message-ID: <20260530164834.2992487-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052837-expenses-whimsical-565c@gregkh>
References: <2026052837-expenses-whimsical-565c@gregkh>
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
[ changed `skb_set_owner_r()` to `mptcp_set_owner_r()` and dropped the absent `msk->bytes_received` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/protocol.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 965819ddc04c9..dbcf8171ad7b3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -400,10 +400,25 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
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
+	mptcp_set_owner_r(skb, sk);
+	__skb_queue_tail(&sk->sk_receive_queue, skb);
+	return true;
 drop:
 	mptcp_drop(sk, skb);
 	return false;
-- 
2.53.0

