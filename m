Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A98832B117
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 05:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781845206; cv=none; b=WOCAwMDN32Ivjc6WFEklz1LVUHqYZ9VhMRmYZByix1Zv/esxW9aU1bmwqYv0uKAXoIn73JKSEqXy7oprUEVJUW2sHkFNobPAhfZrWQL6oCeF+dQeWl+i6Q7HOfBBFoyKrlqhsskF+LHkpWmndoTqyXN2Tnwb7cn5TBl6PQeub14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781845206; c=relaxed/simple;
	bh=ac4BC4lQL4tcOhxgcpL/lmY8D+rgicgYltpw0d+qO7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tr7qyh1cyUL3hXh6Gj5mN/RUuM7aAdxgoZCAb2G9DC8STkxzQONcVJrXfKlsYGIqXHLPpNum2J865rKw4dtqsdu8pTerEKMTFbMSLwm8fD04TE1ZP5/cC2Io3FB64JWk4Rdcbk4Qb+p3Qqd3ml3FGr1C++f3mJlQ5cTxacM8H3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HBxvklIp; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HBxvklIp"
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-c07d76ffd0fso122321066b.0
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 22:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781845203; x=1782450003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7J3h+0tVxChgZOGpCgudfKv/v54zuPYt9gmVmOP/juc=;
        b=HBxvklIp/1WBY1YJrKsWToabCK9fxHGLn272jLaA42aXA9b9rHV0KlzpQW72ZMn8lv
         xXKSTsuwPcYjuvfxZQAveH+ZukGec+rbCu6qDeiWh0UZiHM990pw2DsBlc/ZqCv9jd0y
         dHf5kZOGqLppTf+l27z2wL8C7cFTSrEnEOxL+TKWUOA1PX932Ad2rEhlAh60zq3nNrOE
         ug0/Y9e3S3QJCcswt8GxvF84Jue+tYGDtT1pZ5B2R+JeNB12o8vdWFNwKFFNodexn6Mb
         lUEGRRThtUq/Pwmfr+iAdFcuGo6mRYe/dXHAAAClBFw3LQJNaiW5SUxNy/8abV1JpU/t
         lgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781845203; x=1782450003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7J3h+0tVxChgZOGpCgudfKv/v54zuPYt9gmVmOP/juc=;
        b=XJW7cQaErn8vkksKEvx7O00MD3wEMPIlioO3CahONENxaprr5CLs3MpT50Aa3e23NX
         tQpQBu0diwrVi93YeG/g5ogufNG4n+9m+l6SFuPU42Yzqu24FeYBao83tdq/TYrxnfx4
         4SGK3m+08ZyYGMbE1vF+Idj4RToOuLysmoKRn6cqlxrkWl5EAM554SgFaDUlplA84S2y
         srLPPc2so+bjPa6ps78npAOmae/Gdcs10Z7TQ3GcxRP+DK9/tjyi4jeXURJIcL4YyJ1F
         LaEue3bsyRm+KpN3AMU5wpiaB4rlrdSYExEHarMiZXE/iq+oD7jv+bvwF5C+DEcvL3MZ
         4kpg==
X-Gm-Message-State: AOJu0YxwOj5Ms3xp0ToP0fkMup2XemR1AbnJcO70h2RWwTLYTbBlZ8w3
	dUZgN5+WBLRzhC2/hnqgE/wZx33fPavoV61LpYU5/AhLZ5Cm/ED+ORbF5TWFG7MidjO2j3akkRG
	Y9r6bEJACzFd7
X-Gm-Gg: AfdE7cm1czr9aRkw7vUk562NnQ4v0abSklJUosq181NCNLCW1rQDlOqd+i9Jot9NMJB
	GNlqP0IVH0Rz5EkUOzostpYUpl+4dC5c8zVPnMp/XB1aUbBx7AWFWvLBh56Enkg7hGMQDlLUxrH
	ItEZpXCM1IiE0itpESURI9/OB2bJiSHnldHKOn6hrOniNEOGTWFMm2cBesoKFkLkvAkxkbFfAd+
	RYwaInnE5CCW00xEhd+mENCAaP6ISoMzswP6cFyKGK0VdyGp5LSewQZJv5s2dJad5MA54SJ1mZ/
	sHmWzfKTz8OFize2J75gmiZE4wuD0Pc7NE5e5gJdLe5iO8BW4B1M25tKXLq9OcQGeeB9P9YZDP5
	lI/8VQdbmegI7ZupjlMUTxTOGrMaulc7wLngPHiHCoZMHt2Egtz60y5GCgKXlS1/MEnU7htxGH9
	rONlX6FH96mjDensd3cBSMsamT6ZVU3rA0QRSf
