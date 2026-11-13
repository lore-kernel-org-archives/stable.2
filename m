Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794598951;
	b=iDrwzmGZaeuUMQsrlJSao1DktyeQNfUXXk78FYOuhT6nz5T1inXtRX3pcDv3+HWyoo+2
	 LFPvd1CqpuCizn4JSUxaJKOXt36JNbYcv80o4XeS9tb5tA12GaE1eBTSo7E1mizFJzBJS
	 GJqUWQzyNW4gckv8RNci/VA6i/qz7TmpoLKzgDhYZrb8W3Nkug0jvk8LrDKbso+OiZgvh
	 DP2qRYUg14/MyNG2A+e/uiCdXjHfNNl4j1fYKl+MzrzXC3wq68ClDB+cp07DBF1KfjSqw
	 rYUBDkciv0B8M/35jtj+KpZg0GA9FBn1TsNri6FDRAJqRyPTHaaw5YBBuDvxCr6j7wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794598951;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=LogwcYtrX+XCW6GBeFOgmxo8/nnt6bbp/Xy3FOl0GLQ=;
	b=0c1/wCEnLZ0u2tsvPeAtXb5QogekmeiH+HThBeOTAyCIZYoVO28sc4HBwFBM+3wl5JSX
	 mo1Yqb2xv2FmdMWTZN5DVFuCv+OGWraZsYmEUlC2BFnV0qV02u40xAwYbQGUtnDgw43+y
	 cBIVn+z7UNhNsa6DEQAEL132NuUiInO0lr9lwk7I8yPn6+nqD6dFNS39rjmcS4boWIY4N
	 nu7sUo56nXNhB67r07Jypc2f/Xyc1HxGyg+4oqpzW7IsWHIhFKxPMXp5iB0Xm2jojv7NF
	 mhntcWszHQqZFaWQ/UcRSKsmPVwwqSrn1Knoyu9gWXrpHcWi+oy4O5d3oZeUxGLppuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hNOs+dGk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DF0606A333
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hNOs+dGk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75BD11F000C4;
	Fri, 13 Nov 2026 19:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794598951;
	bh=LogwcYtrX+XCW6GBeFOgmxo8/nnt6bbp/Xy3FOl0GLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hNOs+dGkClaKriERUWAAONMQHnIeOHKVS50a+5yk1apix3EUO9DRims8dGTh8T36T
	 nJbG6qtcRZpHjHt3X1uVOMuWqP1zLRd9VPhpocIj4GAmC9diWZgLvJJizJqPuQl4XF
	 SQSIPxVlcChYK5yarIKoAZ7i0axXfHwgV4F+C14FrUTya0kQbmZInu2lqqzCmChzcH
	 5viYhAEPlZb1PFzOkUp0dXE4XenffYJ9j6c/5j+NmQ2H1rqQ5MIGpPXSViwOehuyEv
	 t64o+ipQLoBkJkZ/yWZTna/e8FY7BUFqlSTb2lhd6l/fHiJ8zTIHaQpyEvCOaum2F+
	 oz/Dw9v39Im6Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Pedro Falcato <pfalcato@suse.de>,
	"Gregory Price (Meta)" <gourry@gourry.net>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jann Horn <jannh@google.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	SJ Park <sj@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Colin Cross <ccross@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mm/madvise: preserve VMA_SOFTDIRTY_BIT when changing anonymous names
Date: Fri, 13 Nov 2026 14:42:28 -0500
Message-ID: <20261113194000.2472091-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201213-failed-6.6-652f15be3c11@kernel.org>
References: <20261109201213-failed-6.6-652f15be3c11@kernel.org>
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

From: "David Hildenbrand (Arm)" <david@kernel.org>

[ Upstream commit 652f15be3c11415725694ccea317c51e35c0b582 ]

When changing the anonymous VMA name, madvise_update_vma() calls
vma_modify_name() to possibly merge with adjacent VMAs. We don't call
vma_modify_flags() and consequently don't obtain the new VMA flags.

Later in the function we update the VMA flags to the stale new_vma_flags
we obtained before. This can result in us losing the VMA_SOFTDIRTY_BIT
flag set on a VMA we just merged with.

There is no need to update the VMA flags at all, so just exit early. This
skips calling khugepaged_enter_vma(), but since the flags didn't change
this is fine.

[ljs@kernel.org: minor edit of commit message, rebased]
Link: https://lore.kernel.org/20261023-fix-vma-atomic-v1-3-8ff4fae1fc85@kernel.org
Fixes: 9a10064f5625 ("mm: add a field to store names for private anonymous memory")
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Jann Horn <jannh@google.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: SJ Park <sj@kernel.org>
Cc: Kees Cook <kees@kernel.org>
Cc: Colin Cross <ccross@google.com>
Cc: <stable@vger.kernel.org>
[ sashal: added a local set_new_anon_name flag by comparing new_flags with vma->vm_flags ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/madvise.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/madvise.c b/mm/madvise.c
index b7f5bbfb5c91d..f3a9c0f3b45a9 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -140,6 +140,7 @@ static int madvise_update_vma(struct vm_area_struct *vma,
 			      struct anon_vma_name *anon_name)
 {
 	struct mm_struct *mm = vma->vm_mm;
+	bool set_new_anon_name = new_flags == vma->vm_flags;
 	int error;
 	pgoff_t pgoff;
 	VMA_ITERATOR(vmi, mm, start);
@@ -175,6 +176,9 @@ static int madvise_update_vma(struct vm_area_struct *vma,
 success:
 	/* vm_flags is protected by the mmap_lock held in write mode. */
 	vma_start_write(vma);
+	if (set_new_anon_name)
+		return replace_anon_vma_name(vma, anon_name);
+
 	vm_flags_reset(vma, new_flags);
 	if (!vma->vm_file || vma_is_anon_shmem(vma)) {
 		error = replace_anon_vma_name(vma, anon_name);
-- 
2.53.0

