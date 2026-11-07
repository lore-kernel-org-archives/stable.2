Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050922;
	b=f0siltjdBHE1hQFTVdt659FPs+EUNdyOjNoRi7YxFmnkol05+o7hsIvGKoVDHUUEQ+51
	 i/1dj8NCQiMprjo5HVXMLcY5XnqEWJL/i1u1DlMU5aZV+OUyZ3dxrjBgvVCrDKUts1PGD
	 DO50BdXMZp63WGTJO+SMZtqPNx3najC0J96x2jZ2gMnTNIGIHkPOND9PnH8nqeFBjUnnc
	 4m7tCf37zao5MDMI7fb5xQ0zmzYaqB7uOAMsUEe0I6nG1Y/FevD9SQ17YufAqUkq8ySKo
	 h4QKi7EQfEI+H2YH5upW5DUGnpXFrhF2V0yFIHT5Ze3SGhQTwQwEdaxT+8oKR3y+xPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050922;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=bthNXh5ZifDOjX8XZRMDwmf4T1beRGKPOzYC7Q2AOe0=;
	b=Ff9Oy6PRheclO/ZXJOdRkslzjQjVAycEnTTSPSO+RL9t5kn5HM3Mt9h7EYzdwIAfjNuB
	 VL3M6z6UZXri1A4QC7aj6uv4DcnKRXf7Vf8jY1lhJQqD5kszbrXJUDBqe96ATPg2YI2rr
	 0BGu9ojb9lWo+O5LIBilps/1dgHQm+W8RQlVtmnSqAoJ7AkXay1KBfUvIZQFqObPobyni
	 BRYpIptijqli6+NfRndrNdiUYfSHx/rNr+DeH0NcbT0SQpTGsMTKk7tJPVxtfBuQOabER
	 aERo830EtZnNyPq3nQPfPKPhrPnF+2qmDqdMFJjJyCv1EFzzccmofLUnJqrabVGceOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f14cbIO3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A754606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f14cbIO3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FED41F0089F;
	Sat,  7 Nov 2026 11:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050922;
	bh=bthNXh5ZifDOjX8XZRMDwmf4T1beRGKPOzYC7Q2AOe0=;
	h=From:To:Cc:Subject:Date;
	b=f14cbIO3Dvm3iPM8KQ/rZjsRX4RmNKTDdb91A9ILBFxKUp6ej9OGcioVW2EWCVC+O
	 5dj3RgUqfyhtMORem3uEWiJBAY5FO+FlnCZcAJ8qneu7KsDr9nGekaQi2zlFHJxuFz
	 LcneC9XVLibG3/FF6hd6B1GexCxgbzv7g/vQxr8FaURuxlZAwcHWcb7WBkTDrGCIPV
	 mChXYic3CBMlGwL6K7EMLWou3AzY6svYfm1tQQsSySLCPd3qhAwSRHZ9rK3ZVMTgCd
	 CsDxf6DefPYzuMtnPvKb/A+bcd+xbtbcqNTCrNRQH02hvyjLV79TEf3fbGJU0jrsq8
	 OyzIhO3gGS38Q==
From: Sasha Levin <sashal@kernel.org>
To: nickolai@csail.mit.edu,
	akpm@linux-foundation.org,
	pfalcato@suse.de,
	liam@infradead.org,
	ljs@kernel.org,
	vbabka@kernel.org,
	jannh@google.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/mlock: use a long for the page count in mlock_fixup()" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:28:40 -0500
Message-ID: <20261107062840-failed-5.10-3ae91e3079b1@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 3ae91e3079b1504ef162b2884454d5f1421f4eb9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062840-failed-5.10-3ae91e3079b1@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




