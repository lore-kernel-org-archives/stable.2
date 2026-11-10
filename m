Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273518;
	b=MaoV2tbhEsbLj8jTquKen7pEgIjNFPVcYgAMqepd/+jn7gbY1ipMQFuEm9pmO5UungUY
	 3dIt7esTkRyoxSe6nh/HrLloo8eJ5dLXMs6yL4sVd0dldEb3JsN3OxID2Izg5oBoARJWd
	 wf2ifm2izglIAlPnKV9Bzt2+oR4JgFXtgH9Anpu6AOa5Rd70js6+BgsLhu7hc0m5ZXenC
	 LiEgn6S12vtoVjF7Nzgejsi3flSStgG6vcgfTrok5FPP71aAP0/NEbCg0xAQugTWoia7a
	 TZDQXh7vUk+KOoQ4SLigbbD0WuLxW1r2sn+1aG8oC0Ei1nhjwrUJ4QVcn3R9kKxZPpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273518;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=1O2lu8oLt733SX7ctPZ/tDyt5Ac6swuvXdFvuMPpN3I=;
	b=fSmdoggGRimlIJpYFnkOQrPSqTlkz21nyGOtZ4zfSXLTPn/C4krD4pq+na/3NQedPG2P
	 ifcspWkkLnUN/ZsOoyWDlbDIOcxmB7i70UjDyuDVY840avBk7nJ6Zc6AUIvpmY7jecRiq
	 BeBRD+K+CFl5Xw9Crxh06odPl3qGotbCrpmK1msAQpON+NcOg3oCvRoaTGk9H7unOp1gG
	 37338BOjHoNQ3pTIzDOMTwtom3GWMn+C/qBUR5MWCegc7VzRUzIs8gRqGL2QmM/QaYw86
	 /kVr4jzYdEdMKVxohJpcW5masQCnmtIrksPiS1n1zsyWXGMMHYROG1Z5C90Ozor1LRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hWXk9uVS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42614606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hWXk9uVS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DEF21F0089F;
	Tue, 10 Nov 2026 01:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273518;
	bh=1O2lu8oLt733SX7ctPZ/tDyt5Ac6swuvXdFvuMPpN3I=;
	h=From:To:Cc:Subject:Date;
	b=hWXk9uVSN9GOpTlutecbFb/AynefmLqtV1/66hUrO183EKAubXW3/QGAVzXhscwzF
	 uidSDyYO1svOQ1r6jg75CaULU5s0LDsKV4YvbNAZaDIrk7r8XFjQ8oLsiMhO4ZBn2u
	 SHky6L4pkimSg8d2Uz4D/Ar9wzO9K/nXFsT/yXnxZB+UOSBrU7Bx83IaG0X5sd9bwM
	 akeJnptvS0IDVvsXKPXyiwnc51byX//HyQclJaZ3t6sMAI/YrXvc9YADrCZTOotuu2
	 3D/2vbEmKWTqY/XNy0ex3vYXSBdzsq7WfP+Hu29by2nRKmLYl/zIi1TiwpuDB8ykaM
	 oZPmeUhAd5G+g==
From: Sasha Levin <sashal@kernel.org>
To: david@kernel.org,
	ljs@kernel.org,
	pfalcato@suse.de,
	dev.jain@arm.com,
	usama.anjum@arm.com,
	lance.yang@linux.dev
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/mremap: use pudp_huge_get_and_clear() when moving huge PUDs" failed to apply to 6.1-stable tree
Date: Mon,  9 Nov 2026 20:18:36 -0500
Message-ID: <20261109201836-failed-6.1-b4417d08034a@kernel.org>
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
git cherry-pick -x b4417d08034a7b4a3083e0e2d95429d4542524f2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201836-failed-6.1-b4417d08034a@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From b4417d08034a7b4a3083e0e2d95429d4542524f2 Mon Sep 17 00:00:00 2001
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sat, 31 Oct 2026 10:39:59 +0100
Subject: [PATCH] mm/mremap: use pudp_huge_get_and_clear() when moving huge
 PUDs

move_huge_pud() reads the old PUD and clears it in separate operations.
Hardware accessed or dirty updates between those operations can be lost
when the saved entry is installed at the new address.

The raw pud_clear() also bypasses page_table_check_pud_clear(), while
set_pud_at() accounts for the destination mapping. This leaves the
checker counts unbalanced for mappings tracked by page table checking.

To fix it, simply use pudp_huge_get_and_clear().

Fixes: 7d846db7d0e2 ("mm/mremap: convert huge PUD move to separate helper")
Cc: stable@vger.kernel.org
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Reviewed-by: Dev Jain <dev.jain@arm.com>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Link: https://patch.msgid.link/20261031-fixes_core-v3-30-d6437171ecc3@kernel.org
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/mremap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 0d06d7f37f19a..16e736c72d9cb 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -509,8 +509,7 @@ static bool move_huge_pud(struct pagetable_move_control *pmc,
 		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
 
 	/* Clear the pud */
-	pud = *old_pud;
-	pud_clear(old_pud);
+	pud = pudp_huge_get_and_clear(mm, pmc->old_addr, old_pud);
 
 	VM_BUG_ON(!pud_none(*new_pud));
 
-- 
2.53.0




