Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98904418FC;
	Tue, 16 Jun 2026 15:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781622545; cv=none; b=aG1883jyWTFT1q4LiA0wfELOrKifPxBjC8msB9O/PJMcxNpaRmR1obqxPzYxxY7erNyhtHRK3cOqH+eLQGZC1YhRkyQ8Ul8k9yyMxOjXjqIEeXURMm51MLH9nNvComY/hMBNG8aTtBQFKley/7dEIoD8n5rWJHFqpHb02ZMzIvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781622545; c=relaxed/simple;
	bh=6tDZkZhMI/2MA6BEKZQB0AGStLHXzS8SPxusuu1Pb3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JATgQt8MfE8T1bcr+Wlj2KQMUQ/dnOj5rarT8A5X3uhdRVq81nGtTk5XGM17Hk1TbUCLpNs+wKCatJGwYDUK6GzyDpFQ/Qh6GY5klK8+ycoJG0jBNLmbKSR9ctnkyvcZw849qXXYY7TO5RTEVX3VLPYk+v1BP/2u5A7w2FVnY8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iz25/H2i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iz25/H2i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43BF21F000E9;
	Tue, 16 Jun 2026 15:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781622544;
	bh=FuaM4fRepF/o1XaIHUwvQhwbfg7Aj8WjTOuDU58kPoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iz25/H2iCs0QaO9SUmnaN62+yvDA8BVabum7KyzQ7hdbZARJVaxVPDcyCDTJtzOw9
	 MIfHWp2hmuQEvl9HlpFI7OVECkwljZGWy0cZR/r0ZRbKJKHChlHpr2Jvfb5leJBjp+
	 JS6LaqB3S05VZdQgN6LdhXb67dwYHSa2JkSr9/qC6ojLB0YrNTLt0mcFhXGCNybQlE
	 0r9XkkM5k3P60CoHfGmEoI3LZTXfBQ90TFisELBGZ8ybJtYpmww8gB8EqRHasDRpuJ
	 hUmZGIoPB8FdrQ9n4+Fotyb/2qW1AG6POOhljTnOZV6iNqal5RE4YCIG+5rJcS2geQ
	 Cca+mrV3a8SRw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 8 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 6/9] mm/damon/sysfs-schemes: kobject_del() scheme quota goal dirs
Date: Tue, 16 Jun 2026 08:08:40 -0700
Message-ID: <20260616150844.88305-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616150844.88305-1-sj@kernel.org>
References: <20260616150844.88305-1-sj@kernel.org>
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
index 300930c2c5b3f..737638be84f15 100644
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
