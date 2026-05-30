Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513553B388B
	for <stable@vger.kernel.org>; Sat, 30 May 2026 14:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780150655; cv=none; b=V9LKxCPtgSkYjtP0nV2uDw0DLXy6C28OVcdfd/JvIRTMVICIJ8NSgWBBlNEXhlpE7IUOgGwdtxLzGYgJTkWvfhFO/ES2KSOZEZvE2u5KBNMQjIfFjBt/KxckuO1Nw04KLvMTEjFqRARL2mPuhkb5Yd4O4hywyvad7OZdEvZHmO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780150655; c=relaxed/simple;
	bh=wmxxM8y3NB/J7C2uAPCjn3R/mwmgxtbfjJnk/x5/9b8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jCLBHTJU4PwICafrviMwzY9buYQXAt/D5lQwEgrveraf4gL+vagFsajl6QIfGc8mnt2EFlx6TEL5oKwTS3lCv5ORtjB/mIrt3mRNIvb6kzf5DD+IBo75lnpKPXUbxTHERm4NbDJZeAkkejqy827eYBWOLD7Ky4kgKx7NjWfhb3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGimDOwO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGimDOwO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3B01F0089A;
	Sat, 30 May 2026 14:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780150654;
	bh=Dp+ce52Gw4GbogvXO3ZgzZi3+ozZoYKk8hwH9MQR4tA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dGimDOwOuLTGHLy0xdMH0UIPohfGlqXV7ZDRgon/zVLJKf8FpfoygFiIId5cF0cY6
	 YE6r+qmzVWpzHhWdXYQoMY4/ZPzR3QP5tRqXg7NJMC+bayceImP9EZJoW9zL/QEePD
	 ITcDrVYshj0KR1N9F3+eayXUdUCqgF/TrpkAZonkX496s/+EJxENRZTxHBidDubcjU
	 ehaErQsnKR/dcdk8ib+5c3zzONsG3QIKcBI1ykVjWv/3RQ1winr2lE0Mho5UivHzvg
	 TIDe/b4NeqvUJyb669vakLNGe4JJDCXQAsJ0KxVQ8vJtu7TwtYPccObjK0mQhpLjj/
	 YudO1Uq6e0Atg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Geliang Tang <geliang@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] mptcp: cleanup fallback dummy mapping generation
Date: Sat, 30 May 2026 10:17:27 -0400
Message-ID: <20260530141728.2398427-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530141728.2398427-1-sashal@kernel.org>
References: <2026052851-deskbound-cardigan-c96b@gregkh>
 <20260530141728.2398427-1-sashal@kernel.org>
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
index aed6c04c7de67..abb9a9764b61a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3327,6 +3327,9 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	msk->rcvspace_init = 0;
 	msk->fastclosing = 0;
 
+	/* for fallback's sake */
+	WRITE_ONCE(msk->ack_seq, 0);
+
 	WRITE_ONCE(sk->sk_shutdown, 0);
 	sk_error_report(sk);
 	return 0;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index b8a8718573e62..d3b5c2d48b530 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -471,6 +471,9 @@ static void subflow_set_remote_key(struct mptcp_sock *msk,
 	mptcp_crypto_key_sha(subflow->remote_key, NULL, &subflow->iasn);
 	subflow->iasn++;
 
+	/* for fallback's sake */
+	subflow->map_seq = subflow->iasn;
+
 	WRITE_ONCE(msk->remote_key, subflow->remote_key);
 	WRITE_ONCE(msk->ack_seq, subflow->iasn);
 	WRITE_ONCE(msk->can_ack, true);
@@ -1382,9 +1385,12 @@ static bool subflow_check_data_avail(struct sock *ssk)
 
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

