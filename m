Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795454175;
	b=J1VugTiPYMhBeQ/N69+EdBbefd8gFGuKCK3qMNsAYeQL6YBaUD7CmGnbIa/nPJS2AsOm
	 LgoUdMpRn354oo1XBAW0NWp1WfbqEY4RDzDw5goFz49wthR3IIphn6mOkJjHq8YbEkZZ7
	 jdwnVNyTDyu5CM4+281mzj5a+IWZ0gwtHP+xIj4fymi9BeyNiDys5g9M+OOXfQIya4xpP
	 HQ3pDT3EW+V4QChSvZ+eoyqAcGA3SC27Ek8WPYro2G5qn99udr6d0kgeKAP38lo8PBXdq
	 QE7XQJSNIBX2UEQtMlAC3gbyoR8pGdMBtNRZGrafQcnn2jhR0/aadrehFcNVjD+ymJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795454175;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dnt2GtHzfP5h866vP0cRtDl18L844ZAZum/+U48ESm4=;
	b=5mf2R64b034Kc24Egdkxwtd4fbuAiyehUWuB4YhPCCtCCTGnRXduJVvP1BXbJW5TQV/N
	 dVRbytXpuVQP9Oy5BMRW3+DrALeM3Tl70AQxV5gjXCOyAC2AvGnm+9eVZJmPiavSDxpOP
	 10bR4KXgRoLfXfC/X60OLu6ZOWkW3I1qBrQiwvVm3BLYg6+cibGA1v9ROraW/IakX35kW
	 F0V9IoCnC8U+2mTBNOE+o86smoULr/AG+LkX/I0UvIPd8HQBDiXh0gnn9CjC6utczISHt
	 /CI2y7sTJOny5YTEZDKXVAj7dCLsBX+n4C+l9/jXe0kf9UpFGENO62cQGMgzjOPlPKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=vcQIYCkg;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE30F606A33B;
	Mon, 23 Nov 2026 17:16:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE30F606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=vcQIYCkg
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4743819F6;
	Mon, 23 Nov 2026 09:16:11 -0800 (PST)
Received: from e137867.cambridge.arm.com (unknown [10.2.213.11])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7BABE3F86F;
	Mon, 23 Nov 2026 09:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795454174; bh=OKpA5BGzsnvMNkmETrY5EVQga+MEy2xQO6CCLFEttso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vcQIYCkgDxusqCN8hgHN6yqNXMxn0KtyUYXFr9Ob2sXYdpscTr0HybhfuF9sLu8Ud
	 xboVdIOA0RmuwR2vaBmLJhWHvAKapg8h2SebzWv5T9hlr3b6kBl5e1huSjIlk5J2cB
	 PZTKbUaPV9G2rs6z1CqSFFbJ70652hCWDw8+JYOQ=
From: Ada Couprie Diaz <ada.coupriediaz@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	James Morse <james.morse@arm.com>,
	Usama Arif <usama.arif@linux.dev>,
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
Subject: [PATCH v3 3/3] arm64: head: set __entry_task along with task setup
Date: Mon, 23 Nov 2026 17:15:57 +0000
Message-ID: <20261123171557.140944-4-ada.coupriediaz@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261123171557.140944-1-ada.coupriediaz@arm.com>
References: <20261123171557.140944-1-ada.coupriediaz@arm.com>
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
the first `switch_to()`[0] and use a NULL `__entry_task`
to set its current task.

Set `__entry_task` as soon as we have a proper task set up in
`init_cpu_task()` in case we get interrupted before switching threads.

Remove the second paragraph of the comment on `__entry_task`, as it has
been incorrect since the introduction of SDEI, and even more so
with this change.

[0]: This can only happen on secondary CPUs first brought online after
     initial boot :
     - all CPUs onlined at boot-time switch at least once
       before drivers are probed ;
     - hotplugged CPUs that booted once still have their `__entry_task`
       in memory, so it would not be NULL.

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

