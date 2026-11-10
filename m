Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272616;
	b=pgy0GcatKNxTtSxb0klX2/rah1lDJCebgZ0VqpQI8JFrgWQ2nxnG5/OkCpXbAoo3l6U0
	 5ATSh6alOMA15uLRjZMMhoe6PPNU9/q4KMws7r9TAUg2u7kCBtrEY2OyiG25IwkmmfoGX
	 E+sF1X6tDCVbNEiLq74nmjKbMce994811woMbeKdDFu+tp+xRV8px9wMx8+CaEWYdZC67
	 tzBmVrZ8N+f+7ZmA0lzPdob2alAPFG2r32LpVZBa9og3ud7qSN7z8Pyfor8DvRqQKzEFL
	 D+W9IR3YmzERln2ATNa7gYDw/SfQGyZ98IbhM8mtk4ZLa5A38QoqwFQmKa2sbFL8DKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272616;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=gJZ0jXn3GJnQkCmkPlTUw8Gn+9yTe6sdlIZuvaw+b88=;
	b=MX/k71d1E31Cud+Tul03kewMnvZAuqYvH8bZdlF5RrVMsYDcomIiwRko5eHrLUnwE09d
	 GcIBlQpK3FP5XVdzS89SZu/ebkDzxzKyVNr+eX5XL8cZmdxCPvjT+UBKQKqVvJr4+zOlj
	 2K6eIp1DiApw1CzHQmxpV3I/XtQYfm8rCjzJLhsVQWPFmf+rIz3NmKC6gWtMyreX6eGgN
	 Dbhh8uQi9pib2oPAmfw30KYICS478uhK2VT+l1QdAOth5CxmUOOgTv3veMyHfwdETSSRg
	 ET1IgNaHkN0+X4df618Q8dUtByeGCggY9jvlVjg82JMJQVMJv89d9IIgyYhIxSUzAXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hc8qHswf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B84A606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hc8qHswf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B60341F0089F;
	Tue, 10 Nov 2026 01:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272616;
	bh=gJZ0jXn3GJnQkCmkPlTUw8Gn+9yTe6sdlIZuvaw+b88=;
	h=From:To:Cc:Subject:Date;
	b=Hc8qHswfFY0cGz+PaEeLvWzrfz2R6YS8ruoCVKc0twHC9LzJYTyu//N1BcxMS9E55
	 L9/RXaaA8hWWN3f0FaoTVRe3MuobVEGeeC9OLbjPrTNwDuHVo/2NDGVWYMrv+D2Dc/
	 AbvC6wFVWdofidn6D5pHxy/m0PQRU/6C0I0YN82MEKAcfpWmaz6j0TId0gzdPBPFSF
	 F1Vwt8HexSPM8LsMoQryXdeXd3I+bmsGDfofCUgwySlekUGdBp91k2cCGGLqcMj9JV
	 0QBNS1hsHN16HMxHxfKH2f5nIWcfJnSZNUWy70944w57GYk0eYd/Y5UVm6l16Nr8zr
	 DJwuzSHbcNdqQ==
From: Sasha Levin <sashal@kernel.org>
To: javier.carrasco.cruz@gmail.com,
	linux@roeck-us.net
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] hwmon: chipcap2: synchronize ready IRQ state" failed to apply to 6.18-stable tree
Date: Mon,  9 Nov 2026 20:03:34 -0500
Message-ID: <20261109200334-failed-6.18-8c02722be2ca@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 8c02722be2caa6604a837b81faeaba78250eda4a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200334-failed-6.18-8c02722be2ca@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 8c02722be2caa6604a837b81faeaba78250eda4a Mon Sep 17 00:00:00 2001
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 14 Oct 2026 19:34:10 +0200
Subject: [PATCH] hwmon: chipcap2: synchronize ready IRQ state

The ready IRQ handler can race with reinit_completion() in the enable
path. In particular, a handler from an earlier operation can complete
the completion after it is reset for a new operation.

Use irq_lock to serialize access to the completion and process_irqs.
Disable IRQ processing and synchronize any running handler before resetting
the completion for a new operation.

Fixes: 3af350929e75 ("hwmon: Add support for Amphenol ChipCap 2")
Cc: stable@vger.kernel.org
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Link: https://patch.msgid.link/20261014-chipcap2_locks-v3-11-27ebfc2c5b9e@gmail.com
[groeck: Dropped obsolete 'Assisted-by: tag]
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/chipcap2.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/chipcap2.c b/drivers/hwmon/chipcap2.c
index b3b725cc7224f..00f62a33d4637 100644
--- a/drivers/hwmon/chipcap2.c
+++ b/drivers/hwmon/chipcap2.c
@@ -123,6 +123,16 @@ static int cc2_enable(struct cc2_data *data)
 {
 	int ret;
 
+	if (data->irq_ready > 0) {
+		scoped_guard(mutex, &data->irq_lock)
+			data->process_irqs = false;
+
+		synchronize_irq(data->irq_ready);
+
+		scoped_guard(mutex, &data->irq_lock)
+			reinit_completion(&data->complete);
+	}
+
 	/* exclusive regulator, check in case a disable failed */
 	if (data->regulator_enabled) {
 		scoped_guard(mutex, &data->irq_lock)
@@ -130,9 +140,6 @@ static int cc2_enable(struct cc2_data *data)
 		return 0;
 	}
 
-	/* clear any pending completion */
-	try_wait_for_completion(&data->complete);
-
 	ret = regulator_enable(data->regulator);
 	if (ret < 0)
 		return ret;
@@ -162,6 +169,9 @@ static void cc2_disable(struct cc2_data *data)
 	scoped_guard(mutex, &data->irq_lock)
 		data->process_irqs = false;
 
+	if (data->irq_ready > 0)
+		synchronize_irq(data->irq_ready);
+
 	/* exclusive regulator, check in case an enable failed */
 	if (!data->regulator_enabled)
 		return;
@@ -510,8 +520,10 @@ static irqreturn_t cc2_ready_interrupt(int irq, void *data)
 {
 	struct cc2_data *cc2 = data;
 
-	if (cc2->process_irqs)
-		complete(&cc2->complete);
+	scoped_guard(mutex, &cc2->irq_lock) {
+		if (cc2->process_irqs)
+			complete(&cc2->complete);
+	}
 
 	return IRQ_HANDLED;
 }
-- 
2.53.0




