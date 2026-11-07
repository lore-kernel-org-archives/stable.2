Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049502;
	b=lDQueI+oV4aU0GMCp4vEI03cSIFb7RSDd8S694fnWTRmtQwx7dC3Qwjawiq6jYmtFgpP
	 lKbLNQvoOgzKKobH+w4tjN4DQIrl3RqBy+nyityrTK0CFQ8+6zuej2c8BjPLiVby19IxT
	 /vobwjD+d7c/TF2uGXVRDINoIutRWNdY4KA0xF2L/wFTfGab407esb9fZIPVnkRN1Y/+j
	 s/lpxWDMgYRsfwPcoS45d2ZSIcODsYjqbPO2sybK9GwDasnQniUVZGYttDF4tlO7cp+8c
	 +3fGIflEaPd7YFCpW6EIARR+RBZdNGdz/ZOJt5TP5z//nM6J6qU0IbVzw8NUBKwrtxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049502;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=mxibyHZFt007KtnQlk9X+etA8jbYnMSnqotkEo5Q4/A=;
	b=MtVvVMnW4G54VB5kY2BbNipWs/rh5J9kqMEdrOTdtdSlcP5ERa28+TYaQgKUALwIjAAT
	 k48Kpk4DplPFq3ZNPeNPfolppWievgVb8/w0EMCen3kWF3Crgb/cJ75lTyvRhTh3MBfsJ
	 U31eF6TA+NoX+IR47BsqpQhI/kWCa8GIH8HDJ/75+4r/29J/TwR4HiwyKXtOln/ngjTYM
	 j/RJ/VMGQOkvvIyyxIXsKcPpTP548V9G5idE414r9FecWn/XBSe5k82iFtZfY09tWav0D
	 6MddyQE5n8/X37GQiqwpGVMt8nk5ELA9bYvMKqYk1w8J8U/XNALu2cHFj20MVoI2m+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OYIPwDnk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B31E606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OYIPwDnk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431041F0089F;
	Sat,  7 Nov 2026 11:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049502;
	bh=mxibyHZFt007KtnQlk9X+etA8jbYnMSnqotkEo5Q4/A=;
	h=From:To:Cc:Subject:Date;
	b=OYIPwDnkrH8FIz4ybHF+AxQJoqkG1916zkEkGoG7aLuYGE8Ej//aiV4iZOboOcsxE
	 HQLT5v0zqTYJ18DllSc1XlmUotcDn9/hbTmPMj8Po13g6LJtFEqolAbHPVlvf131s+
	 NtJrcbKaie0BVFoQeVXgEvpbuYx9VkO5gVCy0zSU5LnaxWKmJFr2xI6MCeOtZArJGe
	 g4HUFa3Kt55nWJK+cIhHBG3CXx+pfprKPVuzu/QL+hTDlahg+lwCCjjJo2Cym/0Uuu
	 4Qe1pAiyoXUFyU47Z1FgfWx2F1XKtOQJWAzYQwnZ1cNr4rbOgXYG+OorAo8nbhmNXv
	 NPBivMaxi7W+g==
From: Sasha Levin <sashal@kernel.org>
To: leitao@debian.org,
	akpm@linux-foundation.org,
	sj@kernel.org,
	baolin.wang@linux.alibaba.com,
	hughd@google.com,
	paulmck@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/shmem: report RCU-tasks quiescent states while undoing a range" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:04:59 -0500
Message-ID: <20261107060459-failed-5.15-ebd1a08c1921@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x ebd1a08c192109c83a87ddf42793ed6283180faf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060459-failed-5.15-ebd1a08c1921@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




