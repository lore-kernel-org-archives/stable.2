Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.196
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795525420;
	b=R7Hr3AYXnUsAJrWM8AtSw/KEIevsbtKBLOUhsqHhwbwsWI3Fre17Vcdks9k3/PBttrLc
	 yO6v8meqf6ccLcCkx6D3TZWDS2GzgLYo1YXfftTtTL5v7CGSeZsOWGWPfpSEWLVI1xgnL
	 Jdeo/u++yvHbSIXVMlrWNvSedJ7SO5xv9Jt9RAsom5b1BoQckpW9qnwPUiKsOe0Anhc6P
	 f8BY8ExHzEcjRhkuopBBELn9pBytpNtWTpT7ELb1Tm220/zVtcam8RYlA5gU21RJ5Gzzy
	 K2Wy6a0KZ7qclL2ub9ANCLUOPC3yTfkWZ6DXkhMCcqRPbSviPCpZBBBKr/p8hyk2k/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795525420;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RzaOSH6wDU86KLn8UnvDUyV5JshCNmIFXfq+s5ulUe8=;
	b=Sd76Ozk8L4nYabGD7mMFKLbwF8PehCwPGCryxPxRVow+oo67Qc81Eq1JMOiN90yvVdv7
	 DyAOdWmGV/PgbHQz80e/pq8zxdvJcsEJnP9JyynTK9TwPZn3hOVcPp9sCJvW5yA6Owg4M
	 6AxfbhsoOztXLKyLO6S87W8Y6oyg6jwWDXUg2zY+h4hPTdUXV6HVhQyCf5R7Tt3D95dUL
	 3PpGlRcXQkBEFxEVZhIOugdkaLsP1hBem3LhMe6tDBXWT+txa1Bwhe2eCkidolRwSs8CQ
	 /XMLit1CTznWH97NRTF7wh9e8LJrtCz+CZIfu3IUouKBqvM14hTRDFyZHmDPlU1WMwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=OTL6oIKM;
	arc=none smtp.remote-ip=95.215.58.196
Received: from mta1.migadu.com (out-196.mta1.migadu.com [95.215.58.196])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539FD606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 13:03:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 539FD606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=OTL6oIKM
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=JmTzUrRmL1kCP/GnAND4zD3C4FlayfF4aT4rwA6Hr/c=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795525416; v=1; x=1796130216;
 b=OTL6oIKMuYw8CPCylKclk36Gxwv0ZZ407gdrXvZquLFl9tntlPyQeRhvw7sCtQZ8LSjZw6Qt
 xNPJZENHh9dAcBXnk/zHyqyrk8FrzCgxzphPcOIMrjAagp+yHoUyrK9EPLdVZPgWVsfKjHjWdSm
 YdUoAwHGrWtzfWRYI9LZFFKE=
X-Envelope-To: stable@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 3fed72913207e595;
	Tue, 24 Nov 2026 13:03:36 +0000
X-Mizu-Trace-ID: 3fed72913207e595
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
Subject: [PATCH v4 2/3] selftests/mm: fix false-positive and racy KSM fork test
Date: Tue, 24 Nov 2026 21:03:27 +0800
Message-Id: <20261124130327.131410-1-xu.xin@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261124130143.128411-1-xu.xin@linux.dev>
References: <20261124130143.128411-1-xu.xin@linux.dev>
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
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
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

