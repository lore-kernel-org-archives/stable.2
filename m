Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B565B472077
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 18:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790100368; cv=none; b=Xqb0jJo5f6SxPvO5RVi0FCWRxJX7fiPIqUQ1nEyz0+zkwbqoiraaEBs+iAP94165QPjSSwi3Kpi31u0exIhJoPj8LjX0X90ZKa9MLgNj7dpaCVE2aZjQtGgJZ2W7HCsdw1LZaKqpqBWzujZ+2ol2awckdP+zVRdbLRjycUZGO5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790100368; c=relaxed/simple;
	bh=aHhCyhi31T7sRvPmZ/vTo4R8QUjr9FJ8uPAqSl+kXHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KFUzQrtrooy0JBPCVjDbZy3Uwk2MHJC/hStEfCcgj3ydhHTTaGAJ5IY6cZlK0wksLCthqcCwpKwNcK6ICmU+jXcB7vjQLWc9fXPAbDbHonXNHVuEnI23NxVj3+Bb76DzzAT3PpPMP066HtsclahX7bSbzL6fJuBjhwNw8shPQzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4vYPuSP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4vYPuSP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36841F00898;
	Tue, 22 Sep 2026 18:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790100367;
	bh=uZ+DBjLol2gS2YZbPbP/JGJ3joxYBt5ptN8cutmQg2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K4vYPuSPZd+Dtabf8YCya6RZL+nNBaNLMEQ+zmf0STU7adUuFCYiRV4l8S+2WM6Ch
	 xqbzv7eL0e9GX9GDD3uqcabwWWQ3pvf2ZpgofR9po1PB0IV4QR1qYOKYA5S/BbOw+Y
	 FoM62T/eB62Y4NrYxBPTj1utofmCShUyqBrdLGAo/JzrCkb+IUhjs7ZLswjiWBdbwU
	 KjY5AZGk57STlGqee1UvfrtiO+hCoiWjKR0s/K478Zzfecff3bxmNx7ZPOekzHmQZY
	 QPJnt9D2aGmiPZd2eFg0BXYKItR/vFwQKBI85uK5RVRU/qW2xo94WNFMKyo3Uv7o+Z
	 j50qd3d7hBIVg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Jann Horn <jannh@google.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Vlastimil Babka <vbabka@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] mm/vma: correctly unaccount on mmap_prepare() failure
Date: Tue, 22 Sep 2026 14:06:05 -0400
Message-ID: <20260922180605.3399750-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092235-visor-glance-dc8e@gregkh>
References: <2026092235-visor-glance-dc8e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>

[ Upstream commit 6cc27d82196385fe06853319f74312a7d8019726 ]

__mmap_setup() accounts memory for relevant mappings via:

security_vm_enough_memory_mm()
  -> __vm_enough_memory()
    -> vm_acct_memory()

If __mmap_setup() fails, this indicates that this accounting did not take
place, and thus it's appropriate for __mmap_region() to jump to
abort_munmap.

However if call_mmap_prepare() fails, it also jumps there and any accounted
memory is not correctly unaccounted.

Fix this by handling each error separately.

Link: https://lore.kernel.org/20260902-fix-unaccount-mmap_prepare-v1-1-ea070189fdfb@kernel.org
Fixes: c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file callback")
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/vma.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 30148e6af7751..dcaa2d8998bfb 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2693,10 +2693,12 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 	map.check_ksm_early = can_set_ksm_flags_early(&map);
 
 	error = __mmap_prepare(&map, uf);
-	if (!error && have_mmap_prepare)
-		error = call_mmap_prepare(&map);
 	if (error)
 		goto abort_munmap;
+	if (have_mmap_prepare)
+		error = call_mmap_prepare(&map);
+	if (error)
+		goto unacct_error;
 
 	if (map.check_ksm_early)
 		update_ksm_flags(&map);
-- 
2.53.0

