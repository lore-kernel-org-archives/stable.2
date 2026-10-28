Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793181416;
	b=vyloZtLU4C4eKLokysramI7IUqzYzYRdkFsc5D55JB01gs13gXklqUiVMZzp5EBGt+Ur
	 SiTlJyJzR4hJMh1koS8KnuDVYbtH59MKeRI+WbTF5Fv6vrZzmMVEDA42VrPuz3B0YrBZ0
	 lCL17dS6Ie+JItI65xJI6MuP6vhMyaKNxGszSN6efFipwMnjjXAdjXooHNFvETPROk8eB
	 4k8ue1Yf9RbQbePSzRSS/SF65mIJEf4/drMT9d8S3BtFqC+5v0+rOjVRPALP8ABOV2UFA
	 0k31j0/jRdMM2pbS3HhrDTzmJpj2pLkI5rp1iFQDFW9P02IYcZBajIRlw6vUmqsK+cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793181416;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=fBVhEWu9nfuqFZTQHurOtPzvVYkt3WEwnKrb2ymcoTk=;
	b=qdFS/bPDG/tfDSkuTTczi7JFPiKgpt/DFoSt6NlzeJ4Qk6d2+ALc9BfJyGIq8OaXkAHv
	 J36Eb3quhEc5lOSuzMpQ9fp/d0tLbEK455rEkYN5jDiUV9QjNWV9Zc6C3x3+qZPvrxlKi
	 Zt7pUqB606WxtxB/wpgPAvywNV3greeNEQdFzKpeeUU05bwKN5yfBYzXxHadB46h5idj3
	 A1ecmso+0GyvKx9N3OR+bQCNlPlwl5npqu4S7gFA7PC9ky0yC1R5B9k2FoztrGm+tzqxA
	 /msT5sDOx5mdMn8dW9yzl0dnTHSL+R7iwgRxyOhokSdH7sS9KZQGmLeryW1L9vHgy2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BnuvrBYU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795B1606A31A;
	Wed, 28 Oct 2026 09:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BnuvrBYU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F8F1F01828;
	Wed, 28 Oct 2026 09:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793181416;
	bh=fBVhEWu9nfuqFZTQHurOtPzvVYkt3WEwnKrb2ymcoTk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BnuvrBYUBhtuVudpLVQFk7PTkGc1/2OHBORTKrrdUPdhyyLTA+aEAFCQYcKtVsqpq
	 JyeJUGzh0K9NYkWa1FeM/X/0fw+efw5OHCwcktCgxNrZZXOvOvgU+zU/C4cRREShNE
	 yQQBbF0QlOATqnnD0cXbnSfnREofEE/T0eX2KY3pRTpuDfCD915Y23fkcVQhPITddk
	 3MI2Kf7CEVUuU4AJVd4AaMeARN99dDGPGgd1nz4sNveyeRSIZr/QJ65dhUWebuOTPm
	 hBCASdPeTl7vqkF1rcwl7TKhrB3aFt6aXQerIW+szxb60QiDAxTGOPsbLpRAubdySg
	 6znWiHu38tJxg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 28 Oct 2026 10:55:10 +0100
Subject: [PATCH v3 12/15] mm/shmem: preserve allocation errors when
 swapping in large entries
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
Message-Id: <20261028-fixes_shmem-v3-12-4ce3baf2db4b@kernel.org>
References: <20261028-fixes_shmem-v3-0-4ce3baf2db4b@kernel.org>
In-Reply-To: <20261028-fixes_shmem-v3-0-4ce3baf2db4b@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Gregory Price <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, 
 Vladimir Davydov <vdavydov.dev@gmail.com>, Michal Hocko <mhocko@suse.com>, 
 Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Lukas Czerner <lczerner@redhat.com>, Carlos Maiolino <cmaiolino@redhat.com>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Daniel Verkamp <dverkamp@chromium.org>, Jeff Xu <jeffxu@google.com>, 
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 David Stevens <stevensd@chromium.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 William Kucharski <william.kucharski@oracle.com>, 
 Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Nhat Pham <nphamcs@gmail.com>, Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>, stable@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>, 
 "Kiryl Shutsemau (Meta)" <kas@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1547; i=david@kernel.org;
 h=from:subject:message-id; bh=4yVKTbJ/EVLH2SOhJr916+b19DoqdwAsmSvxp0HdkpE=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIeHmuqMu2y/ehinHT12ZFezdr10RHv3XUbr0t9D9bnk
 m1tfBbQUcrCIMbBICumyBIUfN/g5ct1tdVufMwwc1iZQIYwcHEKwERaZBj+h1zZd2pVrdKq//NY
 xWZNiEgx+ucawuTzgW239SHxP5MePWL4p/fu7+SNXUE8P4rW/s1/bm/NvCzr7pEpCb/uJfMeysg
 y4gMA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

shmem_swapin_folio() adjusts swap to the requested slot within a large
swap entry before allocating a folio. If allocation or charging fails,
the error path compares this adjusted value with the original entry
still stored in the XArray in shmem_confirm_swap().

Unless the index is at the start of the entry, this turns -ENOMEM into
-EEXIST even though nothing changed.

The caller retries -EEXIST, so persistent allocation failures can leave
the task spinning instead of returning the error.

Restore swap to index_entry on allocation failure so the existing error
path checks the original entry. This preserves the allocation error if
the entry is unchanged and still retries if it changed concurrently.

Fixes: 91ab656ece13 ("mm/shmem, swap: tidy up swap entry splitting")
Cc: stable@vger.kernel.org
Reported-by: Josef Bacik <josef@toxicpanda.com>
Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/shmem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index 59907556369f..da2f5cd37eee 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2552,6 +2552,8 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 			else
 				error = -ENOMEM;
 			folio = NULL;
+			/* Make sure to validate the original value. */
+			swap = index_entry;
 			goto failed;
 		}
 		if (fault_type) {

-- 
2.43.0

