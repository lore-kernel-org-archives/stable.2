Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B4D2673B0;
	Thu,  6 Aug 2026 12:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786018286; cv=none; b=i7+7QbbxsJmuc0fJHplxwaLnLSdK2JFKLG9GLi5r19bdO7cXNn0rJpOiAwNUKWp9GXmlW9w1i4T4yG+XUHExRAYsoumVvr+uakcF8ryhNm7vRoFIxv+Qar0Da0m8mfG/f442k++ujwP6LIrMQ0rPqpesAIQhzCirYcPk9u3Mvkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786018286; c=relaxed/simple;
	bh=ZOwqWb+YUUWInhyQFveSJ9JbWh8wcx+TemohhZQGNMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IlfjE3UxN7wKmkFqjUffZ5DqifxhtNT8+vh6903c9SAyl33exahEftMhXhQSPszGza5Amk7qM0KqQjQGBC/iQC34dUpUllwW/bNxL2UIV15PLq5FRBYbbA8o0wb6/1r5ypHS/X4kRgOqHdgPIXYfx2ETqwXEk+0Q73OXFYYFrZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FbIcEyC+; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FbIcEyC+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Yu
	lkwmZf7EblPg7Hft79CTPkVdGunT1fPQenhuXXzJc=; b=FbIcEyC+O8ejRiNe4b
	E4Sjml9pa/2OS4W3ZuitNK0mdII8KP9DS7QoCnfN+EU52bSMnoDByBq+gULyQD16
	JhvsferQOfIjTB4Rq0SO3PhMi3JLWOWgA8DiBu7nWUG9nBfskzrsKRD7M4UqMWLj
	0PY35HxwhgZtpJCKXbIjUDn40=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDntYa2eXRqDR_9MA--.2495S2;
	Thu, 06 Aug 2026 20:10:32 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Zqiang <qiang1.zhang@intel.com>,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Hui Su <sh_def@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] kasan: fix cache shrink race with CPU hotplug
Date: Thu,  6 Aug 2026 20:10:06 +0800
Message-ID: <20260806121006.1642946-1-sh_def@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDntYa2eXRqDR_9MA--.2495S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uryDCF15WF1DWw47ZrWkWFg_yoW8try7pF
	y3Ga43Gw4vvr1kXw17Ja15WryrAFZ0ya43Aw4agrsYyF1ruw1kWry3trZYvFWYgryrXanF
	vr95AFy5uF4UAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piHa0PUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwRhEo2p0ebizZwAA31

kasan_quarantine_remove_cache() first invokes per_cpu_remove_cache() on
all online CPUs. Each callback moves objects belonging to the cache from
cpu_quarantine to the CPU's shrink_qlist, where they can later be freed
from task context.

kmem_cache_destroy() invokes the quarantine removal path while holding
cpus_read_lock(), but kmem_cache_shrink() does not. The latter can
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
allocator. This may prevent kmem_cache_shrink() from releasing slabs
that would otherwise become empty. If CPU1 remains offline, a later
kmem_cache_destroy() also skips the list and can report that the cache
still contains objects.

Per-CPU shrink_qlist storage exists for every possible CPU, and each
list is protected by its own raw spinlock. Iterate over possible CPUs
so that a list populated before its CPU went offline is drained as well.

Fixes: 07d067e4f2ce ("kasan: fix sleeping function called from invalid context on RT kernel")
Cc: stable@vger.kernel.org
Signed-off-by: Hui Su <sh_def@163.com>
---
 mm/kasan/quarantine.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
index 6958aa713c67..16f4e67beee8 100644
--- a/mm/kasan/quarantine.c
+++ b/mm/kasan/quarantine.c
@@ -355,7 +355,12 @@ void kasan_quarantine_remove_cache(struct kmem_cache *cache)
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
2.43.0

