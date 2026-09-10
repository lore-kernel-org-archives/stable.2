Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8862C0296
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789002023; cv=none; b=S1rF41X0kqqkRPF3QDkl3Nk5VpeRa3dekEL1RkFCS1+dvRgEmLNRgM2AeEwgfJeTiDYuzV0e8gBZELlQe3jqf8jjrhgEiBAfxmwX4tVid3Gq8r99gs/6ME7OTuhsFubES6CiXwftgqbRAT+gU0Zlx31m6DjwH3N2HJcMHQtd9/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789002023; c=relaxed/simple;
	bh=vXgtmFF1NlBxjAUiNHA5itlzQFxltZRnKvWoeqThnNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ciurAbe9jSTGnn9dxcBpNT3na32KsMraa68mofdL7GJdyR8kijJkVpm4MWxLSzYQ6PJK2C2hflwNkf051nmZChKuCwcuDOjcJnhQipZtBPH+r0HfZDpau8szPp+WgXyEHwHwqeZWBUhQRIhmOGqV1mtbBoixxg6jc5sP5bFFPlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBDq0LXc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBDq0LXc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3780B1F00893;
	Thu, 10 Sep 2026 01:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789002021;
	bh=uaHGyOI2fA8hq5FHKJa8zfEuBYix08B2pPH5bXgiW6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jBDq0LXcViOlPpsz97RO1Uzl0/+iCRqgkF2M+g+3saIdCPv0ISk8Uq5lFV/w/DbVB
	 pO6QL44tYPM0M0qhxjV/xgEoxFNhccCquAu1S7cHr1j88bfAk1qaf+GFyBv/wQsHjo
	 +07CWsKT7BobVv7CZ9KPa18hT4oGyiYkZRG91BtbuoSmHguS26grtHdQkpG/Qnnj8N
	 2wEd+9VnH3EqKjrb/eJHLSTLMsdvPX6bBwZPeLuOa/FKuAk1cR8qxhPO0YyaclI41j
	 AZC6tKWCgLD9fQuOlutEHaHMBMJ8lwy2qzib6jlYq4S4YOJa9riPANkWw85/6lsYLn
	 Y8q0QkQGwXHlw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hidayath Khan <hidayath@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] net/smc: fix use-after-free in smc_rx_pipe_buf_release()
Date: Wed,  9 Sep 2026 21:00:18 -0400
Message-ID: <20260910010018.3788134-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910010018.3788134-1-sashal@kernel.org>
References: <2026090345-helmet-chooser-2b86@gregkh>
 <20260910010018.3788134-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hidayath Khan <hidayath@linux.ibm.com>

[ Upstream commit c924884743e948e25625b7fbf3ee2a9325a204a7 ]

smc_rx_splice() hands RMB pages to a pipe and takes a socket reference
per entry so the smc_sock stays alive until the reader finishes. The
connection does not: a concurrent close runs smc_conn_free(), which
releases the receive buffer back to the link group pool.

smc_rx_pipe_buf_release() tests sk_state before taking the socket lock.
The state can change between the test and the lock, and
smc_rx_update_cons() then dereferences conn->rmb_desc and walks
conn->lgr, which smc_conn_free() has already released. On the
is_reg_err path smcr_buf_unuse() frees the descriptor outright, so
this is a use-after-free.

Take the socket lock first and test conn->freed instead.
smc_conn_free() sets that flag before releasing anything, and every
caller holds the socket lock. The two paths exclude each other: either
the pipe release runs first with everything valid, or it sees the flag
and skips the update.

Fixes: 9014db202cb7 ("smc: add support for splice()")
Cc: stable@vger.kernel.org
Reviewed-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
Signed-off-by: Hidayath Khan <hidayath@linux.ibm.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260820074642.966856-3-hidayath@linux.ibm.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/smc/smc_rx.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/net/smc/smc_rx.c b/net/smc/smc_rx.c
index 343bdab3b5077..9ec9a18dc96ee 100644
--- a/net/smc/smc_rx.c
+++ b/net/smc/smc_rx.c
@@ -109,16 +109,15 @@ static void smc_rx_pipe_buf_release(struct pipe_inode_info *pipe,
 				    struct pipe_buffer *buf)
 {
 	struct smc_spd_priv *priv = (struct smc_spd_priv *)buf->private;
+	struct smc_connection *conn = &priv->smc->conn;
 	struct smc_sock *smc = priv->smc;
-	struct smc_connection *conn;
 	struct sock *sk = &smc->sk;
 
-	if (sk->sk_state == SMC_CLOSED ||
-	    sk->sk_state == SMC_PEERFINCLOSEWAIT ||
-	    sk->sk_state == SMC_APPFINCLOSEWAIT)
-		goto out;
-	conn = &smc->conn;
 	lock_sock(sk);
+	if (conn->freed) {
+		release_sock(sk);
+		goto out;
+	}
 	smc_rx_update_cons(smc, priv->len);
 	release_sock(sk);
 	if (atomic_sub_and_test(priv->len, &conn->splice_pending))
-- 
2.53.0

