Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878333C9EE4
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 08:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785919386; cv=none; b=AstCIdA+MfjAxaSeX1sSRpzXd7/aYAFVWJ9aeaORpiP97oEJDyseN+pOi+8MfL7dT2ycSQRiJ4f7v+9981P5H6X9eSdxUwybCoZ0U9M/HlHufqYK6Vv+RbelAwnMKNAI8HxSEdbW1ek9WWLtRtoRk+3rFCnfumDup17DxQ91w8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785919386; c=relaxed/simple;
	bh=z1APqFTks3Xt6TfPck/y3SBLewlpKzEzBxP35Lg5DIg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hX0o9aXfVaRFgrXjp10pPUfy+nTTNzSAVSsWQQvcO6V/LnZSJyDhS3UFjgqwgT9Jd1M0Gs8pZTfP/gYCXBVEWRcGGG7IptFK6gN/+advUfDzsc10qrkC2OF5JUw+pd74+fpufkmBt1LQn+s94SZjpfzrC7S47nXjntbUbFIFwgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gHFZT1OB; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gHFZT1OB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Dx
	sOeJBgLD6jZEVkGeHk085+Bv5tTcnYZ6Dn+cOzVFY=; b=gHFZT1OB7HVXln+L5h
	SWACOdotVQHKoF1PuuQRwTQT82vp2zkWyLcS+j6J4/7s/DZCFZwFKtUjbnkeIss3
	HRy8VU3mz/vv53xDRBSJaYoEVUBDXK7a0MyPGHRprx32kJzS9Zm29rlhxfwVz28o
	15WyFZqUVgBEqut/15kEMIV58=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wCnwmJz93JqARgeOA--.21852S2;
	Wed, 05 Aug 2026 16:42:28 +0800 (CST)
From: dayou5941@163.com
To: akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org
Cc: ziy@nvidia.com,
	linux-mm@kvack.org,
	Li Youhong <liyouhong@kylinos.cn>,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v3] mm/memory-failure: fix concurrent access issue in min_order_for_split()
Date: Wed,  5 Aug 2026 16:42:24 +0800
Message-Id: <20260805084224.2597547-1-dayou5941@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnwmJz93JqARgeOA--.21852S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAr4fKrWfGF1fXF47GrWDtwb_yoW5ZF43pF
	W7Kwn8XrZagwnI9r47Xw4DAF1Fk34kWa15uF93Cw43A3Z8Aw1jkF47Ww4YyF4UKr48AFn7
	tFyDXF1093WDtF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jFfO7UUUUU=
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC3RZSAWpy93YoUgAA37

From: Li Youhong <liyouhong@kylinos.cn>

min_order_for_split() accesses folio->mapping without proper
synchronization. While the compiler typically caches the value
in a register making a NULL deref unlikely in practice, the
real issue is that the callers in memory-failure.c do not hold
the folio lock at the time of the call:

- memory_failure() explicitly drops the folio lock before calling
  min_order_for_split().
- soft_offline_in_use_page() has not yet acquired the folio lock
  when calling min_order_for_split().

This means the value of folio->mapping may be modified by a
truncate or invalidate operation while min_order_for_split() is
executing, leading to a torn read or use of a stale mapping value.

Fixes: 689b8986776c ("mm/memory-failure: improve large block size folio handling")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260803060001.800638-1-dayou5941@163.com
Cc: stable@vger.kernel.org
Signed-off-by: Li Youhong <liyouhong@kylinos.cn>
---
v2:
- Dropped the approach of caching folio->mapping inside min_order_for_split() in favor of adding the folio lock at the callers.
- Added VM_WARN_ON_ONCE_FOLIO() in min_order_for_split().
- Updated the commit message to clarify that the real issue is the callers not holding the folio lock, rather than a TOCTOU race.
  v1: https://lore.kernel.org/all/20260804035828.2684059-1-dayou5941@163.com/

v3:
- Fix author name and Signed-off-by format as requested by Greg.
  v2: https://lore.kernel.org/all/20260805072625.2437636-1-dayou5941@163.com/
---
 mm/huge_memory.c    |  2 ++
 mm/memory-failure.c | 12 ++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 58cabe6af33d..e3f16dadc1d4 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4300,6 +4300,8 @@ int folio_split(struct folio *folio, unsigned int new_order,
  */
 unsigned int min_order_for_split(struct folio *folio)
 {
+	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
+
 	if (folio_test_anon(folio))
 		return 0;
 
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 3b1e6946821b..7391524b5046 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2437,12 +2437,17 @@ int memory_failure(unsigned long pfn, int flags)
 		res = -EOPNOTSUPP;
 		goto unlock_mutex;
 	}
+
 	folio_unlock(folio);
 
 	if (folio_test_large(folio)) {
-		const int new_order = min_order_for_split(folio);
+		const int new_order;
 		int err;
 
+		folio_lock(folio);
+		new_order = min_order_for_split(folio);
+		folio_unlock(folio);
+
 		/*
 		 * The flag must be set after the refcount is bumped
 		 * otherwise it may race with THP split.
@@ -2796,8 +2801,11 @@ static int soft_offline_in_use_page(struct page *page)
 	};
 
 	if (!huge && folio_test_large(folio)) {
-		const int new_order = min_order_for_split(folio);
+		const int new_order;
 
+		folio_lock(folio);
+		new_order = min_order_for_split(folio);
+		folio_unlock(folio);
 		/*
 		 * If new_order (target split order) is not 0, do not split the
 		 * folio at all to retain the still accessible large folio.
-- 
2.25.1

