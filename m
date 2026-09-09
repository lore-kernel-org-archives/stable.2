Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463922512C8
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 00:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788913516; cv=none; b=CGMXu4X+UqdxOIuzR4YZgSERv30VoP9WsQmsHYoqrGFgmE0/1eyJ64qdRxtAhQO8W5d3IZvYYdC7aiPw5g9fVtnBDbvP9OSzU1qgaaehcmS1+4Ky3Dxaq+Yg0Dd/O5+2MUNnfLPe+7gGmO9tAS7F23zS1SE5o5R1rQTHq9yhW6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788913516; c=relaxed/simple;
	bh=ZNZ57vAXDAf412+CmslUaGkdfXXxwEEhgDZfJOPMAm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T4rpEZqPHiAhpGYszSHmFLDu+XRzST2GSi6M3dTrX7venIc9Ch8ZzVrG7Y9ZyZBhPFeQXq5vBqkSgD7c8L/WEyT3ax+IyenqwBiAndo0nern/9WQOVEF+7IcbAf7g3MwRKMVMbMe1mzHBcFdjRTCe4oTxNdevVMLfJBJ2WEmhXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NV89d4L/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NV89d4L/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A222B1F00A3F;
	Wed,  9 Sep 2026 00:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788913515;
	bh=l9EmZDnW91zjS4jADklSr1Y1f/aSrViZEaulr4FJH7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NV89d4L/MpGDDio3UvLgIfuNyDJ62Q6kUFuJJrKA4acYEnWnCGoppw9Jk9F/vS+Nn
	 tH1v34ZFf8ykgjzMZfAqYkTUAsF9BwPf4DyszkUbPJmZ+oGuXgJYn4mwQgxJrLgOwZ
	 mWDFxNf09jGN9KieXZCka+HIzKBb4aBM/K7sSxodPLK+/SnYuhBLn0a0qmUN8KjUG7
	 bjry+Q2lYt40jHHVHoFUDK9KNDnnM9S9z3C6HwzaIm4HFusLxtIi5ZDD/o2m/v5/Xp
	 66FFRqSEdoew0DQuMowTRTVyAiV5lb8LaHvBXCkqEmu01MrUS+Z+nDLBZKFwpwqEHs
	 hm6wLFtQnBGEw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anna Schumaker <anna.schumaker@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/5] SUNRPC: Introduce xdr_set_scratch_folio()
Date: Tue,  8 Sep 2026 20:25:09 -0400
Message-ID: <20260909002511.725380-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909002511.725380-1-sashal@kernel.org>
References: <2026090350-comment-projector-6988@gregkh>
 <20260909002511.725380-1-sashal@kernel.org>
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

