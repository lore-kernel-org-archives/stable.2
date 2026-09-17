Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8875C377EB8
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 01:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789609184; cv=none; b=E5Rr5m+iWDoU3TUE6rUMr63/251pD0B170VRk66iG3zhoUhaVHIMYYKjz76ngDuH92qGMID+ZUZBIcagsq/5Vwz+Pn4+posPrugDbsIVhwqcU4pB+QHsJaN2FxruzjbqLYXqj5EOJJ5R/JfbFxNakyuJJfzFPqaecPOnIYxPJtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789609184; c=relaxed/simple;
	bh=yx6zfZGR9nOwtWVhAs9ttTqZcWCXjQdd2JlzPj88shc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qXacs01+vaGnvMTjv3ACGDgNgb/Ds1zBR1g1ERLGiWpOCNL2tovrKQmtHeSFfbt4dGHtpKX18USXcd/NhhZryF1mjEGV2RX8k44lo4+rXhPMKoPhov6RRBvewzeFjQPiBWWlTp7TA3tZq+MBkiuJxeX3Nuk1LOLvEMVLS9MQ/k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1M8AERf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1M8AERf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3CC31F00893;
	Thu, 17 Sep 2026 01:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789609183;
	bh=bd1vX4I+bqG2/3/N3SO0u/Ps50MCXk87/wWu1g+hsTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K1M8AERfgvEj4zgCRvrk5+fie/rvCvW9rwGQ2GRchTRAG+b/EoaPAzeoWztDODt35
	 y//o35lDZqcRzd8DMxW5mgkxa0CX1p7K0DdTbhmMbC/nHKvrn5XQ7fxmcTCQDfajt2
	 4uIol4gsdNARwZt7pLQs2jU+a2vJQNuYnAKKeB6abiUEpGMM07GFcrDXm+m2tCT804
	 7j2hBTXOQPNyGaVlP23Fw0GeGVQocPW5JOGDLPaZxdh8s0uoJHPWRTBeJRBerH5WdW
	 WRbNbLw5Wgj4qyvXSL00PQSiOi283xq5uKIDQ0GHQ7OT94108K5//G9UNDIrz/QGgK
	 4v5n/rZvNjWmA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/5] landlock: Add access_mask_subset() helper
Date: Wed, 16 Sep 2026 21:39:37 -0400
Message-ID: <20260917013940.3651217-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917013940.3651217-1-sashal@kernel.org>
References: <2026091639-trophy-refract-3155@gregkh>
 <20260917013940.3651217-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Günther Noack <gnoack3000@gmail.com>

[ Upstream commit 45f2a2926b2187d1b08132d2728af50785b007a7 ]

This helper function checks whether an access_mask_t has a subset of the
bits enabled than another one.  This expresses the intent a bit smoother
in the code and does not cost us anything when it gets inlined.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
Link: https://lore.kernel.org/r/20260206151154.97915-4-gnoack3000@gmail.com
[mic: Improve subject]
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Stable-dep-of: 2c6dc7925382 ("landlock: Fix use-after-free of the source's parent directory")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/landlock/access.h | 7 +++++++
 security/landlock/fs.c     | 4 ++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/security/landlock/access.h b/security/landlock/access.h
index 7961c6630a2d7..bab403470a6c2 100644
--- a/security/landlock/access.h
+++ b/security/landlock/access.h
@@ -97,4 +97,11 @@ landlock_upgrade_handled_access_masks(struct access_masks access_masks)
 	return access_masks;
 }
 
+/* Checks the subset relation between access masks. */
+static inline bool access_mask_subset(access_mask_t subset,
+				      access_mask_t superset)
+{
+	return (subset | superset) == superset;
+}
+
 #endif /* _SECURITY_LANDLOCK_ACCESS_H */
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index d741ed3e55680..13a15127f3ce0 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -332,7 +332,7 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
 
 	/* Files only get access rights that make sense. */
 	if (!d_is_dir(path->dentry) &&
-	    (access_rights | ACCESS_FILE) != ACCESS_FILE)
+	    !access_mask_subset(access_rights, ACCESS_FILE))
 		return -EINVAL;
 	if (WARN_ON_ONCE(ruleset->num_layers != 1))
 		return -EINVAL;
@@ -1717,7 +1717,7 @@ static int hook_file_open(struct file *const file)
 		ARRAY_SIZE(layer_masks));
 #endif /* CONFIG_AUDIT */
 
-	if ((open_access_request & allowed_access) == open_access_request)
+	if (access_mask_subset(open_access_request, allowed_access))
 		return 0;
 
 	/* Sets access to reflect the actual request. */
-- 
2.53.0

