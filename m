Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481223E3DBE
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 07:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785914832; cv=none; b=qfG8M7hbeA/J/ixA/BNYWS3a94TaHgaZsxbra8mnSUanpIx1fFCCYfSamL9Hrb9Scfi05s2P61rJbjGGnx0bKORjtL0VpmWYR35x2G89HpgOrEhQzgq4s+G4PDApv5DxUuSdx++0kU3qN3wJGknC/vOhmd5G/uqpyBI20BppWMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785914832; c=relaxed/simple;
	bh=Pa1Bp5oDeHBv8strhXlEBGksBSZoON+2QmKCC6T8FHY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JIqFK80mSisq2mAHfZPPQvC4V3mz9mSbZ9OkztH2tKw7NuQrDcEAvXJOxCKzoEiaXd3qFAHyXCAxY7BWcLWCipVt8MF97k6gnQp3WT5GVsTCsrkUNxv6RAexHGaNPQEFljdx8RouqSjT6XzKBbgtWoJvpN0vDL5roSHH1rQoW54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hRK9TGUD; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hRK9TGUD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=U3
	wrcV0k5ZLgN4YIkNlOZPK6c/r+xRI0oP9uZc18DtY=; b=hRK9TGUDUFYwWSlNvX
	Vfq/LuomIQNXbdTld13rt4HjySi+PhGrWZZhMGar4j//Q40KeAmUT871oeQ/Pm8W
	MfNuEI/+cLJj0t4NIkSoqrUXC7n1S+A9B9WTr5hm6wdXNkp8wXT7vpG7x8sxIgSX
	Ih0JihXuclir3NxqN7G64zShc=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3PzWi5XJqs4gTOA--.20967S2;
	Wed, 05 Aug 2026 15:26:27 +0800 (CST)
From: dayou5941@163.com
To: akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org
Cc: ziy@nvidia.com,
	linux-mm@kvack.org,
	liyouhong <liyouhong@kylinos.cn>,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] mm/memory-failure: fix concurrent access issue in min_order_for_split()
Date: Wed,  5 Aug 2026 15:26:25 +0800
Message-Id: <20260805072625.2437636-1-dayou5941@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3PzWi5XJqs4gTOA--.20967S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAr4fKrWfGF1fXF47GrWDtwb_yoW5CryxpF
	W7Kwn8XrZagwnF9w47Xw4DAF1Fk34kWa1UCF93CwsrA3Z8Aw1qkF47Ww4YyF4UGr48AFn7
	tFyDXF1093Z8tr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jFzuAUUUUU=
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC3gPYh2py5aPVGAAA3R

From: liyouhong <liyouhong@kylinos.cn>

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
Signed-off-by: liyouhong <liyouhong@kylinos.cn>
---
v2:
- Dropped the approach of caching folio->mapping inside min_order_for_split() in favor of adding the folio lock at the callers.
- Added VM_WARN_ON_ONCE_FOLIO() in min_order_for_split().
- Updated the commit message to clarify that the real issue is the callers not holding the folio lock, rather than a TOCTOU race.
v1: https://lore.kernel.org/all/20260804035828.2684059-1-dayou5941@163.com/

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

