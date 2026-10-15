Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4EB559301;
	Thu, 15 Oct 2026 16:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792080510; cv=none; b=Ol7sZT2syrwOPE7Mcq75o+h+60u10DjxKJw8YUMXNbbaECc5YHAejDJ5SONxehf2ALJjZxHHt+wOtmC6AFTMs1UQ++OQnV413GYT8vyHa4iibw0dDXw3LqBpnmU/lWVulOWQzZrsSnYQGqCDOqTrZ3E12DxPOWx8W5ZpGx3ViIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792080510; c=relaxed/simple;
	bh=ofcXbd6OOZoV/XLvMGg3PkUCMySCCrJuOQSO/eipRzw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KM5589mWEEQI3lSIMOfgeXk/L5pWETMZNnSH+Xjjq3PgAH3BKYSlKVXQwZEFLaAGuRn4tiOvUCCklZIwaUztpcdPPNSP0FkHMUsVKj3dKRHP2kxTTacF/xfdAmkugmYu9z2u/vKNnOMPcnBbjK6jvJzzJb6OHCxoKwik9qgt94s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYhfvFO4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYhfvFO4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B770A1F000C4;
	Thu, 15 Oct 2026 16:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792080493;
	bh=3afvpKZmu+aKIyTGjKM2wG2gBoeR2hpYzLmhDcjm3gw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fYhfvFO435HJX8G2tJtP76UAXmJ91Nqa2hGQgcoVIF+DmlQd1+edSNcaE1eEqpnvg
	 slM//rKzJmgasqG4T3BL8RHQwMQn7VfrN/UPyCvclOS6KJ5zuXQcJcgL2EIsAUCIy1
	 +WE8HwVO/tfCMQ7iqK//NkgCsprNmQ6irdFK4X6ROpiLwhn7QRz8ZL4dYlFDe1GRc/
	 YhOk4ISazQ9WQfsOxGSynufEw9x+vERdRgx4ENL4OqQwd5dWVDS+Zz7dWB0MZ7rlWy
	 hsz2tsA2CD7DotS78D5FBwfpxg8jVm5OFin/K4HDru4o6SZ+EJryWcMmEpvlmqv5tf
	 ea2VqumbPfPtw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 15 Oct 2026 18:07:14 +0200
Subject: [PATCH 08/10] mm/hugetlb: tolerate UFFD_WP markers outside uffd-wp
 VMAs
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-urgent_fixes-v1-8-42796911043b@kernel.org>
References: <20261015-urgent_fixes-v1-0-42796911043b@kernel.org>
In-Reply-To: <20261015-urgent_fixes-v1-0-42796911043b@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>, Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Adam Litke <agl@us.ibm.com>, 
 Mel Gorman <mel@csn.ul.ie>, Rik van Riel <riel@surriel.com>, 
 Peter Xu <peterx@redhat.com>, "Kiryl Shutsemau (Meta)" <kas@kernel.org>, 
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Josef Bacik <josef@toxicpanda.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1330; i=david@kernel.org;
 h=from:subject:message-id; bh=ofcXbd6OOZoV/XLvMGg3PkUCMySCCrJuOQSO/eipRzw=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIu/DKO/u4dbn2Vryjmo2WmyN2iOelftGYEZC9wuDY90
 WSiiHR9RykLgxgHg6yYIktQ8H2Dly/X1Va78THDzGFlAhnCwMUpABPZ3crwT2ESC8MXne43+r4x
 hk+0nC/qmUf0JDC8qko3dEoXW6yRzfC/sHDFvMK5Jk+S43JFfEuiegWWbtqYekwm2/3cBq47233
 4AA==
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

UFFD PTE bit handling is a bit like swiss cheese, in particular with
recently added RWP mode. Having uffd-wp markers outside uffd-wp VMAs
already confused this code in the past and resulted in uffd-pte bits
confusing other code later.

Let's play safe and just ignore these markers in hugetlb_no_page(), not
silently propagating the uffd-wp PTE bit.

Fixes: 2d427bb01639 ("mm/userfaultfd: add RWP fault delivery and expose UFFDIO_REGISTER_MODE_RWP")
Cc: stable@vger.kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/hugetlb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ba6860b9b7f4c..1548a6156206b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5939,8 +5939,11 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 	/*
 	 * If this pte was previously wr-protected, keep it wr-protected even
 	 * if populated.
+	 *
+	 * TODO: fix all cases where uffd-wp markers remain in VMAs that are no
+	 * longer registered with uffd.
 	 */
-	if (unlikely(pte_is_uffd_wp_marker(vmf->orig_pte)))
+	if (unlikely(userfaultfd_wp(vma) && pte_is_uffd_wp_marker(vmf->orig_pte)))
 		new_pte = huge_pte_mkuffd(new_pte);
 	set_huge_pte_at(mm, vmf->address, vmf->pte, new_pte, huge_page_size(h));
 

-- 
2.43.0

