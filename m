Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795131679;
	b=F7op1TZF14taT9/za0Zh8i3gPuWGUCwN02kycJCsgZ5TRNEf7do1KDbsYzrESHQLCig4
	 OQNHFsXFlCK9iTTl/kC1RXFa45gKVBTg3dyC36ByNr46pLLjA7xxxUpAuiv4sKyMO2sll
	 D3feWyK29vC01tpahzG4rjbnXqabCKleYFCXnCQzsv/a9wDUBm6ftZCazpxeTBCqTjtKV
	 CT5aB5SzkZliwt9ilIs1ft6VdbPBT7Q3tfsTpllm/7kpD5i9m8+J/7tKqltDQi5Q1s/5P
	 V5SWNJxDojtLIZRPCdbV9xlVyOq5WbtXQEtyaJGSrRf7s18Qv23WHqpc65QCho1Oddg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795131679;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=rrqe4OL7rF0jVL1e4A2AH8iDIiTDyxz7nVkoEsGHoek=;
	b=TPJEKxdNUDqo8Ybcl/ZgYPbCUYIzhjjsOwTNsnQbywX4w4MnPu9eWTl3LN0z7MPUJBOE
	 ugWHG+q/rwlAZirRuXqgNrO0TZuE5HIM8I+jgOC/FTC65pasXt+6OLo9jI2UuzvE+zjUP
	 IMiq56H0EQNL3bU59qeR8DJxo451t9JchooAoqjCPmHyn4s9tf26Wiw5QeKj+UbfORj4i
	 aOdnRDmZA4qHCCH7X4Qfyy6sF0hJxyEGoLYOKLYedeaXoP2JH4faVxfY6HKE7Er24s2Cl
	 wo4RQRy/PhTfacf1REVcSpJpZY7w8wUQp23tRrEAooizoepCe25vXgBigIvCsI/XVDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Wbw3MVau;
	arc=none smtp.remote-ip=74.125.224.46
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F24606A331
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 23:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91F24606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Wbw3MVau
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-67db3a48dc6so545659d50.3
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 15:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1795131678; x=1795736478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rrqe4OL7rF0jVL1e4A2AH8iDIiTDyxz7nVkoEsGHoek=;
        b=Wbw3MVauYF6euxivL0WLepHbMXlTv7BP7mivKx337xquqBERVRSuxX0S9xm/kQqqH3
         MswqeI+HHsDcb4ZkH5xaAxBVFI2vzmPk1fgl9e899tlflMpxuVJqqaZ4ey9sgzMcbJGD
         w/VOtxnvM61uiYQ/Lx9vxVbz1QAeu/98IQI9KnScRqdniDmPWi0LA9FHTBC78FXsXihW
         An7Fgxq65QOO+SH8897pKPRH1RvXvOqDtBHcJC/I6kdnfI6WXuNAywj2AyO2O3qnGvwa
         1AEx5BVcHl9Qq/JA4NYy/+r/Q6Iik0u6+4M6aZA6UKZc1EF/mx/FzYgUmuYUyq4SImv3
         qpyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795131678; x=1795736478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rrqe4OL7rF0jVL1e4A2AH8iDIiTDyxz7nVkoEsGHoek=;
        b=elDyb8JZPIDytcxaGUra3sDWeb/yTZUGBwZMFTE7enWQ5ijgBjBPKiFbEr3/8ydVbZ
         Ly4NDHApJs4zi2JJMwCQFLBEQagO93ilM/SGb7AUve/262AxdFkQYwCAW8eHXcgdWiM4
         3EivGwd4iwryHmQfMutU1StVQJWQHFBNQt2ashApYpRZ3wgfVghJ44PtjSrmm0ns4HTD
         6B/BlCfQFCB7GvLkCDqKLF4SFxUOX7ARYFPkwMfnwfQNvrYqgHUqAIlz7vkMy9iGpUb4
         aOWRH68Fe4sSdRwU8pWLB4g8laCrNLIw9OF0dQ1UV1Z7u7HQNV59rBJCc0qVOpePOtiU
         430A==
X-Forwarded-Encrypted: i=1; AL+hErFiPGJ7yidOl2XWiGqPA+c8kHsOsOeOWAptcr78oSUWk+VwJpXwRwECF7LvQBem++C/lX/i+7I=@vger.kernel.org
X-Gm-Message-State: APuU4Z8F9iYvlkKBwJvH32NgJvE5wBoWzikGaAHnF960jU6emFhPlCi/
	4RD1XXYn79PfxWPAqTcP+ccNT9T1fFIqe5vJleE5B4docRlkHVoC2bw7NQUvwPMA4AI=
