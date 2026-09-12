Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988BD33689D
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 01:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789176734; cv=none; b=dj/To0MaBj/Ydgv8gjmSwBryYmskg3NE1AOluXj7Eip0ilu6EGpMlBIg9U+nL1qNXplCNk4TAm/JtuvSnbpKO+BpD8ndxylIwxptpCPZLid1BoRJFKTR4w1cLpVsSwS2mrIEZrw45APngAFyqWP0EM7YX09GHOFeeo7WXCvhAkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789176734; c=relaxed/simple;
	bh=qE4ouGFsEQ8eMKjaa8jYMiVy5+YLNR+zA3Zncxa6tAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O498kIjXxiT+8E9wzZJp93m8ht5e1wAb+Sh1S2UQtEAzRMIwR1RGAzP+VTdsTMSJyidG5lUGM8hhhGYwGugWud/8x7ejK2xCfWrzrZfVHK6866EvD8i82vfG1FijuDtBdvH4BpPN8Ym6OuWXt9gyJ0AJvm167r1bJT1DzA6DXZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8u8WQol; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8u8WQol"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C738F1F000FF;
	Sat, 12 Sep 2026 01:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789176733;
	bh=Vg0hcIU3UT+5YDF2ZvZ2tsc47XywEWTCDesBuEtOgVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B8u8WQolBY/Itu5GX4XstssLJ0sVTPId33XwTlH9PF4hzrco+eWWwUEkUVV5ciag2
	 BwIkMVpnzA7RJ6S5bAJeLNHeo1OTUMeLmzo4Z6jtD99rmMgYAit+QApY+gdUsDy+J+
	 xDxMJDY2P1Jt0GpvgeZSl190uMliBGNhN9n632ty+I33Iiv48L5bWALTccYA+pL/ky
	 ASf0yfv5TjQZzMG0IWenCh0vK5x/HkOZaFi4c8riTwXYUPAG+r+98BC6RSzQ6LXhuZ
	 W9lil9+fgud3WvzWLEMt0NhuLgyNc6K1TGKjipN81vWvpiThDiln2VDbQ0xkxVCpzo
	 5UROIDGgOIPtA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yangtao Li <frank.li@vivo.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/4] f2fs: convert to use sysfs_emit
Date: Fri, 11 Sep 2026 21:32:08 -0400
Message-ID: <20260912013211.1760018-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090930-ricotta-unpledged-5906@gregkh>
References: <2026090930-ricotta-unpledged-5906@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yangtao Li <frank.li@vivo.com>

[ Upstream commit 084e15ea14bbb1ad40163438cfa74a76a1521c16 ]

Let's use sysfs_emit.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: 5cb33b00c8fb ("f2fs: avoid NULL checkpoint thread access in sysfs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/sysfs.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 503a50542ac53..75e9f3166b1b7 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -326,19 +326,14 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
 
 	if (!strcmp(a->attr.name, "ckpt_thread_ioprio")) {
 		struct ckpt_req_control *cprc = &sbi->cprc_info;
-		int len = 0;
 		int class = IOPRIO_PRIO_CLASS(cprc->ckpt_thread_ioprio);
 		int data = IOPRIO_PRIO_DATA(cprc->ckpt_thread_ioprio);
 
-		if (class == IOPRIO_CLASS_RT)
-			len += scnprintf(buf + len, PAGE_SIZE - len, "rt,");
-		else if (class == IOPRIO_CLASS_BE)
-			len += scnprintf(buf + len, PAGE_SIZE - len, "be,");
-		else
+		if (class != IOPRIO_CLASS_RT && class != IOPRIO_CLASS_BE)
 			return -EINVAL;
 
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%d\n", data);
-		return len;
+		return sysfs_emit(buf, "%s,%d\n",
+			class == IOPRIO_CLASS_RT ? "rt" : "be", data);
 	}
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
-- 
2.53.0

