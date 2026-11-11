Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794406086;
	b=pIsm2pqUmxO5CiYsYXKRsFybsAJC3gVQxXtSE6SoK8eAfDeVM829SnuKtwxIT3R9sO0J
	 umz08ZCwe2tW23rJzkvyjJF7N4JgeKTf2JMsaTpxLEHWLarffi+nfsQYfsYsXKhhxGRJe
	 MqbeMSSHTKIcC4vdb/AEeexW2PfV3VV/tQvVCQ/UC7rK+6U4WnZ1/mG528zK+M5bymF//
	 bYlu9hn35mmb1+vWHup6lqnG52zw7HY5k9qgHW6CWkxdViwpTagwX2mqnXT19VVlYtPb4
	 vOVbVdOMD4B98Z0tIGo2SuGLDztZF2897he/taKf48yZBpn971GXAvstDBKceoF/EZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794406086;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+zTOUYzfG7L+Flt647dCHTAb6advZTr34dWXHE+HL80=;
	b=rOTNFsmELrVXJe6Dc1cfvcqfuBOZ4/AJvCLxe88IwOm3/BOV9BbkTlOgRNZl8DpvLaIA
	 20K2o7lCcr1aOoYIaIrlENE8XH5bqh3naWvrvYsHzu1iec+3/P9bUfPgLg6wUkTloknSE
	 gbbWFczwdVn81yphCm5Xs+saejvtMHle7ZiHKnFTbIkWEMPNdp7LfJ49b+d39B8kLHLVs
	 70DG8RnaQ6n9eaP2bHr/qEl/dkJ4J7QZepdqOYmFRtPDAcagTuOu6iU/qjtgGfqnwVNhC
	 5+oNIGxavxe7/OTDr/4l/uWVKzUh9uuiyO3P0QrwzK32FPiWYr247vzC+0dEaiv3XlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RHIa8Z0e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41302606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 14:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RHIa8Z0e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E29A1F00A05;
	Wed, 11 Nov 2026 14:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794406086;
	bh=+zTOUYzfG7L+Flt647dCHTAb6advZTr34dWXHE+HL80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RHIa8Z0euANxygNyJW92sD6BCK3gzmgP42YN+EJeLVIwGm4sVSFpwNMy66MyghFCk
	 J8nI/y48kc/1Ee+3bFTvFGdQ3MozmQLs6tAzdNlcUG6JHb50YgNvdnSEiZoAuZH8k0
	 8P42SHJxVgISn2W3LUcQ94FnHbvuBGJFFnBrpZRlQVuET/+uzMCe85fEfBCOWqOx8K
	 b4OlXa6J5/zVIMWHdqk8nJsnaGfvN3euCnkozjV915UqKG1ObL1Ee/OhH3xJXNQZfW
	 J1rIh1yN5wyd0DQAnOhhyO0qLX/0JRzH37fXOKjTotsFy5aVqxensUEFihWuSlKWCP
	 Kzp+DfxFAENeQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	SJ Park <sj@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Hugh Dickins <hughd@google.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] mm/shmem: report RCU-tasks quiescent states while undoing a range
Date: Wed, 11 Nov 2026 09:08:02 -0500
Message-ID: <20261111140714.2196934-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111140714.2196934-1-sashal@kernel.org>
References: <20261107054738-failed-6.1-ebd1a08c1921@kernel.org>
 <20261111140714.2196934-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/shmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 420d4e3b79e35..9db6a2488f456 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -950,7 +950,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 		}
 		folio_batch_remove_exceptionals(&fbatch);
 		folio_batch_release(&fbatch);
-		cond_resched();
+		cond_resched_tasks_rcu_qs();
 	}
 
 	/*
@@ -991,7 +991,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 
 	index = start;
 	while (index < end) {
-		cond_resched();
+		cond_resched_tasks_rcu_qs();
 
 		if (!find_get_entries(mapping, index, end - 1, &fbatch,
 				indices)) {
-- 
2.53.0

