Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EFF513555
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 14:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568992; cv=none; b=D0HvAK5yOkEAI8euIT3MINH3A19qEhBb907wVCd8FSWl/3f0EiDCiJa4KqrfknstFRpGIHIjPx/Gq1qImGXc82iq6Ek+kl7cF/rlgI6JYd/6ZzUIAzzpJWb8hvu6PzePBEg7BUZPRs+JLZbfN9GpmDelKaaz3G59CxqJ74oi2cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568992; c=relaxed/simple;
	bh=H1UpL8RE+4ubIeODOHRKKNMEkz2Emg2PEoozV6LwmdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GahDvjoizvdEaDBk/C3NRj0ZrDD7Odjf7SJ59N70VwqkD311yAZ/TBC6oXZKeZxjy6zbKEB6cTCK7TCSjkDHxpOJyUBYd4oAFwapfhM8qFpfo7FE6HOfKoLKnaVNll8nvxQG53SsHI/aTazB61acg08UPEWmtcjG/pSUd6GRg5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PyzjYxIh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PyzjYxIh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CACEB1F00898;
	Wed, 16 Sep 2026 14:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789568991;
	bh=z4+5ZDCl3IpaHTGAbKAbhO6uoQCfnp65A60IcD/kffk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PyzjYxIhtcFJ6IXT84xvGLbIxhjbwEn0RYtPVLpGAQQ9ti8TPon9mZe+XW7zixM/c
	 /fGvA67YVzuNYS8RmNfOiaE+Ek6ysCmvkFbSrFclkd01tLfBwZkx5mFbo0HLIRD6Ph
	 D7C15nTw6GjONU+kjSiJSrowLl7IHyeu2yLmTHFpHCV194+FxbJabfSTcKTb/SjQDD
	 1pWilLKi4Mvm0iaasVxr7ott9VI+grfSRkmNmFbqZ2B1aXdQ3oWAb+TSgLdUtyma4K
	 eJ/1yHeCZZbYsYxzJXa1zvy2W1c+vLoMw/Y3hpJrVXSdys4vEgNYNwiWh3IX1Fr4v7
	 a73O6wGjgx/Uw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] path: add cleanup helper
Date: Wed, 16 Sep 2026 10:29:47 -0400
Message-ID: <20260916142949.3271509-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091643-swoop-reproach-dbbf@gregkh>
References: <2026091643-swoop-reproach-dbbf@gregkh>
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

