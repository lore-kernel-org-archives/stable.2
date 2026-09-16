Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2674EC675
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 14:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789569740; cv=none; b=ZsqK2DkZAcppi3hZYcSBOO78R6oD1xgn2+2FLcVwbZoFtcow/9gNism7qhUZXbo6Gou0e14puH3BFMGmkpirqekt/CesqDkcttaiTj9itjAZOXfG5oyg1AFdjLCss2G3M1G/ltv+bIPegk0/17CMgqB9fj6lHfML5u/MxWKRZis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789569740; c=relaxed/simple;
	bh=H1UpL8RE+4ubIeODOHRKKNMEkz2Emg2PEoozV6LwmdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fHkATEvYgJLe4IsaF/N0aErP+S56HcJrOLMHkk7Rrbn03beXhvP0V76PTIzxLsYbisuA4LmgsADfga5yFZ1PPk58T/5jajq/D3jZhy1x8uCMKt5ou8U1ebmYpUV5/2Zb4mtxzkbKZ9qp6GmQ/Ls6V6YC3qCuLWMl9+Yn2mNG4oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDuO/BLJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDuO/BLJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1F31F00893;
	Wed, 16 Sep 2026 14:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789569737;
	bh=z4+5ZDCl3IpaHTGAbKAbhO6uoQCfnp65A60IcD/kffk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hDuO/BLJE8uHQZ2iJvxHoOHZTU68JRLJxJkxi8up69tEjqOnMg5HCECrqS/eUCA8t
	 6souMJbN5hfAeRe6JBmMZQM+IjUxmgQTcwFXKJsN6rmP8YiCHrSlLoC+9eQhhgusXq
	 IgmEFPplRVBV5DkpU0Y2/b8ubGCIuxg3nC76zSyDm8imaz/2JcuWPH0jvRYHLkeDIT
	 t3ibfaimJsvmiZMrtowv0cG1QzgF8wtQk/2veFLJdZCktoP6NaZ1O07ZYOedDf1yOQ
	 1U/bhgylc2rTG56gpc7tXxggRQUKYd9WGjHPVOx2iJJWK5Yqx6g5BVvP78euDtA3i7
	 cl5iqBq/MsFLQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] path: add cleanup helper
Date: Wed, 16 Sep 2026 10:42:13 -0400
Message-ID: <20260916144215.3565253-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091643-quickness-ammonia-8ff3@gregkh>
References: <2026091643-quickness-ammonia-8ff3@gregkh>
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

