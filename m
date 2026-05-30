Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EBF30274D
	for <stable@vger.kernel.org>; Sat, 30 May 2026 14:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780150777; cv=none; b=TzSxpsycQkmY0yhDhQv/2Y6u7Nt27KaaGSxY6rJIgxU0GBbmEK9+KRlY9A8ShL4tAdqm8FPQhFUsjIM/vpOcTV50B23qj+QaoUGvGBhu6HN6PYljRnPjIPb7DkyC4F9NO/RiGTDDOU6re9wf3GTHmj5+pMhXN9ZUXn2WNOUt/qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780150777; c=relaxed/simple;
	bh=Cukb7VB+Hd3xbCREc1QkoS0IYIvzi4GZ3bH2ObbOKXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OS/zL/v7zKkSk2pnBwEHEHw1pDCLsK6Zyev8stG+SSyZrUSbqvKp9TTJBvhlEn9AOIzhN5nUvNZnUEtbsH3CQIa4qDpa0lbCF/cN5xhwFxciXd7x0oMw5GFsx0ES9UxwAqxlhhNHFxsG/Jje0P6WBA6MpeS5fZWZxscRTNB7pxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gc+D8RRB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gc+D8RRB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A4E41F0089E;
	Sat, 30 May 2026 14:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780150776;
	bh=bVlaiYimqnFRVwlGzzMbyvUYetFIAIpQf9WTSzbXKhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gc+D8RRBu29h1SfZU8qv4e4sJtinU+SgC4Pkgl87JsUHCdR8bjrsFTbuKRkQdX/9y
	 Q0J/8qbKahlWD/UCzuraqFgt4c/e27WVmpXPo29RbuElX79GpMLzwFiuVousKRTuuS
	 ouopao+vwNB8zB8PA5ZKzYlNow7KezpF8bP2C+Q8mFGFm9OFEkc5Im+QxKyPOPlBLw
	 XJYBiMSmK70euE1IENa4WwcSgfh6HIQZ7sWSSDCi7MptcQpJ07mo+dz9cN4j3IZJgw
	 znBZXwdI+Yoy0kLBLM4Xt52I0EeL0eqrPr2vaCnm7xNzs938wrFsQUE+iZR8Dl0LUl
	 Yx4Qkj++4hcag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shardul Bankar <shardul.b@mpiricsoftware.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] mptcp: do not drop partial packets
Date: Sat, 30 May 2026 10:19:32 -0400
Message-ID: <20260530141932.2407122-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530141932.2407122-1-sashal@kernel.org>
References: <2026052836-subscript-earache-630d@gregkh>
 <20260530141932.2407122-1-sashal@kernel.org>
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
index 9b8f7d2bdb315..139ec1eb97b65 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -390,12 +390,26 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
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

