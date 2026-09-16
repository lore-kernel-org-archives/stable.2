Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15F14D7957
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 15:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573753; cv=none; b=hl0LU7O/XUX9wlDslmzhGqojbIe6VBgwYDw8cosgSvrPEDGpH9dJpc6ppwZRLjafa9oN8efONFnVHXWhm4ZO076yk0IRokX4RwGGtuFm+SDErYeS0/ksx0LH+P/EoSYQVTSnMw9kqceyBooT6MatGzBhCF2Iwi9/Vci1xq8A8dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573753; c=relaxed/simple;
	bh=H1UpL8RE+4ubIeODOHRKKNMEkz2Emg2PEoozV6LwmdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VLhgyawLKMAeBQPJhG38k4dynuWBM4aNBI8zFx/BQBUyJ3atLwDGRaF0fIHdZiZpj6vprEzA4ZKiMAVbnuUe99Mq4V4qgU5WbKDINm6nGSvUS6bxSw67ZBRerRUO1JIfYiXyPnvO7Pwf8VMXzQbELKQdvnIwR/yUig0akeY/UWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Az28p4Lb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Az28p4Lb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ADD31F0089A;
	Wed, 16 Sep 2026 15:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789573751;
	bh=z4+5ZDCl3IpaHTGAbKAbhO6uoQCfnp65A60IcD/kffk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Az28p4LbLVMw8qmQfYwfrlDwlmbskt9wJvZZNo6UA0VArQmC/aUnkAZV5QFuoDpSP
	 3j9mXqBugNX3qUMrJd0p1BJN8WIfE9BdXDPdBHfc+/vXWobZ4OOCq8ssTR122NPQfu
	 VPx/tdVpg+9Z97CrBjdmK87+tsUCgHzuClMih5awfIl5wBKu+iPAmbRrSkxtD68Ojn
	 qbcXlBFJpVjh4EherocFoU42ojMRaFUVP1ph3WgDC9DU2o+ZJdcaetrYiC/Rnb8DN7
	 r0x5wy76L1A1Fo+rlZ6O661tg/Odgr2YhHLiJojfTu3Wdv1oEtowZTlAmcnSbV0zKZ
	 gG6y5cuICMCvA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] path: add cleanup helper
Date: Wed, 16 Sep 2026 11:49:07 -0400
Message-ID: <20260916154909.4167397-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091644-washstand-tweed-f09f@gregkh>
References: <2026091644-washstand-tweed-f09f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit ff2c570ef7eaa9ded58e7a02dd7a68874a897508 ]

Add a simple cleanup helper so we can cleanup struct path easily.
No need for any extra machinery. Avoid DEFINE_FREE() as it causes a
local copy of struct path to be used. Just rely on path_put() directly
called from a cleanup helper.

Link: https://lore.kernel.org/r/20240607-vfs-listmount-reverse-v1-2-7877a2bfa5e5@kernel.org
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: a7c1290eef60 ("configfs: pin the symlink target's dirent instead of chasing ->ci_dentry")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/path.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/path.h b/include/linux/path.h
index 475225a03d0dc..ca073e70decd5 100644
--- a/include/linux/path.h
+++ b/include/linux/path.h
@@ -24,4 +24,13 @@ static inline void path_put_init(struct path *path)
 	*path = (struct path) { };
 }
 
+/*
+ * Cleanup macro for use with __free(path_put). Avoids dereference and
+ * copying @path unlike DEFINE_FREE(). path_put() will handle the empty
+ * path correctly just ensure @path is initialized:
+ *
+ * struct path path __free(path_put) = {};
+ */
+#define __free_path_put path_put
+
 #endif  /* _LINUX_PATH_H */
-- 
2.53.0

