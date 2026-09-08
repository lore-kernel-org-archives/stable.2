Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20DA55C1D4
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 13:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788874640; cv=none; b=qCFebeYpZJ97pKLmdCC7iFnmzfW4sT2c6ZquBbxJ89UWGJgRhxVf6xvzSbYnkLnuBZuo55rlXdrwy93oGc/4cv3ZsVQmBKIWm2JgrMJ5o1mfEZHEdLD2k7jUSE2uZiA2KYsJYbUXPUrKmsz8TDGNtP1mZqFJy+m7x1KvqsZHrnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788874640; c=relaxed/simple;
	bh=Wj2ql/fK1o1LSzhzZysgS8GGykk7dlgKMi2IWyPEfIg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RlXe+xcNRQjt0f7eGaPWCLmoTOt1c7Dl3CqhHxUZ1FxIuIgss0wyCQB8GoJpMct85Bbgt3P3CHhP+lzQaMgRUPyTrDa2FbR0O1vydkhF4zHkq7ckdSrQIc+f0SWEpurLUB76WDblYVq/u14RgKNNx9Exx4q6sGQVsuChHjxfFYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xVc5s+HQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xVc5s+HQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FDAC1F00A3D;
	Tue,  8 Sep 2026 13:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788874629;
	bh=NOrCKoZe7XibdBWcUVc7MoOWQwb5GbdtXzIvlFjhXiU=;
	h=Subject:To:Cc:From:Date;
	b=xVc5s+HQ3YF9WhtWR13h907OMhP4HIyWZOQtXDat5rxTOugUTzF8KO507wOm5sXDM
	 7R27wnxH6s4iNia5W9ucdcGRGoQukRkR8f1VsdAW+bcfPF931123tKyRB3ACJ98gOo
	 EEB3/rqQoKHJQ8VS2fIrXYmXsgXXkLDW63wAyvGg=
Subject: FAILED: patch "[PATCH] irqchip/stm32mp-exti: Fix the unit of the hwspinlock timeout" failed to apply to 6.1-stable tree
To: junan76@163.com,antonio.borneo@foss.st.com,radu@rendec.net,tglx@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2026 15:31:13 +0200
Message-ID: <2026090813-staff-splicing-7337@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x d31fbbade43f880b7e59e2b3a72722fe2725d93f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090813-staff-splicing-7337@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d31fbbade43f880b7e59e2b3a72722fe2725d93f Mon Sep 17 00:00:00 2001
From: Ju Nan <junan76@163.com>
Date: Fri, 21 Aug 2026 10:47:57 +0800
Subject: [PATCH] irqchip/stm32mp-exti: Fix the unit of the hwspinlock timeout

HWSPNLCK_TIMEOUT is passed to hwspin_lock_timeout_in_atomic(), whose
timeout argument is in milliseconds, not microseconds:

  atomic_delay += HWSPINLOCK_RETRY_DELAY_US;
  if (atomic_delay > to * 1000)
          return -ETIMEDOUT;

So stm32mp_exti_set_type() asks for a 1 second timeout where the comment
next to the macro says it wants 1 millisecond. The semaphore is polled
with udelay() from a section that holds chip_data->rlock, a
raw_spinlock_t, so preemption stays disabled for the whole wait on every
configuration, PREEMPT_RT included.

The hwspinlock core documents this explicitly:

  If the mode is HWLOCK_IN_ATOMIC (called from an atomic context) the
  timeout is handled with busy-waiting delays, hence shall not exceed
  few msecs.

Fixes: 5257169ade8c ("irqchip/stm32-exti: Use the hwspin_lock_timeout_in_atomic() API")
Signed-off-by: Ju Nan <junan76@163.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Radu Rendec <radu@rendec.net>
Reviewed-by: Antonio Borneo <antonio.borneo@foss.st.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260821024756.24927-2-junan76@163.com

diff --git a/drivers/irqchip/irq-stm32mp-exti.c b/drivers/irqchip/irq-stm32mp-exti.c
index bf3a2def69ca..a19e91fbd010 100644
--- a/drivers/irqchip/irq-stm32mp-exti.c
+++ b/drivers/irqchip/irq-stm32mp-exti.c
@@ -22,7 +22,7 @@
 
 #define IRQS_PER_BANK			32
 
-#define HWSPNLCK_TIMEOUT		1000 /* usec */
+#define HWSPNLCK_TIMEOUT_MS		1
 
 #define EXTI_EnCIDCFGR(n)		(0x180 + (n) * 4)
 #define EXTI_HWCFGR1			0x3f0
@@ -376,7 +376,7 @@ static int stm32mp_exti_set_type(struct irq_data *d, unsigned int type)
 	raw_spin_lock(&chip_data->rlock);
 
 	if (hwlock) {
-		err = hwspin_lock_timeout_in_atomic(hwlock, HWSPNLCK_TIMEOUT);
+		err = hwspin_lock_timeout_in_atomic(hwlock, HWSPNLCK_TIMEOUT_MS);
 		if (err) {
 			pr_err("%s can't get hwspinlock (%d)\n", __func__, err);
 			goto unlock;

