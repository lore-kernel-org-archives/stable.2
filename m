Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793387517;
	b=3K96wHdCByHFcY6seNoz3EuGO0skSzVmWzR8PlxAAqziM9HVfp0M/4z2a+R11BIZKfS9
	 SzRpHVYYzM9PmY9+2r3UPghjUo4t9YVH1/+wNBgfyrMhUa5GtMab+ekIZyBc1Cm9LdcN1
	 qZ3Y2UJavwoEz/YDXdDz5vsnqC7Kz75h+GGOnNIftMMZO6AVx8Ko871Vqx+9TyPK02QJf
	 iRCQqr/+Ks/4DNvOJIAG4vM/t+9bYo6qLJWlp75C8KH+s2JBaI8ED1ai1zdante3QLjjv
	 cwQBOmyKtbe3MIghaSuBQjJDfBLY79H2BuF7p6kVpfe/BQmHAvQRGEKdVf649ieS8nw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793387517;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=AdjV0Dc6jq/EF2upr0RQlEptHizYdyJQMh7DJ2M0kWc=;
	b=5K0qaMoXLuvkCYttRMRC3KtqJOGX1Zbn0u8Hn7mEgFNXT6AZbOJyaDUtY770mNf8fU2M
	 +uTS8qkMzI8JwKsWbqBY5ykqaICk5gQAtTyZ4kwNpNiHJU/6oKCiGWlAIo9v6RlzmDc1F
	 STEg99aY5hotzvYGafheT4BALOmriAy8WaQC5MBAmYLAN2u1JEgPT0Dbrn8V8/mot7oTC
	 690TURlu9UsSXlViDtZF7pIwQ7ZZ4LxdrVUqYycoT6bElipgBCYo5jABNy6OvBpIa2BnS
	 lpvSUVRo4I5PSdNGxZmX6Hgocux1Aw1lHj3QBxDwrpRz69x8POAXCUMS8dnmYOCB/dQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iWeVmgHp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62565606A31C;
	Fri, 30 Oct 2026 19:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iWeVmgHp
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793387517;
	b=KL2zpdG3oBasmC8bvaCpdFwRkSHmaQ2Se7DPWfQvIB4hU2OSGIfPUALiyah5DPKQN0eR
	 EAnijLEqmamQxEiVZHm7qHe6rLQve6afLbJJoynVG2r2Bq1jvnWBs+KLgpAXGR4WsXQcw
	 PzqevpDTpXOwkA0kv92BnMsA/09JmKBHN0cJvlurkjQJUz+6MSmN3nvkwerdEGTpMxZpk
	 i581m3WZFr1aWNVsYJDept7Gzl/pTWVbMR2hfaJwTpwF40QsUBChdu8gki0eUVv3psmn7
	 /b/Gh1h9rqLHYP8n1tV3SYhN8Xuo2uJBXWPezTIVrp/PebJ1Sf8giRcnFsgwmgz2f5g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793387517;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=AdjV0Dc6jq/EF2upr0RQlEptHizYdyJQMh7DJ2M0kWc=;
	b=udeviO3Gi2lELJ9IAkUM1qutiyo3hJ7q+3t4hNTKzRQGjKJnfPpgWd+YXTBhPVDUjD41
	 SIM0gRiNZB9Qb6iFe+sfazgrOrY8WsKOmJayDxFfZ5WaoTkbufZYNr3fkHUFaYK0g5o76
	 OOsfb5v86NvMgic0622TlNR4DfbZR+p3zrOXPhQhXUV2ipjr6X6zqDCL/0VQmu3AaimPB
	 2D90M6MQB6+IX3USGMS5BzfNYYuFz6EGxW8qfpExTCAVBRhTAfDhEsW/7bLCOSx8AAbsg
	 jKzk1hi05sxLKYPV+MbsAI3aPNfOG5gpjyY9EC1siVrxny0jf/dyDWIERz/heUX4qAw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id AE72F1F000C1;
	Fri, 30 Oct 2026 19:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793387517;
	bh=AdjV0Dc6jq/EF2upr0RQlEptHizYdyJQMh7DJ2M0kWc=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=iWeVmgHp6u9S6Dqzfpc97M5zvM7sSv8dHy1CP8A8IzygwlYP/cWh9k3Ux0KHDX0aP
	 jH6CTqkVLCPAd+X6yeMZkL4dWx/apTJtmrN1AwUOMHpG8VcMBUxth2G6vUP6m3SmN+
	 jzGeMQeG5T4InEf76LZ3Lhq15c29fp7FLydadra8zlslOZDdgJSGo8TMHTxrUdJvCt
	 NZz6/URB88kqxzElxgbYTvFqjVuGWyrrPLPBZeNsaRf9zFInKUBmIqRbpDzpoD+D9W
	 ozjJ/kLT79viKYg4LyZNrUq2IxGb+ba0ltprCXEcnHRJFP3D/utO4kYakAuUO8586Z
	 Q4Bk9G+Z12OEA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 11DE344258;
	Fri, 30 Oct 2026 19:11:56 +0000 (UTC)
