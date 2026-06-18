Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894F1227EA4
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 07:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781768489; cv=none; b=Nnci2xwpL/JCoUEC3Xw7Awp4eR3u97KY5SExvm0gRbB+7PyOVVaPslPGIjjbav4wSIU/o7IScMHgVVmK3hqngPIPd+19l0MKu+yQYLZZvjLbSn1rYe0Vs4mX44X+8TkHjbCgGl/Be5GL8rwgPOZ/40th0otC2UbypKVpLsjdjdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781768489; c=relaxed/simple;
	bh=ScYW2N5cjq2izfTgndEasj5dLBugxLYTWzSBPFyhcUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VD3K6dI6/xN8V/I2kO6PHmusifWhXbu8ZV+zQO2KXb5yF9o39afGtCHx1MOg6/tZHFMPWWj+E4MHwefsCb4FMYHkyEziN8QkJ2OOkZISug8n2JDSAbImDlHKi6mpKuBzT8N2O42JRXVMrZ8anytTRzoWflRc+wiECBWUBM//bp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FEGYsRBN; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FEGYsRBN"
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-c07fcdd75d3so16096966b.1
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 00:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781768486; x=1782373286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u0WP4UbMHgsRq9pCJnlsjfImjR5xHttu6tCXtUn+z5c=;
        b=FEGYsRBNxtklzjLQQZL6XkKF1jYj+MM0rZZuToLhbzJYN+5viPGOwwkR+nTtoX7JXm
         7y/Gy75eNCeSkRss9Pk9/+0ppVbgapz1q62yYhxJn/eHy52Z/HXpbERrz9GzMOTqkyWx
         Vz+BAfuCjGT2iux3rv3IH2lkbxDyG4AAm0v5updEcAE+SUa5H4du5heuN6UNXSb8B9s+
         a8FC33U3oq+1EbMShYspf88sDqidXuxGUQuZ+K5FzHNaoI/Va/ZOULej35TyFeloogyW
         DpFTqirRA7RdJm25P5MUCCOucqclDyvGHN/C6zFEDyfzkUhZcYcqzSPeaqwLQNBCVsEv
         EPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781768486; x=1782373286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0WP4UbMHgsRq9pCJnlsjfImjR5xHttu6tCXtUn+z5c=;
        b=mQWpwj2AAJfhwpVds4ihKf4kvvLkfkZwL7WimaqhXvZwjVMGkGSPFPJZBXGIuarAhp
         nibHUaoUlIQIfBOvurjcdjmb4CpYlLjUBAkwyPwZhZJ+kqcGYcA+y6M1vWqVhLPcu4xx
         GB4yPGqtcfMgboB0MqQvOjQEIO6Lu3tXTWIISJ2PrYq9OXJP1bp0KNouSHM2PC36F7mt
         EJzc9PDIGLmH33yLznyurUGOHRr2jdBFTermRDtipXDWGaWQBH+4P5Wx8cJwMqs5I0Ld
         6OCnSEpt/Ud8+c/yVatqj4VG4rxGn6Dss9N0VlbWpoTi+VPtxY2KzmI4KWidbumU3MwI
         cRXQ==
X-Gm-Message-State: AOJu0YyYKAS+NzsC0bMO4Wy4PUl+aX0Pyzc0/off3w966nJnM/S6bs0f
	ra+0V3RTQ5UEvcQYdutBdv4QSiA7SxJPkRJeYm81ztn1w1so4aPwoM4E40SuB4poXY86z61d+np
	LR77Fwx0HE1hx
X-Gm-Gg: AfdE7cmrhmVwRTMSZMW6FoPFyGvqqqZ7rYh13ABWGuVh94RDrDelQL9x1kzUCCNlb4p
	Fc3PxrGh+adIj6qlIAxozVQdZikSx7RuBkqi9Ycio1oxfKaC1Nxn14DEt11dQUPLutJ05UarrXl
	6lJhm+IrB/0cThiL7I5ncOlkmrlCjbe8a9GMvCZTuF96R1cmbkZwIehCOiq/Na1cWBsnrX3PdAr
	jAbLEgAQ3oFFET6lu0n80SWsgpmZVxVfa3RkRvhwflz1xajrJAJTflb9b1duO/5Y7VhubvJ/utb
	XXcOp+46Xswj809wtBhmhsp3xy4h3Sbi1VZoU3JsrluW8DvSlCsRY+F10QBzr6nuLkY9auEGFUY
	REBEbf2vENI5pl5/pRXpDGSgbTH0oZb4WkOzqWKoc4kaJFWtkiDLnnvPKryh67ElugqJf1lw1yz
	RPPBeqmlEu79zZXZkloursNeRkf4eHM77RCjyx
