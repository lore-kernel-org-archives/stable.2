Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793886322;
	b=rEnMqbu2SEwnL07rnPB2H4hIQyJuuXYfMED51SY8vTvIMZoNURYoa3BdfZJB2eb12Bgy
	 gB+Y5V4QZWMhxtdsdjhtz0QdoWH1Ek7KbbzIxi8p1eXUuArHIkNBS3pWY81+9fxRY1HAa
	 OLSga1nYYfk6Dtuiqeo4/ZP9idvAV9An13NvP1ynk2UFbGQ8kY22hTu4IaweOrU4M9wvI
	 CJUhxBD+GiFZOWXeZBeB2+7jdRz01wdRnrF2BoVb0EEkEOMh+cYAHeDOSggkZMuTQw6Tv
	 YzuYqR6P07bVeUpsoX8bmUlqSeQXQ050m1/vcFC5KhZc1qG0DC4HOf4FvnyIr7XOrsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793886322;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GK2AysT2g+5dlAy+740tCfT7P3+RaAyau3ZULAxFDIQ=;
	b=fzBIHggOUhRAsABCMgG8qWeUtKuUa6Q5GeBPQczAt4P/tRnE57pRyqUnGJMRaqTYzJPP
	 E0r9qwJACVTUewsnxe+Z8ajF2IbuqckCJKtGjSgi7YMMfjcQVaPr9z3EhRCaIRNIv9mEz
	 BPWngdY2POpVVlylDwJgIXgvXpswhXidhncicOxeeaYu1Npvz2EDGz9XMtwaXurbBxCFi
	 mjZMP+WnOBR73FxwwEXr//okdY/I0rAaZJ0LagU8tVN+1fljYdtrEA7otcAvLv8MqupI2
	 /bniRRFLyO7JyYd1+QVrkWcf7rwOy2QU/uMB3mOdNepZLctgMy3bE+Qc/jZ0Y/oR2rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YxaO9m+D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DA3606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 13:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YxaO9m+D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2479F1F000C1;
	Thu,  5 Nov 2026 13:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793886321;
	bh=GK2AysT2g+5dlAy+740tCfT7P3+RaAyau3ZULAxFDIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YxaO9m+DXDIDQpwRNkmLa0TC1hofrSOzyMbrdyfEzjzKBIagu3niNw5BohjUp67/X
	 4sVPxKDCCtkVni0Oz+QSd9AZzbXxp0NrYp2QI29Y0jR6Kji4b4Yr8DZmiQAx5+l3sn
	 2yhRsVDfR/z0oPkNXLfo+9nYLNZmr/Q64SlR2AUb17dD7ZVrIumNtVeorzqo8GX2YF
	 31Z5ue2FngZOJBAN774fbXdgdQlerheSYTmaeAK73iWc/uxPHdC138AkloQYAyfhV5
	 1t1v/cR5arCcS05xDbH4YsT61f6gvSSNLT0jSz3S0bWWVHFRrzPDOxWUzx98y1yajk
	 /O33T/jM81sEg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] xfs: fix buffer overruns in xfs_ioc_attr_list
Date: Thu,  5 Nov 2026 08:45:19 -0500
Message-ID: <20261105134352.1395474-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110440-penalize-refocus-9272@gregkh>
References: <2026110440-penalize-refocus-9272@gregkh>
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

[ Upstream commit 0b9081a774ee7b9dff1e9ac3765b73c1d6bba5b2 ]

When we converted the al_offset array in struct xfs_attrlist into a VLA,
the size of the object shrank by 4 bytes.  Unfortunately, the buffer
size validation in the attrlist ioctl wasn't updated to notice this, so
the al_offset[0] assignment blindly writes off the end of the buffer.
LOLLM noticed the omitted check and complained.

Cc: stable@vger.kernel.org # v6.5
Fixes: 371baf5c9750a2 ("xfs: convert flex-array declarations in struct xfs_attrlist*")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
[ sashal: Applied the unchanged fix at the existing xfs_ioc_attr_list() location because the upstream file split is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 1d0c529255667..8f57f478a9b24 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -383,7 +383,7 @@ xfs_ioc_attr_list(
 	void				*buffer;
 	int				error;
 
-	if (bufsize < sizeof(struct xfs_attrlist) ||
+	if (bufsize < struct_size(alist, al_offset, 1) ||
 	    bufsize > XFS_XATTR_LIST_MAX)
 		return -EINVAL;
 
-- 
2.53.0

