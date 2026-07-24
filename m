Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748161419A4
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 01:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784856322; cv=none; b=nmPU54yHlt0Jp1UC8qPTW0Qcq4qt463BQM556MygZmHLbuK/8kGcptG56LJpuoqXAbPWxYcPTroB2BLlfejD9mzn+Mj2FyBL+Yph5bLNOFKySJG096m48xC2iuOMyi394rUp52Od4sZ/ncN2YPGWKfYahTeGdqXbDlo42aWM4pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784856322; c=relaxed/simple;
	bh=e4SAkjXOT+31fiezqGGMWlUOMQAVVKnIv/psxHSaAVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FcbXdn58nh5GTDzx8SuDsSolTfv5dQo080Hv/DTTA3IOkD7hhObE9fc5uFOCqDXWhuz9kYTWSANfz6rb4JmBigGaGvqm+haB04OSfbqUdxjd5dzXDTN508ZVsmYahOtrXhaMVuWxqHRfrydhom8/Jy+kF4X7aBuEDvXWjBS8r5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5cVbYp8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5cVbYp8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2741F000E9;
	Fri, 24 Jul 2026 01:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784856320;
	bh=fFJys4IqGvkj5cTHvJg9IB73rXw9akIqXBPRX34dXhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W5cVbYp8/PC/cmS8JY5/UWoiiKNmTca+gk3iHnLz6d0ytR25+U87sUiVUEbhJLKWL
	 3xpDorf9eRfVwT/Hqmp8jDnwkkzGEWDW3MX9drqsak0E9NeeExuA9GmoTZLgTWIE7K
	 wP/OMvYLcQ7dQAUp8GaQ0tRzaTrsUMRz/Ha2nxx19H5wV6g7gWSNC6gHpxRgqbAuIx
	 8tVMTUgV0gg+0ZCGov0JT+WDs7OyvQjAMzdpsKBLY7h4s++qjmwjZSLMo18OM7oVoU
	 t0fbecktqDDZFwY0CSW8uMwrG4DEoSh/EuVxlsNhlQVNLGa7hMNyQGZd9oebYoVUYf
	 PsX4DYIYFXvSA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Chris Mason <clm@meta.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/5] SUNRPC: Bound-check xdr_buf_to_bvec() stores before writing
Date: Thu, 23 Jul 2026 21:25:14 -0400
Message-ID: <20260724012515.3833219-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724012515.3833219-1-sashal@kernel.org>
References: <2026072058-disparate-ventricle-c83c@gregkh>
 <20260724012515.3833219-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 42f5b80dda6b86e424054baf1475df686c403d5c ]

xdr_buf_to_bvec() writes a bio_vec into the caller's array before
testing whether that slot is in range, and the head branch performs
the store with no check at all. When the caller's budget is exactly
used up, the next store lands one element past the end of the array.
The overflow label returns count - 1, which masks the surplus store
but cannot undo it.

rq_bvec, the array passed by nfsd_vfs_write(), is allocated to
exactly rq_maxpages entries with no slack. The OOB store can land in
adjacent slab memory; the bv_len and bv_offset fields written there
are derived from client-supplied RPC payload sizes.

Move the in-range check ahead of the store in the head, page-loop,
and tail branches. With the check at the top of each sequence, count
is incremented only after a successful store, so the overflow label
can return count directly.

Reported-by: Chris Mason <clm@meta.com>
Fixes: 2eb2b9358181 ("SUNRPC: Convert svc_tcp_sendmsg to use bio_vecs directly")
Cc: stable@vger.kernel.org
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: 18c1cc698861 ("SUNRPC: Return an error from xdr_buf_to_bvec() on overflow")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/xdr.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 4d8287337e69da..43101b82cc5243 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -180,6 +180,8 @@ unsigned int xdr_buf_to_bvec(struct bio_vec *bvec, unsigned int bvec_size,
 	unsigned int count = 0;
 
 	if (head->iov_len) {
+		if (unlikely(count >= bvec_size))
+			goto bvec_overflow;
 		bvec_set_virt(bvec++, head->iov_base, head->iov_len);
 		++count;
 	}
@@ -193,25 +195,27 @@ unsigned int xdr_buf_to_bvec(struct bio_vec *bvec, unsigned int bvec_size,
 		while (remaining > 0) {
 			len = min_t(unsigned int, remaining,
 				    PAGE_SIZE - offset);
+			if (unlikely(count >= bvec_size))
+				goto bvec_overflow;
 			bvec_set_page(bvec++, *pages++, len, offset);
 			remaining -= len;
 			offset = 0;
-			if (unlikely(++count > bvec_size))
-				goto bvec_overflow;
+			++count;
 		}
 	}
 
 	if (tail->iov_len) {
-		bvec_set_virt(bvec, tail->iov_base, tail->iov_len);
-		if (unlikely(++count > bvec_size))
+		if (unlikely(count >= bvec_size))
 			goto bvec_overflow;
+		bvec_set_virt(bvec, tail->iov_base, tail->iov_len);
+		++count;
 	}
 
 	return count;
 
 bvec_overflow:
 	pr_warn_once("%s: bio_vec array overflow\n", __func__);
-	return count - 1;
+	return count;
 }
 
 /**
-- 
2.53.0

