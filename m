Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28C34AD7CA;
	Fri, 11 Sep 2026 17:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789149118; cv=none; b=QBnaBqB6VS9/nODYlSNrhSoYxFJlMM9GbqigWdJBwX/iY66GfDrjWXbn3SAn4PfO1my0jtuqayiBEbD26C0NUJHzAusFJCbLu8bV1BKVj1UvCB24Z3hLOR+0fUjL0exgTGI/E7L2TgGpTf/rng6o5Wzh2SHwmDdQlrrYkSdPucI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789149118; c=relaxed/simple;
	bh=7Nm6FYo4GXzkpPgmiRgntaMxy35TbQyo6ON4gFJvBiQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Uv1DRc5zvL8fu2YHN0Xc8mc9hR2f1G/WFoeTlZIW2qA2Ch4t2Kb1un52StFaGMklqF9RVkCcYh6g1xdgSwm133ID2Y0qHJNEHXDjDLDlYtFFBdD3/LM+TNG/r96JqHvJtL5mnPuG+HxWHnVYyGeZMMX9R5da1NvlrtoLAnCgj5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=aYhTBS6V; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="aYhTBS6V"
Received: from UbuntuVM-22.efytirfs5hsengjwslc1ligxab.xx.internal.cloudapp.net (unknown [20.112.67.58])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6717920B7166;
	Fri, 11 Sep 2026 10:51:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6717920B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1789149074;
	bh=CORYO3XveuNPmRLRjv4VwC9D8zQGTqIrGY5gmcAeUXQ=;
	h=From:To:Cc:Subject:Date:From;
	b=aYhTBS6VWKld0svBWhZ5XfIek50ulWdB/Tr7+b5OtzSjCl9aod+8HQK0d4cdjxP9p
	 XzROCtnKsIvTMcLv91zU2qU1GmHpPxGPoA2TYQiz6B7Txnz2Iuw1n+8NSCJbR7mbGJ
	 zr/yjzHeIMjESolx3TS7yCqHiLdnasnXZE8uLF1I=
From: Hardik Garg <hargar@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com
Cc: mhklinux@outlook.com,
	ssengar@linux.microsoft.com,
	namjain@linux.microsoft.com,
	romank@linux.microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] mshv_vtl: Check per-CPU register page before mmap
Date: Fri, 11 Sep 2026 17:51:46 +0000
Message-Id: <20260911175146.1370148-1-hargar@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Register-page setup is optional for each CPU. If allocation or
registration fails, mshv_vtl_configure_reg_page() warns and leaves that
CPU's reg_page NULL, but initial context setup continues successfully.
Meanwhile, successful setup on another CPU sets the global
mshv_has_reg_page flag.

mshv_vtl_fault() checks this global flag before selecting the requested
CPU's register page. With mixed setup results across online CPUs, the
check passes even for a CPU with no register page, reaching
get_page(NULL) when userspace faults in that mapping.

Check the selected per-CPU register page before taking its reference and
return VM_FAULT_SIGBUS if it is absent.

Fixes: 7bfe3b8ea6e3 ("Drivers: hv: Introduce mshv_vtl driver")
Cc: stable@vger.kernel.org
Signed-off-by: Hardik Garg <hargar@linux.microsoft.com>
---
 drivers/hv/mshv_vtl_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
index fc993560a45c..3296ab5c0243 100644
--- a/drivers/hv/mshv_vtl_main.c
+++ b/drivers/hv/mshv_vtl_main.c
@@ -912,6 +912,9 @@ static vm_fault_t mshv_vtl_fault(struct vm_fault *vmf)
 		return VM_FAULT_NOPAGE;
 	}
 
+	if (!page)
+		return VM_FAULT_SIGBUS;
+
 	get_page(page);
 	vmf->page = page;
 
-- 
2.34.1

