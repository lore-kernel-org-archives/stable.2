Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794655561;
	b=cJi/I0TtLmTQuswPD4TFKVsd4FP2gQhcP+qaoPS+2yhLjxqXKoKcOKpcs6HzjdWjsucE
	 SLzfE7xBgYk+R/YWwxXZJt2nG7y3kgA9NObLtDyqDzEHG8YBu8OT6SFdlCXr+8mdTRBK3
	 VinzOR7Df5UowR4tgX5/lOsMeOX+mXgBLxkx5xBObaQIjGhmA0Ev73KMwQnV+dJUlLQ8U
	 5mCF7Hvh1nhDc/u8cep3OG5fQrUGJm3LDMoUgWl8czfi6icwOzcOWTX0kGV/ls7eHEo/2
	 YYOHANnNP2PzlbvRXiYiWIQwnMPRTIZYQCtGdQWU6Eg+56bPOPHfc40/3JZGkKB0wKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794655561;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Ik3cMVEgluWCZTmAy6XC89hjzBK/NOOgQFoYH5sRUdQ=;
	b=duCJjzOb6RaKJ7ChlzIPKCSxzg+y6+jng2fHc8ZKSz+G/CZc1kM0lFdzHLT97pToFUsi
	 sUgI3Wb4CzXODANrIUC7dK09sRe3RCEOI2De9S2P+p3Llur2/V2dOyPW5NmAHMhCkw1rM
	 nXEs2Q7DnEXpxcwoupl2zwfrxFN6CZwW0O8MQ8G2HR1/5SFhvEwjLfLhQiX5trR3Qq+Fy
	 X3Qx2UdPt2Fd/eYHxokkbCPuiV4gXKgwNLeSW3LxJmCLwy91lOycv2aoa9sjNRFkI8q0L
	 rPYih+JQXZE/XOzZj3FRP0r/oap6U8udLAaLf2xCRHYX8MQq3AiRr9MafDf6HaxNaCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=A0QRxa8C;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1FD606A327
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 11:26:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA1FD606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=A0QRxa8C
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3712b6d9843so1638020eec.1
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 03:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1794655560; x=1795260360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ik3cMVEgluWCZTmAy6XC89hjzBK/NOOgQFoYH5sRUdQ=;
        b=A0QRxa8CuVSRxDlN0s8i+K5NVUwAn8ZVpkikQ3XOScT4HKboMnq8mAr/kF2pVDWDSc
         F01rFqtrZL3wOYfCjWFhc/mgJkNz7WS1K7TwCkeEXa3JU7AxsQET2ciwU+UnaXLPEJqs
         o8dtsf/2Wlhuczzjn0sPPKQYkkFIHOhhUrWm/MiRK5bTkXyGAT051Q0VQSifWcGgs+X7
         fKhRQi6dshPRXerht1zK8y8LgAQwtKxRGkkLrq+KJSs75EQkRLa2jjG4x1WkS/M5gncG
         +0xf/+6WOYmr5I3fCH74BIcW3N3mYtom+bCVdmH847PhIVth+PpfF0/vm5f7Ut34edz5
         fXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794655560; x=1795260360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ik3cMVEgluWCZTmAy6XC89hjzBK/NOOgQFoYH5sRUdQ=;
        b=cydm0c223apXAeDdYiMlbzIiMbvLDxDV0yXI5B+yWcxTmUwLnv3fZUZyvy51WHofHm
         L7A7DGFpZWarzibrYvHKos3QDAQV/hgMSwOXaZN8BemcA/a2Psb5vQlycoVb/iVYCsMO
         IfFAGaMcZTzhqTi64a3vPp3rMSZikUKVgERb1H/x330VclHuUJ6eBtSEhWPPBCRgXGvw
         rCAQ5rjTdeCk66RCJa7mSSAOD0553rpBIuNZ9C7ENGKKgfjrlVK1EkQxU5AZyQOq3c+0
         X7QnKA5Xh/AuqxkR1GiNXCbxelzh8Q+izUDR9wUXcudqrcQSWQT8Wumlk/wvR+ZGO7bv
         /vQQ==
X-Forwarded-Encrypted: i=1; AL+hErEnZLzmRR7zrB3krwdeOWfSMcvtfSkX7hONJmgPB5iGYWE88RFuIMsYpovolBFEhW2rpJyBBww=@vger.kernel.org
X-Gm-Message-State: APuU4Z+m7pEGyIy8pvKyfMqIYdJAC5/ty28l+nT5aYSaZj203XghZRy5
	WnkKYNJc7YHnJvg+o6XUyaFEMsQBbEeXaDdZV38IlqAt64K1+4CvuwUxS/+AFel/u90=
