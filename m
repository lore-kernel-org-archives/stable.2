Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9E91F91F6
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 10:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791109090; cv=none; b=F9loMsueq5+2MKlWFsIQHXIeagUokn12erRr+GLHROYXjeoP4KcVpwHBubWGrHW/6p0wXdewwZJF5075YYhx3+BNa2K2LZ1PL1VVgzqiYEUp42RWPxZ2Qkk4X90V55merC3wemToaEy0a+oUII//yxvcSfuTTTHY+C9deaNgMJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791109090; c=relaxed/simple;
	bh=djLAujk9DgbJFEokwBagpVriTtwWaep60Af7IjgOYDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/bPCmLnbxqAe/jE3NkrptKrrzQ2nUNGlVpej43xyv956eYlyjjJmcvnosxr8I3s5F/f8Q6bvaOkUlubtDwU0fx+x2BAEB/duLhZT0lfeUhrHhDfKIiem/XHg1sIUyKiTwjaIj2gj3mvLLpP88zDyisQDFBt/g1ee+VqVgViIys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNp+DXor; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNp+DXor"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75A11F000FF;
	Sun,  4 Oct 2026 10:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791109089;
	bh=Q893X3lfCQuSxEpjEZrhZkxZBX97dYyydtHU9gUfc4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lNp+DXoro5DiaVhYtog0JhXfc8YBnnzPlgU+ynLt2qbLS303ycf4SZPWyaa8jbQIr
	 V9nt2dDVGQvV6QcJqsTniml2HnKdzqEUWByz3UJ6Os21xxQW410QLmOFWk41csSLef
	 aoIvJOqB93rRLY6/0dylm5/yL8f0J8fKkYx5/JOBlTgx8uT5+epbD0hppFpB6+Mirm
	 /jWfYxokmUWNCLwuk3slp/dqtorfI9r3RbzViAKGQl3JLAuMKT3xkvu3HJ82/WhZOJ
	 D8s72CanM8YP9reirLkkcNSqsUZEjwTGM6QeU1n8QQ+j/BDu9CvIeTlNmJNSna1f4M
	 X+ukWk2FxbDOQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
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
	David Hildenbrand <david@redhat.com>,
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
	Pedro Falcato <pfalcato@suse.de>,
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
Subject: [PATCH 6.18.y 1/5] mm/vma: remove unused function, make internal functions static
Date: Sun,  4 Oct 2026 06:17:51 -0400
Message-ID: <20261004101719.1402752-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100329-jaws-trash-1c19@gregkh>
References: <2026100329-jaws-trash-1c19@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

[ Upstream commit cf1d98f44d056d7114554beb78665c20d1ed244a ]

unlink_file_vma() is not used by anything, so remove it.

vma_link() and vma_link_file() are only used within mm/vma.c, so make them
static.

Link: https://lkml.kernel.org/r/f2ab9ea051225a02e6d1d45a7608f4e149220117.1760959442.git.lorenzo.stoakes@oracle.com
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
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
Cc: David Hildenbrand <david@redhat.com>
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
Cc: Pedro Falcato <pfalcato@suse.de>
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
Stable-dep-of: 976d5e0ddac8 ("mm/vma: predicate setting mmap_prepare VMA fields on new vma alloc")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/vma.c | 21 ++-------------------
 mm/vma.h |  6 ------
 2 files changed, 2 insertions(+), 25 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 5beb18b0610b0..74657c264c1ae 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1800,24 +1800,7 @@ void unlink_file_vma_batch_final(struct unlink_vma_file_batch *vb)
 		unlink_file_vma_batch_process(vb);
 }
 
-/*
- * Unlink a file-based vm structure from its interval tree, to hide
- * vma from rmap and vmtruncate before freeing its page tables.
- */
-void unlink_file_vma(struct vm_area_struct *vma)
-{
-	struct file *file = vma->vm_file;
-
-	if (file) {
-		struct address_space *mapping = file->f_mapping;
-
-		i_mmap_lock_write(mapping);
-		__remove_shared_vm_struct(vma, mapping);
-		i_mmap_unlock_write(mapping);
-	}
-}
-
-void vma_link_file(struct vm_area_struct *vma)
+static void vma_link_file(struct vm_area_struct *vma)
 {
 	struct file *file = vma->vm_file;
 	struct address_space *mapping;
@@ -1830,7 +1813,7 @@ void vma_link_file(struct vm_area_struct *vma)
 	}
 }
 
-int vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
+static int vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
 {
 	VMA_ITERATOR(vmi, mm, 0);
 
diff --git a/mm/vma.h b/mm/vma.h
index 4c7ea8b893ab7..9d5ee6ac913ad 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -381,12 +381,6 @@ void unlink_file_vma_batch_final(struct unlink_vma_file_batch *vb);
 void unlink_file_vma_batch_add(struct unlink_vma_file_batch *vb,
 			       struct vm_area_struct *vma);
 
-void unlink_file_vma(struct vm_area_struct *vma);
-
-void vma_link_file(struct vm_area_struct *vma);
-
-int vma_link(struct mm_struct *mm, struct vm_area_struct *vma);
-
 struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	unsigned long addr, unsigned long len, pgoff_t pgoff,
 	bool *need_rmap_locks);
-- 
2.53.0

