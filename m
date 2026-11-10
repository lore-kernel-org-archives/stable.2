Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273673;
	b=44bNym0AxaA4WpRkFAkWlZjFdIP8IUK0Nr7OEH2ggI15rncKi40klRen5AfajraNu8tx
	 YZjlYwG9ZKMlRPxNStWvQKRqkjCqDSK6Y+urlBQzAfaY4Np+Iv0JKBpCxVVANmZDcshTQ
	 rUUsEEoD7veMTDJpo3VJmBgE5VhImcL8RZbJm6uzmw5ibxiGCThCY6BmqJCwibWHU1Zyq
	 506JAWdXXvdm1Un4z5ytFDnCru9XYEgSjixTFCBAkCeZ6XYA+zXVvq6sPUV0TGK6hNLU6
	 EG4qEFqAyjuMZ+/dBAQ0hC46rnJBnBINaN8fiQ6MdcY11zIuprg7EwO/jluBF8GkAFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273673;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=u3wCMOTkjQeEUOfTL1NzCQqnNAKfGzDHos80PTRRm2o=;
	b=mI5YcaX80NNV4s26p/pUmfVNDLyg05cCTFqVrO8l+CQNXe4y+S4yWXHt7Caz6mYVEDBG
	 bsTFuWX/onnU/9C3RcqQhBE4IpBd33vXbCBivdHqbV9p1WwK97oC94hWy7ZxxO2EKxy52
	 6WFaL9ffBGUAJMrX5+KRLbFpxPyqG1oW2lnqAlZVTjLDm6zX9I/qHPqad2LmW5ULhMVB5
	 9CZCXfCeeF/n6hzgVE5J56ri4cPPaEiZPiYNcu4r8s2NoGDkvYVtEsBvfhxBkIjF5nDDl
	 C1o4zZAml2+rRmYijkomGeMEsq78fs808PIKWEkZt6k8VnnCb5J0fUyQcwwjEnzPXkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FqZClKAJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B22606A338
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FqZClKAJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0AED1F008A1;
	Tue, 10 Nov 2026 01:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273673;
	bh=u3wCMOTkjQeEUOfTL1NzCQqnNAKfGzDHos80PTRRm2o=;
	h=From:To:Cc:Subject:Date;
	b=FqZClKAJEpa9kj6Tjc/mtOopqORCNsyOZ6vCIfER14kp3G2YCKNrjuZcGprren+H7
	 Why95WS5H5Zfef/WLQ9vIZwvDvZ3+SMK46koZ4m+Er2JPqzaEgYKrGwyw4gVA1MZZH
	 vkuBS8kIwYeRALg5ehFYfRlhz2xTnx+YthzS9tkl3mT5k2Xql+9rYOG3JnQdov2Yyz
	 HgxkjOLod+WpOqPafGtFBzyWukTTwH1nCOPY1Hrhvu/i/JD62QoRSoqv6cJ8V0xxP9
	 PZ1SBuBbQgbdqYTxUAj8jrLFeBzo5fLNvd9FC44lmOK9oO0cDbmAPlXewu/X0zTeaE
	 dqqVZElBBPYRA==
From: Sasha Levin <sashal@kernel.org>
To: josef@toxicpanda.com,
	riel@surriel.com,
	usama.anjum@arm.com,
	ziy@nvidia.com,
	david@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/filemap: read mapping->a_ops->free_folio under i_lock" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:21:07 -0500
Message-ID: <20261109202107-failed-5.15-dc24e273244e@kernel.org>
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
git cherry-pick -x dc24e273244e9d712257d5a6c20a32c7f5ca84e6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202107-failed-5.15-dc24e273244e@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From dc24e273244e9d712257d5a6c20a32c7f5ca84e6 Mon Sep 17 00:00:00 2001
From: Josef Bacik <josef@toxicpanda.com>
Date: Sat, 31 Oct 2026 10:39:35 +0100
Subject: [PATCH] mm/filemap: read mapping->a_ops->free_folio under i_lock

