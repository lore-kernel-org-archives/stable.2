Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E0347CA73
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 13:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788268425; cv=none; b=KSbWBiGs8eioC4olVgo++5ig/czKx6F3AVfIKO7xWhEBoSuN5TsyDONMrZPWZvDfsC29ZmfUW1iQMUMZb5MuAki/E/l4Ek3KN/ugMota9jq1Eq1xjR2FMG+jA70A6iJXvut8dRIGEYrYx8ZR9hIFyqv16/SyC8A2AQBY4e+rN5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788268425; c=relaxed/simple;
	bh=qz0SaQk3SQ761T7x85SQqX6nS4lr/tPFoNL/yc11oWM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eqorraxPFaB6VFg7R5lAMmKDT/8XTdc3/CxR8a90eAJgK2ucM80N0cZl0Dneu6OxYFYTqAbWz8B0IqDj4DIh0qLARKYhkU428rpLHkmIl8axw8h2Qkb+AzNKoBXtLw+ha9TpWDx9sgcOv0J1ZHqb4jlZGx+Q58eSzQLCtx5fLt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANU2PVlR; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANU2PVlR"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-499b2981a7bso54894545e9.3
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 06:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788268422; x=1788873222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kXeoOvwBP+ldx/8gVLXWVNkzbohuXGpUFdUxHm5IJN4=;
        b=ANU2PVlR0xjDk10WJqeNzE4PntPV11Y7KQ0HLMFGfWM/M1zB/LaUktVc6FaEZ+UzpG
         knocl7ARmHJpXgtXBIipi5CzN7J/UDkspYvlOIMIHyHb+NStk1VqNNkK7NGjum1ey3BU
         JzpOuhTnUHrwtw+6doZCLKGlvZd/FY/63aWKo2XdoVKf4lOaIQl5Fk252dhg87vaP5f4
         PUSGRIme95qlQkrQNQfSSTy9ma8RiEsR58BZf5ZkyZFAgb6P48QJTuTiWm1UaEfaou1r
         f/Avv1DF2uSgRKvPxAV7fELdiw2nj6xrfrISO13N3xmN8uLe5ZPr1GSgpeasirqdaLPB
         6xiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788268422; x=1788873222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kXeoOvwBP+ldx/8gVLXWVNkzbohuXGpUFdUxHm5IJN4=;
        b=ZXYyxRCFMeSFa6UUdSa+R3/fNcGYxVbbRrhtmEwv4n/4+km9VXTI2jQSAQQQO27vur
         3r7NaAiDN0AsuhBycSj3eisn1FqF4LtIqX6lT71nOHoIehKR+kWBM/W0ttjNmaY0NMsz
         gajmLlu8LcbJUqFbXoNsw8SowscPpVRfUbNheL0YdfTF1VeqHI8kVjQU+4fXmIy+8AYB
         SdBpVdYdxZOW7mB3eg6s6ZjIcyPom6aQmDxumu7BT9nHqdxwLIt5/87t0EODo4TosYQY
         8V1i3jEihOLZRSGQXY+EanWSARwrNYATzczHnJNzY7MknRx1W1N732dQcEOv+l4Gz/9c
         nQpQ==
X-Gm-Message-State: AFuF++mnGBMx+apdh23E4Cgm8rPmxABQJHBeg6H9e8QCwU2spFxx0j2z
	dpx0qpxwGinEgZVI4FjGZHOp1CN8jeg3ci6KFv9sdStfH01qox7HPVAc3GdUIoT+
