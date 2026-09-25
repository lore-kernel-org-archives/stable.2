Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4392049C4BC
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 17:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790356913; cv=none; b=WDmQN7iOYw1AO83jkRGeNlzRpEwRPhfN8IOZDLrAgBENcAEgGd3nUJf3tFtS6f9KwuLuhm6E9fBrJj34U4Z0/SjOC65yfkx5WojPV6BJ4mcEMt5QkqKUUtxthpdog/FPiB1glAMaOeiiUi27PkR/7sTLJnkEVQ2LZyQ+O6yF8cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790356913; c=relaxed/simple;
	bh=XsLurEGBZvM2bLU0UgX7me9FFWLASNVgRaWp8LKPMIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PIisnZ2YBL+nxPuZ5vNpTJb/D04QGE6QyJMsHkvjX78SayTkoL1Tr1ed4/E+Hagn0zJ1PyxavPsdW1vRDt8EPH/NI9HxIzD3jqxRPwb4MN4T1g5iP8Bh1wWRU0dhCm0XYbJz3HE574U7oKxoQY8ZonVBu+tjalvAsOs415rWeNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CzmCVyTe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CzmCVyTe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790356908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2y3SWVL9xb1mi6/jmBV5roo3osTXZ0gweNVe3xO+8yY=;
	b=CzmCVyTeiwzZTHCFaGXxm6Lo7twuj0ACK+TyW30YAG/ruiLSZNGeSio/d+ZroltdnsHsz1
	nQAkTgWDAWO9nycXWWboPPOxITUsICrjJNUI6fqBFl+xAytRHYov0JRVV6I/IB+02bWit9
	xKfgKbvaxf7KHDcqkn3Tkc1bPN7BkmU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-Dpk2Qw1wOKOy6r-1EGkHgg-1; Fri,
 25 Sep 2026 13:21:44 -0400
X-MC-Unique: Dpk2Qw1wOKOy6r-1EGkHgg-1
X-Mimecast-MFC-AGG-ID: Dpk2Qw1wOKOy6r-1EGkHgg_1790356903
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 69C9B1955F75;
	Fri, 25 Sep 2026 17:21:43 +0000 (UTC)
Received: from lcapitul-thinkpadt14gen3.rmtcaqc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 876B71800473;
	Fri, 25 Sep 2026 17:21:42 +0000 (UTC)
From: Luiz Capitulino <luizcap@redhat.com>
To: stable@vger.kernel.org,
	linux-mm@kvack.org
Cc: rppt@kernel.org,
	sayalip@linux.ibm.com
Subject: [PATCH v6.18.y] selftests/mm: hugepage-mremap: fix mapping alignment
Date: Fri, 25 Sep 2026 13:21:29 -0400
Message-ID: <20260925172129.2962208-1-luizcap@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

When running the HugeTLB kselftest suite on arm64 with 64K base pages,
this test always fails:

  # -------------------------
  # running ./hugepage-mremap
  # -------------------------
  # TAP version 13
  # 1..1
  # # Map haddr: Returned address is 0x7eaa40000000
  # # Map daddr: Returned address is 0x7daa40000000
  # # Map vaddr: Returned address is 0x7faa40000000
  # Bail out! ioctl-UFFDIO_REGISTER: Invalid argument
  # # Planned tests != run tests (1 != 0)
  # # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
  # [FAIL]
  not ok 1 hugepage-mremap # exit=1
  # NOTE: These hugetlb tests provide minimal coverage.  Use
  #       https://github.com/libhugetlbfs/libhugetlbfs.git for
  #       hugetlb regression testing.
  # SKIP ./uffd-wp-mremap

The problem is that the default HugeTLB page size on such systems is
512 MiB and 'length' is not aligned to the page size. This causes
uffd_register() to fail as 'length' is 10 MiB and not aligned to the
HugeTLB page size.

On upstream this was fixed by a914785f6349 ("selftests/mm: hugetlb-mremap:
add setup of HugeTLB pages") as that commit aligns 'length' to the
default HugeTLB page size as part of what it's doing. Since this commit
is part of a 50+ patch series, we backport only the 'length' alignment
bits to fix the test.

Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
---

Two notes:

 1. This is fixing an issue upstream commit a914785f6349
    incidently fixed
 2. This should apply to v6.12.y as well

 tools/testing/selftests/mm/hugepage-mremap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/mm/hugepage-mremap.c b/tools/testing/selftests/mm/hugepage-mremap.c
index 928c1045e295..0d4e1a5b185d 100644
--- a/tools/testing/selftests/mm/hugepage-mremap.c
+++ b/tools/testing/selftests/mm/hugepage-mremap.c
@@ -97,6 +97,7 @@ static void register_region_with_uffd(char *addr, size_t len)
 
 int main(int argc, char *argv[])
 {
+	unsigned long hugepage_size;
 	size_t length = 0;
 	int ret = 0, fd;
 
@@ -114,7 +115,12 @@ int main(int argc, char *argv[])
 	else
 		length = DEFAULT_LENGTH_MB;
 
+	hugepage_size = default_huge_page_size();
+	if (!hugepage_size)
+		ksft_exit_skip("Could not detect default hugetlb page size\n");
+
 	length = MB_TO_BYTES(length);
+	length = (length + hugepage_size - 1) & ~(hugepage_size - 1);
 	fd = memfd_create(argv[0], MFD_HUGETLB);
 	if (fd < 0)
 		ksft_exit_fail_msg("Open failed: %s\n", strerror(errno));
-- 
2.55.0

