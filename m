Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795696168;
	b=SJ71I2NAMa+5JxVuxeNPp93k/KeyxyxatmSVFsnDoBKdjSBHKzz+4llicjnjR4v1aj3W
	 p/ylXXljELCldpJHHPve/edtAHUT35yRf9JotUz4WWtt32/Qf7EzLXAUbWEYGFaYbQlO2
	 DmiHimVUUgypseqBWYNxio1bE8L97frWNnY7tktyYLN/+EJk/JixXi/f0jPjPqtWHuydK
	 9UgnKMpbPHxVnLpZ9T9vY8iAYZP0c5r03IgSvlwsI4ilHsm+NMBTEU/BSspvDHDmNFOfj
	 w1g26HfDRQc0fRb2w/8qI07eKMQ4ulwSPgqpmD6tteNaOufnreLbuszBwhDrUPU8ETQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795696168;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=Giut5oAN+AjVqPxPA21/kV4OLA4B6tJvSVA2HFrCt+E=;
	b=qrhNnQjE3M9ki5owhX3kDYEKdmmRJdDvFnJAC6s3BUmWipJdt5jHv4m23j+Oe4+tL0HH
	 EDd3XiMUyuwhW8zwt0PgoP/ApIRzq4oPoVYc2YyAbdLxdERgPmxxQMe3hGvhDK9kb8SFX
	 cepLgv0vj9kSOlPw1tWMp8JpET0ltqlGdMOEgL0AuD31soRxwfB/nClxj3dpIHOEHNCmA
	 HNZ+SQBSTVHOIkeHZOmNJmfi8/hUdnOWmoA1ZHk40xWqtev4uXtIAscPTq0g69RpKq2p1
	 7HOg+noJuM2EmRxpbWBx+iJ+qbAiTU7R1VL+MSf822oG/+xNmx8HavUtfVcbrolUe6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=dDw6nR4f;
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC315606A333;
	Thu, 26 Nov 2026 12:29:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC315606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=dDw6nR4f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Gi
	ut5oAN+AjVqPxPA21/kV4OLA4B6tJvSVA2HFrCt+E=; b=dDw6nR4fXWJ49h+njI
	WoPkaycdKRku5RlFL0XEkOtujnEBkXbiM7zLM7J+wRHz2hGvaYi8CzCXG/tBIP9S
	tzSbKE03aHAMxlIspqs00Ez39dJ4GHM/y2VBX088MEfKDNhRY0/bwlNo1kUx9agt
	HtfrbXI5JcCQDFk1TdUr4sieo=
Received: from shaos.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wBnQyAJJghr+9G_KQ--.34212S2;
	Thu, 26 Nov 2026 20:28:58 +0800 (CST)
From: shaos <shawnq1@163.com>
To: me@bobcopeland.com
Cc: linux-karma-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] omfs: require exact directory-name matches
Date: Thu, 26 Nov 2026 12:28:57 +0000
Message-Id: <20261126122857.1504827-1-shawnq1@163.com>
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
X-CM-TRANSID:_____wBnQyAJJghr+9G_KQ--.34212S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGw4xur47Ar4fJr1DWF4Uurg_yoWrXFy7pF
	90y3yrKF4fJF1Utw4kKFyjvw1fuws7AFWaga4UX3WxGws8W34Ig34Ikw43ZF47Zr95JrWY
	va1jq348AayUGaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Ud9N-UUUUU=
X-CM-SenderInfo: pvkd40jtr6il2tof0z/xtbC8QpodmsIJgpVZwAA3Y

Hello,

omfs_scan_list() compares an on-disk name with strncmp() using
only the requested name length. If a bucket contains "alphad" before
"alpha", looking up "alpha" accepts the longer name as a match.
Operations on the short name can then act on the wrong inode: the
reproducer reads the contents of "alphad" through "/alpha", and
unlink("/alpha") removes "alphad" while the real "alpha" remains.

Require the stored name length to equal namelen before comparing the
bytes. This keeps the bucket-chain lookup exact and prevents the
wrong directory entry from being removed.

