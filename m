Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FD219EED3;
	Wed, 17 Jun 2026 14:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781707723; cv=none; b=cSZDxJLz0xXWaB42q0vbOq6LLfk6XVk97Ox+9Fb/U0HrCLP2cuwM7ASJ0PO5xfj+nOH/hbmTJ8o/m8roXUJqRG1flIkjEAvGdw0gm/k0NyUujWly3GBZKps7KpbdvuRy9uc5IqStHN2uVYsbELqCJieZ9UG40YnKtjiTOzENo5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781707723; c=relaxed/simple;
	bh=lQ+hXp0EG7HRMiej8K9CBjlYy9fdmquWxB/ps/nsJ6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C7c4DjkMXMsL20XWUNOuxvN9k5QQVeWhCtnnUtLktuKb4trKB21aqyEucBHB54ErhxyorCARHC+j1tEX6xhlZrAHuwdbfv3dmBTgUNbe8hhTKgR86ll8as6hngT+X75QInBOZ+DuNrJ2il5NR/k0Wmp0z0ZXU8c0rOgidMgmWe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOTuBBHc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOTuBBHc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66841F000E9;
	Wed, 17 Jun 2026 14:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781707722;
	bh=AsGS+HxEzDkHzhjYAPG09eB03bpLenO2Lknga+uqbAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IOTuBBHcg7Eti+iec8DTFhmVDja0Nd0xAbNiiVXffYZZTH209O/K1Gk1vnCEphP9M
	 9uPUQIX5zInGml/zaPsKlf0B6HfI/Kuoj6Sb1DMH5AM8FEDjqaj19RSSdzyIEonwAg
	 XOkb2YY3KTK6B/ZSni5tCz+iFk45Iif4OlnA3BbS6dEk5OlORKzumo/GOQWq99x3kx
	 TadvDW2B0tF/0kK/Iyl95+iDxBIHE0dk4T/mmdEnS5kOWO8beiCAk8Nau/hiis+e+Y
	 hqvNvY3rf5UywoHLihgr4rg1YXnHxcvlLBgyUUeY2npS63nVo3had6Gbso5AZhW4/y
	 7l9cYTMQpgTkQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 8 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 06/11] mm/damon/sysfs-schemes: kobject_del() scheme quota goal dirs
Date: Wed, 17 Jun 2026 07:48:00 -0700
Message-ID: <20260617144807.91441-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260617144807.91441-1-sj@kernel.org>
References: <20260617144807.91441-1-sj@kernel.org>
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
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index db6226c05b023..573a40c679be3 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1465,8 +1465,10 @@ static void damos_sysfs_quota_goals_rm_dirs(
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
