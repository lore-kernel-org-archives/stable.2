Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795696168;
	b=2f52ilJQ3vCgSCQoXMa1w7dl+Rjn2eMfv1FTDdTbd4bCyYhejLrjB0tzcoXYaugIBFme
	 4BkOjtvT95SHz4C81uKjxeJecQlgoBYkYtmIcFU2s5lxT589IyNDKPUV+MEUcM8w1n8jG
	 G99KT6k8NTd4WwGrL9hF6iCeqP9zF/o8LIRROJBgqGa4M8xeCJKGxRj2afiuOpoFNUwc1
	 aMkI+WFW1kq1VuR8mSESGZntPlBx4alGx70/tdgfc8CC37EFeP3Hx6QUl6kN+3R2Kg3XT
	 Df3GBGn8W6ASYEMscV8MYXuHPg4KQ2bHdaWgx9+TTtaV9q175POCzVLzuBXTDY/3adg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795696168;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=nI5767BYDl1w/qhydDBUNNOudORJqLYrgnB55C/m5Iw=;
	b=cWSuvNA6bi58fvse16SOsK0vxeFAFMEDyV/OaCQsayYbzBXEyqD/mLSFZQuRTlNxYeHQ
	 6FvJZuofs8xEuYmvdzIfbq3YiDhl33HnFjGYIJ2ASJ5REY1p+KvIjzkCIZDgsK7CKqn03
	 On/6+4MtGR+/Fa66JwismEqY+Hxz2wQIU9E+B1yclOE+R6WivUcgUXuZvKVWhPF45GWaM
	 Mq6AlcBSPJaOxwbw1T7TCttDQxtbPgqdMKJ+xjWXQiYMAeMT7Kb8m00wNuD4aM7fNf3oV
	 bguwPoKp/F3koaEYTvXONzeV3+fpdQ/m6Vnjl4tjxkePhmJXAowQoCu6GV/EZss9ZQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=WLzAseSU;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705C1606A330;
	Thu, 26 Nov 2026 12:29:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 705C1606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=WLzAseSU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=nI
	5767BYDl1w/qhydDBUNNOudORJqLYrgnB55C/m5Iw=; b=WLzAseSU1euar0ByfK
	RQ7JA6FmKqHheLp0xh/ZRGEYe5DVpDqaZZ4oGJsbeDOM6WjLNzgVeVA//mwtLeJU
	+m8gRFBfCYCkPvFVFSs9CcHg6F85ZeRs8fMVS5ulvAd4KIcjOba8aCNRB53w27sH
	M0rYKJf91hLSyXkS2xv5Nlcq4=
Received: from shaos.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDXH0wTJghr33ZULA--.24861S2;
	Thu, 26 Nov 2026 20:29:07 +0800 (CST)
From: shaos <shawnq1@163.com>
To: phillip@squashfs.org.uk
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] squashfs: exclude fragment tails from block-list scans
Date: Thu, 26 Nov 2026 12:29:06 +0000
Message-Id: <20261126122906.1504988-1-shawnq1@163.com>
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
X-CM-TRANSID:_____wDXH0wTJghr33ZULA--.24861S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXrWrtr1DAF4kXr1fKrWUtwb_yoW7JF47pa
	9akr1akrWqyF1fXws7KF4Uua45uwn7Ca1vgr18Zw48ZasIk3ZagFZ5K3y29F4qvrZ7JFs8
	Xr4YqFyUZan8JFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UWpBfUUUUU=
X-CM-SenderInfo: pvkd40jtr6il2tof0z/xtbC0BNqeGsIJhMUugAA3p

Hello,

seek_hole_data() rounds i_size up to compute file_end and
uses that value as the number of block-list entries. For a file with
a fragment tail, the tail has no block-list word. The scan therefore
reads the next inode-metadata word and can classify fragment data as
a hole.

In the crafted image, pread() reads byte B at offset 4096, but
SEEK_HOLE reports 4096 for a data tail and SEEK_DATA returns ENXIO
for another file whose fragment tail contains data. Count only the
full data blocks when a fragment exists, and return the fragment
start as data when scanning past preceding holes.

The image mounts read-only. Mounting it requires CAP_SYS_ADMIN and
access to a block device. The effect is incorrect SEEK_DATA/SEEK_HOLE
results, which can cause sparse-copy tools to omit real tail data.
No memory corruption or privilege escalation is demonstrated.

HEAD commit:    8d7fe9885c62fc9a95bf55d9db244d9672a8aadc
git tree:       fe970b05333fb8e41da21e9e289f652abcc7cba7
source version: Linux 7.4.0-rc4-g8d7fe9885c62
compiler:       gcc 11.4.0, GNU ld 2.38

