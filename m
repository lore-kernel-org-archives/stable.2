Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A073C1402;
	Thu, 18 Jun 2026 09:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781776225; cv=none; b=g4UmLra7glwCoNm6wFNfiZ+npGShtFnb4X+nAynY9JA3JLze+q4PMeoQhKynxmDgcha6pzEoIjBgmBmDdfd6SHxoKVLYzQGN7feU4FZY84QphHyAEHzQ+uJAngVu4S2rFWBYBBCunzj9MvN2TiwxvHgruZAV8OmXfXkL3NiJVnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781776225; c=relaxed/simple;
	bh=1X/LLlJo0XKVnDm+ByK3MJQEd4TUzqoNqPBV75130YM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UvHiilWqU9FHShEIWzZOpgg64aGBMdfoiDCpWlx3GiV5MrWdc3K/T4tQxTed6oKCFWWuXLf2RtTeMJSGqmSHVbIYPijIOi7WSDgSm0bvUQultFazBAYEWCB0sUpqs7a4ZT67Px+YcBwDRewvO1FO1RtPu6KVjLynpV8HQde0n5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxqGFQBh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxqGFQBh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 247ED1F000E9;
	Thu, 18 Jun 2026 09:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781776224;
	bh=BWwwCWEs6k8jntGbl6gKaqqrPpfzJ0y/J83NkZ0wKkM=;
	h=From:To:Cc:Subject:Date;
	b=YxqGFQBh9rYaT2yOGmXP+bDnc2URzBXy0IkTpq9liQGs+U9DbtfTzEAtneEcieh5l
	 5x9htkhbdrDnl0Sot0soTd87KwFdwqztJPJJbMdyOE0hdJ82AdXhJXC8z/A9A/ti+W
	 asitA/IUXGo2M9KJvp4rcHC9ETTy9mTHrPFP/qqDcgItj009sK0UThX340K87CyF3x
	 S1h4DThiX8JD4JtJ1Loj/WyZUGt+UuL1M1X+MbH4b6/VCjlssUrEiviMf7M8xqf05i
	 KeZ8eZtbcWMDw7ZMRQA2/7PUgJbRG1Rgq/qFCKUPYNWZb3y8zkoDn1ypTAH90+17X/
	 5T4TIpQVFtB9Q==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	vova tokarev <vladimirelitokarev@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: [PATCH v2] userfaultfd: prevent registration of special VMAs
Date: Thu, 18 Jun 2026 12:50:17 +0300
Message-ID: <20260618095017.2553004-1-rppt@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Vova Tokarev says:

  userfaultfd allows registration on shadow stack VMAs.  With userfaultfd
  access, you can register on the shadow stack, discard a page ... and
  inject a page with chosen return addresses via UFFDIO_COPY.

Update vma_can_userfault() to reject VM_SHADOW_STACK.

While on it, also reject VM_SPECIAL so that if a driver would implement
vm_uffd_ops, it wouldn't be possible to register special VMAs with
userfaultfd.

Since VM_SPECIAL includes VM_DONTEXPAND which is set but hugetlb,
exclude hugetlb VMAs from the check for VM_SPECIAL.

Reported-by: vova tokarev <vladimirelitokarev@gmail.com>
Fixes: 54007f818206 ("mm: Introduce VM_SHADOW_STACK for shadow stack memory")
Cc: <stable@vger.kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---

v2 changes: 
* reject all VM_SPECIAL except hugetlb

v1: https://lore.kernel.org/all/20260617194059.2529406-1-rppt@kernel.org

 mm/userfaultfd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 246af12bf801..c3adedaaf7d5 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -2111,7 +2111,10 @@ static bool vma_can_userfault(struct vm_area_struct *vma, vm_flags_t vm_flags,
 {
 	const struct vm_uffd_ops *ops = vma_uffd_ops(vma);
 
-	if (vma->vm_flags & VM_DROPPABLE)
+	if (vma->vm_flags & (VM_DROPPABLE | VM_SHADOW_STACK))
+		return false;
+
+	if (!is_vm_hugetlb_page(vma) && (vma->vm_flags & VM_SPECIAL))
 		return false;
 
 	vm_flags &= __VM_UFFD_FLAGS;

base-commit: e3d8707358ea76b78bdec9928937bb9a797f2c8f
-- 
2.53.0