X-Gm-Gg: AR+sD11ROz7k0Q1YMT86FaIHtvRciOvZZaD2UXJCekQwTz2ExzG6K+PeDUm1Lw9hGD8
	sAmOpEfC21+LByPzIGHOCinRMiIkj01f20QIteQPK7Kuru9wPJApt+UNHWAdm8eyz0aDirLEYiV
	XSaS36quBJ3N6xq50+0p1v/BkDy3vYsQZZngPTmGXdIQyp5fCs6P3IkUz9J3gjdOOKEVuEZNJck
	ww38mJKHG2wCQ1bEsvZu+YPVnamleDirQQqjO+iu84yRG1isvwB8xRtH17QypoyqTJWNUr5SPTj
	D4ItfaYxEQ5SFI6+Jon8bYnpyrp28MP1/PLVE3x8h8evm5x6S9dtE6XSC1JqD4nbALgXWg+9Mqp
	3cMv+qYb7CukpDRshWGFHzoLkbORbozbYJh3RibcRoKSIATjB07D1iG1evs8G0YayGaJ9QIMG2p
	rLHjUWKmJkKEAtGKiats0XJKqoOveQH7U9C/+AI6G7tMLmvvYXILBEGOr10h0hjozOyyyiAhiOx
	MTOjOlHaB3ELuIGQ+/xvHH9A4m6kHA4hzxiFr0K8nbF9KuShJ39jQRHwYBN8SxzeqAFKtXqmes4
	qIVqon28Vi8xAyXjPE5NXlEwBEtAPNKqX+HkZuvcJAdX8xYXi9lZceBzp2zxuNhyRyJ4IbP9+D+
	TEFK4pg==
X-Received: by 2002:a05:600c:3f19:b0:498:943:ccc0 with SMTP id 5b1f17b1804b1-49cdc43d444mr166787295e9.6.1788268421259;
        Tue, 01 Sep 2026 06:13:41 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-a16a-7801-fd8c-4b37-36b4-e53a.310.pool.telefonica.de. [2a02:3100:a16a:7801:fd8c:4b37:36b4:e53a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48442d6eafesm4504719f8f.24.2026.09.01.06.13.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 01 Sep 2026 06:13:40 -0700 (PDT)
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
Subject: [PATCH 6.1.y] cgroup/cpuset: Fix misplaced DL migration reset
Date: Tue,  1 Sep 2026 15:13:35 +0200
Message-Id: <20260901131335.15553-1-kmehltretter@gmail.com>
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
cpuset_can_attach().  The 6.1.y backport instead placed that hunk at
cpuset_can_fork()'s similarly named out_unlock label, while removing
cpuset_can_attach()'s two existing targeted resets.

If cpuset_can_attach() fails after accounting a SCHED_DEADLINE task,
cgroup_migrate_execute() does not call cpuset_cancel_attach() for the
failing subsystem.  The temporary migration fields remain set, and a
later successful migration can consume the stale state and corrupt
deadline-task and pending-bandwidth accounting.

Move the reset to cpuset_can_attach()'s common error exit.  It is not
needed in cpuset_can_fork(), which never accumulates migration DL state.

Fixes: f8a8358832f3 ("cgroup/cpuset: Reset DL migration state on can_attach() failure")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Applies to Linux 6.1.186 and 6.1.187-rc1.

A controlled QEMU A/B on 6.1.186 forced an attach error after accounting a
real SCHED_DEADLINE task.  The affected kernel returned with
nr_migrate_dl_tasks=1 and sum_migrate_dl_bw=104857; both fields were zero
with this patch.

The equivalent 6.6.y correction is submitted separately.

 kernel/cgroup/cpuset.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 681b52f6aae5b..7123bb020a242 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2600,6 +2600,8 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	 */
 	cs->attach_in_progress++;
 out_unlock:
+	if (ret)
+		reset_migrate_dl_data(cs);
 	mutex_unlock(&cpuset_mutex);
 	return ret;
 }
@@ -3405,8 +3407,6 @@ static int cpuset_can_fork(struct task_struct *task, struct css_set *cset)
 	cs->attach_in_progress++;
 
 out_unlock:
-	if (ret)
-		reset_migrate_dl_data(cs);
 	mutex_unlock(&cpuset_mutex);
 	return ret;
 }
-- 
2.53.0
