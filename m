Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793007700;
	b=NYDywZzHDENGmLvF5DDb8XhpSTxGJ4wTPuONYYrFZnVG1xMlJMvDxatl4YZWxJE44Z+O
	 KMeGStAlXkiA9tKD3Ihu75mhrIkkvr8RiZqpLZ2dysvl6qJmf2uR/wTK+3F5/6Gp+zspc
	 MWyfsmdWBBWGRWuEsehH8qGXkEM1FLQBYm0EJo+56VitEGm9EHXZDmcjXjX9jLTQeUHug
	 taRJ+b/c1veT6zA04gVfM05ndUQNoAEaC/8bOtVKrLexSnIZSwY1+4U0dX7G5FxEhVOs9
	 v8qsumPd+bOq9tkOhq4Tpy94zmp6FjakaYreIo+shjybuJA/JEiFwmM9KLuZer2iPlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007700;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=CIB2Xp6FjBPfWS9jhb1q/bROMQT4vDagtnjeVLmjTUM=;
	b=PDfUZIktvw4llCYDchdZMsSVD6/KDMcjygDAB9WQYvSsHIBAGznj9ct941jl8ZnIVkHP
	 IyUWKfmiGu60kfoeCmLMh68wtp7QLdaUIF+TzRLW4A9mMtNhyLDw1210ZKerlbtBB64C+
	 zyk48rvioJ3oKaD6WeLBhCLD6XzYKDJSdgNt75hhSnmwNuSXGCzs9J7FWZrQsPSrTQlFQ
	 oalyfD0ZIEVMTSIFmyA+5zmvOUlrwwe1FECRWZUmv3N/JGlVXSMtFDq3n1OcX9CP0Azcn
	 0dYOu/iZFf+WhAS715AJe0VwRTTR7bsjDl4ps57Eapchjll0GucGancyVRH2/YancHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ECoyWcuI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F7F60A260B;
	Mon, 26 Oct 2026 09:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ECoyWcuI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 795881F01829;
	Mon, 26 Oct 2026 09:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793007700;
	bh=CIB2Xp6FjBPfWS9jhb1q/bROMQT4vDagtnjeVLmjTUM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ECoyWcuIHIReO2k+iIdaYY8Ll7Js0j9eSWRMUmexY4LkObZJB9hP5F6W2Sf52Ez+j
	 d7v5vtc9JYSvQ77qguCbQNaO8inCIjJCWinneteD/a/f3f5sxFJeulAfMmHrIvrawz
	 jfOnrUqIRvThcVKmlmEE+1bBUv/XTSs+eCBJTDtAY/GxTxRe5kgUwfXfTNjocEgQC2
	 HqO7Yfs+JKPBWc8amDBDjnkOqOcdANQo111hNA7EdURwvoWplwz8huG06BMAE1cZR2
	 XFPKtSoFJU4RtMju6iioBaePP3nxY1YQJ/lhQFvZpBmASO8b71VgXje83CGrXq2qpa
	 4vrTGXMchv2aw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 26 Oct 2026 10:40:40 +0100
Subject: [PATCH 07/16] mm/shmem: avoid moving the truncation start
 backwards
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
Message-Id: <20261026-fixes_shmem-v1-7-703206d5fa0c@kernel.org>
References: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
In-Reply-To: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
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
 "David Hildenbrand (Arm)" <david@kernel.org>, 
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1657; i=david@kernel.org;
 h=from:subject:message-id; bh=huOOPo/PWB8ZiXeYAxEnPQiR96JDBCTCFnb0WNlFItU=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLuK4glHA5bnhB5xEfO8sQz+YNnknYbB6eKbFz5daH6i
 dTFx/bwdZSyMIhxMMiKKbIEBd83ePlyXW21Gx8zzBxWJpAhDFycAjCRzCJGhjOVyzrbvwl6W++e
 MM3xz7Oc07mMHpqMTjlfjidf2J/UXsHI0CCwJeda5c7tYgk/vrNGTXsdIXIt+/znJerbPjzlX3G
 tnA8A
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Chris Mason <mason@kernel.org>

A nonuniform folio split can fail with -ENOMEM after splitting off some
smaller folios. shmem_undo_range() then sets start to the end of the
original folio, which may now lie before the truncation boundary.

The final scan can consequently discard data below the new EOF, or
keep retrying a large folio whose split point lies outside it.

Keep start at least at its original value when skipping a folio after
a failed split. The part in the truncated range has already been zeroed.

Fix generated by an LLM and sent by Chris Mason in private.

Fixes: 7460b470a131f ("mm/truncate: use folio_split() in truncate operation")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
[ david: split fixes, simplify descriptions, adjust comments ]
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/shmem.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index c551e33c697fe..2410ec46ee1d1 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1388,7 +1388,13 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
 		same_folio = lend < folio_next_pos(folio);
 		folio_mark_dirty(folio);
 		if (!truncate_inode_partial_folio(folio, lstart, lend)) {
-			start = folio_next_index(folio);
+			/*
+			 * Splitting failed, but the part in the range is
+			 * already zeroed, so skip this folio. The failed split
+			 * may have shrunk it; do not move start backwards and
+			 * discard data before lstart.
+			 */
+			start = max(start, folio_next_index(folio));
 			if (same_folio)
 				end = folio->index;
 		}

-- 
2.43.0

