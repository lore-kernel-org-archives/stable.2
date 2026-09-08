Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF57C4E80A3;
	Tue,  8 Sep 2026 14:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788877029; cv=none; b=E5Hessedw5xh+bZdYeHsng1Q/QkRQcpwBs7uLp2z2LgSJqxIuG0qM4QNeRzK4fewX+JiaUa5V+SbFx/8ZgsKJDZPboKwWiuuMTL0TSGGgSG3dNYEf/WZ2Xe3mjtM9vmpZTh+Srsd8jdpfdtHPyAMiGddXfHfzJxKfblJcMOaH30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788877029; c=relaxed/simple;
	bh=dl5AWU68BS2Ezaxw2/gJ0EKanb2dZsb9bAtoK2VloU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WiN6meD7lwo85vfM2TxEk2K1K1BqFrI8GhPjjOIQ/nGq2dS3I/jvzYo+43oAWjB15r7NIb5FCmzz9NNHg16AoKdxYBZZTQC6aL7ik5oXAGRacxYJNrdrIpInxJDvZJI1NosOMfiVWPhG2m6ccjHnvd3e/vtuD/UxoaVWNSjkmt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1x3wd3-0002fj-00; Tue, 08 Sep 2026 16:16:53 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
	id A40BCC0155; Tue,  8 Sep 2026 16:16:41 +0200 (CEST)
Date: Tue, 8 Sep 2026 16:16:41 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	=?iso-8859-1?Q?Beno=EEt?= Monin <benoit.monin@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] mips: select CONFIG_WEAK_REORDERING_BEYOND_LLSC from
 CONFIG_EYEQ
Message-ID: <aqAYyd1uwh1mJOwY@alpha.franken.de>
References: <20260828-eyeq-reordering-llsc-v1-1-0c5a69fc5124@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260828-eyeq-reordering-llsc-v1-1-0c5a69fc5124@bootlin.com>

