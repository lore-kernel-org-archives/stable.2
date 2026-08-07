Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF17263F44
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 03:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786073706; cv=none; b=tFnXiQBQl8l7eXtcCYhL0vldiZ5S2fYUJIP6gua6ZKNilmmI4T7i8wYyFu17kZu2YAFm4thWvL2/YLgpNKxDfuDI0eBK3wvSN+upkPEmoQr6ZXMhLprfl3jhZt8tZMiyw4F5nojlmVOBRnqWjdEFsGVv8JzMLbFCUF9bwHv6GM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786073706; c=relaxed/simple;
	bh=IPcNEwmdmIL6shZkb6brbIxhS8abR99WN46J58FMS7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iLKksjy9qzHV8v09Pr9kvJN5kfchS5+vHOkCvt1zdqTIdFHPo/aomAc4BaJrBuq5Eir5+ZCnnFbRGi1GdYcz0zj8GVJYND/tuzSnFPGUaLIKAppzAnTwlJulGPqpIP/tlzYu0Vap6BcGDjgv5rk8IsqZiCqUNmGGCgaLI5H4p8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRVz93U6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRVz93U6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 771E01F000E9;
	Fri,  7 Aug 2026 03:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786073702;
	bh=OVfBD+11YJq18BTWABGGlwvlZc0kzsonAmLIpfHCnTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FRVz93U6pzZUlKlV0XaGkifjs0J9by02mejeJ3rcWkr1+3U1ml/xTYE6PT7z8b3/b
	 Bw41n/lMVU527PQiyoYl96OrNM9dOLIRvHyDdiExUo43k4V8jBeJdT+j1f07dq9X98
	 pUzCJudYqx2cl/YRRXFNp7hRI629ebHnHNai2v959ExfNux/8Z/PkXf1I+goXi7GCD
	 SYxt/olPyGcde5SXsMIl6QaWW2XP6Vs41QQKw66FDtN33I4scRDs1yPxYOJSlukCwH
	 CDFAcIgv/AtkYQOWJa1MWSBgzGtiAY0xDdGyyxUrTvgr1bspmYC/b9TYZaENtfU83j
	 9ZpKNU7TjbgEA==
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
Subject: [PATCH 6.18.y] userfaultfd: prevent registration of special VMAs
Date: Thu,  6 Aug 2026 23:34:59 -0400
Message-ID: <20260807033459.1725973-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072906-estranged-sinless-b8ff@gregkh>
References: <2026072906-estranged-sinless-b8ff@gregkh>
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
 include/linux/userfaultfd_k.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index c0e716aec26aa..796a380664bd8 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -214,7 +214,10 @@ static inline bool vma_can_userfault(struct vm_area_struct *vma,
 {
 	vm_flags &= __VM_UFFD_FLAGS;
 
-	if (vma->vm_flags & VM_DROPPABLE)
+	if (vma->vm_flags & (VM_DROPPABLE | VM_SHADOW_STACK))
+		return false;
+
+	if (!is_vm_hugetlb_page(vma) && (vma->vm_flags & VM_SPECIAL))
 		return false;
 
 	if ((vm_flags & VM_UFFD_MINOR) &&
-- 
2.53.0