X-Gm-Gg: AYBFou3Nx2KLIRkK0hXhIahRPdA87Bhduy4TZgPgSpWpoa02b4rjwhTa9p0zO2/LMvF
	DeJ+41wIkL4+nhMXw48GKPAhR84E6I8kXVjRMPqKiRsw+hsiYepYZ1e+Qnb+ojNF01nUjGsmpoC
	qhq9S6M3mjhZCfOThe8BAhOty3SaiSWF9loOK0HzYE/GXT7kcz34hn1nEDXQkSzBi5C8jS+B6+O
	RTpQgH5Ctq8QrhtbRaa+odHw5ofRAH62H6JTCQ/siEv/tE43Yo3CHxx4sxJlRsl/ir0svJuipbr
	A6WY2KlY4AvTzGZdDiaChuVtZTWZtyfDB8t5RwP++JQarnZxmFHlhh1XqfqgJnsXo8t8EFoVaxB
	/6Y/3ywiLfiAsMh+cUmPWcs7ONKxuecJgxHQYZjyN1poAankyqU5TOxV8KPQCWXah092oNu/PCI
	/EaZNZ0JKU43/CbO71DQB3Idv/ThCf7tGpo+Ev+0VSrtFjZHhJcYTXwz8ILEm8wiy9UVhqoxB+b
	WwDrtvV6jc+APfHejxi8GqVndRiIACx39Y8cdrc1Ezrg55L2LKHccuO2veVO4NqEWQwOPyXpsB+
	50Oplia2SLDvsyi2jDfpjRgjlhXTS9gBhm7z61YEtoxHWyHnvoL9TUeoSvHM
X-Received: by 2002:a05:7301:713:b0:376:ce6a:a499 with SMTP id 5a478bee46e88-379684ae563mr4808021eec.36.1794655559588;
        Sat, 14 Nov 2026 03:25:59 -0800 (PST)
