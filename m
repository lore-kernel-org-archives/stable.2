Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC51812B143
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 10:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791109135; cv=none; b=UQyuRH+2YZUwwmGi64rTf9/l956D9F7/4TXL1YsQIJ4qfEbCato9PG9CfTCLO5ZyQRev9lrMlP6TTMu5Jdrt9qwC9b3Vv8ACBRPnQgE3t6x24tYX/2TGziqhqoFOsL9tASCKtZV7YiphHgV3dMyf//Gh2b6LAbupK9713xx7eWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791109135; c=relaxed/simple;
	bh=I4I59Uds3fmGqMORk19vUYNfQzd3D9UhlTJXKcCQ4Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CzOVSCRZdueWPKWrE5TxFmZ+sbVhrfRY71JTn6/aQYiaueRxeAvtZA0UF/M9ipkMErArPnydRoAeTFGz/7VByAai2KSFHsIMrir+fgJIre+9yrS5Q1djJmjyk/ZR3+QGbLhi8DsmZ62zdNihigGTgpM1uUChsfQrhZ+oXzdA/eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivjMGKVS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivjMGKVS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B831F000FF;
	Sun,  4 Oct 2026 10:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791109133;
	bh=xc14X6xaQO6wW+pUhK7rNrBmwlu+tmmmHNnXANJEneU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ivjMGKVSDpRh2caJfNH6KOKUB1uD9Mi++7q+YKh/5v/yL7ldsZBlQTlOgwAuwJyyf
	 qtMgMcbS11qVK5tjl/Em7EZ7esFm9QtyYh03cejOL5n02Wtv6w3Xmk8OH/kgyNaT/I
	 i3/EgrJStu5pOnFyqamx54PibspUhODASjnc2nghg7+7u6Zk+AAvlGQ3RdN4sJX51i
	 A4B1WDXWVoa2G1nd6/DmPHj0hKiy2C9CdMGJDWsQl4dCmqe+63XeJn/freKY0VLrv6
	 WvixY3Ks8QPtq/5TZK0SilDpgX9P0V2NNPIV90LGmvhF+vrG0LllpKAUeCdGTp69wg
	 2ivDAdrX253rg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	"Gregory Price (Meta)" <gourry@gourry.net>,
	Zi Yan <ziy@nvidia.com>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 5/5] mm/vma: predicate setting mmap_prepare VMA fields on new vma alloc
Date: Sun,  4 Oct 2026 06:17:55 -0400
Message-ID: <20261004101719.1402752-5-sashal@kernel.org>
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

From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>

[ Upstream commit 976d5e0ddac885b0219252f004f6c561c344df9d ]

It only makes sense to manipulate VMA fields if a new VMA was allocated,
rather than merged.

VMA merging does not compare vm_ops or vm_private_data, so a merged VMA
keeps its own, which is also what the legacy f_op->mmap path does since it
never touches an existing VMA.

Currently, these fields will get overwritten by whatever state is
established in the mmap_prepare hook, and if the VMA was merged,
vm_ops->mapped will not have been called, so this could destructively
clear existing state without replacing it with anything valid.

There is an implicit requirement that vm_private_data and vm_ops are
fungible across VMAs which means that losing the 'new' state is fine.

However in this case the 'old' state is being overwritten by potentially
invalid 'new' state, so this must be rectified.

Additionally constify have_mmap_prepare while here.

All existing in-tree users either derive state from the file or are
unmergeable due to VMA flags, so this has no direct impact.

Link: https://lore.kernel.org/20260923-fix-mmap-prepare-overwrite-v1-1-3b3f1bfcdf5e@kernel.org
Fixes: c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file callback")
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Acked-by: Zi Yan <ziy@nvidia.com>
Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Jann Horn <jannh@google.com>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/vma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 5d19adbb63a56..d4e85c252563b 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2676,7 +2676,7 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = NULL;
-	bool have_mmap_prepare = file && file->f_op->mmap_prepare;
+	const bool have_mmap_prepare = file && file->f_op->mmap_prepare;
 	VMA_ITERATOR(vmi, mm, addr);
 	MMAP_STATE(map, mm, &vmi, addr, len, pgoff, vm_flags, file);
 	bool allocated_new;
@@ -2710,7 +2710,7 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 			goto unacct_error;
 	}
 
-	if (have_mmap_prepare)
+	if (have_mmap_prepare && allocated_new)
 		set_vma_user_defined_fields(vma, &map);
 
 	__mmap_complete(&map, vma);
-- 
2.53.0

