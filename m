Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167533955D3
	for <stable@vger.kernel.org>; Sat, 30 May 2026 11:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780141708; cv=none; b=P6TCW/OeVW2Eupf8G/h0KXt7ydagilW90EKdw7TB5Hsk2A5GZGj+DQf0QHIWkc1CjkqkPiWe20bvMWSYucSoFopiGcLB2wzhxcl0Nw97om5A2XMhsqEO/GsB55IqzGasQB1BFeQDUlf3KbBuNbkwcrPBJTxqa8yQUixGfxIW34s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780141708; c=relaxed/simple;
	bh=Np1IqzMFo3KhyPzDSXZcC38K604lk0aglRATKbW6evQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uxYsDO2owDgcoNNazQ/I/9Avlj7JqInh1/qrAp4fseXWr64RGLPNYdb2yLO1T2ieu6OsrsXcHksKncOb4QSmyPuHalqz0Vk+3+ozx1pdy6aGbbC9IG7fpjhlz7+G0/MmrW2RdgPafs2lS7k3E/jTuKMO2qdJj5xQIhGyzKsTdak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXiJ0YfJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXiJ0YfJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A3F1F00893;
	Sat, 30 May 2026 11:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780141706;
	bh=yJk62aF1ki3sM8dVZMdNt/SHiQRiSjWR6UKerSk7oVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GXiJ0YfJ1DZb20qolh+C7Me9JogCSsTVnk7h6C38WX5+wzn42AM8XPQdR3yr5k22X
	 7xGQespPvt0AKpqgWYlWxqmgvYRLbf03GIDnfLRPOcqzodqLiWKkJlgjVno1xfto2b
	 Ji2wivytZiCXQl5ApWHXmF6ZofKLofToELzzo7jdzkLj9CECjMXgLp2VR1Mge4fOP8
	 1aH6yLc/UnOKvBvCcQOCxo+Fzs5NCkflFoHLYRftdibQVIFSCPhtSOxyW9x7Ish0lu
	 F2iU/0azH/scprjB7nARqnBRRCVYMHJEYJeX9UwKZllfPokA2B1r/i9hD4NPHofL8u
	 TfMqIObm0Balg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Geliang Tang <geliang@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] mptcp: cleanup fallback dummy mapping generation
Date: Sat, 30 May 2026 07:48:23 -0400
Message-ID: <20260530114824.1966673-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052849-concise-frosting-9b5c@gregkh>
References: <2026052849-concise-frosting-9b5c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 2834f8edd74d5dda368087a654c0e52b141e9893 ]

MPTCP currently access ack_seq outside the msk socket log scope to
generate the dummy mapping for fallback socket. Soon we are going
to introduce backlog usage and even for fallback socket the ack_seq
value will be significantly off outside of the msk socket lock scope.

Avoid relying on ack_seq for dummy mapping generation, using instead
the subflow sequence number. Note that in case of disconnect() and
(re)connect() we must ensure that any previous state is re-set.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Geliang Tang <geliang@kernel.org>
Tested-by: Geliang Tang <geliang@kernel.org>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20251121-net-next-mptcp-memcg-backlog-imp-v1-6-1f34b6c1e0b1@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 0981f90e1a05 ("mptcp: reset rcv wnd on disconnect")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/protocol.c | 3 +++
 net/mptcp/subflow.c  | 8 +++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1dbe6c8a8b8c5..16ade718b27c7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3308,6 +3308,9 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	msk->rcvspace_init = 0;
 	msk->fastclosing = 0;
 
+	/* for fallback's sake */
+	WRITE_ONCE(msk->ack_seq, 0);
+
 	WRITE_ONCE(sk->sk_shutdown, 0);
 	sk_error_report(sk);
 	return 0;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 3226fef7237ef..42fd759c51df4 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -491,6 +491,9 @@ static void subflow_set_remote_key(struct mptcp_sock *msk,
 	mptcp_crypto_key_sha(subflow->remote_key, NULL, &subflow->iasn);
 	subflow->iasn++;
 
+	/* for fallback's sake */
+	subflow->map_seq = subflow->iasn;
+
 	WRITE_ONCE(msk->remote_key, subflow->remote_key);
 	WRITE_ONCE(msk->ack_seq, subflow->iasn);
 	WRITE_ONCE(msk->can_ack, true);
@@ -1435,9 +1438,12 @@ static bool subflow_check_data_avail(struct sock *ssk)
 
 	skb = skb_peek(&ssk->sk_receive_queue);
 	subflow->map_valid = 1;
-	subflow->map_seq = READ_ONCE(msk->ack_seq);
 	subflow->map_data_len = skb->len;
 	subflow->map_subflow_seq = tcp_sk(ssk)->copied_seq - subflow->ssn_offset;
+	subflow->map_seq = __mptcp_expand_seq(subflow->map_seq,
+					      subflow->iasn +
+					      TCP_SKB_CB(skb)->seq -
+					      subflow->ssn_offset - 1);
 	WRITE_ONCE(subflow->data_avail, true);
 	return true;
 }
-- 
2.53.0