Received: from G6L4RL2QG9 ([2409:8a00:1832:6900:9d36:3b30:f4a3:7b5f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379553316fdsm16190627eec.5.2026.11.14.03.25.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Nov 2026 03:25:59 -0800 (PST)
From: Muchun Song <songmuchun@bytedance.com>
To: Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Miaohe Lin <linmiaohe@huawei.com>
Cc: Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Sashiko <sashiko-bot@kernel.org>,
	Jiaqi Yan <jiaqiyan@google.com>,
	"Jose A . Perez de Azpillaga" <azpijr@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 1/3] mm/hugetlb_vmemmap: fix HWPoison state races during optimization
Date: Sat, 14 Nov 2026 19:25:21 +0800
Message-ID: <20261114112523.75208-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261114112523.75208-1-songmuchun@bytedance.com>
References: <20261114112523.75208-1-songmuchun@bytedance.com>
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

HVO copies the vmemmap head page before remapping it to a newly allocated
backing page. Memory failure can update the old head page after the copy
but before the remap's TLB invalidation completes:

CPU 0                            CPU 1
init_new_hugetlb_folio()
__hugetlb_vmemmap_optimize_folio()
  vmemmap_optimize_pte()
    copy_page(old_head, new_head)
                                 try_memory_failure_hugetlb()
                                   get_huge_page_for_hwpoison()
                                     hugetlb_update_hwpoison(old_head)
  set_pte_at(..., new_head)
  flush_tlb_all()
free_vmemmap_page_list(old_head)

The raw_hwp_page linked to the old head is then leaked and the folio's
HWPoison state is lost when the obsolete backing page is freed, allowing
the poisoned huge page to be allocated later.

Unpoisoning has a similar race: unpoison_memory() can free the
raw_hwp_page and clear PG_hwpoison from the old head after it is copied,
leaving the new head with stale HWPoison state and a freed pointer.

Serialize HVO remapping against HWPoison updates and removal. This
ensures that an update is either copied to the new vmemmap head page or
applied after HVO installs the new mapping and completes the TLB flush,
and prevents unpoisoning from modifying the old head while HVO installs
its replacement.

Fixes: 11aad2631bf7 ("mm/hugetlb_vmemmap: remap head page to newly allocated page")
Cc: stable@vger.kernel.org
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-18e93f17-529b-4d84-ba44-a41829f4be64
Reviewed-by: Jiaqi Yan <jiaqiyan@google.com>
Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
---
v3:
- Serialize unpoison_memory() against HVO head remapping (suggested by
  Sashiko)
- Reword the subject and commit message for the extended race coverage
- Collect Reviewed-by from Jiaqi Yan and Jose A. Perez de Azpillaga
---
 mm/hugetlb_vmemmap.c | 10 ++++++++++
 mm/hugetlb_vmemmap.h | 24 ++++++++++++++++++++++++
 mm/memory-failure.c  |  3 +++
 3 files changed, 37 insertions(+)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index ba8e11e399b2..79ca68dff635 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -15,6 +15,7 @@
 #include <linux/mmdebug.h>
 #include <linux/pagewalk.h>
 #include <linux/pgalloc.h>
+#include <linux/rwsem.h>
 #include <linux/vmemmap-optimization.h>
 
 #include <asm/tlbflush.h>
@@ -41,6 +42,8 @@ struct vmemmap_remap_walk {
 	unsigned long		flags;
 };
 
+DECLARE_RWSEM(vmemmap_remap_rwsem);
+
 static int vmemmap_split_pmd(pmd_t *pmd, struct page *head, unsigned long start,
 			     struct vmemmap_remap_walk *walk)
 {
@@ -333,6 +336,9 @@ static int vmemmap_pteify_folio(const struct folio *folio, unsigned long flags)
  * responsible for freeing the pages left on the @vmemmap_pages list, even on
  * failure.
  *
+ * Note: The caller must hold vmemmap_remap_rwsem. If TLB flushing is deferred,
+ * the lock must remain held until the final TLB flush.
+ *
  * Return: %0 on success, negative error code otherwise.
  */
 static int vmemmap_optimize_folio(const struct folio *folio,
@@ -348,6 +354,8 @@ static int vmemmap_optimize_folio(const struct folio *folio,
 		.flags		= flags,
 	};
 
+	rwsem_assert_held(&vmemmap_remap_rwsem);
+
 	VM_WARN_ON_ONCE_FOLIO(folio_ref_count(folio), folio);
 
 	if (!vmemmap_optimizable_order(folio_order(folio)))
@@ -536,6 +544,7 @@ void hugetlb_vmemmap_optimize_folio(const struct hstate *h, struct folio *folio)
 {
 	LIST_HEAD(vmemmap_pages);
 
+	guard(rwsem_read)(&vmemmap_remap_rwsem);
 	__hugetlb_vmemmap_optimize_folio(h, folio, &vmemmap_pages, 0);
 	free_vmemmap_page_list(&vmemmap_pages);
 }
@@ -588,6 +597,7 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
 
 	flush_tlb_all();
 
+	guard(rwsem_read)(&vmemmap_remap_rwsem);
 	list_for_each_entry(folio, folio_list, lru) {
 		int ret;
 
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index d057e8b12bf1..8b28063d78cc 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -9,9 +9,12 @@
 #ifndef _LINUX_HUGETLB_VMEMMAP_H
 #define _LINUX_HUGETLB_VMEMMAP_H
 #include <linux/hugetlb.h>
+#include <linux/rwsem.h>
 #include <linux/vmemmap-optimization.h>
 
 #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
+extern struct rw_semaphore vmemmap_remap_rwsem;
+
 int hugetlb_vmemmap_restore_folio(const struct hstate *h, struct folio *folio);
 long hugetlb_vmemmap_restore_folios(const struct hstate *h,
 					struct list_head *folio_list,
@@ -20,6 +23,16 @@ void hugetlb_vmemmap_optimize_folio(const struct hstate *h, struct folio *folio)
 void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list);
 void hugetlb_vmemmap_optimize_bootmem_page(unsigned long pfn, unsigned int order);
 
+static inline void hugetlb_vmemmap_write_lock(void)
+{
+	down_write(&vmemmap_remap_rwsem);
+}
+
+static inline void hugetlb_vmemmap_write_unlock(void)
+{
+	up_write(&vmemmap_remap_rwsem);
+}
+
 static inline unsigned int hugetlb_vmemmap_size(const struct hstate *h)
 {
 	return pages_per_huge_page(h) * sizeof(struct page);
@@ -59,6 +72,14 @@ static inline void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list
 {
 }
 
+static inline void hugetlb_vmemmap_write_lock(void)
+{
+}
+
+static inline void hugetlb_vmemmap_write_unlock(void)
+{
+}
+
 static inline unsigned int hugetlb_vmemmap_optimizable_size(const struct hstate *h)
 {
 	return 0;
@@ -69,6 +90,9 @@ static inline void hugetlb_vmemmap_optimize_bootmem_page(unsigned long pfn, unsi
 }
 #endif /* CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP */
 
+DEFINE_LOCK_GUARD_0(vmemmap_remap,
+		    hugetlb_vmemmap_write_lock(), hugetlb_vmemmap_write_unlock())
+
 static inline bool hugetlb_vmemmap_optimizable(const struct hstate *h)
 {
 	return hugetlb_vmemmap_optimizable_size(h) != 0;
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 78f0a13349cb..6a7b7be9928d 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -69,6 +69,7 @@
 #include "page_alloc.h"
 #include "internal.h"
 #include "memory-failure.h"
+#include "hugetlb_vmemmap.h"
 
 static int sysctl_memory_failure_early_kill __read_mostly;
 
@@ -2038,6 +2039,7 @@ static int get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 	bool count_increased = false;
 	int ret, rc;
 
+	guard(vmemmap_remap)();
 	spin_lock_irq(&hugetlb_lock);
 	folio = page_folio(page);
 	if (!folio_test_hugetlb(folio)) {
@@ -2812,6 +2814,7 @@ int unpoison_memory(unsigned long pfn)
 
 	ghp = get_hwpoison_page(p, MF_UNPOISON);
 	if (!ghp) {
+		guard(vmemmap_remap)();
 		if (folio_test_hugetlb(folio)) {
 			huge = true;
 			count = folio_free_raw_hwp(folio, false);
-- 
2.54.0

