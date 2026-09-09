Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0041F16B
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 00:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788913536; cv=none; b=qDjrVcPN4KVTWpYNIlytyzOsrKwVOj7UL2INLWXOJAoOdZTqJGAzaHaMMkb5CLPoSM6xwB9d2GD1FEtSUBDyvy5KT5tDuMuuD9qsD7tAKsBudpbycvZVmrLa6w4N/C2Pt+kOktihkCE+ZqLCi1lKaFBVES2AbswYSPBLrk7HbJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788913536; c=relaxed/simple;
	bh=ZNZ57vAXDAf412+CmslUaGkdfXXxwEEhgDZfJOPMAm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LnGAgZUAPJszwvj6ebd2EeqykHq/tnLDUTVPJxp3bladuFhTup25Rd9735MrS301k1WVzw8pMFsrA+owLflGwagY18ee7hKNy7HjZzCqP5pyOUruQV+PGuHACfdzisK/BHE9DrOncJSgCruNpRKqoEf/h1vo7V07QHFiPtyyCY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbDP+3+x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbDP+3+x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3383C1F00AC4;
	Wed,  9 Sep 2026 00:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788913535;
	bh=l9EmZDnW91zjS4jADklSr1Y1f/aSrViZEaulr4FJH7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HbDP+3+x5gY4sWe0kT3pdlGGzHqaga9w8Es7y0cY0JGLg6qasK/bb/wWA30TclfHd
	 2d156d40KRiyZk7ouAeRGEiiJyLoHhQQikeUgDZ+oVyZXyZ5SmNL9ReGuZQ17cSdtD
	 uiR6KBkkn0VWfJ8vqBoOxAjrh/TTea1y7NCg+YMZUxAq9hbKYj/8sEmoO1En7Yi6lG
	 c36+pjMhOjRFFcFFFoBPD7ubcuH0uBYFbdGq+Ze6/6ScCEXuvSm/RzO2LZDOSamTuL
	 Uy54j/kmHc1swVWpTOStEifwcSaTxPS/TRzlqgMrasF3O3WHr5RrCVts3xSLgGwtyf
	 Fyim4zlH9Wmyw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anna Schumaker <anna.schumaker@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/5] SUNRPC: Introduce xdr_set_scratch_folio()
Date: Tue,  8 Sep 2026 20:25:30 -0400
Message-ID: <20260909002532.729106-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909002532.729106-1-sashal@kernel.org>
References: <2026090350-comment-projector-6988@gregkh>
 <20260909002532.729106-1-sashal@kernel.org>
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
index f84e2a1358e17..2b73b3db87d99 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -299,6 +299,19 @@ xdr_set_scratch_page(struct xdr_stream *xdr, struct page *page)
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

