Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B2944F546
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 02:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791857389; cv=none; b=sByLIaXR9tCMLq08a1/d2z87MyA3zvV9jU6Zk2NFcS7h65RWeaNo9aMYifLw1aPbSZ7ekLxN4l9TsK9bfeSu/1B5Ojvw0GIrw9OzuA9q742OZDJjDO35f8uRfY/vgYlDB7ocNGd5+mIoPwGJ5+ppPJ+Us5apBBYtRx0PPio4mok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791857389; c=relaxed/simple;
	bh=///uuY9jbj++gbJGzjzpOoqz67KdoOg1gGFB1Qb8Yi0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mj69I0pQzf9RXUdJcgvl8p9I1oIBcb8jQToyYsb/klwuDJaKLwHLVdjSuDqR2w3nMhHZOymWB0T0TyuqJmPUIQcBNrR77NiflBBfWYKwwcyja/LPj+QlD8laBIhd4GpYsJk8Y86TRyutxYtG+UOCXrp+xyAI9GX+9wlz/gPOG4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0kBjkcW; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0kBjkcW"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e8b20a899fso7610335ad.1
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 19:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791857388; x=1792462188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7yfQb/NIWEqP4dfQyyW1F46esS1vblLkgAQScX3XltE=;
        b=D0kBjkcWRNEdwYrDZKC1BwlcbmmPHgDOBGMaT2Kg/idr2/p8rETcHROhvFGe5rbEAQ
         wyv4MrIQBseEFza97Y9LamMWy9BhtLUTNNOaZwUSbiHv1t1V+/ZkZUE+qmEZUh1U39LU
         7Sn+DqK7Rxio454w4JJKl8b+A53Hkg01MQjdftcTDH4bfxzik3yDcyjH43VAqpKGe62R
         wb1fbwPOy8JnrAC/b+2/GVW4NY6qUl5LHHXX6+9lH3Uy+6JpdfgwGEQPM8gAsuuL/OFV
         7xQPrwav0BIp2RrKRuOyMZB5eUhz22cpsRJWuNbJIbRa5pdp7ISg7Ghj/FWumgczb5SE
         L62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791857388; x=1792462188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7yfQb/NIWEqP4dfQyyW1F46esS1vblLkgAQScX3XltE=;
        b=GKOUtGaOC/PRMsXXk3U9SmCW9MXwGd0c2csmHIvOdjr2SjNiRF0Kkip+TmJ7Tkz6mX
         wa2pHen5p50lU0Rx/0z7PhbKcf/lEDoIYT1qOGWM+Z7N/3O85y0J7ktaWu/xegGzfpjG
         jdJviRhzY9Yp1wFfsYZBIorUVSK68dvTPhK1IYzLGizJYjK3DbaFPKWUd1dBuj1QvdPC
         ieREDaJ53xU+qNv1+8oSvH1Xm3vgdJXmHuE/YYODt+QNu8gcrYN2aWnU6OQZfnul/Z2x
         VJ3j4Gcct6kc4L/MiHMFWrcN6+hB6ka/EywbRi2HTOrTrLLM7Z1LVlr3iyQSyrNXAXw5
         8BZg==
X-Forwarded-Encrypted: i=1; AKwUvBwlxvD9FJu7rttwspcf0LVAhVxoH+RJpZR9rTPOWnL4cy69iRx+eMkvfOa+Ay1OXOOsFNL7e9A=@vger.kernel.org
X-Gm-Message-State: AFq9FYLkkmtY+T4+wwZsgU2mA7DEHSjdzaoV/1zijwMkwn9zkjhcMBIL
	vkIy2rpLBde0Cl+OEd4oywMWCG5KEQLsdiiDBfQRLKzefGm8+nYzbfwi
