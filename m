Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E5F3EFD24;
	Thu, 15 Oct 2026 16:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792080520; cv=none; b=Gnh5vpE/mRy0dg6SZgP1HhK1w3XjV660KPKp1MJnprdMC+C4xTQSYEv2zyJRxasae17ZtwD1kuBoB3aduDq8nOj/P0N5eUtCYkZHP28JBY24FLlK04v/GDmqVaP+4Y+s+Wz2nKz+NR25p/f1cekpMBzTjD2/zhijapK2b//9TOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792080520; c=relaxed/simple;
	bh=xzUoLGsOY/4424/eZSx1vu8LhLt89f41pteXNyOKue8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ut6m6/Gb9N4rcyPDlle3kG2XybfQmge9GLtH1TVJTa5VD8FzoRW1B9MCrQjZKhPrDHnXGH4l7lHX1yzvboyDCHSrzopcifyhH1IlzXdNBx/ok2DXlcVnkdQ0fXBl8aogFltSNVq6vGnVXphyviItGGWe/YTmglcRqmyNnS7z+Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0BiqyM1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0BiqyM1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18C91F000C6;
	Thu, 15 Oct 2026 16:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792080506;
	bh=aNBJ012Mx6kfcvUBOVNjCydGf++Y8d3EAS1qqSl0elI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=S0BiqyM1EikbU5FSP5gpgmgVDBpDGZBYWODwAV1Ic3pNA1VmXdIOuQKrAshlqR3Qh
	 wVP9C6RR2rBriogLU/+ZEYh5q71OPq3xSELDt/+3lXBBdtWTc62aIKPCFWPSZq0FTf
	 y6+9+NgDq6+rinyM3/++iSFdepuLfZS1iXvRjqoHz/LLqcH2SBHFMQrbsWVD9qMVGX
	 Npc6IX+bOez0lyR1YTFpqRQ4DunIPt8k24kjrcvhVpo20A5FzpUgPqMMA4R9ttx4ME
	 T2oHNK+l1Aj19WPcDh0pts0jgnqhIXtUncc3/s8gfI4+GuDEuAybw/NORTIoyH32aV
	 s37ewwY6xA1WQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 15 Oct 2026 18:07:16 +0200
Subject: [PATCH 10/10] mm/mremap: fix calling fixup_hugetlb_reservations()
 on the wrong VMA
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-urgent_fixes-v1-10-42796911043b@kernel.org>
References: <20261015-urgent_fixes-v1-0-42796911043b@kernel.org>
In-Reply-To: <20261015-urgent_fixes-v1-0-42796911043b@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>, Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Adam Litke <agl@us.ibm.com>, 
 Mel Gorman <mel@csn.ul.ie>, Rik van Riel <riel@surriel.com>, 
 Peter Xu <peterx@redhat.com>, "Kiryl Shutsemau (Meta)" <kas@kernel.org>, 
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Josef Bacik <josef@toxicpanda.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1190; i=david@kernel.org;
 h=from:subject:message-id; bh=xzUoLGsOY/4424/eZSx1vu8LhLt89f41pteXNyOKue8=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIu/DIpVItrO/T+XsDxVxsfyqpM+Td5ovDErdGyr3ZqT
 jh2/utCvo5SFgYxDgZZMUWWoOD7Bi9frqutduNjhpnDygQyhIGLUwAmsuEDI8OUOOH5+WJBQm+u
 xXNcnr3e6QdPid4Hqb8/ltfaOHxx2GfP8D+9qqk/RG3zpy9q+ZLHG72S6nZxFrUa31m/csHRGGu
 dbewA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

In case we fail to move the page tables, for example, because we fail
to allocate a page table, we actually keep the old VMA.

Calling fixup_hugetlb_reservations() on the old VMA is wrong. Fix it
by just calling it on the VMA that will be removed.

The user-visible impact is that the VMA loses its reservations, meaning
that the existing reservations get stranded (leaked) and new hugetlb folios
that are getting allocated in the VMA cannot make use of the
reservations, failing these allocations.

Fixes: b714ccb02a76 ("mm/mremap: complete refactor of move_vma()")
Cc: stable@vger.kernel.org
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/mremap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 444f37d7cd28e..ace0c6a343b1b 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1345,7 +1345,7 @@ static int copy_vma_and_data(struct vma_remap_struct *vrm,
 		mremap_userfaultfd_prep(new_vma, vrm->uf);
 	}
 
-	fixup_hugetlb_reservations(vma);
+	fixup_hugetlb_reservations(vrm->vma);
 
 	*new_vma_ptr = new_vma;
 	return err;

-- 
2.43.0

