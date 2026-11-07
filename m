Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046753;
	b=4ZBMMz4w6wm6VL8U6hpIoTrei2OrcnnwlS4cfghmvq6Ad8Z7Gx2YsazS57ZNGb2AP8WI
	 wP7gd+LxQQXLmGosdR2s8FmqcA8y3TbLgNiuXBduYLNyk3+Kn8MdnecNT8gclXpaknx/I
	 i9YAb5reeAMM21SRlhaPWvmQp0yFGjwuStgmkyRQrNG2Hcqy22yS9x55oB/H4XIGxZOf9
	 3qMKaxTLUbJkMD3hNo+hkGCiMTcfJEK399CXyq/kICGJTdxR8iBPDNk01sCcNXg+Cu6da
	 Kl4vjOOl8saJMjTSsrVDlJ5JCNYw1mfWcRTsQKAT51n3uixJG8kbbjeXjXXCWm2FpjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046753;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=A/4sNX8PrBiwORvvxOqDrrsoThbriLDSmhwyDyfE3PY=;
	b=rN8Drc7LDSFtOg2LhXEUW1jrn173AgVDJbznH+gbnDtAVsx56C0oRiOKRGBY4QF+Q/0v
	 dVxd5XnR/U/pgvv3ATbQKm+fGKX7QTfzX2GPYqgq/+yCIC19Pxaf4QwWYSAFA+3iKEq5T
	 YB6+kqcmdHVH8qbc2NCyNd043fh87anWyFG0BXQpbnp590uCLmwmTZpBa5tcCPkPdbH0J
	 cwMZZJCUJVTzEFYXDOpIzY0FLHW9ExYlRxbDioLYxLUMx9k7aVvba3HM+zuoU7GWFpgK8
	 +LsmoZCEvDvJsmRY/AhPOTwqh63eGxbP+2lHMl5/mNE2i+bukvLWl9DYiXv8U2A7Gpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hYOGRxFp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0605A606D81B
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hYOGRxFp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605EC1F008A2;
	Sat,  7 Nov 2026 10:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046752;
	bh=A/4sNX8PrBiwORvvxOqDrrsoThbriLDSmhwyDyfE3PY=;
	h=From:To:Cc:Subject:Date;
	b=hYOGRxFpfrOiBxkaFY826v97rL4hjK8fEIMcc13pRdw5tlfYQ3lVyIKDT9cqJmydC
	 m4piVNZXRLZv69QnCI8+XHl3U4UBIvXh82GHJX6OZa6P6rzAq7CuoChOKVXDAIUKnF
	 eGdrmFn4hzrAFCLd8hDmBto7Ce8VhNz4NW2fG5mwV4FSWFayenjLpPO9SdYDL+kuZC
	 AKJjaKwEvDIzywgJLsjNTLFYoiTtBWTMu/gkYCfTjfK9Dlbqa3EZ7ecKD0mx5PMdlp
	 oKA7tx+ZhvGQXXsfGqsc1ZEYIcPvdheFTv/B2itx/g9SwKL/ynaHheTeqp3X3la+so
	 pQmaVViAKwBPg==
From: Sasha Levin <sashal@kernel.org>
To: djwong@kernel.org,
	hch@lst.de,
	cem@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] xfarray: don't crash when sorting if array element crosses a folio" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:19:11 -0500
Message-ID: <20261107051911-failed-6.12-329750292e9d@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 329750292e9dfbb594b375d7b30cf5ddb58b7bb9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051911-failed-6.12-329750292e9d@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 329750292e9dfbb594b375d7b30cf5ddb58b7bb9 Mon Sep 17 00:00:00 2001
From: "Darrick J. Wong" <djwong@kernel.org>
Date: Tue, 22 Sep 2026 22:59:42 -0700
Subject: [PATCH] xfarray: don't crash when sorting if array element crosses a
 folio

LOLLM points out that if an array element crosses a folio boundary,
xfile_get_folio returns a NULL folio pointer.  If this happens,
si->folio is also set to NULL, and calling folio_pos/folio_address will
just crash the kernel.  Teach this function to handle this condition by
falling back to reading the array element into scratchpad memory.

