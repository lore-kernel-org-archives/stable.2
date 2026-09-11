Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D25288B9
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 22:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164025; cv=none; b=lQQzQQvJm4CN6HgVOKc0Y7VpOclaI669YOXp6t/LKG1olg7gIhVc12rqAZ0JulGOiXkvEymOHbpYeRARZTefR0OQdYjtLDXapolBnWiRL2bon2BDCiPmyo1IrEtCxWWxZwAKAdOF1zPiOZ6m4BkzNpQ4O6XnFTAycFfmmJ8wOhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164025; c=relaxed/simple;
	bh=kj9VcDpBt+7HsqzNepH9xRIY2SQSiB3L9DcI2FULcVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p/62QKpi0KqVhZjXT9m6jSHXcTsdSEwPYy0YnXQ8yRtv2rtOk+57v2TM3FNofn4JhaW2AGwxara2Nkev8BIm7ezwMhlkGdbLEibP504MDLI6zq+B1snHWWifv0A/a4Nn7v1b0lT3cNKVAAT7xpbuHOnicEB80Cu0+MCTOH2hs9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eq3UO5EW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eq3UO5EW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A44B1F000FF;
	Fri, 11 Sep 2026 22:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789164023;
	bh=xViccjbs2bMRrQbVDcIty465AdrSmQqFvxrXr737kig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eq3UO5EWt77Bg1mhWH6a7WX9nDvnX+c8CMATt69GJ2NwIBlbsIUZ7kElc5lA6tZy+
	 tJOZT99bJBrxyN0c52lg6g2S49TyqZkfOXl/ZHbdOyV2/sLQ8koKGegCC6TlI12m00
	 Y3CZCqKIvSFGoks0gcqcizUMnitEOTLAMJAMi8NqR3ElvigDvWiNwUzYVtvnlHA2W6
	 idfOVqhTy+q+oZl0KD/35Q2qfjzZJNJY2/sr00XEMTroXSDgExF7cqc0ObrckFcVUB
	 +SxiSWs9knAD+tSE04Z6YHf4AQ0svstJQBdQBnWA1iz9QtEsRuoKYJjFinPKa3V+jk
	 lO0GQiLrXsRow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] f2fs: use new ioprio Macro to get ckpt thread ioprio level
Date: Fri, 11 Sep 2026 18:00:20 -0400
Message-ID: <20260911220021.1624116-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090930-parkway-apply-1c3d@gregkh>
References: <2026090930-parkway-apply-1c3d@gregkh>
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
index 4cd2d4bde217a..08d8d865f1306 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -339,13 +339,13 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
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
@@ -470,7 +470,7 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		const char *name = strim((char *)buf);
 		struct ckpt_req_control *cprc = &sbi->cprc_info;
 		int class;
-		long data;
+		long level;
 		int ret;
 
 		if (!strncmp(name, "rt,", 3))
@@ -481,13 +481,13 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
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

