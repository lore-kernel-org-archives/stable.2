Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050212;
	b=2M4sw6NPzySFs/BHOzHozy2VEEufn2IiQqzoBk/KJ0LxQnbN3YdA8UBKoTG+XABbPaNS
	 df85+hZNLCPsAEqpX7bXCBHNFynDio+zeZasc0JmOEJv1Pj/yQvgl4Z9FYVJZFXYsPPvd
	 FUK0veeyUPCUNp89c+QdiXSEMlwxU0AZStNlSQGkwwdnK7qUYwWXsalhUXARi2VZX7r5+
	 jPa6S7R/W9UYd2rxYbguBUf8hNt0/6LXnc5b3zjZFyZAuon+OsgEneAEE50gkGHpV+SO2
	 KDB+C6HeWvfxHBcCyFqNu0vAygY54wzp1psOxZtu4iWskmglb3e3PitGRTdGlPcoHwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050212;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=1YgW7hoKGWNizxc1QA6MwT0ljR+mg4X+RaKV5LhUhjU=;
	b=LRsR3Xj+4EnJOgpRPvvPjkn2UQCdHE2Ozrp0sB5TnSlvE3S8inwL6wCXSZtvg1Gi2T92
	 mxukEhdfxxqSxegLfL/26sLP1Jz6fbxDx/EqPZ5WoMMMsouTLOEIOKUxGAK5uEkssGKcR
	 HU757eyOVRn69pIsNxSuiXMHeldgEaRL7JHGd0mZvimBNislPwzXTHjaM/tpRbEb2sXO9
	 t9pICob+7BxZJx/FkOHd9vdmGUYXrml0g8dnMF7aZoLARM3N81vJUEawJXcqI1DwZIxpK
	 bTKp7C6DkQnP1rsWo/o0xM0m0LThLrBQWADuU9wJKiyQ6dUO2nOx8gLJ3dKFYxxMPRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pi92xreW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150B2606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pi92xreW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E291F0089F;
	Sat,  7 Nov 2026 11:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050211;
	bh=1YgW7hoKGWNizxc1QA6MwT0ljR+mg4X+RaKV5LhUhjU=;
	h=From:To:Cc:Subject:Date;
	b=Pi92xreWRDZs9tyUWrxmSWuD7gqMmPLMXySTauvkQ2XU/joSuZhoAgE3n22XrU8pF
	 iMm019HRB8TVCw3hwA8j4iF5KIGD0X6pTOOv8BJDvX9+PGoVOdaromFyw5e+yfSJLb
	 g9BPe6cV8KzxN04gJY8HZpWX8xcPWop+jJPpjUIgr0VhEeCrkS3i/8K4ntgja1GURm
	 +CwNI4wH5tLK7iey7PnLT7DLph8sUgF8aDxqj0LWOIPuuSCvzxnZIyWxKxUTyZGiae
	 7t2n0wzkkSipF0826yp1sbmK+bNH28nEFqjZZQ1XWStRfYJQgikr5eCQy3nu8p66oo
	 4D8FToIkt9mmA==
From: Sasha Levin <sashal@kernel.org>
To: getshell@seu.edu.cn,
	lee@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mfd: da903x: Cancel IRQ work during teardown" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:16:50 -0500
Message-ID: <20261107061649-failed-5.10-fd2258999ecd@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x fd2258999ecdc7164ef0cda2d4102e4558a5660f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061649-failed-5.10-fd2258999ecd@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From fd2258999ecdc7164ef0cda2d4102e4558a5660f Mon Sep 17 00:00:00 2001
From: Hongyan Xu <getshell@seu.edu.cn>
Date: Fri, 14 Aug 2026 23:30:19 +0800
Subject: [PATCH] mfd: da903x: Cancel IRQ work during teardown

The IRQ handler disables the IRQ and schedules irq_work. Releasing the
IRQ does not drain that work, which can continue to use the devm-allocated
chip and notifier state.

Manage both IRQ-work cancellation and subdevice removal with devres.
Register the subdevice-removal action before requesting the IRQ, then add
the IRQ-work action after the request. This avoids leaving a live IRQ
without work cancellation if action registration fails. Devres cleanup
then disables the IRQ and drains the work before releasing the IRQ and
removing child devices. Register both actions before creating the children
so partial probe failures use the same ordering.

This issue was found by the author's in-house static analysis tool.
The patch was reviewed by the author against the latest mainline tree.

Fixes: 26b8f5e1e2d1 ("mfd: add base support for Dialog DA9030/DA9034 PMICs")
Cc: stable@vger.kernel.org
Suggested-by: Lee Jones <lee@kernel.org>
Assisted-by: Codex:GPT-5
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
Link: https://patch.msgid.link/20260814153019.1114-1-getshell@seu.edu.cn
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/mfd/da903x.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/da903x.c b/drivers/mfd/da903x.c
index e86b39de3303a..e4ad48e1f139b 100644
--- a/drivers/mfd/da903x.c
+++ b/drivers/mfd/da903x.c
@@ -421,6 +421,14 @@ static irqreturn_t da903x_irq_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static void da903x_cancel_irq_work(void *data)
+{
+	struct da903x_chip *chip = data;
+
+	disable_irq(chip->client->irq);
+	cancel_work_sync(&chip->irq_work);
+}
+
 static const struct da903x_chip_ops da903x_ops[] = {
 	[0] = {
 		.init_chip	= da9030_init_chip,
@@ -456,6 +464,13 @@ static int da903x_remove_subdevs(struct da903x_chip *chip)
 	return device_for_each_child(chip->dev, NULL, __remove_subdev);
 }
 
+static void da903x_remove_subdevs_action(void *data)
+{
+	struct da903x_chip *chip = data;
+
+	da903x_remove_subdevs(chip);
+}
+
 static int da903x_add_subdevs(struct da903x_chip *chip,
 					struct da903x_platform_data *pdata)
 {
@@ -484,7 +499,6 @@ static int da903x_add_subdevs(struct da903x_chip *chip,
 	return 0;
 
 failed:
-	da903x_remove_subdevs(chip);
 	return ret;
 }
 
@@ -520,6 +534,11 @@ static int da903x_probe(struct i2c_client *client)
 	chip->ops->mask_events(chip, chip->events_mask);
 	chip->ops->read_events(chip, &tmp);
 
+	ret = devm_add_action_or_reset(&client->dev,
+				       da903x_remove_subdevs_action, chip);
+	if (ret)
+		return ret;
+
 	ret = devm_request_irq(&client->dev, client->irq, da903x_irq_handler,
 			IRQF_TRIGGER_FALLING,
 			"da903x", chip);
@@ -529,14 +548,12 @@ static int da903x_probe(struct i2c_client *client)
 		return ret;
 	}
 
-	return da903x_add_subdevs(chip, pdata);
-}
-
-static void da903x_remove(struct i2c_client *client)
-{
-	struct da903x_chip *chip = i2c_get_clientdata(client);
+	ret = devm_add_action_or_reset(&client->dev, da903x_cancel_irq_work,
+				       chip);
+	if (ret)
+		return ret;
 
-	da903x_remove_subdevs(chip);
+	return da903x_add_subdevs(chip, pdata);
 }
 
 static struct i2c_driver da903x_driver = {
@@ -544,7 +561,6 @@ static struct i2c_driver da903x_driver = {
 		.name	= "da903x",
 	},
 	.probe		= da903x_probe,
-	.remove		= da903x_remove,
 	.id_table	= da903x_id_table,
 };
 
-- 
2.53.0




