Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793007721;
	b=cpuB6yyCJSSqmEfh+JynsEiVTucSOz0kZ+ngDfuCzZaEUnMJv+LLZ2FMk/tDzzFPcfnf
	 E6UJ3r4Vl87icuNb9IrkmlgyuMnzBArejAMc8Dx7o2m8imfpSeHKhmuIZIw8x75aq/hSw
	 6UokG7IDhwX+Rg4jwcj9weNsYrl4EgmWX+zVKkSNPR9N4Fw82kBfcMejUObIcY+nzoufZ
	 yWDzUXNVp+XBD274/hIj64RIvFSQKPfjda9mpv8Dagu47LFwp670TDx2yIoeNsNoNuzfq
	 SkM1IHMqxwTRIWJUi/yha3nFGZmE0wWJ6at7e9aF3Iz1gNfi80q/+nQW3IDfwLNml4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007721;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=YkrD495PT8KvXx+wacfeY6qqrolNrkaLFRbD+03i/Eg=;
	b=Yay6xxK6fIdYW4dy0bWcdy1RlaAedfOZ2BLkGuXr0+UEJPJEVgs1lnZrLu//tMb0JCQR
	 Hh3/gZ18nh7OYoGRV3/7DXQomuDH/hRkb1YsI6sdH2eATEa/NTeT57FjtvG4FULUW4/9n
	 3d6h/f1hlUk1cGj3x89wjH0yCt7C8p6pR9omyYFxBW4AUERVJPL26qDG/NiGdjHAvd2uB
	 J/N1cIyLWQ9/J08Iu8OAJUbiNhk1WwbzDq5fVQkkTIs0i3t0MLAOMdzkJ7CkVV/lEsSN8
	 /Qs2+us2+WaP5Yc2O/6kWbjPLK0qG76t2bboZbu6IHghKyrEyQ28Wj8NjDo6/fKTo6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RD3sTveD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4444A60A2615;
	Mon, 26 Oct 2026 09:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RD3sTveD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD3411F01484;
	Mon, 26 Oct 2026 09:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793007721;
	bh=YkrD495PT8KvXx+wacfeY6qqrolNrkaLFRbD+03i/Eg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=RD3sTveDzjGei9ZxgcQN6iTQA2b4yENz2Yit9n4466aEJMlAu6z9PFAzI6/FU/0Uq
	 Viy1tyjil7OQWK2Bz71ERrByrRIYCdxdsNg1jXWbn5EVdW6itNn9FDvhEB5raZFqSB
	 Pm/Jw76+aSwl+yZXm2fpiz1prpNkAFmwmbCFV9fhW1vhPhzn9fdD10Z6VcbexCJp5Y
	 8/zUKwKW73mJunbf5MawWUyaDKMeC0WmnlmUOx61twLF+wEYioiufl24zMwnwfqcPP
	 CtKrEVFYK4BHSmt+Dgyv/KPfH5BowWUX/6/fIpFh7K7z2CnByP+WG8cIR/CicfkbJD
	 4sGJmawRxoi5Q==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 26 Oct 2026 10:40:43 +0100
Subject: [PATCH 10/16] mm/shmem: discard whole new large folios on
 fallocate rollback
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
Message-Id: <20261026-fixes_shmem-v1-10-703206d5fa0c@kernel.org>
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
 "David Hildenbrand (Arm)" <david@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1380; i=david@kernel.org;
 h=from:subject:message-id; bh=eBeVwVosSjmZ+XFjtnKWT7CD12JlDHJ8L0A3Idph/fk=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLuK4jv0J8702rX9uabOVdKFacb/rjRxBB51rKf/cvPM
 4kpD6fZdJSyMIhxMMiKKbIEBd83ePlyXW21Gx8zzBxWJpAhDFycAjARNXOG/1F37ve8vl41fX7C
 LhPhaRksc95pS6nGFy4o/V309Gvw7zxGhuO2u9a26PbzzDOpk1Y/v2+F6USvNefW2Py7/9EyJVi
 ajREA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

When undoing a failed fallocate(), shmem_undo_range() must discard each
newly allocated folio. Its second scan instead passes large
folios to truncate_inode_partial_folio(), which does not necessarily
discard the entire large folio, but instead tries splitting it to
discard only the requested range.

For example, with huge=always, a failed allocation starting at offset
4 KiB can leave page 0 allocated in an otherwise empty file.

Discard the whole folio when unfalloc is set. Note that we enter this
path only for folios that are not uptodate, and can consequently be
dropped without losing any data.

Fixes: 55ac8bbe358b ("mm/shmem: fix race in shmem_undo_range w/THP")
Cc: stable@vger.kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 938221c473f3f..c8608026e06ef 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1483,7 +1483,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
 				if (!unfalloc && folio_test_large(folio))
 					folio_mark_dirty(folio);
 
-				if (!folio_test_large(folio)) {
+				if (unfalloc || !folio_test_large(folio)) {
 					truncate_inode_folio(mapping, folio);
 				} else if (truncate_inode_partial_folio(folio, lstart, lend)) {
 					/*

-- 
2.43.0

