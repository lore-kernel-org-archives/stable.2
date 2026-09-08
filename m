Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC2D53CA6B
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788870042; cv=none; b=Lh43tXTIIRydk5ke6TDypsMQ5tiajYfLdcBDb7H06O6MNRv2depWG+Uo6Q25q8G8lHvtRJtEtuZoWvFKLq+rvGNVyhCj+GCEGU6FhyTNvkaZTXlqGn+6djGCZhMiYMRitJj7uTICVS1td/r8RbciYxUrOLu/ZjpzyHUWIc+gTj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788870042; c=relaxed/simple;
	bh=J09pF8lZTJnzJNFSpAGbPNsGYVDv1EqbGnfoLmEfGHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KvCJ043hzq8YGdGA53MEFrvvu28K071rJWHD/8nKbpTSJujsYtCAihUh9VJiP1LE/6g5QxltnHb1Y+yK4WLg1/x+fYKEiX+sFgU8mFGn+AOJy9I9rqj4N0e3yy2XdEooWkDtVgdy1Kwj4qyAk+S2ti8zxKOher9LTvJodLmf7dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE4A1F00ADB;
	Tue,  8 Sep 2026 12:20:34 +0000 (UTC)
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/5] entry: Remove unused syscall argument from syscall_trace_enter()
Date: Tue,  8 Sep 2026 08:20:29 -0400
Message-ID: <20260908122030.2052577-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908122030.2052577-1-sashal@kernel.org>
References: <2026090331-spouse-sprawl-968e@gregkh>
 <20260908122030.2052577-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jinjie Ruan <ruanjinjie@huawei.com>

[ Upstream commit 03150a9f84b328f5c724b8ed9ff8600c2d7e2d7b ]

The 'syscall' argument of syscall_trace_enter() is immediately overwritten
before any real use and serves only as a local variable, so drop the
parameter.

No functional change intended.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260128031934.3906955-2-ruanjinjie@huawei.com

[ sashal: Reduced backport -- upstream 03150a9f84b32 touches 2 file(s), this
  backport carries 1. Not backported here:
  kernel/entry/syscall-common.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 4a3591287fb7 ("entry: Fix seccomp bypass after ptrace with TSYNC")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/entry-common.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 0d5dc199ed8ca..0f672ee152dfc 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -53,10 +53,10 @@ bool syscall_user_dispatch(struct pt_regs *regs);
 long syscall_enter_audit(struct pt_regs *regs, long syscall,
 			 unsigned long work);
 
-static __always_inline long syscall_trace_enter(struct pt_regs *regs, long syscall,
+static __always_inline long syscall_trace_enter(struct pt_regs *regs,
 						unsigned long work)
 {
-	long ret = 0;
+	long syscall, ret = 0;
 
 	/*
 	 * Handle Syscall User Dispatch.  This must comes first, since
@@ -116,7 +116,7 @@ static __always_inline long syscall_enter_from_user_mode_work(struct pt_regs *re
 	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
 
 	if (work & SYSCALL_WORK_ENTER)
-		syscall = syscall_trace_enter(regs, syscall, work);
+		syscall = syscall_trace_enter(regs, work);
 
 	return syscall;
 }
-- 
2.53.0

