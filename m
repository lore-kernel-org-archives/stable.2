Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2987137C923;
	Sat, 19 Sep 2026 19:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789846572; cv=none; b=LRK7heq/4+Fx/YBpF6eYfRaPCG/ePXLeT20fzMY07pq5RlMsBfZQLV2pQsPAOTPJjYHksWX/kb1v47fX4VnMKcfIh0LHCHQvsJs0VGbv20fI8Y3Rw5ZnnlnemYzUfbLe8/RAIlKlGUB5jvMpbCMJa4De63JmFMMN1scrapUoO4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789846572; c=relaxed/simple;
	bh=CN1/SK+Y8yFbsameLPvNWaUmOIDS2T5f+NmuRjL+7hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bwj3VIEnl0MCvSxmgjqt8wavJqnW8zJwxE/BQGLY0KFfouE4INrzvH4NTBbzuu4FFKxZOj/nZzyz1R/LqsNVks4IsQrQg92CWY/T4PclCLXoiIjFUq9w2hfI9TD+UjYjhdk1IbHKIwff09pGMFwLB+8fMH2DAoap+3kSb5oUDGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kz85fqWn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kz85fqWn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89AF1F000FF;
	Sat, 19 Sep 2026 19:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789846570;
	bh=5xA+FJH7GWS4YusAZCGPKyUllf//BAWDWX7tMuc6SeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kz85fqWnWw6OCA4hFNZA1BvCgQNmnt1kpGJu7R5DgixImfLhdokvhMg6cP6DLp0ht
	 ZVwqsWD7zpdDFGj9kKWxwpLfYkEZdYMYIbD/fEoLPpdpoA8ufxbVQj6uBWUHTtyvCl
	 0f2jzmeJK/rItfHUekuGVAE6pJUcPpgSA6MKEc+fTjkg5zPX2H4bAV2+A9mdQCeXwz
	 BO/66qGm34QbETdgnYhOVTq1f22o+WRLvG0n4eLnFtQqTMiNHRrdPBFuqGrjrzJulk
	 xaaiqE5k+Ly455NCG5Q9/KDj/ecasy0M796UTGO9GcOGYBon/diaYlEQHnic09jJsv
	 FKNGzzOhafaKw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	sashal@kernel.org,
	Shardul Bankar <shardul.b@mpiricsoftware.com>,
	Xinyang Ge <xinyang@anthropic.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 7.2.y 3/4] mptcp: close race between scheduler and state change
Date: Sat, 19 Sep 2026 21:35:45 +0200
Message-ID: <20260919193541.1915297-9-matttbe@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919193541.1915297-6-matttbe@kernel.org>
References: <20260919193541.1915297-6-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1636; i=matttbe@kernel.org; h=from:subject; bh=+/aiUzZzfqJ31ICMVpIbl3dR0DbObCOaPqDPmlz8uUU=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLWPRH8p3ek5VnAc6kdx3tXr19TxLud4TDD7H+rpm7N5 83by/Rco6OUhUGMi0FWTJFFui0yf+bzKt4SLz8LmDmsTCBDGLg4BWAiJ8QYGRbW51fn9W0ovxn8 5rBGtQS33DK9KQXGpYuOpfntf2rjX83IcIfjVOtN7Y4ngnctRSbOeXcj8N2Vqnk1tixrc6YxhrN q8wMA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

commit 42064de57fb83231fcc89663a94885f228a1ee53 upstream.

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
Link: https://patch.msgid.link/20260917-net-mptcp-misc-fixes-7-3-rc4-v2-2-0cf5c72667c8@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b6581858979d..99fd31036222 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1588,7 +1588,9 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 
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

