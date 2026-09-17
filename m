Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33233513576;
	Thu, 17 Sep 2026 13:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789650385; cv=none; b=dw8qtIq6mQ8b5NVHJ4H1ZSOt3Hw5BXY22ucASOvKxaqhgvuNNhWvh10/zrowZJTjOKJl4z2H8/k+4bKxOX3jxsgk8rFXHPHZ0jWoeoHao1CCycw9DLmYGFWpnYg9FxlSM8Mu8zbxKtiXBVdoW4W35Wv1hm1P7ECbTyhshTi7C1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789650385; c=relaxed/simple;
	bh=9w+WvPJ3aYLp6/wS57Jaw4mb7DboOndjnFZXPTxC+Io=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FnGFkUIWTfiHkCdX5JYmEdTNuNBjpEm2D+hYYMCu+58Gmph3UUx/MFjKqZNsz4r8qXHNlvcYXkDkoSM8P1kISqMfTDXI4s5zQxYawCDo9XMCBnEsIXAzN1WpAoqNcbwizTldwrTm9dS/m6CxImTqMK8Y7Frr6fuAUzQ/2QifWWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0G4MVG0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0G4MVG0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE891F00898;
	Thu, 17 Sep 2026 13:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789650377;
	bh=ZKTqy+1rn/oN3Z6QFh4uh2VTISqwBFW4uCXZoAX0i+w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=S0G4MVG0RK6xFMse93B3m1CE6bQOgHD4vfy2AXzWTgXDcxsjsMKPOmgF3JRZ7kka9
	 BSPpdXThzmIA1QFyfpvpNMitA2gts2XA5qxRk8Eo+Vde8FtOwXOa26XJvzwb4Yy7+3
	 ySnrzgeLHc1Qb5YeAk2kkjTYiePdKKGDBXZNhw5VlOWp9Cr3LTmwn+GnN/0XDHa3Y2
	 GBiDJyOnuIv1n02nTT6by8b5G/KVBM0G81/ke0Pr7L5J67d3w3Tcrkfab0uuP7sp4o
	 n/iZRAWY7iQ18tvvhafNeksm+CrU/P17spo8n9ghDI2yuKkH1Za5H6SFXBhAwsxz3s
	 wmR7aQFSmCkFA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 17 Sep 2026 15:05:58 +0200
Subject: [PATCH net v2 2/3] mptcp: close race between scheduler and state
 change
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-net-mptcp-misc-fixes-7-3-rc4-v2-2-0cf5c72667c8@kernel.org>
References: <20260917-net-mptcp-misc-fixes-7-3-rc4-v2-0-0cf5c72667c8@kernel.org>
In-Reply-To: <20260917-net-mptcp-misc-fixes-7-3-rc4-v2-0-0cf5c72667c8@kernel.org>
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
 h=from:subject:message-id; bh=Ola5B1/PLL6OtlWpXMLg0kumciF1N+qOuxhUivE0uDw=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJWPz0whecR74ugGXZzChc9XvbANaOBRyRn6/9b31a6m
 nw42n+qvaOUhUGMi0FWTJFFui0yf+bzKt4SLz8LmDmsTCBDGLg4BWAiu4sZfrMudCxxORqoXfgh
 rOQXU85aszQDrYYVk0JOqisKPwg5f43hv9MyhZ3/jhQ7bPuvIFnDs21bg9irFTylj/lXVdhIC31
 nZgAA
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
index d9fc3be9d2db..577d0134b9ec 100644
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

