Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C200C78C9C;
	Fri, 26 Jun 2026 08:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782462110; cv=none; b=l6xbJuO4+PGkqmUX0eIHR2A+D4bLeRK0SgyzThXEeCs5bJs1GTMsxMbFReAbZbNevZjuRbZLu4gvtYX6TlP+pGA9PO2L+hrqJOEsBc3toLRKHOcDGn7OLxQMJXYy8u4n/CR/4Pj0KESFrwVz4aFwBZc0kb7D+bZ8NLn5Rppxies=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782462110; c=relaxed/simple;
	bh=b1jZY13uZgoIT6DSw59IK1PEEKc0ZANopqJxqciRdr8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oPFdeB+Q5f5hyk9NzD43lsaJGYz4q3PVKBQPMoUQtNqpMMG8jHj9BKlY/7FWgx3Z16DuXbRNW6MSG3yxz3K1smB+aQKbmICcXXPXmjjMt8BXAePTIzosK2DU4bRHXQ9l04HKhMXtCoUjWtCNLcyjsPpJ0F7RWVuP6GQkYICD244=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VuM+Cc/f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VuM+Cc/f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57CAF1F00A3F;
	Fri, 26 Jun 2026 08:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782462109;
	bh=AYNZzZeOmFE2pPGD5v82j7fSWAbJiNgUt8ZRmPqYi4E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VuM+Cc/fPuXXma72yaPxPdO+vp38h0bXCjVwItksCXJ7lJrPe8tdY+C12WvktPaFm
	 V6ShIUNFPfNe9VdBbDw7ysUpWL3bvcn7LNxQEQByhtq/67+wP5tNe7aMk/07Si87hf
	 SjX8wjRjaYYkWAjA/x12jwp7RYimxMYeEBMi7G2tL7W+REwJSRN3ToULO3bQ1lqVbA
	 WqtVZVfkIw8JC8atVLbRiAum395W/ISVrbVQbS+hK9/WEjho5JtH/M5U4jMiWJ5fAK
	 YdXvHfSqTePxsheMu49tuwrzP1naD3E/wXxbFtonUUy7xjITz0V/gxslu7x3yOsDOy
	 zTtBOJqok2gKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93CC839389E8;
	Fri, 26 Jun 2026 08:21:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Disable -Wattribute-alias for clang-23 and newer
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <178246209611.3816447.421614366595878220.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jun 2026 08:21:36 +0000
References: 
 <20260515-syscall-disable-attribute-alias-for-clang-v1-1-9a9d95d41df6@kernel.org>
In-Reply-To: 
 <20260515-syscall-disable-attribute-alias-for-clang-v1-1-9a9d95d41df6@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: linux-riscv@lists.infradead.org, morbo@google.com, justinstitt@google.com,
 nick.desaulniers+lkml@gmail.com, arnd@arndb.de, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, stable@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Nathan Chancellor <nathan@kernel.org>:

On Fri, 15 May 2026 19:35:18 +0900 you wrote:
> Clang recently added support for -Wattribute-alias [1], which results in
> the same warnings that necessitated commit bee20031772a ("disable
> -Wattribute-alias warning for SYSCALL_DEFINEx()") for GCC.
> 
>   kernel/time/itimer.c:325:1: error: alias and aliasee have different types 'long (unsigned int)' and 'long (typeof (__builtin_choose_expr((__builtin_types_compatible_p(typeof ((unsigned int)0), typeof (0LL)) || __builtin_types_compatible_p(typeof ((unsigned int)0), typeof (0ULL))), 0LL, 0L)))' (aka 'long (long)') [-Werror,-Wattribute-alias]
>     325 | SYSCALL_DEFINE1(alarm, unsigned int, seconds)
>         | ^
>   include/linux/syscalls.h:225:36: note: expanded from macro 'SYSCALL_DEFINE1'
>     225 | #define SYSCALL_DEFINE1(name, ...) SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
>         |                                    ^
>   include/linux/syscalls.h:236:2: note: expanded from macro 'SYSCALL_DEFINEx'
>     236 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>         |         ^
>   include/linux/syscalls.h:251:18: note: expanded from macro '__SYSCALL_DEFINEx'
>     251 |                 __attribute__((alias(__stringify(__se_sys##name))));    \
>         |                                ^
>   kernel/time/itimer.c:325:1: note: aliasee is declared here
>   include/linux/syscalls.h:225:36: note: expanded from macro 'SYSCALL_DEFINE1'
>     225 | #define SYSCALL_DEFINE1(name, ...) SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
>         |                                    ^
>   include/linux/syscalls.h:236:2: note: expanded from macro 'SYSCALL_DEFINEx'
>     236 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>         |         ^
>   include/linux/syscalls.h:255:18: note: expanded from macro '__SYSCALL_DEFINEx'
>     255 |         asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))  \
>         |                         ^
>   <scratch space>:16:1: note: expanded from here
>      16 | __se_sys_alarm
>         | ^
> 
> [...]

Here is the summary with links:
  - Disable -Wattribute-alias for clang-23 and newer
    https://git.kernel.org/riscv/c/175db11786bd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