The Gist contains the console output, kernel configuration, PoC,
image generator, and init harness:
https://gist.githubusercontent.com/shaos26/5cddc5a02fbba647b37bf60e8a4e0b05/raw/1e23ad163e22d0bd4fba3a65bd8db632cdd37f10/console-output.txt
https://gist.githubusercontent.com/shaos26/5cddc5a02fbba647b37bf60e8a4e0b05/raw/1e23ad163e22d0bd4fba3a65bd8db632cdd37f10/kernel-config.txt
https://gist.githubusercontent.com/shaos26/5cddc5a02fbba647b37bf60e8a4e0b05/raw/1e23ad163e22d0bd4fba3a65bd8db632cdd37f10/poc.c
https://gist.githubusercontent.com/shaos26/5cddc5a02fbba647b37bf60e8a4e0b05/raw/1e23ad163e22d0bd4fba3a65bd8db632cdd37f10/mkimg.py
https://gist.githubusercontent.com/shaos26/5cddc5a02fbba647b37bf60e8a4e0b05/raw/1e23ad163e22d0bd4fba3a65bd8db632cdd37f10/harness-init.c

Build the kernel from the HEAD commit above with kernel-config.txt.
The reproducer requires Python 3, static gcc, cpio, gzip, and QEMU.
Create the positive and metadata-word control images and initramfs:

    python3 mkimg.py img.sqfs
    PHANTOM=nonzero python3 mkimg.py img_ctl.sqfs
    gcc -O2 -static -Wall -Wextra -o poc poc.c
    gcc -O2 -static -Wall -Wextra -o init harness-init.c
    mkdir -p root-pos root-ctl
    cp poc init root-pos/
    cp img.sqfs root-pos/img.sqfs
    cp poc init root-ctl/
    cp img_ctl.sqfs root-ctl/img.sqfs
    (cd root-pos && find . -print0 | cpio --null -o -H newc |
        gzip -9) > initramfs-pos.cpio.gz
    (cd root-ctl && find . -print0 | cpio --null -o -H newc |
        gzip -9) > initramfs-ctl.cpio.gz

Run the positive image with:

    timeout -k 2 20 qemu-system-x86_64 -machine pc -accel tcg,thread=multi \
        -cpu max -m 512 -smp 1 \
        -kernel linux/build/arch/x86/boot/bzImage \
        -initrd initramfs-pos.cpio.gz \
        -append 'console=ttyS0 panic=1 loglevel=7 vivid.n_devs=0 dummy_hcd.num=0 netrom.nr_ndevs=0 rose.rose_ndevs=0 comedi.comedi_num_legacy_minors=0' \
        -nographic -no-reboot -monitor none

Repeat with initramfs-ctl.cpio.gz for the metadata-word control.

The unpatched positive image reports SEEK_HOLE=4096 for pos_hole
and SEEK_DATA=-ENXIO for pos_data even though pread() reads B at
offset 4096. The metadata-word control reports the correct results.
The patched kernel reports the same correct results for both images.

Fixes: dec91e7ab10e ("Squashfs: add SEEK_DATA/SEEK_HOLE support")
Cc: stable@vger.kernel.org
Signed-off-by: shaos <shawnq1@163.com>
---
 fs/squashfs/file.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index d83594ce91d23..cbe21f6168d94 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -681,9 +681,12 @@ static loff_t seek_hole_data(struct file *file, loff_t offset, int whence)
 	if ((unsigned long long)offset >= i_size_read(inode))
 		return -ENXIO;
 
+	/* A fragment tail has no block-list entry. */
+	if (squashfs_i(inode)->fragment_block != SQUASHFS_INVALID_BLK)
+		file_end--;
+
 	/* is offset within tailend and is tailend packed into a fragment? */
-	if (index + 1 == file_end &&
-			squashfs_i(inode)->fragment_block != SQUASHFS_INVALID_BLK) {
+	if (index == file_end && squashfs_i(inode)->fragment_block != SQUASHFS_INVALID_BLK) {
 		if (whence == SEEK_DATA)
 			return offset;
 
@@ -737,7 +740,10 @@ static loff_t seek_hole_data(struct file *file, loff_t offset, int whence)
 
 not_found:
 	/* whence value determines what happens */
-	if (whence == SEEK_DATA)
+	if (whence == SEEK_DATA &&
+	    squashfs_i(inode)->fragment_block != SQUASHFS_INVALID_BLK)
+		offset = file_end << msblk->block_log;
+	else if (whence == SEEK_DATA)
 		offset = -ENXIO;
 	else
 		/* there is an implicit hole at the end of any file */
-- 
2.43.0

