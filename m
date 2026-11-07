Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050503;
	b=QQonj6/GkdeMEpT6VX12OIxWzHOsX6ZdCEW6xAebPtE2g2l1gTAu8YQ4hgxBsYEEMxx9
	 0PFgbdzR2seqVUnZzJ0l2bOgcCQAZFbbHu/MqOZ6D675yjYboXVvKlrMyonsulGR06HzZ
	 rNcYhkfKm1k++DJhXSP19Z+tMjuR82b6PL1xr3v1w5cdgIv4ZpCZn+h5xaFIf8wcPQF/D
	 XohV0lyjHQwzWLcT9uzRAP0BiLhRQkTKUAG+UeLZs7et2jYTtpgqQSrjszVyST+3qwABY
	 RAkLFomt92n+I2wKb/ftZ9rJzfxeMcO8/Z0ki8sl7gFIYNNclCVu0Q7qVC2XGUJGZvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050503;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=X0NDkBUj2jyZ73KCh+xGkhZR843hRMX+PwB2TZNnSHM=;
	b=3HL14Fkj8SMvhZ4DkbGiJDPuC8CGRtnpqNkiI/AJ4r4X658/6gSepvR1aF8dpfkCVL4I
	 eCwtN7WDCRxJYfSdMBrCDabW2etWoTVv8WDzIQAHByG2h14xJFpyGpGcxXN/rZokKBDSb
	 kFuEbIhrSSEQvY+vQLL6TYszkjRUqkafuQyodbzEmJeytqoBCIdCc91/WkR0jrlhOHPdf
	 DYZ0PvtKpWC3OuXepBBZfsryltfFlhi7iHxQOCW+zqK6MsCaMq10fMJu7IKdi7D6dMPmT
	 WCLmL+Kx1C95iXkbDVgqdHEhxLbx3SUD+x/obAUxbCOX76WxHmkYR1J/KLLkS0swbyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=okNoC64N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C91606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=okNoC64N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC70F1F0089F;
	Sat,  7 Nov 2026 11:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050502;
	bh=X0NDkBUj2jyZ73KCh+xGkhZR843hRMX+PwB2TZNnSHM=;
	h=From:To:Cc:Subject:Date;
	b=okNoC64Ni1KJCjN8Fs2Q+M8nsDNy3294YTba8ogGpVsHf2bZGxXB2lM/4XrdkrJ3I
	 +GVU/tj/HFEITALsHjmr9ZfmlscTNfdXpH5Kl3xZDMGSsTMvPTsDTvKboGfPaFA0p9
	 YOPm/CgfKVccI9ujVPcQ/MKCIw56BkokBuPghQ0Di+Zz1l1CivfHwPN9pgGizMSIHf
	 86/EU2mcaA4aASWvMHaU31Ml6ALxp+Jhia/YWN8CjIjO48ouxZVwDpP2w/6r+d+swu
	 WF/9oZfatB5pfUYOa5C0jlswCPlCw8fHJQARTc214lntfDOcPqsycJ2Nhffj587SRk
	 LMX4/TGE8myOg==
From: Sasha Levin <sashal@kernel.org>
To: leitao@debian.org,
	akpm@linux-foundation.org,
	sj@kernel.org,
	baolin.wang@linux.alibaba.com,
	hughd@google.com,
	paulmck@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/shmem: report RCU-tasks quiescent states while undoing a range" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:21:40 -0500
Message-ID: <20261107062140-failed-5.10-ebd1a08c1921@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x ebd1a08c192109c83a87ddf42793ed6283180faf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062140-failed-5.10-ebd1a08c1921@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From ebd1a08c192109c83a87ddf42793ed6283180faf Mon Sep 17 00:00:00 2001
From: Breno Leitao <leitao@debian.org>
Date: Fri, 18 Sep 2026 04:24:37 -0700
Subject: [PATCH] mm/shmem: report RCU-tasks quiescent states while undoing a
 range

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
---
 mm/shmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index f33dbf5af2cb7..f2a36a1b53750 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1367,7 +1367,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
 		}
 		folio_batch_remove_exceptionals(&fbatch);
 		folio_batch_release(&fbatch);
-		cond_resched();
+		cond_resched_tasks_rcu_qs();
 	}
 
 	/*
@@ -1408,7 +1408,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
 
 	index = start;
 	while (index < end) {
-		cond_resched();
+		cond_resched_tasks_rcu_qs();
 
 		if (!find_get_entries(mapping, &index, end - 1, &fbatch,
 				indices)) {
-- 
2.53.0




