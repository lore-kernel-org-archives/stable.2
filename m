Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.58.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794997341;
	b=GA3LHyJFHdImf6/hNDBWbuKqp9+sustgvHFIxeTKo2iCecjWeUlmtDGoFN3b0trJsW7t
	 iwez4IcgYXTNR9Gq++kZOYc12ZzzX4gwAHtJAn54OFqMt9O0ZCiyZ4bmgaAcaZLGfARaU
	 ARxmcETW6/oQnUdDx+iaNkNcQWTnBmlPGoQzyVmsnhOoC0nGtO6q5ZXeogabcdxCR8ZXV
	 rTU8Q0J0DWpbj/QbJdkI39+o7hSvV6bUhi3oXWP6ozYfWXSvkQhYnGZjmKsfqBHiKbrLw
	 MZXV9YEiXyaSONXqUcqhz78VMX1PuhdA6jZy/HBByXAh9LVg8I+kYprjWv1ASLCd3Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794997341;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=so/CeAH0TndbVbEBeoF4tkF3aB19pcuqXJXgWV3BUF8=;
	b=o7OxN4viN5Ifm4ii+ETUFigbNt9js6L72KTSGANFjA4tyLHnjB6b48k/LKSBvJ2JAE4Y
	 vbYqJrqEGlWvK5pDkB6zKUzOHFT2EdBjnyE+zashovJ39Ne72eB41+aZ1nO5LRwD7G+zQ
	 YyMJbuP7cd6ErlTjYldiOzt0NYCBELk3GHP3320NMydm8WNwhutOkU4fTdANFD+1dXCtx
	 HtYGHQIy9ZEI1z+E3ArM6imErsgOYU81q8lci6agHvqb7sm4uclchwPLlevIIw9gSNhOj
	 R6iW5qXa/hW20EOtnVH3B6ixwk0Bo7WoAXMRd2IzmzLVKJvRMyOJ+4LLFZM1j0jypqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=LjRCyMWy;
	arc=none smtp.remote-ip=162.62.58.211
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB62606A31C;
	Wed, 18 Nov 2026 10:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCB62606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=LjRCyMWy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794997335; bh=so/CeAH0TndbVbEBeoF4tkF3aB19pcuqXJXgWV3BUF8=;
	h=From:To:Cc:Subject:Date;
	b=LjRCyMWyuk8MxwA/B3/ayfIdZC8zf6ptOd1a0CgD49+DOJ3aTCyFSsvCpETmI/8hg
	 OQzUL8QYArGCM6J5F4LmYnAH50y02A3RnukQdmBIhWw3PJ4BXHl+Qh/anG34ZWFbZs
	 /hBJA/DsSZ8nvQS2hSvpSDPcFXgtMVsGO0wxG1Zc=
Received: from DESKTOP-6LNKCJL.localdomain ([111.199.66.152])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 588170B0; Wed, 18 Nov 2026 18:22:08 +0800
X-QQ-mid: xmsmtpt1794997328tz8vz7byo
Message-ID: <tencent_69A761EE2ABA6F15B942EBF0EE686B2DE608@qq.com>
X-QQ-XMAILINFO: NDD+ZwUaH+mrqhv6ZaLC/66xueoPLPA/oVmOv751sEPd2/kh/9Xt/3/ISsXNxf
	 KzHY9jjguRCdyQtuTSP7Y9GXvlO9waSUth8Gqe2r/r9y+3BB0itmtirWhupkQweIWtSRDfMauXf+
	 gT3WpoDT62+58tcsjC1OQDeMdnBICWqG16xASD1okoWkBn1JYpO1wbTpoMPz06abKPY19JVzo71a
	 AXW6i8dkw5S2nwho28OY/gKasuRY8d1syX9T7/m9JF3sV9+r94xjqV9l1knyFuQocDPVOVa4h4iM
	 Oj+G43pd80CBK9x09bqO/zI6iFtAL5OovnqihwujezbuJsnEBeIUPfP4uVaRwxOt1Ezq4BWLjFP0
	 m8SHnAKazSDg2LcNaPjanEfKQMZr4fWo8SNxWQ3W04WBvf9f3MVhBPZY9rFZHClu1+gfPt8oTsg3
	 MhR+HiDux+UH+bnZyVHlghIYPolSBgT+n0DBNGFUzM8GrZ6NIWSxJ5rglOqrGizgFOtKp6IQKaVB
	 RcnrXgSMGloT8lesM6x7b9MB67IIToVZG64zXnjb/FX1/EDPV6bh7FLEXEeuU5sb4kQCmqnB4cNG
	 JxuTeDA42YOoCOMBwdUdwQ7XOMJq5hAM1F2zQube/0bUX7h8iqUPaKktBIT8kvHvsVvwW9WmmRVR
	 R2iRTjJW6dkke5IXN34iIshc4uJ12ayua8+YMjrRUbRA4ti3J/6Svsrc+ZMv5PqRiGQFtkxFhmio
	 aSJ6LEsRhyVI4FJEPXFvjwzZzvLfDe+xK2Dnxq30/YM+4b0j2fe/dnwGghlY5QBactIxyy4RX0ow
	 H8Z0yUFc/c7cD8ODUGmqf2Tijp69CTpXIxh3NunfuVrhIRoYPb4jEIeLWCfqS0bry+UOP3hPxuyk
	 /NGmswsrQwHotY3JvrvKAEd7/1LV+94UniSv9DRlQtvE3MsY0obzkauMiafDvW98YQOK1kN6bi5Q
	 SRs6i4vnA4gEtDeyPrMKKI1NVL0yjlrGPzCWE7a+kHocSnpbmD+2GkBOd6CJu/81RXHW86HlOWqc
	 m/0vcIkq0ceGyT39C0oI60MYBuBm6SNIiOhlW/W/KmXK63nLg5A0S3I614SYs0Zkks0vPo7EN/5Y
	 v/ZJ8LYDmS8uRQWFb/pRVwU23nNza10YHSvFmZ
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Jingyi Sun <1045704958@qq.com>
To: Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Luiz Capitulino <luizcap@redhat.com>
Subject: [PATCH v3] mm: shmem: limit forced anonymous shmem huge orders to MAX_PAGECACHE_ORDER
Date: Wed, 18 Nov 2026 18:22:07 +0800
X-OQ-MSGID: <20261118102208.751-1-1045704958@qq.com>
X-Mailer: git-send-email 2.43.0
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

