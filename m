Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033C84C042B
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446464; cv=none; b=AgDxUYUFZBY6laVmjBdI4fSZEzkSAfbMLUncCr/7JzNAuM5MDWFXMCjNhiL8P5l3AJGxCW/Whrx/Uh2hT0Lkclw/92YLBwZQUOWL8QqF9YZPHEjTGvzWmsxgnTe82KHKVi+mPE3NPgfDVxunRszjVDa8Z1vVnS8Y3pL/qF5hcfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446464; c=relaxed/simple;
	bh=spn7yREXxT0P1W/fB+dLKR4A2YuQru24ObS2dcssqAE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NqbxxKg304rCB8N2Dex2tsvIDEkSZPmKvxrGgWHExYit9lUGwUW0e8WQ50vs2FpanBDYiQJ3ZHc/7Sw8YIyhBm6/ZGeIXaCskB7PmFXcIsGOtPDyajpUrKioHdNCUi5hk9XYqTCILDcBj7v6JJ82+zt4DGqnqaWjm0f3jmFyxlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EbQs5m2C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EbQs5m2C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE861F00A3D;
	Thu,  3 Sep 2026 14:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788446456;
	bh=EOT0Nj1wkyiTseZNzVREVgOtZGHWK7etjcd+kykDj3E=;
	h=Subject:To:Cc:From:Date;
	b=EbQs5m2CaQ6CicAeRWKbOF39f2JdmiG09dPdvoszQdhpoAr7JWCglgYqzIktMzLYa
	 w+q72Qsm8oqWcImE+PfHoc2SmaN0mpv7RRVpcxR0GmQ8XNbmfucfANsMKdqfTRWcyD
	 sYd0BaNZ65I/ghTG0qK9KKv5zJYitfgDyEZBWN0w=
Subject: FAILED: patch "[PATCH] riscv: acpi: Handle LPI architectural context loss flags" failed to apply to 6.6-stable tree
To: peixin.xie@linux.spacemit.com,dlan@kernel.org,lihuisong@huawei.com,pjw@kernel.org,sudeep.holla@kernel.org,sunilvl@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:20:02 +0200
Message-ID: <2026090302-tropics-obstinate-fff5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 7e4cb63d61a7e0bef20f0d00e831c7fac06e4a1c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090302-tropics-obstinate-fff5@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7e4cb63d61a7e0bef20f0d00e831c7fac06e4a1c Mon Sep 17 00:00:00 2001
From: Peixin Xie <peixin.xie@linux.spacemit.com>
Date: Fri, 7 Aug 2026 19:24:32 -0600
Subject: [PATCH] riscv: acpi: Handle LPI architectural context loss flags

Commit 4785aa802853 ("cpuidle, ACPI: Evaluate LPI arch_flags for
broadcast timer") replaced the generic nonzero check for LPI
architectural context loss flags with arch_get_idle_state_flags().
RISC-V does not implement the helper, so it falls back to the stub
that returns 0. Consequently, CPUIDLE_FLAG_TIMER_STOP is not set when
an LPI state loses the hart timer context, preventing cpuidle from
using a broadcast timer for that state.

Implement the RISC-V helper and map the hart timer context loss flag
to CPUIDLE_FLAG_TIMER_STOP.

Fixes: 4785aa802853 ("cpuidle, ACPI: Evaluate LPI arch_flags for broadcast timer")
Cc: stable@vger.kernel.org
Acked-by: Sudeep Holla <sudeep.holla@kernel.org>
Reviewed-by: Yixun Lan <dlan@kernel.org>
Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
Reviewed-by: Huisong Li <lihuisong@huawei.com>
Signed-off-by: Peixin Xie <peixin.xie@linux.spacemit.com>
Link: https://patch.msgid.link/20260803-riscv-acpi-lpi-timer-v3-1-520fa13732f5@linux.spacemit.com
Signed-off-by: Paul Walmsley <pjw@kernel.org>

diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
index d59bd06347cc..980aa11d7741 100644
--- a/arch/riscv/include/asm/acpi.h
+++ b/arch/riscv/include/asm/acpi.h
@@ -12,6 +12,8 @@
 #ifndef _ASM_ACPI_H
 #define _ASM_ACPI_H
 
+#include <linux/cpuidle.h>
+
 /* Basic configuration for ACPI */
 #ifdef CONFIG_ACPI
 
@@ -67,6 +69,23 @@ int acpi_get_riscv_isa(struct acpi_table_header *table,
 
 void acpi_get_cbo_block_size(struct acpi_table_header *table, u32 *cbom_size,
 			     u32 *cboz_size, u32 *cbop_size);
+
+/*
+ * RISC-V Functional Fixed Hardware Specification Version v1.0.1,
+ * Chapter 3.1.2, Table 4: Arch. Context Lost Flags
+ */
+#define RISCV_LPI_HART_TIMER_CTXT_LOST		BIT(0)
+
+static inline unsigned int arch_get_idle_state_flags(u32 arch_flags)
+{
+	if (arch_flags & RISCV_LPI_HART_TIMER_CTXT_LOST)
+		return CPUIDLE_FLAG_TIMER_STOP;
+
+	return 0;
+}
+
+#define arch_get_idle_state_flags arch_get_idle_state_flags
+
 #else
 static inline void acpi_init_rintc_map(void) { }
 static inline struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu)

