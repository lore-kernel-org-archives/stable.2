Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4571B492E22;
	Wed,  9 Sep 2026 03:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788926138; cv=none; b=m4BYSPYLHp8j7w0za1U/EYzlehhDNnZC0ZDhj866fdw9khIStp+UGm2E/TN/tk3IjGyoNW4QfKgYycARAYyw9G/D+JmuFO2+raBzsyl5vGRfyPRGZQHtsr3jQm5fgZWLdPYNjHWP5lRBDyvlxqrIncnWhZ1gph/VzCVaMzCMLFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788926138; c=relaxed/simple;
	bh=cq7mUkAGeEyv3KgxkJgZ8NEWFrXTCVefYXMxgG+OApc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ONoNccqAOTc2TfCjnI5EQFMPKU1WcnIbUQX9IzyrfYX4DC9Cva4c+nZiXozFFloe+Tf80qq9yg66tGUsXxn8qRDFcg2RvjJBRkPt3YLH0W7uchggb6uAD7b03lXCJqYG/DjQdlXp4bd/8id7ZmzPLveUkzlyQrmhwhOWa5uU5uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQgXwf/l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQgXwf/l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 003111F00A3A;
	Wed,  9 Sep 2026 03:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788926137;
	bh=Vq+t2kJ2c2koofbAuX5JsAQ3LgK32fLRwrrs3+BfP34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cQgXwf/l2H/LSx576oCNoYYcH9Dl9R4fEsOxUrJoWuOcjHn7buyAIpMD8x9GZL/LM
	 +cdlvIGiadzL94PPW3N7Zbjb92leySFXPtEvc5vGKeyIfcex2f7TGxN6WR/4snLxUS
	 RD7uf3F422nkRfJ/XNsgX9AeHKnl1Jhfhk2ZmWAsjED5lbExxrnfEds3/Q75e2TpTi
	 HJWCJA+SxI1nKDrQwFr0JWBTU79djS/jAlBOTMnvQDU9P5cK3YxX2OWoncXbhtwIQN
	 EAmxDqJJaoci/6tD1jgqPAh790l5zC4rWKqeFsGQ/F4DykYeHiGjOOt+t9bu2gRSJh
	 YXISL2JsnMCiQ==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] mm/damon/sysfs-schemes: kobject_del() scheme dirs
Date: Tue,  8 Sep 2026 20:55:29 -0700
Message-ID: <20260909035529.159422-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026090817-livable-sturdily-4c48@gregkh>
References: <2026090817-livable-sturdily-4c48@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On CONFIG_DEBUG_KOBJECT_RELEASE enabled kernel, lack of kobject_del()
could cause directories creation failures due to the name conflicts.  Fix
those issues for scheme directories by adding kobject_del() calls.

Link: https://lore.kernel.org/20260628220121.97360-4-sj@kernel.org
Fixes: 7e84b1f8212a ("mm/damon/sysfs: support DAMON-based Operation Schemes")
Signed-off-by: SJ Park <sj@kernel.org>
Cc: <stable@vger.kernel.org> # 5.18.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 05fb6ac98c49be870c5f9ccdfdf95f0107e564ae)
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index bb2f4650741fa..7e4fb112d1154 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -954,6 +954,7 @@ static void damon_sysfs_schemes_rm_dirs(struct damon_sysfs_schemes *schemes)
 
 	for (i = 0; i < schemes->nr; i++) {
 		damon_sysfs_scheme_rm_dirs(schemes_arr[i]);
+		kobject_del(&schemes_arr[i]->kobj);
 		kobject_put(&schemes_arr[i]->kobj);
 	}
 	schemes->nr = 0;
@@ -991,13 +992,15 @@ static int damon_sysfs_schemes_add_dirs(struct damon_sysfs_schemes *schemes,
 			goto out;
 		err = damon_sysfs_scheme_add_dirs(scheme);
 		if (err)
-			goto out;
+			goto del_out;
 
 		schemes_arr[i] = scheme;
 		schemes->nr++;
 	}
 	return 0;
 
+del_out:
+	kobject_del(&scheme->kobj);
 out:
 	damon_sysfs_schemes_rm_dirs(schemes);
 	kobject_put(&scheme->kobj);
-- 
2.47.3

