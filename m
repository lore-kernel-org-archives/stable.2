Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ACB1F4181
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 05:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781845211; cv=none; b=ShYyHcsspYewt4CE/hCfyJ4PqYAndOZ536RBJCOHX6Bd7gRwx54ZNYZQOIye4qCB/97ktAgfpEQfGcpBWepufJ1ItArR3dk9pEUE5nPWeCqjEsnEytCczdBCp4/cEEVXk8J/kM+81eMau9x3Y9WhUtVH/7qfadWm2zMLn2nwLDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781845211; c=relaxed/simple;
	bh=ScYW2N5cjq2izfTgndEasj5dLBugxLYTWzSBPFyhcUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z/U767T/Dtseod57FhUk7pAWPVLLIgL345qMdtQQQmEkeECWLHJSH2kZTa0DFhRG84mKv1i/BVjWJJv34QZtxkMRuCcfdUIaQtq5n0lfZcxmVmQ7h3pzl/ibwbIKEoMpmMDgEaXpys3Kjs2T3n8Sp3J1OxInB+/lJFIM/bOhTXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ta/CwdD5; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ta/CwdD5"
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-695737cf38bso2395413a12.0
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 22:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781845208; x=1782450008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0WP4UbMHgsRq9pCJnlsjfImjR5xHttu6tCXtUn+z5c=;
        b=Ta/CwdD5UPQYrpTiGM4CYIyzyzL1fqGUVGro+3Rd+9p6Y170oTLUZXz9leB17SXuuN
         NTb4/rdrR04pN66Uf6yHaZhFXp09l59qkyPJA5u+OgZrbIxsV3WlBx2MHgK3zFi8cL7Q
         uKYorG15wJvpWdWfY+uLCWooYuD3lITULoDsBd1FO1vdwvuFhMOZMmgKsETCbuKhIkA0
         njkxLgIGCqyG30+aB23NQh4zLr2/WG/A93bpq/aKtL1gs2HsJ+XPZ7qFSVwrFTdgMVYE
         ErUxaz3Vwcl/2aAyPGAtJ9vYRV0MvWx9cyUp/bOJK9c02oPaGj5juvoz82kRqPFs9Gf3
         6K+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781845208; x=1782450008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u0WP4UbMHgsRq9pCJnlsjfImjR5xHttu6tCXtUn+z5c=;
        b=sm6iK7N3DW0zXsWjs6+jCChSpPYiNIz33tA7Nuy2VnU9JUiN2OIhCARM7kd7/I0EkR
         tQABE0r8yXb5ahODzeDqJAILTpHVKVvZIw2j4ZqDPs3rbKzanE7W3u+Z7nMOobtwsue8
         J5O1Z8rqqP8hpyYRLFNwPSk/vP4XNwu+TB4cbSJ9Kewe6doOwbfMsFnoZaMky/efM/Vs
         dq5fx/SBxjqB44U+dhIHLD+5F+vN6vnz5unGhGPL85bqms5T4wK8/vNn+rP0qXO7wjN4
         3tu8bdpcokx0ULAwAw8EcMOBI8fROMoVD74UoGN1392tYRAChIGoKIZohn7LqEf/Nz0v
         mOaw==
X-Gm-Message-State: AOJu0Yz9MKnWBrm51MlU6LYXR6NnDwb5ukSqh1/i1xl3FJa+gW7Wh0tQ
	8NF1vgFCfO2E+zir6qHS64qyVSFR+C+nDAhpyIVK+MzAJAP16DkxscvTaAmW9H2fv/sKvEF2vQ8
	FpHElRunratqN
X-Gm-Gg: AfdE7cli/nBYXrSWTS8NLRKqjdZDPG6L3VU3miQIUOAInQqCgnpf9+IJbU3JNDhCh1U
	I9k3HUWviS6wKQD3b1muoyZv2R7cq0knAHQUbsFFX+4dSkRgZ10+M1Dc6yGLK8dqUUdcIusPGiD
	d5P1uMUdPt7Dafi88pcsIwicAvb9S3cnRdBOvkcYGLHKjlTwTb/3RRnZ3W5vzv6PbFA2xeR7SaG
	RxD6hpHCoCbbDadt6orBiZSZrF3spddtBvvYiHw+D1q+XiQW+f7AE1qaoRhLKERcYK/esF9M42g
	0md1uyK4Ao4rJRuFEP7xKDux9qq/aDx2kuWKZrVhuUg8QfdtylqyUD5xM2TiKIe352C6lvLvZ1L
	JETpC6cuYq1N/RHAkbSfFzwWPHwHnBkS4LmLaw2aRsIM/SLkZUj2AtP27emizndeKv6rmcOKHf0
	YMvEJoAINXd8IieGRDRYWehj9bGWcMUa8L69d1
X-Received: by 2002:a17:907:9811:b0:bfe:ed16:283e with SMTP id a640c23a62f3a-c09903ed213mr100207066b.50.1781845208020;
        Thu, 18 Jun 2026 22:00:08 -0700 (PDT)
Received: from localhost (27-53-24-58.adsl.fetnet.net. [27.53.24.58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7208d67cbsm8969725ad.26.2026.06.18.22.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 22:00:07 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Ihor Solodrai <ihor.solodrai@pm.me>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH stable 6.1 v2 2/2] selftests/bpf: Check for timeout in perf_link test
Date: Fri, 19 Jun 2026 12:59:48 +0800
Message-ID: <20260619045949.14013-3-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619045949.14013-1-shung-hsi.yu@suse.com>
References: <20260619045949.14013-1-shung-hsi.yu@suse.com>
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