The reproducer uses a crafted writable OMFS image. Mounting it
requires CAP_SYS_ADMIN; unlink additionally requires write permission
on the mounted directory. This is a filesystem correctness and data
integrity issue. No privilege escalation is demonstrated.

HEAD commit:    8d7fe9885c62fc9a95bf55d9db244d9672a8aadc
git tree:       fe970b05333fb8e41da21e9e289f652abcc7cba7
source version: Linux 7.4.0-rc4-g8d7fe9885c62
compiler:       gcc 11.4.0, GNU ld 2.38

The Gist contains the console output, kernel configuration, PoC,
OMFS image builder, and init script:
https://gist.githubusercontent.com/shaos26/652a268fb0905bb1ada587cf8ab135db/raw/77a78f40e36b1853c4913832be9773a5d2147194/console-output.txt
https://gist.githubusercontent.com/shaos26/652a268fb0905bb1ada587cf8ab135db/raw/77a78f40e36b1853c4913832be9773a5d2147194/kernel-config.txt
https://gist.githubusercontent.com/shaos26/652a268fb0905bb1ada587cf8ab135db/raw/77a78f40e36b1853c4913832be9773a5d2147194/poc.c
https://gist.githubusercontent.com/shaos26/652a268fb0905bb1ada587cf8ab135db/raw/77a78f40e36b1853c4913832be9773a5d2147194/mkimage.py
https://gist.githubusercontent.com/shaos26/652a268fb0905bb1ada587cf8ab135db/raw/77a78f40e36b1853c4913832be9773a5d2147194/init

Build the kernel from the HEAD commit above with kernel-config.txt.
The PoC requires Python 3, static gcc, BusyBox, cpio, gzip, and QEMU:

    work=$(mktemp -d)
    python3 mkimage.py "$work/base.img"
    gcc -O2 -static -Wall -Wextra -o "$work/omfs_probe" poc.c
    mkdir -p "$work/rootfs/bin"
    cp /usr/bin/busybox "$work/rootfs/bin/busybox"
    for applet in sh mount umount poweroff dmesg ls; do
        ln -s busybox "$work/rootfs/bin/$applet"
    done
    cp init "$work/rootfs/init"
    cp "$work/omfs_probe" "$work/rootfs/omfs_probe"
    (cd "$work/rootfs" && find . -print0 |
        cpio --null -o --format=newc | gzip -9) > "$work/initrd.gz"
    qemu-system-x86_64 -m 1G -smp 2 \
        -kernel linux/build/arch/x86/boot/bzImage \
        -initrd "$work/initrd.gz" \
        -drive file="$work/base.img",if=virtio,format=raw,cache=none \
        -append 'console=ttyS0 rdinit=/init panic=-1 oops=panic loglevel=7' \
        -display none -serial file:omfs.log -monitor none -no-reboot

The test enumerates both names, opens both paths, compares their inode
numbers, unlinks "alpha", and checks the directory again after a
remount. The unpatched run shows that "alpha" reads and resolves to
the "alphad" inode and deletes "alphad". With this patch, "alpha"
resolves to its own inode, its unlink removes the exact entry, and
"alphad" remains readable after remount.

Fixes: a3ab7155ea21 ("omfs: add directory routines")
Cc: stable@vger.kernel.org
Signed-off-by: shaos <shawnq1@163.com>
---
 fs/omfs/dir.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/omfs/dir.c b/fs/omfs/dir.c
index 18f4b4543cc81..a00e62baf1cc7 100644
--- a/fs/omfs/dir.c
+++ b/fs/omfs/dir.c
@@ -53,7 +53,8 @@ static struct buffer_head *omfs_scan_list(struct inode *dir, u64 block,
 			goto err;
 		}
 
-		if (strncmp(oi->i_name, name, namelen) == 0)
+		if (strnlen(oi->i_name, OMFS_NAMELEN) == namelen &&
+		    memcmp(oi->i_name, name, namelen) == 0)
 			return bh;
 
 		*prev_block = block;
-- 
2.43.0

