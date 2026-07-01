Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC05D367B88;
	Wed,  1 Jul 2026 10:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782902541; cv=none; b=KVQvVXttnpPyDlvXGMsqhLGJ5K3wOXK/g43D8ynqRHdeQ+yDcduo9x1u3EwlfDr7UiRcG5+UtQVkyTXYuW9UEyHUQ4LxahYCdkHJtqcCKP7TrTid5n9xW1P3u5D8ZDhz0ph8Q29M9H/FxSc7gADLA83gNiYgH7BUI4bX8WInsOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782902541; c=relaxed/simple;
	bh=fzjQrLnsA9SvCLC7YC7jrA01ELmp0S+JssWOTeT8q4c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pmYoXNdp/lkl63bDQZ0/cZOaMDSc2aOOzEB+kNeFoeEEJ73xQSTaI5PRUMlkPaFugLu+l4E5MkndmhfK05LWERyjIHbJHlDWgWfWTVzcPXUnSw+ZI2lX+ZIwZG0HpYLW1Q7QQVZnG7bA70BezKIVvQr56FXwHAslDtRtlD+VPO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGoo7WJy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGoo7WJy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9651D1F000E9;
	Wed,  1 Jul 2026 10:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782902539;
	bh=OEdz+rLxqF1S83O2UZrN8DXpt6GP29carIftf0rRt7Y=;
	h=From:Date:Subject:To:Cc;
	b=BGoo7WJyNkrgqzu6VOUXDckvrTCsW3w7mIqXj+Vh32lPGMYRsf9pS17ZIBagv+YT/
	 Uuv25d3xrED5FDGBK1y6Ov329R20HrKzZaNcXxNgel1hKKKEMxB/JS6j5sWgidvGqP
	 aCc5JlThWrnOU6mPdwldnrm5wvgm+1ULbavTh1MK9MDRFhvhK9U9edCDI555yNOC/S
	 J6T8CF/3n4Yr1Ckpd/kBDPO2ccqYlmhnOaOexUHOX04hiNzwgFH2WjqE825pr1xCQW
	 3SdjGAEm9x4ax+LOvUTin8CtCK1pPsZz5Aymjx7eFA7FTqM5pmBZa7iMNSLkZvq0My
	 Pt95PS+09enCA==
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 01 Jul 2026 12:42:09 +0200
Subject: [PATCH v3] ARM: breakpoint: CFI breakpoints only on demand
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-arm32-cfi-bug-v3-1-e3c37e2b80a4@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNyw6CMBBFf4V0bc10gJK68j+MC1oHqA8wLTQaw
 r/b4sJo4vIk95w7M0/Okme7bGaOgvV26CPkm4yZru5b4vYUmSGgBImS1+6WIzeN5XpquYBGKwl
 VoUzBonN31NjH2jsc3+wnfSYzpkhadNaPg3uuh0Gk3b92EFzwupCVLqEEA3p/IdfTdTu4lqV4w
 I9egfjVMepKNwqxVDkBfOnLsrwAJCryIPwAAAA=
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
Changes in v3:
- Actually strip the RFC prefix...
- Link to v2: https://patch.msgid.link/20260701-arm32-cfi-bug-v2-1-9bf922593e00@kernel.org

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

