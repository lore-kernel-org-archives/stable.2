Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927D417C211
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 13:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783690219; cv=none; b=aO7gDlT/V/odKLdXxuuiLnyOlvzQneE6p6icMyx5cIRHHeNbKbhyReQc8t+r/4r7SKZGEvF+6oPvrh/rUQ/WuMBIon9+GSJDa216W0HWOwMkffHqJXJpg19qECFrAzdP3VswSsY6A6zOg9U30u90cJ6RxhqL5+eKce+o/AiOb/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783690219; c=relaxed/simple;
	bh=dxSVXPOMJ1RXYpsZyzjHoqWgI/L/oA+5Q3WRsN5ev/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qnCka9z0KBMid91LEjJeLlNH/HBixOl4Oyew+6Aos1xtRT9hWn9J6KYYBKtGFOQGWIy8MGF95mINg+13/wjMMJNcbijApLl+jtI5r7zusJyzq1JKx+2QnQQdjPbSE18ZgW52F0Ed4Xl3/zEBOpdxvicWHE5xTtOFXdr6rIRhKW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ndw1NDDY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ndw1NDDY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96AFD1F000E9;
	Fri, 10 Jul 2026 13:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783690218;
	bh=jXjESfY+f0cmOub3F8/es/EQRsNEqq5gPSj78qN+vUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ndw1NDDYK/jgJteYELnRcog49831CvuU6OboBq7IuMi2Pef5dxjEJvGd8tiuZPKo2
	 2TJyW+0+4BOl1OzenFY66JWcnJ2ZA8zRKLrZZpBu3szD7BPZZhqNdW9P6G19AcF85q
	 /65RVJY5VYVc34I88nU3IP7kRycVb2VIDfjCt0YNglS6DnRKd85DMzmncRZXllOrkf
	 1BoDZ5dB0BvgRJzhm11y1yEcbaWPvXJdQVqmQB+uNWMg1xhvSH8rEmVhHVhBfa0P9c
	 rlpg5qUSj++1m6KfDUVE7j1lGEUASPDupCUYVrDg/DeD4IAOIxBlP9GJjDXoRzHXGr
	 EDwMFihPCRCmQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeremy Linton <jeremy.linton@arm.com>,
	Jarred White <jarredwhite@linux.microsoft.com>,
	Easwar Hariharan <easwar.hariharan@linux.microsoft.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ACPI: CPPC: Suppress UBSAN warning caused by field misuse
Date: Fri, 10 Jul 2026 09:30:16 -0400
Message-ID: <20260710133016.79831-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070952-veto-gradually-3869@gregkh>
References: <2026070952-veto-gradually-3869@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeremy Linton <jeremy.linton@arm.com>

[ Upstream commit 1b1acf2dada0cc3931bb2cb9ff8832edfbee46a1 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/cppc_acpi.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index f86e68863a24ae..30c8799b1a6a8f 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -161,8 +161,13 @@ show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, nominal_freq);
 show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, reference_perf);
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
@@ -970,7 +975,6 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 		 * by the bit width field; the access size is used to indicate
 		 * the PCC subspace id.
 		 */
-		size = reg->bit_width;
 		vaddr = GET_PCC_VADDR(reg->address, pcc_ss_id);
 	}
 	else if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
@@ -1030,7 +1034,6 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 		 * by the bit width field; the access size is used to indicate
 		 * the PCC subspace id.
 		 */
-		size = reg->bit_width;
 		vaddr = GET_PCC_VADDR(reg->address, pcc_ss_id);
 	}
 	else if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
-- 
2.53.0

