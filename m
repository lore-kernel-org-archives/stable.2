Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3889243499D
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 19:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788895717; cv=none; b=nItnLagkMLVjJ1GHnRNLkakdaZBhOn0oh3L9a7orDNFK6ro/8GBZpdHovzkZMZ5ld5N1XYirefQGb44yXTlTIH43ZJKoSsZxn3gFgd33Ti4PIubHCdLfsqvEVAxNFeIRlL0Dn6KXKOHfFSvx8JPtrdOnOibZt+T10SpzxRdkFBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788895717; c=relaxed/simple;
	bh=ymYfWlqCDRtoEhiQ5vWyphVkNZJUyXykgMvOyxtylgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NuuykFkg9kfncrpW7SU0xm5tZcYX5V9s3siVn1nqHY3iJ+J6gK0IL4YoNVHpiRDndyiBErAOxGChuTcWY5GjKOFZu03l2fGom08IWQsc5Tjbp+PQudkraTDIzHNWUOvPf0kK2HD42XoJk36Idp6tmVv4srkHRNfdc4a43GXLYnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4umCWvt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4umCWvt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4041F00A3E;
	Tue,  8 Sep 2026 19:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788895711;
	bh=F4+p1HI/ojHzf1vKuomm/xjS7ysWoJtSBvxG2A1ZLE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g4umCWvtufiRlCsrwI4t6gzvZHrEvdE6/J5SZKDfk8sJdRNwNED+GIQQXPJMI5JQl
	 vi/rspM4Ls4IC3WK984HyIRwb04iclwo2tFYUD8R7i7IKLnv2oou8IUGUQFjX6LD7P
	 jaj3w8ZiHE4Ww5LMLM+kierp2cnu6j3gFFFjKKORAyCQw+RhfMnlH+cZ4lQ4rD/b78
	 hmwX2JitxRgTuO7Qkrhqya4KCvaR2EROLZKv3CCB+CglYJCcYYVtg31Nznqp+SmaAF
	 GlK+ywo4zsSNPcdJTj64/RR8Vw9MJrmLGMNcbCbP1TXSvc+H6HvvpQN73YljnrBALz
	 WDGZgHKeeiJGg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anna Schumaker <anna.schumaker@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] SUNRPC: Introduce xdr_set_scratch_folio()
Date: Tue,  8 Sep 2026 15:28:26 -0400
Message-ID: <20260908192828.296500-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090349-throwing-hardware-8a25@gregkh>
References: <2026090349-throwing-hardware-8a25@gregkh>
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
index 0a3cbbe4a4cdf..5dfabde5f725a 100644
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

