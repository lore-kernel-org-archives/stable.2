Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CBB3ACEE0
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 12:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785069730; cv=none; b=GwkrHZ14ys6bZ3VukRpNV4pXC1wqRcbFAh1qKYwzMPKDCwpXh0swlgJPpO5rPVp7J6EY5B1cVWKaeqcceeBIBLlllYoOdkEO1CiWujxl6NVVOhhsWxXeFAulptDSE4CY6JoY+Na7NNUMxvF7qSsttA0izm98fv19ha1mluXw6qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785069730; c=relaxed/simple;
	bh=88567qwyUezVonq7o6pkHkht4aItTh3vpBiXgSMjgt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kd6mQ9qRSvG2UWsYZf0Q+yhHeMAklRWEdiFaiCRtdwtNPqyKYKhUgfkZQp2f5yFxVgkQEO/Ym5JWKCXRbgFcE8myEeNacHiuj2frU+ZvgC4vKWGtn/rjVrXo+ZIRZbmMXrZFe25fmT8SAieM/QhZ190mMGpAF18DA9gXqkg/c94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLG3xy+o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLG3xy+o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D395B1F000E9;
	Sun, 26 Jul 2026 12:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785069729;
	bh=mCCHPPUXT34JUAu7XRHOMDq0Oprvu9WCSRY5j7H5rqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lLG3xy+okKOhPJGlEpAhlikuy7NAReey5bRMQmUwTeXzoGYzczDWf/dOyCeSMV0aA
	 AmRHCOu+NtGGGXciM6WQCrePoHZqB5UxvEs9QEI5uTxYVeiHa0yTfIJOnchtT8+Bl6
	 phIvW5MXyG5JQ7/3lk9TEI9mdw4RLCHDwKKSMlyo4W6G89XuFwkvc58x0k9iBx0jvw
	 pYtXbVAIw2Eef4Fso70tQShCk2aUzWi4P8Cgmo5wZ4/wRj6sMfhC2Jcz8i23g4+Avt
	 RdLx5DrswbNtf8P7TYlP6QIf5hsOs7154mF1JsdavZAwSg0Sb82R/PoH63dIMqkDPL
	 smdRxgFkjR93Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] taskstats: fill_stats_for_tgid: use for_each_thread()
Date: Sun, 26 Jul 2026 08:42:06 -0400
Message-ID: <20260726124207.101107-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072045-canteen-finisher-8a4e@gregkh>
References: <2026072045-canteen-finisher-8a4e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Oleg Nesterov <oleg@redhat.com>

[ Upstream commit ed5378a387fd7c382497f2abcf4605e030b64044 ]

do/while_each_thread should be avoided when possible.

Plus I _think_ this change allows to avoid lock_task_sighand() but I am
not sure, I forgot everything about taskstats.  In any case, this code
does not look right in that the same thread can be accounted twice:
taskstats_exit() can account the exiting thread in signal->stats and drop
->siglock but this thread is still on the thread-group list, so
lock_task_sighand() can't help.

Link: https://lkml.kernel.org/r/20230909214951.GA24274@redhat.com
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: b3e4fbb04220 ("taskstats: retain dead thread stats in TGID queries")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/taskstats.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/taskstats.c b/kernel/taskstats.c
index a16392b1bdc145..069419c18df0bf 100644
--- a/kernel/taskstats.c
+++ b/kernel/taskstats.c
@@ -233,9 +233,8 @@ static int fill_stats_for_tgid(pid_t tgid, struct taskstats *stats)
 	else
 		memset(stats, 0, sizeof(*stats));
 
-	tsk = first;
 	start_time = ktime_get_ns();
-	do {
+	for_each_thread(first, tsk) {
 		if (tsk->exit_state)
 			continue;
 		/*
@@ -258,7 +257,7 @@ static int fill_stats_for_tgid(pid_t tgid, struct taskstats *stats)
 
 		stats->nvcsw += tsk->nvcsw;
 		stats->nivcsw += tsk->nivcsw;
-	} while_each_thread(first, tsk);
+	}
 
 	unlock_task_sighand(first, &flags);
 	rc = 0;
-- 
2.53.0

