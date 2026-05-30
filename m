Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3FE3955D3
	for <stable@vger.kernel.org>; Sat, 30 May 2026 11:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780141856; cv=none; b=V+WDyqInZ6pgoClOQ07uKOUijVu3ffgw0TFC7jH2RHCylTbbKBh5Nml8bYNDfE2CZlUZEuuBLrlEqRQsR0lN+AwKFJ2ig6Ez6p1hETz5jK7H7NtnpM0oOYQP140qIRww/ZSRTleqrVyqbzqIOqhQSjz+4kL4XpKLbb7bsKInSRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780141856; c=relaxed/simple;
	bh=q9Mh2+IJthSNEbgeuziea5ooWLoCU2X5uRd+2Ri9r58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E3IfmP7ML/7YjITPLyS3vaRqHEEaHSjysfeXAnmdTWPe2/mIxtE9FnjtwVJeX4K/5GAeEJ42eEELsE4u0hk9BziBZ0gvXny0Iew9W6fDMCqFKwKPKGQvG7QP1zFuJxcyQcz9E/+QzMmCLHobX2JNDdCf/9QCIgJkHG9TPTmtX7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcfAgBtx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcfAgBtx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 355941F00893;
	Sat, 30 May 2026 11:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780141855;
	bh=1D0sEZs2/U5yXMUv0fKatFs/dnic5B/emyJhg8S9w+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IcfAgBtxHh37AOwExuW/JSTgXDvW366RUOTMSkIG4SWdIkYRYqS1KfcyXhbioG6Hv
	 B8UCr3DamCq2lPSypLr3REfoObEOp3uwms/BEfvv9Ec9lM0qNbkTQKDj4RwKaQ8Eim
	 Z/NJbbV4E8rzBZ/ZO8YSMQ7+LxUu5qQPlGjiT2UfuXgF3lxZ6y2jML9gWTy4gHow41
	 OzKE+XRAmU480i+ARJ3AkJt52paPXiB2VJn7ppMl16kK7w1EkiYJ+GCwLc59YuiGfQ
	 alC0gSdyhw+v5zST4tVZCXaCjKBvprTB5JPjNf8GidEMO4qFh901pm6QKHkzTSJRgn
	 gta+eKf3YzZeg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Geliang Tang <geliang@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] mptcp: cleanup fallback dummy mapping generation
Date: Sat, 30 May 2026 07:50:51 -0400
Message-ID: <20260530115052.1973393-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052850-revocable-pessimism-d52d@gregkh>
References: <2026052850-revocable-pessimism-d52d@gregkh>
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
index 7dbb666c72c30..5aede32e47f0e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3369,6 +3369,9 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	msk->rcvspace_init = 0;
 	msk->fastclosing = 0;
 
+	/* for fallback's sake */
+	WRITE_ONCE(msk->ack_seq, 0);
+
 	WRITE_ONCE(sk->sk_shutdown, 0);
 	sk_error_report(sk);
 	return 0;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 10e945f5fa0f1..26ea58691f793 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -490,6 +490,9 @@ static void subflow_set_remote_key(struct mptcp_sock *msk,
 	mptcp_crypto_key_sha(subflow->remote_key, NULL, &subflow->iasn);
 	subflow->iasn++;
 
+	/* for fallback's sake */
+	subflow->map_seq = subflow->iasn;
+
 	WRITE_ONCE(msk->remote_key, subflow->remote_key);
 	WRITE_ONCE(msk->ack_seq, subflow->iasn);
 	WRITE_ONCE(msk->can_ack, true);
@@ -1415,9 +1418,12 @@ static bool subflow_check_data_avail(struct sock *ssk)
 
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

