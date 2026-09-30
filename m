Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DCA4D9540
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 16:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790785657; cv=none; b=L9OTyJtrrWhsEsAZKEYrphKabtzHO7AquYS9AM398PpKF9xGV5wHLN/yJb+R+iuQWpNEUzjxDjhr38U6RXc9XcvYkX9WjIK3RW4uHT/OqaI0+q+k/S3fNXyhIuyqI79avKdu37ZZXn1KW2V63NOi2NCA2rC1wyEV0/nJIIKZKpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790785657; c=relaxed/simple;
	bh=EF47LMwptAM1nQReMhccLj8feX+VPSlM1UdRK/A3Xl8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ETD4SX8MWJ3GpLAa9ywCuwei63A5uFenczS1AhIu+Mcx1ngYoahBvoS/OstZ8O9u91tBESjgLZryGZWciYkdn7EK9XdQy/LuyLO0y4/KkCxn5zLVr47nh9AoJ9/RQVmz83tlMXRqZlYBWxLG4U/1KONT7OGL09RCNkS9vtHLla4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EreaLwy5; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EreaLwy5"
Received: by mail-pj2-f40.google.com with SMTP id 98e67ed59e1d1-3a2adb9bc3cso2200798a91.2
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 09:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790785652; x=1791390452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OrlU1pYKaIQMZzrdlwTiBa480D5W1n9HSK6HdsiooX8=;
        b=EreaLwy5wXAiPjeXiINs9mj/XotAUuZ2TvTnqNiTiqhoDu5PE8X/2aHdG4DY1gdG5/
         5CdcMhkIrHTXY+wY826pE6/ABwQCe3I5O331ULMbznzmnGPO+l+PF39zGRGWpSz6/NHX
         vPQUFsm5KFdVP2pPP+UONqrRFN9TMoq9RCrZosf28xczbCDOq0gNz8EZ6dMjGgaaBxAO
         HzgmcbG782VHtD5hyWJq/t8mJ1T/t4rXm/S6z+WjiIR0Gj4mb1oDyY4xjuckV7+64fwE
         B0UoJeMj4/SVuoc2STC5Duq2KFLMKub/ymRxS0flSwQ1FqzQEMU174UJ2XqoAxxR3Ac/
         7yaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790785652; x=1791390452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OrlU1pYKaIQMZzrdlwTiBa480D5W1n9HSK6HdsiooX8=;
        b=d3vP3AT+Izi7spXVCrYfzFS13i+ohKB7FxRC5vIaLJEwJbjrLq94mf3aC1ZcIxN7kj
         8VR+tk6FBO5SR+uDIiZRGAPNB+VrE8ZqRWmiil9z5Cz71CiA09tp7mPDZV79H/pRe5rs
         OVOyzzvjiH+kc4Mw+/PvVzW0H/UV8UoM4O8PDQt70z80m7SiPgz13fFVcvDwQ2Fjm6jW
         Wor4UG9R011Gd+EPJLIDlzhOaI7skD/2Gp1MKyMQxedFP7BoerkIZJDVds1t+2pnmTlJ
         ocDGvtD5t/p7ybJBd5S6T35JEgRIE4S/CXnWmoXF8X9I0zRHJfiGtoE//yn2EzaHpSSw
         Rt6Q==
X-Forwarded-Encrypted: i=1; AKwUvBw6/k9HDuZmxwMCPMUEBWI0UbxgFaUmLqPlMXbGnALuEbwVQ9tdoW9pU84tbUMoqWNtQ1eDGSg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLTJryEOZx4ARtVz6Pg32qnIPpPmXGrQhrJZrra0wsbn0OGYANK
	rU1WuTvaDDS4Z/CrvJkkck5ZMUOQCcGa44qy3OMwhhT7EwYUBbIP3yRi
