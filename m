Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9A75237BA
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 18:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790878536; cv=none; b=HX436CAP7uh992f4t+2BQnvI6Upgb0woHopAqSOjzrcJHKknuxsBoTx7Cln2MCQLuOJIBSNIjKzWuoVMdlNaJc+uo5pXnqMP0KMbik3KcnEth6qsaBOcs5Y7z860rlmddmYABN2Mo8bxCucLt6tu3wpnDY7uvHmdttc5kpX1ug0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790878536; c=relaxed/simple;
	bh=UYIxpue9U7wLOldjTAEq2Y8YcpIjqgAN3TM8JYsRuCU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pd+XsmE9gDYFOoxurLodke+Js+w8eTppaa96H1Ih5K85XZOzV/Kp/1rn3/i0A9CHqgv+8kHyzSJoUWBuNRQ8yJWGJIwPQVV1Do9tqz66/aiO+hDh6mKlRg8gwNKHppGLvY0X5094wkU3T6yXP36QJr50KeydBcUiC7R+7fEITEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Snifk8Dc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Snifk8Dc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790878529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=A0IEnKIIoe14yk04bwWgYY6XA9TxUuiuYvjrXGnIi6w=;
	b=Snifk8Dc9XLKGLoXItQDEaIzjfO3KioB8BEbvwHxpqeOVkSloGM9+8ocP3R3SLRImJoJt1
	ZK2iyZ+7TOg+i4Eeb+Boa+FDvp5vWwKGdSZSgX0VHalC+n+DJSBCNeCnijGrbq8yWD94X7
	Yo/gGGCvmHAQTbRHxYZ/mM9s3YZrFyA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-211-3j7Aynp0Me-5pNw8J8K6SQ-1; Thu,
 01 Oct 2026 14:15:26 -0400
X-MC-Unique: 3j7Aynp0Me-5pNw8J8K6SQ-1
X-Mimecast-MFC-AGG-ID: 3j7Aynp0Me-5pNw8J8K6SQ_1790878525
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B1EDD180049F;
	Thu,  1 Oct 2026 18:15:24 +0000 (UTC)
Received: from lcapitul-thinkpadt14gen3.rmtcaqc.csb (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7CA3430000E4;
	Thu,  1 Oct 2026 18:15:23 +0000 (UTC)
From: Luiz Capitulino <luizcap@redhat.com>
To: sashal@kernel.org,
	stable@vger.kernel.org
Cc: rppt@kernel.org,
	sayalip@linux.ibm.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6.12.y v2] selftests/mm: hugetlb-mremap: add setup of HugeTLB pages
Date: Thu,  1 Oct 2026 14:15:18 -0400
Message-ID: <20261001181518.685129-1-luizcap@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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

v2
- Preserved original changelog & subject
- Small code style difference from v1 due to git cherry-pick usage which
  preserved the original commit style

diff --git a/tools/testing/selftests/mm/hugepage-mremap.c b/tools/testing/selftests/mm/hugepage-mremap.c
index 3070484f9ed0..164bbda8128f 100644
--- a/tools/testing/selftests/mm/hugepage-mremap.c
+++ b/tools/testing/selftests/mm/hugepage-mremap.c
@@ -87,6 +87,7 @@ static void register_region_with_uffd(char *addr, size_t len)
 
 int main(int argc, char *argv[])
 {
+	unsigned long hugepage_size;
 	size_t length = 0;
 	int ret = 0, fd;
 
@@ -104,7 +105,11 @@ int main(int argc, char *argv[])
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

