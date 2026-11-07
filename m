Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048879;
	b=j6FI7MrM2UAbbQnY+7CtcN0tkr1mFtI7UbLwNmey6ffR2SjXOA1XYKyUpaBuAy4T4Url
	 oDQatm6PHzTL0l66RUp1kQ8A15GPr6KcZbDn6nm34Q5ClohvoQYvsSPTMML8Aw+btCbXz
	 zLv6samgbLLLCpYw9BlTSEcG5+szGUUFCdQM3GIFKA2ZO5PnjNMjYHmEEFVoL6OYM+2MT
	 cobaKFYS4mX4QWOSEkX0WswRfKnCE4iHnPFYmBVHHPSUxwKgQl0AKKIAD1h1q0lIs1hKZ
	 trN+2VcXT4aTfuydE1V07p/9qDq9+C63LhkWvCfOXBypMhoGWWN5Obr3SmXIOdBBguw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048879;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=JNRlRgcDMisJ+rvIeEt8VFs0t0HbphcUiC2vKlL2c0s=;
	b=ESAfbvoxL+cln3B9vAi8lErtxreZYzsV1+HdGHrOpN5yNjvI6mVWwoyGTJYsM7S969xL
	 mUx4G2a3U8b+Z21lI++4r1ogIketRQuF9An+pI00Z47GV+r6o699a2Z/CWdWETH50YhZ6
	 6+yROiZnQfKmpjq140/uMYvaRpg6jnUgnBHoIoyqP2U0+QDi5FEZ7JEDfjIM1+UTvF4b2
	 45dqpaSf6Ys6gUGWbJ4ruh9wZv7ejW/dQyPLAhRIsnbzPCMGIrlHMSjB5pj7FLXd7Afb7
	 q/8NvTxt9cOxOClHiSh1v7sK/aRDwYEtCAJogno8R3hSHba+vwBSoJ0GjHvU973yEPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iOR3UR5S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92E4606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iOR3UR5S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3481F008A1;
	Sat,  7 Nov 2026 10:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048878;
	bh=JNRlRgcDMisJ+rvIeEt8VFs0t0HbphcUiC2vKlL2c0s=;
	h=From:To:Cc:Subject:Date;
	b=iOR3UR5SDezjbyeClco5eQK8R3KdE6Rm2yINYBIqIfXz+cwa6oZjNARwSzPuCoVqQ
	 kmhe0jHGiX4gZlEnodxsG6HxoNXThTIiFbnJ7E3DIiOJR5JtUyL7YuIMDTPeey2UEv
	 gpmf0mUpzhIgODyYzT1csliJPElhUD++JAjvkCeiTttNS5jkRGcuxQE8Kb6DXr6FXp
	 wzNWahOvzGnmmITzZO6j+IJoXMyP4I0Kwj5D0jSj/dqGauGGih+LXzTDqgcicn6fTS
	 H5G1KvMEVVJXHGnVc3JP8/UHosTUhlAA0cRTZNoQ5ZoncyS5/Yto+rfonyFBWjcLuD
	 3pQ0FR3ru2rkA==
From: Sasha Levin <sashal@kernel.org>
To: nickolai@csail.mit.edu,
	akpm@linux-foundation.org,
	pfalcato@suse.de,
	liam@infradead.org,
	ljs@kernel.org,
	vbabka@kernel.org,
	jannh@google.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/mlock: use a long for the page count in mlock_fixup()" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:54:36 -0500
Message-ID: <20261107055436-failed-6.1-3ae91e3079b1@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 3ae91e3079b1504ef162b2884454d5f1421f4eb9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055436-failed-6.1-3ae91e3079b1@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 3ae91e3079b1504ef162b2884454d5f1421f4eb9 Mon Sep 17 00:00:00 2001
From: Nickolai Zeldovich <nickolai@csail.mit.edu>
Date: Wed, 14 Oct 2026 09:13:58 -0400
Subject: [PATCH] mm/mlock: use a long for the page count in mlock_fixup()

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
---
 mm/mlock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index 4235a1518fc9e..67ae9b18b9235 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -457,7 +457,7 @@ static int mlock_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
 {
 	const vma_flags_t old_vma_flags = vma->flags;
 	struct mm_struct *mm = vma->vm_mm;
-	int nr_pages;
+	long nr_pages;
 	int ret = 0;
 
 	if (vma_flags_same_pair(&old_vma_flags, new_vma_flags) ||
-- 
2.53.0




