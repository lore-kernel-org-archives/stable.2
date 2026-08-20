Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A231C5D72
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 00:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787185321; cv=none; b=mcbLzmqYnga7XgP4w8tQW/egnNHKcQkT0iCbkp/EDSsQ/sEFZWtNXt68UuG2NWUYVnhb/vxo5Ee4LxWRqzMZ6xiwylgqkQsTftiN658Z2KfexkCTK+xsA76Y7B66yINZZ/cPleySubj3MXA1exkXFCPjmmvaHSufsSxKWnGvm+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787185321; c=relaxed/simple;
	bh=vaY0P3hjZGMlXKCzaJyIxaJwtL7yg0HdeDCgjEEBY0c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rJkfLxf31eJRIfZ6tNcMjClAPnu+8voDL11NVY1T1sQjXyCla/gNxu+pj5AxWVbufcm93EJSlwLaYNFV6nnyO4huzjWYYRSQU70cHH6VQS1bgR7ZmHcvFSLmnHzV7cJ2+4WvuOoWC6okxcBW7/tm6OMBuRBBaYfy4iqa10DtetA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anthonyvardaro.com; spf=none smtp.mailfrom=anthonyvardaro.com; dkim=pass (2048-bit key) header.d=anthonyvardaro-com.20251104.gappssmtp.com header.i=@anthonyvardaro-com.20251104.gappssmtp.com header.b=XrH5T264; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anthonyvardaro.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=anthonyvardaro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=anthonyvardaro-com.20251104.gappssmtp.com header.i=@anthonyvardaro-com.20251104.gappssmtp.com header.b="XrH5T264"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ce7d2adef4so21168865ad.3
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 17:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anthonyvardaro-com.20251104.gappssmtp.com; s=20251104; t=1787185319; x=1787790119; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=APwF6PUHOqN1JhIA+m2g5MAL7aCXBL5aOcOFSVNm7oo=;
        b=XrH5T264dJm0XaXbJGaXsNYcFq/7v5oGusxGeo9UgbTB19fx+DZpltZKLeSuMHST6k
         O7dyntksTMVC070VSKrBnMBuW3Mcy5dX5Xwcqrhx0UdvCCR4OQBAPvjF31gZEdqrTDKW
         I+DA/XWN3dV2SiCT3PaRbsbP5gEr6EFerlbc6Kl220N52QcuvBXyugsOTzQgl7l1KtWA
         HJCOcG8FUk0anqjYWQ/s4/qoi2W3Hz4WwZveULAjbDwRH6R3tDx3FeLbn8ATt2f+ay1W
         G8P0Pmnly2q7D3OUjwwzsYko77Lz4Fp0MlsiLXsvEi+7WdDqfEWtrN2LVejiJc5eODx/
         9vbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787185319; x=1787790119;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=APwF6PUHOqN1JhIA+m2g5MAL7aCXBL5aOcOFSVNm7oo=;
        b=r90rX/RJMWXZXOmt5axy2EkNxPq+00vwff1rYkhg1YQkSrGJHlGxjXF6CWON0UJD70
         A5t03IShjsOWXz2PuNVxwN7enUnfLGJC52irxT98QX3ysBfUnD1tyKdtd8kItIksjwxA
         QEy/ruhDvA6PpsKu1j+MJ0+MO3owPqDWf2od0YNemumWr90lpToGejTNIPMNAforiXRp
         szF25Dx++9FUAv/l519wzRMsxWf5TdxPd8R5WpYGgRfzPc9Wjk1B0bFIDe+uO/PcCK8I
         aLDYd/WqzG2O4Mz/V3gT1bzq0QM/AFaao9lL2NQ86rqiqRE6F3kAp/I1KgKsemqpOmbW
         5F/g==
X-Forwarded-Encrypted: i=1; AHgh+Rr7to0qsmJNVP3sQyv7zC4K6glG0sG+Pi+4V0gDRHArtzbaRXBQhJLydOuvyrdNBpZMUl/urGk=@vger.kernel.org
X-Gm-Message-State: AFuF++l58iPU+S/UztborPDg/urrSER47nEOA1PYFjyqDbhSQi5H8Qnl
	h/5HlTwz47XRXE7V2hk+n0UO3x04lIo+J2qa9N2PGWIbVxMSRdsPpI+kxL3Px4x7mSg=
