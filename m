Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80F53FBB47;
	Thu, 18 Jun 2026 15:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781795736; cv=none; b=VW18rlA925jC8BltVuiTq3NxQUw0kuZhv+K2G8mApq+BKGMVlGHj0MorcqTrAF1x8QXZq1kgKMgWIZ9+jqoOsIM8eaNDhuqjMZR5+9PkYChK01uDoLERgfnP6jkNwqdR9/8TWbjj0UokowJ+cM6LHsyiJLmIyJ7m21LEPldNvUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781795736; c=relaxed/simple;
	bh=AuFlMphkveA90yCqSXRmXIRQmPvmUuSntvti9i7Zy3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bbexSP33K0QJkEu0GGU/NTCCrmKTuIWih9pElpsK4GyIURVen4zG1Qjfos4LYZBI+T8LXKnsn1G2R6C++mN/nUflWxcumCSUb0ykvrra6c9RZLphb5PUUEWYwoU2n5KlzIkOJgs0PvuMcKH3Y97y8RI9/VpOGgouBJMiW83A1Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBzMCNZ6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBzMCNZ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201B81F00A3F;
	Thu, 18 Jun 2026 15:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781795733;
	bh=ldrKeyywA9GImftn4PhLnmtfD48DExaqHnJXAUHGEGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oBzMCNZ6CWhBgtJ8ogg1I0u0bFEXoQG5zXlf9ov+CpM8HRMOrVPfO8uvBIhRtkRB8
	 mF9IynH1WOfs3o9TtVUzpk0APlI8R/eTWPd9dlxV5vztEAob2jA3h7q6MCfHBrWJCv
	 W7N1LACeqUjeEA9RhZ31uegcI4CFirnybLHzv0M3ihs+lnZErFnPNhRlto8wYoFDqJ
	 TG4maXxZ+Jq6qRdwpsjLxPGzDkXgGLHSK99UvBsaL3V21ybWQNRMT+vKSDlOS5ZIfE
	 DSDSwl6Wz5+BkwMYnj/oiAg9n8A+kP6+kKxFVPQ7TnyeXkWz8Jx3onG81ougfKcgUm
	 LvGQd3UXhGngA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 3 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 05/11] mm/damon/sysfs-schemes: kobject_del() scheme filter dirs
Date: Thu, 18 Jun 2026 08:15:09 -0700
Message-ID: <20260618151517.5366-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260618151517.5366-1-sj@kernel.org>
References: <20260618151517.5366-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On CONFIG_DEBUG_KOBJECT_RELEASE enabled kernel, lack of kobject_del()
could cause directories creation failures due to the name conflicts. Fix
those issues for scheme filter directories by adding kobject_del()
calls.

Fixes: 472e2b70eda6 ("mm/damon/sysfs-schemes: connect filter directory and filters directory")
Cc: <stable@vger.kernel.org> # 6.3.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 36a35ad0983eb..2b0a1ac36420c 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -914,8 +914,10 @@ static void damon_sysfs_scheme_filters_rm_dirs(
 	struct damon_sysfs_scheme_filter **filters_arr = filters->filters_arr;
 	int i;
 
-	for (i = 0; i < filters->nr; i++)
+	for (i = 0; i < filters->nr; i++) {
+		kobject_del(&filters_arr[i]->kobj);
 		kobject_put(&filters_arr[i]->kobj);
+	}
 	filters->nr = 0;
 	kfree(filters_arr);
 	filters->filters_arr = NULL;
-- 
2.47.3
