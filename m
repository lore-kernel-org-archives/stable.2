Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35EB41DEE5;
	Wed, 23 Sep 2026 17:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790185548; cv=none; b=qEF1ldfCF8ZoMvrITrMRvFOD76mWXPuqwS8Mc3P/D/g5jZh79MUfOlvy/zWVS8VbwGoFswRjVHxmicCS36hvCMn6zKFJtO4RaC9dbdqSVi8XlWuTKhBdKroMN6Myj+pEI+EVpYlZaU9i6Uvk/d9KHsXwbjgo3ICkvFyMKdWmvcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790185548; c=relaxed/simple;
	bh=B/5OxH4zopJDHw6XR/oNfqdty/0ftHeGKu0ofzE6qRQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KqwnzKFo0IAifBhv949/zvGXtInksmdhiV8rENDFtDxC04N6HPrw+psS9PkCibka39ZfpFbR9HGdUomJA+osco8BZERLtpEw/3eQHfDueamSJJhYXPJiko+5/GknDeema9hS7DT1J++JGNHP0p+gy0Mr/54CBKrNiH59igi6Y24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZvW1r2i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZvW1r2i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326261F000FF;
	Wed, 23 Sep 2026 17:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790185546;
	bh=gBATB8uu2oRqNmBGt1NsSq+MtGX6Gp4XwS/NcICfVSc=;
	h=From:Date:Subject:To:Cc;
	b=SZvW1r2ik+DDhg7vkKvvs618HlAFXyxsfvGQfSM6EI8MT2IkGKP0UiZKgozWz5V+u
	 83lw3cVk/Wjvxf/Pf6FmG/RwmUfKCGxjbWlbAxGOcTwidoJNgpJiqqqhJIxD34frPk
	 WReIvz64KF8bnDkJ5odUtPC8qZ8DGOkHLoVfMIhwHAwAJ1OsBRh5Gt81JCW5L8OSTP
	 q0QNwCNtey+lO7Ci8+X3P4ncdaONp4EHQM2JSNJiRQrddzywYtZymwFhn/kY2/Wq76
	 +rkzv6JnXGn0rN3RTDwPRd91Azi6Yr1YFSW+K+iexFgPbUjPOG/wTP6h4PmeH3dDcH
	 IUFXBCmHIlZ+A==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Wed, 23 Sep 2026 18:45:41 +0100
Subject: [PATCH] mm/vma: predicate setting mmap_prepare VMA fields on new
 vma alloc
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-fix-mmap-prepare-overwrite-v1-1-3b3f1bfcdf5e@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MMQqAMAxA0atIZgNtlYpeRRyKRs2gllRUKN7d4
 Pjh8TMkEqYEXZFB6OLEx65hywLGNewLIU/a4IzzpnUVzvzgtoWIUSgGITwuklv4JPSVqSdrXaj
 HBnSgQvU/74f3/QD6PtX7bAAAAA==
X-Change-ID: 20260923-fix-mmap-prepare-overwrite-6304d112a4c7
To: Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>
Cc: Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2429; i=ljs@kernel.org;
 h=from:subject:message-id; bh=B/5OxH4zopJDHw6XR/oNfqdty/0ftHeGKu0ofzE6qRQ=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLK2CLjXS2s2qf181v8xJGaF9Zx97Ct5WeMDZp9LDNnha
 Cf9kTOzo5SFQYyLQVZMkeX5F/H9QSJh8zov+LvBzGFlAhnCwMUpABPRlWX473ije1/kep09ew53
 7DjrYLvx7xxG020Pbl/o+q8vmeqdNIPhf/xxAZefS87LfVGUVGmVf6Trybg6Zb6axoY5b86dyJf
 0YwcA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

It only makes sense to manipulate VMA fields if a new VMA was allocated,
rather than merged.

VMA merging does not compare vm_ops or vm_private_data, so a merged VMA
keeps its own, which is also what the legacy f_op->mmap path does since it
never touches an existing VMA.

Currently, these fields will get overwritten by whatever state is
established in the mmap_prepare hook, and if the VMA was merged,
vm_ops->mapped will not have been called, so this could destructively clear
existing state without replacing it with anything valid.

There is an implicit requirement that vm_private_data and vm_ops are
fungible across VMAs which means that losing the 'new' state is
fine.

However in this case the 'old' state is being overwritten by potentially
invalid 'new' state, so this must be rectified.

Additionally constify have_mmap_prepare while here.

All existing in-tree users either derive state for the tree or are
unmergeable due to VMA flags, so this has no direct impact.

Fixes: c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file callback")
Cc: stable@vger.kernel.org
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
Note that this is cc: stable to account for any possible back-ports that could
break it (unlikely) or out-of-tree modules which might be affected.
---
 mm/vma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 9f0a0acf694a..6cde67883fb0 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2849,7 +2849,7 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = NULL;
-	bool have_mmap_prepare = file && file->f_op->mmap_prepare;
+	const bool have_mmap_prepare = file && file->f_op->mmap_prepare;
 	VMA_ITERATOR(vmi, mm, addr);
 	const pgoff_t anon_pgoff = addr >> PAGE_SHIFT;
 	MMAP_STATE(map, mm, &vmi, addr, len, pgoff, anon_pgoff, vma_flags, file);
@@ -2892,7 +2892,7 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 		allocated_new = true;
 	}
 
-	if (have_mmap_prepare)
+	if (have_mmap_prepare && allocated_new)
 		set_vma_user_defined_fields(vma, &map);
 
 	__mmap_complete(&map, vma);

---
base-commit: fe2ec83746e501645709761605c2464a44fd2929
change-id: 20260923-fix-mmap-prepare-overwrite-6304d112a4c7

Best regards,
-- 
Lorenzo Stoakes (ARM) <ljs@kernel.org>

