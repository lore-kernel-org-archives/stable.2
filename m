Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793799588;
	b=3vBfnDJAdlngbE/yj/yCSaCYzb5UqnQhUTrdepzz3Fg9euibV/IdzocakAbJnQXfxT6Q
	 /I8864ntVRZyZ+W/Eaynqt9NqFpfgZYAIwACfdyq1UZYVjOMAXFPOsrgrmXcVMR84Lahi
	 swyzJ7DlTWI5eVwM01hNURaJN0lWvQL1wL9EVX3S/kcon4tegMCe962DyAF28w2AZd7O+
	 Gr9XGpzW8hcgakXDjaAJHw+4DA+aNCqetwyLlsoZl7hjVsM/NmQuBoZecQIc/xRUe5ZXw
	 PNT3IGUhAzmSlv46p9y+pp9MGCNB865CvqMhSSscZwrb48kbQK2AWvUd1qPpWDR/o6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793799588;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=yl/Gy08XKoe3mtrryXuqQZ/T9p9WbuTrQtwFRw93CUM=;
	b=Nibqw8W2EblnIzMjFz1Umk3GyXtMj39Vs2bFZILoVDlDhbuZeogUEIXRlS13CjcAnx5b
	 nKl8n7gjpwH+d8CYIaQ/wb0ALIrh/kPGHRu6s5YS7m9m85QFjtGNHz/eTV8UMQpDul9tJ
	 73WpBLwrNblkSzd2VFM7O3uA17vKxDfjHlihZ0CZqT3Xn0bI8W3jrJCPgvDZLJq6yJqLY
	 qx3yQxqVnowGBHvuxjdSuMsfV8jeYfMlbbbEdHqGUEwY45No7Wr2nCJ1xHdkPF9cVkB8p
	 SdtMS9PuPzt8WL9w9+5E5L7dmFHSc7g8fd9eKADVnI5URjaH0UWm/IEvwG0JQ+5uccw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="qE3/mUd/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54813606A328
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 13:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=qE3/mUd/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC571F00A17;
	Wed,  4 Nov 2026 13:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793799587;
	bh=yl/Gy08XKoe3mtrryXuqQZ/T9p9WbuTrQtwFRw93CUM=;
	h=Subject:To:Cc:From:Date;
	b=qE3/mUd/0fS47lTDhJ+UHAB3L9toD5JLrtuCB0a4sIOy2OXbxF8D2upCkJYjOMxsK
	 HUzDs4LAof2esm3ba2uoknQhFVlghv2/2+9nnryCvPA5TOsh2r2tUw43HkFwAxHXQs
	 5fqmcFvAB2u0vlZrJHFIVsJDpOdlvaqB6YmJ5URI=
Subject: FAILED: patch "[PATCH] mm/hugetlb: fix use-after-free in hugetlb_mfill_atomic_pte()" failed to apply to 6.1-stable tree
To: david@kernel.org,agl@us.ibm.com,akpm@linux-foundation.org,jannh@google.com,josef@toxicpanda.com,kas@kernel.org,lance.yang@linux.dev,liam@infradead.org,linmiaohe@huawei.com,ljs@kernel.org,mgorman@techsingularity.net,muchun.song@linux.dev,nao.horiguchi@gmail.com,osalvador@suse.de,peterx@redhat.com,pfalcato@suse.de,riel@surriel.com,rppt@kernel.org,stable@vger.kernel.org,vbabka@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 14:39:46 +0100
Message-ID: <2026110446-swimmer-stimulate-cc19@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x d8a9cd7fd2fb01211430c933932da58839b8ca65
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110446-swimmer-stimulate-cc19@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d8a9cd7fd2fb01211430c933932da58839b8ca65 Mon Sep 17 00:00:00 2001
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 15 Oct 2026 18:07:09 +0200
Subject: [PATCH] mm/hugetlb: fix use-after-free in hugetlb_mfill_atomic_pte()

Let's fix another instance where we use a folio after dropping the PTL,
where someone else could e.g., MADV_DONTNEED it once we drop the PTL,
making us trigger a use-after-free on the folio.

Link: https://lore.kernel.org/20261015-urgent_fixes-v1-3-42796911043b@kernel.org
Fixes: cb6acd01e2e4 ("hugetlbfs: fix races and page leaks during migration")
Fixes: 1c9e8def43a3 ("userfaultfd: hugetlbfs: add UFFDIO_COPY support for shared mappings")
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Acked-by: Muchun Song <muchun.song@linux.dev>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: Adam Litke <agl@us.ibm.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Rik van Riel <riel@surriel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Kiryl Shutsemau <kas@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: <stable@vger.kernel.org>

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 16a3abb985be..5db64fa98404 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6520,11 +6520,16 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(dst_vma, dst_addr, dst_pte);
 
-	spin_unlock(ptl);
 	if (!is_continue)
 		folio_set_hugetlb_migratable(folio);
 	if (vm_shared || is_continue)
 		folio_unlock(folio);
+
+	/*
+	 * Hold the PTL until we're done with the folio: the page table owns the
+	 * folio reference now.
+	 */
+	spin_unlock(ptl);
 	ret = 0;
 out:
 	return ret;