On Fri, Aug 28, 2026 at 04:07:33PM +0200, Théo Lebrun wrote:
> On I6500 CPU cores, lld and scd give no ordering guarantees (same as all
> other instructions). To respect the assumption that arch_cmpxchg() is
> fully ordered, we must inject sync instructions above and below our
> lld/scd loops using the already in place WEAK_REORDERING_BEYOND_LLSC
> infrastructure.
> 
> Otherwise, bad things can happen:
> 
> [   34.054496] CPU 3 Unable to handle kernel paging request at virtual address 0000000000000000, epc == a80000080838e01c, ra == a80000080838dfc4
> [   34.054559] Oops[#1]:
> [   34.069561] CPU: 3 UID: 0 PID: 170 Comm: pipe_race Not tainted 7.2.0-rc6-01553-gb73c35220968-dirty #103 VOLUNTARY
> [   34.079932] Hardware name: Mobile EyeQ5 MP5 Evaluation board
> [   34.085592] $ 0   : 0000000000000000 0000000000000001 0000000000000000 0000000000000000
> [   34.093616] $ 4   : a800000808ee2618 000000000b7a879d 0000000000001000 0000000000000000
> [   34.101638] $ 8   : 0000000000e3f2c9 0000000000000000 a800000808a2a9f8 0000000000000000
> [   34.109660] $12   : a8000008139ffcd8 ffffffff84080018 a80000080837fae0 7878787878787878
> [   34.117682] $16   : a800000807e82940 0000000000001000 0000000000000000 0000000000000000
> [   34.125704] $20   : a800000802920e00 a8000008139ffdf8 a800000802649400 0000000000e3f2c9
> [   34.133726] $24   : 0000000000000006 00000001200406e0
> [   34.141783] $28   : a8000008139fc000 a8000008139ffd10 0000000000e3f2c8 a80000080838dfc4
> [   34.149837] epc   : a80000080838e01c anon_pipe_read+0xd4/0x428
> [   34.155697] ra    : a80000080838dfc4 anon_pipe_read+0x7c/0x428
> [   34.161549] Status: 140000e3  KX SX UX KERNEL EXL IE
> [   34.166551] Cause : 40800408 (ExcCode 02)
> [   34.170574] BadVA : 0000000000000000
> [   34.174161] PrId  : 0001b028 (MIPS I6500)
> [   34.178183] Process pipe_race (pid: 170, threadinfo=000000005ca35720, task=00000000e1013890, tls=000000014ebbb780)
> [   34.188568] Stack : a800000802649400 0000000000000000 0000000000000000 a8000008139ffdd0
> [   34.196623]	 0000000000000fba a800000808ee0000 0000000000000001 a8000008130c3e80
> [   34.204676]	 a8000008080d1280 a8000008139ffd58 a8000008139ffd58 1dbd2b22ea1dd500
> [   34.212729]	 a800000802649400 a800000808ee0000 ffffffffffffffea 0000000000000001
> [   34.220783]	 0000000000001000 0000000000000000 00000001200ae518 ffffffffffffffff
> [   34.228836]	 000000fffbe0e530 a80000080837edf4 000000fffbe0e530 0000000000000000
> [   34.236890]	 0000000000000000 0000000000000000 000000014ebb55a0 0000000000001000
> [   34.244943]	 0000000000000001 a800000802649400 0000000000000000 0000000000000000
> [   34.252996]	 0000000000000000 0000400400000000 0000000000000000 1dbd2b22ea1dd500
> [   34.261049]	 00000000140000e3 a800000802649400 a800000802649400 a800000808ee0000
> [   34.269103]	 ...
> [   34.271568] Call Trace:
> [   34.274026] [<a80000080838e01c>] anon_pipe_read+0xd4/0x428
> [   34.279533] [<a80000080837edf4>] vfs_read+0x25c/0x318
> [   34.284607] [<a80000080837faac>] ksys_read+0x104/0x138
> [   34.289763] [<a80000080802b9cc>] syscall_common+0x44/0x68
> [   34.295187]
> [   34.296689] Code: f84000cf  02209825  de020010 <dc420000> d8400004  02002825  0040f809  02802025  f84000c3
> [   34.306504]
> [   34.308099] ---[ end trace 0000000000000000 ]---
> 
> My initial reproducer was the xdp-tools test suite. A standalone
> reproducer would be an lld/scd loop that, when the read is reordered by
> the CPU, triggers a fault. We can achieve this from userspace by
> stressing an anonymous pipe, which uses a mutex. Program used:
> 
> 	// SPDX-License-Identifier: GPL-2.0
> 	// pipe_race.c - reproducer for MIPS LL/SC reordering vs fs/pipe.c
> 	//
> 	// Two userspace processes on an anonymous pipe:
> 	//   parent  = writer: tight write() loop
> 	//   child   = reader: tight read() loop
> 
> 	#define _GNU_SOURCE
> 	#include <assert.h>
> 	#include <errno.h>
> 	#include <sched.h>
> 	#include <signal.h>
> 	#include <stdio.h>
> 	#include <stdlib.h>
> 	#include <string.h>
> 	#include <sys/types.h>
> 	#include <sys/wait.h>
> 	#include <time.h>
> 	#include <unistd.h>
> 
> 	int main(void)
> 	{
> 		long wrsize = 70;	// bytes per write()
> 		long rdsize = 4096;	// bytes per read()
> 		int pfd[2];
> 		char *buf;
> 		pid_t pid;
> 		int ret;
> 
> 		ret = pipe(pfd);
> 		assert(!ret);
> 
> 		pid = fork();
> 		assert(pid >= 0);
> 
> 		if (pid == 0) {			/* reader */
> 			close(pfd[1]);
> 			buf = malloc(rdsize);
> 			assert(buf);
> 			for (;;) {
> 				ssize_t n = read(pfd[0], buf, rdsize);
> 
> 				if (n < 0 && errno == EINTR)
> 					continue;
> 				if (n <= 0)
> 					_exit(n < 0 ? 1 : 0);
> 			}
> 		}
> 
> 		close(pfd[0]);			/* writer */
> 		buf = malloc(wrsize);
> 		assert(buf);
> 		memset(buf, 'x', wrsize);
> 
> 		for (;;) {
> 			ssize_t n = write(pfd[1], buf, wrsize);
> 
> 			if (n < 0 && errno == EINTR)
> 				continue;
> 			if (n != wrsize)
> 				break;
> 		}
> 
> 		kill(pid, SIGKILL);
> 		wait(NULL);
> 		return 0;
> 	}
> 
> Fixes: fbe0fae601b7 ("MIPS: mobileye: Add EyeQ6H support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  arch/mips/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index e2eb9627bd14..5713a7e325dc 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -661,6 +661,7 @@ config EYEQ
>  	select USB_UHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
>  	select USE_OF
>  	select HOTPLUG_PARALLEL if HOTPLUG_CPU
> +	select WEAK_REORDERING_BEYOND_LLSC
>  	help
>  	  Select this to build a kernel supporting EyeQ SoC from Mobileye.
>  
> 

applied to mips-fixes

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
