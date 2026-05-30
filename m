Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FA02C11E6
	for <stable@vger.kernel.org>; Sat, 30 May 2026 20:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780171634; cv=none; b=s6DDClswJO2h8+SR9T5jp3RnQqXqkjSq59dviTMDm34YnuEHjot04GX2YNIBpVq3Zu6SuUlH4I/2ot/G1zmZErrIhNiaTH9GNBxTdRChuNf/HXzHB0K+hvQBW7zPZtT43XmPuLHzPGsWJ0bVtNsg/Mdnacq1pG/tx3Lzir+rYMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780171634; c=relaxed/simple;
	bh=n1hsIxPl9Q9HAvZYmenx4GuAr/ao90yNN06kiZGpQso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iylANVw4cI5tOf35/+zTLwxlV4WGdOiDsiu7ggDKtwn+pQai4ANs+PBcufmNqgAP0EBqzqr6/C2b4r1XqrEIraQUZtM1RvLHlWvN/ipHnudce0rL905uJGjY6Ydomu4gA91JBGtlsffKvQI+EaIyYJmO3qAjhfsApGO0Y6K1gSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SuKtKbPI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SuKtKbPI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2DC21F00893;
	Sat, 30 May 2026 20:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780171633;
	bh=4lhU153Y/fVhKw03AIk6SHHSZch3t+Xy+V1ivzg4Lkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SuKtKbPI7RRFQU/KqfLXum+inti9PDl//aNsSkZxOmefYUzDL5EWTQz/8lfp3FX0j
	 +JqERFp7GYGVBN+9dhV2qocgkpNbmhKCfYGl2QKK85gsGvru+IYTUBI43wDtEqogGz
	 kq2o/syfdUFxvi/tOn9hhuiaVR+OsPJ0MGgUzg6FOPnRbbh4EG1w1z4oP2sv/mOF4/
	 3sUb+ibJX6K0TeJPYaFNoWCT6ucVO8VFGiqaAIinOhg1ny3QKxGRuED/Cw/N5v2/pk
	 ElNrJL0btBDaf86/CggV2DrJLy/RSxREB6QBj+82W5YODVXhDp5lxvJSrtO2Ypjx7G
	 p5kz4oiKPLRLw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shardul Bankar <shardul.b@mpiricsoftware.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] mptcp: do not drop partial packets
Date: Sat, 30 May 2026 16:07:11 -0400
Message-ID: <20260530200711.3281969-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052839-kudos-clear-0573@gregkh>
References: <2026052839-kudos-clear-0573@gregkh>
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
index 70bc440c615d7..b02c4885adbb9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -314,10 +314,26 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
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