X-Gm-Gg: AR+sD12rDUubmLBxp4/xqL4dJGid3QKN014wHgafeY6d0sPOVVfsrEcsT8Aw0vf5Fiu
	sPJzOmHPHEEmpcWmRnhOoI8vKcT402WRaTmkOklspvwOXIh115XR8uHymsW+lrBV4p2oj6OTrn5
	BT3ejlhIdzkW5a0YYzPnNNbMnl4sUUORoJk/bEQ9Yjfx3chjnSekzP4Qo83NDIoJvt3noA8ke92
	lALXBCr1cW+oOWwEEx5DwdAQoYVbftfelt1kh+8Nx0ydCXaszuU3TF8RDCdgKvycLjVuqz4yBfU
	7LhiuMC6Dqum6kEzb3AqcV3MjBfOqQ2vX0QdoAe8HG1BagPtt07RLuNc3yXvXK2TbmsXtleLR44
	gOl9qaLpiiGlNmpSn78Q5/ZH/ZkqcPtYn/uNPnVw/f9rS8ohMWloj9PSdTMt1EX+VDUlT+rUTLB
	xaU3dgMNtx8nMhfUv7WoFC8DJiuIQxl3pf1tmBrDuhK5cj4y0EfyH8SXZc18Yw6o12gwpKE4QNO
	lMj+L8Tucs0zSDBS2Fe/v4uayQmftagvFK0Xy2tsAz9X31/0Ndedu9ZXS5N+4dNS2hU44aKpKxq
	/D6YrEQDl493jQfqQ7JgTUU/UJb6EF96psLPEN0AFEUC+7taRuy5BuTelsaRlQM8cOWiXnXcm0/
	IKeyuPCSZvGEfJLphtjDLYK8=
X-Received: by 2002:a17:902:c950:b0:2d6:2901:6265 with SMTP id d9443c01a7336-2d629016342mr11412075ad.2.1787185319472;
        Wed, 19 Aug 2026 17:21:59 -0700 (PDT)
Received: from coder-vardaro-vardaro-2-0.coder-vardaro-vardaro-2.remote-dev.svc.cluster.local (ec2-16-145-69-213.us-west-2.compute.amazonaws.com. [16.145.69.213])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d62e3d27basm229915ad.79.2026.08.19.17.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 17:21:58 -0700 (PDT)
From: "Anthony Vardaro (Anthropic)" <me@anthonyvardaro.com>
Date: Thu, 20 Aug 2026 00:21:38 +0000
Subject: [PATCH] xfs: revalidate cached COW fork mappings during writeback
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-b4-xfs-cow-wb-revalidate-v1-1-8a19080799ea@anthonyvardaro.com>
X-B4-Tracking: v=1; b=H4sIAJFIhmoC/22Nyw6DIBBFf8XMuhMBjTb9lcYFj6HSGjBgq4nx3
 wt22+WZO/fcHRJFRwlu1Q6RPi654DPwSwV6lP5B6ExmEEx07MobVC1uNqEOK64Kc0VOzsiFkLW
 iN9yqpjM95PocybrtVN+HH6e3epJeiq98KJkIVZRej+U0zXW2hviiWJ/R3x04ji90XxSgtQAAA
 A==
X-Change-ID: 20260813-b4-xfs-cow-wb-revalidate-0427d1fb36d7
To: Carlos Maiolino <cem@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 "Anthony Vardaro (Anthropic)" <me@anthonyvardaro.com>
X-Mailer: b4 0.15.2