X-Gm-Gg: AZFdTZfOG8Z/cTGmocqd8hCfQWXCwhrSWvgIt5glW4rWRvbZE8aOArTEa3d15Zy6yN5
	uJC+cCqj769QsB34h37Y6nB6UUusVdfEWdFXXjRz18u1Eel0lk/q4lVRUUjYelM1pfgYOL4z3rP
	pRFEt6/9P40yhcfzmii6FFK+vZ5l1KU77Z+u0FA5d+fesqhnuFVv3d3PL9St1fAPLgYS6u5IYKh
	Hxk/nFADpeiFEcNJ2MVQDd7n25I+NNKTJOskfo7wlKMVc/Zfz63H11O6YW7gNBtgTA/PoOfk0yP
	Wr0KHrITf32oNmb88QNN52I5piq7HcRxHGUfHO5BIMCEItcoGqKfmfuuuEoupN2W4K93gYU/zbu
	JfjNrDVHHJ99pC+fYNWA4lkeAlrnh8QaWHHCM84QhbqvywctBdgF//ZkOr/9HX5JawBgUoa7vCX
	LDZd/Bjxn4WWeuHXEBvUmfwBwNkbsty8JAga4O0xvdtmFUa/qA0cxRhlvY9QUblKwLzLZgpF1W3
	6WZWZkXUk99Z1bvoTmX5wRLzOrlzhP5NuHOtCMuUZjMHRJPKgQ14avmXu8n+J91vXn5kedyWAt5
	5MqBEBhYBFcBs1SspyDKoP5vR/b4W3oKPJf1Rh+KtS1N7P2DFo4ntZau3nsTswRVU4SR5uiOOKD
	yH6sBQDWnMVgg3BThdXFVa/BSGIK0PG2feBciFIkkNy6Dlky2WY9IQReD1ttBWorVzFywYjw=
X-Received: by 2002:a05:690e:14c4:b0:67c:608:b372 with SMTP id 956f58d0204a3-67df441e4f7mr413834d50.66.1795131677626;
        Thu, 19 Nov 2026 15:41:17 -0800 (PST)
Received: from system76-laptop.attlocal.net ([2600:1700:6476:1430:1932:ad09:1827:11fb])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67df338e8fesm796893d50.16.2026.11.19.15.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 15:41:17 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Zheng Zheng <fengaojigui88@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/5] hfsplus: reject special files larger than their allocation at mount
Date: Thu, 19 Nov 2026 15:41:08 -0800
Message-ID: <20261119234112.720963-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119234112.720963-1-slava@dubeyko.com>
References: <20261119234112.720963-1-slava@dubeyko.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The volume header describes each special file (extents, catalog,
allocation, startup and attributes file) with a fork that holds its
logical size, its number of allocated blocks and its first eight
extents. hfsplus_inode_read_fork() takes the logical size as is, and
fs_blocks is derived from it, so a corrupted header can make a special
file look larger than the blocks allocated to it.

Syzkaller found an image whose allocation file has a logical size of
0x800000000800 bytes but only one allocated block. Deleting a file on
that volume frees its blocks, and hfsplus_block_free() reads the
bitmap page through the allocation file while it holds the deleted
file's extents_lock and sbi->alloc_mutex. Page 0 of the bitmap spans
fs blocks beyond the first allocation block. As they are below the
inflated fs_blocks, hfsplus_get_block() does not treat them as beyond
EOF: it takes the allocation file's extents_lock and searches the
extents B-tree, which has no record for them. Lockdep reports
recursive locking on extents_lock and the block free fails with -EIO:

  WARNING: possible recursive locking detected
  rm/922 is trying to acquire lock:
  (&HFSPLUS_I(inode)->extents_lock){+.+.}-{4:4}, at: hfsplus_get_block
  but task is already holding lock:
  (&HFSPLUS_I(inode)->extents_lock){+.+.}-{4:4}, at: hfsplus_file_truncate
  ...
   hfsplus_get_block
   block_read_full_folio
   ...
   read_cache_page
   hfsplus_block_free
   hfsplus_free_extents
   hfsplus_file_truncate
   hfsplus_delete_inode
   hfsplus_unlink
  hfsplus: unable to mark blocks free: error -5
  hfsplus: can't free extent: start 74, count 1

