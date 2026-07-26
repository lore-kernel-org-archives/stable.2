Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3753A371885
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 13:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785072924; cv=none; b=OKbYHeAHh15ZhoTg2oS9iUH8C93Kfo3uM9vnfs9BWuS6ef+MeuqMQgIUXB0hgGaDRuwbnTBTonko8WtjMxA52BQnqPAnR4IrfttvefbDjm3UcFV1wUKuZrj9AHoFZ5UIYkQtbnPdXhzgVIxq2l8h+6js+JOZHLq90Z/mrJvuywk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785072924; c=relaxed/simple;
	bh=Z8F84BXjiVBkoWFPBKlGBvC9BAJ5sLWeY07YT707YMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VgGasSpwtv1hroGxeYn9QV2dZHM3jpTTgZz5jikBCm7J/+JefrF9XGGFn6cLiXBaU2AGpfPQVWoB7v6SUPSbQT7hcd5/HJnMhsOpsm6LuBJOI3f5yB9BJfXn+zoHuUh5KjtOMHRXlhsJj9PrLsUpRmmgl8N3s3GRp554Gpu9MBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Az85m0WE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Az85m0WE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57BA61F00A3D;
	Sun, 26 Jul 2026 13:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785072922;
	bh=mgTevTIxReJ8Xn8AqnRZwDip0M5VpWKjBtt4pWc/Mxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Az85m0WEDomMln/1TO60gjeT8WxwsuyQEvYL7FDE6S8YHuY8Gz6fq7Y5OdbSl4Zhn
	 020J/HLjNuZlJ6x2bPYLf0anZxN/etUw4DP7Xrla0LjhSLWWi2r5ymbymzVuAn0dOh
	 w2axjad1mmFXrl1E5Uwo0K3QBEqosubLYzP9d0tjHz9gkWpzsB10mdW0Qzpys0duHk
	 oSk6r7xM2adjMthB+o7fUgkXuXgTeJtqm0YOXT72xhUYa+6gst8ILHyVXZy6BwGYM5
	 4Mw+5kxZTez9tm+KEkKwjK3WKCqBHKx0PDwxGi9Y0LsLURl76S7Q4IQTe4iZDPYuRP
	 RkLk3MOgnZzfg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] taskstats: fill_stats_for_tgid: use for_each_thread()
Date: Sun, 26 Jul 2026 09:35:19 -0400
Message-ID: <20260726133520.364343-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072047-tameness-overlap-0f45@gregkh>
References: <2026072047-tameness-overlap-0f45@gregkh>
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
index 14c65293a865c2..a0b04f2b223496 100644
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

