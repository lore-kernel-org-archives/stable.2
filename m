Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901526;
	b=H/FTJeWSaXC3xebXKGcaYqXGEyWXvEeU67EslZw5G8CbgtgP8Y5wuFFyAZxSICC7+xyJ
	 NE5Z4T4kB5fWqfL+85Duhrjzog3JNV8tW46NLeO4yeAiWyEYthQyTI2d/lGN+q0nPxcSU
	 F6ZFoYYIyDj/ugZf+DPjkk8lkyzY6kbVfy7gZMAmyx6e2nrE0BeKXxqEI2jxVqGMSfg67
	 sCHb59MI9gjk1TziWHWfsp3HpQ+Zph7XTxLVs5VvZUu5T6RNxui68GLiBm2bQK5cgU8Vt
	 nB8Ey8eRPEMAVOGCSJ9SzAtXxhq3V4uRd4GCHZTTeazJT9TARwi8MCdUlfyfZNq/IFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901526;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gytG2zeu3LBR2a+qL1kR6yX58t184m+fMsQtYQoHktE=;
	b=gdKEBLgfyw2SIYTZO6CxTxUKs8pHQ8Gk6DaKxo4GVT/61v+e9TIBVCC+fKHs3LSGx+N/
	 6ivFmZuuKGMlqnqlVVxxA98iiK3o1q3VahUhihHOtTikyh00KKgJjQtmLAeVgffsi+xu4
	 tvPZ4dqq99ZobnGE/44WhbdTM19+Nk6t2o2A2Yb6e40BR7Jj5MVUWme2pEUbTxJ1XJZbL
	 z984544jxi1FwuumqTUP6BRRykqATR9n/DQjPXkAphGcfRzkSdLIcX/wr0iY4t3LoMMM0
	 IvltuzqC4Mxl9j3YlLcVEkLMjYgKZL+4UhAUZJ/UaujCfCEXtiFzlwgMp32Gt4g91wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YmSEWLAV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B489606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 17:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YmSEWLAV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B28381F00919;
	Thu,  5 Nov 2026 17:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793901526;
	bh=gytG2zeu3LBR2a+qL1kR6yX58t184m+fMsQtYQoHktE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YmSEWLAV2AFOBYNIaHx8GqghS5P0msTeaEVz+XAZlm5uRpusSnBhOe8XMnXQeoiSg
	 Og0Ltm1yTS3H+FTUh+S+RdyFichADCkYVp5rG/Qp4SN93nXsXph6baCVqzOsq9TiN0
	 Ya7GvOcxtWnCY/PdpJ+byXTQg/YNdhdjfjRuc0aE9CGrc4LMQcZyK3g0qdnFBY6Hkz
	 jsVeY56x2VHVFeOzL3aemX6Q24+58kjiVqN8LLxQtRpvKj9EqMQgErjayJlZ74ptDf
	 vy3O3nHWiL4w7xfYpvYJ6zvkbIHf+nCzvd6TOfM54cYX8KpNc1h3QxNCyxdPFh2K4R
	 SCnbkWwUw5i5w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] xfs: check for buffer overruns when examining local/remote xattr entries
Date: Thu,  5 Nov 2026 12:58:44 -0500
Message-ID: <20261105175826.2184176-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110428-companion-surround-cdb4@gregkh>
References: <2026110428-companion-surround-cdb4@gregkh>
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
[ sashal: adapted separate local/remote helper checks to the existing void xchk_xattr_entry() function using bare returns ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/attr.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/xfs/scrub/attr.c b/fs/xfs/scrub/attr.c
index c785d80bbfe50..5e5115bf6c05f 100644
--- a/fs/xfs/scrub/attr.c
+++ b/fs/xfs/scrub/attr.c
@@ -334,6 +334,12 @@ xchk_xattr_entry(
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
@@ -341,6 +347,12 @@ xchk_xattr_entry(
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

