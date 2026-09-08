Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A86E355F41
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 16:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883310; cv=none; b=lm413VF6HZQh7kzX5rvZDWN2GzvfcqE5GUn1cxfPxDMkZEO3a4e3VSULM5xvTHv73ExkUiENpYjcoNP4/WzhPBoW2/TXgOZR1FoPgKreg+wkfA766dDjkOcf34KYJvBc+bovuSc+49Ck65MM8HEYePrdryW95EFb5sL+gS4OECw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883310; c=relaxed/simple;
	bh=Y3wYaZaiQh+pNJW/74pXVoX+i8+yMTRruywt4Z8+2fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QpemXGH9M6xSkay8MV8UH1ImMuemyive0S6y7/MPpqbHxGqkYTz1TJhvUVr1Us2V4huRjc6rZb2Glrwwwmi70lSpWRHg+S5dXpUMu2XI5fSAza03tudzASl8Ag7FqxEw086K9wl847lkJt3I4BHSZhMeQmr4Vrp8GCuecK976Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPyGDwY3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPyGDwY3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812221F00A3A;
	Tue,  8 Sep 2026 16:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788883308;
	bh=uC1+jM1ezArUAwnc7ZeLylOrWYcLFL05wkNmRbzPd9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jPyGDwY3miZvIYRNijYVTU688vvWh+t67vc2VBuoGSKlrn+7Jw2M9tUvdq7ydK2jB
	 oQB2/aOFngQHjFsaiKhJiJMC9NX0VyOQxDqMX+S7LpP4dqIkd9hz7udZ0UFPBAjYat
	 MTRHqEC9o+uYKq+wpXntuGfhlTTasssUpcYW+oDQsbj8F4ATGMhTVfq37hWaZyt/uw
	 PHxxxnw4yFFnDGS2KCDff4sONiinYHvbtNwLTeXiN8kUi4sylBeZ+9DlmtPlBcFGy+
	 MNGA33thjmCJFwEUYsWDwqgLqkztNGTwP75G9aD/RJaea4G8TtPq1mNW1yyn2A0IHZ
	 UIzTEBvUg4iLA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hui Su <sh_def@163.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	"Zhang, Qiang1" <qiang1.zhang@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] kasan: fix cache shrink race with CPU hotplug
Date: Tue,  8 Sep 2026 12:01:44 -0400
Message-ID: <20260908160144.2550298-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908160144.2550298-1-sashal@kernel.org>
References: <2026090357-uneasily-gauze-359b@gregkh>
 <20260908160144.2550298-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hui Su <sh_def@163.com>

[ Upstream commit 8790303cbaac52a11dfed4aab261f8ea60682525 ]

kasan_quarantine_remove_cache() first invokes per_cpu_remove_cache() on
all online CPUs.  Each callback moves objects belonging to the cache from
cpu_quarantine to the CPU's shrink_qlist, where they can later be freed
from task context.

kmem_cache_destroy() invokes the quarantine removal path while holding
cpus_read_lock(), but kmem_cache_shrink() does not.  The latter can
therefore race with CPU offlining as follows:

  kmem_cache_shrink()             CPU hotplug
  -------------------             -----------
  on_each_cpu()
    CPU1 moves objects to
    CPU1's shrink_qlist
  on_each_cpu() returns
                                  CPU1 goes offline
                                  kasan_cpu_offline()
                                    drains cpu_quarantine
                                    leaves shrink_qlist untouched
  for_each_online_cpu()
    skips CPU1

The objects left on CPU1's shrink_qlist are not returned to the slab
allocator.  This may prevent kmem_cache_shrink() from releasing slabs that
would otherwise become empty.  If CPU1 remains offline, a later
kmem_cache_destroy() also skips the list and can report that the cache
still contains objects.

