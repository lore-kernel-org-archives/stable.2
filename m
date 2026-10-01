Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B0D51992F
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 18:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790878439; cv=none; b=sWDo2NrqYqRUTUWX8+ZKtIBlYKmRGRJ11fkpChh/0WQ+WNL9qE47RvVj8XmmwYXu7zfeh24ar07TX/tx4DrnrDsN2G8X+XnZaziqAUF3ZUJ6hzbWrMRS6u4R+Oge1pfzHSbzK+IPJZUd7bslribBvqBsLf8YpXBFJOr1nxiNFxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790878439; c=relaxed/simple;
	bh=2XOoaBawLjbMqXkjs7Dxr/8UeBMSq7cEksbLVDPeip0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aJnEr/ezqrcCXkAkUcCEgSzge3Uw2vkf5E8d4YsdDVcBVbOcMphQxMC9KdB8YCcxGLnaJnTfzOlCXSFi2Aehu+MzPf1zfhjaLQhLR6yiXh0AFbc2uJ0fOFSXwWCeWpijruBncA0+uvUzioULV1l56zf4K1atAnIcI3yslNIm9Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AOIGOcMD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AOIGOcMD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790878433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2K6+AjrHHCLY+3zXw5HOJ91vX9fbZQsVpcAGubvt7/o=;
	b=AOIGOcMD4YIs7naDmi/KrFwIYoGvzEtpToAWv5QmmXukR1KDz+NcgaeMEuYTGNm+vdPAgd
	XOIME3XvqDA9DmkMUkEhHmIf5DBWRHPHERs7NZNyo8vi6LstF7JMgYpqPlHdiWKXQBwMD6
	RIJi0KI2tRVveuWyEgeHYtOFyx5R1bI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-l93d_TTfNca1FqR8r5n-pA-1; Thu,
 01 Oct 2026 14:13:50 -0400
X-MC-Unique: l93d_TTfNca1FqR8r5n-pA-1
X-Mimecast-MFC-AGG-ID: l93d_TTfNca1FqR8r5n-pA_1790878429
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B36B218009D3;
	Thu,  1 Oct 2026 18:13:48 +0000 (UTC)
Received: from lcapitul-thinkpadt14gen3.rmtcaqc.csb (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A4CED180059F;
	Thu,  1 Oct 2026 18:13:44 +0000 (UTC)
From: Luiz Capitulino <luizcap@redhat.com>
To: stable@vger.kernel.org,
	sashal@kernel.org
Cc: rppt@kernel.org,
	sayalip@linux.ibm.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6.18.y v3] selftests/mm: hugetlb-mremap: add setup of HugeTLB pages
Date: Thu,  1 Oct 2026 14:13:30 -0400
Message-ID: <20261001181330.684841-1-luizcap@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

commit a914785f6349da754e1226420bf4e51961956769 upstream.

hugetlb-mremap test fails if there are no free huge pages prepared by a
wrapper script.

Add setup of HugeTLB pages to the test and make sure that the original
settings are restored on the test exit.

Link: https://lore.kernel.org/20260511162840.375890-42-rppt@kernel.org
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Tested-by: Luiz Capitulino <luizcap@redhat.com>
Tested-by: Sarthak Sharma <sarthak.sharma@arm.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Barry Song <baohua@kernel.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Donet Tom <donettom@linux.ibm.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Liam Howlett <liam@infradead.org>
Cc: Li Wang <li.wang@linux.dev>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Nico Pache <npache@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

[ Backport-notes: this is a partial backport containing only the aligning
of 'length' to the hugepage size. The hugepage_settings.h include line and
the hugetlb_setup_default() call are omitted. Without this fix, the
uffd_register() call always fails on arm64 with 64K base pages and 512 MiB
default HugeTLB page size causing the test to fail with the error below as
'length' is 10 MiB and not aligned to the HugeTLB page size.

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
]
Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
---
 tools/testing/selftests/mm/hugepage-mremap.c | 5 +++++
 1 file changed, 5 insertions(+)

v3
- Preserved original changelog & subject
- Small code style difference from v2 due to git cherry-pick usage which
  preserved the original commit style

v2
- Added "commit <sha1> upstream" line to changelog

diff --git a/tools/testing/selftests/mm/hugepage-mremap.c b/tools/testing/selftests/mm/hugepage-mremap.c
index 928c1045e295..d6caa075a86a 100644
--- a/tools/testing/selftests/mm/hugepage-mremap.c
+++ b/tools/testing/selftests/mm/hugepage-mremap.c
@@ -97,6 +97,7 @@ static void register_region_with_uffd(char *addr, size_t len)
 
 int main(int argc, char *argv[])
 {
+	unsigned long hugepage_size;
 	size_t length = 0;
 	int ret = 0, fd;
 
@@ -114,7 +115,11 @@ int main(int argc, char *argv[])
 	else
 		length = DEFAULT_LENGTH_MB;
 
+	hugepage_size = default_huge_page_size();
+	if (!hugepage_size)
+		ksft_exit_skip("Could not detect default hugetlb page size\n");
 	length = MB_TO_BYTES(length);
+	length = (length + hugepage_size - 1) & ~(hugepage_size - 1);
 	fd = memfd_create(argv[0], MFD_HUGETLB);
 	if (fd < 0)
 		ksft_exit_fail_msg("Open failed: %s\n", strerror(errno));
-- 
2.55.0

