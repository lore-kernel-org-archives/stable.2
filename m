Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0A346EF92
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 11:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038520; cv=none; b=a2NzdSFjndz4+e8CmH2t7yI1MNPfNRn47F8RGQGAXCI58itk6o577qhidpSJJlXOtNNbqo7qyJTEfpxFwpsjAOQvUYoNACfBBF049QxgqKJ9FfCszgpEnRXtgklCsdnBJP4zvACw6jeaLNUbNZiuKCPpta2Q6jnxM4M+hq2K1F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038520; c=relaxed/simple;
	bh=XH3Lgveysf4FIpFglcOTj3AD5iZ7b6bacDL9vCKGJ/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QVOcaau9JQMIYR0Olk5ASdQpDys1ikuohMQ27TvHxwxeFZIfbIslQIv+gC7ZaAGma7li13WEU5xIEDCLbLIv3Sq8WdKWQTpUMmNzzDFd/8nJikADsveJp2lGsQd2+yCfzWBlrAgk/bENPQX9A7Uak1fqrZEqO/wswFV9Q1LvyOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmHd3J4/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmHd3J4/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC921F00893;
	Thu, 10 Sep 2026 11:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789038519;
	bh=mLVjiRuaZ7ftR1B5s0wxcUJ6b49QHAxqw+k8DE1nz4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EmHd3J4/dXJgtFbT5La8//Cc5NEGmKS5vwdLOpaKhkIFjbWM9Zi/4BOOACMrC7zj+
	 jVlkx8s0HLPB6IBqFC65jRJEKLmDt0spTHyY2krs3UB15aS/FCCXmGe797+tzBdHAm
	 g1xjMBo7apM+8wxDOyFUlKQduYPc9csXh4ddBFAvkIt6HOZgEtYtNcpii+wN1ECkMs
	 pN+EdunXyxv6wRrWWY5c4U+jgvcCtW2f1ECkC7wun/TxGV11zblRJUJkTkDUkEKZVh
	 I8zNh/A/a7KFbrnnvxvtfTyR3hExnz2qUT1ZzD+qTyDBxU9w0G4MXVTlBPtFuZtDoX
	 tP4ueYOXPO1jA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/7] fs/ntfs3: Sequential field availability check in mi_enum_attr()
Date: Thu, 10 Sep 2026 07:08:32 -0400
Message-ID: <20260910110835.4144700-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910110835.4144700-1-sashal@kernel.org>
References: <2026090804-parakeet-recolor-7d74@gregkh>
 <20260910110835.4144700-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 090f612756a9720ec18b0b130e28be49839d7cb5 ]

The code is slightly reformatted to consistently check field availability
without duplication.

Fixes: 556bdf27c2dd ("ntfs3: Add bounds checking to mi_enum_attr()")
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Stable-dep-of: 7c4841e2a627 ("fs/ntfs3: fix slab-out-of-bounds write in ni_create_attr_list()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/record.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index e633fabdfbe5e..e8d25f6ff15ed 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -232,6 +232,7 @@ struct ATTRIB *mi_enum_attr(struct ntfs_inode *ni, struct mft_inode *mi,
 	}
 
 	/* Can we use the first field (attr->type). */
+	/* NOTE: this code also checks attr->size availability. */
 	if (off + 8 > used) {
 		static_assert(ALIGN(sizeof(enum ATTR_TYPE), 8) == 8);
 		return NULL;
@@ -252,10 +253,6 @@ struct ATTRIB *mi_enum_attr(struct ntfs_inode *ni, struct mft_inode *mi,
 		return NULL;
 
 	asize = le32_to_cpu(attr->size);
-	if (asize < SIZEOF_RESIDENT) {
-		/* Impossible 'cause we should not return such attribute. */
-		return NULL;
-	}
 
 	/* Check overflow and boundary. */
 	if (off + asize < off || off + asize > used)
@@ -286,6 +283,10 @@ struct ATTRIB *mi_enum_attr(struct ntfs_inode *ni, struct mft_inode *mi,
 	if (attr->non_res != 1)
 		return NULL;
 
+	/* Can we use memory including attr->nres.valid_size? */
+	if (asize < SIZEOF_NONRESIDENT)
+		return NULL;
+
 	t16 = le16_to_cpu(attr->nres.run_off);
 	if (t16 > asize)
 		return NULL;
@@ -312,7 +313,8 @@ struct ATTRIB *mi_enum_attr(struct ntfs_inode *ni, struct mft_inode *mi,
 
 	if (!attr->nres.svcn && is_attr_ext(attr)) {
 		/* First segment of sparse/compressed attribute */
-		if (asize + 8 < SIZEOF_NONRESIDENT_EX)
+		/* Can we use memory including attr->nres.total_size? */
+		if (asize < SIZEOF_NONRESIDENT_EX)
 			return NULL;
 
 		tot_size = le64_to_cpu(attr->nres.total_size);
@@ -322,9 +324,6 @@ struct ATTRIB *mi_enum_attr(struct ntfs_inode *ni, struct mft_inode *mi,
 		if (tot_size > alloc_size)
 			return NULL;
 	} else {
-		if (asize + 8 < SIZEOF_NONRESIDENT)
-			return NULL;
-
 		if (attr->nres.c_unit)
 			return NULL;
 
-- 
2.53.0

