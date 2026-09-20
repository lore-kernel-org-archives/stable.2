Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72A83ED3B4;
	Sun, 20 Sep 2026 09:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789897313; cv=none; b=NcWE7y2u/oSHypd8OAZ9QZ+8vkVgHmXINBxnJycsQaPbiMQGcS1CFHvzDo9NEiINHR3cgkkYcox1s77wmlMh3ja686tASw2r6bsCM7fQKDrsxLuRFNNUPF/77s08WHLJTqoMeaueabRmsTOFLEOF8aW48OiaCGhB7NzJfTjUPVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789897313; c=relaxed/simple;
	bh=bmSjrip0R4ION0z730h6r/gyHATsSsgEJh+I6M7HJa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CupA+rmQFlv1EJc375yoeQZ9AnlJQ4NcZOl6BU7CCTt1l86xot9S4HpzmKM2QHBhtWXf/wG78AmAuFOMbOiCd8PZvDtjkAfs/rRzxk+Q32QtxqObzR82SXAVKGx0xPm96eanogSDBqWgSuSW4gbQ4lnBLnS9DXfQJZkBMBA1Abo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/ZJhI4F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/ZJhI4F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69251F0089A;
	Sun, 20 Sep 2026 09:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789897311;
	bh=SGQhVy/Ix1KWEg13IImx3L2eVLgqfe07umBSMIVihfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y/ZJhI4FMq3dIHA4StuOxF7Sddbnu8GxdU1Bu9l4o6tVQ8aKZVMO+wt+9Q2S0lMYX
	 BAI4MRbUnSByMFwULgk23oIhYGzgZSZdRBO/qOMqsmLwUWC+Bag/Aubde+m1DJSoGv
	 1gcj4few1JWH6Pj7KSeT6JqrwPZQkhNj9JDIDV58/8q0RD/0t1fU5W6ckHVsuf5OId
	 7DL3PmBeYeGhwcGgs14reGQJS4kFy4SaAOJHjBRl1MI0hKyTxVog1qhJ34F+bgYtaR
	 mAMwf01ZF/OeB07ft1YXBxkeolJ/0WeEFEzMvCziHMDg3tE5GmkKqlfTiOtAW/9f12
	 tIV35irFSKqPQ==
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
Subject: [PATCH 6.12.y v2 2/3] mptcp: close race between scheduler and state change
Date: Sun, 20 Sep 2026 11:41:38 +0200
Message-ID: <20260920094135.2431797-7-matttbe@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260920094135.2431797-5-matttbe@kernel.org>
References: <20260920094135.2431797-5-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1636; i=matttbe@kernel.org; h=from:subject; bh=1Uq5TXp1CKF/jKqL7YfsUTcPXXbot2SxFy+EEa/xV7U=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLWrwoq1vrYl7Ll8BM57qktTnfzfWcq+Nb4hkqemsRU0 70+hPNYRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwEQWfGNkWGUSxu55Z8K2u9mB +nelH82rFczdadP9d5fKZsV+9huX9Rn+Fx/89O9ett/zxNcpqZc6pLVNXq/IqrhkWNp/3F+6uWc 7CwA=
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
index ff63ba5ee464..1304f3cb6d14 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1567,7 +1567,9 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 
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

