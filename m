Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3779E5947F1
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 22:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788907019; cv=none; b=gt2HIB/mbGd49T/0mcy0V/Ll6yqqOj/SQ59MEvAkdUM6EOOHIml1Y3YOd+bBkam+WHT90J04YtTMJ6EG2LXV8D052TzInxJ1UPxL2/4yOGsiI9lljH5pSuCRin3UpTCbrY43ujTD7q3Sod2I6cNEcuRnw4fHfk/eXpjzkeBzyn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788907019; c=relaxed/simple;
	bh=PxoEYotsoNXRbOVw3ZHe8eiQpcHzVvIEdvRDVu9up5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KUbwycLZy1CTaG+L4GUmuvQeOpzV9rmYMMp+bvpc+JRcnXjuoeUY6Kh7elOFonzURCYz4pJo1jOEIApdWNev3eqakLiY+vA9uzqt+Sed2g6W2Xe5Y2Sy2gbycEVSICEjEVsWzdDW9I6wSpeZQq4MurqS5XniJXzddM3nmyIXrU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ov5aTBNB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ov5aTBNB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6267F1F00ACA;
	Tue,  8 Sep 2026 22:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788907015;
	bh=G5lYaEm1Z7udKhduViWAjErgCWjeEXIfFHsLdYM5KkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ov5aTBNBGv2w2uWeH/oq35uQX+5hEIjcE8DXQeaj6NAbuf2j1RdVWaPXTE8SJKwvf
	 Kd9adTCSt8pGLjgnpp/ogq5P0kfkUqlbKZ33D7QwfE2brzmF1inWsn1T3VN7MpYK24
	 n2uOvfVsW0eVDX0PjYv8krGO8+SlufPzuMtt9Eej8QbpkovFlIoKsixx7z/CVAXod5
	 gg6UCrYRl0R9z1yGloUUrjvM6h9j2qFuSxj5Slm4iUDpb6hmIJzca0bsXkz2AwzZLR
	 71l3a5CCcENzZzV2r2NX1TAd76WfFIspyUryiu3Y80rfbcR0I5FnixuhMNVj92JfPr
	 BSlan0n7ImkJQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anna Schumaker <anna.schumaker@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 5/7] SUNRPC: Introduce xdr_set_scratch_folio()
Date: Tue,  8 Sep 2026 18:36:48 -0400
Message-ID: <20260908223651.501880-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908223651.501880-1-sashal@kernel.org>
References: <2026090350-breeze-repugnant-70de@gregkh>
 <20260908223651.501880-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <anna.schumaker@oracle.com>

[ Upstream commit c8a127596edc026e5364a7a609986dcd3999914c ]

This will replace xdr_set_scratch_page() when we switch pages to folios.

Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
Stable-dep-of: c479bde671cb ("sunrpc: defer rq_argp and rq_resp free until after RCU grace period")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sunrpc/xdr.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index a180482dc209b..36a974baa101b 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -317,6 +317,19 @@ xdr_set_scratch_page(struct xdr_stream *xdr, struct page *page)
 	xdr_set_scratch_buffer(xdr, page_address(page), PAGE_SIZE);
 }
 
+/**
+ * xdr_set_scratch_folio - Attach a scratch buffer for decoding data
+ * @xdr: pointer to xdr_stream struct
+ * @page: an anonymous folio
+ *
+ * See xdr_set_scratch_buffer().
+ */
+static inline void
+xdr_set_scratch_folio(struct xdr_stream *xdr, struct folio *folio)
+{
+	xdr_set_scratch_buffer(xdr, folio_address(folio), folio_size(folio));
+}
+
 /**
  * xdr_reset_scratch_buffer - Clear scratch buffer information
  * @xdr: pointer to xdr_stream struct
-- 
2.53.0

