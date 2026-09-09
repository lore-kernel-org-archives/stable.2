Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7772538C2A0
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788975191; cv=none; b=QXMOLzMJdUYAO+XEnugbj3COqzK/4bQtz885aTIGzUeWge6taZeJpUENgz9YJqKQrgBhKjIbJfSqNKQV70RrhWAJ7g6++iy/x+Gn+XIcextLGbwToafAXw/DPm0eyCZpZhmMYDOl1DvaMnMYSAFeztbIGr9o9ZBaOx7lU3e+QjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788975191; c=relaxed/simple;
	bh=a9BBkExL6A+Pyjg8Fk3d8JOxJ6Ky2eYRS5Gq2M2W5dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JTpPsOMW758LNoZJNvGANBD2A3DJXCzXOrEwcp85FrTYu0RoMXb0qxcRn63PT9IJKUPSSBMTmxY60fMWNC0hxfnUsHMu3p20uWovrSM47YHDIwrs7ADMIIvRAeJQ0sUv51ICRK/e6WnJycZVbPjI6pn/Qc9rPlZG5Fw7WxzKXPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9ACr88s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9ACr88s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADDF71F000FF;
	Wed,  9 Sep 2026 17:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788975190;
	bh=K5v2w7H2Vpi91Zk71CHwNBix0/pEUwS64rX4zY6MKHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H9ACr88sGqJgbssaByFP9gQQoghKln2ZyYvsxvD263uD4lmNrC5CSsRWpq2osNGpY
	 MxczGIl+I+jVRG0d2B273MojMwfDMINOZvjI1dWUBUr1f8Xgp1/ZA8e7Go5M1CZVMG
	 pq3PK/dMkSP4ycKpQ1/IUppYD1hRutwPcIR6mJCEmafLw4n/ffj0mrBlrZs0b8kG2r
	 JtvnUO6F8tCAu1et72Uwxzf10JfmEVjb5/DyxxXadZz4N74zy1enSP6NkJpQJTBX0C
	 Nn1OGwwO6KP9BQl3S15KeI6vdYqOp4o1eDvSJQ8U/rwPO5wY2N2Wegaa02O9ZvUGgq
	 9byUMyO2mTaMw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hidayath Khan <hidayath@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Breno Leitao <leitao@debian.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] net/smc: fix socket refcount leak in smc_switch_conns()
Date: Wed,  9 Sep 2026 13:33:07 -0400
Message-ID: <20260909173307.3302296-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090344-afraid-primarily-b3a0@gregkh>
References: <2026090344-afraid-primarily-b3a0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hidayath Khan <hidayath@linux.ibm.com>

[ Upstream commit 719296c4aa8213d4ac8002e77d5956d436bc98d0 ]

smc_switch_conns() takes a reference on the SMC socket before dropping
lgr->conns_lock, so the connection stays alive while the CDC slot is
fetched:

        sock_hold(&smc->sk);
        read_unlock_bh(&lgr->conns_lock);
        /* pre-fetch buffer outside of send_lock, might sleep */
        rc = smc_cdc_get_free_slot(conn, to_lnk, &wr_buf, NULL, &pend);
        if (rc)
                goto err_out;

The err_out label only drops the wr_tx link reference, so this early exit
returns without the matching sock_put(). The second error exit is not
affected, because sock_put() has already run by then.

A leaked sk_refcnt means the smc_sock is never destroyed. Its send and
receive buffers stay allocated, and for a user socket the reference held
on the network namespace is never released, so the netns can no longer be
torn down.

smc_cdc_get_free_slot() fails when the target link goes down or when the
connection has been killed while the switch is in progress. Both are
reachable during the link failover this function implements, so the leak
is triggered by the same hardware events that make smc_switch_conns() run
in the first place.

Restructure so there is a single sock_put() covering both outcomes,
instead of adding a second one to the error path.

Fixes: 95f7f3e7dc6b ("net/smc: improved fix wait on already cleared link")
Cc: stable@vger.kernel.org
Reviewed-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Hidayath Khan <hidayath@linux.ibm.com>
Link: https://patch.msgid.link/20260820144729.1019399-1-hidayath@linux.ibm.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Replaced smc_switch_link_and_count() with the existing conn->lnk = to_lnk assignment. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/smc/smc_core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 995c48388885c..c138a0ab0369d 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -582,13 +582,13 @@ struct smc_link *smc_switch_conns(struct smc_link_group *lgr,
 		read_unlock_bh(&lgr->conns_lock);
 		/* pre-fetch buffer outside of send_lock, might sleep */
 		rc = smc_cdc_get_free_slot(conn, to_lnk, &wr_buf, NULL, &pend);
-		if (rc)
-			goto err_out;
-		/* avoid race with smcr_tx_sndbuf_nonempty() */
-		spin_lock_bh(&conn->send_lock);
-		conn->lnk = to_lnk;
-		rc = smc_switch_cursor(smc, pend, wr_buf);
-		spin_unlock_bh(&conn->send_lock);
+		if (!rc) {
+			/* avoid race with smcr_tx_sndbuf_nonempty() */
+			spin_lock_bh(&conn->send_lock);
+			conn->lnk = to_lnk;
+			rc = smc_switch_cursor(smc, pend, wr_buf);
+			spin_unlock_bh(&conn->send_lock);
+		}
 		sock_put(&smc->sk);
 		if (rc)
 			goto err_out;
-- 
2.53.0

