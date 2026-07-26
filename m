Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7CA2D8DB0
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 13:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785072121; cv=none; b=ueMSnPxQHeyALrI6l1cewwwunaWBF0FFa2Tg9JW0Xeoo1SU0Haj1JPQipXnOH7S2dqufz5/zPov5TV4XTjOBhQwlrE1EZ98ZrJRkN7GvtFrTZPE/D1IxmCXlVFnzc5en9rLOvvLBWWDy6FqBc41z27ENZJtMTC/ioUz85cC6t+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785072121; c=relaxed/simple;
	bh=N0znt5OzizKjEGzO4JIRxq+UDTEYxEfRZFIU6q5gPrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z76kmm2UfG/JfoyDNuPmYSIhBadh4UwXzH3qym8POAP+yI6OhAKPXiRs+dsGvgV/dt+IlbOtrBBMBbQsZjy0kOVHZApjkU1kWtLJ7mtVrarIKocIyxwnRPK8gfFCyziti7zRk6Qnn/HOpH4CoHRvsBgAxCpHZa4rlotYO4idYfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ap3aEc62; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ap3aEc62"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572821F00A3E;
	Sun, 26 Jul 2026 13:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785072118;
	bh=PyQMlUybW7+Ml96tIPF9A0sS4GA5vtNFlPU43IZtDsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ap3aEc62zhPSa9FT7E4ncmeFVSv1KyxINcj7YNyU9YACZOuGwfZE6W/gd7ERhYF5v
	 y51zOLLMIJMeQ9aJTTo/J5QS9qMOzmbnrjkXcDjnXNn42ce3rf7vzQZ7jhL+VJam+n
	 YnGxDY4aFD7xphfTxq5CDuPEDRQCFqYJptO0oMKpatUqAdV+y19OAts7EWmW6qCaxz
	 OE6A2Q3NaSyFOMCHCIp4p5diPZr2ISlztkPAz/sM0se8mcZAcxrdJTRDbAgmrz1bii
	 R+5ADaUrGY6IaGXrGyN6bp0nW19vww1UZ2XsW4o7Ie2PDANlCUCHyh/imWSiE8PDZP
	 3cxcyEx2jiO4g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] taskstats: fill_stats_for_tgid: use for_each_thread()
Date: Sun, 26 Jul 2026 09:21:55 -0400
Message-ID: <20260726132156.327047-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072046-broker-latter-538d@gregkh>
References: <2026072046-broker-latter-538d@gregkh>
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
index e1cc9386e228a2..6916bc152ce831 100644
--- a/kernel/taskstats.c
+++ b/kernel/taskstats.c
@@ -211,9 +211,8 @@ static int fill_stats_for_tgid(pid_t tgid, struct taskstats *stats)
 	else
 		memset(stats, 0, sizeof(*stats));
 
-	tsk = first;
 	start_time = ktime_get_ns();
-	do {
+	for_each_thread(first, tsk) {
 		if (tsk->exit_state)
 			continue;
 		/*
@@ -236,7 +235,7 @@ static int fill_stats_for_tgid(pid_t tgid, struct taskstats *stats)
 
 		stats->nvcsw += tsk->nvcsw;
 		stats->nivcsw += tsk->nivcsw;
-	} while_each_thread(first, tsk);
+	}
 
 	unlock_task_sighand(first, &flags);
 	rc = 0;
-- 
2.53.0

