Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273733;
	b=L6xT0BpdtLkR6/pSPdL3xVHCjMTDj9DKrxyz/iiuAQgyTV2TevylYi5L/m6sjoo92yr0
	 r5Yli4jy3VKBqZ95f1NRnQxfuYJEFkMAoXRuXTWt3Br45i5qvgkrI6+mIEJSm0g9GCOJM
	 qZrB7sYQyNBGSCnKwnEA2f3xRDIYQTbCiT2NnB9UWv2tr3zx2nDBTKiYi/4m8si2Rs+l2
	 m1dEKOUwSnCqgagH2/8qI2pJ5YMov7OoXl057dWSVPXdO8z/fTBzBwTFETg9K0FhFCZjb
	 0suxghO/wTymVeggkOb2JhvvHxUt233E2mYiT1i+4UZeXk03ZBFAVNbZE+MfXyDec3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273733;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=/iw81Ukno+/GFpNxlOFNQ6IEIPGlD9QMDmHYLD8gZC8=;
	b=4gLbRT7kVjJFYzhpTF6skZnaMANrF4+Pdwwzl8jqHoQ4/2gTcGoDmJ4TtvUeE+VT+lmS
	 +KKEf6qy0XvM/MACMIhSzkRRThqbZuliZkDi8AI8lbN+e5T+HqU1KEVf89F5YDOKkcJYQ
	 /QPhjOmjntTcRrVb8ISXSuwbPbuTs4WfIAb3w21F5nj8uT08I3MFHYLddqwOFj8XbS7jR
	 yPbg4hevtJG/ZD1U4OZ8hPgeQisstlrURNate7Wbnfnj7g6uHVa8ji3AHXkLR16sdc6Bh
	 Ttq2hn20nCszhY3gapg4K3zJHZRUXTd3mdzwDKbecxK+sRzUzaJRxPx/l0v5cd9/9Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="NuFkjV/w";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C33A60A5BD4
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NuFkjV/w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FBE31F008A2;
	Tue, 10 Nov 2026 01:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273733;
	bh=/iw81Ukno+/GFpNxlOFNQ6IEIPGlD9QMDmHYLD8gZC8=;
	h=From:To:Cc:Subject:Date;
	b=NuFkjV/w/SeSWOxt5tVhKPQ7SEQk1Dggc//AVEHya/yFu01Jnm8XHAKDwCn7pdxk8
	 qCJ51h/cYivAzfVwHYA8pxE4uhDC/IOxy+bAOFG19L7oVNEBh/V/8KBTIZ3h4mEQVG
	 fZt/fjKlH5RGUcik9d2B440+SMcNbJ5amtrutpqdshAACS7Uxfxj4aF6skbhUbIhcB
	 gs8pyzOyHt5eEaI+2XGDQSmRXkiMAdFeJhPcR+b+a7EJchmhnLj8PIL6MwsuqQWVw4
	 6vVlIbbec/yaCCOvldQtofGvut8nivWEST/E9blixdbkwEUU/Z/e4R0Grep1edea3f
	 ni5X1grjFb/0A==
From: Sasha Levin <sashal@kernel.org>
To: samarth.colleges@gmail.com,
	akpm@linux-foundation.org,
	lance.yang@linux.dev,
	david@kernel.org,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	peterx@redhat.com,
	kas@kernel.org,
	rppt@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/ksm: keep soft-dirty when merging a page" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:22:10 -0500
Message-ID: <20261109202210-failed-5.15-2efc6332f18b@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 2efc6332f18bfd848f74f3d5ba45b31450601faa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202210-failed-5.15-2efc6332f18b@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 2efc6332f18bfd848f74f3d5ba45b31450601faa Mon Sep 17 00:00:00 2001
From: Samarth Narang <samarth.colleges@gmail.com>
Date: Wed, 21 Oct 2026 11:21:57 -0700
Subject: [PATCH] mm/ksm: keep soft-dirty when merging a page

replace_page() maps the KSM page with a PTE built from scratch, so the
soft-dirty bit of the PTE it replaces is lost.  A page written since
"clear_refs 4" then no longer shows as soft-dirty once it is merged, and a
soft-dirty based dumper treats it as unchanged.

Copy the soft-dirty bit from the original PTE to the new PTE.

Link: https://lore.kernel.org/20261021182157.1873726-1-samarth.colleges@gmail.com
Fixes: 0f8975ec4db2 ("mm: soft-dirty bits for user memory changes tracking")
Signed-off-by: Samarth Narang <samarth.colleges@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Assisted-by: LLM
Cc: Xu Xin <xu.xin@linux.dev>
Cc: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Peter Xu <peterx@redhat.com>
Cc: Kiryl Shutsemau <kas@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: <stable@vger.kernel.org>
---
 mm/ksm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/ksm.c b/mm/ksm.c
index dbfb8f98b1892..910a1307ac9f3 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1463,6 +1463,10 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 		dec_mm_counter(mm, MM_ANONPAGES);
 	}
 
+	/* Preserve soft-dirty when replacing the page. */
+	if (pte_soft_dirty(orig_pte))
+		newpte = pte_mksoft_dirty(newpte);
+
 	flush_cache_page(vma, addr, pte_pfn(ptep_get(ptep)));
 	/*
 	 * No need to notify as we are replacing a read only page with another
-- 
2.53.0




