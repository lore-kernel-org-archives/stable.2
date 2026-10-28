Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793181401;
	b=ZjxZxNfNR98qIAM1ilYntNsJyAVHiZCIsQSEeJ8D41KMXZ/ek/fn0s7HO/vBaMzL8K3m
	 OHLyCm095n7sRzdosK1rTWvpOy/CmMtF9dhjHpoKv93DhUNqMSJOWzDjND+npfmxryWGy
	 5KqoEXaDyod9GMSu1FZ0Gd/robt9/pN+Bppknza9mvzNXwU+mc6kOrmNuPKovc+SCXArw
	 6cu2XD5goxgqZ73IaVTlE5XDb7n67ERYrKGRMneNBLofN7m6AoJ1/F0SimWOcrhKKeW6U
	 XtbT/fwURRfOedaFpIrF6q9k1J2am/ndsCU7FHKPb02rW5y9dMfNriGIuMHIm1LxEJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793181401;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=tTONV0wfYTEoLkmIvz7RQ+tH1UPTg8CBB7eyk2nMDtc=;
	b=1MjTCJZYJVzYXso4VXNcV6zBcbet3zdnZTHPnGp2LBAi9nnole4QiTwosTI3F4cNrp0J
	 EGHBx3tN9WFhZxK1Zv0am9QsqflUVNZukz3ba0i075+LrObl0XZpLELSPH3YaNrfTxgS9
	 1QWo2FS5JfrjyASJXpuKI5+w/8z/vXT4fsc7yIUqYZr8YDqSBVjIfemXKHRuvYXgS+fjA
	 QBM/yJgz/Hxyx9ZIhTAOMNKycljaHk5nPHWhkU+cL8vexPFDm52gTqdDy6y+UooFKsJYm
	 3ljHFTvJYUHJZSmxeUal5TfvS595kEDzgBY/dynvEqoOmxAdqPUN0lWvkOcK5CAX4RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T7LvDeA4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E90606A31C;
	Wed, 28 Oct 2026 09:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T7LvDeA4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9411F01828;
	Wed, 28 Oct 2026 09:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793181401;
	bh=tTONV0wfYTEoLkmIvz7RQ+tH1UPTg8CBB7eyk2nMDtc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=T7LvDeA4NM/lf+CB9jzmQfHAxXqaA3Ilna6y11k3BHwLYimyi8th7awsune2nKO06
	 9H2OBF61PJCX3HYXXz+7XH7SmhmgJeweeG5IpaOZaOOv1yL7SH0nhtRdSMcr96rkQS
	 NF2FrV2WybzV8IXuBcvvCxOANd7SfGQAjGm4WVcU8DkfAFzoZJ68tcUhc2LYaBDsb0
	 td7m++OEXW8bXS7MrcK8hBRbby4mcy4stf+J8LYOQswXRivoQ3g64SXlYFVta8lg1Z
	 Oq951tfV3xmBNNEkjbAxrjVA2tfiA/V5JEhPYhZcV7gRc3neSLCOlNU5YwgMJDMH8K
	 anruem1gGbZyg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 28 Oct 2026 10:55:08 +0100
Subject: [PATCH v3 10/15] mm/shmem: rescan after nonuniform folio splitting
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
Message-Id: <20261028-fixes_shmem-v3-10-4ce3baf2db4b@kernel.org>
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
 "Kiryl Shutsemau (Meta)" <kas@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2061; i=david@kernel.org;
 h=from:subject:message-id; bh=kDSUfEl5ZNv/axp1FN2MBeYxXzEoqliEBOqbPl2MeRo=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIeHmu6oaGktF8mefv+O1eUsyMWHqrtO7JsXqaBY+PcJ
 6u8DunkdpSyMIhxMMiKKbIEBd83ePlyXW21Gx8zzBxWJpAhDFycAjARd1ZGhlkzfM/qP2F9KKC8
 gnEd0y+FevO9fEtWz1a59/90bW1m30mG3+yfNC47XDzyfNKO7SsaMry3Pm3dc/Giy+E/DhJcd+d
 G72MGAA==
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

The final scan in shmem_undo_range() restarts after a successful split
only if the original folio is no longer large. A nonuniform split can
leave that folio large, so the scan skips the newly created folios.
Hole punching then leaves pages within the hole allocated even though
they could be discarded.

For example, a fault below the hole can allocate a 2 MiB folio after
boundary handling. Punching a 1 MiB hole at offset 64 KiB splits the
folio successfully but leaves the original folio at order 4. The scan
continues past all 512 pages, leaving 2 MiB allocated instead of 1 MiB.
The hole reads as zero, but the pages and their block charges remain.

Fixes: 7460b470a131 ("mm/truncate: use folio_split() in truncate operation")
Cc: stable@vger.kernel.org
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/shmem.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index a686b3d77647..21983cce9fcb 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1478,18 +1478,12 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
 				} else if (truncate_inode_partial_folio(folio,
 						lstart, lend, NULL, NULL)) {
 					/*
-					 * If we split a page, reset the loop so
-					 * that we pick up the new sub pages.
-					 * Otherwise the THP was entirely
-					 * dropped or the target range was
-					 * zeroed, so just continue the loop as
-					 * is.
+					 * The folio was split. Retry the scan
+					 * to find the split folios.
 					 */
-					if (!folio_test_large(folio)) {
-						folio_unlock(folio);
-						index = start;
-						break;
-					}
+					folio_unlock(folio);
+					index = start;
+					break;
 				} else if (folio->mapping) {
 					/*
 					 * Splitting failed, but the part in the

-- 
2.43.0

