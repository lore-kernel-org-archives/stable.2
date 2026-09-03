Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1504E237C
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788448992; cv=none; b=VHlNKYJUyKI3cwjNe2g63Ga3OPMLEBOJz9HE8+Z8INE8rxMDKkLDYcogFzXOWVEYYQFGGC/9LnetL886vHRl7AQjbmosV36eI9JdMZS7FaCywRi21wlGkXnRXfzgm2h1FGqxEwGAbn0aF5CVdu0HGR2U9vFuBzjH3uHk+YZUgDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788448992; c=relaxed/simple;
	bh=YX1rtqjFYKhLMgJTdjOGsa4NT0pwXTLp0X9wM0clPd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R49SZTqhIo5jeR960PYyOoD7ZBJhXV9I+W+b8PlbUX4Kdk2NtnAP5RurJb58PCj8lKICaBngw8qIAuFram9oKzCOpmg5XvFNnAfBdU3kazSVnb+8KIDm4jL21MbZsN/U2MZqq469HgtHsOnhfMHe/iaJDUMgx5a/f0AILn8TTjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=joZrpxCw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="joZrpxCw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD681F00A3A;
	Thu,  3 Sep 2026 15:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788448990;
	bh=VEMk5loJgbREOn7Np4I/rD9w1Tyd8klvAhoKci++bwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=joZrpxCw7xDGPbHVmLIbFzmlSLHFWbfE9YNgtt0lGvKmA8W7RnIc6QQFWwd5BJYii
	 7tb8hyOF9qxNVT6Hna35AI5rWAaeVy/JvBrDDRO3zeNbPKfxpOO/wOoPqh07SYRpJu
	 /mvtB9T2Lshpc/S/DOloVhK053sTCyp3KGlCbZkZE2xO5GrDlXjODXEP2jirM4IOSK
	 4/84Z5jeq7AlC7uSp6VKj916UbQ6TcS9+gjkhGyOOyWrIEam2Xo63bTXdXPiNdK7sV
	 FEeAvOwficMaGeHdTSWTOQlt/P6TC8a7qNo6kdyoour9sM2TmkcXhz1TKaht9D6AO+
	 vi8NA1NWiYe7g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: gao xu <gaoxu2@honor.com>,
	Barry Song <baohua@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] mm: fix possible NULL pointer dereference in __swap_duplicate
Date: Thu,  3 Sep 2026 11:23:06 -0400
Message-ID: <20260903152307.887829-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090322-mating-twice-bdd0@gregkh>
References: <2026090322-mating-twice-bdd0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: gao xu <gaoxu2@honor.com>

[ Upstream commit c3e998398de48a7528842f05858a3a6bb21002e6 ]

Add a NULL check on the return value of swp_swap_info in __swap_duplicate
to prevent crashes caused by NULL pointer dereference.

The reason why swp_swap_info() returns NULL is unclear; it may be due
to CPU cache issues or DDR bit flips.  The probability of this issue is
very small - it has been observed to occur approximately 1 in 500,000
times per week.  The stack info we encountered is as follows:

