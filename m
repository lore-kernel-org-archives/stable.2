Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422FD175A8B
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 12:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788265618; cv=none; b=Joyz2Hup7fR7Wbn4Yncrzx9XxAhBuO0liEedQjHhGY3B0hObhDkRExb3CZRmmFfk8bNbTVgF3NKpfOw3K4GCaliqB56Km7ccVUDVCzDS529v2pjmNh1iTEYwINKhN0zO6PxfnXC/U9Aqpu/x+99vhbgTAozvRuWO+GxvyrMabmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788265618; c=relaxed/simple;
	bh=7Q34ACZX39BwIgyh4m+8rA64bsnZpabLgc3mbIx2n/w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AWWs0Fk8v+dQk445JnalW+WWIsSjfWRC5yMpPUD7OvlMiFbGkBQl7XY9cgc6+01f3tVjVFEembtVdTwmB6UW8iuToKozbOD2ilqBF+pOySe2ZCOTbsuT4O0VzfWfOSladC7VIUZhP41CMib+3C1hqFYSXz+aPYEK3E5BcqasHZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+V8iEj1; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+V8iEj1"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4843efcbdb2so1061882f8f.2
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 05:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788265614; x=1788870414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=f6qpjX7WWAJ2cweV8AeFtOfMeKDPxjEBYU+hvHsVykk=;
        b=W+V8iEj1SYJmqTRgLxIijEMnL3aHNyuEuY4C2dSOsK7dH1KZjC6zDmRM8n5GMKp1ZK
         SuX6ipU35B4rp7XVbnYm0cBV55Ix7kF7RniaYVbPHukcutZRJSknGi1lgZMhRNV589AU
         yszNSj4AlRy5PQxP6DeAIAE/paCn+pbNgUdFQ3EGAxZUMN+u810xqmPbUssZsNxE3QeV
         ydG1Ymkt+m2UNRaiuZ4epxzi99Ddl5Iu1SMCyiHWoRhJurLoIiRLoFmMAlVbREgm7xAe
         9gHXPwEEPXrkBB4q4nr95hcW0m3x/3EEoPac5ITr/zek8JWVnxkYBK+zl+dqcJoRHmpb
         LcJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788265614; x=1788870414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f6qpjX7WWAJ2cweV8AeFtOfMeKDPxjEBYU+hvHsVykk=;
        b=LX3c4f2Y+fv3kVsYR5Atn9DCDjxgTrnKRzgg+jOsp2nqfrTsG0puKcD6s0sLdOqU2d
         lWVep95IKnxS5rO7IDwYM6N8uFsJBARymiya+60J5VFjdeM7JiWm5P/fLHLM2ra3K0sY
         7mqaZNoYgpMzUZgdBbwSUrh7znv+Cj4Xb1S5h7D25Z/GU0l3hLfnMFaqaF2hFEarQzYR
         sk/8VZiNoTY8m8730uuMwYIfgrAds40q78BtqM4uZ48+WesSD7zm7qUlDpYr1X+j1xlM
         K81z0TvDHNNIwjsz/VWUKt0qy9UeigSFNb1xowS3y19KzaxTcgrvZDPffI7nmy9tnscA
         6MBQ==
X-Gm-Message-State: AFuF++nsFZ8Y7NPNTSEmprSxxsYgHkbWDGxPTQG8p4LWLf3FhdgWQu7C
	1ByFV+xh/BgmnxGOVOjF5q4bE0pbkuUZsRuQ0upPoB/g7ZhluWpH+5n3Urdl14QG
