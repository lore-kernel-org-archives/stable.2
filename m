Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BD03E5A38;
	Mon,  3 Aug 2026 16:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785773839; cv=none; b=Nj7OpcyEhbzdjnbFZ4dyyGsuPRCjmxdMzeKE+eQS3SbvPchiJhHyqay1PIYfEimAm5byRfLlPcNcmG2QPargn5Piq7j3J1+kJNaUsRlFWOMIYISQwDJqhEwFFqc2ZwEDxTJkKONCiSW4TW9eeJ633rOKAmggjcKsUK1zKjW+8XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785773839; c=relaxed/simple;
	bh=a50rDkuPZo2+Ajw0lTnGCH+IgCJD/gdXH5g/0VvRJ24=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n3ojUYmaof5+n1mxTc4kX/nmd9K9C5lquJPmLWcsBWwokTzAK7IevAI1iLAocAsgXGXxFGpS08pY2Qz3cq4gbZSvVA775ZzwWN/U3L5LYEW7u45TOO7UZjwmuopswavEFa0WI+Zn1/GDSu8UBoiJGw7ZD0uiFeU2qqpiBVF55Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LtcfDLrP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LtcfDLrP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA8E1F00A3A;
	Mon,  3 Aug 2026 16:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785773837;
	bh=MFsCO3HIEA7tvcBR0h/SaDgADYrMrUwYc79JJ2kD76w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=LtcfDLrPTfb8aMCeNf3qxn8Dxt9gtkybaz4wIexP7zshbyh0E17KhdWOPOmC9FGLL
	 Af97eDj7/orDNhzdNnZWb3BLfY+Y+f6QuNlCL/tQGGhm9KjRuaEKhXgb7ZJuontnSz
	 Y2iDbBKOcfgrBBge9iVD9sD0beL88nE9EYhFx3Je9S9vZHCLUUX6h0D8VNjnrUYH2b
	 7gt/w88FucoW8/a7/sfyaeIaQE8qJzqrfQk0jE/7K9aqZK4d0P9ktbvzJtECSD8OAQ
	 RfWZxJMkjLiMAevPtlxsi+mqvc+wBt1gK8x/MSPIIpnAtiYErO5WNkBvvsqizbTG84
	 pHJxA68jN8ifQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 03 Aug 2026 18:16:39 +0200
Subject: [PATCH net v2 7/8] mptcp: fastopen: only mark MPTFO subflows with
 SYN data
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-net-mptcp-misc-fixes-7-2-rc6-v2-7-b8f496d71664@kernel.org>
References: <20260803-net-mptcp-misc-fixes-7-2-rc6-v2-0-b8f496d71664@kernel.org>
In-Reply-To: <20260803-net-mptcp-misc-fixes-7-2-rc6-v2-0-b8f496d71664@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2405; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=m4h2VvVXoQsxyUp0cTHCmA7BgFqI3pJF+c4g9B5voAg=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIK9n2eG6h5sbvhZbqGAPehXylbrhjz6CU9Xsh02Zerp
 +Vv54ztHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABMxmsfwP92sf5ZR1PTKav6K
 L+wMsdPjLaqA/Or779tfGgZMUedi+Gd7P+3dvvy1yf+Tn85TEfx4RnVf8JLJnQeNM0wW1V68s5w
 VAA==
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

Only mark the subflow as MPTFO after confirming that an SKB was queued.
Return quietly when the receive queue is empty.

Note that mptcp_subflow_context's is_mptfo field is now not just about
subflows where the TFO was present, but about MPTFO subflow that
consumed SYN data. Only having a valid cookie but not carrying data is
not really "doing TFO".

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
v2: update commit message to reply to AI reviews. (Clashiko)
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

