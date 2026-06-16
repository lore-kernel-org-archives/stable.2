Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235E93C3C1E
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 03:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781579860; cv=none; b=ZItVgCM5K3v9Ntr5mqxk9XlAj1yP1ykzna1QQu17L7j0q32s2KcocqKMozGpWKBRZKr6DKtlnUopAooqaDbVtKcX2eQBq0f7PkMQCdCA4c+/oIvw177OtGDU9vN/bvypTGQgKSpSWzMMxBkz2PB90imZXJITedSmImPmyuxY2fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781579860; c=relaxed/simple;
	bh=MJZHPkPn3picYFOyl0gJWsXMt6Pe2GOtTUBDuC5RALQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FKEPGaMJIcBhsUlAXjGqSnumESb0smQa34n7SaBODOtjl1n2LelGwPIzRZmcLKpodf9rLQgmHXl+AIxpRpBvKnfbO2z45uzhfd72d+gcqyiy52zO08KnSVhJsdCZzhBjcz2sLF7jzh3U9RfEMfOM6BCgxK7xmXRcvlBAMJeflOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CwFDBXMV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CwFDBXMV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C861F000E9;
	Tue, 16 Jun 2026 03:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781579859;
	bh=dxMmA+tZNAo3PYafx2VTJTi/44/cctvYz8tJc3+eE/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CwFDBXMV3ch8eetHlviV/y8WPK6z81Yvm94w2WPn93Lte8/WJKud9gvhShZLcNCiy
	 6HAZM9dvrR5MsZZME5JZ5++xScjO5vUFf/GwLeQvPEGCo1Fd8z0Pzobgwub2fhnQBv
	 BGDr98QNH7/QSL4FsJEesoVsh6NDvPqZuQ01Kp6DOAtgCNwTUoceLexpux+nHyB5BZ
	 KA5qfXkKiX5vifQ1zbrC5E2oiU2Ff8jO9wlIGCzfDFY7coz34KEM4SEu/jRev0ipQC
	 7lm4y89R7Mfzg1IWEIoy/RBgE9+SFzfC8JMn0LD9YmTl0MROGPpV89bctHZn11HgZ4
	 /pD2v4Hipbx9A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] RDMA/umem: fix kernel-doc warnings
Date: Mon, 15 Jun 2026 23:17:35 -0400
Message-ID: <20260616031737.2781524-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061513-rimless-afoot-0214@gregkh>
References: <2026061513-rimless-afoot-0214@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit ff46d1392750444fab5ae5a0194764ffdc4ac0d2 ]

Add or correct kernel-doc comments to eliminate warnings:

Warning: include/rdma/ib_umem.h:104 function parameter 'biter' not
 described in 'rdma_umem_for_each_dma_block'
Warning: include/rdma/ib_umem.h:140 function parameter 'pgsz_bitmap' not
 described in 'ib_umem_find_best_pgoff'
Warning: include/rdma/ib_umem.h:141 No description found for return
 value of 'ib_umem_find_best_pgoff'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Link: https://patch.msgid.link/20260224003120.3173892-1-rdunlap@infradead.org
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Stable-dep-of: 15fe76e23615 ("RDMA/umem: Fix truncation for block sizes >= 4G")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/rdma/ib_umem.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index 70597508c7656b..161c80e1d71957 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -57,6 +57,7 @@ static inline void __rdma_umem_block_iter_start(struct ib_block_iter *biter,
 /**
  * rdma_umem_for_each_dma_block - iterate over contiguous DMA blocks of the umem
  * @umem: umem to iterate over
+ * @biter: block iterator variable
  * @pgsz: Page size to split the list into
  *
  * pgsz must be <= PAGE_SIZE or computed by ib_umem_find_best_pgsz(). The
-- 
2.53.0

