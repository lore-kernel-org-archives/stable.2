Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794455978;
	b=LBsXgdhBKRH4/UxhPULTyhp8DRVPgaKgVFV5QiuGPYd8nsSmFukLJv9HjyHhFSQgWKrG
	 cOeoUd1RwFdUSa+a9dkBwKMWzkGv2aLw1RyPRyX1u1eXIjbKASmIlB3gO41qOSaan9J5E
	 1ZWiUHfvvHVSYJ/8KODq/xAwzT81lkjrNezsTtIPL3ssQCat4hiMPqQvGWk+OegYdmoGs
	 VY2463knyrn2YrTwVm7VwOQhcdc//Yj5PPXf2qM/guu3vBrqkaMnoH+Vx3rjSTehM9q6G
	 9eb0d4uQK7/OPHPSyUka531cY7P71TntPV6O6vDgZzsLLw38CupU+3nAxNPPaCbhZJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794455978;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=B1rjHwzRMSWAtmbA29yTE6CaiNyV71QbpXffM68IGs8=;
	b=Ahom2TK0xMDOReA5Pz6HM9q1KrTQSYHoLbIQSpVDaLATIrIsKoCGZeHIYziOK2hSjdlI
	 KF2rfe3aTX0SPI8tulQA8VENyYjVzQrDmITNLMiRztQvckE7k/RN6wFOXQVj9NbNU56v9
	 /ca0CARhd9Mlz9xCZaq9J8VDeC97x4l4kDjGJzvSnk3Gvz5sMUdf604BR9tl6KSFkOpaD
	 BxVEx8rO+WpSpuoQuG4GNcHbnUdXg3SAXzn3hOMVjaAcgPvhrSN7nOVwJ4AFYGHfnnCmb
	 Pv811glZEyQlxDu2vL/8p74b3TIlRz9+VwbPP2k22TBUdZ5SC1XUMjbrdBtfkxOA/ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WTOc12Qx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E3D606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 03:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WTOc12Qx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0527F1F00A05;
	Thu, 12 Nov 2026 03:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794455978;
	bh=B1rjHwzRMSWAtmbA29yTE6CaiNyV71QbpXffM68IGs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WTOc12QxVRbQEAGWDGCx+GvBIBceQkxgMTEEQU0fIOr4OTeLaTfYT5qYL+ioj9Cau
	 Ogve9P4KnjJ66wfSVT875aUEbbaYshOS4G0o9BnKfqJmgJyKzN75skGdmuH+lwMqKn
	 X8eSAY0upXO9zKvEIkZa3zTgJwD6iwWb0F5spzBzb8kt9D6JxrUdmoDxjFnUfabO8N
	 MFu6ZMbaFsU/FHmm8kCVtKkOqXQE2pRJF/5QKu8/wSNsy6wHg5DacbGbg6kdGdVlSK
	 tNov+Y9byesEB4uBs3PN+0sMl6nHT+ivarrdJ4U7ofu/feeyIPRT/IVE0Z5Mr1+cSC
	 qBo3Q1BzOlpWQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Luiz Capitulino <luizcap@redhat.com>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	"Liam R. Howlett" <liam@infradead.org>,
	Jann Horn <jannh@google.com>,
	=?UTF-8?q?Jakub=20Mat=C4=9Bna?= <matenajakub@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mm/vma: fix expansion of VMA_MIXEDMAP_BIT VMAs
Date: Wed, 11 Nov 2026 22:59:35 -0500
Message-ID: <20261112035912.1673036-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201653-failed-6.1-8146c6478224@kernel.org>
References: <20261109201653-failed-6.1-8146c6478224@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>

[ Upstream commit 8146c6478224d8f6395c6b08a19c344a56d79867 ]

Commit ca3d76b0aa80 ("mm: add merging after mremap resize") combined
merging with expansion of mremap()'d VMAs, however it also unintentionally
disallowed the expansion of unmergeable VMAs.

Previously it was possible to expand a mixed mapping which mremap() had
already ensured was a legal expansion.

This is clearly seen in the mremap() logic, as it checks
vma_is_fixed_mapping() to determine legality of an expansion rather than
vma_can_merge().

Additionally, copy_vma() allows for a failed merge to result in a new VMA
being instantiated if MREMAP_MAYMOVE is specified.

However, this is not attempted, as a failure in vma_merge_extend() is
assumed to be an -ENOMEM failure.

Since vma_merge_extend() is used exclusively by mremap() to perform a merge
and/or expansion, resolve the issue by invoking vma_expand() for
unmergeable VMAs there.

Explicitly assert that the VMA is both non-fixed and a mixed mapping.
This provides double insurance against broken changes in future.

Note that khugepaged_enter_vma() (which vma_merge_new_range() runs) is
redundant in this case, as a mixed mapping is not subject to khugepaged.

Also update the VMA userland tests to add a required predicate.

Link: https://lore.kernel.org/20261023-vma-expansion-fix-v1-1-6142baf1f46b@kernel.org
Fixes: ca3d76b0aa80 ("mm: add merging after mremap resize")
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Luiz Capitulino <luizcap@redhat.com>
Closes: https://lore.kernel.org/all/20261023023106.515365-1-luizcap@redhat.com/
Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Jann Horn <jannh@google.com>
Cc: Jakub Matěna <matenajakub@gmail.com>
Cc: <stable@vger.kernel.org>
[ sashal: adapted VMA expansion to use the existing vma_adjust() path instead of vma_expand() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mremap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index ec66e7be8afea..f7d9687d7735b 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1098,8 +1098,12 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 			 * expanding, so perform a simple expand for such vma.
 			 * Ideally the check for close op should be only done
 			 * when a vma would be actually removed due to a merge.
+			 *
+			 * Mixed mappings cannot be merged either, so they also
+			 * need to be expanded directly.
 			 */
-			if (!vma->vm_ops || !vma->vm_ops->close) {
+			if (!(vma->vm_flags & VM_MIXEDMAP) &&
+			    (!vma->vm_ops || !vma->vm_ops->close)) {
 				vma = vma_merge(mm, vma, extension_start, extension_end,
 					vma->vm_flags, vma->anon_vma, vma->vm_file,
 					extension_pgoff, vma_policy(vma),
-- 
2.53.0