X-Gm-Gg: AYBFou1eiLoTWQexzJUorVJNK4xM13tr15QjV9x6QBz0CTK0OuWiL/m7mIxLIbkstg9
	JClNM1U+6B5mWnWDjoh6eCKyCXhNhtQFPZ4wlVH6QgtT1jU1GUdBSgsInotHyQeTbqw3ztioLIb
	Focox34j+w+vFFGZubZfd/6+cBqxMCIJAoNjLv2cwDWdoYdbwUpqaY8z2KZs8nHycsS6+L6yW3w
	3IvRfROu2uoQJrPv09UTafWEg1ABsYprxXg5sJtX+GxgMogSG7eZBpN8XWgpoExN3TGNsvRieUo
	BOEE67o7wqEVGjgR5WzIlzniDBFsDTWdkX+m6f+CblZobfARQCNbRfcReVOY5sYySZNdbeliyXA
	0WYKGtkH7h3rmzASstnKW19J8S2jBB9P84mbwBD91IvQ1nDiOW3FraquPDjJBJ9jHmvTNi+kSdl
	US2Ba/rUC8QhC8n7SAROpwkNUYkmwCtPLA9ft5DE3bgNlkfPN1nxkiWVpPpCz60QjUaUsxiQnjF
	A==
X-Received: by 2002:a17:90b:4b11:b0:3a0:d79d:b6bf with SMTP id 98e67ed59e1d1-3a4d14de36bmr811283a91.20.1790785651665;
        Wed, 30 Sep 2026 09:27:31 -0700 (PDT)
Received: from thangnn-ASUS.. ([2a09:bac5:d45e:16c8::245:115])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4e66742acsm725485a91.4.2026.09.30.09.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 09:27:31 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+e390d66dda462b51fde1@syzkaller.appspotmail.com,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] hfs: don't give the extents overflow file overflow extents
Date: Wed, 30 Sep 2026 23:27:26 +0700
Message-ID: <20260930162726.144048-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hfs_bmap_reserve() grows a b-tree's backing file via hfs_extend_file()
while the caller holds tree->tree_lock. For the extents tree itself,
once its three MDB extents are full and hfs_add_extent() returns
-ENOSPC, hfs_extend_file() falls through to insert_extent and records
an overflow extent for the extents file. The next extension then sees
alloc_blocks != first_blocks and calls hfs_ext_read_extent(), which
takes ext_tree->tree_lock again:

  hfs_ext_read_extent()           <- hfs_find_init(ext_tree)
    __hfs_ext_write_extent()
      hfs_bmap_reserve(ext_tree)
        hfs_extend_file(ext inode)
          hfs_ext_read_extent()   <- hfs_find_init(ext_tree): deadlock

The extents overflow file can't have overflow extents of its own; its
extents live only in the MDB. Fail with -ENOSPC instead, returning the
just-allocated blocks to the bitmap. hfs_btree_open() already rejects
an extents fork larger than its MDB extents, so this keeps
alloc_blocks == first_blocks for the extents file for the whole mount.

Reproducible with a plain mount + ftruncate on a fragmented volume with
a small extents-file clump size.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+e390d66dda462b51fde1@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e390d66dda462b51fde1
Cc: stable@vger.kernel.org
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
Notes (not for the changelog):

Reproduced in QEMU (x86_64, lockdep) with syzbot C repro 11c3a202580000,
and more simply with mount + ftruncate(0x100c17a) on the same image:
"possible recursive locking detected" on ext_tree->tree_lock followed by
the task stuck forever in D state. The image's extents fork is
consistent (one 4-block extent), with a 2048-byte XT clump and a
fragmented bitmap, so the three MDB extents fill up after a few
extensions and insert_extent runs for the extents file.

With the patch, 3 runs of all five syzbot C repros plus the direct
mount+ftruncate case: no lockdep report and no hung tasks. ftruncate
still returns 0, since hfs_file_truncate() already ignores a failed
extension.
 fs/hfs/extent.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/hfs/extent.c b/fs/hfs/extent.c
index f066a99a863b..5e7a1f1eb395 100644
--- a/fs/hfs/extent.c
+++ b/fs/hfs/extent.c
@@ -457,6 +457,13 @@ int hfs_extend_file(struct inode *inode)
 	return res;
 
 insert_extent:
+	/* The extents file can't have overflow extents of its own */
+	if (inode->i_ino == HFS_EXT_CNID) {
+		hfs_clear_vbm_bits(sb, start, len);
+		res = -ENOSPC;
+		goto out;
+	}
+
 	hfs_dbg("insert new extent\n");
 	res = hfs_ext_write_extent(inode);
 	if (res)
-- 
2.43.0

