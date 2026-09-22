Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE9A369D56
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 09:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790070194; cv=none; b=k+PVHPhiCGe831HJmW8guWoEq6I4EZFiTcZmWqlFt5tMl/HHcs+nAg3AzIEKxAe/U5CCx1HQr12oqVvzXgP+UiiP9a1PoDDVgFDzNWAkSWPOV+wUrRg/NPiV9fNhS71tU9CGwxjAMEgvMmLRGzQAjcxSERfid/R28SaDHhXjX+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790070194; c=relaxed/simple;
	bh=AXq2ZLYCQQCux0e6BVijaimRaW1NIqgkMnZv7n9ts6Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GH60SQf1L49/3jYsAwhLshH1+Srabn6U0JmhSBZUvP06ubTaXbITdfLyCzuhrmb9OD4VJKJmkif1TUnvkrYf1L13xHyefIPiRQA4XK1IRRgxchB7H0cc8pJWJan+sqks2tG0zdDyXaYVWXCAw9MVContwOnTg6fKIyFPuPkpYtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UfpX96kM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UfpX96kM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79AF21F000FF;
	Tue, 22 Sep 2026 09:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790070192;
	bh=m7kZt8d3nhgdx6J46gB57zGndv8mCgvm7/ScrSnbsSg=;
	h=Subject:To:Cc:From:Date;
	b=UfpX96kM2QW3ynBWHmeBxsO+P0yXoD2xVQiGgSmC8VxQmvAz8VSb/pzhgWw2atTFv
	 gJPELIdD6TcpDefUu2Z8osOke7RamQlnh0eGTGxt1KqEly9uofSm2ySXRV73I0i3kV
	 nivhbK5NLx5/Itu/dY5mYwXYAZ0VNtOKXJxYAkps=
Subject: FAILED: patch "[PATCH] mips: select CONFIG_WEAK_REORDERING_BEYOND_LLSC from" failed to apply to 6.12-stable tree
To: theo.lebrun@bootlin.com,jiaxun.yang@flygoat.com,tsbogend@alpha.franken.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 11:36:07 +0200
Message-ID: <2026092207-starry-unrented-8053@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x bbc448c541ed90d52f9ec22f17394304e3bf170e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092207-starry-unrented-8053@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bbc448c541ed90d52f9ec22f17394304e3bf170e Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 28 Aug 2026 16:07:33 +0200
Subject: [PATCH] mips: select CONFIG_WEAK_REORDERING_BEYOND_LLSC from
 CONFIG_EYEQ
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On I6500 CPU cores, lld and scd give no ordering guarantees (same as all
other instructions). To respect the assumption that arch_cmpxchg() is
fully ordered, we must inject sync instructions above and below our
lld/scd loops using the already in place WEAK_REORDERING_BEYOND_LLSC
infrastructure.

Otherwise, bad things can happen:

