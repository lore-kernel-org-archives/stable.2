Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6A03B19AB
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 10:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784890155; cv=none; b=UWn6oTjMGZduGUW1KeUzJ+0gyA8nrodBSb0Th/N5qh2Zb8OYEAB4WDqF6WBggfOpfIP/pbb0UfXUFaRPCv6ZTmPNS5it8DWlfrkPM4tsUeoYfZLEC/fec7Nskt7UWta9oF9YN3xF/pjE3SOS16w155HuQb4MBtwpibFH1ko/V9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784890155; c=relaxed/simple;
	bh=ZizFG+0xmvAb9PF34+RPA75QGYM/cgjVOnh/Ffs9PZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mrFkf+IoQFHofmgRQt+v+IXFlf82i+bZ/1pO6YkNC72bbwPxZ3piNgKtbTe40MpCT/+LNUMlruTnYU9YCqIJ7I+SNxXFs0jds9PrTAtanxZ6XY+JQCuCF4A5cHqakkjDp9FjHP433h3BDlqYjvmmGKdx3gVMDE8GEETv/tuzXck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRVZYtx1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRVZYtx1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C601A1F00AC4;
	Fri, 24 Jul 2026 10:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784890154;
	bh=I/qJkp6Hd6ntfVZvqWjbuK579diEXGTC9a3LcGMp8cM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CRVZYtx1t4hy6SvZNS1JpiVfbao1mr4Q9LqERXCCGVfdzZphxjjFbcmrnnxqOZtqD
	 je0ox70jlHso3TULcxxdWHFpW4TwwVFzJGok4ndTf7wotod+ys9d0UmDh4j3clAxJt
	 OzAkHNSQzFmnPeLJeT1y8jHVHlx4joV5fI91VE3tearkRC7WQdMfnfELNIvqIzYHV3
	 NfLZq6F9ycEB3I/ggm3xCNOFqgqq9q8gpO8reuWOLJuCDsmM6YQjVmFkBYj5F6/2s4
	 2wgmZpAIm7AP415cyPXtRWDhJ+yM6NLylplnxzdPf26O4T9pz5tyAl1MgBUjoOJpvE
	 OaGmyuZtIjHgQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] ntfs3: validate split-point offset in indx_insert_into_buffer
Date: Fri, 24 Jul 2026 06:49:11 -0400
Message-ID: <20260724104911.3974416-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724104911.3974416-1-sashal@kernel.org>
References: <2026072048-smudge-reselect-d44b@gregkh>
 <20260724104911.3974416-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Bommarito <michael.bommarito@gmail.com>

[ Upstream commit f1df9d771df47aa40de6d70949c28720ae1e430d ]

indx_insert_into_buffer() computes

    used = used1 - to_copy - sp_size;
    memmove(de_t, Add2Ptr(sp, sp_size), used - le32_to_cpu(hdr1->de_off));

where sp and sp_size come from hdr_find_split().  hdr_find_split()
walks entries by le16_to_cpu(e->size) without validating that each
step stays within hdr->used or that the size field is at least
sizeof(struct NTFS_DE).  index_hdr_check(), the on-load gatekeeper,
only validates header-level fields (used, total, de_off) and does
not walk per-entry sizes.

A crafted NTFS image whose leaf INDEX_HDR reports used == total but
contains one interior NTFS_DE with size = 0xFFF0 therefore passes
validation, descends to indx_insert_into_buffer() through the
ntfs_create() -> indx_insert_entry() path, and makes hdr_find_split()
return an sp whose sp_size (0xFFF0) greatly exceeds the remaining
bytes in the buffer.  The u32 subtraction underflows and the memmove
count becomes a near-4-GiB value, producing an out-of-bounds kernel
write that corrupts adjacent allocations and panics the kernel.

Reproduced on 7.0.0-rc7 with UML + KASAN via a crafted image and a
single 'touch' inside the mounted directory; crash site resolves to
fs/ntfs3/index.c at the memmove.  Trigger requires only local mount
of an attacker-supplied filesystem image (USB, loopback, or removable
media auto-mount).

Reject the split whenever the chosen sp plus its declared size
already extends past hdr1->used.  This is the minimal fix; it
preserves the existing hdr_find_split() contract and relies on the
same out: cleanup path as the pre-existing error returns.

A prior OOB read in the very same indx_insert_into_buffer() memmove
was fixed in commit b8c44949044e ("fs/ntfs3: Fix OOB read in
indx_insert_into_buffer") by tightening hdr_find_e(), but that fix
does not cover the split-point size field path addressed here: sp is
returned by hdr_find_split(), not hdr_find_e(), and the underflow is
driven by sp->size rather than hdr->used exceeding hdr->total.

Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
Cc: stable@vger.kernel.org
Reported-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/index.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index e801bf16854de9..78de866b5ddce2 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1834,6 +1834,20 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
 	memcpy(up_e, sp, sp_size);
 
 	used1 = le32_to_cpu(hdr1->used);
+
+	/*
+	 * hdr_find_split does not validate per-entry sizes, so a crafted
+	 * NTFS_DE whose le16 size field is out of range can place sp such
+	 * that (PtrOffset(hdr1, sp) + sp_size) exceeds used1. Without this
+	 * guard the u32 'used = used1 - to_copy - sp_size' underflows and
+	 * the subsequent memmove count becomes a near-4-GiB value,
+	 * triggering an out-of-bounds kernel write.
+	 */
+	if (PtrOffset(hdr1, sp) + sp_size > used1) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	hdr1_saved = kmemdup(hdr1, used1, GFP_NOFS);
 	if (!hdr1_saved) {
 		err = -ENOMEM;
-- 
2.53.0

