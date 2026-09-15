Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A8F42BE95;
	Tue, 15 Sep 2026 20:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789504674; cv=none; b=lOnA6Ud3R9f/7oQQFAoF4qsrp136SB/up58K88kdB4hf9Kh8WdpP+hobCu8NLGTrOtGOb8Txc+8+n8RmpxrDbF3ooOj8DXuuBNwzkd8H/Rh3QaZFZkR+Lmx1wJRBK96jVD1XDNZPeMoYXEWfCz/tjQojtXMKQVW0tvID/XcrH5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789504674; c=relaxed/simple;
	bh=pjSWSZCTWSefgsa0hSpR34kbMUb+CgIFXUpyqpAIf5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VKaLMu9Kj6XeWBoIWYOO64xUZElIXKxNxE3MduUPuk2mDmvhC6Xlpz9yorvr7H7w+dy8wDzSRvfdB4QyCPM6U+b+D5n+U3bdvNbNuw3LKMFImuJ4Eim8u4ePJ6gTXKvosBJPtWJsJf6YdPsr1wgjUS7vYR2ORBZ/E7HAKcNJ+BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThINt4Mx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThINt4Mx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A11831F00893;
	Tue, 15 Sep 2026 20:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789504669;
	bh=xtYXoTRHmlL56/c9kqr7oZw8BAmXM7KyZKQJgp8qaRY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ThINt4MxPJGKU9xd/tDsUhdlvEE5XV36UeMyRp6rCOwCjwuQGr+QR6u3WMDR4f3Vz
	 W+HqAb3VqUB+wfTHBo+NLIENZbDYTrje03Tr7V/hsMTdgn42sl+kMNXMc3TAIMwVh2
	 Gf9kV0aaM+uy48hiVEFT1ckKBuc5FmHiEq6bu8N+EYQVT0EDd9dTqsBbCPvLWsvyi1
	 /fHRCVIRXmFySpf/5+lfparFeKwWZ0h2pRH9weW9W3qAkSX61AVqO3da+ClDza6Dfm
	 pbZJ/XXitt8zwpeWWLMMDlZK+RrP9BMCscBVexKQDhr1ykTEmkOw/9sk29gXweDerw
	 bGHBYvYAd2fMA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 15 Sep 2026 22:37:33 +0200
Subject: [PATCH net 2/2] mptcp: close race between scheduler and state
 change
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-net-mptcp-misc-fixes-7-3-rc4-v1-2-a257797dd5d0@kernel.org>
References: <20260915-net-mptcp-misc-fixes-7-3-rc4-v1-0-a257797dd5d0@kernel.org>
In-Reply-To: <20260915-net-mptcp-misc-fixes-7-3-rc4-v1-0-a257797dd5d0@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 Shardul Bankar <shardul.b@mpiricsoftware.com>, 
 Xinyang Ge <xinyang@anthropic.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1369; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=6+E1hTgKtC2Wqeqb4IpXtBGzbsK7ipf2MQiokegHE9I=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJWrpk2Z0P0za//lorPdpintUzum/L0FY9D3U1d6612V
 0kt/nxrUUcJC4MYF4OsmCKLdFtk/sznVbwlXn4WMHNYmUCGMHBxCsBErjUwMiyezb+gW//DtadB
 +xKDNkvO2digK5jEGMEy9+UzqXWaEhMZfkz8uoBP315pjalI1q2f13SM/06cLvcxbNveX8eXMq1
 bywcA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

The mptcp scheduler may race with subflow sockets state change: data
transmission on the selected socket may fail and a later release could
try to use mss_now reset to 0 for a divide operation.

Address the issue by explicitly checking for the critical scenario.

Fixes: c886d70286bf ("mptcp: do not queue data on closed subflows")
Cc: stable@vger.kernel.org
Reported-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
Reported-by: Xinyang Ge <xinyang@anthropic.com>
Closes: https://lore.kernel.org/20260525194828.1137119-1-shardul.b@mpiricsoftware.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0098e2830931..709610db3ce9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1664,7 +1664,9 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 
 static void mptcp_push_release(struct sock *ssk, struct mptcp_sendmsg_info *info)
 {
-	tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle, info->size_goal);
+	if (info->mss_now)
+		tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle,
+			 info->size_goal);
 	release_sock(ssk);
 }
 

-- 
2.55.0