X-Gm-Gg: AR+sD13q22uarXHG7e8bqeNYwsZvZWBSa4btlLk1JzbMC5eSzVAulTC0uDD18KK2XOu
	q6e/Qin54eBGPDu+BG1tXe3o4V/F+jBmPhgRydFPFnzdi1xbtAZqYhJUhTilyUPK9ceIqnmVst8
	4ie7Mm/EH/8gK4ndwgGXRlusg8SeA45+oqFAeVm3vxEEPgrMCSc8UwtqvD4y7fShHpDd8Je3Z7V
	Livw/MvQM+cKcskuyGWh2TDdzioYbe114HEkNTqZud7BFn5kWZ8KdEtZVE4QxkjbOi5/UiNcHW9
	JTh0KPsBKhD7lwVtlFtJ5sC9iVsEr7eBDdDX6o8kazJlH4DKLC6UbJx43jSxsqMdBJ3+tFomTYe
	SoSX/IuvDf7pD7qT3h3zXUqV+82272L6ik+v2y/6dcted6cnYZqKCiIq/5b5dgpRxZa1w57Cfye
	v3FLd2/4d76t63f6JNtKSIPMtJs/BODmR3g2fIw5Wq4ZJXv7U9AKhQpPSO0YHZsC8rvga/DU96v
	g+agyY796rl11citAnJmm0Uo4pN8eumUumEUUhjFR7TmKfXM0o7HoBJSQnJcDpLNzL7+/Ux0emG
	dcla/3TUMVOdb4RUfDxxyUFTnztsmeb5GSLMJFJEo+WPwaPZxc9fToVajA1suI0Fd28=
X-Received: by 2002:a05:600c:6091:b0:49c:d60c:74e0 with SMTP id 5b1f17b1804b1-49cdc44a420mr156178575e9.13.1788265614057;
        Tue, 01 Sep 2026 05:26:54 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a16a-7801-fd8c-4b37-36b4-e53a.310.pool.telefonica.de. [2a02:3100:a16a:7801:fd8c:4b37:36b4:e53a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce089c2sm64755395e9.2.2026.09.01.05.26.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 01 Sep 2026 05:26:53 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: stable@vger.kernel.org
Cc: Waiman Long <longman@redhat.com>,
	Ridong Chen <ridong.chen@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Guopeng Zhang <zhangguopeng@kylinos.cn>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Karl Mehltretter <kmehltretter@gmail.com>
Subject: [PATCH 6.6.y] cgroup/cpuset: Fix misplaced DL migration reset
Date: Tue,  1 Sep 2026 14:26:42 +0200
Message-Id: <20260901122642.11571-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mainline commit 4a39eda5fdd8 ("cgroup/cpuset: Reset DL migration state
on can_attach() failure") puts the common error cleanup in
cpuset_can_attach().  The 6.6.y backport instead placed that hunk at
cpuset_can_fork()'s similarly named out_unlock label, while removing
cpuset_can_attach()'s two existing targeted resets.

If cpuset_can_attach() fails after accounting a SCHED_DEADLINE task,
cgroup_migrate_execute() does not call cpuset_cancel_attach() for the
failing subsystem.  The temporary migration fields remain set, and a
later successful migration can consume the stale state and corrupt
deadline-task and pending-bandwidth accounting.

Move the reset to cpuset_can_attach()'s common error exit.  It is not
needed in cpuset_can_fork(), which never accumulates migration DL state.

Fixes: 14897ef9341c ("cgroup/cpuset: Reset DL migration state on can_attach() failure")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Applies to Linux 6.6.155 and 6.6.156-rc1.

A controlled QEMU A/B on 6.6.155 forced an attach error after accounting a
real SCHED_DEADLINE task.  The affected kernel returned with
nr_migrate_dl_tasks=1 and sum_migrate_dl_bw=104857; both fields were zero
with this patch.

The equivalent 6.1.y correction is submitted separately.

 kernel/cgroup/cpuset.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index f9c7178f51ada..bb413045d1744 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2630,6 +2630,8 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	 */
 	cs->attach_in_progress++;
 out_unlock:
+	if (ret)
+		reset_migrate_dl_data(cs);
 	mutex_unlock(&cpuset_mutex);
 	return ret;
 }
@@ -3462,8 +3464,6 @@ static int cpuset_can_fork(struct task_struct *task, struct css_set *cset)
 	cs->attach_in_progress++;
 
 out_unlock:
-	if (ret)
-		reset_migrate_dl_data(cs);
 	mutex_unlock(&cpuset_mutex);
 	return ret;
 }
-- 
2.53.0