Cc: stable@vger.kernel.org # v6.6
Fixes: cf36f4f64c2d4e ("xfs: cache pages used for xfarray quicksort convergence")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
---
 fs/xfs/scrub/xfarray.c | 69 ++++++++++++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 22 deletions(-)

diff --git a/fs/xfs/scrub/xfarray.c b/fs/xfs/scrub/xfarray.c
index 2ce24bfe4c0fa..5ea3ce4bf8d84 100644
--- a/fs/xfs/scrub/xfarray.c
+++ b/fs/xfs/scrub/xfarray.c
@@ -794,6 +794,46 @@ xfarray_sort_scan_done(
 	si->folio = NULL;
 }
 
+static int
+xfarray_sort_load_folio(
+	struct xfarray_sortinfo	*si,
+	xfarray_idx_t		idx,
+	loff_t			idx_pos)
+{
+	struct folio		*folio;
+	loff_t			next_pos;
+
+	folio = xfile_get_folio(si->array->xfile, idx_pos, si->array->obj_size,
+			XFILE_ALLOC);
+	if (IS_ERR(folio))
+		return PTR_ERR(folio);
+	si->folio = folio;
+
+	/* No folio?  Get the caller to read into the scratchpad. */
+	if (!si->folio)
+		return 0;
+
+	si->first_folio_idx = xfarray_idx(si->array,
+			folio_pos(si->folio) + si->array->obj_size - 1);
+
+	next_pos = folio_next_pos(si->folio);
+	si->last_folio_idx = xfarray_idx(si->array, next_pos - 1);
+	if (xfarray_pos(si->array, si->last_folio_idx + 1) > next_pos)
+		si->last_folio_idx--;
+
+	/*
+	 * If this folio still doesn't cover the desired element, it must cross
+	 * a folio boundary.  Get the caller to read into the scratchpad.
+	 */
+	if (idx < si->first_folio_idx || idx > si->last_folio_idx) {
+		xfarray_sort_scan_done(si);
+		return 0;
+	}
+
+	trace_xfarray_sort_scan(si, idx);
+	return 0;
+}
+
 /*
  * Cache the folio backing the start of the given array element.  If the array
  * element is contained entirely within the folio, return a pointer to the
@@ -819,33 +859,18 @@ xfarray_sort_scan(
 	    (idx < si->first_folio_idx || idx > si->last_folio_idx))
 		xfarray_sort_scan_done(si);
 
-	/* Grab the first folio that backs this array element. */
+	/* Grab the folio that backs this array element. */
 	if (!si->folio) {
-		struct folio	*folio;
-		loff_t		next_pos;
-
-		folio = xfile_get_folio(si->array->xfile, idx_pos,
-				si->array->obj_size, XFILE_ALLOC);
-		if (IS_ERR(folio))
-			return PTR_ERR(folio);
-		si->folio = folio;
-
-		si->first_folio_idx = xfarray_idx(si->array,
-				folio_pos(si->folio) + si->array->obj_size - 1);
-
-		next_pos = folio_next_pos(si->folio);
-		si->last_folio_idx = xfarray_idx(si->array, next_pos - 1);
-		if (xfarray_pos(si->array, si->last_folio_idx + 1) > next_pos)
-			si->last_folio_idx--;
-
-		trace_xfarray_sort_scan(si, idx);
+		error = xfarray_sort_load_folio(si, idx, idx_pos);
+		if (error)
+			return error;
 	}
 
 	/*
-	 * If this folio still doesn't cover the desired element, it must cross
-	 * a folio boundary.  Read into the scratchpad and we're done.
+	 * If we don't have a folio mapping the entire array element, read into
+	 * the scratchpad and we're done.
 	 */
-	if (idx < si->first_folio_idx || idx > si->last_folio_idx) {
+	if (!si->folio) {
 		void		*temp = xfarray_scratch(si->array);
 
 		error = xfile_load(si->array->xfile, temp, si->array->obj_size,
-- 
2.53.0




