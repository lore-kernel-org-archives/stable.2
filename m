Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0B428690
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789002022; cv=none; b=QHdBbeMNUAhrSyReGNnWr69v1WmYdplUBL0cUKpkGfRp4Gr0C32+n3RKRe1v+TGtGw/YoEKb4Ooct9foqDRkikaN5P59ie+jpPzlCBry4f9BbopbTfLXe8d8x99KXBDdVWfKlf3600vf/Y2qdR8dpQczL07eYCk9BaDrE4TLGc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789002022; c=relaxed/simple;
	bh=tjTfGnTuEDcUfqWOMexZNvMzm3/G9kAmjJgHOO0ZZg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YJI/zJSuDFFIEZN7DWWTVoZRn9lLI+/3xQF8oKNzf3dzMjnCm5sPo3wmxQnCq/0PYHBcR2YVH4rDsJ5ozI+Em+fX7Zkp1JgvFhGOffqfZxVdk0BytZEbz0Y7Tn+3kg0+YJZ3w6kuLNIfXpKnApLonnfZD3WOMT6ZgEz3o5s7BGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzqWvX9O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzqWvX9O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 716D01F000FF;
	Thu, 10 Sep 2026 01:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789002021;
	bh=uMPFcf5Lxfng06dnQNOdlyv7r7v8Umi58HepG7pKh5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QzqWvX9OJH/1VzcnwEuaLHzhtTuEcRHhLH+PRCQGEAreQxkOCyjs64ER/le2gSrjt
	 6GU/0fQSDbb/QI3jAhEXzZwsayqh2VuqTzpGyZVDOYWnyOaRLXquXTItTffssEU1pc
	 6g83PT8BRTj8qqMUvhmkIKW7rgk+SJCdDeBl8QptDNMfmOoCScC2TYEgG15KVa4Gv4
	 u/6QJbMLgOW1xdJ3rPdB/yUwZMazbEMTm28bxthgHL5wFrknVJzLWGqI35Fn5NncZF
	 eE0FaXffJJ4v/F9yOZM7vV2iH8+fleyv4ezP7oAsZmJdBefM6NWvCeUagYqQ+qG3II
	 iMu5yzGn5oQdQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wen Gu <guwen@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] net/smc: Resolve the race between link group access and termination
Date: Wed,  9 Sep 2026 21:00:17 -0400
Message-ID: <20260910010018.3788134-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090345-helmet-chooser-2b86@gregkh>
References: <2026090345-helmet-chooser-2b86@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Gu <guwen@linux.alibaba.com>

[ Upstream commit 61f434b0280ed65495831f1b6e1a5c21a90f47c6 ]

We encountered some crashes caused by the race between the access
and the termination of link groups.

Here are some of panic stacks we met:

1) Race between smc_clc_wait_msg() and __smc_lgr_terminate()

 BUG: kernel NULL pointer dereference, address: 00000000000002f0
 Workqueue: smc_hs_wq smc_listen_work [smc]
 RIP: 0010:smc_clc_wait_msg+0x3eb/0x5c0 [smc]
 Call Trace:
  <TASK>
  ? smc_clc_send_accept+0x45/0xa0 [smc]
  ? smc_clc_send_accept+0x45/0xa0 [smc]
  smc_listen_work+0x783/0x1220 [smc]
  ? finish_task_switch+0xc4/0x2e0
  ? process_one_work+0x1ad/0x3c0
  process_one_work+0x1ad/0x3c0
  worker_thread+0x4c/0x390
  ? rescuer_thread+0x320/0x320
  kthread+0x149/0x190
  ? set_kthread_struct+0x40/0x40
  ret_from_fork+0x1f/0x30
  </TASK>

smc_listen_work()                abnormal case like port error
---------------------------------------------------------------
                                | __smc_lgr_terminate()
                                |  |- smc_conn_kill()
                                |      |- smc_lgr_unregister_conn()
                                |          |- set conn->lgr = NULL
smc_clc_wait_msg()              |
 |- access conn->lgr (panic)    |

2) Race between smc_setsockopt() and __smc_lgr_terminate()

 BUG: kernel NULL pointer dereference, address: 00000000000002e8
 RIP: 0010:smc_setsockopt+0x17a/0x280 [smc]
 Call Trace:
  <TASK>
  __sys_setsockopt+0xfc/0x190
  __x64_sys_setsockopt+0x20/0x30
  do_syscall_64+0x34/0x90
  entry_SYSCALL_64_after_hwframe+0x44/0xae
  </TASK>

