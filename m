Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFE431AF2D
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 15:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783007354; cv=none; b=YCC0Af0Lzqkb7UCTJ1QBavQjEFGAALvGRMSoaK8fOUDpf7VfluOyVBP6v5VWe7hGUBUxRXNBKYBGlmj/ckLapfvRFUWn6S7u4XiF6x47Rw+YaL1/t7n70JPEWUVLbu+iRdo711RtWwp6pGthsK2JLCMxKMU2IQhnoAQ0mqezUt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783007354; c=relaxed/simple;
	bh=V2wsPHM9whO+8UEZU+kmBIh7oNKCMyXeX+sPcDuYAvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pGhnyksQFADdO1nVTx3IGCTVjF037jUo+NYSEJC/TClqUioqxAs4d4BE9MWiVjHeZBigekzwip+B095K2JAE4JwPZ25gL2OPqocJXB/6ef1G7/GtZE8rsAlT85uZVMp8xHy/0gXx6W1qI3ToqYupbF/CPp/QANt/hD4lF966lDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGznK+g7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGznK+g7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59D61F00A3E;
	Thu,  2 Jul 2026 15:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783007348;
	bh=//1yCu2rPJQpbwPWAuzOrita8zkbHkDXNH2MigqNwQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GGznK+g7LLLfgMKHLRUTAr46ouKHCWNg3IHBO9zkRrKDUiAprGC9t6MnaAxIfB9WM
	 /vPBL9vYL0PP4vbKGAtfeHZeVYAycZyL6yUyIDq/D2njhOqEylyTXGwIwS5Nuijf9p
	 Vt+TV/0vsN54B9NgbjXjeIx/QabOaJCkUan/Zo0+g4uQQo+Oznk3q+EjaMFbB6MVY+
	 BqrALQplrRZ6Y49wBO4A7TGkM9kb2C2xzG5VrbglkmYb68D+x64qp71EF80kRZ4Ref
	 +kEVr+vWWF8HmsrnblLxVdlffjJoXT+V5+civoza3hYT8sS0wvPF41O8NkSKMDso+i
	 wg0vGkdZwQfRA==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id F010CF40068;
	Thu,  2 Jul 2026 11:49:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 02 Jul 2026 11:49:06 -0400
X-ME-Sender: <xms:cohGahqVf665o7eGmXLy0T8G9RAZpuryuAEmOm8THAqj5_EJptx5cQ>
    <xme:cohGar3osa6MuugX8lJ3wARH7c06XiA2S0W_gLmSGqjYyuU8aw3AUMvAueJNjGiuD
    lzleTurmFTr3sgsgPEFiV6SKHVHnT5rID7HgNZPCZoXiTW74hkz_bI>
X-ME-Received: <xmr:cohGapyokDYscd4gPBOwMMTdMDdjpkdEYBo67AUsgrQdUMP4acdzBFjL-tqa8w>
X-ME-Proxy-Cause: dmFkZTG0Ih/t8cHbMCodKXQLkUxQJqy59wDK3mLTRA7dVIErvl2/d1Ah+epBvIXb5j+AYP
    IXeEFDcIBfVLytuYu4/vLDhgRVlW3a+843BEiRDknGKdd2YPYw+W7qSRgjHbAB7tPzyIg1
    K/iaGu6PpbNvdlBe1ylT3w+4CnduN7fXaIiVz2SFU4GsotfIh0Hdi2izsWXFRQyA1Pgmvd
    bz3VM1BdljYqC26bMo/Uu8GxRLOKa/FHGZ/ez2IuhQ+NgorPxPnwdGD70mq06prVA+bGMW
    J3iimRYR/yORdPuHTUcQx20NCsiqIhAYZRtSAvfP/TF7cp/wxVykEXOIXpNkkJ9g0C+7Ky
    k0Ou2ccpkl9SwrCYazFezoP1UVC7u15Dh+c0bnSKpDHF6Sa/dnWVOyFi1R2HiHU84o36ua
    YdE/kPxUkO2S7rrMvVVS6l7cQBfP4YWCNNJAATEgH1xyYVOxSLuLmQZx4BdGoRiAckhTVo
    S61Ayb4Wf5ncRlPUzWaXPPLhPHlMhxRhxAVCP16mgVpEaUavAtKGN86Rn7zktZ2wVUN/SK
    Xhg2Ff9xTv1DRo8mIkzjMkpUiz7PByu5/JHbkA2ELN6V+lbCREJqE1Oh+dhM4guw/hkmsV
    siRoc2eFHURGn43lMPC8URpPgSsRTV1n2a/TdmRSRs2wMMtrbCqOv9oturMw
