Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0843E4C87;
	Fri, 26 Jun 2026 12:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782478107; cv=none; b=aWjgJLTk4KSAsJ4+kZc+P9JXWHCL9AKfHKAmoVJIZOSddwiW0Bh0DeredBvpTGToJHYjTOBv6JJL/93DqYuRu+5ZRKl92LKJDrGbFPC0W55Ipzw3A3NV+byPawN2UN2zwWhpXe+Rx7I1nLV3AKG8p9eThoS8lnfKPhqHqBqBXVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782478107; c=relaxed/simple;
	bh=PA80dt2xYrNoJk4Xe8b2EGm9HbRXb8OAlk/dIonJtk4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dbgd1ytggq+bAemjZEt0T2EGHa20maRso1e78T27ohTbInbdsk+9deYOswaQxoJmUbV9qks00nAf4xPnOCSA+BRf5o5xN1GCmVGmZVz3qdNELIH6r7QLlVblPLljPDHu9qiY8rEHvBwVP+cxSqHBrdsW3yUryBhdt3Wb3Z+cb3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COwRB3bH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COwRB3bH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2181F000E9;
	Fri, 26 Jun 2026 12:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782478101;
	bh=8P/TDVoY9rLolsMoac+hbxM6rYfibWe7vkJCayuCM5Y=;
	h=From:Date:Subject:To:Cc;
	b=COwRB3bHX7JbzfEIqHNm5i6LDtPiGuuXL2YxJ7np25HxrHbhL+zI8lar7sEOIb9sU
	 mdzb6UR6tlfMQbGbzS/SRWiJWiX1wXKzqM4fDj+UNRcoECO/KxAcdiyXKAk+d3mlca
	 aVWG0euHCIcCjL+EtZNVXTEsco3861e7yI+YA9loqGf6MABg3MeHGFm/Ab1Q8GEmEl
	 TmOxc/F7En4/KVpRoqF3FFfyMPsEqLzc+GUEFpCTJVRiyGNFpq7TArX8eul9+K9dKx
	 9kAC2dV8R1qWc2qcOfa7e+Yj4zMRnY1dKT0gd1h6kKR1c5fskNa/NxLhsQvKUxr8xy
	 jN17KC/2ipyYQ==
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 26 Jun 2026 14:48:15 +0200
Subject: [PATCH] RFC: ARM: breakpoint: CFI breakpoints only on demand
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-arm32-cfi-bug-v1-1-a467b5050c0b@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ5AMBBA4avIrE1SJRWuIhZaU0biJ62KRNxds
 fwW713gyTF5qJMLHB3seV0isjQBM3bLQMh9NEghlVBSYefmXKKxjDoMmAmrKyXKojIFxGZzZPn
 8fk372wc9kdnfCdz3A7MJL+pxAAAA
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

