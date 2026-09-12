Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DC7331ED5
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 01:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789176736; cv=none; b=LSvUQ7O7N2beHM08MV9hMU9OebYPtKp94Rr6EXQHLH0AGyjNaGmKsFWiJVaKZcd6ATotq7BaOWKqNfGneDzu1HMsjuV2SLMrNuk27rrDSjx6jMrhMKZtP/IWc0XQjUXP2nX0qw/llMWgNDz6+IJNMIQwut39wrhqTat39c5AAE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789176736; c=relaxed/simple;
	bh=tDztb2aWRRrnNrNsiuwy3YXhaoiek/qp1/+lTRzkbEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o4vsbu5KzRY9Yd0jamytcr5SSzwIi6KMNUnyqSq0Nl63oUbxHxA7QObd5HzCBj7EvIi7aqZ5PUiOatgYq3geSkpUzktuBt64RLmQglLdZXCvofYgQIdd2+2kvNMtMdt8Qf085YY4RtqqUOcdMqdojDxG5+ofuLryI0QchAkUnMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1zr0dzf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1zr0dzf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45951F00898;
	Sat, 12 Sep 2026 01:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789176735;
	bh=vNbyiRPgPpGnY3m3mN5+9Nk4KWo05S2ZSkB+d8mguSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e1zr0dzfFLfoMl3rUo7kajXgX/N7I9yz0Arwax3kCLb89ZucPWqeLvHMrwEcL+TbO
	 i3gvvZNjZKdE+QL7Mu459w2CsLx3c2wbyQ4dQPx6cATLc0YAVUwrqiCswklZ7suePv
	 XR5BxwimBARcZq4a4Ak2/50T4LSppe1cknnL3UiJ8K771lhyrFUKx2RdEXh4DWBuDP
	 ElRcr+2e6AoFxIHsxL22sfjzNpiCKQhkWayciiXvAvmQld7Vaaqec0RUivChjRIA+Q
	 hpp/STkPejChGVvzfEiVb+U9noXKxkoEQVRqs7qVfrTrIiET0thSIJD9hFZKO37VJZ
	 vULo+wySUgocw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/4] f2fs: use new ioprio Macro to get ckpt thread ioprio level
Date: Fri, 11 Sep 2026 21:32:10 -0400
Message-ID: <20260912013211.1760018-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912013211.1760018-1-sashal@kernel.org>
References: <2026090930-ricotta-unpledged-5906@gregkh>
 <20260912013211.1760018-1-sashal@kernel.org>
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
index 75e9f3166b1b7..a83e17636c054 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -327,13 +327,13 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
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
@@ -453,7 +453,7 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		const char *name = strim((char *)buf);
 		struct ckpt_req_control *cprc = &sbi->cprc_info;
 		int class;
-		long data;
+		long level;
 		int ret;
 
 		if (!strncmp(name, "rt,", 3))
@@ -464,13 +464,13 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
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

