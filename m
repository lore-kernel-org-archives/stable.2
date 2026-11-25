Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795623318;
	b=KZhaM9yg+c2v1Vv6mnthNwJ3XWJoQQWvSwvcBnbKJtnzDAq5CFoqHca9wpm5PTGEc+oV
	 EQmPLpT89M4KbmqSXdTj48ONH9L4bJsHxIzDhMZrAFvDbpTLyAa9m56MsICsTAZQi8rv7
	 OAUQAo8t0a2EsofXcR3+yJPK65Iavy+g49RcPQsr92vDjgfTvcZNMWYXNPW+TyYRpQnTW
	 OmRSKXAz7Vuw3XlecodZGHClE3Z49co+ENHU+UqaE2IauOd+IKVicy3V25pK9SuaowJxb
	 uTPkh/VvPoOH3isjCybMOVCQ6ADNk9Ix1qc7WrdBH8EjmTuOkyLUEkWV0XDLwbo+lwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795623318;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=056qI/r9e0s9dnvBfMf5urWn7OVhcz8M35R9OuheLUY=;
	b=vndSXdmPFWLPL5YvwdlRn/QHYlz9trNx8/fo3EfBZmGs9DS25yUUDUeoCq6u6pnRIlc6
	 n4qYSWbVKGsC13s3ZdF+Soiu0u4SF2XTrhsam5xKmf77yP6oxTuvpGule0RAFsW6TQgjE
	 063/NIguEkD6BTMz6zvkTC0qWIRrG9kxCB+Ls0rDA37y8ys1tFvHknRcCPbAkAJAX0shG
	 iKvAtffhaIRukqFLk65tBDNTZlLOUH26c7DrpHlOkWJCLqr+uLh6sjDturB+kvNrcw/z5
	 X5U4OKfgHUfTQe8v5qsUZM2pvWArwFQO8fTuKjBj/qLGMKh7b0htyk8t5MuskLopTvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nryidrp0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39434606A335
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nryidrp0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D32261F00A01;
	Wed, 25 Nov 2026 16:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795623317;
	bh=056qI/r9e0s9dnvBfMf5urWn7OVhcz8M35R9OuheLUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nryidrp0Iqd1+HemyfL+RQoBL6iQs0eYKSVog6zPjlUW/Rs1O/zgBwFZXAqKD7Xvr
	 1PsRC6nEVN7NORdWcdstJPGd9qaiag+IR74uIviFe8RbTLGuoT8rdi0LWbRImOBV5d
	 eEAL66p6ziKdCprPcvUh3vp5M+Kfv6iro5r55dwqoFaICkVyb7vCp5YUF8EsdJVSNf
	 K4FLdn5W7B/vX4KKkbkNErB2qgHv6nwcNUNvV3qMUjxj/ch07wHKvopB+X2I/LxORX
	 uPZ6/lk/2erhtaV26uZfyUa+lneiiD4Q3ZkDAYpfTZKLylw4aYEojuor5YX2LIjUBi
	 8TO9hN6fy1Kiw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Uladzislau Zhauniarovich <uladzislau.zhauniarovich@gmail.com>,
	syzbot+79883955da3a62652a80@syzkaller.appspotmail.com,
	Catalin Marinas <catalin.marinas@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] arm64: suspend: Only track cpuidle context for idle tasks
Date: Wed, 25 Nov 2026 11:15:13 -0500
Message-ID: <20261125161506.729393-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125161506.729393-1-sashal@kernel.org>
References: <2026112539-amenity-spinster-254c@gregkh>
 <20261125161506.729393-1-sashal@kernel.org>
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

From: Uladzislau Zhauniarovich <uladzislau.zhauniarovich@gmail.com>

[ Upstream commit ad3fc05c7e65009355effeea06aa629a687acef2 ]

Commit 19235e472798 ("cpuidle, arm64: Fix the ARM64 cpuidle logic") moved
the calls to ct_cpuidle_enter() and ct_cpuidle_exit() into cpu_suspend() so
that arm64 cpuidle could keep RCU watching longer and manage context
tracking internally. However, cpu_suspend() is called not only by cpuidle
via psci_cpu_suspend_enter() (which runs in the context of the idle task),
but also during system suspend via psci_system_suspend_enter() (which runs
in the context of the task initiating suspend, such as a process writing to
/sys/power/state).

