Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5BF2CCC6;
	Sat, 19 Sep 2026 20:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789849773; cv=none; b=cW5CXSgGIGRB6pEs+CrHtK6m5l94JraxOCncdrrJJp7zeCsjXdxIWsdqnKmIMrqoCZuzJcMdgrOsago2fC2A6ZDQ24RR7b3hiktsI6WBjag7MPtT8hm46Qar5xAY0Koa0SQDvdkUoabe6UYEPgGPiMsvc/KcR5mDAJbp3EAePwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789849773; c=relaxed/simple;
	bh=wIQkGPrpNhIPeBtQ1N8sfhUKxd0h+65q0mrZReynOIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dFj2WOR9GoIicMAeWuRl2UHrxiGiF0PfCbX9WvHhQjQRLMJldE2kr4EhasfrczzA/FstclQm5A2VqUS9xKMithElzxHcTk9tYOWjdS4JRsoS8IS02CHziH2uZOPT4BVYVyVMHwLsuXG+cWdGZQ8fo9VVdUzhmJXo0Pm4XMCKUzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ToFvT9JD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ToFvT9JD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F711F000FF;
	Sat, 19 Sep 2026 20:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789849772;
	bh=19uWkkjWrdCxybP4+/+w8dWq8MXHmX5ZLbJ98WpydaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ToFvT9JDiSGqdaYHvWSz+AFBC0Ya8da+FxkaSQFQJnqC/pP4FpRKgtvf2hyM89k0J
	 1cpRBVD4NYoFMoyUb0VlAxcCCc9a/hbSfO4obAF//syU+m0hy3fE71J0sGfXMyYBb/
	 HY5PpX/7t+vbDZ7MSz4YkD7ZQ+bCcs8WElJKcU6kfBjaqPqizJpyzy0NaUr2WTzqwZ
	 59/K/NYT4K0aMq+KiQQjG0AX1lSvHu1He4Kg7vF4J2us2RShq7w7nP/cLhNjKLrJHY
	 /wasNzjtd80ZZ+OnT5/u2UZQyyc6WDVvcCG54K76n8heTNfD7Un0JUQRC8LFxJ1v2P
	 Tz8r1b8dpwwlQ==
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
Subject: [PATCH 5.15.y 2/2] mptcp: close race between scheduler and state change
Date: Sat, 19 Sep 2026 22:29:21 +0200
Message-ID: <20260919202918.2074632-6-matttbe@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919202918.2074632-4-matttbe@kernel.org>
References: <20260919202918.2074632-4-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1643; i=matttbe@kernel.org; h=from:subject; bh=SM1NCJ+XyNa0LwwgpdEzAq2+G78I5l0TBurls9PYHR0=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLWfVi4/FfZwye/AlR0imvYThhKad/o9va3s1rJwKNoz pv6eO6SjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIkIeDIyHPyZ4qyzOYDho6HV /6pjK2YlLS/c5G/2jc24i70wTt0nk+GffscxkeNuz24f+3tLSWL5mnBpp9iChM53vN43kr6+/Rb DCgA=
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
index 42190efadb11..2f18dcb8d034 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1621,7 +1621,9 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 
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