X-Received: by 2002:a17:907:3d06:b0:c08:f5a:a0c4 with SMTP id a640c23a62f3a-c0b753888e4mr41007966b.43.1781845202845;
        Thu, 18 Jun 2026 22:00:02 -0700 (PDT)
Received: from localhost (27-53-24-58.adsl.fetnet.net. [27.53.24.58])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8a888e219fsm1145657a12.21.2026.06.18.22.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 22:00:01 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH stable 6.1 v2 1/2] selftests/bpf: Move get_time_ns to testing_helpers.h
Date: Fri, 19 Jun 2026 12:59:47 +0800
Message-ID: <20260619045949.14013-2-shung-hsi.yu@suse.com>
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

From: Jiri Olsa <jolsa@kernel.org>

commit 3830d04a7401f277185e4439eb259c1b13e76788 upstream.

We'd like to have single copy of get_time_ns used b bench and test_progs,
but we can't just include bench.h, because of conflicting 'struct env'
objects.

Moving get_time_ns to testing_helpers.h which is being included by both
bench and test_progs objects.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Link: https://lore.kernel.org/r/20230809083440.3209381-19-jolsa@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Stable-dep-of: e6c209da7e0e ("selftests/bpf: Check for timeout in perf_link test")
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 tools/testing/selftests/bpf/bench.h                    |  9 ---------
 .../selftests/bpf/prog_tests/kprobe_multi_test.c       |  8 --------
 tools/testing/selftests/bpf/testing_helpers.h          | 10 ++++++++++
 3 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/bpf/bench.h b/tools/testing/selftests/bpf/bench.h
index 669593871483..2c94c57885af 100644
--- a/tools/testing/selftests/bpf/bench.h
+++ b/tools/testing/selftests/bpf/bench.h
@@ -79,15 +79,6 @@ void grace_period_latency_basic_stats(struct bench_res res[], int res_cnt,
 void grace_period_ticks_basic_stats(struct bench_res res[], int res_cnt,
 				    struct basic_stats *gp_stat);
 
-static inline __u64 get_time_ns(void)
-{
-	struct timespec t;
-
-	clock_gettime(CLOCK_MONOTONIC, &t);
-
-	return (u64)t.tv_sec * 1000000000 + t.tv_nsec;
-}
-
 static inline void atomic_inc(long *value)
 {
 	(void)__atomic_add_fetch(value, 1, __ATOMIC_RELAXED);
diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index 0d82e28aed1a..8086e2834646 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -304,14 +304,6 @@ static void test_attach_api_fails(void)
 	kprobe_multi__destroy(skel);
 }
 
-static inline __u64 get_time_ns(void)
-{
-	struct timespec t;
-
-	clock_gettime(CLOCK_MONOTONIC, &t);
-	return (__u64) t.tv_sec * 1000000000 + t.tv_nsec;
-}
-
 static size_t symbol_hash(const void *key, void *ctx __maybe_unused)
 {
 	return str_hash((const char *) key);
diff --git a/tools/testing/selftests/bpf/testing_helpers.h b/tools/testing/selftests/bpf/testing_helpers.h
index 02e8c4efd028..c57349161cfa 100644
--- a/tools/testing/selftests/bpf/testing_helpers.h
+++ b/tools/testing/selftests/bpf/testing_helpers.h
@@ -7,6 +7,7 @@
 #include <stdbool.h>
 #include <bpf/bpf.h>
 #include <bpf/libbpf.h>
+#include <time.h>
 
 int parse_num_list(const char *s, bool **set, int *set_len);
 __u32 link_info_prog_id(const struct bpf_link *link, struct bpf_link_info *info);
@@ -33,4 +34,13 @@ int load_bpf_testmod(bool verbose);
 void unload_bpf_testmod(bool verbose);
 int kern_sync_rcu(void);
 
+static inline __u64 get_time_ns(void)
+{
+	struct timespec t;
+
+	clock_gettime(CLOCK_MONOTONIC, &t);
+
+	return (u64)t.tv_sec * 1000000000 + t.tv_nsec;
+}
+
 #endif /* __TESTING_HELPERS_H */
-- 
2.54.0

