Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7A63B47FB;
	Wed,  1 Jul 2026 07:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782889921; cv=none; b=cKjsE/qfsGt+yh+DCPdDnYv+dFqjGTNVx/aE9sW0nUAobxnrlN+3kPSWOtqbWM9jE4a+7Kt2Isk5A8GBXAD1kIVQLMYKCGkbu775tcMKF0yNA4fFCXEqDinadhtf6Xu62C4ymCnrtAAaTP5SGg7wmFAbg96LygNwfYwYQjHUKJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782889921; c=relaxed/simple;
	bh=v/dwYjNfOakXQYw9nm2G9j7Z1jitafW1O2TtqIQUBTw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=m0NXvowR+ZdKZr6K8aaDxEknIXlr8ND6NbXS2NnuElmvPjuduDM6EvYdxyAzjFQz2iwD1Z2GTrFjPR+Q81+JMbSvaf7xjYWt2EvZEYJ0UqF7aqx7GbW3a5TMkbRnQFAYrm85dQ+NwHOkViYhK2KbNcZH9oTYKI+olOkFhlcWjfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8Mp1NXN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8Mp1NXN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9ABD1F000E9;
	Wed,  1 Jul 2026 07:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782889918;
	bh=Dn93ANJFEv/oMU4vPa0WSiqap/D6BCcqx1zjNYHWMYU=;
	h=From:Date:Subject:To:Cc;
	b=Q8Mp1NXNkHGscfTsybc+ruifepYthS6ipdFqKejsqkeAw8k/ESgjhdye8dhCf8zBo
	 mthCgeOMvojdVQ4tMkjUjiBBX5ttEE+wyPtlFCwIvrbRt7x3AyAy0ujVt6GhoUKnzA
	 tZ3V1n3yxDc3qtUXaZBEWc6cYkcGR0zZfFK3rvAsHXfsucFJxJPD45RTXG/sKBTvd3
	 tSbTmguny0R1aPf3hC3mrhWbX2y6CyNnhF8ICa4AoOrVZFbRSXFpZtgkcx7u4mP537
	 oWEmFX9kj89K+AKQZcj7qDqwX/n/KxeLi73jDYkE/p2J0BR3WS/AJcuyVZi9YhbYmV
	 rhhpwssyhuE0Q==
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 01 Jul 2026 09:11:54 +0200
Subject: [PATCH v2] RFC: ARM: breakpoint: CFI breakpoints only on demand
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-arm32-cfi-bug-v2-1-9bf922593e00@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNSw6CQBAFr2J6bZueEYbgynsYFszYQPsB0wNEQ
 7i7gGuXldSrN0FkFY5w2k2gPEqUrl3A7ncQmrKtGeW6MFiyjpx1WOrzaDFUgn6o0VDlc0dZkoc
 Els1LuZL31rsUP46Dv3Ho18hqNBL7Tj/b4WhW7197NGiwTFzmU0opkD/fWVt+HDqtoZjn+QtSp
 Lh4vQAAAA==
X-Change-ID: 20260626-arm32-cfi-bug-10fb960749c4
To: Russell King <linux@armlinux.org.uk>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Kees Cook <kees@kernel.org>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, slipher <slipher@protonmail.com>, 
 Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.15.2

This removes the stub hw_breakpoint_cfi_handler() from ARM, making
it not steal breakpoint type 0x03 (ARM_ENTRY_CFI_BREAKPOINT) unless
CFI is actively used in the kernel.

When not instrumenting with CFI, we fall through to return 1 from
hw_breakpoint_pending() "unhandled fault" so userspace can make use
of this breakpoint.

This of course does not work if userspace want to use CFI and custom
breakpoints at the same time, and CONFIG_CFI does exist as something
users might want to select for their kernel. If this is not good
acceptable we need to think about other ways for CFI to interfer, such
as not using BKPT at all (rather something like BUG()) and back out
the offending patch until the compiler behaviour has changed.

Fixes: c3f89986fde7 ("ARM: 9391/2: hw_breakpoint: Handle CFI breakpoints")
Reported-by: slipher <slipher@protonmail.com>
Closes: https://lore.kernel.org/lkml/kJqktbpLphg_Pk5I5SPptgTLjl3E3eq5mN5UzCslyFj7Q1Irp-wDid4mj5eQVd2iZtRGXgeZd8goq195EkXdjyt864YMc8mVb2B9NGH91NQ=@protonmail.com/
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Trying to solve the CFI bug. Let's see of this first
approach is acceptable for the reporter.
---
Changes in v2:
- Resending as non-RFC so it can be applied as a band-aid.
- Link to v1: https://patch.msgid.link/20260626-arm32-cfi-bug-v1-1-a467b5050c0b@kernel.org
---
 arch/arm/kernel/hw_breakpoint.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index cd4b34c96e35..007023db6a5d 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -929,10 +929,6 @@ static void hw_breakpoint_cfi_handler(struct pt_regs *regs)
 		break;
 	}
 }
-#else
-static void hw_breakpoint_cfi_handler(struct pt_regs *regs)
-{
-}
 #endif
 
 /*
@@ -964,9 +960,11 @@ static int hw_breakpoint_pending(unsigned long addr, unsigned int fsr,
 	case ARM_ENTRY_SYNC_WATCHPOINT:
 		watchpoint_handler(addr, fsr, regs);
 		break;
+#ifdef CONFIG_CFI
 	case ARM_ENTRY_CFI_BREAKPOINT:
 		hw_breakpoint_cfi_handler(regs);
 		break;
+#endif
 	default:
 		ret = 1; /* Unhandled fault. */
 	}

---
base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
change-id: 20260626-arm32-cfi-bug-10fb960749c4

Best regards,
--  
Linus Walleij <linusw@kernel.org>

