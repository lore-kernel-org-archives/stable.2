Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794330021;
	b=cThmPBovhhqgRcam8kvyLpQ46h949TLaLrw3C0Hrh6VZVzZtut4gVzQinVuULQMnhOTs
	 aN3DmSJLOpo8CrKmsv76QTgR4iZCMjX9nBS291Uq6q2llg2eZ45+u9deXbRvJ8ju6YGjn
	 yoJzYlO/zd4CjIWvASsulk6E3pKGeuJrwY7hVXaLTYe4P56jn92ES22uRX/2bqqpTPM7B
	 rQGWsoM7EAutgzLIjCj3WQSPMKp6anffgiSLgsKG8/8XtPTekJvtXGshijeCApn8Oe0np
	 Hn5MctXTTFkD8kv65PI6XokEzrNVcHlytqOSOgeVcmOE9QUu/GeJjcwgOq+w5tuelbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794330021;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=SJdyAlpe7uOyioeqvAL0JUb1DNgkIClW8wAcV1nsUOQ=;
	b=e4UfEXmJ/qVzZF+U3bIWFCEOrBaAZX/IMVh3ERg3lEGbD5L94ZlwHA6Kxj6lcYtxsVYl
	 Jh7GOcxouNUHqD+cfDLLvzx0rNwySiRZi6fxyM0qW9mdlMGJ0hUpQ2CZxIveGaOTwqdjO
	 Q2gfzRn8zek2yWt2iGGQDvlROnswCfUIc3QhBuLHfQ1jOb54E0ks6qxqhVnHR7M8KIczF
	 Gu9bguVs4kjvKr936Z8h1+z4SIghfRDISsolnIKV3sjHWeXgM+4TZZXzreBsAnMfQHcgq
	 33X0b+wYtceSIZvlje01OLbfsbSTKOORk04cojNzoHGbOL+bE3WWSbaTTe7dIUJVV6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O8XUbzko;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66211606A831
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O8XUbzko
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92AD91F008A2;
	Tue, 10 Nov 2026 17:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794330021;
	bh=SJdyAlpe7uOyioeqvAL0JUb1DNgkIClW8wAcV1nsUOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O8XUbzkoDXqvMw1WMy+MOu7gU7bvyJqrb6yYzON6O5g3DHS6om8xtTSlbAyNWZOvI
	 ys3447lCeeEqz7Std1ddCJgxtfCCjc7BJB3cUVovdnGn6mYN+Dsuh3NT3gDgjje0SB
	 /HHxa1wR1C3A3zGmd6bHQfZ7nHkVjJxGvLsn6wmtVQWpb4KxFPgeghsHXljRPv3iyc
	 5pCK9Yii2Ik6KVytcPgwpddOBHAxZjfHbK8yKX5ys3XvM3wUmv/JKJwfgGxgjHWxBL
	 Q7NaRX225qboKyhp0/irtMZQV/oroddqBh7ou9/hOeoGnycB5URH15UEvltzqchvVB
	 d1X0vdjawtJ7g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] xfarray: don't crash when sorting if array element crosses a folio
Date: Tue, 10 Nov 2026 12:00:19 -0500
Message-ID: <20261110170005.2607949-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051911-failed-6.12-329750292e9d@kernel.org>
References: <20261107051911-failed-6.12-329750292e9d@kernel.org>
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
[ sashal: inlined the upstream helper in xfarray_sort_scan() using folio_pos() + folio_size() instead of folio_next_pos() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/xfarray.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/scrub/xfarray.c b/fs/xfs/scrub/xfarray.c
index ccf7cfb63bbc8..3cf1ab618f2ee 100644
--- a/fs/xfs/scrub/xfarray.c
+++ b/fs/xfs/scrub/xfarray.c
@@ -819,7 +819,7 @@ xfarray_sort_scan(
 	    (idx < si->first_folio_idx || idx > si->last_folio_idx))
 		xfarray_sort_scan_done(si);
 
-	/* Grab the first folio that backs this array element. */
+	/* Grab the folio that backs this array element. */
 	if (!si->folio) {
 		struct folio	*folio;
 		loff_t		next_pos;
@@ -830,6 +830,10 @@ xfarray_sort_scan(
 			return PTR_ERR(folio);
 		si->folio = folio;
 
+		/* No folio?  Read into the scratchpad. */
+		if (!si->folio)
+			goto read_scratchpad;
+
 		si->first_folio_idx = xfarray_idx(si->array,
 				folio_pos(si->folio) + si->array->obj_size - 1);
 
@@ -838,14 +842,24 @@ xfarray_sort_scan(
 		if (xfarray_pos(si->array, si->last_folio_idx + 1) > next_pos)
 			si->last_folio_idx--;
 
+		/*
+		 * If this folio still doesn't cover the desired element, it must
+		 * cross a folio boundary.  Read into the scratchpad.
+		 */
+		if (idx < si->first_folio_idx || idx > si->last_folio_idx) {
+			xfarray_sort_scan_done(si);
+			goto read_scratchpad;
+		}
+
 		trace_xfarray_sort_scan(si, idx);
 	}
 
+read_scratchpad:
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

