Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9194A4409;
	Wed, 14 Oct 2026 20:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792011087; cv=none; b=gCDBC+cIrFBAKpQOyBtgmYF9S5JeYhgabBxAX7cN4LYyWZvYAID1/zk/MHxiNeILzz27jTgviYlNVGUaLMcF+9gjVH98nCW2pzy9FbH/tKTT0Ab1Lbm8sotvFpn578oM04Hp/QTsgRZStK6tW2/sjvPXNaxGuCJ0DYb0RtWa2i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792011087; c=relaxed/simple;
	bh=opR9t8roldITkJx3YKawkdhYtADs8eqqUo5HEesWZ/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VfVnWre7BKcZtVKGD0Z+P6kMAhbNTiMBwwEy8q4NifB70NKAEKePvzLBEV3W5a+vjrhpkkhrT3XJKSo+ZsoUilYjxWqjOba1QU61ja6aCVu7r4azXeACuUI+M/qX3Qp4xkuHKOhZECNnRYGSfLuFB9r6UiE2kjwZ4nsC46Ziklw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=kZwmc8yG; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="kZwmc8yG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1792011079;
	bh=opR9t8roldITkJx3YKawkdhYtADs8eqqUo5HEesWZ/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kZwmc8yG5GWN/GX1hy4fjx5GyK45weOb++UsXnXu+0R83P6yzMr6WI4Rq44fkpJiW
	 3O3kHJtRdopnxsVV/LzorRp/lmwXlMqymC/tsF3Ycars/wVdloQHsbnmbjGrSnxjND
	 igMynXucs2hcCbABRYb6k9uiq7yBYhjhFCCDNZlg=
Date: Wed, 14 Oct 2026 22:51:18 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Sasha Levin <sashal@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Willy Tarreau <w@1wt.eu>, 
	Wake Liu <wakel@google.com>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 5/5] selftests/size: use nolibc startup and syscall
 wrappers
Message-ID: <e37521b1-a02f-49ac-a6b9-a0df08919bbf@t-8ch.de>
References: <20261014200127.1363472-1-sashal@kernel.org>
 <20261014200127.1363472-6-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261014200127.1363472-6-sashal@kernel.org>

On 2026-10-14 16:01:27-0400, Sasha Levin wrote:
> get_size provides its own _start and is linked statically against the C
> library with -nostartfiles. That combination assumes startup and TLS
> details that vary between architectures and C library versions: errno
> lives in thread-local storage that is never set up, and the static link
> expects symbols from the skipped startup files. CI builds have failed
> with undefined _init/_fini on ARM with clang and an undefined _DYNAMIC
> on LoongArch.

I get the _DYNAMIC failures even on my boring x86_64 distro setup.

> Build the test with the in-tree nolibc instead. nolibc provides the
> startup code, so the test returns from main(), and it provides the
> write() and syscall() wrappers without the TLS errno problem. A failing
> sysinfo() is now reported as a TAP failure instead of crashing the
> test. Keep the static link and the existing TAP output.
> 
> Since the test no longer uses the system C library headers, the kernel
> UAPI headers have to be installed before it is built. Add the headers
> target as an order-only prerequisite, as nolibc-test does, so that a
> standalone build installs them. Link libgcc only when the selected
> compiler is GCC, which needs it for division helpers on ARM, and detect
> that from the compiler rather than from LLVM so that CC=clang builds do
> not try to link a libgcc that clang does not provide.
> 
> nolibc does not support arc, csky, microblaze, nios2 or xtensa,

yet...

> so the
> test can no longer be built for those architectures. This conversion
> also makes the separate i386 vDSO workaround proposed for get_size
> unnecessary.

Nobody seems to build the selftests for these architectures anyways.

> Link: https://lore.kernel.org/r/20260929043637.1917707-1-wakel@google.com
> Fixes: 3ce51050fadd ("selftest: size: Add size test for Linux kernel")
> Cc: stable@vger.kernel.org # 6.18.x

I am not so excited about Fixes and Cc: stable.
But if it breaks, it will land on your plate anyways :-)

> Signed-off-by: Sasha Levin <sashal@kernel.org>

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>

> ---
>  tools/testing/selftests/size/Makefile   |  9 ++++++-
>  tools/testing/selftests/size/get_size.c | 33 +++++++------------------
>  2 files changed, 17 insertions(+), 25 deletions(-)

(...)

> --- a/tools/testing/selftests/size/get_size.c
> +++ b/tools/testing/selftests/size/get_size.c

(...)
 
> -#include <sys/sysinfo.h>
> -#include <unistd.h>
> -#include <sys/syscall.h>
> -
> -#define STDOUT_FILENO 1
> +#include <nolibc.h>

Note:

The newfangled way to use nolibc would be to stick to the regular libc
includes:

#include <unistd.h>
#include <sys/syscall.h>
#include <linux/sysinfo.h>

But what you have also works, obviously.

> +#include <linux/sysinfo.h>

(...)
