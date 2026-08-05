Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7C541BA80
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 11:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785930284; cv=none; b=j1l9gLWmB37oVHp9Wq8DIdMj9N59eZRJoGB06B7tLy2HQysryH6hLs5hRnTc1sdyDqG1EUrN2kaXtqahJe6lEC6TzZLLMsLYf1BEpE6bOokoPxtBmVWmdpB3/mcjKj0ZRMwCdXnV/rassV4Ys737b/qvoGNbeW25tSplhu3zRZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785930284; c=relaxed/simple;
	bh=VDmoLM47MPNDWVFBPhUMOBKyjC7RQBHFwsMDQ7sgWd8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GJkX/o4LpW34bP10kzrcwDrkMmBOOTmUtjGP4I461Zrx2MChhql4wbe8TrQFUvtRN8jnxzDRYoKYDLoOhHVEAKwQ+xyQLECvvuDJeIpEo7Ic1UpGylzmFLG0NQ6s4BoBrN0G9xM9L7oA0Q9YdjIhSdoisyY9sg2qs8m4tlhARjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=reKYIOOS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="reKYIOOS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166641F000E9;
	Wed,  5 Aug 2026 11:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785930283;
	bh=xbgqScMAH00KggDxMm9XH98E7tS+U+QpU+v9p5sEq9s=;
	h=Subject:To:Cc:From:Date;
	b=reKYIOOShyOBb8FbmTvyezXXTCRLmgFbq79ID51LEl1YfUAMj4/Dr5R3UgauEX5hB
	 qw17Cviw3jWmOgEKXlfHK5/Ud72SfVOQTyAUrnQbIgNogNP772r6dwAEbag7M/cW1/
	 zpFUVKR/G1k5V2mBiiGpe18kLdLmNfx7NM1VS48U=
Subject: FAILED: patch "[PATCH] i2c: imx: Fix slave registration race and error handling" failed to apply to 5.10-stable tree
To: liem16213@gmail.com,Frank.Li@nxp.com,andi.shyti@kernel.org,carlos.song@nxp.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 13:44:26 +0200
Message-ID: <2026080526-crazed-dislodge-8584@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x d64ec362c369bbc33833f7936d5f3a706b0d5c45
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080526-crazed-dislodge-8584@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