From: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>
Date: Fri, 30 Oct 2026 15:11:56 -0400
Subject: [PATCH] mm/swapfile: drop a large unmapped swap-in folio in
 unuse_pte()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261030-swapin-large-unmapped-v1-1-41e4ae378e6c@columbia.edu>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBCF4avIrBtItAzqVaSLGEcd0RgytQri3
 ZvW5cfj/ScIRSaBOjsh0oeFV59gHhm40fqBFHfJkOscjS60kt0G9mq2MW2bX2wI1Cl0ZY+ElSn
 xCekbIvV8/LvN67Zs7UTu/YvBdX0BHaXeEXkAAAA=
X-Change-ID: 20261030-swapin-large-unmapped-6c8f6e691864
To: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
 Kairui Song <kasong@tencent.com>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
 Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>, 
 Youngjun Park <youngjun.park@lge.com>, David Hildenbrand <david@kernel.org>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, tz2294@columbia.edu, 
 stable@vger.kernel.org, Mani Tofigh <mt4022@columbia.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793387515; l=3373;
 i=mt4022@columbia.edu; s=20261026; h=from:subject:message-id;
 bh=M5/KO6o7bnSBNa94hHZzVGfNGuYH0esspd9WRLUeAHc=;
 b=cIsKIDl0qQSY2um96QQTOYkamZ7uRYzZl1nlZY3LrPTIav2GwYO+9fh0WEiVTcunORwAhWyfD
 iZdb7qZTFvbAZ5oIS0wj85ZlQtwX4r1SVsUX3AYTao1ICRnufLRulAA
X-Developer-Key: i=mt4022@columbia.edu; a=ed25519;
 pk=gljCMQDuxyKPmd5y37CRpEJGSPXDV1MyAnHBhCgXl0I=
X-Endpoint-Received: by B4 Relay for mt4022@columbia.edu/20261026 with
 auth_id=1322
X-Original-From: Mani Tofigh <mt4022@columbia.edu>
Reply-To: mt4022@columbia.edu
Content-Transfer-Encoding: 7bit

From: Mani Tofigh <mt4022@columbia.edu>

Since commit f1879e8a0c60 ("mm, swap: never bypass the swap cache even
for SWP_SYNCHRONOUS_IO"), a fault can read a swapped-out mTHP range into
one large folio in the swap cache.  The folio only becomes anon once
do_swap_page() maps all of it, so if the faulting PTE changes in the
meantime the folio stays in the swap cache while not being mapped or
anon:

  Task A (fault)                       Task B
  do_swap_page()
    /* swaps in large folio F */
                                       madvise(MADV_DONTNEED)
                                         /* zaps the faulting PTE */
    /* PTE changed (F not mapped) */

swapoff then maps it, which marks all of its pages as mapped and
exclusive, and the next fault on one of the other PTEs crashes in
do_swap_page():

  [    6.424485] kernel BUG at mm/memory.c:5195!
  [    6.424503] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
  [    6.427654] CPU: 0 UID: 0 PID: 67 Comm: swapmthp Tainted: G        W            7.3.0-17087-gd865f2677c44 #1 PREEMPT
  [    6.432665] RIP: 0010:do_swap_page+0x24eb/0x2fa0
  [    6.451035] Call Trace:
  [    6.451567]  <TASK>
  [    6.453841]  __handle_mm_fault+0x13b5/0x3b40
  [    6.458525]  handle_mm_fault+0x16f/0x480
  [    6.461143]  do_user_addr_fault+0x312/0xa30
  [    6.462044]  exc_page_fault+0x66/0xc0
  [    6.462846]  asm_exc_page_fault+0x26/0x30
  [    6.476708]  </TASK>

do_swap_page() already drops such a folio from the swap cache when it
can't map all of it.  Do the same in unuse_pte() so that swapoff swaps
the entries in again.  With the fix, nothing is reported.

This bug was identified and confirmed with the help of a deterministic
hypervisor currently under development.  The C reproducer below however
hits it within a second.

Fixes: f1879e8a0c60 ("mm, swap: never bypass the swap cache even for SWP_SYNCHRONOUS_IO")
Cc: stable@vger.kernel.org
Signed-off-by: Mani Tofigh <mt4022@columbia.edu>
---
This conflicts in context with patch 41/47 of David's v2 series [1],
which changes the line right below in unuse_pte() for KSM folios.  I
can rebase on top of it once it's applied if needed.

[1] https://lore.kernel.org/all/20261029-fixes_core-v2-41-a64ce7f83abb@kernel.org/

Reproducer: https://github.com/manitofigh/files/blob/main/linux-repros/swapmthp.c
---
 mm/swapfile.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 189f04d8838f..b0b75ff16835 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2518,6 +2518,18 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 	if (!folio_matches_swap_entry(folio, entry))
 		return 0;
 
+	/*
+	 * A large folio that is not anon yet was swapped in by a page fault
+	 * that did not map it (yet). It can only be mapped as a whole, by
+	 * do_swap_page(). Drop it from the swap cache and swap in small
+	 * folios instead.
+	 */
+	if (unlikely(folio_test_large(folio) && !folio_test_anon(folio))) {
+		if (!WARN_ON_ONCE(folio_test_dirty(folio)))
+			swap_cache_del_folio(folio);
+		return 0;
+	}
+
 	swapcache = folio;
 	folio = ksm_might_need_to_copy(folio, vma, addr);
 	if (unlikely(!folio))

---
base-commit: 5e6c45aaaf93343c7f8a1cde9797080238af5c1b
change-id: 20261030-swapin-large-unmapped-6c8f6e691864

Best regards,
--  
Mani Tofigh <mt4022@columbia.edu>


