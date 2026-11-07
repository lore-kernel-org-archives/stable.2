Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047387;
	b=xBzlJwlGwKLSwpZQcXn5aAqmPzFUEox7Cu2FKHj5QMpKNjYQdt7qGcZfV99YLZ9cNx2i
	 E3+9NcejwDZ50Ej3Vmf3LhUCjAQseaXvRPxgSERylxbCuXEToiTpL22klv0bXOHxVg2zx
	 eQAlDEe3ILcB4usSjaBtFLbhNtWb/HSY3me/DbgeSbLIgYCVMWElOOEv1uLDh5LBm8q8y
	 z65s8Z8jNMnORYxRZgwuWJK5MVEKd+HgXMfjt/aGXkzsjtrCPM9kWGSGRD9B3O4dHkn0E
	 Oe0l3w0QRwT7ojYUWsSX5G7vQn+eImk/7LB4mEjzKYFNX8d6JkZz8OPE/9fW62/+RaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047387;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=IOHjplqxoB94FJ+vsF8612bpUVm0gsnIFMF31Ec4vOQ=;
	b=EiX3LqA/AXh7I63sWsfcNQzXNuAAlVF9AMZDzMBUI6EsF5jMLI/aDFGs7Pv1Omf8llfK
	 N9cmgWPdCBnR6Hk3JBQyZEfCQKuSLXSDjE/otK49hiS3Xvsw48PY7ll6jC5Q9smZTeQky
	 bfr6NIsPtanh0WI+eaHQvO9FmttN/V9FyuFSqZ+kWHZt6TYnhzx2UHN9WuJipTmVxu+wi
	 G+ooqpwjvFK5kO9PeyRWxse58vki2csw0EUIJRmrPiuYo3Kd8iIDijefm4mOvKhgiQIwC
	 6Xq0gWf2gCUgSK2wdeYRodaXGxuF4HrrvOwIsBZ3y35r9KyTN1b6QdbE/lca5+6K3wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GXicXmD7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5AB606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GXicXmD7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80461F0089F;
	Sat,  7 Nov 2026 10:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047387;
	bh=IOHjplqxoB94FJ+vsF8612bpUVm0gsnIFMF31Ec4vOQ=;
	h=From:To:Cc:Subject:Date;
	b=GXicXmD7K2l4y0eo292LkoomwgzRkCRji4+anGrbcymlVUxwvX9smDDFliwREWcPa
	 Bf41zKcVVf7LkPUwpESXxvdvE6QKFGGM33sKwFT6boJFkX4i+XeBfVeVKG7TzkLH5Y
	 89XyPQRpmXKTRle+kbZyj/dPjerHNseLdniVGTMY+boBrDFh6onsjUAd/X3yWLNSqN
	 JKASjuUC2RIyRGwqjkj1QBOjj2awmLHeB3kHb/0Co2l2J7D5syAlJOKRG0lLJaU3LE
	 Dy+YRzjX7nAHkLp2/WLoNgmymvStsUuUwm0qG51Wqic1mhtww+SOTpqRkgXkYE2Wua
	 XMllR8JPVAMXg==
From: Sasha Levin <sashal@kernel.org>
To: mhun512@gmail.com,
	ae878000@gmail.com,
	lee@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] leds: ktd2692: Pass context to regulator cleanup" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:29:45 -0500
Message-ID: <20261107052945-failed-6.6-c73e9f04445f@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x c73e9f04445f361d5f19ca2edfde742ce18348ef
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052945-failed-6.6-c73e9f04445f@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From c73e9f04445f361d5f19ca2edfde742ce18348ef Mon Sep 17 00:00:00 2001
From: Myeonghun Pak <mhun512@gmail.com>
Date: Thu, 10 Sep 2026 15:45:25 -0400
Subject: [PATCH] leds: ktd2692: Pass context to regulator cleanup

regulator_disable_action() retrieves the driver context from device
driver data.  However, ktd2692_parse_dt() registers the action before
ktd2692_probe() stores the context with platform_set_drvdata().

If devm_add_action_or_reset() cannot allocate the action, it invokes the
callback immediately.  A later probe failure also invokes it during
managed-resource unwinding.  Both paths dereference a NULL context.

Pass the already allocated context directly to the action and retain the
device pointer in it for error reporting.  The context is allocated before
the action is registered, so reverse-order devres unwinding keeps it alive
through the callback.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: ee78b9360e14 ("leds: ktd2692: Fix an error handling path")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Link: https://patch.msgid.link/20260910194525.99654-1-mhun512@gmail.com
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/leds/flash/leds-ktd2692.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/leds/flash/leds-ktd2692.c b/drivers/leds/flash/leds-ktd2692.c
index 22fbfccd48735..43d4d55503ab5 100644
--- a/drivers/leds/flash/leds-ktd2692.c
+++ b/drivers/leds/flash/leds-ktd2692.c
@@ -69,6 +69,8 @@ static const struct expresswire_timing ktd2692_timing = {
 };
 
 struct ktd2692_context {
+	struct device *dev;
+
 	/* Common ExpressWire properties (ctrl GPIO and timing) */
 	struct expresswire_common_props props;
 
@@ -196,13 +198,12 @@ static void ktd2692_setup(struct ktd2692_context *led)
 
 static void regulator_disable_action(void *_data)
 {
-	struct device *dev = _data;
-	struct ktd2692_context *led = dev_get_drvdata(dev);
+	struct ktd2692_context *led = _data;
 	int ret;
 
 	ret = regulator_disable(led->regulator);
 	if (ret)
-		dev_err(dev, "Failed to disable supply: %d\n", ret);
+		dev_err(led->dev, "Failed to disable supply: %d\n", ret);
 }
 
 static int ktd2692_parse_dt(struct ktd2692_context *led, struct device *dev,
@@ -233,7 +234,7 @@ static int ktd2692_parse_dt(struct ktd2692_context *led, struct device *dev,
 			dev_err(dev, "Failed to enable supply: %d\n", ret);
 		} else {
 			ret = devm_add_action_or_reset(dev,
-						regulator_disable_action, dev);
+						regulator_disable_action, led);
 			if (ret)
 				return ret;
 		}
@@ -290,6 +291,7 @@ static int ktd2692_probe(struct platform_device *pdev)
 	if (!led)
 		return -ENOMEM;
 
+	led->dev = &pdev->dev;
 	fled_cdev = &led->fled_cdev;
 	led_cdev = &fled_cdev->led_cdev;
 	led->props.timing = ktd2692_timing;
-- 
2.53.0




