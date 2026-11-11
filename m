Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794406255;
	b=b6e2cMUXQAMlZOjW0s76qk0Q3Nxbohnmz/QXH2nyXZUdB8AwYzrBPzRL/fpwy7/VaBsz
	 diw1DfznHNSAveBVH/oZQOgkQ5s0DIEJbayJnPf/EIZHMqckTrWHEg50ZJ/haBh5NvXiT
	 DFp5nNC9dmDzWjbNg6PSWOe5TPnXpyDBOehqEtXulxYNjfjUcjVCQTzZnDBFl5cl5GbUp
	 7v2zzpKFUiaCCA1SYrDgDBn1wn3q6o/JRAVksRK2xXYiO8Qe7siPBdqO/tmHNxpiCeUDf
	 PO2VmC44E+FTQqBOK8dTyZpq9p8Mw7tXDfnHmPSH9xgWDF7TQdH9txBww1UVppRAf5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794406255;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=U0DixsvNmtGQ63u1DSL+6Bk0EbD1jgI1Oc22cehfHAk=;
	b=Ndn1YjP5tYy/dyMHKqRasA7QAPDicngaMSa8h0l4DlRpsw/9Lezut+TNrCOzLVfXsPEs
	 SyM1KtsmpayT6R68ABsoSjX8/5UyJoxbee6lVoB1bj5f91GcdjQ5VLFZsl9Ado1TtEbLF
	 AtJc25HlnDL3yBd0XPfS6RhmN92T3WXXnfAqabAo4X22X5KUqibRHy5RCgDclBUTC75Hz
	 jousCnvLthLggtNI7cgpAKEzobjyFO0r5tA+IUyo0qIMPLGDiNboQlnVC240blkgBT3+b
	 2xydvPJ3bXgf9nLRtYhCSqKpp4LLrbo+Oik4APzv7eLTeoVOUQAR3QLduhw282LW3Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FCXHkSoj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46DE606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 14:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FCXHkSoj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB051F00A05;
	Wed, 11 Nov 2026 14:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794406255;
	bh=U0DixsvNmtGQ63u1DSL+6Bk0EbD1jgI1Oc22cehfHAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FCXHkSojEbhf3LyA03GKPSE4bmSce9zN7FU7f3pNT0f0HwiVn34H+oifZ01/mD04h
	 kDE+BSuDVz49usTOqwi9B1SPb1XwKZy0464ZL1U1U8TyNJcrnCi0tT1LZOFRhdKqyj
	 mdMmnOtFN6/06RQB/yOvIf656GDxv8PJffN58ZC2jairkafFJ0uRS0zVxuO5m3aQqS
	 uBboCZ+GnievLbvomfjZc8TxEo97S/K7qowdCwymmyu1npPU9kMDtRexlQirq44iPw
	 QG3dp2/JnmyoZtKa05xfdmLWasaobodr4gi9/fuEz/iddohqq5A5jdSqDY17/a9T0N
	 STPnsWfeMqlNQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	SJ Park <sj@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Hugh Dickins <hughd@google.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mm/shmem: report RCU-tasks quiescent states while undoing a range
Date: Wed, 11 Nov 2026 09:10:52 -0500
Message-ID: <20261111140935.2257561-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060459-failed-5.15-ebd1a08c1921@kernel.org>
References: <20261107060459-failed-5.15-ebd1a08c1921@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Breno Leitao <leitao@debian.org>

[ Upstream commit ebd1a08c192109c83a87ddf42793ed6283180faf ]

This shows up in the Meta fleet on ftruncate() of large tmpfs files:

  INFO: rcu_tasks detected stalls on tasks:
  00000000752fd185: .. nvcsw: 59455/59455 holdout: 1 idle_cpu: -1/0
  task:rocksdb:bottom  state:R  running task
    __folio_split
    find_get_entry
    find_get_entries
    truncate_inode_partial_folio
    shmem_undo_range
    shmem_setattr
    notify_change
    do_ftruncate
    __x64_sys_ftruncate
    do_syscall_64

shmem_undo_range() walks the whole of the requested range in folio_batch
sized steps, twice, and its two cond_resched() calls are the only
reschedule points in that walk.

cond_resched() is not an RCU-tasks quiescent state.  Use
cond_resched_tasks_rcu_qs() at both points so the walk reports an
RCU-tasks quiescent state as it proceeds.

Link: https://lore.kernel.org/20260918-shmem-tasks-rcu-v1-1-79acf91a2569@debian.org
Fixes: 8315f42295d2 ("rcu: Add call_rcu_tasks()")
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: SJ Park <sj@kernel.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>
Cc: <stable@vger.kernel.org>
[ sashal: adjusted context for pagevec traversal instead of folio_batch, preserving explicit index advancement ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/shmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 06ed84ebdf3b7..cc5b08d9802cf 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -962,7 +962,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 		}
 		pagevec_remove_exceptionals(&pvec);
 		pagevec_release(&pvec);
-		cond_resched();
+		cond_resched_tasks_rcu_qs();
 		index++;
 	}
 
@@ -996,7 +996,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 
 	index = start;
 	while (index < end) {
-		cond_resched();
+		cond_resched_tasks_rcu_qs();
 
 		if (!find_get_entries(mapping, index, end - 1, &pvec,
 				indices)) {
-- 
2.53.0

