Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470912E2665
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 00:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791938682; cv=none; b=MwLTdCSK+468nxyI+g9pY04bpOPeCA4pLw6/DNA3X7Or3tKdem6Ky7SUsMGMKI9U/k4da6yiqureGbMhGIOlbCgXPBrM9Az8kTSbS8GuhJtTAge2YlM3PdVvK93DMUjfSgTWx9zM3TBiCXjBdw8Sy5y5RRQr3W9EE0iHqqzc9YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791938682; c=relaxed/simple;
	bh=p5QG9WeqzQsmbI3lPTlCax+/O1UuT8BHhYe/e1TLa3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kcGF1al3h7Kgd1p48g679HBxJG9rZJbeXlzr1+0fRLHOaLfMJgwFukXVT4b3QcOKFoXVMj5LBXGm+wWpre7BguwhQd6mtQcltMcNb3SjCGPZ7qzLgMgwIBiUJoKKnb3uTi5p5Z+lqYkOeanwkOrpRP24l4HIpfBf3C5lVawibnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ei0a5e3P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ei0a5e3P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2D41F0089A;
	Wed, 14 Oct 2026 00:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791938680;
	bh=HdymHuEocNhVJdlmaFoaUX3tM1rUVByCu4b39Uu6adc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ei0a5e3PL8AVzIGOQc4M4Igso7dIHieeU4JQ202CjQlln/Oc2GB6FdiIdgOxgFug9
	 G5Um5/m+mcpiRG5laoyIBp/EYzzMNvWNq/cGS4IPcRAIIljS4nS/nZgFMst80b80sj
	 4E33QI26N3JlEU+EMQBxJ/2Utd3aZWnb0eOVBO1vfVkoBNV9w57b+5FviozLAcoSXd
	 w3Z1ZsZQY1XJyy/m+TI86sNYBLiuUXxVdSiGBdnEPlgfuxhwwd57SWmqdtmroPfeln
	 Bd3wHZNwumSUTwZaNj4I4TWpgsczIADOIAmLU+gBXcqotvQGC8lO69bUutZIaO2oIH
	 bBZvl3iTvx9Wg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] fs: require inode_owner_or_capable for F_SET_RW_HINT
Date: Tue, 13 Oct 2026 20:44:36 -0400
Message-ID: <20261014004346.1478485-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014004346.1478485-1-sashal@kernel.org>
References: <2026101223-sprinkled-coming-7d84@gregkh>
 <20261014004346.1478485-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit b6512519496e29270bca6b2df9baa3cc2d9d5356 ]

F_SET_RW_HINT controls data placement in the file system and / or
device and should not be available to everyone who can read a given file.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20241122122931.90408-2-hch@lst.de
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: b0d1022b9bdb ("fcntl: refuse F_SET_RW_HINT on an immutable inode")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fcntl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 8e1408e8a5853..8e5389151804f 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -296,6 +296,9 @@ static long fcntl_set_rw_hint(struct file *file, unsigned int cmd,
 	u64 __user *argp = (u64 __user *)arg;
 	u64 hint;
 
+	if (!inode_owner_or_capable(file_mnt_idmap(file), inode))
+		return -EPERM;
+
 	if (copy_from_user(&hint, argp, sizeof(hint)))
 		return -EFAULT;
 	if (!rw_hint_valid(hint))
-- 
2.53.0

