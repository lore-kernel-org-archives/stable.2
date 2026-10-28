Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793181394;
	b=3JV+w+SO46aZNgAn43AStTO+gz9M9jpSFJYkVKSpLmC28YyRNshLuLuQ0LKe5/vdAFAM
	 9OxF8UEnzKftgmeZG5Ez6tDRcmgf+aJpKzDzTipa0wqlcGJ20PN+M9QpGTICAHJL2gjEj
	 DT02enUDviFt+WoQUaO2qbvTcJNLE/NAvvgR3yH8e8+mt8onrhCyUiui0qVjsQlT9Q4qc
	 z02874ON8MQPSz0itYR9jNY8Q4/hSLtOAvGIcROx0Gj3VBRWwNPoDzBiTG2LvcylyYFsQ
	 KslJPmQE8L19tEMlTb+cYX3TDuB8TGUvoW+U63/VOe0GCLr+dkOS93YTIHODxZVY8vA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793181394;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=UpQKMIScdwv99hbScpBFpPKjgrSYaRWIk51glHAK3ic=;
	b=VpVHFsBaW1VjMQK3EIYjg0Gkgbv4mwPPELyt9DOvW+8QD3ePYaYr9E7VHnLvHAyRopdE
	 G/uf2fSKb28Ji2eao/92aSaNypzrwyOlpdfE744UvVnmceSvYccMlET6ByA9YDtasNF3+
	 1mMskwWcwhraxoZCya0qNAkB4RDViv69/1+m3M8ltWopIHg4ZXImQ0RobjWxq68hwyhCp
	 T6BVTBpJqVNq/RJYvgJcb5Bj3HIEJSTY07NwTg8lG2bT08H5uQLMtkLim8VwknVwLyXZz
	 +MyAVUhCPNAtTmgi47xuzPiKsLuDrKJsGixeAX6lLTlrd0gFBzqLVRVupHVk+IA6kWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KVlCpRC4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C796606A31A;
	Wed, 28 Oct 2026 09:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KVlCpRC4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1A61F01828;
	Wed, 28 Oct 2026 09:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793181394;
	bh=UpQKMIScdwv99hbScpBFpPKjgrSYaRWIk51glHAK3ic=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KVlCpRC4pPDvzt14w/q6r/wu9YQhxmtTRLuznofuu9N7qNzGA5TxdJcmnH8nwXvtK
	 fvGF5EyTTGaExBLitX0GYu4GX/XLiU+rMW7gHDLzHuopK1s3KY2pDv9pomoYMBOtI+
	 aYbeK9XDQ8u5YH2B1SM4cwcSuad9n7vf9wlbe1AnzqqDuTETfoYengg6AHA8mkMdFF
	 bODJ8yxc9iWsF0LnLU/t/v6WSC9KMVj05yRKFTUcIqACpsc6PQUDBxk6U087yJQwke
	 Dn3bxFrRcgTsp8jGc/rIJYpWxKPDPDVwW+lBFhs1wpn1K1Mrdv69QxWv2ymW5AiUBx
	 EI6000wh4vNqg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 28 Oct 2026 10:55:07 +0100
Subject: [PATCH v3 09/15] mm/shmem: discard whole new large folios on
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
Message-Id: <20261028-fixes_shmem-v3-9-4ce3baf2db4b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1588; i=david@kernel.org;
 h=from:subject:message-id; bh=Sh5xSudJ+Tjy3Mzo9v0zjd5/Sixygz0g7QawU3O4JKM=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIeHmtibV+VuPlJ+QE1TZlEC37mB6m8+nEzmjxTXuxQq
 /p1KtW5o5SFQYyDQVZMkSUo+L7By5fraqvd+Jhh5rAygQxh4OIUgIlITWBkOHZiTtJavfYdfIZc
 y9c0Clavvfpa1v6xc6Rc/efw6XeCpBkZHrJeYPgbn2a56ln/lQOFk49b3vsf+nOqb0p4RKPyIe4
 2XgA=
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
Reviewed-by: Zi Yan <ziy@nvidia.com>
Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index f52bab8176d7..a686b3d77647 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1473,7 +1473,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
 				if (!unfalloc && folio_test_large(folio))
 					folio_mark_dirty(folio);
 
-				if (!folio_test_large(folio)) {
+				if (unfalloc || !folio_test_large(folio)) {
 					truncate_inode_folio(mapping, folio);
 				} else if (truncate_inode_partial_folio(folio,
 						lstart, lend, NULL, NULL)) {

-- 
2.43.0

