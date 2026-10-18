Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20893FBED7;
	Sun, 18 Oct 2026 21:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792359525; cv=none; b=KXlIqbWgfyFKJC44LpUt/j0U6/+EoskEDgtSv0JVBWGulTYC3iRcMnUDAdJK112lFdsfuj+NSNdK+cu1zVse7M/io+KTdYnMRLmF7thzmWSgtmrA6AvjLHHM6F5B2AQcFZAiL/JgupWMvsP0L1gqmirf0UMaHfUlHukpazq6XQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792359525; c=relaxed/simple;
	bh=sdcUEqq74eHCrRDKAZMGFog2GDloP3CSdqvK6vL/bjA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ej2urS0BwyTs+TrWK+YybAfr1xxjBrAFGO/BtEr93zaPDlQgmIqbDY4TtGQ9u48D4pAQGhGU0BeQqQGru4YfdSL4XkEH2mXz47uvGmCgqLVxzUOc5gvtnQzR9khQx5mt8OKDaHJglLQFLiPTfO8bL9Ccd3EhYv7B0Tm4BAqag0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4a3RBsT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4a3RBsT"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A21BC2BCF7;
	Sun, 18 Oct 2026 21:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792359525;
	bh=sdcUEqq74eHCrRDKAZMGFog2GDloP3CSdqvK6vL/bjA=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=g4a3RBsTVzzCpgIGLlHF7CucRM8NyBxZFSw5eSREYDK4VGaw+cYV4F9+7/CsTTxGD
	 sNfPoA+lO/PA19HIZfJbxJE3/UPwsQYNNq+UmXejXzlI1kpCktyZCw0uerBdD9qZ9F
	 EVsiwKbvCvFpCe7pmAVXmt8lzpa9EWfpCMqRcp4XTmvSJWmKT1HaWD878u/2w4v2pK
	 6VEUYT0vkEbTYDW50AVUV2W+XpecAgOAf7N1tDodreTa1OVNfLAs54omUQN5PojMUu
	 /C+RnF7ICOKZ1iQcLKCodIYvK1mtshVxK3EWH5/I+AQ9cP+3yTlaCllBH6EaylSlO3
	 sQY5yLZd/bknQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CECCCA490;
	Sun, 18 Oct 2026 21:38:45 +0000 (UTC)
From: George Neacsu via B4 Relay <devnull+geocausa.gmail.com@kernel.org>
Date: Sun, 18 Oct 2026 22:38:27 +0100
Subject: [PATCH v3] leds: flash: leds-qcom-flash: Release all V4L2 flash
 devices
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261018-qcom-flash-v4l2-release-v3-1-02e18d30b18a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XNwQ7CIAyA4VdZOFsDHY7hyfcwHgh0GwlzCoZol
 r27bKddjMe/ab/OLFH0lNi5mlmk7JOf7iXqQ8XsYO49gXelGXJsBBcNPO00QhdMGiDLgBApkEk
 E2vGT1coJKxUr149InX9v8vVWevDpNcXP9iiLdfrfzAIEcNJojLK6RnXpR+PDsayz1cy4d9rfD
 hanJUStWimd7vbOsixfcLVdoAYBAAA=
X-Change-ID: 20261016-qcom-flash-v4l2-release-9d05c97d1c47
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>
Cc: linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Sashiko AI review <sashiko-bot@kernel.org>, 
 George Neacsu <geocausa@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792359524; l=5007;
 i=geocausa@gmail.com; s=20261015; h=from:subject:message-id;
 bh=oc/hSq7sr8nReWP4Ks/gKgwmy+1Nv+v2r8Fm6BN5bng=;
 b=1q3DeEEz3i3exvLU9ly0mZBac5aTDJNcmvk7JLVA36tqWSPiaRTLm395I0XWr5VtAE8+A7wb7
 +DuFXBTkEeqC7ByynW5b6KiP8JtMAjpHM9dBgjosACXMvAGMNboI3sH
X-Developer-Key: i=geocausa@gmail.com; a=ed25519;
 pk=KyQk/iWbxsikewDBh0SwlHI51RvAqahD3loqmRp9DVI=
X-Endpoint-Received: by B4 Relay for geocausa@gmail.com/20261015 with
 auth_id=1199
X-Original-From: George Neacsu <geocausa@gmail.com>
Reply-To: geocausa@gmail.com

From: George Neacsu <geocausa@gmail.com>

The probe error path and qcom_flash_led_remove() use leds_count as an
array index before decrementing it. Since leds_count is the number of
registered LEDs, that first access is one entry past the last registered
V4L2 flash device. The loops also stop before index 0, so with a single
LED nothing is released at all.

The V4L2 flash sub-device then stays registered after the driver is
unbound, still pointing at the driver's freed devm memory. On a Surface
Pro 11 (X1E80100, PM8550 flash, IR LED linked to a sensor through
flash-leds), unloading the module and then setting a flash control on
the sub-device triggered UBSAN shift-out-of-bounds reports and a NULL
pointer dereference in regmap_field_update_bits_base(), called from
update_allowed_flash_current().

