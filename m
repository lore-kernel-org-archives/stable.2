Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047952;
	b=YQUHco2OXHWHeBe0fd1TgIGjO+PBcRRq0T5snv0WoCXM14bYdc077V3MOMWhcQWWnkbA
	 FxKHskyyjcQLSaTTQHQ7bdAw4H11z+muSgnPpZQ2V7fthOASw1ULacQ006vYf8LOcFNRw
	 SYv81vvFk3xFRu9DAOOlum0kNNGH3br+aE25rYEnmLSGR32SJWRUVNyv2VKhSK3+tGv8Z
	 ll0w7B3JHW+vxdxYFPH+s0Px1Hi6s3GlQFPl4CI3kkFilZ1SDI8Yfli3Krx9vW3xBEliQ
	 VKUl/pjxeSBwek4r9Iu1Ca8ynGtevC7G+wdr4eVXtlKY6OFJZfVTRp1X5Ttforh4ktw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047952;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=hHwkKcE2RMwDSV4Nxx7MoyOLtql6T2QLQV3aezwKm+8=;
	b=uzcLTi7mTmyJA5YwHC/sUAwtm7FJACuZuwEh80kCtNftL5v7rsjwYAwmO2qWzmoG7PTE
	 tLdFiAGj5Pq0ET0WEmspL405EGN7Vki6DJ0HNyNZkstqGcWihYUFjf5qRklDGD9+DWmgN
	 r9zbyhJ7AJladmGQWeZoxSO7TJugf+4+MWjtAEhICjuJykVOvj+/imVMBoba66AJMP5/R
	 sUv+N30hVTIA+3ujNs+vRNgz9oVIpFZo2NpQyiUXgSWI1edcBpoInYaoLVfza8TRKiK0S
	 kszDxZYohiJP2ElNCc0nKvBxry+RETXiHVOXnwTZL/HuCRrA0gEbP9koYfsAWJ6yTZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CzIE7U28;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B4A606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CzIE7U28
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE5D1F0089F;
	Sat,  7 Nov 2026 10:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047951;
	bh=hHwkKcE2RMwDSV4Nxx7MoyOLtql6T2QLQV3aezwKm+8=;
	h=From:To:Cc:Subject:Date;
	b=CzIE7U28C4apYYUZqOifCZOtKNkJ6pNUa1jA68FFj8iN+deofUS0MBflSphRfpEBn
	 fHfU2+W8IrKNFv4hczNrFBnz52Iov2nsLNCI/5OCYI1g7jTTEsgUgFsPbRSThZ6Tbg
	 xN23qLHhPXgADovLZWbqkfnjkCwDOo9bi5eCAN+5+0LON9B4yXc6B4mgwTcVNyYsCP
	 FqxxBGhxJxZ++kdPKXBl4rOcJhSM8nkWi3h5LXOQVGwk1rx0dGEChm6dVCeoTrskZF
	 4u+32nj0NKz9vyKVfpQj0zDJurP9p5lz1g/F7uAeu/2efZepQgz2EscPQT/NrUgnAn
	 /nIxpTQaL+nBA==
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
Subject: FAILED: patch "[PATCH] mm/mremap: correctly uncharge accountable VMAs in error path" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:39:09 -0500
Message-ID: <20261107053909-failed-6.6-65e722a74df9@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 65e722a74df992719676ead85a9e93fb2b5a0983
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053909-failed-6.6-65e722a74df9@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