X-Received: by 2002:a17:907:a28f:b0:bed:eb8b:d404 with SMTP id a640c23a62f3a-c074b27224dmr109123466b.16.1781768485763;
        Thu, 18 Jun 2026 00:41:25 -0700 (PDT)
Received: from localhost (27-53-24-58.adsl.fetnet.net. [27.53.24.58])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84531dbbe7fsm3277519b3a.14.2026.06.18.00.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 00:41:24 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Ihor Solodrai <ihor.solodrai@pm.me>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH stable 6.1 1/1] selftests/bpf: Check for timeout in perf_link test
Date: Thu, 18 Jun 2026 15:41:11 +0800
Message-ID: <20260618074114.16091-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ihor Solodrai <ihor.solodrai@pm.me>

commit e6c209da7e0e9aaf955a7b59e91ed78c2b6c96fb upstream.

Recently perf_link test started unreliably failing on libbpf CI:
  * https://github.com/libbpf/libbpf/actions/runs/11260672407/job/31312405473
  * https://github.com/libbpf/libbpf/actions/runs/11260992334/job/31315514626
  * https://github.com/libbpf/libbpf/actions/runs/11263162459/job/31320458251

Part of the test is running a dummy loop for a while and then checking
for a counter incremented by the test program.

Instead of waiting for an arbitrary number of loop iterations once,
check for the test counter in a loop and use get_time_ns() helper to
enforce a 100ms timeout.

v1: https://lore.kernel.org/bpf/zuRd072x9tumn2iN4wDNs5av0nu5nekMNV4PkR-YwCT10eFFTrUtZBRkLWFbrcCe7guvLStGQlhibo8qWojCO7i2-NGajes5GYIyynexD-w=@pm.me/

Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20241011153104.249800-1-ihor.solodrai@pm.me
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 .../testing/selftests/bpf/prog_tests/perf_link.c  | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/perf_link.c b/tools/testing/selftests/bpf/prog_tests/perf_link.c
index 224eba6fef2e..d734526d6a16 100644
--- a/tools/testing/selftests/bpf/prog_tests/perf_link.c
+++ b/tools/testing/selftests/bpf/prog_tests/perf_link.c
@@ -4,8 +4,12 @@
 #include <pthread.h>
 #include <sched.h>
 #include <test_progs.h>
+#include "testing_helpers.h"
 #include "test_perf_link.skel.h"
 
+#define BURN_TIMEOUT_MS 100
+#define BURN_TIMEOUT_NS BURN_TIMEOUT_MS * 1000000
+
 static void burn_cpu(void)
 {
 	volatile int j = 0;
@@ -32,6 +36,7 @@ void serial_test_perf_link(void)
 	int run_cnt_before, run_cnt_after;
 	struct bpf_link_info info;
 	__u32 info_len = sizeof(info);
+	__u64 timeout_time_ns;
 
 	/* create perf event */
 	memset(&attr, 0, sizeof(attr));
@@ -63,8 +68,14 @@ void serial_test_perf_link(void)
 	ASSERT_GT(info.prog_id, 0, "link_prog_id");
 
 	/* ensure we get at least one perf_event prog execution */
-	burn_cpu();
-	ASSERT_GT(skel->bss->run_cnt, 0, "run_cnt");
+	timeout_time_ns = get_time_ns() + BURN_TIMEOUT_NS;
+	while (true) {
+		burn_cpu();
+		if (skel->bss->run_cnt > 0)
+			break;
+	        if (!ASSERT_LT(get_time_ns(), timeout_time_ns, "run_cnt_timeout"))
+			break;
+	}
 
 	/* perf_event is still active, but we close link and BPF program
 	 * shouldn't be executed anymore
-- 
2.54.0

