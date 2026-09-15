Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BD4367F58;
	Tue, 15 Sep 2026 12:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789474230; cv=none; b=ZWpkEPgozk8HKX+F5Y05n6PxaUTkqTSVpHaf4sTJqznMRtbfnnXXwqeZaurtxz79WbPUtTLx5MHxVaZ6FKpp+Kid7UOZG8gkhvLUC9ECxVdRfTVkTVcRd27OH9FbjC56564nOG5gNP1aNv3BXCRQuAiAjavfJnDWbHriaOo4CRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789474230; c=relaxed/simple;
	bh=ZGYe6w2pPCKtnhvFXoWByjdANZZAKeh6RT4pCiKErwM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PyO69HHw1hotA7ydeIjgsjtuF+fSebWNQpYYvQgphuwdqGTxMYJOtiHoqCP+KeJeBPB2PVmOCNjBCJaKP7nTEDOIGgE/iJmAgUx6lf3JlDd1PTMTwIMaw5U7F6vvI6PZRAa3rWTbe/kT4mGHrtyDgMSblm7q0zy62Y46O5MPqLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XMDz9J0i; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XMDz9J0i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=aE
	PJwYLN1OZnlAgx3iNSRwk/r3LrjTJvf045dXFvlQI=; b=XMDz9J0isqY5XLTW+3
	AWHx1by/oCOU5sfGA52zb7FD9GqhZKOPeiaraKsyTLyuPB4c5qJsIKWnvdgAcfXZ
	qMHkTb7WogWOw7ucmPA/tk3FbvWnSzZ3PqKaHSNFYx7tdP+io5AtlCQ3kPZgZ97H
	MvCHE538kA2iu7t/tiaY4Bsyg=
Received: from ubuntu.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDnL7mNNalqxvxTAw--.38045S4;
	Tue, 15 Sep 2026 20:09:52 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: Shyam-sundar.S-k@amd.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	mario.limonciello@amd.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make_ruc2021@163.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] platform/x86/amd/pmc: Fix RTC reference leak in amd_pmc_verify_czn_rtc()
Date: Tue, 15 Sep 2026 20:09:43 +0800
Message-ID: <20260915120943.3988720-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnL7mNNalqxvxTAw--.38045S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFW7ArWUGrW3tr1kuF4Durg_yoW8XFWkpa
	nxCF4fGrZ8CF4UG3WxW3Wqya1Uury2vr4jkFyY9w1ava4SqFn3J3sY9w1aqr1DArWkCF17
	XFZxt395ZFs8W3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUfwIhUUUUU=
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbC0xF2gWqpNZEZFwAA3c

amd_pmc_verify_czn_rtc() opens the RTC with rtc_class_open(), which
takes both a device reference and a module reference on the RTC
driver. rtc_class_close() is the matching release, but it is not
called.

Use a __free() to cleanup call on the declaration

Found by code review.

Fixes: 59348401ebed ("platform/x86: amd-pmc: Add special handling for timer based S0i3 wakeup")
Cc: stable@vger.kernel.org
Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
Changes in v2:
- modified the patch, thanks for developer's suggestions.
---
 drivers/platform/x86/amd/pmc/pmc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
index 6792aa2c6187..b1ad79b22c07 100644
--- a/drivers/platform/x86/amd/pmc/pmc.c
+++ b/drivers/platform/x86/amd/pmc/pmc.c
@@ -14,6 +14,7 @@
 #include <linux/array_size.h>
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/dmi.h>
@@ -646,9 +647,11 @@ static int amd_pmc_wa_irq1(struct amd_pmc_dev *pdev)
 	return 0;
 }
 
+DEFINE_FREE(rtc_class_close, struct rtc_device *, rtc_class_close(_T));
+
 static int amd_pmc_verify_czn_rtc(struct amd_pmc_dev *pdev, u32 *arg)
 {
-	struct rtc_device *rtc_device;
+	struct rtc_device *rtc_device __free(rtc_class_close) = NULL;
 	time64_t then, now, duration;
 	struct rtc_wkalrm alarm;
 	struct rtc_time tm;
-- 
2.43.0

