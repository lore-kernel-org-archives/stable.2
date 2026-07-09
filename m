Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BEC35C181
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 17:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783618497; cv=none; b=SOMDBa6B5zxDDUlnrOF1cq3Thq6xeo6PNGsT7J5JS5MBwXgophF1qkSyH2T463HWgVumeMvvu+JPyyD4M/Qhza2QiffnyvtnUigUyYN3HCp1AFQeirdxE4WgN3MExoWFR+LfdCr/y+dSOFNY0ZYzXrIJ0UjJanRmC4CtHyJrf7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783618497; c=relaxed/simple;
	bh=LAjNJTyOOQzVsJlSbsMZ+JJEeRFdFo0DSIIBA9AkveM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kWwP/3nsj3GHeXFfg2Vx663mqnPi8+v8aZNDr2lr5rn+t0Q0JqcLo8c5mmIvkhGyxsMvnMWeij2qkpYpZIhCD+HKNq/+FoqpQg422MZoD1Yr6JTvxkaev7fw2hvnL7S/jpM28Pxj5iyWPrBpleL6l0Fo0M+5akrk1zA30kB6UWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JZLwjTyd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JZLwjTyd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6053F1F000E9;
	Thu,  9 Jul 2026 17:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783618495;
	bh=qZAAgcpt72qEvd7AuvMUwUJ0eizSfw+hDSaW8op8Cnk=;
	h=Subject:To:Cc:From:Date;
	b=JZLwjTydhr3IfhM78Y25d2bmPf6AiYOh/XFC0jREVRXtrW5ODF9GXGNME6Lemr31C
	 uWN1/a5lIuqXvc5KqMwxIcxj7STvjzg6F18jJmvAqw6N8+1x39Cm99gRBQqm50P4p1
	 vt63q2OIPCRo2Ge4HW6R4grlCI3uNyhzWZjgQDCw=
Subject: FAILED: patch "[PATCH] ACPI: CPPC: Suppress UBSAN warning caused by field misuse" failed to apply to 5.15-stable tree
To: jeremy.linton@arm.com,easwar.hariharan@linux.microsoft.com,jarredwhite@linux.microsoft.com,rafael.j.wysocki@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 09 Jul 2026 19:34:52 +0200
Message-ID: <2026070952-veto-gradually-3869@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 1b1acf2dada0cc3931bb2cb9ff8832edfbee46a1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026070952-veto-gradually-3869@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1b1acf2dada0cc3931bb2cb9ff8832edfbee46a1 Mon Sep 17 00:00:00 2001
From: Jeremy Linton <jeremy.linton@arm.com>
Date: Mon, 1 Jun 2026 18:58:08 -0500
Subject: [PATCH] ACPI: CPPC: Suppress UBSAN warning caused by field misuse

The definition of reg->access_width changes depending on the
reg->space_id type.  Type ACPI_ADR_SPACE_PLATFORM_COMM uses
access_width to indicate the PCC region, which can result in a UBSAN
if the value is greater than 4.

For example:

 UBSAN: shift-out-of-bounds in drivers/acpi/cppc_acpi.c:1090:9
 shift exponent 32 is too large for 32-bit type 'int'
 CPU: 61 UID: 0 PID: 1220 Comm: (udev-worker) Not tainted 7.0.10-201.fc44.aarch64 #1 PREEMPT(lazy)
 Hardware name: To be filled by O.E.M.
 Call trace:
  ...(trimming)
  ubsan_epilogue+0x10/0x48
  __ubsan_handle_shift_out_of_bounds+0xdc/0x1e0
  cpc_write+0x4d0/0x670
  cppc_set_perf+0x18c/0x490
  cppc_cpufreq_cpu_init+0x1c8/0x380 [cppc_cpufreq]
  ... (trimming)

Lets fix this by validating the region type, as well as whether
access_width has a value. Then since we are returning bit_width
directly for ACPI_ADR_SPACE_PLATFORM_COMM, drop the code correcting
the size.

Fixes: 2f4a4d63a193 ("ACPI: CPPC: Use access_width over bit_width for system memory accesses")
Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
Tested-by: Jarred White <jarredwhite@linux.microsoft.com>
Reviewed-by: Jarred White <jarredwhite@linux.microsoft.com>
Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Cc: All applicable <stable@vger.kernel.org>
Link: https://patch.msgid.link/20260601235808.1113137-1-jeremy.linton@arm.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index c76cfafa3589..9f572f481241 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -185,8 +185,13 @@ show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, nominal_freq);
 
 show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, wraparound_time);
 
-/* Check for valid access_width, otherwise, fallback to using bit_width */
-#define GET_BIT_WIDTH(reg) ((reg)->access_width ? (8 << ((reg)->access_width - 1)) : (reg)->bit_width)
+/*
+ * PCC reuses the access_width field as the subspace id, so only decode access
+ * size for non-PCC registers. Otherwise, use the bit_width.
+ */
+#define GET_BIT_WIDTH(reg) (((reg)->access_width &&				\
+			     (reg)->space_id != ACPI_ADR_SPACE_PLATFORM_COMM) ? \
+			    (8 << ((reg)->access_width - 1)) : (reg)->bit_width)
 
 /* Shift and apply the mask for CPC reads/writes */
 #define MASK_VAL_READ(reg, val) (((val) >> (reg)->bit_offset) &				\
@@ -1056,7 +1061,6 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 		 * by the bit width field; the access size is used to indicate
 		 * the PCC subspace id.
 		 */
-		size = reg->bit_width;
 		vaddr = GET_PCC_VADDR(reg->address, pcc_ss_id);
 	}
 	else if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
@@ -1129,7 +1133,6 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 		 * by the bit width field; the access size is used to indicate
 		 * the PCC subspace id.
 		 */
-		size = reg->bit_width;
 		vaddr = GET_PCC_VADDR(reg->address, pcc_ss_id);
 	}
 	else if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)

