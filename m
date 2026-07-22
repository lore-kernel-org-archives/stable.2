Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADE0360EC5
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 14:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784731721; cv=none; b=cJsUEM/nBn1qSimW93wx6zXHFQQtSHE0rbs0TVcLmn/o2mWSov2+wwr3FG29PXws16UiBEuD15CwQzP9hYrEO5/ARzu9aDp8pA7WWgsz8zOuF9NqwV2rR1MU6AWsggS3PnH4Yz4mWDHq7JJ22mRw8vysLxWANLlD0IOsu+LPhIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784731721; c=relaxed/simple;
	bh=PRE9PFDkkXN1FQ9ssvcCtYBQxbDdGUKpltyAFE3Nr2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HgSCEsNdPFalu0C7QFzsVJVy+VUUSKdrmMCHNx4m5nSCycetgJDFtQzcDRBuZc0ZwZPxM5NrzIlfOLZij0wS5pwLMETNLFrmMCrJmEBcdJEXNqJQiLq1ixng4MUKOiYecfdnsgpdjNRpElUUCwDNeWaSdc4ddXFl1xu7yOWny8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQyk7ok/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQyk7ok/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B181F00A3D;
	Wed, 22 Jul 2026 14:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784731718;
	bh=24vdTDqH2iy/vvDCqAo06zw9g87cbew33gWUIphvvbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cQyk7ok/d4XeXNluisoPECZvSrXcbEiVEt8OLQfvm9KLnZ+brBzZ7qu2Ms/gT0Laq
	 yfZarM9tCIN/lneu+t96Ndt29OR38wtRohE1L2svquy9XnqhfFYR54NHCKSsojAt/A
	 ZZYryH4ZNdYQRvqdYwFyfsfS2Fzs0geAFprDZx1u2kOOs5u+GCtf808jb/mevcazTT
	 HkqrZmvkRUaPidNog63k7s80Lqlzz7KrCzGSSPLSTr70JaCyl34EaYJTOpzkzb64he
	 FbyiaWMt92pwL093vi+vAC6Hv5nnW+S6sN+kmyrt9TajPud35XtpgJHDm6J8RxNh3+
	 vM7pFyOy8vlAg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/4] afs: Annotate struct afs_addr_list with __counted_by
Date: Wed, 22 Jul 2026 10:48:33 -0400
Message-ID: <20260722144836.1601242-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072053-iciness-ecosystem-430e@gregkh>
References: <2026072053-iciness-ecosystem-430e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kees Cook <keescook@chromium.org>

[ Upstream commit 2d26302bdff1300029a67931739f5770eac22493 ]

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct afs_addr_list.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: David Howells <dhowells@redhat.com>
Cc: Marc Dionne <marc.dionne@auristor.com>
Cc: linux-afs@lists.infradead.org
Reviewed-by: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Link: https://lore.kernel.org/r/20230915201449.never.649-kees@kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Stable-dep-of: dc175389b18c ("rxrpc: serialize kernel accept preallocation with socket teardown")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 0973cd0a396959..771880d4b010d7 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -87,7 +87,7 @@ struct afs_addr_list {
 	enum dns_lookup_status	status:8;
 	unsigned long		failed;		/* Mask of addrs that failed locally/ICMP */
 	unsigned long		responded;	/* Mask of addrs that responded */
-	struct sockaddr_rxrpc	addrs[];
+	struct sockaddr_rxrpc	addrs[] __counted_by(max_addrs);
 #define AFS_MAX_ADDRESSES ((unsigned int)(sizeof(unsigned long) * 8))
 };
 
-- 
2.53.0