X-ME-Proxy: <xmx:cohGanh4XE3jU4eJPihTgl_X71bXP-nMrlMaBYSmWvR_Pht2D4jIBQ>
    <xmx:cohGaspeiRrMQv_Q8hh7AsPQBoH6mYb9AQJKz8QPpJy6A5ppC9mt0g>
    <xmx:cohGauiqwzwvjD272dPuko5FQKCE4UD-oKKVdg_6aIpxN_rETJz0fg>
    <xmx:cohGauNPhzgfdAJWYAcvGyj7_MCkyu6IiqYiIjIkiXufbZFt-KrjpQ>
    <xmx:cohGaoxg2N-SRupt1Xkshgo7n30SMoTQkToKJbheuuWrTWE5ZV9WzKJ1>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 11:49:06 -0400 (EDT)
From: Kiryl Shutsemau <kas@kernel.org>
To: stable@vger.kernel.org
Cc: Sashiko AI review <sashiko-bot@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Peter Xu <peterx@redhat.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Balbir Singh <balbirs@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12.y] userfaultfd: gate must_wait writability check on pte_present()
Date: Thu,  2 Jul 2026 16:49:05 +0100
Message-ID: <20260702154905.975477-1-kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026070238-eraser-blanching-bbcb@gregkh>
References: <2026070238-eraser-blanching-bbcb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

userfaultfd_must_wait() and userfaultfd_huge_must_wait() read the PTE
without taking the page table lock and then apply pte_write() /
huge_pte_write() to it.  Those accessors decode bits from the present
encoding only; on a swap or migration entry they read the offset bits that
happen to share the same position and return an undefined result.

The intent of the check is "is this fault still WP-blocked?".  A
non-marker swap entry means the page is in transit -- the userfault
context the original fault delivered against is no longer the same, and
the swap-in or migration completion path will re-deliver a fresh fault if
userspace still needs to handle it.  Worst case under the current code the
garbage write bit says "wait", and the thread stays asleep until a
UFFDIO_WAKE that may never arrive.

Gate the writability check on pte_present() so the lockless re-check only
inspects present-PTE bits when the entry is actually present.  The
non-present, non-marker case returns "don't wait" and lets the fault path
retry.

Link: https://lore.kernel.org/20260529172331.356655-6-kas@kernel.org
Fixes: 369cd2121be4 ("userfaultfd: hugetlbfs: userfaultfd_huge_must_wait for hugepmd ranges")
Fixes: 63b2d4174c4a ("userfaultfd: wp: add the writeprotect API to userfaultfd ioctl")
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Balbir Singh <balbirs@nvidia.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

(cherry picked from commit 8e80af52db652fbc41320eee45a4f73bc029faf2)
[ kas: apply to fs/userfaultfd.c and fold the pte_present()/
  huge_pte_present() gate into the existing writability checks; this tree
  predates the marker/return-style refactor of these functions ]
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
---
 fs/userfaultfd.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 29c9941e5ea7..cbd9d610c54b 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -251,7 +251,12 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
 	 */
 	if (huge_pte_none_mostly(pte))
 		ret = true;
-	if (!huge_pte_write(pte) && (reason & VM_UFFD_WP))
+	/*
+	 * Gate the writability check on pte_present(): huge_pte_write() on a
+	 * non-present migration entry decodes random offset bits. The
+	 * migration completion path re-delivers the fault if still needed.
+	 */
+	if (pte_present(pte) && !huge_pte_write(pte) && (reason & VM_UFFD_WP))
 		ret = true;
 out:
 	return ret;
@@ -326,7 +331,12 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 	ptent = ptep_get(pte);
 	if (pte_none_mostly(ptent))
 		ret = true;
-	if (!pte_write(ptent) && (reason & VM_UFFD_WP))
+	/*
+	 * Gate the writability check on pte_present(): pte_write() on a
+	 * non-present swap/migration entry decodes random offset bits. The
+	 * page-in path re-delivers the fault if it still needs userspace.
+	 */
+	if (pte_present(ptent) && !pte_write(ptent) && (reason & VM_UFFD_WP))
 		ret = true;
 	pte_unmap(pte);
 
-- 
2.54.0

