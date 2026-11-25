Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795601579;
	b=J+jRwjM4a5IWsCM/XelcR18xxgQ5KuQHn5yFyFNdwYnra8CR+qHLO4Ctprlr5L86IXEA
	 QgQRt3BuoOmTIvHw9l1QYCj4b8Tk2LBmEyPYXHrI1mauaCktqjyjuYQvz/cc+2DoE6gpU
	 HJw2ExwVFufjoSFoUJmy2rUU1veM1htqWHIiyjqI2mvx02XtlWcuO8TMLTEhDRBQ+ZNGQ
	 GooOl0BMhZ2nDuvlyQrYIqz5/003jrgDqXBDgd5XPs/jqumNoB+VHHV7JQlxD+EDNwgxW
	 RbrF6qdmWh0bzgPfcwway/e2a/3YRPwidmOAxVh/Tni375JJHkIoSDhC0ZQK58DouUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795601579;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=pBSM8PBS1YwqQMa/qE12G/p2NX9Kthg8Y+WyICaJlFo=;
	b=il+t4Jtse8afNV1m3y1I2vKvpBBT1/udl53ntWGpVSIXfLAb7av5jqoHtElmiyRPsBC2
	 W43TYor+NLYjCQxvwNFaIDypIyK9hgINZF/06WW5AmRalMUWB8BzVeQVLgMzBtgO1sTzL
	 ItI+7uc9w0mxFlVguDJFPRTof2HW22ktEJ6rf6CT+hVqs5Um0F10efdkOGSR3eek1OXxv
	 nbrvojXGO04HKjOT2NmUSQrddzDEAaaM6Qb5ipIPyTN+z71YgDtNZNUc0CLuKmQ6V5pri
	 KfObcTayvhmZFk9reJe9BVzYrpGRQc/ddTOkYKJ5lHWP0nBuQkIR04cJSZ/yO40fymA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Dl1KtyO6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9424F606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Dl1KtyO6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86001F000C4;
	Wed, 25 Nov 2026 10:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795601579;
	bh=pBSM8PBS1YwqQMa/qE12G/p2NX9Kthg8Y+WyICaJlFo=;
	h=Subject:To:Cc:From:Date;
	b=Dl1KtyO6JYLXjDaGHsx64BnSD9cSwv9UfyQrx9iNGsTAk+h3znByULl4xYqKTv+DP
	 SCcb9XBkkLncWlAVc3i1nZxVzn2IIhLD6UNwvvucu0+GaTVCYs0X0ezdfTCsxeIPh8
	 MaCrRryIVRyPDb/CoVbwPTwxvhe7szhbhkYharo4=
Subject: FAILED: patch "[PATCH] arm64: suspend: Only track cpuidle context for idle tasks" failed to apply to 6.12-stable tree
To: uladzislau.zhauniarovich@gmail.com,catalin.marinas@arm.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:08:40 +0100
Message-ID: <2026112540-presoak-impromptu-e705@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x ad3fc05c7e65009355effeea06aa629a687acef2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112540-presoak-impromptu-e705@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ad3fc05c7e65009355effeea06aa629a687acef2 Mon Sep 17 00:00:00 2001
From: Uladzislau Zhauniarovich <uladzislau.zhauniarovich@gmail.com>
Date: Thu, 5 Nov 2026 20:19:45 +0000
Subject: [PATCH] arm64: suspend: Only track cpuidle context for idle tasks

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

diff --git a/arch/arm64/kernel/suspend.c b/arch/arm64/kernel/suspend.c
index c41724a40b75..cde0b8c19377 100644
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
 

