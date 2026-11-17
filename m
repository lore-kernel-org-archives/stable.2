Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794937714;
	b=xGVBqM2dWMqOROlcC8Qjw1nF5ps0ek70cGPhYridUu2DM+0if8+fPyHh8lVcG41I4EDY
	 4jUagq7TESf29t9fm8naSvDSsXcO5RXI1jPc7DOPug5wi/w/wkzYlZWAYMZMICA5jPb6x
	 9PBAoSixr+qDgzEN7EswofIggOZ8s1qVUBvMPPIy20mWyeBCj0eMaR9QAGPxtL8tgZnGT
	 I836w1a671ys4ds405jHyNR+RgBjMyFsoNJ1CynzpWguPx2YP8HUyXwDrmY9lm3XAKzpq
	 cd7ve6b4ek3s7inMn57kf5LyCys+/5dCqTooa2JIaNssOPIVmIyEiLP98krC0mjzPaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794937714;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IM4foyJ0RX5Ci1v11jEYSe5L3PTEKXroDVN0F6QK9y0=;
	b=g2QnZhEGnDJ81DZyKhHnJEgwva/B5voFPVj2JqiqaTDaTKX6EF6XZhFt+AcIiX0p50lM
	 a9IMN4AOQAj30f1agePvASSsu1P0iexQdzf4E/LE5piht89jmkt+k02/kACwhayLfBbRs
	 LOJKaeHyzNzGcT1ZiuFoqIxVmliqSw1Lh6lCS8UqhpaHRHK+YxokkhkSAv0v/b+BVtqI9
	 dR4+NqyLPSdJI1JcGgHHMzTBY8Mtxhen3mi22dhMVTb1h3JbLrXzCnBAqzEX3LFJLfIOg
	 Ro9haqDJB0w02/VZYyeXyl7dAZgi23zYMuihT8I7ZWRSWbd8Onyq38PuKxsz36wqBOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=W80ozK6q;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77CC606A331;
	Tue, 17 Nov 2026 17:48:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B77CC606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=W80ozK6q
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D83E1BF3;
	Tue, 17 Nov 2026 09:48:30 -0800 (PST)
Received: from e137867.cambridge.arm.com (unknown [10.2.213.11])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6208C3F632;
	Tue, 17 Nov 2026 09:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794937713; bh=m6Izyk+wSH9EmsRBLf1kAV+ngPwW2rElHVDya5kr/XU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W80ozK6qH8+2siXD/pkKOHzm8JeX3dgkeyd6HpFs8zzRkcYPCRICTWQYLpmZcqIXx
	 uAI6FFz4gOt/HbZLJj0KQURCWfNvn8YrOKwPnowgxGDUdAS0ik5dwWih8HGV5ICeqo
	 UUsE3LE1XtF5pwLenxOtQVKDPMqh6pc/0wYnF8HE=
From: Ada Couprie Diaz <ada.coupriediaz@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Cc: Vladimir Murzin <vladimir.murzin@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Kiryl Shutsemau <kas@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Doug Anderson <dianders@chromium.org>,
	Linus Walleij <linusw@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Huth <thuth@redhat.com>,
	Dawei Li <dawei.li@linux.dev>,
	mrigendrachaubey <mrigendra.chaubey@gmail.com>,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/3] arm64: head: set __entry_task along with task setup
Date: Tue, 17 Nov 2026 17:48:14 +0000
Message-ID: <20261117174814.95936-4-ada.coupriediaz@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117174814.95936-1-ada.coupriediaz@arm.com>
References: <20261117174814.95936-1-ada.coupriediaz@arm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`__entry_task` is only set after the first `switch_to()`, despite
a proper task being set up in SP_EL0 as soon as CPUs go through
`__{primary,secondary}_switched()`.

As SDEI can interrupt execution at any time, it can interrupt before
the first `switch_to()` and use a null `__entry_task` to set
its current task.

Set `__entry_task` as soon as we have a proper task set up in
`init_cpu_task()` in case we get interrupted before switching threads.

Remove the second paragraph of the comment on `__entry_task`, as it has
been incorrect since the introduction of SDEI, and even more so
with this change.

Fixes: f5df26961853 ("arm64: kernel: Add arch-specific SDEI entry code and CPU masking")
Cc: stable@vger.kernel.org
Signed-off-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
---
 arch/arm64/kernel/head.S    | 3 +++
 arch/arm64/kernel/process.c | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index d6ba3c0af811..e53a9c6fec83 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -209,6 +209,9 @@ SYM_CODE_END(preserve_boot_args)
 	ldr	w\tmp2, [\tsk, #TSK_TI_CPU]
 	ldr	\tmp1, [\tmp1, \tmp2, lsl #3]
 	set_this_cpu_offset \tmp1
+
+	adr_l	\tmp2, __entry_task
+	str	\tsk, [\tmp2, \tmp1]
 	.endm
 
 /*
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 42b15b0c069f..c3d194676efc 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -584,9 +584,6 @@ static void ssbs_thread_switch(struct task_struct *next)
 /*
  * We store our current task in sp_el0, which is clobbered by userspace. Keep a
  * shadow copy so that we can restore this upon entry from userspace.
- *
- * This is *only* for exception entry from EL0, and is not valid until we
- * __switch_to() a user task.
  */
 DEFINE_PER_CPU(struct task_struct *, __entry_task);
 
-- 
2.43.0

