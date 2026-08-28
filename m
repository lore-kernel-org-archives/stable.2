Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB32627A47F;
	Fri, 28 Aug 2026 14:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787926076; cv=none; b=tGPcFc2xEjmEYiKL/Br8ND/lq5fkjkzPsb+YweDhzpcexwUFlwexbuMOqThnB6jfZbU2jMWhCFO2EFXN+vSBwUuIIHJ2dUgLIY3OFYNM4m3XIVwxH9lyjIuZ0A6t+Tdn22W4kFrjkU5acLNMpwRHTkNAoFOmD4NUIapyFPugH6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787926076; c=relaxed/simple;
	bh=TBH83RWzbPi3hPQhZL8SsrLTL7ByIAO3rQTk5wzs14g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Dny9JWtjDTikaQxWU/OWMnRLXIrptS+pZNKKv0lOc5lk1pakV2++Jws7NnFbi9D732qUpRzSu1V9L1ZEkIVVsPn2ezXfUZyxjCIbkpXVfO7E0/Z2KGGius68kPqz/dG6OVgt6Uah0GmOaooFEHVuwPEZNbElpISc2fRu5kgU5MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QIY+qGWg; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QIY+qGWg"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 351CD4E41404;
	Fri, 28 Aug 2026 14:07:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F3D3360537;
	Fri, 28 Aug 2026 14:07:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EE66011C781A7;
	Fri, 28 Aug 2026 16:07:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787926066; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=MzRL6iatWiMUl1WDoUNGb9uivqjfifE5/OyTjMxiP0o=;
	b=QIY+qGWgooTFrFCwGPBcxL03vPh6RlrDZ9RtufOUQqJQAwMN9AM2g7AKzAomR8kCKkI5A5
	cIB/1dVCWmwn/iTab4/gsSIcalZcbamok4k07nLteIOmKFv0JX2j30Xncd4x3XbJqfoXTl
	1tT7RAwRwpoALX4GdtAfyN2RQdKd3Eq2jNHrl76yfLKVNKIhWbfrze7bEsGrYyphfzcflU
	KMXR4fzaR0dxFnPWK9dj+EvSjXBj2HKG8jMjQ8hEm6qaixLmS8JPSd0USFZlh5NVNyu/3M
	mRzcAAlA1g7zpNdDQcAEq2/rd4ekPPAIAZc7huu9xU2DZQiR88GJYOFOk6cg5g==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 28 Aug 2026 16:07:33 +0200
Subject: [PATCH] mips: select CONFIG_WEAK_REORDERING_BEYOND_LLSC from
 CONFIG_EYEQ
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260828-eyeq-reordering-llsc-v1-1-0c5a69fc5124@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CQAxG4auQrm0CDRlHr2JcyPCLNWTQVg2Gc
 HdHXX6L9xZymMJpXy1keKnrlAuaTUXpcsoDWPtiklpCHSUy3rizYbK+hHngcfTEIYVGdrETtFs
 q6c1w1vm3PRz/9md3RXp8X7SuH95mw7N4AAAA
X-Change-ID: 20260828-eyeq-reordering-llsc-6c61298b2e47
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, stable@vger.kernel.org, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

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
---
 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index e2eb9627bd14..5713a7e325dc 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -661,6 +661,7 @@ config EYEQ
 	select USB_UHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
 	select USE_OF
 	select HOTPLUG_PARALLEL if HOTPLUG_CPU
+	select WEAK_REORDERING_BEYOND_LLSC
 	help
 	  Select this to build a kernel supporting EyeQ SoC from Mobileye.
 

---
base-commit: 1b78070aaef63512688aebfbc82365ef9d6660f1
change-id: 20260828-eyeq-reordering-llsc-6c61298b2e47

Best regards,
--  
Théo Lebrun <theo.lebrun@bootlin.com>

