Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F417239CCF7
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 22:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164026; cv=none; b=riad8QNQcYJrVaYWuR/5GQUrPnp4a8zNoXsegwNAUO0vvAfNIIphg/fjwetr5mOTesx6xD93WyvyQTqK/vkTPgQN1MUXtPCpdbySgWvPje1ihQ4BjT5ze+R98KcfgPl0jGlCMwmv3m63AAM6MbZvZh7QXr+CMQtTHDS4tyc5D5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164026; c=relaxed/simple;
	bh=siXkXwSSTgxMVR32CS6+Qkt2olM+Tg2OZdp3UNGtGgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hL04mbeaZWvjx50OMxSeWyRpS3mkHZ0sHUTv1N0Ple0tI351XS5V+98hCpBuu1DbUgkqkPlPOzT8Ux46u3lyhil3rVGo7F2cMiOC8B4HoDVGgtQ5S+5Lns1jm063X+xKXa4Y26N6qlTvBcTQca/eEjFTVfY/X8WOXeXuVI4C2s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=immOpQrW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="immOpQrW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF371F00893;
	Fri, 11 Sep 2026 22:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789164024;
	bh=qlUlAMPm2AF6DHAfNAdvXa8r1+vKl8zJZtsUJzH9gDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=immOpQrWjPonuCfbj+WjRSbGdGr1fUVnkrY3NSLWegRAMM0SLmLDezl8C/46kcJQV
	 FSMU8nBWoI2FOS/wNOE+CJu41j5493dUj/Fov33jvcZab1ukUI8wSbIeEZQ9ecXN52
	 nAsglUsil1b8F/0aC+fe70b2V2JGjiWw4P/FgtmVbgU0VEMETup9sPs4y0wQwDPFx8
	 iNEgoMEr/rYwzcmuUS/bY5KBCnR8mj0pJatvGXALeXyDs9LcCCPoAD3ivPNVUBZxIS
	 4S5mv5aKOwdPIP9DXxp+16TWN26SRnZOwPylhHsjNwfmpiqKTVlqu4lV3ufdCqA7L6
	 AWcpBaLZ6tK7g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wenjie Qi <qwjhust@gmail.com>,
	stable@kernel.org,
	Wenjie Qi <qiwenjie@xiaomi.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] f2fs: avoid NULL checkpoint thread access in sysfs
Date: Fri, 11 Sep 2026 18:00:21 -0400
Message-ID: <20260911220021.1624116-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911220021.1624116-1-sashal@kernel.org>
References: <2026090930-parkway-apply-1c3d@gregkh>
 <20260911220021.1624116-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wenjie Qi <qwjhust@gmail.com>

[ Upstream commit 5cb33b00c8fbb6e8f1fa3d281c3036d5f7c7c41f ]

checkpoint_merge can be enabled even when no checkpoint merge thread is
running. A read-only mount is one case: f2fs does not start
f2fs_issue_ckpt there, but ckpt_thread_ioprio is still writable through
sysfs.

The ckpt_thread_ioprio store path updates the saved ioprio value and,
when checkpoint_merge is enabled, calls set_task_ioprio() for the
checkpoint thread. If cprc->f2fs_issue_ckpt is NULL, that dereferences a
NULL task pointer.

Protect ckpt_thread_ioprio sysfs writes with s_umount as well, so the
checkpoint thread cannot disappear under the store path while updating
its ioprio.

Fixes: e65920661708 ("f2fs: add ckpt_thread_ioprio sysfs node")
Cc: stable@kernel.org
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/sysfs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 08d8d865f1306..743471d46c07e 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -488,7 +488,7 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 			return -EINVAL;
 
 		cprc->ckpt_thread_ioprio = IOPRIO_PRIO_VALUE(class, level);
-		if (test_opt(sbi, MERGE_CHECKPOINT)) {
+		if (cprc->f2fs_issue_ckpt) {
 			ret = set_task_ioprio(cprc->f2fs_issue_ckpt,
 					cprc->ckpt_thread_ioprio);
 			if (ret)
@@ -799,13 +799,14 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
 	ssize_t ret;
 	bool gc_entry = (!strcmp(a->attr.name, "gc_urgent") ||
 					a->struct_type == GC_THREAD);
+	bool thread_entry = !strcmp(a->attr.name, "ckpt_thread_ioprio");
 
-	if (gc_entry) {
+	if (gc_entry || thread_entry) {
 		if (!down_read_trylock(&sbi->sb->s_umount))
 			return -EAGAIN;
 	}
 	ret = __sbi_store(a, sbi, buf, count);
-	if (gc_entry)
+	if (gc_entry || thread_entry)
 		up_read(&sbi->sb->s_umount);
 
 	return ret;
-- 
2.53.0

