Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4578B3A1691;
	Tue, 28 Jul 2026 17:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785258754; cv=none; b=iunDwNEPzOS5LTFbs/XDqFZ0iPPetUV5tgi8LumTQrF138Y6TBQgaoUV16EY4FMVBMaTyYz2pdVwckfWmY4mbEIDzcVnYldBvuMXfN7An524gxoqJYXrFNq1KhFNzmotLgilrys4BhABKganFSh50+obzOcTgCPvQboNuaaN/CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785258754; c=relaxed/simple;
	bh=Ee+ZUdlvPeC8oOUqX+4znofZ/G/Gth3A0llQg7KuRl8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qvd3BBC6EAcHNbCyAphOXhO8tYs+DVq3qlwV/TtMsLkFtyKys/ioR6vUkaIksUo9morr68yVvdofhmvmSdAi9mHoZdsZ/1kOF6OWqZ6CPI1o1tKoWgfsRtdE5jkM+msG8iPzlVpAF1J3F6RMeWQcWlSEiGbkUA+xR7tiSeEFecw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6FQT22U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6FQT22U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9BF1F00A3A;
	Tue, 28 Jul 2026 17:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785258751;
	bh=S/j1mFgvYIlP4i8duTU+YCkuh9XpJR5giL7Cj1dvYZU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Y6FQT22UE3pbkU+I/FajytSdaCUSuZ4ouf8EZNp5T06+jrtQOCgW+oDdq9BJDhu87
	 QAJCDZDDD2JbXp8IcrE0MJRUeTmaxbeXjZF/AmE34OvKmr6tFdd+mlWd7Y1CwCaDqJ
	 XZQ/YgPoJAzfdHWdWsyWq8beJHu0OwpnyhVYovuWmEwOek1ZacbghSXnNO9QwIM+Se
	 OLhr6gN/HSne3tkEAixWvvJPL6HCWPXbX69mGUt4aNkChJ1T4qnZzVsqtHWJPVKr5I
	 ba51qrFDvt5s5Df0IjVylm95cE1dAN3EpxTqCKkeQb2fHE++cHsCAyYOoO5kZPB2Wj
	 unYN8+xtVTSUg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 28 Jul 2026 19:12:00 +0200
Subject: [PATCH net 4/5] mptcp: fastopen: only mark MPTFO subflows with SYN
 data
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-net-mptcp-misc-fixes-7-2-rc6-v1-4-f7e2d229159d@kernel.org>
References: <20260728-net-mptcp-misc-fixes-7-2-rc6-v1-0-f7e2d229159d@kernel.org>
In-Reply-To: <20260728-net-mptcp-misc-fixes-7-2-rc6-v1-0-f7e2d229159d@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Wyatt Feng <bronzed_45_vested@icloud.com>, stable@vger.kernel.org, 
 Yuan Tan <yuantan098@gmail.com>, Yifan Wu <yifanwucs@gmail.com>, 
 Juefei Pu <tomapufckgml@gmail.com>, Zhengchuan Liang <zcliangcn@gmail.com>, 
 Xin Liu <bird@lzu.edu.cn>, Ren Wei <n05ec@lzu.edu.cn>, 
 Dmytro Shytyi <dmytro@shytyi.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2114; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=F0USe5Pac+45dLUx1tjf4ON3aUyhPCx9SwbxXB50mSw=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIyHr2b17koakepX57nm38MF/OnzueO2qIZ0r7GepV94
 N+FHJfiO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACZyhp2R4czL8kkLExhaP0+Z
 XvZ993T5Ndx615I6+3KdmFktO/ZnLWP4Z9WYMP+ycf0le94868dep+2a5l+aFqNlavLwx9W0RX9
 OsgIA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Wyatt Feng <bronzed_45_vested@icloud.com>

Passive TCP Fast Open accepts a valid-cookie SYN even when it carries
no data. In that case the child socket's receive queue is intentionally
left empty.

mptcp_fastopen_subflow_synack_set_params() set is_mptfo before checking
for queued SYN data. That made data-less TFO SYNs hit a WARN and, if
the warning was non-fatal, left stale MPTFO state behind. The stale
flag could later trigger a state-confusion bug in
check_fully_established().

Only mark the subflow as MPTFO after confirming that a SYN-data skb is
present. Return quietly when the receive queue is empty.

Fixes: 36b122baf6a8 ("mptcp: add subflow_v(4,6)_send_synack()")
Cc: stable@vger.kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Assisted-by: Codex:GPT-5.4
Signed-off-by: Wyatt Feng <bronzed_45_vested@icloud.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Note: a v1 has already been shared alone on the netdev ML:
  https://patch.msgid.link/81f26b8fddd59ebb6cecc417fb138d9ff5214e08.1780458440.git.bronzed_45_vested@icloud.com
---
 net/mptcp/fastopen.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index 082c46c0f50e..f717750906ff 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -24,12 +24,13 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 	sk = subflow->conn;
 	tp = tcp_sk(ssk);
 
-	subflow->is_mptfo = 1;
-
+	/* A valid TFO cookie does not guarantee SYN data. */
 	skb = skb_peek(&ssk->sk_receive_queue);
-	if (WARN_ON_ONCE(!skb))
+	if (!skb)
 		return;
 
+	subflow->is_mptfo = 1;
+
 	/* dequeue the skb from sk receive queue */
 	__skb_unlink(skb, &ssk->sk_receive_queue);
 	skb_ext_reset(skb);

-- 
2.53.0

