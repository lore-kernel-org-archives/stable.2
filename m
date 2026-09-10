Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB13D2609E3
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 00:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788999474; cv=none; b=mNOcCG4irSFntFAxgpG9hu9Cnvf1B60XR1QsZkPM0nXqEix3D/VK+htVFpi+Plk7y6QJZMooolj555IDXf7xrWMFyih4jE1A8RwPQvNC1sH/U7NRCgM/FvB0aDQrDTJouRVePGSdd26hjWausgtX6Ed7yPxs7K6tMzBXa1xU29w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788999474; c=relaxed/simple;
	bh=9dQHn2FR1XRms5B8Y4jLEOtUeZ+SOOkQvoiF72+8qyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DqJDh8F9ERmzzd/t0sRgbZAdIvZa4h8q3DPT6dlPsvlsf1mXDcWkOdZDonxL2OZ6q4R6k+7u+502EC6A7A2UfiOxttC5YQvuVTMW0iMFx2ZeHjmhGyVYQIsiuc66YJIFXfG1SZodVvozQwv4XZdRH/uhpyctbTYDkvxC81r+MwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=buzasAFD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="buzasAFD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E9F1F00898;
	Thu, 10 Sep 2026 00:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788999473;
	bh=R399kpTnmEBK4in+rJE+DAx9GbnJQJl1zOKP5tJ8mQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=buzasAFD1PkXLpYnZ3VaVZn9N0pZkR+HUeIE63cW2JeFlRdDQCwihny2MTKEXxly/
	 +KEohRPErZPBNdbZdJYfjVuaulGcKhR7oLkd3j+jnUcCa06sfbuC75iy09YKW4jHI0
	 5qVjBLbsiaSX0U8TZ+JvAjoMVg3uL7Kt+X8Q41c8ESdN1ukcQfPhquZWEgK4dicYjm
	 v2kKrQjCQ8SgIoN6AgHD1fNx+qff7z3rEuwaGiWyfFPstYf1MPQGeN8PGTZwJuYEZw
	 TeVe/yyg00i2cFMZrBkoyrGup9gBA6y1H21qNY88fFYd9D7hOnysFwWIttb2ba4gZt
	 cuSVbXwje5AhA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hidayath Khan <hidayath@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] net/smc: fix use-after-free in smc_rx_pipe_buf_release()
Date: Wed,  9 Sep 2026 20:17:49 -0400
Message-ID: <20260910001749.3748657-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910001749.3748657-1-sashal@kernel.org>
References: <2026090344-judgingly-mace-1efd@gregkh>
 <20260910001749.3748657-1-sashal@kernel.org>
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
index 33b5bcafdec7d..318ffb372f384 100644
--- a/net/smc/smc_rx.c
+++ b/net/smc/smc_rx.c
@@ -110,16 +110,15 @@ static void smc_rx_pipe_buf_release(struct pipe_inode_info *pipe,
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

