Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B501B29E0E5
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 01:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788830585; cv=none; b=BZ3PRTy0Z6fm/1LrAIU2OdaMONbbA5Y9GG4ohm0ksGxyldEWdDhqYj3WO7vHl5BqeY5aX2CwVFeV9sIkDA1+dkG5y+6bqGufFxVXNcN23CwKCZHlHoSf+NvjWy6Bce7Q8EIjYRvM3dYwHXWYkd9/WsV45XaB3tNrBjwC7kWSiLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788830585; c=relaxed/simple;
	bh=acRLuZ2zEzZQdzjf/NFQQVLQtyknwORNdH34qZvw99M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e8ZC8c+8pTZv613paKfGMioGSTYAhfXHapWkSvnqpFqAMzTOY9gEMfwmKO+q1+ys5csADuMjibvnsJ7ffIkesDKuPwUDSk17QLiK0MUCbP4cNNWi/D0ONZL1qGL/i8toRTgHmi/KORBJCMzKrz46pm8IBd4OQURaPZE9kQILjl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9WTq3jQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9WTq3jQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 560991F00A3F;
	Tue,  8 Sep 2026 01:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788830575;
	bh=/J0DNbMfcuawzRo8IEq+8fg3FaJNp+jQc6kh6GLRgAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K9WTq3jQ+FYwO0ClXxTuCcnYH8Oi/Ye/kH3LLapwlu49ZmhlZX1VQINdOSf6vbGME
	 6XaMlTDTPG3hF+UqTJZQvMcUENBrtY+oFRtw95LWfiFkdNEWgwnbGKv3eX0he0uSuC
	 yRhSscpYMqzzKNaPWrzETMNoNB7RY8AkMqBRluFG/BnMLfxR19Rdb96mb+OHB/7pBA
	 T/Fh4wp7Zv10WhvPbahZbj0Dvxi9UgVCk6ormoNB/VjUktTqtOm5b4dHV4s8/pGL6l
	 ma+q/DFkXiPswYv9zo4UMegtrjzZW175qrMnkNu/9G/oWuZGDJLRW/gkT7TJhJzOJD
	 UA7FaVGMO01iQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/5] entry: Remove unused syscall argument from syscall_trace_enter()
Date: Mon,  7 Sep 2026 21:22:49 -0400
Message-ID: <20260908012250.1760990-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908012250.1760990-1-sashal@kernel.org>
References: <2026090330-squeak-freehand-d54a@gregkh>
 <20260908012250.1760990-1-sashal@kernel.org>
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
index 7f05293bf8ee1..add81461b3200 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -54,10 +54,10 @@ bool syscall_user_dispatch(struct pt_regs *regs);
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
@@ -117,7 +117,7 @@ static __always_inline long syscall_enter_from_user_mode_work(struct pt_regs *re
 	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
 
 	if (work & SYSCALL_WORK_ENTER)
-		syscall = syscall_trace_enter(regs, syscall, work);
+		syscall = syscall_trace_enter(regs, work);
 
 	return syscall;
 }
-- 
2.53.0

