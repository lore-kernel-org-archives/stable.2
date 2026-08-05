Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCFC44C64F
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 11:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931139; cv=none; b=amDwEZ/+zzp5LoBS8A1keaYTy3/1WlPnRv7oKhnfo0yFLJq8fRoJjn6LMaBaTjWdItsJZ8NqfU/jvf3b2oimSkYKT2VyBA3vFkAXA3/Q4uOXfdKIMf2Cd3GpH92MAd2Sh1T4GJo5tZcclvQIp9ZxS8DI7cCGnHAKzN7F4RP892w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931139; c=relaxed/simple;
	bh=kxoUmnFWKV8XwYHTDJlLSnsb6CzRz3GYVrmN727Ho24=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZF66RqgGkMNmAKfEM0NqPjfIbgnJtDSgLBAvigefI9LlqaR+Opr9M+U0WZuZ/EYj8NgvD0YFWDy5UvCrx15eR6jN5gOV//EYjacTIgmfgA7ls5EdD7GIt6sBZMwzx5o963Jv03dLVF+ABx5U7kw3zGZ8dk7c8C1muJJjZ61RvRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ekh9p1Et; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ekh9p1Et"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D652D1F000E9;
	Wed,  5 Aug 2026 11:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785931137;
	bh=Qf6Ft3axsqrUq1kTDa9af+7KiwyKtbdaAPefUxh/QrM=;
	h=Subject:To:Cc:From:Date;
	b=ekh9p1EtxxSjKtqKq/o7FqkkRjTbAsavMfL/5ydknMrzMxoUiXvBkk8IACSrnf7bI
	 fMPqsbHTX2J+cEpX0NjViFaLfDXlMg35NDp+FENNDx+mH4bSnXakcaN1cAhQnfQjjM
	 X9PueIpJQ6KVfC/IkHR6gnixADtE9hfEWSSzK9bw=
Subject: FAILED: patch "[PATCH] i2c: imx: Fix slave registration race and error handling" failed to apply to 5.15-stable tree
To: liem16213@gmail.com,Frank.Li@nxp.com,andi.shyti@kernel.org,carlos.song@nxp.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 13:52:14 +0200
Message-ID: <2026080514-trimester-ultra-2ca2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x d64ec362c369bbc33833f7936d5f3a706b0d5c45
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080514-trimester-ultra-2ca2@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d64ec362c369bbc33833f7936d5f3a706b0d5c45 Mon Sep 17 00:00:00 2001
From: Liem <liem16213@gmail.com>
Date: Mon, 29 Jun 2026 10:38:28 +0800
Subject: [PATCH] i2c: imx: Fix slave registration race and error handling

In i2c_imx_reg_slave(), the slave pointer was assigned before
pm_runtime_resume_and_get().  If pm_runtime_resume_and_get() failed,
the error path returned without clearing i2c_imx->slave, leaving it
non-NULL and causing all subsequent registration attempts to fail
with -EBUSY.

Additionally, because this driver uses a shared IRQ, the interrupt
handler i2c_imx_isr() can execute concurrently and, after acquiring
slave_lock, dereference i2c_imx->slave.  The previous fix attempt
added a lockless i2c_imx->slave = NULL on the error path, but that
could race with the ISR under the lock and still cause a NULL pointer
dereference.

Fix both issues by deferring the assignment of i2c_imx->slave and
i2c_imx->last_slave_event to after a successful resume, and by
performing the assignment inside the slave_lock critical section.
This guarantees that the slave pointer is never left stale on the
error path and is always valid when observed by the interrupt handler.

Fixes: f7414cd6923f ("i2c: imx: support slave mode for imx I2C driver")
Signed-off-by: Liem <liem16213@gmail.com>
Cc: <stable@vger.kernel.org> # v5.11+
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Carlos Song <carlos.song@nxp.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://lore.kernel.org/r/20260629023829.152651-2-liem16213@gmail.com

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index d549d630b41a..49859ee494c6 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -930,9 +930,6 @@ static int i2c_imx_reg_slave(struct i2c_client *client)
 	if (i2c_imx->slave)
 		return -EBUSY;
 
-	i2c_imx->slave = client;
-	i2c_imx->last_slave_event = I2C_SLAVE_STOP;
-
 	/* Resume */
 	ret = pm_runtime_resume_and_get(i2c_imx->adapter.dev.parent);
 	if (ret < 0) {
@@ -940,6 +937,11 @@ static int i2c_imx_reg_slave(struct i2c_client *client)
 		return ret;
 	}
 
+	scoped_guard(spinlock_irqsave, &i2c_imx->slave_lock) {
+		i2c_imx->slave = client;
+		i2c_imx->last_slave_event = I2C_SLAVE_STOP;
+	}
+
 	i2c_imx_slave_init(i2c_imx);
 
 	return 0;

