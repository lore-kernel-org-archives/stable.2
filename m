Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329197;
	b=u/Na4Dc2O701CZLNH8E4Ui0UWy2w5w2I2FltnIW9uXrmPhl4uB7yqgBA9EXX717M6nHg
	 Dsl9XZMNgBmJUY/8Rob+78IsEHEmJ7LuB80XtEUbpcFgcDFKBHNedULKEJMzC72btivJp
	 AlinlJ5j/SrJ9s0pvwc+WWx4BOCG+UN3i/rauH9dtP23kwaarDkkJFLOZoOl2zbn5RfzL
	 ST8N1mQ6OpWW6ve4G1iYuy2Q9VpU7bYmlQTZYKcS7VINggRf91R0XCLan3qqF41bppbRw
	 YiqgTMj+OLrdnIo61lROPCRkZA9fMzpJvEQKg9fc4hofuqDAJ4V1ftCeGXyxIjKn0/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329197;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XUVnt7k4HXPRZqiU79aWoJP1CCDHwoDDeDHrJwhwV4o=;
	b=vs4QtWnbI5hcsg1P74d2G4wq7QBSKxaAmjBVcsFcJcy7rhO2rlgVMgbztAjtXu+sMXWw
	 J7Z5kZAvRat5s2folhH/DJLfDy/Fq+G1iN+AumJLq27omPnBIso9O5U+3D3Ir6WTWGhpe
	 5JYcnLz+2J6/3IPQ4JSzdgbwxQR0SSsdTZWig+kBudq7aRn0g+r+mIORDsJuBlAboiAKu
	 pxWKF3NAZ5SNIKsb1SNaLjU+43a9poq3NaMk3K/92S8kpbKcq9952NXLJGrKDACIXd+5w
	 7Zqw9EmM3Mv/ZJg+SZmZZl8BYBlckZbs7x3wxeFPy2iz2A6aTvs4o8ziQlA9RLKc5Ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=USb4gMO9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C252606A338
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=USb4gMO9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A64311F008A4;
	Tue, 10 Nov 2026 16:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794329197;
	bh=XUVnt7k4HXPRZqiU79aWoJP1CCDHwoDDeDHrJwhwV4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=USb4gMO9TAD5/bRc3/VjDDNygyZuVABDK4c+Uua0NhWPH82u98m5n0YQdKSIfG+b7
	 QJYHKZIUUyaKaXeD5+P3c+dBlhFqthlJVJxGCVtLrsrTUQP8ixjYEuTA+ZvpBCwH+X
	 /rLyYKA9hbOrdkybZTAjR9J2y8TJtoiSrEZsG3ZI7z/xZanJwFLr6fn9gmtbzUXqO2
	 Ct92Vyy0F2I22naxqd4WmomOYgC0LzD+enBrL3AmNSCDvhNX7pgLYpSBlkCTgvcUQQ
	 /iakB/IHvNbkxRENGHfN+xVBRL/bsA3oWFGsqkngdwpu8Sh6H2/gFdnd9IDd9Rz/Hz
	 hwiHMx1SS3Mlw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] xfarray: don't crash when sorting if array element crosses a folio
Date: Tue, 10 Nov 2026 11:46:33 -0500
Message-ID: <20261110164625.2532323-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110164625.2532323-1-sashal@kernel.org>
References: <20261107050829-failed-6.18-329750292e9d@kernel.org>
 <20261110164625.2532323-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit 329750292e9dfbb594b375d7b30cf5ddb58b7bb9 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/xfarray.c | 69 ++++++++++++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 22 deletions(-)

diff --git a/fs/xfs/scrub/xfarray.c b/fs/xfs/scrub/xfarray.c
index 78880b76b15d0..5e1b56defabd0 100644
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

