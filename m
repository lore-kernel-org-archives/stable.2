Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795696140;
	b=z7HZyNj6HRjmw7T3KrWDGazUezbPR4YvK7+7EPfZcMj+1xK9ZvssSoaGcixnYhe9VhMa
	 hh6g4sYxPKe1mfrSv6nvrvhgyc03uckXQXfIG6uwkMS9N+Osg1i4LThUYFwIDe/s0lX45
	 IV1FQC5Eak6Ey0/o8MVO+t2OxHsiT81LIzW4bRJFCoqoCm1UdprEu7G7C5zY/3TM7MgRz
	 54/B0vl8xacShG1fFVmLQ8bJabqW7qW3122ReRF2Q8HATwfQ0WjDy3l+iZHGLlLNqUq4A
	 8ZJf8cdWYuVTsyPpfpmX2jF27EbuiDbspHmG7iGErc15AuKLXbjjof7FxI4mY7Tds4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795696140;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=Atq3ozJ4Wr5OsexYVxytprCPV98S+WrlE0ZQhW+dzpM=;
	b=WfL4fKWJR1842mORBSyXkIOEIRPdakfdiz3ogwvzLXqmJj//af2WRUXusE7XFWYsg157
	 2RUvzCWorgp+f7C7z9uBm2ma/Z0Rf6jHexa/8dLSmGeZGKFAVLL8tbW+qFsA/I9s5dWgD
	 0e2Jt462bQzidE42ZYhlvzs+JXa9EFBRksyGLjiHz541YyxNUbUhm4vvUPs2v55s/rCrx
	 RrPgmLMWvQoRUqnxRKtV7GosXiltWsHhLKpTj+rX46jS4idnc9x0fEQcamnOsbrlkYGwB
	 +5X6nzRO0cvcMExUHyLMtEhnrm6xin/geF0QfZvdoySpWZsZZwTyEPybrBY2S1FrLRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=LHQV4l9R;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB124606A31E;
	Thu, 26 Nov 2026 12:28:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB124606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=LHQV4l9R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=At
	q3ozJ4Wr5OsexYVxytprCPV98S+WrlE0ZQhW+dzpM=; b=LHQV4l9RHT2RTlkqu/
	k0yTyYGLZuV2s7HUyoD0qzkkQeFfr9KogURiQBKqJjBf6R0NFsHxetBlQhDDucu+
	/8iNHlAS6P+CjY+rmWmT/P4usamG+R1UHdObm/3TKoiI/yPQsbsoa+1qH0R+FpF1
	HqbMJl/8wpt5kkMeTFSRClbwA=
Received: from shaos.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgAnyRcFJghrctsxHw--.4035S2;
	Thu, 26 Nov 2026 20:28:54 +0800 (CST)
From: shaos <shawnq1@163.com>
To: viro@zeniv.linux.org.uk
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] qnx6: make directory scans interruptible
Date: Thu, 26 Nov 2026 12:28:53 +0000
Message-Id: <20261126122853.1504791-1-shawnq1@163.com>
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
X-CM-TRANSID:PSgvCgAnyRcFJghrctsxHw--.4035S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCw15Cr1DJr17tF1UtF45Awb_yoW5KF17pF
	Z0yFWxtr4kJa45Ar1IkFW8ZrWfW3srG34UGFyvy34xua13tFnrKw10y3yYgF18CrZ5Ka4Y
	vrW0g34kWa1DJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UAuciUUUUU=
X-CM-SenderInfo: pvkd40jtr6il2tof0z/xtbC8QZndWsIJgZVOQAA3K

Hello,

qnx6_iget() copies the on-disk directory size directly to
i_size. qnx6_readdir() uses that value to walk every directory page.
When the entries are empty, the loop does not call dir_emit(), so the
usual readdir signal check is not reached. A crafted image with an
extremely large root directory size can keep getdents64() in the
kernel for an effectively unbounded scan; a pending SIGKILL does not
stop the task.

Check for fatal signals and yield between pages. This lets the syscall
return when the task is killed and lets other tasks run during a long
scan. It does not impose an arbitrary maximum directory size.

The trigger requires mounting a crafted QNX6 block image, which needs
CAP_SYS_ADMIN and access to a block device. The issue is a local
availability problem; no memory corruption or privilege escalation
is demonstrated.

HEAD commit:    8d7fe9885c62fc9a95bf55d9db244d9672a8aadc
git tree:       fe970b05333fb8e41da21e9e289f652abcc7cba7
source version: Linux 7.4.0-rc4-g8d7fe9885c62
compiler:       gcc 11.4.0, GNU ld 2.38

The Gist contains the complete console output, kernel configuration,
and self-contained userland PoC:
https://gist.githubusercontent.com/shaos26/32f8b37dc46e147d763c0ab8bd52c725/raw/dcf72b32e927cb5ffd34277d7add093a8d77a595/console-output.txt
https://gist.githubusercontent.com/shaos26/32f8b37dc46e147d763c0ab8bd52c725/raw/dcf72b32e927cb5ffd34277d7add093a8d77a595/kernel-config.txt
https://gist.githubusercontent.com/shaos26/32f8b37dc46e147d763c0ab8bd52c725/raw/dcf72b32e927cb5ffd34277d7add093a8d77a595/poc.c

Build the kernel from the HEAD commit above with kernel-config.txt.
Build the static PoC and initramfs, then boot it in QEMU:

    mkdir -p root
    gcc -O2 -static -Wall -Wextra -o root/init poc.c
    chmod 0755 root/init
    (cd root && find . -print0 | cpio --null -o -H newc |
        gzip -9) > initramfs.cpio.gz
    timeout -k 2 30 qemu-system-x86_64 -m 2048 -smp 2 \
        -kernel linux/build/arch/x86/boot/bzImage \
        -initrd initramfs.cpio.gz \
        -append 'console=ttyS0 loglevel=7' \
        -display none -serial file:qnx6.log -monitor none -no-reboot

The PoC constructs the filesystem images and runs the normal-size,
small-buffer, and huge-directory cases. The unpatched run leaves the
getdents64 child in state R after SIGKILL, with CPU ticks increasing.
With this patch, the same call returns after SIGKILL and the child
exits; all mount and small-buffer controls still pass.

Fixes: 5d026c724220 ("fs: initial qnx6fs addition")
Cc: stable@vger.kernel.org
Signed-off-by: shaos <shawnq1@163.com>
---
 fs/qnx6/dir.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/qnx6/dir.c b/fs/qnx6/dir.c
index 56bbaffe4b444..90473375e6ca1 100644
--- a/fs/qnx6/dir.c
+++ b/fs/qnx6/dir.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/filelock.h>
+#include <linux/sched/signal.h>
 #include "qnx6.h"
 
 static unsigned qnx6_lfile_checksum(char *name, unsigned size)
@@ -131,9 +132,15 @@ static int qnx6_readdir(struct file *file, struct dir_context *ctx)
 	for ( ; !done && n < npages; n++, offset = 0) {
 		struct qnx6_dir_entry *de;
 		struct folio *folio;
-		char *kaddr = qnx6_get_folio(inode, n, &folio);
+		char *kaddr;
 		struct qnx6_dir_entry *limit;
 
+		if (fatal_signal_pending(current))
+			return -EINTR;
+		cond_resched();
+
+		kaddr = qnx6_get_folio(inode, n, &folio);
+
 		if (IS_ERR(kaddr)) {
 			pr_err("%s(): read failed\n", __func__);
 			ctx->pos = (n + 1) << PAGE_SHIFT;
-- 
2.43.0

