Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03B0470436
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 11:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038519; cv=none; b=Xp56CCBUQe/FSmgLw1a72/lebzRpFGyVMeQ2DZfAW3Qdmwu0KqHZmZOzkMAj+91NBAmyVgVH42HnTmD3U1hcSeOjHeleoxSsxKLjKpoz65KLJ/TvjubA4A1PfQ30mIFPgWhbjABWjntMfnFYN7HlVf+lUmNfHV303jRk1kymWeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038519; c=relaxed/simple;
	bh=we2gx1mWll2kf6K8cEHy/7WfIDtVufBIp1Ammot7Dys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bl65GsHzQ5kUedYBXKvLcLZbGvaKoI2/MkVoNw+tVt/nKLkuY6TaUSJwmZBa012mjv3bgbJOYkvX/9tzlx0xmHD1zPZLpQw0XD4oJMNqVZyYGEdVcUuh6MSW+PEuTPR1Swof9r90w/FvLc/XB70ECOPuPZysRLPct7KoP/s7pmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFk84Az/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFk84Az/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12CE01F000FF;
	Thu, 10 Sep 2026 11:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789038518;
	bh=cBFCeCabkczFZ/6i1LzyI3FPa/SKR/LyEAA4IAEyU2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nFk84Az/BDJ5+aE3lpAWB5yhq/wSWslTqu9aUIq7tHjyv8piCnoNSg7GpjTup8MdP
	 C8olkBFizHXsaAyFG2J/n5ULO5pL1OZ6NeDH6G0WWfIE/Joxv1BtuXfW+J9Tyt76X0
	 XUGGG/PLAy99Sa4FJui1HxysgpK3v/r5jvahWdL3MAKW0jknbjhtOBDtTmrsd/GcMX
	 09g7fcFFygJeLrKp3AXepEwURjtYMOodN8z+tAsa5Ysrc/tNb939EYS0a+6qWrD6vR
	 pXgSBpAm+eQt6FmbgQG7YjBMSYU5t5UFXYC30WJBDIUBteBBsi4jP918xGcnQTz4bu
	 rc8ZqSkyj9VKg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	syzbot+c6d94bedd910a8216d25@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/7] fs/ntfs3: Add rough attr alloc_size check
Date: Thu, 10 Sep 2026 07:08:31 -0400
Message-ID: <20260910110835.4144700-3-sashal@kernel.org>
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

[ Upstream commit c4a8ba334262e9a5c158d618a4820e1b9c12495c ]

Reported-by: syzbot+c6d94bedd910a8216d25@syzkaller.appspotmail.com
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Stable-dep-of: 7c4841e2a627 ("fs/ntfs3: fix slab-out-of-bounds write in ni_create_attr_list()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/record.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index dbf1d520e21e6..e633fabdfbe5e 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -327,6 +327,9 @@ struct ATTRIB *mi_enum_attr(struct ntfs_inode *ni, struct mft_inode *mi,
 
 		if (attr->nres.c_unit)
 			return NULL;
+
+		if (alloc_size > mi->sbi->volume.size)
+			return NULL;
 	}
 
 	return attr;
-- 
2.53.0

