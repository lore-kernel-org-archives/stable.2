Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D154B1B53
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443635; cv=none; b=pks8z+zzqHmhuKFv1gm0pW/bqqdyg3vVE3EgGEumxIdOPf3gmDh53OoAemlt5c1w0o71Dw+HFRdBxslM/4nfQAxEJeoUUP6/GTzH79krHv6i1JRGeDTipmuccA6ozsMu6JyUyQuUguo6oAzGqzJtw+a8hkdGf3dtBDcpcXeuBWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443635; c=relaxed/simple;
	bh=qzxyekJdNyOQYdcEsStq/p+hl+OopOL+upiw6yPRV+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sIgpEIXso3jlZyzH7MmYk4B6o9LnY1zQHwG5DEcE7KQ76VYyM+7ukmO1LkNZgkZTWQr5LwxiTZHfGdg0M4Uj+SdUQ78TMXp/Js4rwbfZztWU2J0b7qlWIHCb8u6BPh1h2LcmmmrtThJPgZx8mQX6stwyPaTnU8JKS9B4PdyoEAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSUKEM83; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSUKEM83"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B68E1F00A3E;
	Thu,  3 Sep 2026 13:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788443627;
	bh=Uk0nYgyAOzrLfP+QWaiVXHbXJD3UQau6A89j+atAhes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lSUKEM83gWEWjW1qvQbhKh8YSCAc5tBchd92UT9dCT6faDWAcssBzYwcURXF4Uso3
	 xGCTGRltJeo/gqlIuIKAx2L3Rv52+5CcyKSLWdzkA3otMJLeANk3rrB/tF3fTbz1zK
	 +JTkQCKuQJkgUv3Gy2CzVXr0oxzYgadnuqiKmXwE+ozdn8sJysMPYx2+9cZR18W0CO
	 A+/8fuJyl8GHk8/WPbuHydZv14GXqC/c5ghBhcryV/i4XHpgZJNShSUTHirRbFAoRo
	 Q4aMSEoy4NOhNCPphlIuRzUZR7XZk57mNBNGUyDKtCI5XWap+PtilS9z2MVIbiyVbQ
	 maruwW1ujgHfw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: gao xu <gaoxu2@honor.com>,
	Barry Song <baohua@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] mm: fix possible NULL pointer dereference in __swap_duplicate
Date: Thu,  3 Sep 2026 09:53:43 -0400
Message-ID: <20260903135344.780203-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090322-roaming-sherry-27d1@gregkh>
References: <2026090322-roaming-sherry-27d1@gregkh>
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
 mm/swapfile.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 47ff0dfefb498..ed4423b198a7b 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3665,6 +3665,10 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage, int nr)
 	int err, i;
 
 	si = swp_swap_info(entry);
+	if (WARN_ON_ONCE(!si)) {
+		pr_err("%s%08lx\n", Bad_file, entry.val);
+		return -EINVAL;
+	}
 
 	offset = swp_offset(entry);
 	VM_WARN_ON(nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER);
-- 
2.53.0

