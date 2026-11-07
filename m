Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048460;
	b=ggmV/fGA7HTa3E87QH+ON5+eb7L9V118jxFr2VmBOaVacmRDef61ZHAK+FwlwvLAYnz5
	 RbD+VtRAw6tT727drZ07QoJdijSn7q26YqePVI3RTf6zWDq6QsHQh03Zu1FlomzyFuC/R
	 3FntFdelF6aRCZJ9jKSkR9w+gBB/Gb3ZNykRNk+cSkG7wY/7qDE5tbg4chLj7//gtfzL0
	 GnLS208HL/mWDcC4cNU1kL/s/UGCTIQWa2l4pxOr6mtWcdYdSqKlMbxeVnzBvLZg6jXkr
	 hDFFienD8WQM1TixKWiw3Vsdjuzs8DKatzwgB14Fuebit5G8Ul//xQWpX0krh7T6/mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048460;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=9XLLD4U44MVUCa2SctazWrf9TtmUfP35zOI9NwoNCJ4=;
	b=Qd3S5/J5t0eKOdwSZJVq8kEjqmUHKPAA4jaUWL9o7WrOfNKArWMbZwNAEoAky7Rytcnx
	 xtz5QBs5kjaFkcmShbtNyLhU3H79gnJrjMXf0Gglnt5M+G+mVlNj/LjjKmotj5yPvJeX5
	 RIitMfbmMjGVyMnwpFH2xq9Vq8ENz80SUZQCBqHS63hhZxvN6HDd9186P0QARRCfQza+s
	 B+7GXEVA3ttyKetMUI2MkTt91q+QDWTzFeyg3ecrNCHBVGtM9dK2+w6H6Ri1i8hiQLG0I
	 cQTuyJ98d3H31HALNP9o2nDkVAUclQLhB9cs2sVaUszWVt/ELbsOW7F82txoqXR71uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y2RXUJQq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422D4606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y2RXUJQq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567721F008A5;
	Sat,  7 Nov 2026 10:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048460;
	bh=9XLLD4U44MVUCa2SctazWrf9TtmUfP35zOI9NwoNCJ4=;
	h=From:To:Cc:Subject:Date;
	b=Y2RXUJQqPza9HMt+Qmkt8ixqkeWN2DgaSynFarUf3/yhIckEYcl4fFCo+WYAF747F
	 bEdzXWxzO5cdMkoE+OHZ/ReZR0y9xplyF1gNnZOUG9RK93HiFbXJeWzPUWBJDeFF4+
	 GMGtLWqdMLpjXWfW5BkXHm/hwIoo1VQmhvfIBbtJ8Dg4KV3kaSVPtWJMHcATZYoag7
	 laTD94Zd+ujzA7xbqeh0Kx9HxTPs0IQs6Wb54g8VL2HHLYspzOEW+Cm5qirXUTsMYG
	 Uw+9ZLQOF1M8/BoqpQ6vJLlFbhR4XB/gKw+Ngl5kPCv3ybUXsShFuUfdKhLX8plvJa
	 NV4OD173GTSLg==
From: Sasha Levin <sashal@kernel.org>
To: leitao@debian.org,
	akpm@linux-foundation.org,
	sj@kernel.org,
	baolin.wang@linux.alibaba.com,
	hughd@google.com,
	paulmck@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/shmem: report RCU-tasks quiescent states while undoing a range" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:47:38 -0500
Message-ID: <20261107054738-failed-6.1-ebd1a08c1921@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x ebd1a08c192109c83a87ddf42793ed6283180faf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054738-failed-6.1-ebd1a08c1921@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




