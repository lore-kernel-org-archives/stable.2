Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794450889;
	b=gc7kcGV5701GH8HNGYhaG93vK+Chc4xkNTs5bHIwP8o6RaBKfMkTstDGwcvP3B2QJZW4
	 WhgBgIkwLoVsSO/zE3btKm2FxT1YU0jLeRm4kjSewzzGnXYdrO3o99sYdioQjz2QPg66+
	 M8muTmAEqn29wBwKF2hFGcSnmg6wiEtxzZp9qPU400sUQB1ZSVVtryVjOj53TJ3dNePyM
	 f8WnaihBwrDBsqyyAtfG2sD4nkZDEHY5n6MiHBEsIlShWie1FjKqfG/XZ5u6Y8DFmFEa4
	 JWzMCUu+O+mv37hQwG7sMe7ZUWRL7FFCUlvLP77dfFDm4oK+pry6GjGYEtuv/pa1tSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794450889;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=oJPZiK26/bdeLFlcCoQjyj9Qi5rthvWPpsJ6dfb8lPs=;
	b=XL/5G1P1IOJQ/cV5v/wujXMFcDK9JL//jXh24X5VDDYfhZvLRzpaKoWz52hI6RKdo7z1
	 n+CaLlDJCG/mTK+or2cSZfbQuZYri/WpYqgmjnklji8zXQg0AqOfikzxrL8HYZmObddrx
	 yS8NE5X/DvwRRnsRkQKFgHEi0JkF8JoVSH2sZ2nQ3cUZlDL9q4pfeeTzg0aeKvWv9IDCC
	 ZPHTxG9Ac++s/7oL2iaSfMQu/f3yHnXBemEoISaJa+ezx+UqyDh8udoUFGsIJhjml/L9p
	 7UOcsItE6HRScqFG2Ta2kzHv0Ck9POOHtVsFyHzTY8NWzF1oBv753l8rbhhoTJGb2cA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="G/IVx/lK";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F3E606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G/IVx/lK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89611F00A06;
	Thu, 12 Nov 2026 02:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794450889;
	bh=oJPZiK26/bdeLFlcCoQjyj9Qi5rthvWPpsJ6dfb8lPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G/IVx/lKWy92H7m45j3+QjtO1jbTZLcW1YVfJ9UEfhxTCD6U+FuGWAx9OU0B5cVfr
	 wH0VxCoQYBWccAnIpgn09vaQQnmHRPZXKw1JPp+CVnzeOnNBUpI590MIDSP6cMuXD2
	 9DfsGU67QT/B/a2dTumR/qvi8nOfw+DF2Wl9iVKj4d4F/RGlJOtDoiLoUF4ewz9Hxg
	 o6yzAvzDv1fManJXwIMvCsGrYp2Ihjw0zC/k603xhzVrb/SRX9M63x1ZQape7BziN1
	 OUAJsUqVNAqiLt7qaYuzS9zkkWy4aE60ekScPH0/XB0wwC5J4tb0MwguZl7BfWnahY
	 sjL1dMAm2h8wA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alistair Popple <apopple@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Dan Wiliams <dan.j.williams@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Asahi Lina <lina@asahilina.net>,
	Balbir Singh <balbirs@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Christoph Hellwig <hch@lst.de>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ira Weiny <ira.weiny@intel.com>,
	Jan Kara <jack@suse.cz>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	John Hubbard <jhubbard@nvidia.com>,
	linmiaohe <linmiaohe@huawei.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	"Matthew Wilcow (Oracle)" <willy@infradead.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Peter Xu <peterx@redhat.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Ted Ts'o <tytso@mit.edu>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	WANG Xuerui <kernel@xen0n.name>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] mm/gup: remove redundant check for PCI P2PDMA page
Date: Wed, 11 Nov 2026 21:34:41 -0500
Message-ID: <20261112023429.1348841-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200900-failed-6.12-79cb51d538ab@kernel.org>
References: <20261109200900-failed-6.12-79cb51d538ab@kernel.org>
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

From: Alistair Popple <apopple@nvidia.com>

[ Upstream commit a58c6fb6623d8aef36c0c4e0b8a48770deef3213 ]

PCI P2PDMA pages are not mapped with pXX_devmap PTEs therefore the check
in __gup_device_huge() is redundant.  Remove it

Link: https://lkml.kernel.org/r/260e3dcfaf05ff1c734a49698ed4332b5dae04c2.1740713401.git-series.apopple@nvidia.com
Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Dan Wiliams <dan.j.williams@intel.com>
Acked-by: David Hildenbrand <david@redhat.com>
Tested-by: Alison Schofield <alison.schofield@intel.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Asahi Lina <lina@asahilina.net>
Cc: Balbir Singh <balbirs@nvidia.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: linmiaohe <linmiaohe@huawei.com>
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: Matthew Wilcow (Oracle) <willy@infradead.org>
Cc: Michael "Camp Drill Sergeant" Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Ted Ts'o <tytso@mit.edu>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 79cb51d538ab ("mm/gup: recheck the PUD under PTL in follow_pud_mask()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/gup.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index d9107eb461a02..b539ab0a29fce 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -3058,11 +3058,6 @@ static int gup_fast_devmap_leaf(unsigned long pfn, unsigned long addr,
 			break;
 		}
 
-		if (!(flags & FOLL_PCI_P2PDMA) && is_pci_p2pdma_page(page)) {
-			gup_fast_undo_dev_pagemap(nr, nr_start, flags, pages);
-			break;
-		}
-
 		folio = try_grab_folio_fast(page, 1, flags);
 		if (!folio) {
 			gup_fast_undo_dev_pagemap(nr, nr_start, flags, pages);
-- 
2.53.0

