Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9831931714C
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 12:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781612371; cv=none; b=jsEnNZhdfnxlA6fIv7vRN69x0r9A/AeX1XvKTnrVTjqXmJDBwVwhXgCv7gwEHYrTEPfBNzk3gRYadX+iwuLCARoDhEgPdVV0eI7wUa2dmsesXhc4tHntLmncgffd+hp66JIrpAmhXuDGSuV1esrIbMXwfsRibVQiPzfUaX3BTLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781612371; c=relaxed/simple;
	bh=67wyLyhoqpnbojF3yxqYUVJ0BXPGiV98wBzb17L3Qoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BGNWQb7el2lXcHAuvPItosTO1ZXNOntcLfZBPXsRz1y35pU7vWwYv9ofjKAepTMaiEV3CLxnt1gkgUOep40DNbUwAHsXAxwciO8QFZObfd7+JWEskDQfYKvffqrhPQhPqZyGwoXzvTLs1P6i7vKYA4dySQVePaNGAgKGxIzPkm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zb8O1Yhx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zb8O1Yhx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6896B1F000E9;
	Tue, 16 Jun 2026 12:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781612370;
	bh=xtFa2bQ8/p4VsHPgxoErpE2bwKXZUWSV17ylBz3cK1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zb8O1YhxZHIAKDZdJ3NVWRZzGbuSVbHoeIe3mVkAg9M0+lrbQt4etW8GRwB6dHFIc
	 KyozR23c8+oJCxS63aTnTobpW5NlmRza6TQ7qDl6J9HMPHsEFlIijUQlL7f/cZ1Soz
	 CyvAZqpcMnTcZ5JxEvW36bauK1UEB+LvbYPAokObvxg4cmlyo80AVYXlT9xXCsR6sP
	 doPrw6xpep6bxnYUc3yCD1p6FbqqgSpZtPvHIPkJaRil8n+qbouORN+bEAP/9K3Ws/
	 2NzfsaDzkKf3/+crtsaw96gaZsOpHLifnGLtfcv+GSRv7BevYyO9fHu6SeBQHyvywg
	 SPC4MQbBYrsjQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mptcp: fix missing wakeups in edge scenarios
Date: Tue, 16 Jun 2026 08:19:27 -0400
Message-ID: <20260616121927.3135722-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061539-dreadlock-pacifier-9f96@gregkh>
References: <2026061539-dreadlock-pacifier-9f96@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 9d8d28738f24b75616d6ca7a27cb4aed88520343 ]

The mptcp_recvmsg() can fill MPTCP socket receive queue via
mptcp_move_skbs(), but currently does not try to wakeup any listener,
because the same process is going to check the receive queue soon.

When multiple threads are reading from the same fd, the above can
cause stall. Add the missing wakeup.

Fixes: 6771bfd9ee24 ("mptcp: update mptcp ack sequence from work queue")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260602-net-mptcp-misc-fixes-7-1-rc7-v2-1-856831229976@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/protocol.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ff1632d03a96d1..cbaf794e876301 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2187,7 +2187,11 @@ static bool __mptcp_move_skbs(struct mptcp_sock *msk)
 	}
 	if (ret)
 		mptcp_check_data_fin((struct sock *)msk);
-	return !skb_queue_empty(&msk->receive_queue);
+
+	ret = !skb_queue_empty(&msk->receive_queue);
+	if (ret && mptcp_epollin_ready(sk))
+		sk->sk_data_ready(sk);
+	return ret;
 }
 
 static unsigned int mptcp_inq_hint(const struct sock *sk)
-- 
2.53.0