Unable to handle kernel NULL pointer dereference at virtual address
0000000000000058
[RB/E]rb_sreason_str_set: sreason_str set null_pointer
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
user pgtable: 4k pages, 39-bit VAs, pgdp=00000008a80e5000
[0000000000000058] pgd=0000000000000000, p4d=0000000000000000,
pud=0000000000000000
Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
Skip md ftrace buffer dump for: 0x1609e0
...
pc : swap_duplicate+0x44/0x164
lr : copy_page_range+0x508/0x1e78
sp : ffffffc0f2a699e0
x29: ffffffc0f2a699e0 x28: ffffff8a5b28d388 x27: ffffff8b06603388
x26: ffffffdf7291fe70 x25: 0000000000000006 x24: 0000000000100073
x23: 00000000002d2d2f x22: 0000000000000008 x21: 0000000000000000
x20: 00000000002d2d2f x19: 18000000002d2d2f x18: ffffffdf726faec0
x17: 0000000000000000 x16: 0010000000000001 x15: 0040000000000001
x14: 0400000000000001 x13: ff7ffffffffffb7f x12: ffeffffffffffbff
x11: ffffff8a5c7e1898 x10: 0000000000000018 x9 : 0000000000000006
x8 : 1800000000000000 x7 : 0000000000000000 x6 : ffffff8057c01f10
x5 : 000000000000a318 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000006daf200000 x1 : 0000000000000001 x0 : 18000000002d2d2f
Call trace:
 swap_duplicate+0x44/0x164
 copy_page_range+0x508/0x1e78
 copy_process+0x1278/0x21cc
 kernel_clone+0x90/0x438
 __arm64_sys_clone+0x5c/0x8c
 invoke_syscall+0x58/0x110
 do_el0_svc+0x8c/0xe0
 el0_svc+0x38/0x9c
 el0t_64_sync_handler+0x44/0xec
 el0t_64_sync+0x1a8/0x1ac
Code: 9139c35a 71006f3f 54000568 f8797b55 (f9402ea8)
---[ end trace 0000000000000000 ]---
Kernel panic - not syncing: Oops: Fatal exception
SMP: stopping secondary CPUs

The patch seems to only provide a workaround, but there are no more
effective software solutions to handle the bit flips problem.  This path
will change the issue from a system crash to a process exception, thereby
reducing the impact on the entire machine.

akpm: this is probably a kernel bug, but this patch keeps the system
running and doesn't reduce that bug's debuggability.

Link: https://lkml.kernel.org/r/e223b0e6ba2f4924984b1917cc717bd5@honor.com
Signed-off-by: gao xu <gaoxu2@honor.com>
Reviewed-by: Barry Song <baohua@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: f9dc428249ed ("mm, swap: ratelimit bad swap entry reports")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/swapfile.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 53637144c18e5..49ad86d543f92 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3283,21 +3283,26 @@ void si_swapinfo(struct sysinfo *val)
  * - swap-cache reference is requested but the entry is not used. -> ENOENT
  * - swap-mapped reference requested but needs continued swap count. -> ENOMEM
  */
+#define swap_entry_to_info swp_swap_info
 static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
 {
-	struct swap_info_struct *p;
+	struct swap_info_struct *si;
 	struct swap_cluster_info *ci;
 	unsigned long offset;
 	unsigned char count;
 	unsigned char has_cache;
 	int err;
 
-	p = swp_swap_info(entry);
+	si = swap_entry_to_info(entry);
+	if (WARN_ON_ONCE(!si)) {
+		pr_err_ratelimited("%s%08lx\n", Bad_file, entry.val);
+		return -EINVAL;
+	}
 
 	offset = swp_offset(entry);
-	ci = lock_cluster_or_swap_info(p, offset);
+	ci = lock_cluster_or_swap_info(si, offset);
 
-	count = p->swap_map[offset];
+	count = si->swap_map[offset];
 
 	/*
 	 * swapin_readahead() doesn't check if a swap entry is valid, so the
@@ -3328,19 +3333,20 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
 			count += usage;
 		else if ((count & ~COUNT_CONTINUED) > SWAP_MAP_MAX)
 			err = -EINVAL;
-		else if (swap_count_continued(p, offset, count))
+		else if (swap_count_continued(si, offset, count))
 			count = COUNT_CONTINUED;
 		else
 			err = -ENOMEM;
 	} else
 		err = -ENOENT;			/* unused swap entry */
 
-	WRITE_ONCE(p->swap_map[offset], count | has_cache);
+	WRITE_ONCE(si->swap_map[offset], count | has_cache);
 
 unlock_out:
-	unlock_cluster_or_swap_info(p, ci);
+	unlock_cluster_or_swap_info(si, ci);
 	return err;
 }
+#undef swap_entry_to_info
 
 /*
  * Help swapoff by noting that swap entry belongs to shmem/tmpfs
-- 
2.53.0

