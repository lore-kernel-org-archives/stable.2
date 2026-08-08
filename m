Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED18347529
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 02:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786157555; cv=none; b=OBK4780810HhGwYLhuNItX3KzI35G5LxjQdmGFKAwfphF7jHDJQpJcMJ4a0c+T31sP8oWAMSqv6aZVvChRQ10kGeShXan1WSMEZsbhZGYspfZonQIEfB5dPbXu7WgUp5nE11x2JLmExGE0C6DEy8tSlKJ2954q4T1APmDXbNPhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786157555; c=relaxed/simple;
	bh=iofG20uerzb1i9MRCHhqTyWQ0ETuuhwjR0EMq9C2D+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sLKppoM2H/tgzHAKGUBBft3g+lwNK1vCHtu/Wyj6TVXvVWFqIng1pTVLlxnthv7xEZo7Te5/7CkcyeNajSVl6SXXZEPHAVc8F7Le1651+tvJ17L16zEcse8kWeCSy391EJMzbmVAQ7n/eUwXt7E6sXA7NI8IrJHi/SYZ53zU3BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ES+J32oN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ES+J32oN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275E81F00A3A;
	Sat,  8 Aug 2026 02:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786157554;
	bh=lISNuSz9U27P9mwMb7fnjbz85WqTN7mlQXzGYwEnFpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ES+J32oNDVT9MpaQaFN+TcavA5CUyZSQGeWWUUOjhMLttJPXHIitU/H3UckxQuqA5
	 p/QrFDP/QT43J1+4qQIeHwxnOag3p/NzRnCe2e6G95hDZqtiwxY2yDS5SfC/wENf+7
	 rQgnHhZOWdCOmhp7E/2/7yo3TFqkN+ruCrwJqK+AG7GD1zBGqNC0H9tU0gbPAA7+NT
	 pAATz+9ozYw/19nDlExyoOOYkrw8lDxSpMy+r8IsaJInybIAWDp1VpEhchdItgWK55
	 tCQogdg6kh5I/Dy6Fkb79Bp2r1isGl5h5ac+80Xjb+txNqT4zutUDElOlvl3aQFWtI
	 F6veqhxH8aFVQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	vova tokarev <vladimirelitokarev@gmail.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] userfaultfd: prevent registration of special VMAs
Date: Fri,  7 Aug 2026 22:52:30 -0400
Message-ID: <20260808025230.4028587-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260808025230.4028587-1-sashal@kernel.org>
References: <2026072906-scheming-vocation-25cd@gregkh>
 <20260808025230.4028587-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

[ Upstream commit 3c58f641e813c3c71039f8fd4d4e2a3aab713288 ]

Vova Tokarev says:

  userfaultfd allows registration on shadow stack VMAs.  With userfaultfd
  access, you can register on the shadow stack, discard a page ... and
  inject a page with chosen return addresses via UFFDIO_COPY.

Update vma_can_userfault() to reject VM_SHADOW_STACK.

While on it, also reject VM_SPECIAL so that if a driver would implement
vm_uffd_ops, it wouldn't be possible to register special VMAs with
userfaultfd.

Since VM_SPECIAL includes VM_DONTEXPAND which is set but hugetlb, exclude
hugetlb VMAs from the check for VM_SPECIAL.

Link: https://lore.kernel.org/20260618095017.2553004-1-rppt@kernel.org
Fixes: 54007f818206 ("mm: Introduce VM_SHADOW_STACK for shadow stack memory")
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reported-by: vova tokarev <vladimirelitokarev@gmail.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/userfaultfd_k.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 75342022d1441..8ff68ce1860be 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -216,6 +216,12 @@ static inline bool vma_can_userfault(struct vm_area_struct *vma,
 				     unsigned long vm_flags,
 				     bool wp_async)
 {
+	if (vma->vm_flags & VM_SHADOW_STACK)
+		return false;
+
+	if (!is_vm_hugetlb_page(vma) && (vma->vm_flags & VM_SPECIAL))
+		return false;
+
 	vm_flags &= __VM_UFFD_FLAGS;
 
 	if (vm_flags & VM_DROPPABLE)
-- 
2.53.0

