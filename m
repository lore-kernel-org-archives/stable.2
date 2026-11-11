Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794357087;
	b=KCb7uWrijcup6wXNvifTAuSLir/el7x41MhcMwiQTt712lqSOTlyjtejaoX+AtaNtDwH
	 qY7h2jf8Wv4WLV2Cysch8LS5wpUjEbi3I/EB04iQuzAtooDxYUAUrkIv+SAebLzdnYiji
	 3b0ng0gkizM2VY8OYRLyGJMELaupEfTuctLT/96fwdLJtqjuhao/Jvjg/TGnfqR1yzoBW
	 RJK7TXn7eWASKp4zcxTcnnC4CrZlLD4j1ckvJr4jDDFXCIej+vG60OKwIDWWvD2Fxrag8
	 HvoTJhsoffGOs6eQhYjQW8tZpVmhd20aaH3Q36NpejvDJYB9yb/57HsCkBAL3OJSbYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794357087;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=nf61AgeiZ9uQs+avweUGQlMreDitu+Taj2elZ0BoZZU=;
	b=C7C16sgvLkMNjDTfSuehN+4GZt/LL0sLlvJPaYHa+iDGpPw+tTQbF8/EuJtcQv15ASJV
	 DsKAP3f9NU22XaAmMr2HxY2RwNT65ssXCugD7+prNfoofe8df8H3nrqgKQnBvkPqbZ6vd
	 d9waN+vGsjvlknQ0kaHWiYLYbyQ8WhdMkwzkQ4//sFPW1fN2Lb3Ra3gNuIJfYU1fdpdLq
	 GImVvrlm+3Ioy9xONvqjlsMjbnwDzpXWl4kKe2zvfknI57S5J0CZcxlvO4x29aeQ4t136
	 hRp2x18O6Itf50B3x3SAFsKIc45zBOh07fZtYQkyYAh9AU+FqLdmDpDrBxUqhibKmPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XRd5fazI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C156606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 00:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XRd5fazI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F118A1F0089F;
	Wed, 11 Nov 2026 00:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794357086;
	bh=nf61AgeiZ9uQs+avweUGQlMreDitu+Taj2elZ0BoZZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XRd5fazIHDtvphtxBx0qydcXSveasWe5wX1AVXfd22a6DBD9X80Q32E/iwmSynQ81
	 Pl0f63u2G/MpjEHFiph2PJHzinc5Lt+IIqR0KJroX2qlqmDPapHPsO1bRKCjEcb7Vi
	 Alw/IjxOFtNjkdILuXhkDLqccZuBRxG15t86B2xcTsfjQyIMENsqp36lp3x4iMJZ3S
	 qm/YNVLI1BHm0vCT1iCt+DaKvuysCixuzef5wzhQieDMCldEMPPlRIEMxaw60Z32JV
	 RwEmBT/eIh9P2xE3wKGt2GOGnw71AlQBL3uG9dEqbbtF+tGnQvmn2APF3qGF5SjbBo
	 sgdSbRVbH6cXw==
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
Subject: [PATCH 6.1.y] mm/mlock: use a long for the page count in mlock_fixup()
Date: Tue, 10 Nov 2026 19:31:24 -0500
Message-ID: <20261111003109.274925-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055436-failed-6.1-3ae91e3079b1@kernel.org>
References: <20261107055436-failed-6.1-3ae91e3079b1@kernel.org>
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
[ sashal: adjusted context for the older mlock_fixup() signature and local variable declarations ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mlock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index 0124022f0f379..8fa8e871ccbf8 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -406,7 +406,7 @@ static int mlock_fixup(struct vm_area_struct *vma, struct vm_area_struct **prev,
 {
 	struct mm_struct *mm = vma->vm_mm;
 	pgoff_t pgoff;
-	int nr_pages;
+	long nr_pages;
 	int ret = 0;
 	vm_flags_t oldflags = vma->vm_flags;
 
-- 
2.53.0

