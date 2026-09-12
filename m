Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C914BEE43
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 01:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789177426; cv=none; b=Fl+cjEJl6wt4AoXTlmexJ+s2jULpXGL8Tq/aN3xd0mAw12cUGG2GvuQ0vnk+AqCtaATsZAhDOZk2spOUlqr9vdpvnNtIwWrgqMAlje4FBHqsMI9p3w7JFunS1ortRobzVOxuQEYl+Oq/smk6/qEAAP3DvN87/MEJcy7K1Rho47U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789177426; c=relaxed/simple;
	bh=ADGreUnivR2m/8YiWfsIwEjpfav5ecLrinyhCL9skKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NDvpLhmzo7bbsXvMVsz59E749aXeAp/A9D5ZdZ2OgCk4iWElruqp4uQaud90q8TrVnsvBdFHKMkkL9kp5IJpvfNjvRzJ8iVF/lN5CaYZqEvs6LB78ymJ9+zxgZ3AFH+1L9uWSmV+mvL8piDtGW9JQF9qjRGmevXkwqSzWuTJ3SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BrdXAepi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrdXAepi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765F71F000FF;
	Sat, 12 Sep 2026 01:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789177425;
	bh=t4JELfo/kBbq8F6sLc/EM1zWdgPSE1Nj4ujwzpJY+n0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BrdXAepi/wAPQ8emt6UAixa/hwd//pmacKSyU/WTKXzNx4+/qNlD8lIVV+tPDOjsO
	 Yowrr++4FKWXJaGJGTDwI0NiKKE1VT9WW9xgenAAm5LFd3x3EczcXum3aHUcNtwGnW
	 8/3XZIDk0MCHPkWnPt+u3ztrCmLf0arq3h51XqkaF0NkgjrrnQVvxvqpYbntKyob9q
	 UOsTXARMs8l5PMSxvyZOXrR69Pyam9Xf5CsdnsvCnVMOpPZiDG+TZ1jX6vxtYq4xWS
	 ir81SVPgTFzEeHeRcimpTII0XxTqZfZ2MBcZ6XmYMH95NZ6+DzM6dZJmdIraN4/xaj
	 6T2DYJFbPmLeg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yangtao Li <frank.li@vivo.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/4] f2fs: convert to use sysfs_emit
Date: Fri, 11 Sep 2026 21:43:40 -0400
Message-ID: <20260912014343.1817848-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090930-appease-drainpipe-8027@gregkh>
References: <2026090930-appease-drainpipe-8027@gregkh>
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
index cb13d47725432..9e6f13e82dec3 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -302,19 +302,14 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
 
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

