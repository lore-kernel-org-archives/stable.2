Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274078;
	b=IaHKNibazR6Ohg31VpSsBflIbZyYrow5a2RHphgYtB6RVsimCscHQ2IVLbm2MNSF5XMQ
	 cHH8pCrO5W+UpD8Cw0ul8Rn0GU61za2Ru+/yBOsMrJ+KK8o/4D1W+IBBYPWWb20MGpY/w
	 Bl3i/OqILV9vmBmhcGjSTquXCc+WzFpygfCoHJ6s3qBevf02XewgBOqnjZWA5qNmqPKFK
	 VLh+d6LvZWbqhLxhSdZzzUDpSadMbRpvAFvhHj4jbfjEwzQI2jOdv7YvU1RNmmoMyS3qG
	 m4LOrkUyrCshdohi7xQNHCqURFqb7xb5SNJ8G5HM0YE4q8P/3hB1rh2WoU2X0ChjiIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274078;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=hPv56JqfivcljOar7acu1CjSPhKfHH/bt/+ugr8aqA0=;
	b=O7DRI6l+u9y8pNCrYnGjFA4lS/AaBgmH8phzJbfNOvvUdmus8A/3qc8ZevAN74XI0Bvv
	 aSAzDWH/H1gE0UiqtkSp/UMPG7Z27OpalxQlTFs47XNIg3VmT0ya5ifRx7nzwowVCgstO
	 Qn3mheba4frSfZ1EfaJ+a5GB0dhQB0jy7W+WCg5QoWT40K551EGD8nisthGK9pBbPUwcU
	 lEnb7gJbmDzXv9bfvZfd/oiPD3IvlwRasvUI3hXEV2xNSn3UCrAql9rNeE1VFBKGZ83+6
	 SXlq31fATCtQHyUotP4PQHXZcEzl5m1HsfuJQL0MUbtHb7UXvI0fhutRKKzpmeg+Org==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jj+CXz3d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AEA606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jj+CXz3d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ECAC1F0089F;
	Tue, 10 Nov 2026 01:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274078;
	bh=hPv56JqfivcljOar7acu1CjSPhKfHH/bt/+ugr8aqA0=;
	h=From:To:Cc:Subject:Date;
	b=Jj+CXz3drccymgc0PyB/3prEc849CDicIMXoPwaXlny6vMIl3p9sVeipgkiGxkp5p
	 wSu6U5S+KLgI3NSnjocRp4CeUnNM+kcMtQn0wMH+gnpX7asMFzhEW/2U9zPf5/cnll
	 j/k+AuBCqJ16u/QSy0We4LDdgBzeQWvRN+xiNijk0BeYuadAxSKYDNt71x5sTL4Sls
	 Ai+6/BiGKDopcdX8RSX9oShPOV8wVKLWB4lVu2zJYHVKULdUP1NI82dXIfEUFPiKXi
	 GG8nL0eMht/7nIKowSuh4UoPlrvlTrOnmrYTOzMj/AjRrw2rk4bNtdrhTubktlY0Nr
	 xR6GHq2/jMNZw==
From: Sasha Levin <sashal@kernel.org>
To: mason@kernel.org,
	gourry@gourry.net,
	usama.anjum@arm.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	david@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/huge_memory: fix truncate racing with PMD zapping" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:27:56 -0500
Message-ID: <20261109202756-failed-5.10-e6a07d29b0a6@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x e6a07d29b0a60f3a4cfe77fe34eeb4b3fb38d6c4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202756-failed-5.10-e6a07d29b0a6@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From e6a07d29b0a60f3a4cfe77fe34eeb4b3fb38d6c4 Mon Sep 17 00:00:00 2001
From: Chris Mason <mason@kernel.org>
Date: Sat, 31 Oct 2026 10:39:42 +0100
Subject: [PATCH] mm/huge_memory: fix truncate racing with PMD zapping

zap_huge_pmd_folio() removes the rmap before calling folio_mark_dirty().
If this was the last mapping, truncation can skip unmapping the folio
and proceed without waiting for the PMD lock, racing with dirtying.

ifs_set_range_dirty() can oops if MADV_DONTNEED races with
ftruncate() on XFS, when we get the folio set dirty after it was found
to not be mapped anymore.

Move folio_mark_dirty() and folio_mark_accessed() before rmap removal,
matching the PTE zap path. This keeps the folio mapped while updating
its state, so truncation must wait for the page table lock.

Fix generated by an LLM and sent by Chris Mason in private.

Fixes: fe6cf984939d ("mm/huge_memory: transfer the pmd dirty bit to the folio on zap")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
[ david: simplify comment and description ]
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Link: https://patch.msgid.link/20261031-fixes_core-v3-13-d6437171ecc3@kernel.org
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/huge_memory.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 283c4bc8b927c..ce52962db16b9 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2495,10 +2495,6 @@ static void zap_huge_pmd_folio(struct mm_struct *mm, struct vm_area_struct *vma,
 {
 	const bool is_device_private = folio_is_device_private(folio);
 
-	/* Present and device private folios are rmappable. */
-	if (is_present || is_device_private)
-		folio_remove_rmap_pmd(folio, &folio->page, vma);
-
 	if (folio_test_anon(folio)) {
 		add_mm_counter(mm, MM_ANONPAGES, -HPAGE_PMD_NR);
 	} else {
@@ -2512,6 +2508,13 @@ static void zap_huge_pmd_folio(struct mm_struct *mm, struct vm_area_struct *vma,
 			folio_mark_accessed(folio);
 	}
 
+	/*
+	 * Present and device private folios are rmappable. Remove the
+	 * rmap after transferring young+dirty to the folio.
+	 */
+	if (is_present || is_device_private)
+		folio_remove_rmap_pmd(folio, &folio->page, vma);
+
 	/* Device private folios are pinned. */
 	if (is_device_private)
 		folio_put(folio);
-- 
2.53.0




