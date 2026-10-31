Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793440302;
	b=n0+HG8k9Bwhy4RN05yHHhU/je300BJXbym4GHcYVzX+2ZjcQoJXzp03TSbgXkRqDiijW
	 mRQBVgn/RBgrMoLPy2IeMorgfpiD3x8anHo4sj9wa0QEXkIWrjY3JUn2Svpb7hy7yBIfr
	 KYqJQgA6jbmqVkjSiwwn+/xGKAcva4P1hGSmw5PY5kwX7QYhLuMWYX0ipFZrUMq3WA/wO
	 Y1zsqeAuQ8uyNmIThs6Tb3A+aY6que6zfGar934Y1ddJscVgP5xzqRJ1fuFyGkZcN0Nap
	 2YjCtP5EiCC/e+xCVTEn9AyCAz78sk/iOGsZSDvQRyccSGuaHeoPEiwky2MqxL5M/zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793440302;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=/pp7BZen6g6ZjSOvHMxJEmd8Vj24oFI7u7jvugD7NkE=;
	b=wUsmBVXiha0WIpbgYvE6LNWIX/vFr+isJPYKQ1hfUBARg4zD80XO6D76Gvu7bQMPYMwj
	 RNQ6VCMFPjC2VELawMdddFoDv+3sIoJORnMWBrbSgefJJdSOrbUYQi/Nuj8IlNbuIJXxP
	 BiLPWpQTZGpl9F/yFa+2hu/ZEH5tevPwgFLIBRXAHYAvdPVy2hqMUzzyPy+8r5KhP6KLB
	 F9bv29Mkg5IyFXcBMLYPEk+zaDBJwfHLJ2JWOZeEExArL1YlAohQNKmafDyMgKzX0IZ3U
	 waQYzOleCccSRc2of0CKh6klOHFlYXKdXJPiBoMf2hsnyPwaebHkt7CzsMlZ2wmurqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TJMD5efz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532D9606A31A;
	Sat, 31 Oct 2026 09:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TJMD5efz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6853F1F00919;
	Sat, 31 Oct 2026 09:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793440302;
	bh=/pp7BZen6g6ZjSOvHMxJEmd8Vj24oFI7u7jvugD7NkE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=TJMD5efzjo4MGr3Uznn4+DxGJ2LTsbfx/ixDORmcgblTHIc68BYMwsNK6C6VWarFo
	 VfGxg4J667C0pUzinEZwWnLhOacuZCEJq2ulYqBUnj90/yzWCfZHwxpSUiv+LhkUiG
	 2g+RQFhd0JaIpZDnVyTCNCRiqXE+WZm+2RQpFaDQFuZ1Dce2O0g8gW1CyyXRvHw9ir
	 /HwHDBTfRFw4DkC+sW/RAKJJEwJNZmhRHjRY+XKqD2hoRW3BP9261rOH7GeSD2JvM8
	 +qDHXnKc4uHO1cLUJhbjLE+cMq8WjoOTsw+9Y0WcbG28rxC/xGwj3mDwdrQ65IPoc+
	 LKTDSrnbIvsuA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sat, 31 Oct 2026 10:40:13 +0100
Subject: [PATCH v3 44/47] mm/vma: don't leak the charge for stack growth
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261031-fixes_core-v3-44-d6437171ecc3@kernel.org>
References: <20261031-fixes_core-v3-0-d6437171ecc3@kernel.org>
In-Reply-To: <20261031-fixes_core-v3-0-d6437171ecc3@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>, 
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, 
 stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 Muhammad Usama Anjum <usama.anjum@arm.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1343; i=david@kernel.org;
 h=from:subject:message-id; bh=8bDRWBq3PVps+Kl5GQHMx97Trak1vEreOi5AJf6aDXw=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLKebs+e6Fb6o77Y2kyxI9fh098PPTsYn8Ve/y33csXEs
 1FH51kpdJSyMIhxMMiKKbIEBd83ePlyXW21Gx8zzBxWJpAhDFycAjCRGAVGhj3r1iW0ddxJ5Ax4
 szRZOe4ld4W8pr/US231ved7Wr4ozmdk6PnH0vQldb1U8doXllndroefxJw0c2G/8qFHUoSLde8
 CJgA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

acct_stack_growth() charges stack expansion even without VM_ACCOUNT.
This can happen for read-only or MAP_NORESERVE mappings created with
MAP_GROWSDOWN. Unmapping these VMAs does not release the charge, leaking
Committed_AS.

Only check and charge growth for VM_ACCOUNT VMAs, matching mremap().
Unaccounted growth skips the overcommit check while remaining subject
to the other stack-growth limits.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Reviewed-by: Harry Yoo (Meta) <harry@kernel.org>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/vma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/vma.c b/mm/vma.c
index acdf00346cda5..695d0be85ac86 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -3391,7 +3391,8 @@ static int acct_stack_growth(struct vm_area_struct *vma,
 	 * Overcommit..  This must be the final test, as it will
 	 * update security statistics.
 	 */
-	if (security_vm_enough_memory_mm(mm, grow))
+	if (vma_test(vma, VMA_ACCOUNT_BIT) &&
+	    security_vm_enough_memory_mm(mm, grow))
 		return -ENOMEM;
 
 	return 0;

-- 
2.43.0

