Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693062E414
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 12:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785070008; cv=none; b=kRTY0YZChF627xzfPHWSwig4RhLHzBxnXGE0qtXN8sU1vDRTFgYOanXCGfH2+UBBRyTZXjp2VpOh7mJIFdnLT/ZhqYafJ9RQrh4ppAGCIBuYGrWY19wwuK6RFzFbTFltmA+Ru14tD72MG32pvxUeupxs7pyFODy4Fmy2n2k31zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785070008; c=relaxed/simple;
	bh=88567qwyUezVonq7o6pkHkht4aItTh3vpBiXgSMjgt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jeWbGiOoP5CQZLJBcB/kIXEHV1Fwj3JvgU72I+20YAqjnjsswkzmZqgTwI82jdWqRC3rNFYfn8MBRgfLs8zViXGXU0qeYLEUml89ZwKQt9xnXixflNX4L6U8wkh/M7/eOmJQirblDOku3+nzg8UX0MNi6RJGD0oN9RJo6bt99hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJN4v2ER; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJN4v2ER"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF3A91F000E9;
	Sun, 26 Jul 2026 12:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785070007;
	bh=mCCHPPUXT34JUAu7XRHOMDq0Oprvu9WCSRY5j7H5rqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BJN4v2ERwwOFzfQMalsxGkJHa+hYGoLjWEp2lCtGWnMRtxmOshs+/qh73sw7S9ZRI
	 4ZX3aya99K9fkh3y5QvJY6T/gHF0AgdvPt0UVeiwaIEZoSOrCsulO3oW30JZhKmLxC
	 OyWGl7h1iaMRyt00ZzVWpjdcfJ5aO4jlml8kt/04rXGIAnlnEGAzDMLcLykArMk6Qg
	 85pQi6d/CUF5cwOpqPsYyGmE/dzdt9d5vi404894lo/ORvyLMCJD38S8U0oMr+AjHS
	 00SeplfTdscK3ag5gJ2z5XcNA5yg260pYVfwWjYs026shS2I4Fm/IYmOfDWczz1XK2
	 3XDbmbLgyfuUA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] taskstats: fill_stats_for_tgid: use for_each_thread()
Date: Sun, 26 Jul 2026 08:46:43 -0400
Message-ID: <20260726124644.143420-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072045-lint-repose-0998@gregkh>
References: <2026072045-lint-repose-0998@gregkh>
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

