Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4F941A90B
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 09:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786528275; cv=none; b=T6cENEsgScoQeCRIGu4h3W5q/gdJJ3oW/d2fIVAoc+bRDNDnAFQr8QPijxvOh4jz2ou1QixJwJmxl0hhyZt/RbYvkc6ZsVjw0eDuBx/QF58A6iXBD0hVWLNbCzdB9y0RWMhcrt5uf3MG3oZAtijWuuDjexGAbhiIQIOOI5XJktE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786528275; c=relaxed/simple;
	bh=kZwu99JMi3vAvXICmOJGErusnFNSH4xDuANsWP3b02Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Co/3hTssZhS2Hsu+h6I0HpWAoat7YtU4dQejm7VcmbHWK4BV8ux1YJXKKTQUpjx5Fxi5yqYb6PElIJfFoDQmhY585whHBI2O5ubqqvufKoajDz8p65o3SQp8CFmVhq7RX7LKF70Nhwah3O35jzyNo6GiA/4jlfHGklHdgk19otE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRS8CYxC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRS8CYxC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2545C1F000E9;
	Wed, 12 Aug 2026 09:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786528273;
	bh=pyQln8/8ZOSYdSTN+Fm2Kk12xcK/qj17gRrM0OnQAWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZRS8CYxCYsAtrv8Q/TXiw0E/HWAA1B3OKnUFPayvB7+3uaW0MnBmjdn5nTRgv7wvE
	 f9pImfRcLugUpqQeF4a02WIitm2Z9bzqufePt4GO22DjAa7XSjNUz2A/E1jW5+A6yK
	 lwot1xP187VZfnxGAskbFq8qu2sSZ4SaL5B1ooHwBOOnIF7tqcNSZYEwWbLG/NuWz/
	 3uYQ8cEuYN6wNSCBgA3xWpVe1DMwlYI9UmfQ8fW3wk9HHy43a5paxBc+QlAEvQsK41
	 Sfk4Mn0sHxlo/aYnNk6OUAwczw7xNQpxkRcKuwItEoD99TWNQIPG/BqfvEjns0+KCq
	 8UNfVNm/e5JPQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Liem <liem16213@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Carlos Song <carlos.song@nxp.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] i2c: imx: Fix slave registration race and error handling
Date: Wed, 12 Aug 2026 05:51:11 -0400
Message-ID: <20260812095111.1575318-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080514-trimester-ultra-2ca2@gregkh>
References: <2026080514-trimester-ultra-2ca2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liem <liem16213@gmail.com>

[ Upstream commit d64ec362c369bbc33833f7936d5f3a706b0d5c45 ]

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
[ open-coded scoped_guard(spinlock_irqsave) into explicit spin_lock_irqsave/spin_unlock_irqrestore since 5.15 builds with -std=gnu89 ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-imx.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index fae674969628b..9badd5b773bd6 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -832,14 +832,12 @@ static void i2c_imx_slave_init(struct imx_i2c_struct *i2c_imx)
 static int i2c_imx_reg_slave(struct i2c_client *client)
 {
 	struct imx_i2c_struct *i2c_imx = i2c_get_adapdata(client->adapter);
+	unsigned long flags;
 	int ret;
 
 	if (i2c_imx->slave)
 		return -EBUSY;
 
-	i2c_imx->slave = client;
-	i2c_imx->last_slave_event = I2C_SLAVE_STOP;
-
 	/* Resume */
 	ret = pm_runtime_resume_and_get(i2c_imx->adapter.dev.parent);
 	if (ret < 0) {
@@ -847,6 +845,11 @@ static int i2c_imx_reg_slave(struct i2c_client *client)
 		return ret;
 	}
 
+	spin_lock_irqsave(&i2c_imx->slave_lock, flags);
+	i2c_imx->slave = client;
+	i2c_imx->last_slave_event = I2C_SLAVE_STOP;
+	spin_unlock_irqrestore(&i2c_imx->slave_lock, flags);
+
 	i2c_imx_slave_init(i2c_imx);
 
 	return 0;
-- 
2.53.0

