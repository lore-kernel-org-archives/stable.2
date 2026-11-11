Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415849;
	b=KPTvJjZkc7hoOxeTLnS4Fit5zI1A3nHDVslXm8z31qwqrRjDN2bCuM2DFfVyYlC2l6Kj
	 9WplxslnQpoO3TfQpb6YTsXs72EOCkeq3YdDy1g9AvPt2jVMbVaFW96bqTw3+QrYaY+b2
	 i6MbLRrLlq2H9Np63U2fes6eQa2No9fbSbzFE4eINc6ugPhgL+bFVs/7zkuMevGFFAnZC
	 hOkCDgHM06dXjAFWX7rpd7JJVQafSRq5ADZwvO+HGnQQhpThVxXB7YOy19JhAwhRjIiZU
	 pZMICbXywlzMDg3i19iHX/ppp+v97Vlz4n4Zrshs0gJAalMXfH1bouh2lnLzvFAYv1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415849;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4AO9y3y+o3t9ADMtnxVAXydf1L8yQrt8jVed/dCEjys=;
	b=T953zQ4RlO6CpjVImBxsZJJmmtn2xuZjzF2ALeauBgQT43gHqoVgY63AcWi9d3qtmewN
	 bTK4Q/9W8F02HwlKhwFXvCv6IcNIU2iRJCNPpLi4L8ZXubF8raMJTVJqxTx3H5JhWPXXr
	 lkhjjwRhw0dUAXzdyD+lC5y9DVNJypTOy+bnm3zIrb7ZyC4KhEhxKVOZdQRinsr35kJkI
	 Z8UvQzy0jiF2jijhXPRB8FHR4B7kG7nGJQebeq1fXUupBXVN64IqNKCRTJyBeMSgCh8kk
	 uX3uXwxp4Jouev6AiAy8flk8LmwE/PtPKILAO6gCr/U4WG/j4HmkQLhGLbOomuwdR7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mRIWyB36;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FED6606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mRIWyB36
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0261F00A07;
	Wed, 11 Nov 2026 16:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794415848;
	bh=4AO9y3y+o3t9ADMtnxVAXydf1L8yQrt8jVed/dCEjys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mRIWyB36h/o1RHhKdA6r8Wk+3hwalJw19g4oTCZlEnyEebC/frHOTLCpiXhCXHOP5
	 rL681Uyoo8CBIIpXvPzKVb8gIZofXbz/IwLzCXmNbcRm4RZ/AuvY53S+iMzZVaFQtf
	 9QBXl3+zLd9xo0t16Neu8LMj/7WSGGfxUGGroVW5DB/4FHkuvFSGV4r4p043MLMAKP
	 ea6j6jf1iHKPly+tX8c3c6rt6JWUEdbbUdkjwJYOmertzNCiVpyaF/1Z+o2V+NeLO1
	 x02uwVfbuJsmNqUYHBAy635z8hoInAetkmrrM0f+dl1q3HIfxe22qSMZWqAOeuR9Zp
	 d53SqC0/WMTpw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jianyun Gao <jianyungao89@gmail.com>,
	Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] dax: fix wrong error code returned from dax_dedupe_file_range_compare()
Date: Wed, 11 Nov 2026 11:50:46 -0500
Message-ID: <20261111165028.3347948-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052403-failed-6.12-9b036546a02c@kernel.org>
References: <20261107052403-failed-6.12-9b036546a02c@kernel.org>
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

From: Jianyun Gao <jianyungao89@gmail.com>

[ Upstream commit 9b036546a02c6c9a5133f9c1e93503896595c6ba ]

When dax_range_compare_iter() returns a negative error code (e.g. -EIO),
dax_dedupe_file_range_compare() incorrectly returns 'ret' which holds the
positive return value from iomap_iter() indicating more iterations remain.
This positive value leaks to the caller, where vfs_dedupe_file_range()
interprets it as success (bytes_deduped = len), causing userspace to
incorrectly believe deduplication completed.

Return 'status' instead to propagate the actual error code.

Fixes: 0e79e3736d54 ("fsdax: dedupe: iter two files at the same time")
Cc: stable@vger.kernel.org
Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Link: https://patch.msgid.link/20261015143426.17620-1-jianyungao89@gmail.com
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
[ sashal: Adapted return status to return compared to match the existing comparison result variable. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dax.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dax.c b/fs/dax.c
index ae1e9497b4168..e9f12b7de17ae 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -2067,7 +2067,7 @@ int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
 		compared = dax_range_compare_iter(&src_iter, &dst_iter,
 				min(src_iter.len, dst_iter.len), same);
 		if (compared < 0)
-			return ret;
+			return compared;
 		src_iter.processed = dst_iter.processed = compared;
 	}
 	return ret;
-- 
2.53.0

