Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A0A1E7C18;
	Sat, 19 Sep 2026 20:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789848791; cv=none; b=h5vDbQ9d1XXpXSGK6vL0Cc9NKu+mXxJrmJf2ZHkcKoQjm8zJmfok1wXqWp/ijZaaF6nOe1OvdT9j0dM/6sJS0NoXCaDENiye8if/Qw99SzL4IbkEhOsHgZlZctFVn3ejcMNp/P1N5BULADfBhhnPxJbpE+1SRYsEs0qqmEoGAf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789848791; c=relaxed/simple;
	bh=dwhocoWCq7rJOiLDrwA64Y6T/zGO94j072keG0FzDLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RXmvYhpKA7PCsDJg9j+NtgBkZTakjoVrkgiv2SP/DjsjNhCPhIf9CuwiC+g3VS+ETKWolrNfRWJo3zEI74AMs54zapPKgLwHsAVv3siBpxPU3+Y1RPNehpF6gHoZayWt99FieLfZEofZkRXW1uhPCCygB2D9sfeBS3y3X3MYE7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGSmk6Fi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGSmk6Fi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A0711F00893;
	Sat, 19 Sep 2026 20:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789848789;
	bh=VGv5bcygaPAIYafDfFrgO8tRS847RoBkPdxQSzJbqEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dGSmk6Fib+CKh9hvVJMuflpifkMl0u7f7UXLTNN8MJDKAaiCMcpxom9LmIqDHWsvJ
	 LihUGL0uF78KYkTsemKY9rIJsY8eTdExqEJzGeIAyNWBIEJ87GJr9x0+uGRH0AymQL
	 QztpCcvYMOjdATw55Jpw6gv3q7nH36FPuvOKb8eGgkWRHLSiOcUNidqZzwZlCsd4ep
	 wkyxU2mU9hH5o+UEUoO2ts6JjDwIK5tHYdic9dF4u6XeqEs7402FycYGcM41g9+v//
	 QvIR2UFma5HHujlSlnyCck/uK7tTo+W8BKC3JUTYflK4PuzF27N8DIsvGmDMgsEs/v
	 dmQ9EwUcFzRZw==
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
Subject: [PATCH 6.1.y 3/3] mptcp: close race between scheduler and state change
Date: Sat, 19 Sep 2026 22:12:56 +0200
Message-ID: <20260919201252.2025112-8-matttbe@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919201252.2025112-5-matttbe@kernel.org>
References: <20260919201252.2025112-5-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1643; i=matttbe@kernel.org; h=from:subject; bh=YCaJS/uVeKh2uLBYtsClOmVMEQ7iEBR2miH8Bkb8vGg=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLWvTm5fae/hR7DxOVbtx8u5EvTa9rwIuJMRYhbQy3jV EdOzr35HaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABMxKWf47/3F4ULyAlcBI04N ERGuKX93PLFx81V8+N5bJ/5u8/VCLUaGfWv4K64W+Mx2tdoU7n30S1nXj/lpjF+0vJUfcP99b/y SDwA=
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
index ab83cf46a8c3..ca78add7670d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1636,7 +1636,9 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 
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

