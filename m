Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795864548;
	b=AG3wPOeHapE9z61+qMBvRqY2E6C1WdITMk54bzc/Y3SLC1MhRxi5eGxp84R6cT4HJgBl
	 N7OEzkErnGuNIqcOsXCElRV6uN4Sbnwemg6LbbnO8n2rB8Ju8tz4YV7wX0m0t6bhws2IK
	 vDl1qCUVqvRdwVwXlGHMY4tIq48g9GSZ+lrfmInUnatvqXuPVXGou/yYTxarbATGmO0eP
	 1tw3COaTqCnEjCfnVyWK9Kzf8NBc/lDfA6PVtmDJT4lsCqh3Vx0M7xFQU/Iuru46ZLSK+
	 j8Q8Jnirh7gtPyqgXf12INF53VHeZjYxU7hbSVKFEAb/LASG+tmHnOqz9+Z5MAleV6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795864548;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=PSol1rGMhWq/7bJkjDlmY/1qcUzcy40Z2uiSXVn7/WU=;
	b=yqoB4LAoiGZuHzpT/9nvQ4c8l+VV9Sl8aEtsNkOJxe3MB1s3E0YYlJHaHPDmrhdRgKeK
	 Uf0tO6aHIs2B/9zy+wg60fBpSqDkbc9Kx8AUsIhFJ/AQkn/y2nNgSIrJiPVPSr8D86W14
	 6WjiuxDYzsjC1po5yybM9x0dfiHlracUG3wnKdhkjPX4NiMUFwiIqzfSt/cGbiXuafhrM
	 QEbX5OBhNeqsb2DkC0CplBGr6cd9fsIvLIyHWjHj/cCTrgjkTOlBlTj3YOazn1zBqP8ue
	 9DHpFjxaNxSCcHYSBRGH3jqECMPZK1p+vfstg2Jw7iyZunaH6FmGmcyhdlrZtdY01oA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="IGaoe/Uk";
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F67606A31C;
	Sat, 28 Nov 2026 11:15:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5F67606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=IGaoe/Uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=PS
	ol1rGMhWq/7bJkjDlmY/1qcUzcy40Z2uiSXVn7/WU=; b=IGaoe/UkJQ5RKtvstO
	veRPQBylRs+vep8PDesc1PKCJhSAmX09njkYjCeNSu8jVL4k7uwioBcnz6Wkn5lq
	rQdKDYU3dFeJQwBlL7KBC5euNCItIYm6a78M+9I8UKQhJ4qDI326TO274Bk1PslI
	SYgP/1t5w/8HLEg9CHZ/ILANE=
Received: from shaos.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgA3uXHEtwprSFzEIg--.52796S2;
	Sat, 28 Nov 2026 19:15:17 +0800 (CST)
From: shaos <shawnq1@163.com>
To: brauner@kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] minix: reject data zone overlapping inode table
Date: Sat, 28 Nov 2026 11:15:16 +0000
Message-Id: <20261128111516.3209948-1-shawnq1@163.com>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:PygvCgA3uXHEtwprSFzEIg--.52796S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWryrJr4xWrWDXFyrWr48WFg_yoW5Cr18pF
	Wayr15Gr4kWFWUWa4I93yjqa4Sga18AFW7WrW8Xry8C3s8Kw4Iq34UKFyY9rWUKrsrA3Wj
	vF1DKry8CF1UCaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnsqXUUUUU=
X-CM-SenderInfo: pvkd40jtr6il2tof0z/xtbCzwV8imsKt8VGHQAA30

Hello,

minix_check_superblock() checks that s_firstdatazone is within the
filesystem, but does not check that it follows the inode table.  The
inode table starts after the superblock and bitmaps and occupies
ceil(s_ninodes / inodes_per_block) blocks.  If s_firstdatazone points
inside that range, normal file-data allocation can overwrite raw inode
records.

On a crafted Minix V3 image with s_firstdatazone=5, uid 1000 wrote
ordinary file data over the inode for an existing root-owned file.
After unmounting and remounting, that file had mode 0104755 and size
680.  Executing it changed the child from uid/euid/suid 1000 to euid 0
and allowed it to read a root-only file outside the Minix mount.

The trigger requires a privileged process to mount a crafted Minix
image read-write on a mount that honors setuid bits.  After that mount,
the attacker needs write access to a file on the volume.  The test does
not use an unprivileged mount.  The s_firstdatazone=8 geometry control
and the MS_NOSUID control do not escalate.

HEAD commit:    8d7fe9885c62fc9a95bf55d9db244d9672a8aadc
git tree:       fe970b05333fb8e41da21e9e289f652abcc7cba7
source version: v7.3-23088-g8d7fe9885c62f (Linux 7.4.0-rc4)
compiler:       gcc 11.4.0, GNU ld 2.38

The full console output and exact kernel configuration are available
from me on request.  The reproduction package includes the C harness,
image builders, payload, and initramfs.  The patched kernel rejects
the s_firstdatazone=5 image with EINVAL and accepts the
s_firstdatazone=8 control.

The check compares the first data zone with the first block after the
complete inode table.  It handles Minix V1 separately because its inode
size differs from Minix V2/V3.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: shaos <shawnq1@163.com>

Thanks,

shaos

---
 fs/minix/inode.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index 9fb938ec58689..943ea1515f95b 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -176,6 +176,7 @@ static bool minix_check_superblock(struct super_block *sb)
 {
 	struct minix_sb_info *sbi = minix_sb(sb);
 	unsigned long block;
+	unsigned long inodes_per_block;
 
 	if (sbi->s_log_zone_size != 0) {
 		printk("minix-fs error: zone size must equal block size. "
@@ -207,6 +208,17 @@ static bool minix_check_superblock(struct super_block *sb)
 		return false;
 	}
 
+	if (sbi->s_version == MINIX_V1)
+		inodes_per_block = MINIX_INODES_PER_BLOCK;
+	else
+		inodes_per_block = sb->s_blocksize / sizeof(struct minix2_inode);
+
+	/* The inode table must not overlap the first data zone. */
+	block = 2 + sbi->s_imap_blocks + sbi->s_zmap_blocks +
+		DIV_ROUND_UP(sbi->s_ninodes, inodes_per_block);
+	if (sbi->s_firstdatazone < block)
+		return false;
+
 	/*
 	 * s_max_size must not exceed the block mapping limitation.  This check
 	 * is only needed for V1 filesystems, since V2/V3 support an extra level
-- 
2.34.1