Release the registered entries from leds_count - 1 down to 0. Initialize
the mutex with devm_mutex_init() before registering managed LED class
devices so it remains valid until their devres cleanup has completed.
Route a final torch-clamp programming failure through the V4L2 cleanup
as well.

Fixes: 96a2e242a5dc ("leds: flash: Add driver to support flash LED module in QCOM PMICs")
Cc: stable@vger.kernel.org
Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20261016-qcom-flash-v4l2-release-v1-1-0e92aa7c9327@gmail.com?part=1
Link: https://sashiko.dev/#/patchset/20261018-qcom-flash-v4l2-release-v2-1-8e2297844d9f@gmail.com?part=1
Assisted-by: Claude:claude-opus-5-5
Assisted-by: ChatGPT:gpt-5.6-sol
Signed-off-by: George Neacsu <geocausa@gmail.com>
---
The V4L2 flash cleanup currently indexes one element past the registered
array and fails to release index 0. Fix the cleanup for both probe failure
and driver removal.

v2 added symmetric probe-error cleanup. v3 keeps the mutex devres-managed
so it remains valid until the managed LED class devices have been
unregistered.
---
Changes in v3:
- use devm_mutex_init() before managed LED registration;
- drop manual mutex_destroy() calls so LED devres cleanup runs first;
- add the Sashiko v2 review link.
- Link to v2: https://lore.kernel.org/r/20261018-qcom-flash-v4l2-release-v2-1-8e2297844d9f@gmail.com

Changes in v2:
- initialize the mutex after direct-return probe checks and destroy it on
  the shared failure path, addressing the Sashiko review;
- route the final torch-clamp register-write failure through V4L2 cleanup;
- retain the v1 tested cleanup of every registered V4L2 flash device.
- Link to v1: https://lore.kernel.org/r/20261016-qcom-flash-v4l2-release-v1-1-0e92aa7c9327@gmail.com
---
 drivers/leds/flash/leds-qcom-flash.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/leds/flash/leds-qcom-flash.c b/drivers/leds/flash/leds-qcom-flash.c
index b03a683..4219e55 100644
--- a/drivers/leds/flash/leds-qcom-flash.c
+++ b/drivers/leds/flash/leds-qcom-flash.c
@@ -923,7 +923,6 @@ static int qcom_flash_led_probe(struct platform_device *pdev)
 	devm_kfree(dev, regs); /* devm_regmap_field_bulk_alloc() makes copies */
 
 	platform_set_drvdata(pdev, flash_data);
-	mutex_init(&flash_data->lock);
 
 	count = device_get_child_node_count(dev);
 	if (count == 0 || count > flash_data->max_channels) {
@@ -936,6 +935,10 @@ static int qcom_flash_led_probe(struct platform_device *pdev)
 	if (!flash_data->v4l2_flash)
 		return -ENOMEM;
 
+	rc = devm_mutex_init(dev, &flash_data->lock);
+	if (rc)
+		return rc;
+
 	device_for_each_child_node_scoped(dev, child) {
 		led = devm_kzalloc(dev, sizeof(*led), GFP_KERNEL);
 		if (!led) {
@@ -951,10 +954,15 @@ static int qcom_flash_led_probe(struct platform_device *pdev)
 		flash_data->leds_count++;
 	}
 
-	return regmap_field_write(flash_data->r_fields[REG_TORCH_CLAMP], flash_data->torch_clamp);
+	rc = regmap_field_write(flash_data->r_fields[REG_TORCH_CLAMP],
+				flash_data->torch_clamp);
+	if (rc)
+		goto release;
+
+	return 0;
 release:
-	while (flash_data->v4l2_flash[flash_data->leds_count] && flash_data->leds_count)
-		v4l2_flash_release(flash_data->v4l2_flash[flash_data->leds_count--]);
+	while (flash_data->leds_count)
+		v4l2_flash_release(flash_data->v4l2_flash[--flash_data->leds_count]);
 	return rc;
 }
 
@@ -962,10 +970,8 @@ static void qcom_flash_led_remove(struct platform_device *pdev)
 {
 	struct qcom_flash_data *flash_data = platform_get_drvdata(pdev);
 
-	while (flash_data->v4l2_flash[flash_data->leds_count] && flash_data->leds_count)
-		v4l2_flash_release(flash_data->v4l2_flash[flash_data->leds_count--]);
-
-	mutex_destroy(&flash_data->lock);
+	while (flash_data->leds_count)
+		v4l2_flash_release(flash_data->v4l2_flash[--flash_data->leds_count]);
 }
 
 static const struct of_device_id qcom_flash_led_match_table[] = {

---
base-commit: 62f482ff73bf3ae88b0c899115527752cf9cbf13
change-id: 20261016-qcom-flash-v4l2-release-9d05c97d1c47

Best regards,
-- 
George Neacsu <geocausa@gmail.com>


