Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.203
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160698;
	b=WBI/FLaRtRGwGbzqxuHpvysSeIA6o/1g56vL0lpsYTL6GIEqKhWc2JSWbVUVtN7/JLlM
	 4GcM41MTAnz2r4pWrAhoGTcLBtm+Yw9Dn2CRyGSEkbab0YXMYBY1rv+4sTa880XXEoTOX
	 gdcASvbq2A/koys4VgmlYSmTDCdcdfJbkHn5AYwXgd9pL9widbGVpjFS6TKf91/yO2x6S
	 fRpdT15Ch2KdwmUFDHEOyaLeFv1L2CedqshG9OiMjz8Rk2eeBcnvwTZWbBaKObsyG1szp
	 y5X2xgvjaFLE+D6nwd3ZqATK0oUpz+kquMVrWWLfVTXiqIGHU9gC0/pUUugATngueTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160698;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Lxi6unjVQ4QMAgeTvpwgXSWHJFUdnkiAu2/vuTAVwOc=;
	b=pWPgFs8KWY2SHkJQOH1vKnEsxS1gmQ9jhkCr1FAqASlf4nEt+ddi9VPuS7RFYt3PzG7a
	 N4ZEkEGUn4E/9VTI8gjsc1lhxpUudKurD8zlAwJrg3bDynFdnti3bavS9sLpwAuQ4lggs
	 66lE7UwkAildTJBRttIM14HAjyNC5HmicsCEQyU8invHLxIFpATKQAl0iR3Wft8BS4wGq
	 4wH/XiVnSi5l4P7zNujZ+I2V1sL2kB6XqV6aAlpek8BG8ljtC+Tbl4SyGr9+e9ZeNc40X
	 ihQdneQ1uC7/9yhkVu6CHf7+XHQ55M5BZDvzKhGsRTlGtZW/0gNWv/5PqB+mw40WPdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=rIr1t80t;
	arc=none smtp.remote-ip=95.215.58.203
Received: from mta1.migadu.com (out-203.mta1.migadu.com [95.215.58.203])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E0B606A332
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 07:44:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9E0B606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=rIr1t80t
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=lB7kRH1Y6c45DRzOiYxWXvEym+deCOdTIknp2BnEVAM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795160696; v=1; x=1795765496;
 b=rIr1t80tmltB+JcBtrDnIX+74N1Ia1PLfMhBevXJagxvm6AAdWGnvC0fBlJ9srxtn9Zdm4w7
 efcOzUMBCDEYHpPmrzEUJd7yDaoDu32JPJ8rsL3Ks9Vl1oGeW5oJV+M+d5a1USVsjt1Fmaw1o7s
 zGYYPvD9GCuMdLtbNAUgdkCo=
X-Envelope-To: stable@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 9b268e6d28a98aa1;
	Fri, 20 Nov 2026 07:44:55 +0000
X-Mizu-Trace-ID: 9b268e6d28a98aa1
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
Subject: [PATCH v2 2/3] selftests/mm: fix false-positive KSM fork test by dropping init_global_file_handles()
Date: Fri, 20 Nov 2026 15:44:45 +0800
Message-Id: <20261120074445.41446-1-xu.xin@linux.dev>
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

In test_fork_ksm_merging_page_count(), the child process currently calls
init_global_file_handles() before reading ksm_get_self_merging_pages().
However, init_global_file_handles() calls ksm_stop(), which writes 2
(KSM_RUN_UNMERGE) to /sys/kernel/mm/ksm/run, unmerging all KSM pages
across the system and resetting the counters to 0. As a result, the test
always passes regardless of whether fork() properly resets the counter.

Remove the redundant init_global_file_handles().

Fixes: 08ff89b5659d ("selftests/mm: add fork inheritance test for ksm_merging_pages counter")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Xin (vivo) <xu.xin@linux.dev>
---
 tools/testing/selftests/mm/ksm_functional_tests.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
index 135191f99962..c20982b0aff0 100644
--- a/tools/testing/selftests/mm/ksm_functional_tests.c
+++ b/tools/testing/selftests/mm/ksm_functional_tests.c
@@ -670,7 +670,6 @@ static void test_fork_ksm_merging_page_count(void)
 
 	child_pid = fork();
 	if (!child_pid) {
-		init_global_file_handles();
 		exit(ksm_get_self_merging_pages());
 	} else if (child_pid < 0) {
 		ksft_test_result_fail("fork() failed\n");
-- 
2.34.1

