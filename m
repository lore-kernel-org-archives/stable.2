Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793926160;
	b=MjHeavdEVUkjmVBBgkoVJLS1n04Otqa2ycBsOX4GRPmKb99fugtPrXOnrHDsl0mGPtb4
	 muNfkipWaMftVgWB4lSNkiF0Gsvg0/LW6b2onTE+XT0eFC67imbF9HEsCe9OaFVP+tCAQ
	 e2hJfCjvZargARP+VxMZH6vsPagXsnA7a6PzbvXErxGaO77kIv4qEh2dlT1xIwTXaKSG+
	 q6mfzfks1IXyw4GEZCyJ5g0xNgTJfgOFLzpkpx2KFnj6WLAAZKEc2JK61Ct6QbyBoeXiF
	 Qfqb698npDxd99g8pJlQfUxJUXZtZIL9Dx+mbLp8FQQhgu8xX9/8bXWM+DqZlrfK04Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793926160;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=jgz8wjvlW1s4UExojFhFRF462vA+T7Z/XNDEjPACEes=;
	b=IwcxuQdtC70J4LxpyEanDno9sdeAcHppqscJZ6VzHGQ9FuXLurEaMhgPpZugf2Tbj9/z
	 myDE77Jd7zuroMIo1PtWq07U02kyApqJJ0MoLLUYVitYd8XFlbQyQTZzyuG0eTbRwWdOe
	 deERUb+nGIrfADEtN25u1MZUduko+gDBEyKwIIWcipRXfRwKwjES6YRBq6qhuA44QrCBF
	 X2fdcXPV/6dnlOeWIe6dau54/R0W4mMc10JW5pUXwVnFGy2cLMQxIvhJqmqc9EEPH0sUS
	 WxdL0WQNc4uawv7mZ7HdTR8YxUgk6wWZPB59C40fDmS+qsehFa7XT4JgpUDKT+0AQNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZXP5JWqq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274B4606A31B
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 00:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZXP5JWqq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F381F0089F;
	Fri,  6 Nov 2026 00:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793926159;
	bh=jgz8wjvlW1s4UExojFhFRF462vA+T7Z/XNDEjPACEes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZXP5JWqqA7mQEiIAJUWM11T+z/+GZwG2SIheW6VZlaYk/a8F/ULBYRXOJVOtvdc7p
	 RgRugGNypbbzGvieEJnAWQtxoOPb+Lf4Xe1N/mFBoeWk3Xe2hs+yXTejC7W3Q5eoBO
	 MpB+DrYCyMCWLwV5DcVGnW1LOTdRAiYDxj/UjFPlkdQJwhYjYl8W0UhIHkmO49P0tq
	 ybtPurTDs6ugnLrNDMgK1N46t0Az6FuIdLIu2RMOFqg+aZhEPiAxqqVrzUWB8APLnr
	 tjBxeDLMe0FvTSZyqvny2LRAV3e2y6X+N1mdZUacLcPpZPQna2RGeunB0GFqpQPVUF
	 OU7IJhQw5hzEg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] xfs: check for buffer overruns when examining local/remote xattr entries
Date: Thu,  5 Nov 2026 19:49:18 -0500
Message-ID: <20261106004455.2757412-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110429-grazing-remission-18fd@gregkh>
References: <2026110429-grazing-remission-18fd@gregkh>
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

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit 91c41f9524906a8ebd2ae68c98a07b4bd5255ddb ]

LOLLM noticed that the xattr scrub and repair code can walk off the end
of the buffer if the xattr entry record starts so close to the end of
the buffer that there's not even space for the entry structure itself.
Strengthen the bounds checking here.

Cc: stable@vger.kernel.org # v4.15
Fixes: 13791d3b833428 ("xfs: scrub extended attribute leaf space")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
[ sashal: adapted checks to the combined void xchk_xattr_entry() function, omitting the upstream repair changes ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/attr.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/xfs/scrub/attr.c b/fs/xfs/scrub/attr.c
index 558f44ccb13fe..3947fb3deb140 100644
--- a/fs/xfs/scrub/attr.c
+++ b/fs/xfs/scrub/attr.c
@@ -276,6 +276,12 @@ xchk_xattr_entry(
 	/* Check the name information. */
 	if (ent->flags & XFS_ATTR_LOCAL) {
 		lentry = xfs_attr3_leaf_name_local(leaf, idx);
+		name_end = (char *)lentry + offsetof(typeof(*lentry), nameval[0]);
+		if (name_end > buf_end) {
+			xchk_da_set_corrupt(ds, level);
+			return;
+		}
+
 		namesize = xfs_attr_leaf_entsize_local(lentry->namelen,
 				be16_to_cpu(lentry->valuelen));
 		name_end = (char *)lentry + namesize;
@@ -283,6 +289,12 @@ xchk_xattr_entry(
 			xchk_da_set_corrupt(ds, level);
 	} else {
 		rentry = xfs_attr3_leaf_name_remote(leaf, idx);
+		name_end = (char *)rentry + offsetof(typeof(*rentry), name[0]);
+		if (name_end > buf_end) {
+			xchk_da_set_corrupt(ds, level);
+			return;
+		}
+
 		namesize = xfs_attr_leaf_entsize_remote(rentry->namelen);
 		name_end = (char *)rentry + namesize;
 		if (rentry->namelen == 0)
-- 
2.53.0