An intermittent occurrence was observed with a virtio-9p filesystem.  The
mount and umount commands both returned 0, but the kernel logged the
following during the userspace-triggered teardown:

  [  2994.380134][  T111] BUG 9p-fcall-cache-1 (Tainted: G    B              ): Objects remaining on __kmem_cache_shutdown()
  [  2994.381140][  T111] Object 0xff11000004361118 @offset=4376
  [  2994.381607][  T111] Allocated in p9_fcall_init+0x201/0x400 age=19564 cpu=1 pid=104
  [  2994.382591][  T111]  p9_fcall_init+0x201/0x400
  [  2994.382810][  T111]  p9_tag_alloc+0x12f/0x700
  [  2994.382982][  T111]  p9_client_prepare_req+0x102/0x3e0
  [  2994.383165][  T111]  p9_client_rpc+0x1ab/0xa50
  [  2994.383334][  T111]  p9_client_getattr_dotl+0xb0/0x1a0
  [  2994.383515][  T111]  v9fs_vfs_getattr_dotl+0x115/0x360
  [  2994.383719][  T111]  vfs_getattr_nosec+0x22c/0x3a0
  [  2994.383910][  T111]  vfs_statx+0xd7/0x170
  [  2994.384062][  T111]  vfs_fstatat+0x45/0x80
  [  2994.384215][  T111]  __do_sys_newfstatat+0x84/0xe0
  [  2994.384386][  T111]  do_syscall_64+0x115/0x6a0
  [  2994.384566][  T111]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
  [  2994.399720][  T111] WARNING: mm/slub.c:1244 at __kmem_cache_shutdown+0x363/0x500, CPU#0: busybox/111
  [  2994.405655][  T111] Call Trace:
  [  2994.406325][  T111]  kmem_cache_destroy+0x73/0x1b0
  [  2994.406630][  T111]  p9_client_destroy+0x271/0x3c0
  [  2994.407210][  T111]  v9fs_session_close+0x3c/0x260
  [  2994.407409][  T111]  v9fs_kill_super+0x48/0x90
  [  2994.407584][  T111]  deactivate_locked_super+0xa3/0x160
  [  2994.407778][  T111]  cleanup_mnt+0x1dd/0x3e0

Thus, a successful umount left objects in the 9p fcall cache and prevented
the cache from being destroyed cleanly.

Per-CPU shrink_qlist storage exists for every possible CPU, and each list
is protected by its own raw spinlock.  Iterate over possible CPUs so that
a list populated before its CPU went offline is drained as well.

for_each_possible_cpu() can do more work than for_each_online_cpu(), but
this change only affects CONFIG_KASAN_GENERIC kernels.  The extra work is
limited to cache shrink and cache destruction paths and does not affect
the normal allocation/free fast path.  It adds one raw-spinlock-protected
scan of each possible CPU's shrink list.  These lists are normally empty;
a non-empty list is traversed to remove objects belonging to the cache
being shrunk or destroyed.

Link: https://lore.kernel.org/20260808031459.3032812-1-sh_def@163.com
Fixes: 07d067e4f2ce ("kasan: fix sleeping function called from invalid context on RT kernel")
Signed-off-by: Hui Su <sh_def@163.com>
Reviewed-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/kasan/quarantine.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
index 152dca73f3984..11bd18e851a02 100644
--- a/mm/kasan/quarantine.c
+++ b/mm/kasan/quarantine.c
@@ -361,7 +361,12 @@ void kasan_quarantine_remove_cache(struct kmem_cache *cache)
 	 */
 	on_each_cpu(per_cpu_remove_cache, cache, 1);
 
-	for_each_online_cpu(cpu) {
+	/*
+	 * A CPU can go offline after on_each_cpu() returns, leaving cache
+	 * objects on that CPU's shrink list. Scan all possible CPUs to
+	 * drain those lists.
+	 */
+	for_each_possible_cpu(cpu) {
 		sq = per_cpu_ptr(&shrink_qlist, cpu);
 		raw_spin_lock_irqsave(&sq->lock, flags);
 		qlist_move_cache(&sq->qlist, &to_free, cache);
-- 
2.53.0

