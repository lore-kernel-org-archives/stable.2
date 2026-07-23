Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CD03DAAA3
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 19:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784836750; cv=none; b=nHWQAn69EKIPPNNWd6RFT7RKJXDXeyFPbhWJ90yjRkFIUszSWZ4bZDKOROdRyZ7lv7ZtK5fjyz0Tth7aQEUKcCO/NqHr/b9z378JTnuqIB4R8fUVn60aiISWo8ozJUosoJwx7YUxy+SwapQuYFMW38/Yvthd6EAL+vOy4VPKmfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784836750; c=relaxed/simple;
	bh=e4SAkjXOT+31fiezqGGMWlUOMQAVVKnIv/psxHSaAVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dN9JwTgBjj6mBY66OE2rg1whq/Lt1EsJe/Ea6pM8cqMVhO7jwUpKuXjYbnMRBfT7/usxPpL6q9vXCUA9tvFU7w+eEMp9spVcFbPuogmH7g8Trw8L9QV3nhehjENQITUDGcveocrtQa3mxIWO7ta/D+HnaTMNmnPau2hI1bZ0ejo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+RBRy7z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+RBRy7z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E521F00A3F;
	Thu, 23 Jul 2026 19:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784836748;
	bh=fFJys4IqGvkj5cTHvJg9IB73rXw9akIqXBPRX34dXhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e+RBRy7zFUTzbAyDr+dWviamrKdVUMTHwpS3CrgmnXEhi0I6vb08+9hHhiQ9510It
	 v8NoFTnCyr2X1pqqWxmdN8uefUfIDjyAAwmevZhsC2czECWMbMoeYkqjHkyM7DsuuK
	 VMknDoyxxvK8eGZAYkd62qze0hmtstd7b+8l0ChJ5OMozpEAg/ZdEMbnxcpQSacf24
	 1WbfsYiDzrL3wCUI0X0HVIwCB8nYgZeOC4EG6o73VhLdaaFQLVUbt2snLVESPcEB8B
	 aPj7XTybSIc22lJ07/Ri/Tw6l4JwHnNSPH70sWPHn/Imz03NqwJwioT4SfLbLN1HhX
	 Myj3N706ZnLOw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Chris Mason <clm@meta.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/5] SUNRPC: Bound-check xdr_buf_to_bvec() stores before writing
Date: Thu, 23 Jul 2026 15:59:02 -0400
Message-ID: <20260723195904.3685200-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723195904.3685200-1-sashal@kernel.org>
References: <2026072058-antibody-haunt-1c24@gregkh>
 <20260723195904.3685200-1-sashal@kernel.org>
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

