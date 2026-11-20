Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.204
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160565;
	b=uKc6ntIpl7wWc99XXQae/01m5Zn6SBSxBL6jg1H5uvlAriYtMET/YWbTg4OAP8zXqrsU
	 RBrmxRqG6MFxAL3/2J+mhYcQHrBsHTx4Fj+cizfUksrzrfB0RnXyhUBUJV68FG44txLG8
	 jfXmdfwEQJxoSXI7TZYiGK+khkrPTm1GC25AR9FJVAKDj3B/ZD+/TODb+98p5oQxQwq81
	 +hE/Pzu2xf6QFhDKHnf+wVXeOgypcTTxj4ZqgIJGDeH2R4CKaq2vbwydfME8kyjCWaDQM
	 fe4zoIeX+1C7sn1gAr/EfIm6MCTe86W7vFy751XhI9upisU4BOFSoMrJW0lNeJUKpgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160565;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=fHTdpM8nxSvx3evoOQbtGvFbq+YzrWfScABJx2vwaCs=;
	b=PcKYKH+mMaVBIaigTdtvYxPWrWUNWy0odAPLCvwxzgVeo1E+NGameurv9a2jJWeOWCDa
	 6+wDmg2Z41BYvFsG3SlexiUhTcccT1zn3RxHMHhcTN4KF10cudgEN9RYr2pxXcxnue/Ou
	 rdJTt+FL5yBI4XzuHWa7UQ4dceTbLTU0BOJ5Ne71Mx4eW/LIbNkQXawLQCaYCLrr4pIzw
	 S3PZGU/vDIUivfOBzEBfaLkmrw7wrcCtl6wDcLEWxYgVOlO+xz4cN2Ox5oK0HebuAOWet
	 cn7rKpOx7c1rp6a1Nnrj8Za712Q0nuDbsS9tVC5RUNTbwJfPo77ZpABmWpfh6Nup5og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=IFTqiyv0;
	arc=none smtp.remote-ip=91.218.175.204
Received: from mta0.migadu.com (out-204.mta0.migadu.com [91.218.175.204])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D6860A261B
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 07:42:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5D6860A261B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=IFTqiyv0
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Rf68KggUysX1MYPELIpPD1pBE4j+ZU9neLaxwKPeBJ4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795160563; v=1; x=1795765363;
 b=IFTqiyv0d1cpPHITuUombiXXqWGl7hr//7jd2CjBovzzMo11dyBnQzvFK7MgO5qpf9Toeb9G
 wOKN5J+0TMl4pxM6zqR4RaNWMTyf0HpLadpSsixbitZKecsLz2oNQr1sFTSo7EofyxKDv1cG/mb
 afX83lNtBRtyQE/1Cq/9onHY=
X-Envelope-To: stable@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id cc1442cd9fd56b76;
	Fri, 20 Nov 2026 07:42:43 +0000
X-Mizu-Trace-ID: cc1442cd9fd56b76
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
Subject: [PATCH v2 0/3] mm/ksm: fix ksm_zero_pages accounting on fork
Date: Fri, 20 Nov 2026 15:42:30 +0800
Message-Id: <20261120074230.40269-1-xu.xin@linux.dev>
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

Patch 2 fixes a false-positive bug in the existing KSM fork selftest by
removing a redundant init_global_file_handles() call in the child.

Patch 3 extends the selftest to verify that ksm_zero_pages is not
inherited across fork().

---
Changes in v2:
- Encapsulate zero-page PTE marker clearing into a dedicated
  might_clear_ksm_zero_pte() helper and simplify the code comment. (David)

- Fix compilation error by adding stub implementation of
  might_clear_ksm_zero_pte() for !CONFIG_KSM. (kernel test robot)

- Document the fork() interaction and MADV_UNMERGEABLE behavior for
  ksm_zero_pages in Documentation/admin-guide/mm/ksm.rst. (David)

- Fix a false-positive bug in the KSM fork selftest (patch 2/3) and
  extend it to verify ksm_zero_pages is not inherited on fork (patch 3/3).

Xu Xin (vivo) (3):
  mm/ksm: do not inherit ksm_zero_pages counter or PTE markers on fork
  selftests/mm: fix false-positive KSM fork test by dropping
    init_global_file_handles()
  selftests/mm: verify ksm_zero_pages is not inherited on fork

 Documentation/admin-guide/mm/ksm.rst          |  7 +++-
 include/linux/ksm.h                           | 18 ++++++++--
 mm/memory.c                                   |  2 ++
 .../selftests/mm/ksm_functional_tests.c       | 35 ++++++++++++++-----
 4 files changed, 49 insertions(+), 13 deletions(-)

-- 
2.34.1

