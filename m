Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1F3332EAD;
	Sun, 28 Jun 2026 22:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782684089; cv=none; b=lYa41yavwRfbVrUhKNtms9yXvqB3EZRhdabpM28NSnTRdstI7zAyqZQHV4iYkG02TFymg2KFSut1y4/RrzI0a3a3DYH7KmTSpGhVffHTtqqlEKVZUo2jQlMw63H8DZMZtinWBI413/VtD9V0jdZGcFGM9hWVzUI13AiVW5rmtEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782684089; c=relaxed/simple;
	bh=bY9JM4/YWaQF++aOUqTKn596NeVr+FddWT+swXcs78Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gYpe1qRLpeFE9iPE8cmwozag+ebnSnAhMOkxJIrrhmu4+pJ2v5Ru5k8F9FPUrJxFumAyF139e9D/hHen6Nu3mjkmdc2EQ+YIx/x2cJUKAXPLco6bdhblBeJgKyJfaG+IwMgvYvAHB+yCvV7Vdf2oKSgV0f7xx7NF7++k1DKfB1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLw7S9YL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLw7S9YL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F1151F00A3A;
	Sun, 28 Jun 2026 22:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782684088;
	bh=tKghVa2ofXRswbu+yKIaGI5IAC3ZZZ0ZVkr8KecMvtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nLw7S9YLdVPzCHa/o6oMlgOG/nKsWrF0bRwlfayUlHOz9q2XfcoCN9+rxTNg0/Mjd
	 B69Sur9C/lpiJE3UNdB26sgCsi7W5t3RtwN+iSrm5PEe9Xz9wdS5X3Ybb8ByIPZ/AC
	 Vn80skOrO+z5R0zz+TiowPcgtFMGOPvq/Z/bs5gRVIjXVnHUG0PyOVlAPZ2jFh7mdA
	 Uoz3RPFWPAi32LmB13bZtXbcixyG66Icwi2oHY42KSJwxa1RafxgdeB0hUqLrPRU3o
	 HfgvK0itTgjl8eUAO26BdIAfdN3r1COini0zrdAyjfLmN2OEHs/7Dn3Ila4jGypEfR
	 z0lOCVfxoLB+w==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	"# 6 . 8 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 06/11] mm/damon/sysfs-schemes: kobject_del() scheme quota goal dirs
Date: Sun, 28 Jun 2026 15:01:15 -0700
Message-ID: <20260628220121.97360-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260628220121.97360-1-sj@kernel.org>
References: <20260628220121.97360-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On CONFIG_DEBUG_KOBJECT_RELEASE enabled kernel, lack of kobject_del()
could cause directories creation failures due to the name conflicts. Fix
those issues for scheme quota goal directories by adding kobject_del()
calls.

Fixes: 7f262da0a30d ("mm/damon/sysfs-schemes: implement files for scheme quota goals setup")
Cc: <stable@vger.kernel.org> # 6.8.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index e955fb916a7e2..58051185713cf 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1463,8 +1463,10 @@ static void damos_sysfs_quota_goals_rm_dirs(
 	struct damos_sysfs_quota_goal **goals_arr = goals->goals_arr;
 	int i;
 
-	for (i = 0; i < goals->nr; i++)
+	for (i = 0; i < goals->nr; i++) {
+		kobject_del(&goals_arr[i]->kobj);
 		kobject_put(&goals_arr[i]->kobj);
+	}
 	goals->nr = 0;
 	kfree(goals_arr);
 	goals->goals_arr = NULL;
-- 
2.47.3
