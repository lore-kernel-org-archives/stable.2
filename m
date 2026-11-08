Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794136695;
	b=0kBzvZ+kb4mSGbHeP/PtBJ4eptRJkHmVDYql86/vMd582Cndw6mpP8/qDHLmkRnRMUo5
	 vhGoZ7Bn6jk6++zNXO+O1Jar0AglT1iQvQ0NYhl7QhWPBnBkHt8NQ8dz+usOGNZPXeVva
	 qolQLH3j7aVvvew8AH6TOLBF7rKVrH0t210KX16F3lKZtTD/Y9BYHJFrHEsDfDRzBOtNu
	 4B8I+Owf+t8yBE4LH97WunM/VxnfzXEKm3dtWweuQRBXLEIk6Iv3vWK+PvHDnYBnqFpqP
	 /SI9nlNj8UEfOk9EwNSKVb2vRt4D2CCnvNrVaujfzFc1suXK6DqxDCWrYY0Yi4Nus6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794136695;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=cdwLi7q6otXV/9z7XEcfd3Rd+mPlyC63hV954DkWURg=;
	b=0syGtR/B8tQyLwvjmuvjS+mKzaQFtlVilJqaawWXPWZ/c/xPAAOfJdUyxee5hudgJ05I
	 dRvNNOl2WgCt661cnTJ0RCnM169dchoqf6c++ef5jW2kn7mMlB6/YMbMmLjUw1EmhE6OK
	 yEy68/O1sHexIY3jcFkqwUnjbRsQuS+wm1/r2oR7vo0+uxlI5CRFW8EPmpztAM9wH0DHj
	 F+8EQojdaQ6znwMIPlCd5uhB4Mh5Kw7axag3Z04IrzymSgnjjKmsNJC7erPHG1fSj6mJa
	 WP+N44E9cL7iRmttku13JLDWsC6X27NLRXNi60IcDuGbiJOtA4MEz/ObZbdwlnK9+HA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=X7YqH4Et;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F8E606A31C
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 11:18:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7F8E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=X7YqH4Et
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 029B415A1;
	Sun,  8 Nov 2026 03:18:03 -0800 (PST)
Received: from e127648.arm.com (unknown [10.57.14.94])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 057263F632;
	Sun,  8 Nov 2026 03:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794136686; bh=JvCDQcIrlwTMa1en4Kh5iLK5FCGAw2n6Qr4zYUjTolw=;
	h=From:To:Cc:Subject:Date:From;
	b=X7YqH4EtNyc8Mne6WKe2l/ZUNTCFFGJXXYsFFekA+6AGyOIm5oetPnf+3oleKWfGv
	 3Ikb4UxjvgUJCaCfnp4IQ26feKVlb2Q0+rw79oyCt6p7ZAsM1JQ27LE5AVhjOPSO+B
	 IZAOmGG7sxp86UH/u9DochdiPUgBmhxLDJxBf+cU=
From: Christian Loehle <christian.loehle@arm.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	rafael.j.wysocki@intel.com,
	sumitg@nvidia.com
Subject: [PATCH 5.10] ACPI: CPPC: Validate FFH register fields before hardware access
Date: Sun,  8 Nov 2026 11:17:51 +0000
Message-Id: <20261108111752.2558740-1-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 6b016c5c96448c0a5f09328d37f66562d154a5e5 upstream.

The x86 CPPC FFH accessors construct masks and shift values using the
firmware's Bit Width and Bit Offset without checking that the field fits
in an MSR. A zero-width field or a field extending beyond bit 63 can
therefore cause an invalid shift. The safe MSR accessors only handle an
access fault, not invalid field arithmetic after a successful read.

Also, the 64-bit GAS address is implicitly narrowed to the 32-bit MSR
number. A descriptor with nonzero upper address bits can access a different
MSR from the one described by firmware.

The arm64 AMU counter readers have the same unchecked field arithmetic.
Validate the field bounds before reading a counter, including both
descriptors in the paired counter path.

Dispatch FFH accesses before decoding the GAS Access Size in the common
read and write paths. Otherwise, a large access_width can trigger an
invalid shift in GET_BIT_WIDTH() before the architecture validates its
register. That field has architecture-specific FFH semantics and is not
needed by the generic memory/port accessor on this path.

Validate x86 MSR addresses and share the field-bounds checks between
related accessors within each architecture.

Fixes: a6cbcdd5ab5f ("ACPI / CPPC: Add support for functional fixed hardware address")
Fixes: 68c5debcc06d ("arm64: implement CPPC FFH support using AMUs")
Fixes: f489c948028b ("ACPI: CPPC: Fix access width used for PCC registers")
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
Tested-by: Sumit Gupta <sumitg@nvidia.com>
Link: https://patch.msgid.link/20260916162805.1039247-17-christian.loehle@arm.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
Backport to 5.10.y: Retain the older cppc_msr.c filename. This tree has
only the x86 FFH accessor; the arm64 AMU reader and generic access-width
dispatch changes are not applicable.

Tested on Blackview AMD with a full native build and boot, FFH descriptor
validation, feedback counters and CPU hotplug. The final backport also
passed the extracted-function UBSan regression tests and plain git am onto
base 3a323bc22b881a5bdc1646080f93f5ecb22850bf.

 arch/x86/kernel/acpi/cppc_msr.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/kernel/acpi/cppc_msr.c b/arch/x86/kernel/acpi/cppc_msr.c
index b961de569e7e..37543b21ce94 100644
--- a/arch/x86/kernel/acpi/cppc_msr.c
+++ b/arch/x86/kernel/acpi/cppc_msr.c
@@ -4,6 +4,8 @@
  * Copyright (c) 2016, Intel Corporation.
  */
 
+#include <linux/limits.h>
+
 #include <acpi/cppc_acpi.h>
 #include <asm/msr.h>
 
@@ -14,10 +16,20 @@ bool cpc_ffh_supported(void)
 	return true;
 }
 
+static bool cpc_ffh_reg_valid(const struct cpc_reg *reg)
+{
+	return reg->address <= U32_MAX && reg->bit_width &&
+	       reg->bit_width <= 64 &&
+	       reg->bit_offset <= 64 - reg->bit_width;
+}
+
 int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val)
 {
 	int err;
 
+	if (!cpc_ffh_reg_valid(reg))
+		return -EINVAL;
+
 	err = rdmsrl_safe_on_cpu(cpunum, reg->address, val);
 	if (!err) {
 		u64 mask = GENMASK_ULL(reg->bit_offset + reg->bit_width - 1,
@@ -34,6 +46,9 @@ int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
 	u64 rd_val;
 	int err;
 
+	if (!cpc_ffh_reg_valid(reg))
+		return -EINVAL;
+
 	err = rdmsrl_safe_on_cpu(cpunum, reg->address, &rd_val);
 	if (!err) {
 		u64 mask = GENMASK_ULL(reg->bit_offset + reg->bit_width - 1,
