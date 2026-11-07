Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046121;
	b=M4jC2uRrvPgKRg8b4WYnDNAJIQQAHXX0x7gXothX7rcf0ToRrqFhKtLI+XP/XEs0k8oe
	 LJDiM8D1nF8LXD07sC3A1pfLExhwvqarQz0hg5FSGABhF+AR2AIHgpm77uazl+5O6VM3Y
	 H3SYT5ux5yfuAQ3QGj7kGo8xpl5sbqUuxhx+9rueGFvB4jYGDUE6obWcxrKttGswkWrxC
	 6KekNyEP/Dtv+428I77LkioIWgQEq6gLA+R1mWB1TtUuKscm30Ctaa4xZL++5xoZ1pJqx
	 s3ivH1P2/tEchyLK+8F+4/zEnyT3pVc/W82V9iZI1AHHuO15hNEKffiodF7tTTjBnyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046121;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=9P9JC2N5SVnSD1mOn8EgQe5yjcvVZOshqDaMuJEorxs=;
	b=YcrhW6cGTR5kpX0A2GL7v3zzUJKpNhfpvMjLHRf2v/6/pupqNXNIC4iUe+u2sI1SJA27
	 Xh/Do4xifN9UoDzn3K2tZoQKE0XsL40TArEHF7OTstkd0cDHpYAcSnpbYtxx6147kdFtC
	 k9Hw14NgqEwQPnm4k2MsuBV0NQfJCefLSadiKtW03VaeEbmKrnO+N1goxcbKRrhclDDbg
	 pRuqL1F7XANvB4sWUDXyN7DTEyosAENgkb3/HypkFlx5H2xYr3mvJcDk6/6pFNjYnmqX2
	 ZN8tT9Xi9WrvOAtWjBXEx4+ZRWs2f3ZQhvEw81c/e4P/YSDxyLPiIbeIWlpmPGZPJnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G44qzpCu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BDE606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G44qzpCu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C7701F0089F;
	Sat,  7 Nov 2026 10:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046120;
	bh=9P9JC2N5SVnSD1mOn8EgQe5yjcvVZOshqDaMuJEorxs=;
	h=From:To:Cc:Subject:Date;
	b=G44qzpCu53gp7IMxrJWxu2Gz1SoXbUkYEvoEGcIW9x/sJbZHCJVj34EfEsiCOrM6y
	 gSaw+d0HW1/Qr120Ax7K0NkypdzaYC0pxU5bmNZ0+CChcRc07WmkDjrBHZW6q81Ach
	 jorwk3ldcQF7rOBJSXk5baGZT3Z1fv5eghbDIkqwMOdTWeDqxQkGhDT25A6F8oO8Lb
	 IGf/9+IImZzvbYBs7laBB+LmCRj9+3mRu0jdZsAk8M02+79f8fRKhxBSaG9MN/UHjr
	 thowy4m9RLZpC2Vkfs63Thjl1VTcrq+iL6OStb0Bo/TTP1ARp2HfFIcEI3Nz7+gW/v
	 sGygXsu6x5jcQ==
From: Sasha Levin <sashal@kernel.org>
To: jiayuan.chen@linux.dev,
	akpm@linux-foundation.org,
	muchun.song@linux.dev,
	hannes@cmpxchg.org,
	mhocko@suse.com,
	chrisl@kernel.org,
	jack@suse.cz,
	axboe@kernel.dk,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	tj@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/memcontrol: fix data-race on reading jiffies_64" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:08:38 -0500
Message-ID: <20261107050838-failed-6.18-c20cf1c3c8cd@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x c20cf1c3c8cdd98618d6fcc794003a0e003ae858
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050838-failed-6.18-c20cf1c3c8cd@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From c20cf1c3c8cdd98618d6fcc794003a0e003ae858 Mon Sep 17 00:00:00 2001
From: Jiayuan Chen <jiayuan.chen@linux.dev>
Date: Thu, 27 Aug 2026 10:54:56 +0800
Subject: [PATCH] mm/memcontrol: fix data-race on reading jiffies_64

KCSAN reported a data-race between tick_do_update_jiffies64() updating
jiffies_64 and mem_cgroup_flush_stats_ratelimited() reading it directly.

Unlike jiffies, jiffies_64 is not volatile, so raw reads are plain
accesses and can even be torn on 32-bit.  Use get_jiffies_64() instead,
and fix the same pattern in mem_cgroup_flush_foreign().

Link: https://lore.kernel.org/20260827025457.116191-1-jiayuan.chen@linux.dev
Fixes: 508bed884767 ("mm: memcg: change flush_next_time to flush_last_time")
Fixes: 97b27821b485 ("writeback, memcg: Implement foreign dirty flushing")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: syzbot+ced4d9a8cadb5ef3adae@syzkaller.appspotmail.com
Acked-by: Muchun Song <muchun.song@linux.dev>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Chris Li <chrisl@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Tejun Heo <tj@kernel.org>
Cc: <stable@vger.kernel.org>
---
 mm/memcontrol.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 856a7d07586cc..d399710e9799a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -757,7 +757,7 @@ static void __mem_cgroup_flush_stats(struct mem_cgroup *memcg, bool force)
 		return;
 
 	if (mem_cgroup_is_root(memcg))
-		WRITE_ONCE(flush_last_time, jiffies_64);
+		WRITE_ONCE(flush_last_time, get_jiffies_64());
 
 	css_rstat_flush(&memcg->css);
 }
@@ -785,7 +785,7 @@ void mem_cgroup_flush_stats(struct mem_cgroup *memcg)
 void mem_cgroup_flush_stats_ratelimited(struct mem_cgroup *memcg)
 {
 	/* Only flush if the periodic flusher is one full cycle late */
-	if (time_after64(jiffies_64, READ_ONCE(flush_last_time) + 2*FLUSH_TIME))
+	if (time_after64(get_jiffies_64(), READ_ONCE(flush_last_time) + 2 * FLUSH_TIME))
 		mem_cgroup_flush_stats(memcg);
 }
 
@@ -3946,7 +3946,7 @@ void mem_cgroup_flush_foreign(struct bdi_writeback *wb)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(wb->memcg_css);
 	unsigned long intv = msecs_to_jiffies(dirty_expire_interval * 10);
-	u64 now = jiffies_64;
+	u64 now = get_jiffies_64();
 	int i;
 
 	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++) {
-- 
2.53.0




