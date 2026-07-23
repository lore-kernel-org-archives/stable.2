Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF7044E644
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 17:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784828142; cv=none; b=QZgOtx9MKHD2eEUGJfyuuBA6gK5rZhPVqy16vAKewbR8cTSUj4iONs3gADocFr3geQfn64lN3GMohBzNrjiyOhmRbZURAyoN4NY/AIQNDnk0jZEkSeOPpeE5OQBkyErcG1bieCyxEFmqhp+5KBQqX15dgjuOU/4xHpDcgJkWPrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784828142; c=relaxed/simple;
	bh=qK4jYzLYiKz8eCWCsvRpJRNNul7xv7X8hW15OlMtKHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KZ5b7DEmUc0RRYvBXov23MMmW8qtTIv/VpXHrcK0OQmjlBiaXjiHe+hw3mdKlHvKk8ZL67X/Nb850TGjgqphCjgENKvF/5NscYRRy9Flmkqohh+aTU7hnjqK3JXxw+z/au6xNKiN6ncBinuBLhYHjHL4J+qsjvjrMD+Ko/hYB7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajC+pbvG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajC+pbvG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFFBD1F00A3E;
	Thu, 23 Jul 2026 17:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784828141;
	bh=xtzDQ0STVfETwMq8Sgb4sOzJ5AQr4hqsXnK0H1dtlLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ajC+pbvGXAhMZnoLN6QeVfu97XJOh367RT6Nn2jEUx6o8qRbqsHzJN4EixNY1ODxw
	 z3Qm7ovA7xxOublQTZl3Htw5AblXjOUiItzWu2jsPolR7Cuv5PVyOj56px5VwY/630
	 1iTDXxcXFyb5T5hYlWetfpqfRmqTsUFZHu67+BUqF11VdmkT4WxhIRUgJCcddC5pve
	 skA1IqOHbAcPBfPg2VJC9qZ+K24ig8GMTWHMXsCdhOkj7vRnFFmqZUO7ctNhXSEGtY
	 UWKc1IyD2M3CrVjMuXVDQgJkQHrsFrA3Hs8+PdK9FauSRMHAmo1S63nqzW1xFuLaLs
	 53AxvFBPLZJDA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Chris Mason <clm@meta.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 2/3] SUNRPC: Bound-check xdr_buf_to_bvec() stores before writing
Date: Thu, 23 Jul 2026 13:35:37 -0400
Message-ID: <20260723173538.3416792-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723173538.3416792-1-sashal@kernel.org>
References: <2026072057-glucose-profile-c2be@gregkh>
 <20260723173538.3416792-1-sashal@kernel.org>
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
index 516833b4c11444..2f28e41f7486c8 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -152,6 +152,8 @@ unsigned int xdr_buf_to_bvec(struct bio_vec *bvec, unsigned int bvec_size,
 	unsigned int count = 0;
 
 	if (head->iov_len) {
+		if (unlikely(count >= bvec_size))
+			goto bvec_overflow;
 		bvec_set_virt(bvec++, head->iov_base, head->iov_len);
 		++count;
 	}
@@ -165,25 +167,27 @@ unsigned int xdr_buf_to_bvec(struct bio_vec *bvec, unsigned int bvec_size,
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
 EXPORT_SYMBOL_GPL(xdr_buf_to_bvec);
 
-- 
2.53.0

