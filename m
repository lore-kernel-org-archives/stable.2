Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4DC5474F
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 11:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787138065; cv=none; b=g5fqJKiENRiq1wZbbracz/MOiwVO3p13c1Dp0A3/Pgskrvgmq4mlhcEuQlwcMWC491+WZgP0/LhSQ+OGZ3328u6UUGu+r5dc64rkaXnd65FvgkcGuNbj3XseTJeKX8F33AbWO8IWLwWcLP3236JpCWtZZWo8Oe0Fx3AqHNRoKkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787138065; c=relaxed/simple;
	bh=W3a48UxhfpJXf3MmUFuGzWRIZVzs85yYwc7VlHQHnZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kB244M2FgxcV0s10o3ZW6eqrLzw+NPVSkS7hhNGUqQPGQ/SwV/VZBXKk/gVZ2mX7iTyUSDHuM7ft6k0hADE8SNY+Uwgwk7EgoNf4CUTjAKsradMZZI4gc0awwS5mRdxKDSIzCEaK/9nKN2B1MGRDbd6gmsrHBEErVDvd1GNKycc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Og1sylnX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Og1sylnX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2384B1F000E9;
	Wed, 19 Aug 2026 11:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787138063;
	bh=J+6uvOEEpsn5cFa+0zyBftsDwnuGQNzFiiC4WdtOH04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Og1sylnXk+Uy3l9nMn9UNCZbEfaKZe9A1j5/gSpVdTdSxmWRUlXGSN8A1KqOfgcNO
	 VYzC9/QTUg0+kaiPjnNmM9X36p72SyDHWIw+Py56EcG3zc68G0V2q/TqOM+MsnB5Ie
	 GhapXRA7CZRwNPR6ViEBnr8m3XMGrCDuAngfWfFxTurkBOQ29MfgVDTefzZvrpRspz
	 DFp7+EDU0Pep/9Jm5XPjjsxGbbj+jpbGU1V+z1zlbHxksgleQl/0XggPoS+M8d9pAs
	 nKD5OIpnZurw/GzEYgzKGahO1vPwIxy6qZlEFjtmDM6ie2AxTRRUG5KW719iY6GhMX
	 psWJVB17Yf9yA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] sched_ext: Update p->scx.disallow warning in scx_init_task()
Date: Wed, 19 Aug 2026 07:14:18 -0400
Message-ID: <20260819111420.3549656-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081715-muscular-drizzly-bfad@gregkh>
References: <2026081715-muscular-drizzly-bfad@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tejun Heo <tj@kernel.org>

[ Upstream commit 0454a604b98a9bf301e82860cd216ec4ac563668 ]

- Always trigger the warning if p->scx.disallow is set for fork inits. There
  is no reason to set it during forks.

- Flip the positions of if/else arms to ease adding error conditions.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Stable-dep-of: 5f8b69642d18 ("sched_ext: Take cgroup_lock() first in scx_cgroup_lock()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/ext.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 83baf2708888..4e06f0a0361c 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2841,7 +2841,10 @@ static int scx_init_task(struct task_struct *p, struct task_group *tg, bool fork
 	scx_set_task_state(p, SCX_TASK_INIT);
 
 	if (p->scx.disallow) {
-		if (!fork) {
+		if (unlikely(fork)) {
+			scx_error(sch, "ops.init_task() set task->scx.disallow for %s[%d] during fork",
+				  p->comm, p->pid);
+		} else {
 			struct rq *rq;
 			struct rq_flags rf;
 
@@ -2860,9 +2863,6 @@ static int scx_init_task(struct task_struct *p, struct task_group *tg, bool fork
 			}
 
 			task_rq_unlock(rq, p, &rf);
-		} else if (p->policy == SCHED_EXT) {
-			scx_error(sch, "ops.init_task() set task->scx.disallow for %s[%d] during fork",
-				  p->comm, p->pid);
 		}
 	}
 
-- 
2.53.0