Writeback can write a folio through a cached COW fork mapping after the
blocks behind it have been freed. Since commit d9252d526ba6 ("xfs:
validate writeback mapping using data fork seq counter") a cached data
fork mapping is dropped when the fork changes, but a COW fork mapping is
accepted on range alone, and since commit 3b3508980730 ("xfs: remove
superfluous writeback mapping eof trimming") nothing trims it to EOF. So
when close() or truncate frees the post-EOF COW blocks and the file is
then appended, the same writeback pass writes the new folio into blocks
the inode no longer owns. fsync() returns 0 and the range reads back as
zeroes, or the data lands in another file.

Check cow_seq against the COW fork if_seq for COW mappings as well, and
only sample cow_seq where the mapping is built so a failed conversion
cannot pair a stale mapping with a fresh sequence number.

This costs one extent lookup and one cancelled transaction per
invalidation: about 5% more fsync time on random 4k overwrites of a
reflinked file, nothing measurable on sequential writeback.

Fixes: d9252d526ba6 ("xfs: validate writeback mapping using data fork seq counter")
Cc: stable@vger.kernel.org # v5.1
Assisted-by: Claude:unspecified
Signed-off-by: Anthony Vardaro (Anthropic) <me@anthonyvardaro.com>
---
An fstests case for this, using the wb_delay_ms error injection knob,
follows separately.

Backport note: kernels before v6.2 do not have
trace_xfs_wb_cow_iomap_invalid() (added by commit c2beff99eb03), so
drop that call there. Kernels before v5.5 test wpc->fork ==
XFS_COW_FORK instead of IOMAP_F_SHARED and have no XFS_WPC().
---
 fs/xfs/xfs_aops.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 2a0c54256..c043e5bad 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -304,12 +304,22 @@ xfs_imap_valid(
 	    offset >= wpc->iomap.offset + wpc->iomap.length)
 		return false;
 	/*
-	 * If this is a COW mapping, it is sufficient to check that the mapping
-	 * covers the offset. Be careful to check this first because the caller
-	 * can revalidate a COW mapping without updating the data seqno.
+	 * A COW mapping is only valid while the COW fork is unchanged. After a
+	 * change, the blocks behind the mapping can already be freed, for
+	 * example by the post-EOF trim on close. Do this check before the
+	 * data fork check, because the caller can revalidate a COW mapping
+	 * without updating the data seqno.
 	 */
-	if (wpc->iomap.flags & IOMAP_F_SHARED)
+	if (wpc->iomap.flags & IOMAP_F_SHARED) {
+		if (!ip->i_cowfp)
+			return false;
+		if (XFS_WPC(wpc)->cow_seq != READ_ONCE(ip->i_cowfp->if_seq)) {
+			trace_xfs_wb_cow_iomap_invalid(ip, &wpc->iomap,
+					XFS_WPC(wpc)->cow_seq, XFS_COW_FORK);
+			return false;
+		}
 		return true;
+	}
 
 	/*
 	 * This is not a COW mapping. Check the sequence number of the data fork
@@ -359,9 +369,8 @@ xfs_map_blocks(
 	/*
 	 * COW fork blocks can overlap data fork blocks even if the blocks
 	 * aren't shared.  COW I/O always takes precedent, so we must always
-	 * check for overlap on reflink inodes unless the mapping is already a
-	 * COW one, or the COW fork hasn't changed from the last time we looked
-	 * at it.
+	 * check for overlap on reflink inodes unless the COW fork hasn't
+	 * changed from the last time we looked at it.
 	 *
 	 * It's safe to check the COW fork if_seq here without the ILOCK because
 	 * we've indirectly protected against concurrent updates: writeback has
@@ -394,16 +403,14 @@ xfs_map_blocks(
 	    xfs_iext_lookup_extent(ip, ip->i_cowfp, offset_fsb, &icur, &imap))
 		cow_fsb = imap.br_startoff;
 	if (cow_fsb != NULLFILEOFF && cow_fsb <= offset_fsb) {
-		XFS_WPC(wpc)->cow_seq = READ_ONCE(ip->i_cowfp->if_seq);
 		xfs_iunlock(ip, XFS_ILOCK_SHARED);
-
 		whichfork = XFS_COW_FORK;
 		goto allocate_blocks;
 	}
 
 	/*
-	 * No COW extent overlap. Revalidate now that we may have updated
-	 * ->cow_seq. If the data mapping is still valid, we're done.
+	 * No COW extent overlap. If the data mapping is still valid, we're
+	 * done.
 	 */
 	if (xfs_imap_valid(wpc, ip, offset)) {
 		xfs_iunlock(ip, XFS_ILOCK_SHARED);

---
base-commit: 0877338ade31b825884a744e03f27c8de300f101
change-id: 20260813-b4-xfs-cow-wb-revalidate-0427d1fb36d7

Best regards,
--  
Anthony Vardaro (Anthropic) <me@anthonyvardaro.com>

