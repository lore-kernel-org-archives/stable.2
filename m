Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.217
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795525319;
	b=wAv4QHIWAsaMNkPAQGCsjNYDUNRhNyyO63BgbD74BASkOR+Fd2jsNP58fn6PKFE/9lrl
	 jS1H/4ZLtQPW7YXyC5Bgd6xRy0dyE+n5nf5BS0Sh5KKpWsGabuGvIBHLPO4AZIkatUdoK
	 3s4bhPayo8h6rNZc2GwTiLB3tdvhbp+lKpAS0ld2sjTFGetea+Bbr9q046hcLUiwvFp+L
	 P9oBDNZxbPx7WFBK/Xk1p2ikvGiu+737P4nw3hZVqfAYB4glgUK2Sh6n15AIhQtaZGwZu
	 d6IfngesjaDlnOCC7oAARn1tJTsA3bDQ1udCDwVZMjkIQIZfYbyTCbDsCwLgjMnqb6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795525319;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=N9p6GMpiXBcl+jaczrOvf2ku3VNe7glVjQtCROb0hAw=;
	b=SSKA5Hss74OCHgGDorpkNg/Lz9W+KB09bI+sk0dRUb5bqQD98/hsutY/W7IBr/kYynyd
	 Dp5WQt0lEr/A2DmF03lVIyQfjagqWabUXxwzryrx2cDXngk0xMXqSjv6rECnWgE/wREjw
	 l1FfJ+xZg9GA8ryjhh105mygav8rP3j9viOEr8p2rHCZnGUyyC/4WqgEfkyhOLwLfxbDD
	 BmRIgLE0x2wB/Ry87FY3IKg28YUMQCg3cwmPYdFt6EWSB1bSQ8RJiVZIodbLIrvCqMKxS
	 gZh8RrAjO86L5shKoz2JjceA7f7J9w93xkB96PgE/dGEDD1yZ8re8yB/dpztjTq9+Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=To2tbGyS;
	arc=none smtp.remote-ip=91.218.175.217
Received: from mta0.migadu.com (out-217.mta0.migadu.com [91.218.175.217])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CBA606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 13:01:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05CBA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=To2tbGyS
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=JPkUZj7QGHtjWgvJq/FICVMX0UJPUNsCw+1258YO1uo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795525316; v=1; x=1796130116;
 b=To2tbGySR1aM4P7ygW9usvjlw+G1CBv3/WA9W3qEcrKO34BtxhIpj/wLvcPwI57LJp2BwK8P
 /Z6m9irGgwbDRzqUhkhnJkI3/bUv5gH7xV9RRnki5xxtFiXSBw7ovhrRSm8Mksa1lEinFcVrVP3
 to0qjPuxjTRPoPsuoC1qfMBY=
X-Envelope-To: stable@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 821e2fd635352937;
	Tue, 24 Nov 2026 13:01:56 +0000
X-Mizu-Trace-ID: 821e2fd635352937
X-Migadu-Flow: FLOW_OUT
From: "Xu Xin (vivo)" <xu.xin@linux.dev>
To: david@kernel.org
Cc: akpm@linux-foundation.org,
	chengming.zhou@linux.dev,
	donettom@linux.ibm.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org,
	xu.xin@linux.dev
Subject: [PATCH v4 0/3] mm/ksm: fix ksm_zero_pages accounting on fork
Date: Tue, 24 Nov 2026 21:01:43 +0800
Message-Id: <20261124130143.128411-1-xu.xin@linux.dev>
X-Mailer: git-send-email 2.34.1
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

Currently, fork() wrongly inherits the parent's ksm_zero_pages counter
and keeps the KSM dirty-bit marker on zero-page PTEs, inflating both the
child's per-mm counter and the global ksm_zero_pages counter.

Patch 1 fixes this by resetting the child's mm->ksm_zero_pages to 0 in
ksm_fork() and clearing the KSM zero-page marker when copying present
PTEs, and documents the behavior.

Patch 2 fixes false-positive and racy bugs in the existing KSM fork
selftest by dropping init_global_file_handles() in the child, avoiding
8-bit exit status truncation, and pausing ksmd before fork().

Patch 3 extends the selftest to verify that neither ksm_merging_pages
nor ksm_zero_pages is inherited across fork().

---
Changes in v4:
- Update the comment above ksm_fork_pte() as suggested by David Hildenbrand
  in patch 1/3.
- Rename test_fork_ksm_statistic_count() to test_fork_ksm_counters(), unify
  cleanup labels, munmap before ksm_stop(), and refine log messages in
  patch 3/3 (David Hildenbrand).

v3: https://lore.kernel.org/all/20261123034136.209410-1-xu.xin@linux.dev/

Xu Xin (vivo) (3):
  mm/ksm: do not inherit ksm_zero_pages counter or PTE markers on fork
  selftests/mm: fix false-positive and racy KSM fork test
  selftests/mm: verify ksm_zero_pages is not inherited on fork

 Documentation/admin-guide/mm/ksm.rst          |  7 ++-
 include/linux/ksm.h                           | 24 ++++++++--
 mm/memory.c                                   |  5 +-
 .../selftests/mm/ksm_functional_tests.c       | 48 +++++++++++++++----
 tools/testing/selftests/mm/vm_util.c          | 16 +++++++
 tools/testing/selftests/mm/vm_util.h          |  1 +
 6 files changed, 87 insertions(+), 14 deletions(-)

-- 
2.34.1