When entering system suspend, current is a non-idle task. Calling
ct_cpuidle_enter() invokes ct_kernel_exit() from kernel space (!user) on a
non-idle task. With CONFIG_RCU_EQS_DEBUG enabled, this violates context
tracking invariants and triggers a warning:

WARNING: kernel/context_tracking.c:120 at ct_kernel_exit+0x1b4/0x1f4
kernel/context_tracking.c:118
Call trace:
 ct_kernel_exit+0x1b4/0x1f4 kernel/context_tracking.c:118
 ct_idle_enter+0x20/0x34 kernel/context_tracking.c:299
 ct_cpuidle_enter include/linux/cpuidle.h:134 [inline]
 cpu_suspend+0x264/0x474 arch/arm64/kernel/suspend.c:136
 psci_system_suspend_enter+0x4c/0x80 drivers/firmware/psci/psci.c:544
 suspend_enter kernel/power/suspend.c:468 [inline]
 suspend_devices_and_enter+0x88c/0xd0c kernel/power/suspend.c:533
 enter_state kernel/power/suspend.c:618 [inline]
 pm_suspend+0x498/0x698 kernel/power/suspend.c:644
 state_store+0x14c/0x1fc kernel/power/main.c:819
 kobj_attr_store+0x6c/0x90 lib/kobject.c:842
 sysfs_kf_write+0xe0/0x108 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x260/0x3b8 fs/kernfs/file.c:345
 vfs_write+0x51c/0xa0c fs/read_write.c:687
 ksys_write+0x12c/0x228 fs/read_write.c:739

A corresponding warning is subsequently triggered in ct_kernel_enter() via
ct_cpuidle_exit() upon resume.

Fix this by checking is_idle_task(current) in cpu_suspend() and only
invoking ct_cpuidle_enter() and ct_cpuidle_exit() when executing in the
context of an idle task.

Fixes: 19235e472798 ("cpuidle, arm64: Fix the ARM64 cpuidle logic")
Cc: <stable@vger.kernel.org>
Assisted-by: Gemini:gemini-3.8-flash Gemini:gemini-3.1-pro-preview syzbot
Reported-by: syzbot+79883955da3a62652a80@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=79883955da3a62652a80
Link: https://syzkaller.appspot.com/ai_job?id=5359e16f-013b-4850-9cbc-ddfb3bac95e5
Signed-off-by: Uladzislau Zhauniarovich <uladzislau.zhauniarovich@gmail.com>
Tested-by: Uladzislau Zhauniarovich <uladzislau.zhauniarovich@gmail.com>
Link: https://lore.kernel.org/r/3e92ccb0-2952-4317-af4c-45457c15efae@gmail.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/suspend.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/suspend.c b/arch/arm64/kernel/suspend.c
index c41724a40b756..cde0b8c19377e 100644
--- a/arch/arm64/kernel/suspend.c
+++ b/arch/arm64/kernel/suspend.c
@@ -5,6 +5,7 @@
 #include <linux/uaccess.h>
 #include <linux/pgtable.h>
 #include <linux/cpuidle.h>
+#include <linux/sched.h>
 #include <asm/alternative.h>
 #include <asm/cacheflush.h>
 #include <asm/cpufeature.h>
@@ -99,6 +100,7 @@ int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
 	int ret = 0;
 	unsigned long flags;
 	struct sleep_stack_data state;
+	bool idle = is_idle_task(current);
 
 	/*
 	 * Some portions of CPU state (e.g. PSTATE.{PAN,DIT}) are initialized
@@ -133,7 +135,8 @@ int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
 	 */
 	pause_graph_tracing();
 
-	ct_cpuidle_enter();
+	if (idle)
+		ct_cpuidle_enter();
 
 	if (__cpu_suspend_enter(&state)) {
 		/* Call the suspend finisher */
@@ -149,9 +152,11 @@ int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
 		if (!ret)
 			ret = -EOPNOTSUPP;
 
-		ct_cpuidle_exit();
+		if (idle)
+			ct_cpuidle_exit();
 	} else {
-		ct_cpuidle_exit();
+		if (idle)
+			ct_cpuidle_exit();
 		__cpu_suspend_exit();
 	}
 
-- 
2.53.0

