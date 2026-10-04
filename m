Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C37A134CCF
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 10:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791109102; cv=none; b=jid7MmwgveruPXl0Vj/kT3TuwatLwFY1XH2V5+20W49PP2y2THX1Kr1gSuRwbvDRzZ7voXMtErqkHKV0sxF0eaxSKbk01vcftrGBoyC+6u9nDY0tb9nQTWVxTeRP3c3tz4a2qsdgMySWYp2qD7FTftmgE7qzExyeiALMEn/vL0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791109102; c=relaxed/simple;
	bh=HdMqp0TAi/gsmQ+aAGqJGEtAVs0VwyiFV77eJQSh+rY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LtDRiPYKOPB5SuGlfCGj/wqmWyGG1Uijdhg72Fo7cCAsbznFjqtDxOYAc5DzqNqx38vK+UtmwXR9zOfv9xQv1AUnknKpQbtNfcSmAh5m0HR+NYnJN0t7/bU5AFIslM5atARaO/6ro1V2e5wF0eDcT4nmsZT7VmQVAPMY2t01lKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEhbswjC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEhbswjC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5851F00899;
	Sun,  4 Oct 2026 10:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791109101;
	bh=VxBDV6So/fD9ON9Fok1dVg/xEXmq+WNrWgboE0XLkm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WEhbswjCL0JDQC13NL0jK8HFnireiAxJL0piwPaB3NQII3WN64mNjLabZ4BrhIyMp
	 WY8Q3SJSVBz0Ft35dEZLwe9MTDayEJcpRG3k8UJSAxVz4Btecq3W7veEuyzTXwiP/r
	 TF5T/09vtjYwat1NNGtc4VqbfzkSS7s6SKGLl/gl+7cmR+QKSBHn4e0pjXxcVkSqb5
	 ozzW+14MbwpVmcGh2VS6BLGhP2x4oAeOiu52O09hdIyY0nZjFcjpXEXTd+iXxRWIPk
	 YWElVvWkqZJkMC9QbK7UDBlJqgsCVeey8vhgXUz2QQTapTUL6tDHLXIkXG425KoRNL
	 0MuO9fNeon2CA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Andreas Larsson <andreas@gaisler.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Baoquan He <bhe@redhat.com>,
	"Chatre, Reinette" <reinette.chatre@intel.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Christian Brauner <brauner@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Dave Martin <dave.martin@arm.com>,
	Dave Young <dyoung@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dmitriy Vyukov <dvyukov@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guo Ren <guoren@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Hugh Dickins <hughd@google.com>,
	James Morse <james.morse@arm.com>,
	Jan Kara <jack@suse.cz>,
	Jann Horn <jannh@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Kevin Tian <kevin.tian@intel.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Liam Howlett <liam.howlett@oracle.com>,
	"Luck, Tony" <tony.luck@intel.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Nicolas Pitre <nico@fluxnic.net>,
	Oscar Salvador <osalvador@suse.de>,
	Robin Murohy <robin.murphy@arm.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/5] mm/vma: rename __mmap_prepare() function to avoid confusion
Date: Sun,  4 Oct 2026 06:17:52 -0400
Message-ID: <20261004101719.1402752-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004101719.1402752-1-sashal@kernel.org>
References: <2026100329-jaws-trash-1c19@gregkh>
 <20261004101719.1402752-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

[ Upstream commit 2bcd9207dedc585bae33ad7b337f2232a8a11da8 ]

Now we have the f_op->mmap_prepare() hook, having a static function called
__mmap_prepare() that has nothing to do with it is confusing, so rename
the function to __mmap_setup().

Link: https://lkml.kernel.org/r/d25a22c60ca0f04091697ef9cda0d72ce0cf8af3.1760959442.git.lorenzo.stoakes@oracle.com
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Chatre, Reinette <reinette.chatre@intel.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Dave Martin <dave.martin@arm.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Dmitriy Vyukov <dvyukov@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guo Ren <guoren@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: James Morse <james.morse@arm.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Jann Horn <jannh@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: "Luck, Tony" <tony.luck@intel.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Nicolas Pitre <nico@fluxnic.net>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Robin Murohy <robin.murphy@arm.com>
Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Preserve the separate setup and callback error paths so a failed callback
still undoes memory accounting.

Record whether merging found a VMA and use that result to select new VMA
allocation. This preserves existing behavior while providing the
allocated_new flag needed by the follow-up change to user-defined fields.
Move the error declaration below the mapping state to avoid a conflict
with the follow-up const qualifier change.

Stable-dep-of: 976d5e0ddac8 ("mm/vma: predicate setting mmap_prepare VMA fields on new vma alloc")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/vma.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 74657c264c1ae..5d19adbb63a56 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2365,7 +2365,7 @@ static void update_ksm_flags(struct mmap_state *map)
 }
 
 /*
- * __mmap_prepare() - Prepare to gather any overlapping VMAs that need to be
+ * __mmap_setup() - Prepare to gather any overlapping VMAs that need to be
  * unmapped once the map operation is completed, check limits, account mapping
  * and clean up any pre-existing VMAs.
  *
@@ -2374,7 +2374,7 @@ static void update_ksm_flags(struct mmap_state *map)
  *
  * Returns: 0 on success, error code otherwise.
  */
-static int __mmap_prepare(struct mmap_state *map, struct list_head *uf)
+static int __mmap_setup(struct mmap_state *map, struct list_head *uf)
 {
 	int error;
 	struct vma_iterator *vmi = map->vmi;
@@ -2676,14 +2676,15 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = NULL;
-	int error;
 	bool have_mmap_prepare = file && file->f_op->mmap_prepare;
 	VMA_ITERATOR(vmi, mm, addr);
 	MMAP_STATE(map, mm, &vmi, addr, len, pgoff, vm_flags, file);
+	bool allocated_new;
+	int error;
 
 	map.check_ksm_early = can_set_ksm_flags_early(&map);
 
-	error = __mmap_prepare(&map, uf);
+	error = __mmap_setup(&map, uf);
 	if (error)
 		goto abort_munmap;
 	if (have_mmap_prepare)
@@ -2702,7 +2703,8 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 	}
 
 	/* ...but if we can't, allocate a new VMA. */
-	if (!vma) {
+	allocated_new = !vma;
+	if (allocated_new) {
 		error = __mmap_new_vma(&map, &vma);
 		if (error)
 			goto unacct_error;
@@ -2715,7 +2717,7 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 
 	return addr;
 
-	/* Accounting was done by __mmap_prepare(). */
+	/* Accounting was done by __mmap_setup(). */
 unacct_error:
 	if (map.charged)
 		vm_unacct_memory(map.charged);
-- 
2.53.0

