Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794357606;
	b=uvD3LwCsiVBwtz5kZMUjUEiO5a42coWSeE+d0NtY+OBseHs0NdmQM2ZKEhT3YxcAmUiu
	 ikJWwCbK3VDAsnP05WD9tzu7Xwxwd5sdOteATulMaP0DxSifSEyys9MbqWVM7jWqYjVJl
	 98107wnr/VDz354zq+6wyznPhEGqES8dqHvlB03xQBkmFVpeBtS5UgyZAnaCj4KwvgVT2
	 BCCKixZmdCu9dN1gYTdvmwRtFWf0WbZrCgVu92VY4q2GrmxXy0AaU0qv02Ez/dDNMO+Z1
	 wXAmhrA02XjfSwpFoR53dVDkwzWeZosiy7ZrR6QwOXwSseBye62i5lnsRgcbn114hCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794357606;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=jkmSTbGwMIOC0T+8o1yU4rbcfj4SPDTHyaqUcehnT+A=;
	b=YA/j9Wq6/NX4dkZctg493eBDPYKZtqGYN8o+/2q1KF877Hq13Fef/X4btG8jDMC/dZ9X
	 XyDJ9ynNS1Yj1S7hIeDesAFL5d7UO8W/MAvzarkT81NKo/x6ROIdQp40kRt4FHWZUhOvi
	 tuIrT+uRt/EsFRTQ0uMxMEfRXTdcJzGc/4P/Oh9/s6woGxSIoRg/9uBjRNtPl2kgaH71s
	 skr/mOuKJ8k+g7Hsmtlh97ShYZmHxQkjHV1kwK7LYIZmqDsGaq2CZdK39vizpfmXtEHIz
	 EtMEbQxtQJSymrMZpYg9HsSFAfr92exSfQNXIGSZsZvJGvfl1r2qbOhrG4rDe103xuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NGvfxhVJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E085606A327
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 00:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NGvfxhVJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 233041F0093D;
	Wed, 11 Nov 2026 00:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794357606;
	bh=jkmSTbGwMIOC0T+8o1yU4rbcfj4SPDTHyaqUcehnT+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NGvfxhVJOwoYRrSK51KZ2w0h80lOYnEqxjN6CBLvru4r+GsIUrk2LrzpHziiElqR+
	 43FyD9CBAxjR+Q/xTwB8RGzAF5WSQUr6L5cj8GwGd23hYUUf0SW2a3zRFzRi+ZN6oc
	 QVsw9lRrr+6gTH+MnPo7XXtP9r6i3p7vxF8slz5dj+FWfcA08GOxOFAkNe4+IXnD2/
	 K2+W//THgK8N2532X1p9k99GFBtJm/N16pw+4Z6VJ9A3sDiZijvj5OuKrBDWKI2G3d
	 Pwok1GgYFrI0Rhjx2+6t7y81HexnezMlnGWS+tt86moKW7Dbt7PuPWu/i02QjM5hHx
	 FciiU4GCTxLIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nickolai Zeldovich <nickolai@csail.mit.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Pedro Falcato <pfalcato@suse.de>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Jann Horn <jannh@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] mm/mlock: use a long for the page count in mlock_fixup()
Date: Tue, 10 Nov 2026 19:40:03 -0500
Message-ID: <20261111003710.290413-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062840-failed-5.10-3ae91e3079b1@kernel.org>
References: <20261107062840-failed-5.10-3ae91e3079b1@kernel.org>
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

From: Nickolai Zeldovich <nickolai@csail.mit.edu>

[ Upstream commit 3ae91e3079b1504ef162b2884454d5f1421f4eb9 ]

mlock_fixup() adjusts mm->locked_vm, an unsigned long, by the number of
pages whose VM_LOCKED state it changes, but computes that number in an
int:

	int nr_pages;
	...
	nr_pages = (end - start) >> PAGE_SHIFT;
	...
	mm->locked_vm += nr_pages;

When a single VMA range of 2^31 pages (8 TiB with 4 KiB pages) or more
is locked or unlocked, the count is truncated to 32 bits and then
sign-extended, so locked_vm is changed by the wrong amount, while
munmap(), mremap() and the other paths that maintain locked_vm use the
full unsigned long page count.

Such a range is reachable on 64-bit architectures with a 47-bit or
larger user address space (x86_64, arm64 with 48-bit VA, riscv64 Sv48)
by a task with CAP_IPC_LOCK or a raised RLIMIT_MEMLOCK, which do_mlock()
checks against the full untruncated length.  It costs nothing with
MAP_NORESERVE and MLOCK_ONFAULT/MCL_ONFAULT, since then no page is
populated.  On x86_64, after

	p = mmap(NULL, 8UL << 40, PROT_READ | PROT_WRITE,
		 MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE, -1, 0);
	mlock2(p, 8UL << 40, MLOCK_ONFAULT);

VmLck in /proc/self/status reads 18446744065119617024 kB instead of
8589934592 kB; munmap() of the region then subtracts the true size and
leaves VmLck at 18446744056529682432 kB instead of 0.  With 16 TiB,
locked_vm is not changed at all, VmLck stays 0 kB, and after the task
drops CAP_IPC_LOCK or lowers RLIMIT_MEMLOCK, mlock(), mmap(MAP_LOCKED)
and the other mlock_future_ok() and account_locked_vm() users enforce
RLIMIT_MEMLOCK against that count, so they let the task lock memory
beyond its limit (or, in the 8 TiB case, refuse every further lock).
The error persists for the life of the mm; unlocking the range in pieces
skews it further.  The wrong count is per-mm accounting only: it does
not change which pages are locked.

The int has been there since before git history (the variable was named
"pages" until it was renamed in 2.6.28); every other updater of
locked_vm uses an unsigned long or long count.  Make nr_pages a long,
which holds the page count of any user range and its negation, so the
existing sign handling is unchanged.

Found by formal verification of mm/mlock.c against the kernel binary.

Link: https://lore.kernel.org/20261014131358.780240-1-nickolai@csail.mit.edu
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Nickolai Zeldovich <nickolai@csail.mit.edu>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Assisted-by: LLM
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: <stable@vger.kernel.org>
[ sashal: adjusted context to match the existing mlock_fixup() signature and local variable declarations ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mlock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index 884b1216da6a6..91b736be6d95f 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -526,7 +526,7 @@ static int mlock_fixup(struct vm_area_struct *vma, struct vm_area_struct **prev,
 {
 	struct mm_struct *mm = vma->vm_mm;
 	pgoff_t pgoff;
-	int nr_pages;
+	long nr_pages;
 	int ret = 0;
 	int lock = !!(newflags & VM_LOCKED);
 	vm_flags_t old_flags = vma->vm_flags;
-- 
2.53.0

