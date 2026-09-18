Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CE12DA775;
	Fri, 18 Sep 2026 07:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789717064; cv=none; b=h8UyTyJSrg3V2uYkSUUNz1IM5oSCOjw7Mskc4hiXhCWuyCZr4zUprb3ghXPmrRJjSX9aPIRCiRXd7FjSpofZOSsOEXjFSJBI2w7RDYBTkfZMVonBRwaXN3DCURz9X7B+1oLql/jPZEPgyt/KmTE1k1WuValp3CkCS9I4na3C0+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789717064; c=relaxed/simple;
	bh=zEwIv5nV9kBlQtke+WYPJv2JXm3NHjpHCgQ0avWbAUU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kU6dYlqkqhkBQo7i3dObkYXi6wRvE7A7sbej65EEXwLzKeTFHjZwnLntDuu0uApgx1TOSWddaCAqDjWcdTp536LZnAnotf9HVilgSHKh2epEl1zqQfg2MqSu9dyUpFMZo+M5cmjBLrsNg6oV33s4v5N+KFVj20ReswVbsRH42UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nb4QuX5P; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nb4QuX5P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ie
	PUHtWxOWzcjYvDTkI/eozzGuxXVCGuAvz56k1anIs=; b=nb4QuX5Ppt1sxIBsLK
	AIswLUmukSIKMEnbNs55s1+1Tz+rqUSOgkqf0zgcIh5WGjiw7xoMy3DIu8JQoSbE
	EGlO0G5iQ/IEHa3w6T4sEnVmRuwvuRnHUpKPEsS/QC+jNrGF+OrgAd4zUepQ2/wo
	wX0Yz1OLn7OHxk0uF+zHrxJlw=
Received: from thinkpadx13gen2i.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgAHJZAU6qxq7+01AA--.4395S2;
	Fri, 18 Sep 2026 15:36:52 +0800 (CST)
From: Zongmin Zhou <min_halo@163.com>
To: jtaubepe@redhat.com
Cc: alex@ghiti.fr,
	aou@eecs.berkeley.edu--cc=palmer@dabbelt.com,
	pjw@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Zongmin Zhou <zhouzongmin@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] riscv: hwprobe: use _BITULL() rather than BIT() in MIPS vendor uapi header
Date: Fri, 18 Sep 2026 15:36:50 +0800
Message-Id: <20260918073650.42586-1-min_halo@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CADRr4beOuFxa4A+CCLC8MFAALKBUptLaVANvDb6ZS42m_UMrbQ@mail.gmail.com>
References: <CADRr4beOuFxa4A+CCLC8MFAALKBUptLaVANvDb6ZS42m_UMrbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgAHJZAU6qxq7+01AA--.4395S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFW3Zry3Zw13JFWrGw4UArb_yoW8Xr1DpF
	Z8ursYgrWrWr1xCF9rGF1xZryaqw4rKw4YgFWUuw48J39aqry0qw4Yvw43Z3WUtF4vqF4j
	gFn8Cry0yayDA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnzVbUUUUU=
X-CM-SenderInfo: pplqsxxdorqiywtou0bp/xtbC9BSFMWqs6hQwfgAA3i

From: Zongmin Zhou <zhouzongmin@kylinos.cn>

BIT() is a kernel-internal macro that is not available to userspace, but
the MIPS vendor extension uapi header uses it without defining or
including it. Any userspace program that includes this header and uses
RISCV_HWPROBE_VENDOR_EXT_XMIPSEXECTL fails to build.

Use _BITULL(0) from linux/const.h instead, which keeps the value at 1,
so there is no ABI change.

Fixes: bb4b0f8a1bcb ("riscv: hwprobe: Add MIPS vendor extension probing")
Cc: stable@vger.kernel.org
Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>
Reviewed-by: Jesse Taube <jtaubepe@redhat.com>
---
Changes in v2:
- Add Cc: stable@vger.kernel.org as suggested by Jesse Taube.
- Collect Reviewed-by from Jesse Taube (no code changes).

 arch/riscv/include/uapi/asm/vendor/mips.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/uapi/asm/vendor/mips.h b/arch/riscv/include/uapi/asm/vendor/mips.h
index e65ab268b265..a31c23afe74f 100644
--- a/arch/riscv/include/uapi/asm/vendor/mips.h
+++ b/arch/riscv/include/uapi/asm/vendor/mips.h
@@ -1,3 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 
-#define RISCV_HWPROBE_VENDOR_EXT_XMIPSEXECTL	BIT(0)
+#include <linux/const.h>
+
+#define RISCV_HWPROBE_VENDOR_EXT_XMIPSEXECTL	_BITULL(0)
-- 
2.34.1


No virus found
		Checked by Hillstone Network AntiVirus

