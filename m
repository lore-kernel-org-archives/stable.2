Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795405560;
	b=v4mWMW3i5UT6dNuZEa8s8vBomqMsiuRyqfHQ30H6WFU5Q7IXUemYR6HF++iFx9iKeeBs
	 fq7HUdURL1KOusqfGkQGmpoujAPHk+a4mPHx0xG4twY9QipxFAv5vT3E/kxjBlSAIJ+GA
	 id2XoBZ5C+ITgTY74yZCo2d71OEdQX672MoD5i6fNQcGJNdc+4y3xBgDMjErJQf3f7ISk
	 EajjnlGa70OpBYjpGwqvKI9mji1AfXW58XTOKbfj1C7ICfuJkURwdVExK3pvkC2QaxOJG
	 s4Lq2w59jGMQkTEN1sdXSyfzUl7OxBuJJ0a9J93vGJuphu6stbTGP37Vvf8owXCYfKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795405560;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/Qa0HZZjs7or3S/BSPmhnoxADvYGuQMQWM8HAvfk0Ro=;
	b=MFoaEx15fQAAsSwTzYpINvAuFitB2FEgVzEjXJZT9PGYKLV4ptNT/g7fNzjyLAJHSgNH
	 7P49pfMoQUi8Fxtt8bWV5fkJ/8SUC1roCF9mUO5282QiXWT0Pt2IEEasjiyYoXSqh9Mz9
	 bsl2oaqDqAqzzoCGsyLMHZNXUeBA5E7jArKJVP+dYYs+8EkAs8X2RDb322Bf1GxzQe2kP
	 dijROThsVyDajf33BqKJvTBAdv3o9CpxSVjT2NDqgTmVgJ/WBilex9gOw4D+GJ8wtztBz
	 W+BxzqYA8jEnFSHjv0Z2i+tLOMaOigCVsTJEg33kYT769WXVhgaUKFswq9aJ/WdCPaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=AZ6GIxFi;
	arc=none smtp.remote-ip=95.215.58.219
Received: from mta1.migadu.com (out-219.mta1.migadu.com [95.215.58.219])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF805606A31E
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 03:45:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF805606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=AZ6GIxFi
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ieS6icOUU8W2/q+0+Ez1Zj6/vTJxsNmx9lTsgVr45kc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795405557; v=1; x=1796010357;
 b=AZ6GIxFiXyYvb3yzi1ie45t+JCI8YjlvB7igI1mXeblpvO+QZ/ykV/Alp2a/NQ1lwyR+1lqe
 d/L8Hf30fcByxeOHETETqcQaHFGr8nabFXdCVWMSS6E6kQ97WzY0GuAwQu59vjbqmZXD0O2/8Wp
 I9zJ1ylSjQZyHK+DgcMK4thI=
X-Envelope-To: stable@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 1cf38e753e5e894b;
	Mon, 23 Nov 2026 03:45:57 +0000
X-Mizu-Trace-ID: 1cf38e753e5e894b
X-Migadu-Flow: FLOW_OUT
From: "Xu Xin (vivo)" <xu.xin@linux.dev>
To: xu.xin@linux.dev
Cc: akpm@linux-foundation.org,
	chengming.zhou@linux.dev,
	david@kernel.org,
	donettom@linux.ibm.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: [PATCH v3 3/3] selftests/mm: verify ksm_zero_pages is not inherited on fork
Date: Mon, 23 Nov 2026 11:45:48 +0800
Message-Id: <20261123034548.237302-1-xu.xin@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261123034136.209410-1-xu.xin@linux.dev>
References: <20261123034136.209410-1-xu.xin@linux.dev>
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

Extend test_fork_ksm_merging_page_count() to enable use_zero_pages and
merge zero pages alongside non-zero pages before fork(), verifying that
neither ksm_merging_pages nor ksm_zero_pages is inherited by the child.

Signed-off-by: Xu Xin (vivo) <xu.xin@linux.dev>
---
 .../selftests/mm/ksm_functional_tests.c       | 44 +++++++++++++++----
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
index b871d5656688..0e128c579d5c 100644
--- a/tools/testing/selftests/mm/ksm_functional_tests.c
+++ b/tools/testing/selftests/mm/ksm_functional_tests.c
@@ -655,45 +655,71 @@ static void test_prot_none(void)
 	munmap(map, size);
 }
 
-static void test_fork_ksm_merging_page_count(void)
+static void test_fork_ksm_statistic_count(void)
 {
 	const unsigned int size = 2 * MiB;
+	long merging_pages, zero_pages;
 	char *map;
+	char *zero_map;
 	pid_t child_pid;
 	int status;
 
 	ksft_print_msg("[RUN] %s\n", __func__);
 
+	if (ksm_use_zero_pages() < 0) {
+		ksft_test_result_skip("Enabling use_zero_pages failed\n");
+		return;
+	}
+
 	map = mmap_and_merge_range(0xcf, size, PROT_READ | PROT_WRITE, KSM_MERGE_MADVISE);
 	if (map == MAP_FAILED)
 		return;
 
+	zero_map = mmap_and_merge_range(0x00, size, PROT_READ | PROT_WRITE, KSM_MERGE_MADVISE);
+	if (zero_map == MAP_FAILED)
+		goto unmap;
+
+	merging_pages = ksm_get_self_merging_pages();
+	zero_pages = ksm_get_self_zero_pages();
+	if (merging_pages < 0 || zero_pages < 0) {
+		ksft_test_result_skip("read KSM stats failed\n");
+		goto unmap_zero;
+	}
+
+	if (!merging_pages || !zero_pages) {
+		ksft_test_result_fail("KSM failed to merge pages before fork\n");
+		goto unmap_zero;
+	}
+
 	if (ksm_pause() < 0) {
 		ksft_test_result_fail("Stop ksmd from running failed\n");
-		goto unmap;
+		goto unmap_zero;
 	}
 
 	child_pid = fork();
 	if (!child_pid) {
-		exit(!!ksm_get_self_merging_pages());
+		merging_pages = ksm_get_self_merging_pages();
+		zero_pages = ksm_get_self_zero_pages();
+		exit(merging_pages != 0 || zero_pages != 0);
 	} else if (child_pid < 0) {
 		ksft_test_result_fail("fork() failed\n");
-		goto unmap;
+		goto unmap_zero;
 	}
 
 	if (waitpid(child_pid, &status, 0) < 0) {
 		ksft_test_result_fail("waitpid() failed\n");
-		goto unmap;
+		goto unmap_zero;
 	}
 
 	status = WEXITSTATUS(status);
 	if (status) {
 		ksft_test_result_fail("ksm_merging_page in child: %d\n", status);
-		goto unmap;
+		goto unmap_zero;
 	}
 
-	ksft_test_result_pass("ksm_merging_pages is not inherited after fork\n");
-
+	ksft_test_result_pass("ksm_merging_pages and ksm_zero_pages are reset after fork\n");
+unmap_zero:
+	munmap(zero_map, size);
 unmap:
 	ksm_stop();
 	munmap(map, size);
@@ -842,7 +868,7 @@ int main(int argc, char **argv)
 	test_prctl_fork();
 	test_prctl_fork_exec();
 	test_prctl_unmerge();
-	test_fork_ksm_merging_page_count();
+	test_fork_ksm_statistic_count();
 	test_merge_aged_pairs();
 
 	err = ksft_get_fail_cnt();
-- 
2.34.1

