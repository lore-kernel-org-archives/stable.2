Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794356781;
	b=5EiRLqAOWJFyOoUv3eMArYqpMYkwTiecsfW8r6+8FSpJSbUtSU5vbmqLfpDkLbBlvb19
	 x9O9tENTADXQvak91aqwekcTWO1KKquRrPPSiqvU/vW9090OrYWzWmM2/RGHsgfaCkyPW
	 adyEaEzb3zG9ZyuQWHIMbx5J08KW41pHCv7L96f5OcFg6IhZIEaAcjC1nBtpT6tOK8r0K
	 VVF4nujquUO0hgkCiXZptGprCjjcWsmTdMx9OPCYckbeyffOTShh6Y9T7RWOiRiV26HWf
	 OiSbvfKwT4mY6ncOYy8cT1HUBPpQzz3S1n7Ra2TJpm+SsmKSAG7i1iGzVnQ33usfyqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794356781;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HGFn0F6GdILE3Slr/nibWemgVO408dD6VRP7NqYXC+8=;
	b=nVZOMQ+XmwtiL5wJxa8QmglDsk0YKe/M13UblwqOMwePJiuPn3BPl5Tq8Schu/klCcuE
	 EuCQNB87Nx/msyqx6/CC+UpXG/joqbmOO/ZOyIfwbNKKbnvehXMFfeKNS8xWH0MU2dDo9
	 hkyBDEblIbtcMT88t67AbJCChgqV+DpleI1+7/fr1wKZBGvlPhlNav2G/htB2tokhBNZe
	 HDjU71vpYwczWSMuZUMvcWoXNXfccUa/TH0pJHy2lzOI+8//10n6GoLrAwKnE0hGKUl1v
	 W6RO5NQQgCV3gSQDrxNI0Q0qTzNE49Tqxyt+baFToa2ekMHIGcu3px5L3hLOqSOsStA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WBdsuK93;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F47606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 00:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WBdsuK93
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92371F0089F;
	Wed, 11 Nov 2026 00:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794356780;
	bh=HGFn0F6GdILE3Slr/nibWemgVO408dD6VRP7NqYXC+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WBdsuK93N2XSfJ+YU8S4aV/z6JKiA2gBQrcvV2u8xi/rNElW6PNotc3oyJFtPaW8w
	 LHyOs5tVjyhHn+5FiEYHRQTonCI30SpPNJV739vJ9RhAPEm6ndHDPohi0Ol9ymh9UX
	 5rDKRHXTW4e/eWUENaxzEi4/usVFUeJcEBF3HQfCjbEVs47eqeud6U7n9cycH1awLf
	 K6SJWBLUDZX5Grft3naNGhgSUR/dIHKZ8YcImwzEwb9l4EEy90PuDTzIRveEQMMG24
	 OnEDaMDQVM5m5dJrcDJoReT916sU13PrlRd2A8I1CZ/utBkdu/kM9wZygJ29FznWhC
	 uNxtOeDx5Wfzw==
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
Subject: [PATCH 6.6.y] mm/mlock: use a long for the page count in mlock_fixup()
Date: Tue, 10 Nov 2026 19:26:18 -0500
Message-ID: <20261111002506.262661-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053855-failed-6.6-3ae91e3079b1@kernel.org>
References: <20261107053855-failed-6.6-3ae91e3079b1@kernel.org>
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
[ sashal: Retained the pgoff_t pgoff declaration in mlock_fixup() for the existing VMA merge code. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mlock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index 97bd390c6d251..f03f9f0f1c11d 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -415,7 +415,7 @@ static int mlock_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
 {
 	struct mm_struct *mm = vma->vm_mm;
 	pgoff_t pgoff;
-	int nr_pages;
+	long nr_pages;
 	int ret = 0;
 	vm_flags_t oldflags = vma->vm_flags;
 
-- 
2.53.0

