Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A9B2D9EDC
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 01:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788830585; cv=none; b=YEEbQWJppzYRIKVBnqyBSA0sTGfJ+OasNiOs0A8TA3tS0UORbv8PVTmYsyUKxGZX3vZnFQgvkjm2Mz7nJios/3FoLCu7YzyBG+U1ZEqCEXGnFKAa++9uBJkg5nORF/sWZTuvD4LGT+Q2eDPCk+4ZdFMOUsiN910V34TWfBHYNCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788830585; c=relaxed/simple;
	bh=PSMp80JByIzCOk5k3ZNFx38GXy+JW8tvZPcLK4t8VaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jja1qpD38ZCfP18SpjIkbWhoIy8BfIRTRPjBnnspgw4u8e7qTpgl7QVugxvFLZ9UGBXmlgpZbX7c565WZX+n5esqQeg9FRXjYOAKO5eKLIKiH/cP9ZjO2xqD0R9q8yACHoGekiG//pcOme7EDACopCiLQ7q0dViyYD5ABeUuqnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0dms3FT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0dms3FT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17AE91F00ADB;
	Tue,  8 Sep 2026 01:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788830576;
	bh=zOqjPCoCqQxfolSJ0qyXt5nvs7JXhd1izelqWzcZUdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b0dms3FTn7a+WnZH1QYB0mxLAnXFW86TavOb+fFFtq+Lrl9WkLdL0I2d0oyeEGtj7
	 kqPXBId/au7wwiE0+toWWh0PBohrVNNpXceTasOgz4cb6PFr52a8pVkAbC7BnqXBeD
	 fBAGhSi8WZbIPZA2VWCwn+SWcSAOPL8QjtoaTwhCaZhhDSbDP3f3Ltpq42DhI8Jmq5
	 0J5muKMvamV5KqUbLNASzoV4txdkWd7qKhbGp0KVsaXMAEXEeVk7tCHlwE4DHmBZ1Q
	 KZml9Ty3nQxoX0UyLX0emchYq3MQgI9Luu9bp1LR1wL/bERl0o7g9nf/pxzcYyD1Jz
	 7KhcCQsmWeKpw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 5/5] entry: Fix seccomp bypass after ptrace with TSYNC
Date: Mon,  7 Sep 2026 21:22:50 -0400
Message-ID: <20260908012250.1760990-5-sashal@kernel.org>
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

[ Upstream commit 4a3591287fb7f808e209b4974ed337f609a2006b ]

Sashiko review pointed out the following issue.

If a thread is stopped in syscall_trace_enter() for ptrace, another
thread can install a seccomp filter with SECCOMP_FILTER_FLAG_TSYNC
(e.g., via seccomp_attach_filter()). This will successfully set
SYSCALL_WORK_SECCOMP on the stopped thread, but syscall_trace_enter()
evaluates a cached 'work' variable sampled on entry. Consequently,
the subsequent check for SYSCALL_WORK_SECCOMP misses the newly
assigned flag, and the filter is silently bypassed.

This race condition could allow an unprivileged process to execute
a prohibited system call (e.g., execve) that the newly installed filter
was intended to block, especially since the tracer might have modified
the system call number during the ptrace stop.

Fix this by re-reading the syscall_work flags after ptrace handling,
so that any new SYSCALL_WORK_SECCOMP flag set by another thread via
TSYNC during the ptrace stop is observed before the subsequent
seccomp check.

Fixes: 142781e108b1 ("entry: Provide generic syscall entry functionality")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20260629132914.1135C1F000E9@smtp.kernel.org/
Link: https://patch.msgid.link/20260713025712.416366-1-ruanjinjie@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/entry-common.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index add81461b3200..a2ee413c4450f 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -74,6 +74,9 @@ static __always_inline long syscall_trace_enter(struct pt_regs *regs,
 		if (!arch_ptrace_report_syscall_permit_entry(regs) ||
 		    (work & SYSCALL_WORK_SYSCALL_EMU))
 			return -1L;
+
+		/* ptrace might have changed work flags */
+		work = READ_ONCE(current_thread_info()->syscall_work);
 	}
 
 	/* Do seccomp after ptrace, to catch any tracer changes. */
-- 
2.53.0

