Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5884638A72C;
	Wed, 17 Jun 2026 19:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781725267; cv=none; b=qRCEhbSooP3fOk4C3peBqO7Zhp19I3ASHHcAr4WcIutkoM3w8XgfjqDzPOe6hMBFecZ8tnHh3emDQXQE8HFQ5/7A3S+Y6G8/1xAaRwbNX8QK8C0h+NVe312F09N+lqAdhzqhOrkFJUBG+UnysBFkLH3uctXzUy+DkWcMFuLnRzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781725267; c=relaxed/simple;
	bh=cLCtUrFszsNpqaXSsFU9smSVm9I+BmoRFXf4J4vNNuw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QvIIzv9icA3xn0XOhTnpUDPvjJ6dBn1m1fLdUjLfRExlZblifb11CBLqM/p9FyqqXyZISbHCwmVIKwqH2uDO9eMeReqXYVbyKBTPgjesm4t3WGc/a/QjcpD2jNz5uM5DZLPwL+yjLsMYnYzQhJyILup073apFXRdqX08HUluJMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWDvejAF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWDvejAF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA611F000E9;
	Wed, 17 Jun 2026 19:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781725266;
	bh=SOS1yGkhDPya+/uAhiZ1+Rq+6pspSgmQL30KoFCQaE4=;
	h=From:To:Cc:Subject:Date;
	b=gWDvejAFGLUPpouhULsa6FkMZlkYa1bbkiKWcOYyc6h8izFiTlHGQdTDxmdzm7Av6
	 6FVUbO3pIohmkRkC3dW+mxqY6hY5i0HYWosv43Bdh6bQx/0O8W9aEJir4BPzJ7nRW+
	 IKxlIkkG5tBeN6ghY8lO0i0Pn8ZnESPASKjFV0Tfrvx5V6bFxOuu+dY+d3olggfwNT
	 a8Ukf+1UizEgbleF2FM7sVEu2QSSP5Cpws5MK2IYnhiO0azQ5Ao4zFECcrblB1SO7f
	 7NwIhJHk1LxugF7QS4kxIFPtZDvY6tftOGGZ4SrlSnBBabqHbZNpcJxpCwSuUjm7+K
	 Wlxfi4YwIPNQQ==
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
Subject: [PATCH] userfaultfd: prevent registration of special VMAs
Date: Wed, 17 Jun 2026 22:40:59 +0300
Message-ID: <20260617194059.2529406-1-rppt@kernel.org>
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

While on it, also reject VM_IO, VM_MIXEDMAP and VM_PFNMAP so that if a
driver would implement vm_uffd_ops, it wouldn't be possible to register
special VMAs with userfaultfd.

Reported-by: vova tokarev <vladimirelitokarev@gmail.com>
Fixes: 54007f818206 ("mm: Introduce VM_SHADOW_STACK for shadow stack memory")
Cc: <stable@vger.kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/userfaultfd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 246af12bf801..b8d2d87ce8d7 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -2111,7 +2111,8 @@ static bool vma_can_userfault(struct vm_area_struct *vma, vm_flags_t vm_flags,
 {
 	const struct vm_uffd_ops *ops = vma_uffd_ops(vma);
 
-	if (vma->vm_flags & VM_DROPPABLE)
+	if (vma->vm_flags & (VM_DROPPABLE | VM_IO | VM_MIXEDMAP | VM_PFNMAP |
+			     VM_SHADOW_STACK))
 		return false;
 
 	vm_flags &= __VM_UFFD_FLAGS;

base-commit: e3d8707358ea76b78bdec9928937bb9a797f2c8f
-- 
2.53.0

