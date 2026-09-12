Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD1133936C
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 01:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789177428; cv=none; b=FNH7gR0aqHFp4fG+gaU2gLLqT8MQIYQUPXne3fcxJukA71gjIBqaaw17Ho7GAYbmqNHtHZje8keWV1ZMqcvrIjMW6szsJlEuHtZVXO0ycin8NCbBAeDbl324wK/QTgCoYqEjUPidbnzQ+vBfG9GqE0Hw/rOYP0PgHvSFA9oX71k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789177428; c=relaxed/simple;
	bh=EXFC4EKFXEu7SpcKxvswgZ+CGqmmtsPl2YMnwlcgkSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sSyvAmcHgp3F8VG9cNKzWsKxR0f/IA9u413BGjhvAPA/H919ZBuFCJBtV2Hefca8UCs5H4OOB/srPWDSSSE00boUTuqe3sYD+OBZJ89QIhFelKuE1AAaHmr3KR0kPmDufL9c+5stNyFHrMi0fOkwmcR7ATIwDGqu3qLUJubTfqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YnO9zVZ9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YnO9zVZ9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460431F0089B;
	Sat, 12 Sep 2026 01:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789177426;
	bh=KwlMayCVKizp4COLtupv5aTy8t1a2M6rrZU1E4z6tIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YnO9zVZ9v24IA6Kzufhr+fhW4XOyIlluS/yV1ZYS8kdxjPQ4c1qkhISC0vK/xh/w2
	 keaPdJOKpZLw1/c2blMOCw4zJWXIbBnSAIqWSv8txk/nDnMvy8S6xGn2jJSfNyS0ZE
	 EMpRW8Tq/fxpCBGGuwg0o3zvuAmrOc8gLlulNdj03I7smsBlNNZosHYqLTiVQKyYyP
	 4xZwrTfKMM7/1Ht1+B6JQ+QwYtoSl8vTaxxoFCSr1qpnZpKAi3qMygJX+0o52p8u06
	 eOvJRzEm9+YGRwED0aGivxp+kUT+uqNInxe4gRmtyYcpaNkAaSJFu+XqodILHFuIUk
	 bCwQbdkrJGo8g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/4] f2fs: use new ioprio Macro to get ckpt thread ioprio level
Date: Fri, 11 Sep 2026 21:43:42 -0400
Message-ID: <20260912014343.1817848-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912014343.1817848-1-sashal@kernel.org>
References: <2026090930-appease-drainpipe-8027@gregkh>
 <20260912014343.1817848-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhiguo Niu <zhiguo.niu@unisoc.com>

[ Upstream commit 270b09313b4e16cdfd01d8371023a1661dd1112e ]

IOPRIO_PRIO_DATA in the new kernel version includes level and hint,
So Macro IOPRIO_PRIO_LEVEL is more accurate to get ckpt thread
ioprio data/level, and it is also consisten with the way setting
ckpt thread ioprio by IOPRIO_PRIO_VALUE(class, data/level).

Besides, change variable name from "data" to "level" for more readable.

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: 5cb33b00c8fb ("f2fs: avoid NULL checkpoint thread access in sysfs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/sysfs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 9e6f13e82dec3..cd969ba2eda57 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -303,13 +303,13 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
 	if (!strcmp(a->attr.name, "ckpt_thread_ioprio")) {
 		struct ckpt_req_control *cprc = &sbi->cprc_info;
 		int class = IOPRIO_PRIO_CLASS(cprc->ckpt_thread_ioprio);
-		int data = IOPRIO_PRIO_DATA(cprc->ckpt_thread_ioprio);
+		int level = IOPRIO_PRIO_LEVEL(cprc->ckpt_thread_ioprio);
 
 		if (class != IOPRIO_CLASS_RT && class != IOPRIO_CLASS_BE)
 			return -EINVAL;
 
 		return sysfs_emit(buf, "%s,%d\n",
-			class == IOPRIO_CLASS_RT ? "rt" : "be", data);
+			class == IOPRIO_CLASS_RT ? "rt" : "be", level);
 	}
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
@@ -409,7 +409,7 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		const char *name = strim((char *)buf);
 		struct ckpt_req_control *cprc = &sbi->cprc_info;
 		int class;
-		long data;
+		long level;
 		int ret;
 
 		if (!strncmp(name, "rt,", 3))
@@ -420,13 +420,13 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 			return -EINVAL;
 
 		name += 3;
-		ret = kstrtol(name, 10, &data);
+		ret = kstrtol(name, 10, &level);
 		if (ret)
 			return ret;
-		if (data >= IOPRIO_NR_LEVELS || data < 0)
+		if (level >= IOPRIO_NR_LEVELS || level < 0)
 			return -EINVAL;
 
-		cprc->ckpt_thread_ioprio = IOPRIO_PRIO_VALUE(class, data);
+		cprc->ckpt_thread_ioprio = IOPRIO_PRIO_VALUE(class, level);
 		if (test_opt(sbi, MERGE_CHECKPOINT)) {
 			ret = set_task_ioprio(cprc->f2fs_issue_ckpt,
 					cprc->ckpt_thread_ioprio);
-- 
2.53.0