A logical size beyond the allocated blocks is invalid on HFS+, so
check it when the special file inodes are read from the volume header
and fail the mount if it is exceeded. The error is reported as:

  hfsplus: special file 6: size 140737488357376 exceeds allocated size 2048
  hfsplus: failed to load allocation file

Tested on a KASAN and lockdep kernel: the syzkaller image and images
with the logical size of the allocation, extents, catalog or
attributes file set one byte beyond its allocation are rejected, the
image with a consistent size mounts and its files can be deleted, and
generic/001, 002 and 013 pass on freshly created volumes.

The analysis, the fix and this changelog were drafted with the help of
an AI coding assistant (Claude Opus 5.5) and reviewed by the author.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Zheng Zheng <fengaojigui88@gmail.com>
Closes: https://lore.kernel.org/linux-fsdevel/CAO-4RZ1a46EoJY7x6euiS+7aTOb-T9X62E9nGyToRcyvKU+eHg@mail.gmail.com/
Cc: stable@vger.kernel.org
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 fs/hfsplus/super.c | 38 +++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index f3283e9b42c8..33594e1f8367 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -26,34 +26,62 @@ static void hfsplus_free_inode(struct inode *inode);
 #include "hfsplus_fs.h"
 #include "xattr.h"
 
+/*
+ * The logical size of a special file must fit within its allocated
+ * blocks. Otherwise its page cache would map blocks past the end of the
+ * extent records, which the code accessing these files (e.g. the bitmap
+ * code holding alloc_mutex) does not expect.
+ */
+static int hfsplus_system_read_fork(struct inode *inode,
+				    struct hfsplus_fork_raw *fork)
+{
+	struct hfsplus_sb_info *sbi = HFSPLUS_SB(inode->i_sb);
+	u64 size = be64_to_cpu(fork->total_size);
+	u32 total_blocks = be32_to_cpu(fork->total_blocks);
+	u64 alloc_size = (u64)total_blocks << sbi->alloc_blksz_shift;
+
+	if (size > alloc_size) {
+		pr_err("special file %llu: size %llu exceeds allocated size %llu\n",
+		       inode->i_ino, size, alloc_size);
+		return -EIO;
+	}
+
+	hfsplus_inode_read_fork(inode, fork);
+	return 0;
+}
+
 static int hfsplus_system_read_inode(struct inode *inode)
 {
 	struct hfsplus_vh *vhdr = HFSPLUS_SB(inode->i_sb)->s_vhdr;
+	int err;
 
 	switch (inode->i_ino) {
 	case HFSPLUS_EXT_CNID:
-		hfsplus_inode_read_fork(inode, &vhdr->ext_file);
+		err = hfsplus_system_read_fork(inode, &vhdr->ext_file);
 		inode->i_mapping->a_ops = &hfsplus_btree_aops;
 		break;
 	case HFSPLUS_CAT_CNID:
-		hfsplus_inode_read_fork(inode, &vhdr->cat_file);
+		err = hfsplus_system_read_fork(inode, &vhdr->cat_file);
 		inode->i_mapping->a_ops = &hfsplus_btree_aops;
 		break;
 	case HFSPLUS_ALLOC_CNID:
-		hfsplus_inode_read_fork(inode, &vhdr->alloc_file);
+		err = hfsplus_system_read_fork(inode, &vhdr->alloc_file);
 		inode->i_mapping->a_ops = &hfsplus_aops;
 		break;
 	case HFSPLUS_START_CNID:
-		hfsplus_inode_read_fork(inode, &vhdr->start_file);
+		err = hfsplus_system_read_fork(inode, &vhdr->start_file);
 		break;
 	case HFSPLUS_ATTR_CNID:
-		hfsplus_inode_read_fork(inode, &vhdr->attr_file);
+		err = hfsplus_system_read_fork(inode, &vhdr->attr_file);
 		inode->i_mapping->a_ops = &hfsplus_btree_aops;
 		break;
 	default:
 		return -EIO;
 	}
 
+	if (err)
+		return err;
+
 	/*
 	 * Assign a dummy file type, for may_open() requires that
 	 * an inode has a valid file type.
-- 
2.53.0

