Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3713F4824;
	Wed,  1 Jul 2026 09:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782897692; cv=none; b=XULRrDzYTlyKjxTfzD/x9eja04E3wWBYFSXC+gxZPn21knpb55ML4Oi80iiuiHCe+wzP9/KID8kE3SNq13Fm6FlBPImHQ7/wrB5RMV0MSsrfhhFhzrEbFtD/sUb6hHgf3HIH2hAu2iY0zCNUFk36C+N8ALorIN1t85qvFExJWGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782897692; c=relaxed/simple;
	bh=x1MoegCY6YEEWIzYOP6qLgLJzGXz39X22orJAX7mHVY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l/SveEE9sLnYVwc0h8vMJ8dwFHrfwmacVsydrA9gkAJqmS72Ri76TIwsMLA5tE/8OQ79iDL5FuVtNh/H8f4rWHhxELbabeBfDzrzrssfU1cNpz79IwvTPMhMPS8Z2nEZbk4HaWNj1EnAAglTBO8zZlhR15gfl++1UlXk4uPkMo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qLExgf/z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iSBZwsbw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qLExgf/z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iSBZwsbw"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782897687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RZTHPrI4IM81/CExa8gXGUexuM3Q0SH52YtJqQ1ZRIM=;
	b=qLExgf/zidv5RV/7Q70dezrp0I6TovxjLZ/Uxy+mzJsItwLmbULuMcWXtMFp8fq/LKp9pu
	+94Bu66jpRQTFhBMeOjGNpEh5sPSpH5cUnN9b+IqTx/XDybqGJLJjCFCmi+Pi5dxjwhoVi
	4LpWqldjLGa8cc6C89V/bKi3kD0wL9Mjdvr2i44SI7ghx2TNpgGEp8/U9HrMMZ7p/aydBD
	l8TaoyqbgaIhVm3UXTp0q/VU3VWqV4/75xBeCMZ0FKram8UwNwxsvoKnianF+wkQ6qltiP
	ZBww19KqrlH7BZWnnQ49io+WhrkllBEJKbbZ5uz0mIbvl6oG4yJYLjH+s5TOGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782897687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RZTHPrI4IM81/CExa8gXGUexuM3Q0SH52YtJqQ1ZRIM=;
	b=iSBZwsbwunqy0uUPMJoFZyYyGUDsylfBmObKjuv0FrRLC+aw3cyH3ZNwiQ1BiR2nj+Pg2h
	xFG2Tjdug+lz3aBw==
Date: Wed, 01 Jul 2026 11:21:22 +0200
Subject: [PATCH 1/2] riscv: vdso: Do not use LTO for the vDSO
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260701-riscv-vdso-lto-v1-1-89db0cd82077@linutronix.de>
References: <20260701-riscv-vdso-lto-v1-0-89db0cd82077@linutronix.de>
In-Reply-To: <20260701-riscv-vdso-lto-v1-0-89db0cd82077@linutronix.de>
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Conor Dooley <conor.dooley@microchip.com>, Wende Tan <twd2.me@gmail.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Nam Cao <namcao@linutronix.de>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 kernel test robot <lkp@intel.com>, stable@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782897683; l=1567;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=x1MoegCY6YEEWIzYOP6qLgLJzGXz39X22orJAX7mHVY=;
 b=zQHfOUpebyL5rgX0Mbz4u0oHJzSMpORSRNHVgS/rlmQKMgOzBBwelbAYq7OBLvRTre7APEoOu
 83oTc3bpBwYCq4Rcg+nXy+pGCNj4CT+NZ6E85GjoujQqZsytYVSPsc4
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

With LTO enabled the compiler assumes that the vDSO functions are not
used and optimizes them away completely. Currently this happens to
__vdso_clock_getres(), __vdso_clock_gettime(), __vdso_getrandom(),
__vdso_gettimeofday() and __vdso_riscv_hwprobe().

Disable LTO for the vDSO, as these functions are hand-optimized anyways.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202606301855.WvkSC4kD-lkp@intel.com/
Fixes: 021d23428bdb ("RISC-V: build: Allow LTO to be selected")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/riscv/kernel/vdso/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index a842dc034571..43ee881f6c6f 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -69,9 +69,9 @@ CPPFLAGS_$(vdso_lds) += -DHAS_VGETTIMEOFDAY
 endif
 
 # Disable -pg to prevent insert call site
-CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS)
-CFLAGS_REMOVE_getrandom.o = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS)
-CFLAGS_REMOVE_hwprobe.o = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS)
+CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS) $(CC_FLAGS_LTO)
+CFLAGS_REMOVE_getrandom.o = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS) $(CC_FLAGS_LTO)
+CFLAGS_REMOVE_hwprobe.o = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS) $(CC_FLAGS_LTO)
 
 # Force dependency
 $(obj)/$(vdso_o): $(obj)/$(vdso_so)

-- 
2.55.0