memory_failure() -> ... -> filemap_remove_folio() can read mapping->a_ops
after the inode has been freed. Once the folio is deleted from the
pagecache it no longer pins the mapping, so after i_lock is dropped
e.g., a concurrent final iput() can evict and free the inode before
filemap_free_folio() looks up mapping->a_ops->free_folio.

Most callers hold a reference on the inode, but not all.

Documentation/filesystems/vfs.rst explicitly states that ->free_folio()
must not assume the original address_space mapping still exists.

Fix it by loading ->free_folio while i_lock is still held, similar to
what folio_unmap_invalidate() does.

Inline filemap_free_folio() into its remaining caller such that
delete_from_page_cache_batch() also just loads the callback before
dropping the i_lock.

The bug was found by code inspection and has not been reproduced.

Fix generated by an LLM and sent by Josef Bacik in private.

Fixes: 59c66c5f8c4f ("mm: factor out page cache page freeing into a separate function")
Cc: stable@vger.kernel.org
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[ david: get rid of filemap_free_folio() entirely; improve patch description ]
Reviewed-by: Rik van Riel <riel@surriel.com>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Link: https://patch.msgid.link/20261031-fixes_core-v3-6-d6437171ecc3@kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/filemap.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index b74bc1e5015c6..906b013c11eb3 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -227,18 +227,6 @@ void __filemap_remove_folio(struct folio *folio, void *shadow)
 	page_cache_delete(mapping, folio, shadow);
 }
 
-static void filemap_free_folio(const struct address_space *mapping,
-		struct folio *folio)
-{
-	void (*free_folio)(struct folio *);
-
-	free_folio = mapping->a_ops->free_folio;
-	if (free_folio)
-		free_folio(folio);
-
-	folio_put_refs(folio, folio_nr_pages(folio));
-}
-
 /**
  * filemap_remove_folio - Remove folio from page cache.
  * @folio: The folio.
@@ -250,6 +238,7 @@ static void filemap_free_folio(const struct address_space *mapping,
 void filemap_remove_folio(struct folio *folio)
 {
 	struct address_space *mapping = folio->mapping;
+	void (*free_folio)(struct folio *folio);
 
 	BUG_ON(!folio_test_locked(folio));
 	spin_lock(&mapping->host->i_lock);
@@ -258,9 +247,12 @@ void filemap_remove_folio(struct folio *folio)
 	xa_unlock_irq(&mapping->i_pages);
 	if (mapping_shrinkable(mapping))
 		inode_lru_list_add(mapping->host);
+	free_folio = mapping->a_ops->free_folio;
 	spin_unlock(&mapping->host->i_lock);
 
-	filemap_free_folio(mapping, folio);
+	if (free_folio)
+		free_folio(folio);
+	folio_put_refs(folio, folio_nr_pages(folio));
 }
 
 /*
@@ -320,6 +312,7 @@ static void page_cache_delete_batch(struct address_space *mapping,
 void delete_from_page_cache_batch(struct address_space *mapping,
 				  struct folio_batch *fbatch)
 {
+	void (*free_folio)(struct folio *folio);
 	int i;
 
 	if (!folio_batch_count(fbatch))
@@ -337,10 +330,16 @@ void delete_from_page_cache_batch(struct address_space *mapping,
 	xa_unlock_irq(&mapping->i_pages);
 	if (mapping_shrinkable(mapping))
 		inode_lru_list_add(mapping->host);
+	free_folio = mapping->a_ops->free_folio;
 	spin_unlock(&mapping->host->i_lock);
 
-	for (i = 0; i < folio_batch_count(fbatch); i++)
-		filemap_free_folio(mapping, fbatch->folios[i]);
+	for (i = 0; i < folio_batch_count(fbatch); i++) {
+		struct folio *folio = fbatch->folios[i];
+
+		if (free_folio)
+			free_folio(folio);
+		folio_put_refs(folio, folio_nr_pages(folio));
+	}
 }
 
 int filemap_check_errors(struct address_space *mapping)
-- 
2.53.0