smc_setsockopt()                 abnormal case like port error
--------------------------------------------------------------
                                | __smc_lgr_terminate()
                                |  |- smc_conn_kill()
                                |      |- smc_lgr_unregister_conn()
                                |          |- set conn->lgr = NULL
mod_delayed_work()              |
 |- access conn->lgr (panic)    |

There are some other panic places and they are caused by the
similar reason as described above, which is accessing link
group after termination, thus getting a NULL pointer or invalid
resource.

Currently, there seems to be no synchronization between the
link group access and a sudden termination of it. This patch
tries to fix this by introducing reference count of link group
and not freeing link group until reference count is zero.

Link group might be referred to by links or smc connections. So
the operation to the link group reference count can be concluded
as follows:

object          [hold or initialized as 1]       [put]
-------------------------------------------------------------------
link group      smc_lgr_create()                 smc_lgr_free()
connections     smc_conn_create()                smc_conn_free()
links           smcr_link_init()                 smcr_link_clear()

Througth this way, we extend the life cycle of link group and
ensure it is longer than the life cycle of connections and links
above it, so that avoid invalid access to link group after its
termination.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
Signed-off-by: David S. Miller <davem@davemloft.net>

Keep only the connection teardown state needed by target commit
c924884743e948e25625b7fbf3ee2a9325a204a7 ("net/smc: fix use-after-free
in smc_rx_pipe_buf_release()") for this 5.15 dependency backport.

Add conn->freed, reset it when creating a connection, and set it before
smc_conn_free() releases connection resources. Also set it when
smc_lgr_unregister_conn() detaches the connection: on this stable tree,
forced termination may unregister and free the link group without first
calling smc_conn_free(). The target can then use the flag under the socket
lock to avoid accessing either reused buffers or a detached link group.

Drop the upstream link-group reference-counting changes and their new
helper functions. They are unnecessary for the target's teardown check
and conflict with the older link initialization and link-group cleanup
code, which lacks smc_wr_free_lgr_mem(). Preserve the existing 5.15
link-group lifetime and conn->lgr clearing behavior.

[ sashal: Reduced backport -- upstream 61f434b0280ed touches 3 file(s), this
  backport carries 2. Not backported here:
  net/smc/smc_core.h
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: c924884743e9 ("net/smc: fix use-after-free in smc_rx_pipe_buf_release()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/smc/smc.h      | 1 +
 net/smc/smc_core.c | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc.h b/net/smc/smc.h
index 1eee40ec1d969..bae4dcccdef85 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -211,6 +211,7 @@ struct smc_connection {
 						 */
 	u64			peer_token;	/* SMC-D token of peer */
 	u8			killed : 1;	/* abnormal termination */
+	u8			freed : 1;	/* connection released */
 	u8			out_of_sync : 1; /* out of sync with peer */
 };
 
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 995c48388885c..6dc7f265e1170 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -198,6 +198,8 @@ static void smc_lgr_unregister_conn(struct smc_connection *conn)
 		__smc_lgr_unregister_conn(conn);
 	}
 	write_unlock_bh(&lgr->conns_lock);
+	/* Termination can unregister a connection without smc_conn_free(). */
+	conn->freed = 1;
 	conn->lgr = NULL;
 }
 
@@ -650,8 +652,9 @@ void smc_conn_free(struct smc_connection *conn)
 {
 	struct smc_link_group *lgr = conn->lgr;
 
-	if (!lgr)
+	if (!lgr || conn->freed)
 		return;
+	conn->freed = 1;
 	if (lgr->is_smcd) {
 		if (!list_empty(&lgr->list))
 			smc_ism_unset_conn(conn);
@@ -1356,6 +1359,7 @@ int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini)
 		if (rc)
 			goto out;
 	}
+	conn->freed = 0;
 	conn->local_tx_ctrl.common.type = SMC_CDC_MSG_TYPE;
 	conn->local_tx_ctrl.len = SMC_WR_TX_SIZE;
 	conn->urg_state = SMC_URG_READ;
-- 
2.53.0

