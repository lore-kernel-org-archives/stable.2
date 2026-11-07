Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048886;
	b=Yxo1VA9fe2eoHRrZMVU0ynLT2YKO4OGf2aqe+JcF2/ANJPxSQ+GSlPf8u3xKFpUmacDj
	 0iCYfw/oNPMeG4A+Sk7nMVn3mvpPAT047W9CswgxmYysMDTwaWqxexEmPAACofKtXQDjV
	 Twhy+Etqheh7ArRwITBIPcIX/ilCyFHFMTh8u7eS7ao8WMykNAXxKuD1rfA2d0ZISTN/P
	 wVRj0achNOkZ6oMtpycLmpDKageqfhSJN77Nunrzx9czm/fg2YfiIOaNPITX4y256NigB
	 hhkZLEFEYSvCxZmizVINNuylwxbMjjcNE+tgQPKmZ4AoRZHCB1U3ONY4N6hv96gzPKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048886;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=cO2kXXbsM+AxoL1zIpUT3sbSD4m1Kbmh+8m4KU9bHmg=;
	b=m5o/fCbHvvr/yxZXHwV+4TAV9T3aNWvh2OW32bgLr+d7jYTnI9NdaM9EQbEPxZvsASe2
	 P16J86x316rcvyIdlBuUIGwq4uAB8cZuFSiIyD1tZG0xwaXPvIyy8h743eqp1YNuXkd84
	 SSEtmeqkqWgb3u1z9OSV+CsCv190NwTdsl7VQ41Z89OTq/fr1t3TMG2xqDdHrr+BnZsHm
	 8jFaIBZZaACWuA8EpgLUe+UAauWCeDgtTHT1xMQULCBucin1Ll0YYJKs/4ZVsw3jfBP0V
	 VwJy3f7RJz70gNzi6h6OwQw/STF6HCHaYRmAWxb95MV3qwT7yVXTr+9t83ttnSg3uCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n4PvYkew;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25026606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n4PvYkew
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A4B1F0089F;
	Sat,  7 Nov 2026 10:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048886;
	bh=cO2kXXbsM+AxoL1zIpUT3sbSD4m1Kbmh+8m4KU9bHmg=;
	h=From:To:Cc:Subject:Date;
	b=n4PvYkew8DAPHAlMmX9qOWwNXtnJ38QWvZXKK+Yv4SBOEpWJLDoefkuvqdS1T9iwD
	 aacPA5qFY/6I28uCGfRxmZtuxopX20o9t1S5mclFWSojDd41cgaoG4rVNscP4rFRMb
	 tGUbaPRsEt4vS2arIEjlUCZxxWYOhmFnfawTGWxeCIfBTi3tn9VgAiAp9wXDFU2+Np
	 o52MYqeeIJMORl/H3ma8pIf0gCEmGHM0j8WUTaHR1kgU1cjKh8xBWFXkKAnMok3Af6
	 X/dz6bbfgt29HTNyNgNLdp5CILnOv5LjIqilEJK8ivvp7lkND7RKw8+yS7eLrrmZee
	 0p7R3LnCORF3Q==
From: Sasha Levin <sashal@kernel.org>
To: ljs@kernel.org,
	akpm@linux-foundation.org,
	liam@infradead.org,
	vbabka@kernel.org,
	jannh@google.com,
	pfalcato@suse.de,
	bgeffon@google.com,
	0x7f454c46@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/mremap: correctly uncharge accountable VMAs in error path" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:54:43 -0500
Message-ID: <20261107055443-failed-6.1-65e722a74df9@kernel.org>
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
git cherry-pick -x 65e722a74df992719676ead85a9e93fb2b5a0983
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055443-failed-6.1-65e722a74df9@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 65e722a74df992719676ead85a9e93fb2b5a0983 Mon Sep 17 00:00:00 2001
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Mon, 19 Oct 2026 16:57:48 +0100
Subject: [PATCH] mm/mremap: correctly uncharge accountable VMAs in error path

The mremap error path is a fragile and unwieldy beast - it reverses the
page table move then updates vma_remap_struct state to swap VMA, length and
address between old and new VMAs in copy_vma_and_data().

If the mremap() operation didn't specify MREMAP_DONTUNMAP then its caller,
move_vma(), invokes unmap_source_vma(), which unmaps the new VMA rather
than the old one.

For accountable VMAs when MREMAP_DONTUNMAP is not specified,
unmap_source_vma() unsets VMA_ACCOUNT_BIT during this unmap in order that
only the delta of a VMA expansion is charged (performed by
vrm_calc_charge() earlier).

Therefore nothing uncharges the expanded VMA size, and there is a permanent
leak in global Committed_AS.

Resolve the issue by uncharging when MREMAP_DONTUNMAP is not specified.

Link: https://lore.kernel.org/20261019-other-mremap-charge-leak-v1-1-d94477fe6545@kernel.org
Fixes: fdbef6149135 ("mm/mremap: don't account pages in vma_to_resize()")
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Brian Geffon <bgeffon@google.com>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: <stable@vger.kernel.org>
---
 mm/mremap.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/mm/mremap.c b/mm/mremap.c
index 24827e13e617f..0d06d7f37f19a 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1339,6 +1339,20 @@ static int copy_vma_and_data(struct vma_remap_struct *vrm,
 		pmc_revert.need_rmap_locks = true;
 		move_page_tables(&pmc_revert);
 
+		/*
+		 * When copy_vma_and_data() returns, the new VMA will be
+		 * unmapped rather than the old one.
+		 *
+		 * When an accountable move is being performed, this unmapping
+		 * will not uncharge any expansion, so do that now.
+		 *
+		 * A move is accountable if the VMA is accountable and
+		 * MREMAP_DONTUNMAP is not specified, so only do so if the
+		 * latter is true.
+		 */
+		if (!(vrm->flags & MREMAP_DONTUNMAP))
+			vrm_uncharge(vrm);
+
 		vrm->vma = new_vma;
 		vrm->old_len = vrm->new_len;
 		vrm->addr = vrm->new_addr;
-- 
2.53.0




