Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA151F94F
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 00:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788999474; cv=none; b=rMz8Rxndy41StsZrUbb9bXoVw9luhs8oY8piYqk9Y6ATklqFIeT8NrBi6pfwoa/JbD3DfzDoReR9gR82pLVsASPvAzBnEneC39PlVbs4sG+rkSYb0+sunFJGeN9XBH/259JdTle3SQgWUk77cvZ+a3U6Rasv9dOW3aqB45ar2hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788999474; c=relaxed/simple;
	bh=dedaetYgx+Pv6yRC5roWb7VS69RFrzR9nQB/vfA79RQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j1TUjLdWSdu2E69biPEu57ZvuVkjVz5ThqnI1Y8f6FGu5fXCxXB4M2XOOcZ4FK6aVWlGh4tG9gu2be1VETeMpFfqnEQS2/A0ISi0DxEY57ChXrN6eg2uDym14+yGwtVjf3AFgqwCDKV9G6OWl31Px6uViw2E1tPps4to1HlNiw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B55MkpYW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B55MkpYW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B371F000FF;
	Thu, 10 Sep 2026 00:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788999472;
	bh=VeL0ioTRpvYx0yYlh/NelWsM1wlngamNYNj6IFYCXyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B55MkpYWLHwl98pwvwUCRcyDm9ebCPFCsnfjMhetzRSIQmMcAe/Lcfbcv9gDE/qWN
	 PTdScsUmYpJK4rgLn3i6lFBIawhCzY3h3d6FePT9s/kffOCudyeatxfbvoN7E6pFWi
	 A6Lj3WSipQvVidWAJF4agb9Is6Hh7xXFU4V+HkVaTN7/GCCK5tOO3uEI1Yy694E0jC
	 eOxam285NKekvLO57c/P4uvALr9nmVnjicJ9iSCN3YwPuXftNGKrt8sgajkx463L1k
	 hHiRQC+5FoWvsXSyZ6o3mqULl0gKVBGkZx1KJxp9+yo/DN7IyIzpMN7RjNc0xIXERN
	 iI47u+k+1g6CQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wen Gu <guwen@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] net/smc: Resolve the race between link group access and termination
Date: Wed,  9 Sep 2026 20:17:48 -0400
Message-ID: <20260910001749.3748657-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090344-judgingly-mace-1efd@gregkh>
References: <2026090344-judgingly-mace-1efd@gregkh>
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
index 6455371430a3c..339a467c03d02 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -217,6 +217,7 @@ struct smc_connection {
 						 */
 	u64			peer_token;	/* SMC-D token of peer */
 	u8			killed : 1;	/* abnormal termination */
+	u8			freed : 1;	/* connection released */
 	u8			out_of_sync : 1; /* out of sync with peer */
 };
 
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index f6119f29b44ce..c2a8fc7a03ff8 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -217,6 +217,8 @@ static void smc_lgr_unregister_conn(struct smc_connection *conn)
 		__smc_lgr_unregister_conn(conn);
 	}
 	write_unlock_bh(&lgr->conns_lock);
+	/* Termination can unregister a connection without smc_conn_free(). */
+	conn->freed = 1;
 	conn->lgr = NULL;
 }
 
@@ -1049,8 +1051,9 @@ void smc_conn_free(struct smc_connection *conn)
 {
 	struct smc_link_group *lgr = conn->lgr;
 
-	if (!lgr)
+	if (!lgr || conn->freed)
 		return;
+	conn->freed = 1;
 	if (lgr->is_smcd) {
 		if (!list_empty(&lgr->list))
 			smc_ism_unset_conn(conn);
@@ -1740,6 +1743,7 @@ int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini)
 			goto out;
 		}
 	}
+	conn->freed = 0;
 	conn->local_tx_ctrl.common.type = SMC_CDC_MSG_TYPE;
 	conn->local_tx_ctrl.len = SMC_WR_TX_SIZE;
 	conn->urg_state = SMC_URG_READ;
-- 
2.53.0