X-Gm-Gg: AYBFou2y1EbvegHb193wYq+hB3sysCvQOmk7PzqjcBSR2jsKGscd7qkJ0P48GDX9Pxt
	lH7d9GlBUbKxe/4DxCNRF/wi5HRisTNUQ8wmj0w0Y732lc6HQ2nykPu+bdOU1F5sFFZyxnUJLWE
	rMQtBpKX85fk7f78lJwu1uu5+i8CLW5kI5nYSzJs9p03JA2oxHTJCTk5m0tWegbOqpZxBebErGU
	IJthaUY/SJ4HjdroVafqqvRaWrTStp8UEYVp5jGHEFGUGGXTdchqbqVdJz+8gCWWycp8m0tdSbJ
	IqIOJhLP5Ge6f1dxGDiKcHOqPtYxQZHSsXyUfZZM0RNSzW0l0fpjzVSvszYu/yPt72mDy54B4FE
	1LsG+he3wRCdnxcfpxIpjgXgOjVukYbbgbn9Y3buP12BcRsN19ytgjTgfUKTuYLr8W+36w0B/4p
	VsREqs5dEhxQRjK1bPIg4MKToDfhDfFVgkeLU3UaIGkkCNvQ2iQMyGi8wuAsguKGwjiFrJM5GHo
	eXDizsik6gpurPCCajXKr6kgBuj676dbqXI5LZAwLFDx5Yh/Z4rH/BgxLfK0zwmbnuFcJc15Nsq
	kYKcfo3hzdrEaNk=
X-Received: by 2002:a17:903:2a87:b0:2dd:c100:b2c5 with SMTP id d9443c01a7336-2e842ce4e2fmr99096335ad.48.1791857387543;
        Mon, 12 Oct 2026 19:09:47 -0700 (PDT)
Received: from f2fs-test.c.googlers.com.com (225.134.16.34.bc.googleusercontent.com. [34.16.134.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e90977deafsm4319505ad.68.2026.10.12.19.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 19:09:46 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>,
	stable@vger.kernel.org
Subject: [PATCH] f2fs: release a removed xattr node in roll-forward recovery
Date: Tue, 13 Oct 2026 02:09:41 +0000
Message-ID: <20261013020941.4025355-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

When xattrs shrink enough to fit in the inline xattr area,
write_all_xattrs() truncates the xattr node and clears i_xattr_nid. If
the file is then fsynced without a checkpoint, only the inode block is
written, with i_xattr_nid of 0.

Roll-forward recovery starts from the checkpointed inode, whose
i_xattr_nid still points to the old xattr node.
f2fs_recover_inline_xattr() copies only the inline xattr area, and
f2fs_update_inode() writes the old i_xattr_nid back. So the inode keeps
the stale xattr node:

 - The node block is never released, and fsck reports "nonzero bytes in
   xattr space after end of list".
 - If the inline xattr list ends exactly at the end of the inline area,
   its terminator is read from the stale node, and the removed xattrs
   come back after recovery.

When the fsynced inode has no xattr node but the checkpointed one has,
release the old xattr node in the same way as f2fs_recover_xattr_data().

Fixes: 28cdce0459cc ("f2fs: recover inline xattr data in roll-forward process")
Cc: stable@vger.kernel.org
Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/node.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 55008f18afd..590fdedf9c2 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2831,6 +2831,29 @@ int f2fs_recover_inline_xattr(struct inode *inode, struct f2fs_cached_block *ent
 	f2fs_cache_wait_writeback(ientry);
 	memcpy(dst_addr, src_addr, inline_size);
 update_inode:
+	/*
+	 * The xattr node of the checkpoint was removed before fsync, e.g. the
+	 * xattrs became small enough to fit inline. Release it as well, or
+	 * the inode keeps pointing to the stale xattrs.
+	 */
+	if (!ri->i_xattr_nid && F2FS_I(inode)->i_xattr_nid) {
+		struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+		struct node_info ni;
+		int err;
+
+		err = f2fs_get_node_info(sbi, F2FS_I(inode)->i_xattr_nid,
+								&ni, false);
+		if (err) {
+			f2fs_put_cache(ientry, true);
+			return err;
+		}
+
+		f2fs_invalidate_blocks(sbi, ni.blk_addr, 1);
+		dec_valid_node_count(sbi, inode, false);
+		set_node_addr(sbi, &ni, NULL_ADDR, false);
+		f2fs_i_xnid_write(inode, 0);
+	}
+
 	f2fs_update_inode(inode, ientry);
 	f2fs_put_cache(ientry, true);
 	return 0;
-- 
2.56.0.385.gd3acb90ef8-goog

