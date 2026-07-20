Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1EE19D092
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 14:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784557627; cv=none; b=sQ3zE7nBeT4e+PyPKGz393bZ92RZfVkEM8p/gMGncWWNWCo1Lrs1JWBR1nJz3N64Ih3H7R/tJGqMKhYM6oM6rdlFQ9eDlqV9dxqOdPt7c+2CsDc7lmeYZ1oy7pPT15W9p2dwX48eEBsxd/7AE3EWOwrK7exQDjUVpfsf7nNDi9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784557627; c=relaxed/simple;
	bh=fbsROzd0zDkBGQA+AzfY9EY80xn4QUPYMZTZTUQwCbA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NAzeVrCDyZB+taAQKExAr2QDOi0U4ost+4r7wDqNhwi2FFoY6NXNyPu4MNIRVnzJB9rlPfgkj9MhKY9CR/xaf8g7UIIUDPt5GseMHZUmV6Wc37a3vQ37z0nzIYNEWlr9xxInEg2hQmeEnDhwQGC65gXwlLwoa4m6shc5v6L9JUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vp+NpIAc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vp+NpIAc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00ED61F000E9;
	Mon, 20 Jul 2026 14:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784557626;
	bh=BgXyft6mGRuJNm98goxzAxYmsmI1NtbN32YeDQQax6I=;
	h=Subject:To:Cc:From:Date;
	b=vp+NpIAceNTjxCtK+zAEn8sr0kpeAbwaN4WoBqiRji+OtlFTFGOqQcSq6HgA0wlEp
	 oa6TpyENj8FzgZDHbEMhdjaxJizC5icjwn9n1iM7Gr5eRSJYTyyxJ02hCHlFhgX942
	 NkzIMp55zksbWQiAcWVnywI6yhJdlaMCN+a5/mog=
Subject: FAILED: patch "[PATCH] ntfs3: validate split-point offset in indx_insert_into_buffer" failed to apply to 5.15-stable tree
To: michael.bommarito@gmail.com,almaz.alexandrovich@paragon-software.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 16:26:49 +0200
Message-ID: <2026072049-legroom-strode-957e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x f1df9d771df47aa40de6d70949c28720ae1e430d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072049-legroom-strode-957e@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f1df9d771df47aa40de6d70949c28720ae1e430d Mon Sep 17 00:00:00 2001
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Fri, 17 Apr 2026 18:57:12 -0400
Subject: [PATCH] ntfs3: validate split-point offset in indx_insert_into_buffer

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

diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 5868964e129c..ade276225999 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1862,6 +1862,20 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
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