[   34.054496] CPU 3 Unable to handle kernel paging request at virtual address 0000000000000000, epc == a80000080838e01c, ra == a80000080838dfc4
[   34.054559] Oops[#1]:
[   34.069561] CPU: 3 UID: 0 PID: 170 Comm: pipe_race Not tainted 7.2.0-rc6-01553-gb73c35220968-dirty #103 VOLUNTARY
[   34.079932] Hardware name: Mobile EyeQ5 MP5 Evaluation board
[   34.085592] $ 0   : 0000000000000000 0000000000000001 0000000000000000 0000000000000000
[   34.093616] $ 4   : a800000808ee2618 000000000b7a879d 0000000000001000 0000000000000000
[   34.101638] $ 8   : 0000000000e3f2c9 0000000000000000 a800000808a2a9f8 0000000000000000
[   34.109660] $12   : a8000008139ffcd8 ffffffff84080018 a80000080837fae0 7878787878787878
[   34.117682] $16   : a800000807e82940 0000000000001000 0000000000000000 0000000000000000
[   34.125704] $20   : a800000802920e00 a8000008139ffdf8 a800000802649400 0000000000e3f2c9
[   34.133726] $24   : 0000000000000006 00000001200406e0
[   34.141783] $28   : a8000008139fc000 a8000008139ffd10 0000000000e3f2c8 a80000080838dfc4
[   34.149837] epc   : a80000080838e01c anon_pipe_read+0xd4/0x428
[   34.155697] ra    : a80000080838dfc4 anon_pipe_read+0x7c/0x428
[   34.161549] Status: 140000e3  KX SX UX KERNEL EXL IE
[   34.166551] Cause : 40800408 (ExcCode 02)
[   34.170574] BadVA : 0000000000000000
[   34.174161] PrId  : 0001b028 (MIPS I6500)
[   34.178183] Process pipe_race (pid: 170, threadinfo=000000005ca35720, task=00000000e1013890, tls=000000014ebbb780)
[   34.188568] Stack : a800000802649400 0000000000000000 0000000000000000 a8000008139ffdd0
[   34.196623]	 0000000000000fba a800000808ee0000 0000000000000001 a8000008130c3e80
[   34.204676]	 a8000008080d1280 a8000008139ffd58 a8000008139ffd58 1dbd2b22ea1dd500
[   34.212729]	 a800000802649400 a800000808ee0000 ffffffffffffffea 0000000000000001
[   34.220783]	 0000000000001000 0000000000000000 00000001200ae518 ffffffffffffffff
[   34.228836]	 000000fffbe0e530 a80000080837edf4 000000fffbe0e530 0000000000000000
[   34.236890]	 0000000000000000 0000000000000000 000000014ebb55a0 0000000000001000
[   34.244943]	 0000000000000001 a800000802649400 0000000000000000 0000000000000000
[   34.252996]	 0000000000000000 0000400400000000 0000000000000000 1dbd2b22ea1dd500
[   34.261049]	 00000000140000e3 a800000802649400 a800000802649400 a800000808ee0000
[   34.269103]	 ...
[   34.271568] Call Trace:
[   34.274026] [<a80000080838e01c>] anon_pipe_read+0xd4/0x428
[   34.279533] [<a80000080837edf4>] vfs_read+0x25c/0x318
[   34.284607] [<a80000080837faac>] ksys_read+0x104/0x138
[   34.289763] [<a80000080802b9cc>] syscall_common+0x44/0x68
[   34.295187]
[   34.296689] Code: f84000cf  02209825  de020010 <dc420000> d8400004  02002825  0040f809  02802025  f84000c3
[   34.306504]
[   34.308099] ---[ end trace 0000000000000000 ]---

My initial reproducer was the xdp-tools test suite. A standalone
reproducer would be an lld/scd loop that, when the read is reordered by
the CPU, triggers a fault. We can achieve this from userspace by
stressing an anonymous pipe, which uses a mutex. Program used:

	// SPDX-License-Identifier: GPL-2.0
	// pipe_race.c - reproducer for MIPS LL/SC reordering vs fs/pipe.c
	//
	// Two userspace processes on an anonymous pipe:
	//   parent  = writer: tight write() loop
	//   child   = reader: tight read() loop

	#define _GNU_SOURCE
	#include <assert.h>
	#include <errno.h>
	#include <sched.h>
	#include <signal.h>
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include <sys/types.h>
	#include <sys/wait.h>
	#include <time.h>
	#include <unistd.h>

	int main(void)
	{
		long wrsize = 70;	// bytes per write()
		long rdsize = 4096;	// bytes per read()
		int pfd[2];
		char *buf;
		pid_t pid;
		int ret;

		ret = pipe(pfd);
		assert(!ret);

		pid = fork();
		assert(pid >= 0);

		if (pid == 0) {			/* reader */
			close(pfd[1]);
			buf = malloc(rdsize);
			assert(buf);
			for (;;) {
				ssize_t n = read(pfd[0], buf, rdsize);

				if (n < 0 && errno == EINTR)
					continue;
				if (n <= 0)
					_exit(n < 0 ? 1 : 0);
			}
		}

		close(pfd[0]);			/* writer */
		buf = malloc(wrsize);
		assert(buf);
		memset(buf, 'x', wrsize);

		for (;;) {
			ssize_t n = write(pfd[1], buf, wrsize);

			if (n < 0 && errno == EINTR)
				continue;
			if (n != wrsize)
				break;
		}

		kill(pid, SIGKILL);
		wait(NULL);
		return 0;
	}

Fixes: fbe0fae601b7 ("MIPS: mobileye: Add EyeQ6H support")
Cc: stable@vger.kernel.org
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index c3f69def2008..d7c67cebe065 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -658,6 +658,7 @@ config EYEQ
 	select USB_UHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
 	select USE_OF
 	select HOTPLUG_PARALLEL if HOTPLUG_CPU
+	select WEAK_REORDERING_BEYOND_LLSC
 	help
 	  Select this to build a kernel supporting EyeQ SoC from Mobileye.
 

