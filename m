Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2833AA9D1
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 09:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784625921; cv=none; b=UMPpJbjpRcmru7cWwobbmZSFh/q/aDl3zJBdfUC6kNvkE7vauzskuHZVY1hHwcxB9m4fzYw3gCfu/nhOHaH6FuRlV6+QNNtkY/IObJV2TTmLoe0rba2CVOJ6au/F9Hrn0D+BJGiwsOkaofzKjmP0jgN0ARFoXko1uzhzK/LkV4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784625921; c=relaxed/simple;
	bh=f0TiAYWQ/Y+DA3jI1NBtIBIPQ4FuEMu1WqBa+euTxic=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=f1/cKYkb2cr1EPncnvcxCblebAtjFWYQkfElo3zOitQdAW4nuRa/BMzB02InVG1ItVNK66IHOO8UXfqBKbd2bhc3oC7ILANPfNPy23F0ufiy6OBYwMHLUnN4bkVP1J+bzDJX438iwXV20dCDUAfW0MiRtSvxwkiJk3Kx0yOS2ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Hm0g//8+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Hm0g//8+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CD01F000E9;
	Tue, 21 Jul 2026 09:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784625919;
	bh=I/pLEycYQ9yTN0tMG2wQ+kzt0vb0DLS+rh1f6hPzOy8=;
	h=Subject:To:Cc:From:Date;
	b=Hm0g//8+GaK/InIJIcJSrLR2LWXOJf7Hwfd5VsKcj4zfASBcpRqTQxlvMAnC8Of2I
	 hbwSLy32O6ZG0e4lEnMTwBoy7Tuu0q2llP8jsxJGyb6ForLYVnEkz117kWk9whXg1F
	 KrbAtr79LXRAYSf8r6xgXB6ao+ZX8+32sddCrlzM=
Subject: FAILED: patch "[PATCH] riscv: vdso: Do not use LTO for the vDSO" failed to apply to 6.12-stable tree
To: thomas.weissschuh@linutronix.de,lkp@intel.com,pjw@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 21 Jul 2026 11:25:10 +0200
Message-ID: <2026072110-prozac-irk-0502@gregkh>
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
git cherry-pick -x ad6dcfa023762e37962f77ee48e752b7570e9440
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072110-prozac-irk-0502@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ad6dcfa023762e37962f77ee48e752b7570e9440 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Date: Wed, 1 Jul 2026 11:21:22 +0200
Subject: [PATCH] riscv: vdso: Do not use LTO for the vDSO
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
Link: https://patch.msgid.link/20260701-riscv-vdso-lto-v1-1-89db0cd82077@linutronix.de
Signed-off-by: Paul Walmsley <pjw@kernel.org>

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

