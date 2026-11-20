Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.218
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160715;
	b=JW5RP0E4Ca9s7WNq2PTAaAdd9A5PmkJA4ignXhLXYka+LTruQm2WY3z9Au3lABGC9zU9
	 a5Pv47qu+3WwSPOXpnQMQY5HZ5Hfl/c8FV1A5YMT3xGLsltnIK3bDhhchg799mmAp0HZz
	 IKXqJ9t44yGO3iNtlFMmuPjEF6lq+JRvI6i1CVmDS315o8y+C6fVq8AOvTCI+FOaEcyNf
	 b5eSsVYh5a8+s74Epc9RKiwGx1w6eA0WjVchy0FezcnBWCGrml8TgE6x+tS86uPL97II/
	 oImeb+t40WS00fCaejQAjHtQ48w9aXWOvO5vAepnUwFuRiR3X/Ig4aZJP28dcKWygsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160715;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ep0ATggb/Y672w60Sb1w5LxlTuBduvlPJl1IN+HAHFs=;
	b=5Ju3NyPIq31nPgUf4kKyeKOw0nlSnZRfhIE/lVDhXC2+gRUekfOv8sob8yaktVyk9rSV
	 V5/+AAG+tJI7yVMNYMpyD9epGMWb9bBoBDDy9KRFkTdjSL+xL+uWdAUnK75euuqqQjDNn
	 SOk8q2UfgeYOBo7tkv3hDXnZPyz4sr2feLPMOsa5+v+xKNhLUfD69hi9Ap/X9IQ+/jkLR
	 ype4Dg+pjxTtlsQlhYjih/sZuLaz7e4uPwUEtiqWs+Ri9C+pIsDTLX7FmxrI/nvIiBTFK
	 iMbDp09CwPGJSuYPg4uck0+DwngEez1+yHsn+UobxdZVXdVPmBl/jgQajTM+/ShbDIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=FbR+xUWp;
	arc=none smtp.remote-ip=95.215.58.218
Received: from mta1.migadu.com (out-218.mta1.migadu.com [95.215.58.218])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCA5606A320
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 07:45:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CCA5606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=FbR+xUWp
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=JHnjnpTpVniuo9xfwgm87vmWr52+uUxiRXAA2RmX6ds=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795160713; v=1; x=1795765513;
 b=FbR+xUWpleG4L8SrinPmARyiWjNxfbRyL8Z0xOHi4DBGipC6EW1iXFawve4t3L83p2jHbMsz
 eZC/RwIZeyMpT26SU7r2wv/NQIveguxV29rPmxBgdsCi1TJN4V2CN1c13hGLt6u8DUh+KfGR9Fj
 cwOoBiVEN1hVuw3SdvwhtFME=
X-Envelope-To: stable@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 158cbfe756fc8433;
	Fri, 20 Nov 2026 07:45:12 +0000
X-Mizu-Trace-ID: 158cbfe756fc8433
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
Subject: [PATCH v2 3/3] selftests/mm: verify ksm_zero_pages is not inherited on fork
Date: Fri, 20 Nov 2026 15:44:59 +0800
Message-Id: <20261120074459.41517-1-xu.xin@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261120074230.40269-1-xu.xin@linux.dev>
References: <20261120074230.40269-1-xu.xin@linux.dev>
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
 .../selftests/mm/ksm_functional_tests.c       | 33 ++++++++++++++-----
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
index c20982b0aff0..321f8abc85f9 100644
--- a/tools/testing/selftests/mm/ksm_functional_tests.c
+++ b/tools/testing/selftests/mm/ksm_functional_tests.c
@@ -655,40 +655,57 @@ static void test_prot_none(void)
 	munmap(map, size);
 }
 
-static void test_fork_ksm_merging_page_count(void)
+static void test_fork_ksm_statistic_count(void)
 {
 	const unsigned int size = 2 * MiB;
 	char *map;
+	char *zero_map;
 	pid_t child_pid;
 	int status;
 
 	ksft_print_msg("[RUN] %s\n", __func__);
 
+	if (ksm_use_zero_pages() < 0) {
+		ksft_test_result_skip("write \"/sys/kernel/mm/ksm/use_zero_pages\" failed\n");
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
+	if (!ksm_get_self_merging_pages() || !ksm_get_self_zero_pages()) {
+		ksft_test_result_fail("KSM failed to merge pages before fork\n");
+		goto unmap_zero;
+	}
+
 	child_pid = fork();
 	if (!child_pid) {
-		exit(ksm_get_self_merging_pages());
+		exit(!!(ksm_get_self_merging_pages() + ksm_get_self_zero_pages()));
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
-		ksft_test_result_fail("ksm_merging_page in child: %d\n", status);
-		goto unmap;
+		ksft_test_result_fail("ksm_merging_pages or ksm_zero_pages is non-zero in child\n");
+		goto unmap_zero;
 	}
 
-	ksft_test_result_pass("ksm_merging_pages is not inherited after fork\n");
+	ksft_test_result_pass("ksm_merging_pages and ksm_zero_pages are reset after fork\n");
 
+unmap_zero:
+	munmap(zero_map, size);
 unmap:
 	ksm_stop();
 	munmap(map, size);
@@ -837,7 +854,7 @@ int main(int argc, char **argv)
 	test_prctl_fork();
 	test_prctl_fork_exec();
 	test_prctl_unmerge();
-	test_fork_ksm_merging_page_count();
+	test_fork_ksm_statistic_count();
 	test_merge_aged_pairs();
 
 	err = ksft_get_fail_cnt();
-- 
2.34.1

