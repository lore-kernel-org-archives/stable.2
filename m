Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047181;
	b=MvMxqar8hWu533dkX/pKFwAJnIAGvOhOKuNgIZ7hcnDQrnKVB2U+U1PrW44ZnkIlZR8A
	 MjOyZzExY7vhCYZzWSZUdoUO8rvLe8aLOT4qjIycqIHhnbw5p7eLupubE+1X+K+mUYv8m
	 oaxdDJ1/id1edigzGRoSIamiOfDLpiBkv/SDgdJbGRtN3Duld6ctkcAEQWqtFmiiOmaG9
	 fq05VBGUkTDph5sryhfIS8KD5GS6UTEUOnYH6pqeUD2Zk5rzxiAjzI2ZzlyqE5hfzze11
	 ckvmTkrxB70zhM+mpnGggaE5ZDEVQycPGa8upo831CogisiRacw6VMrBpUyjCJ8JKNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047181;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=/aYFZH3z7OD62kycpTo45pEQJX9cQaxjxUc7aUGDA+k=;
	b=gH3pztK2lF8u6/zIiaqD9uiLFFGEi1+byNJLXgMEXSUtIivFJdJ5ni9s38Z0vz2LZ+Bh
	 A8NeAMH/0rkqHkHsEh0CtKFGNaE0mZobIFhftADItvgHEevAyDaxMfCCO36xXQCPzSDKI
	 76qhrn/DLWVpmm1QP6wIwrEjiS27YODWlEPDfv69S67WhXb1a3u21RCCWHwiy3EDDgW8Q
	 efnSoNXlkztta5P5GkfR4nrtEmbPlV64iLLkqbxyhZJIoVaiazoiH4OtG1WCBGjKqD8C+
	 vxyIkJFEZ2MAWzabLv1MT7hb1Fwy8h0iP5cE8BJ+wNtAFP2hIZwh162dzdeqm9D/fCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TQ0BDw0j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC23606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TQ0BDw0j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434241F0089F;
	Sat,  7 Nov 2026 10:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047181;
	bh=/aYFZH3z7OD62kycpTo45pEQJX9cQaxjxUc7aUGDA+k=;
	h=From:To:Cc:Subject:Date;
	b=TQ0BDw0jiXiDpM9K4rFCMA6oRVk1FsX2VKWJW3bvk5KEU3CDRoBlm0DnZYNNG6Sxr
	 Kd+TEDlSsiFINpeIEXcrfEI7QzthJ6QokUL3Kvx2lzmb2vFNvZal/FGNSqrDC5NU51
	 h0bXLWbUVsQvvzRN9A9+7XZo5vKnjQDvAMNrz16U2dLZcr4Nia5u2D0c3clnM7U3LR
	 rQlNB9zYAJL4QqrnjLz+V7OxK/AyfBqvL8pL0s3lrYdOjQYoeSfUdlNkPvLW+l0z6S
	 xuNeqTtUOPfLwNaHQnEnX9Ooj154xGayQt/+BRT0/IRF9UoxKvoPTidgxBwlh1oJ14
	 jD8rgRzVdiiAA==
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
Subject: FAILED: patch "[PATCH] mm/mremap: correctly uncharge accountable VMAs in error path" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:26:19 -0500
Message-ID: <20261107052619-failed-6.12-65e722a74df9@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 65e722a74df992719676ead85a9e93fb2b5a0983
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052619-failed-6.12-65e722a74df9@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




