Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907769;
	b=Plk78s8wBbOJVWG6TX1j43v5FoBmedTecnR14hipX8EVccDG1BgfPwRgK3herj2p97Sk
	 mCpGZ2mCnz+VWcppVcVNPu8jkpHxQ8oxbp37dFGfcaLFEaAyGgtZrr0zcAiSijq9Szn/m
	 eIj8NF+Foz0i+p3rJTUUPqkUlHrtzfFgx0rC87zeHqCNVZjPMZ7yk0/jJDe/z1tbJybox
	 7Xm1hgBVs9UOTxkdOhtxBQ0yEIeSeKHSIhVdXxF9cPh9guVhsGcA5ueaoktuO7WAdYIFr
	 FiqV/5/vYBvogKRexCZ4KwwlD/JI8PF0fAFkM3Y6gLneZw8ZY2SsdRhq42mM5Fht/KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907769;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gBFgjicN0vIw72u2jgZ9RGIJ4WV7p4mlZtHldIWNOQQ=;
	b=ORCIumiM3LfbRwfK+bLVBGO8YBb0CyR/9DcPKyNRVwn7jF2MA8i2EqBYCUh7GlV1gmNj
	 lgJ4xGzFjspsXInrBLYHJy5tE85QLpfLdp7K9O6C2OnylaSVgYvov3jPTnyw0jdjLq7Cp
	 AG/i5bb0w/p6HOdrZ1K1uKUotCkxvB6f41rWqgSnESkVf1eJdXrpr35lniDFu1WG80NSs
	 BDxIPwiwm5V8qI/sR78MyRKhrnBnJOccyIsjO+M+U8K0u4XEg1tcperHOd4ooFpL+HdBz
	 rEF6/MBNgJ0EbY84oroSK1W2y0vDiFvAm12MawnF8L/GKhcvNqRjhvX3ekpAdjDekcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lHSd2f4V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E386078573
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 19:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lHSd2f4V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA821F008A3;
	Thu,  5 Nov 2026 19:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793907769;
	bh=gBFgjicN0vIw72u2jgZ9RGIJ4WV7p4mlZtHldIWNOQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lHSd2f4VoILPHJd0WxSKUR3zu4zqb3725sTsVvC0yPTs3VAqRV2x+D3+mC0qXkH51
	 sgZ6r1oYMm/vSdqG/RILKgWFM8Otpx998GNzguFt93vmVAv1DVC0QFX107DPAH9oYA
	 ufyLoWpO7Q3F1ViE2oVIdpT7bV11BQLgza8DcOaV92KiOh6nxAz9KzH8dHjPhmSczt
	 y5YsIFHIgCx7Svhl4WjDpcOirOZuANaqh2FS/VLnwb4oAi3cuxJthkOAUJ4ZjK3wo0
	 MO0+f+XakdMThMX0VpdBUd/S7PFTwGf4neGqULG4i7raMARHEj9Jjb5xoM095JQUEJ
	 2bvMF/4dkh5gQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] xfs: check for buffer overruns when examining local/remote xattr entries
Date: Thu,  5 Nov 2026 14:42:47 -0500
Message-ID: <20261105194224.2628803-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110429-uneasy-subgroup-b993@gregkh>
References: <2026110429-uneasy-subgroup-b993@gregkh>
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
[ sashal: adapted checks to the combined void xchk_xattr_entry() function instead of separate scrub and repair helpers ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/attr.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/xfs/scrub/attr.c b/fs/xfs/scrub/attr.c
index 601e02d749881..01a2f893c156f 100644
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