When the top-level shmem_enabled knob is set to "force",
shmem_allowable_huge_orders() returns huge_shmem_orders_inherit for
anonymous shmem without masking it with THP_ORDERS_ALL_FILE_DEFAULT,
unlike the other return path at the end of the same function.

huge_shmem_orders_inherit defaults to BIT(HPAGE_PMD_ORDER). On arm64
with 64K base pages HPAGE_PMD_ORDER is 13, while MAX_PAGECACHE_ORDER
is 11 because of the xarray split limit. With shmem_enabled=force, an
anonymous MAP_SHARED mapping can therefore get a 512M (order-13) folio
in the page cache. Splitting it later, e.g. on swap-out from
shmem_writeout(), triggers

  WARNING: lib/xarray.c:1051 at xas_split_alloc

and the split fails, so the folio can never be swapped out.

This is the same problem that commit 9fd154ba926b ("mm/shmem: disable
PMD-sized page cache if needed") and commit b66b1b71d7ff ("mm: shmem:
avoid allocating huge pages larger than MAX_PAGECACHE_ORDER for shmem")
fixed for the other paths; the force branch was left out. Mask it with
THP_ORDERS_ALL_FILE_DEFAULT as well.

Reproduced on v7.3-rc2 in QEMU (arm64, 64K pages, -cpu cortex-a72,
4G RAM, zram swap): with shmem_enabled=force, a PMD-aligned
MAP_SHARED|MAP_ANONYMOUS mapping of one PMD size got a single
PMD-mapped folio (ShmemPmdMapped: 524288 kB) and MADV_PAGEOUT
triggered the warning above in 3/3 runs. With this change: 0/3.
shmem_enabled=always and 4K pages did not show the warning. The code is
unchanged in v7.4-rc3 and in mm-unstable, but the test has not been
re-run on those trees.

The issue was found with a research static analyzer for
cross-architecture dependency bugs and confirmed with the QEMU
reproducer described above.

Fixes: e7a2ab7b3bb5 ("mm: shmem: add mTHP support for anonymous shmem")
Cc: stable@vger.kernel.org
Cc: Luiz Capitulino <luizcap@redhat.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: Jingyi Sun <1045704958@qq.com>
---
Changes in v3:
- In the force branch, set mask and jump to the common return at the
  end of the function instead of masking in place (David). No
  functional change from v2; kept Baolin's Reviewed-by.
- Re-ran the reproducer with this version on v7.3-rc2: 0/3 with the
  change, 3/3 without.

Changes in v2:
- Dropped the Assisted-by tag (Baolin).
- Collected Reviewed-by from Baolin.
- Dropped the note about the overlap with Luiz's mTHP series; Luiz
  confirmed his series will land after this patch.

v2: https://lore.kernel.org/all/20261118024517.21812-1-1045704958@qq.com/
v1: https://lore.kernel.org/all/20261117121626.1058-1-1045704958@qq.com/

 mm/shmem.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 10cef89b00b0..6d6b4a7e024a 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2113,8 +2113,10 @@ unsigned long shmem_allowable_huge_orders(struct inode *inode,
 	 * Only allow inherit orders if the top-level value is 'force', which
 	 * means non-PMD sized THP can not override 'huge' mount option now.
 	 */
-	if (shmem_huge == SHMEM_HUGE_FORCE)
-		return READ_ONCE(huge_shmem_orders_inherit);
+	if (shmem_huge == SHMEM_HUGE_FORCE) {
+		mask = READ_ONCE(huge_shmem_orders_inherit);
+		goto out;
+	}
 
 	/* Allow mTHP that will be fully within i_size. */
 	mask |= shmem_get_orders_within_size(inode, within_size_orders, index, 0);
@@ -2125,6 +2127,7 @@ unsigned long shmem_allowable_huge_orders(struct inode *inode,
 	if (global_orders > 0)
 		mask |= READ_ONCE(huge_shmem_orders_inherit);
 
+out:
 	return THP_ORDERS_ALL_FILE_DEFAULT & mask;
 }
 

base-commit: 666539eecdf4db623f5e3c3e55cf9f2dfad24aa4
-- 
2.43.0

