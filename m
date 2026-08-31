Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC5B3D16EF;
	Mon, 31 Aug 2026 08:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788164748; cv=none; b=KXqeetSh4WuE1Tqpf9CWajknk5vnCYEdmZBUOcy8Yehi55F4Jqd1deLuGxpJZ8GhVw2Y3dxp9dngWmAWiwi5jMW2XfxiEyGMedQTCQqHT67p9hBU041mE+GzZNs4+1wS/ohFym6g1taLQw9SoUt2ITaSmkj7LkIAz+h9jxlSSYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788164748; c=relaxed/simple;
	bh=xsI3jIwO/Y6Bv18OEqwIndpxG3vHdwMkYo3i4+24WFU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PmeKmjW1xMWSwRpK764v3jG4EN2z4eEYCsPNWkVGyTxGtDCDJaQmG657zK7CYUAMRkTVXf54UuZo8JStFklUDdPl6dfMgyRGUkw6GVdjolvDFtGlIKCPnnO3ypIjFUUCUnXUQUzRjkZJPAOLa5tbbQjTJaipXpBaVhEGEmITjZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=BlFye806; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BlFye806"
Received: from CPC-namja-026ON.localdomain (unknown [4.213.232.18])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6C70220B710C;
	Mon, 31 Aug 2026 01:25:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6C70220B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788164711;
	bh=z45F0iklb5017VL+SXkncmfHBmXiRVtinzOnE76JzOU=;
	h=From:To:Cc:Subject:Date:From;
	b=BlFye806KqZHS9a8yhNLe4okqEKQGfQ8Xx0pFUY6Ts+MgVXvJgoZv6WevydhlhWVu
	 FN6t81AB7LAlULYLDvyTofZW9f6L39XfBWAfMXzOmE29K/skwrp3eCkLdvKJm6id0U
	 O4o6Vi8B1KFIP4PwkuNjgmT+KRCgdUGUYiShNtHc=
From: Naman Jain <namjain@linux.microsoft.com>
To: tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org
Cc: hpa@zytor.com,
	decui@microsoft.com,
	namjain@linux.microsoft.com,
	yunhong.jiang@linux.intel.com,
	ricardo.neri-calderon@linux.intel.com,
	rahul.tanwar@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] x86/init: Initialize wall clock in get_rtc_noop()
Date: Mon, 31 Aug 2026 08:25:28 +0000
Message-ID: <20260831082528.1623843-1-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_rtc_noop() is used when an RTC is unavailable, but leaves its output
argument untouched. When CONFIG_INIT_STACK_ALL_ZERO is not enabled,
timekeeping_init() may therefore receive a nonzero invalid persistent
clock value and warn:
"Persistent clock returned invalid value"

Initialize the output to zero, the documented representation of an
unsupported persistent clock.

Fixes: c311ed6183f4 ("x86/init: Allow DT configured systems to disable RTC at boot time")
Cc: stable@vger.kernel.org
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 arch/x86/kernel/x86_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 252c5827d0634..3b9b41820c84c 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -37,7 +37,7 @@ static void iommu_shutdown_noop(void) { }
 bool __init bool_x86_init_noop(void) { return false; }
 void x86_op_int_noop(int cpu) { }
 int set_rtc_noop(const struct timespec64 *now) { return -EINVAL; }
-void get_rtc_noop(struct timespec64 *now) { }
+void get_rtc_noop(struct timespec64 *now) { *now = (struct timespec64){0}; }
 
 static __initconst const struct of_device_id of_cmos_match[] = {
 	{ .compatible = "motorola,mc146818" },
-- 
2.43.0

