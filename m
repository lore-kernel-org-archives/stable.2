Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795405546;
	b=M7mAzgbFbxuOJBuD9dRsAfpagBZsyANFG43ZomVff6ceBFFPO0f8qYuTNaKw5h0u3gGS
	 bvrTCBl6Ky1AYwbznjigPo+NswIdVIfD8zUXJAdyKgIaAcn/nfSr0O3VLhvqKR/GZtiLA
	 OuRUlmjpakXtwGm24Lg1KQtArNSPLidwbWJYbMpvJeZCr0v1m288hFEf7NC1I0TxKAp+i
	 udcgod3D7vVJYCP010kptYlDBbnIlKIAhP5dpe8fzmdsADfs2WognqyAh7u+AUN7VkObi
	 lss1dL/g+j0TY4+/fI0BKHWi6EVqckhw2GYGkttQsoLZkD2SeiNQ2lzpfviFlUgIc7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795405546;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=htJ+G2m31J9SRlk7O48P5yvgT1ieAXPqPN86Pmytgdo=;
	b=zfIUa1gsFsK8j5RVFB/YOrc01LE4y7J/E+5NmM5vTiHO00r0mm8XYPFAwuUbEcxcMD5n
	 ko2Fvm14nePmV9ImwapW71+/+8pblDeUT7f+A0GqFfQr51yY53p7BzyeqVIWFg+2/nIoB
	 Sr43Fjo+jb+ifcKUkZXfojZysL489it7Uap7dS8jpmNoZRJqMUuGavxPUUsztgRM+NRx8
	 Fq7ZrUMGhvlFigAcL6yvXN0hPokfhBNIaYJx5k2r9KwP8q2ynA4RO7h+DsEx9iIWsgBBK
	 yvxiqHaVWQQhjpjmylHE/7vT0X36qVpTfR7u+mwMzoCpemUIB6wpCHF2H9oCOMhN8Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=iampxN5t;
	arc=none smtp.remote-ip=91.218.175.225
Received: from mta0.migadu.com (out-225.mta0.migadu.com [91.218.175.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFD4606A31E
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 03:45:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AFD4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=iampxN5t
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=AjGuHxKPho2+lTUWKKgkjdNmlALln6KLBsfucJzafsI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795405542; v=1; x=1796010342;
 b=iampxN5tRwt8Jt0+JUf7XqHmjXfTDzr9pzLiB1c91Ee+hYZQ8re+GvnFmQrA1ezYSjZjvzGv
 f+Ba+fbDbg9B/kV6vyWdS9ON5iEY8frgB1r19U36+eonmk+dbKjVbRNkfqRRKSYjSgg+jvQojDc
 k0hVpQZjwuFX5P3807OrPw7w=
X-Envelope-To: stable@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 7f0750ea786c6782;
	Mon, 23 Nov 2026 03:45:26 +0000
X-Mizu-Trace-ID: 7f0750ea786c6782
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
Subject: [PATCH v3 2/3] selftests/mm: fix false-positive and racy KSM fork test
Date: Mon, 23 Nov 2026 11:45:17 +0800
Message-Id: <20261123034517.236914-1-xu.xin@linux.dev>
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

Currently, test_fork_ksm_merging_page_count() passes wrongly even if
fork() fails to reset mm->ksm_merging_pages, because the child process
calls init_global_file_handles() -> ksm_stop(), which unmerges all KSM
pages across the system before reading its counters.

Fix three issues in test_fork_ksm_merging_page_count():

- Drop init_global_file_handles() in the child process so it does not
  call ksm_stop() and mutate global KSM sysfs state (unmerging all KSM
  pages across the system) before reading its counters.

- Use '!!' in exit(!!ksm_get_self_merging_pages()) to avoid 8-bit exit
  status truncation (e.g., 512 pages on 4 KiB systems truncating to 0).

- Introduce ksm_pause() to pause ksmd (write "0" to /sys/kernel/mm/ksm/run)
  before fork(), preventing ksmd from scanning the child and incrementing
  its counter before it is read.

Signed-off-by: Xu Xin (vivo) <xu.xin@linux.dev>
---
 .../testing/selftests/mm/ksm_functional_tests.c  |  8 ++++++--
 tools/testing/selftests/mm/vm_util.c             | 16 ++++++++++++++++
 tools/testing/selftests/mm/vm_util.h             |  1 +
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
index 135191f99962..b871d5656688 100644
--- a/tools/testing/selftests/mm/ksm_functional_tests.c
+++ b/tools/testing/selftests/mm/ksm_functional_tests.c
@@ -668,10 +668,14 @@ static void test_fork_ksm_merging_page_count(void)
 	if (map == MAP_FAILED)
 		return;
 
+	if (ksm_pause() < 0) {
+		ksft_test_result_fail("Stop ksmd from running failed\n");
+		goto unmap;
+	}
+
 	child_pid = fork();
 	if (!child_pid) {
-		init_global_file_handles();
-		exit(ksm_get_self_merging_pages());
+		exit(!!ksm_get_self_merging_pages());
 	} else if (child_pid < 0) {
 		ksft_test_result_fail("fork() failed\n");
 		goto unmap;
diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index f26f9e4bfdbe..e638475543e6 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -1080,6 +1080,22 @@ int ksm_stop(void)
 	return ret == 1 ? 0 : -EIO;
 }
 
+int ksm_pause(void)
+{
+	int ksm_fd;
+	ssize_t ret;
+
+	ksm_fd = open("/sys/kernel/mm/ksm/run", O_RDWR);
+	if (ksm_fd < 0)
+		return -errno;
+
+	ret = write(ksm_fd, "0", 1);
+	close(ksm_fd);
+	if (ret < 0)
+		return -errno;
+	return ret == 1 ? 0 : -EIO;
+}
+
 int get_hardware_corrupted_size(unsigned long *val)
 {
 	unsigned long size;
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index ab1325dc6580..df16973d108a 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -168,6 +168,7 @@ int ksm_set_smart_scan(bool enable);
 int ksm_use_zero_pages(void);
 int ksm_start(void);
 int ksm_stop(void);
+int ksm_pause(void);
 int get_hardware_corrupted_size(unsigned long *val);
 int unpoison_memory(unsigned long pfn);
 
-- 
2.34.1

