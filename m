Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23FC3A901C;
	Fri, 16 Oct 2026 06:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792132650; cv=none; b=VIkjtXoioepBr5XXTuxm+DPYXMTC9W9MYD0zViggEIqcgT1CQPA/lihvduE5A0IRGiDZYhUa9yMJVKqCxf8kZsNj6pugldJW2qO6ugtTU+JZaY/VzDvq9WDibhvIq6qZEPGcR8agU8aqqMI7KjLf//vdjcWhbTSMruiLnphmqr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792132650; c=relaxed/simple;
	bh=BnnYdFFWWwOCp+3d1u2NUGSicwuidY4Oh+2ora6rmm4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gI/ZIMwG1iOxKAdZOJkEMdHJVCkxgFUALtW2t4ok46ve/4hEr8IxhP2zx1Iy+dVyxD4N8U5wskrug7r9M8PsuUs8df5b26N/Hoy+0ruR38rlh1ENld4e5Z6EloEVbHLHEPPW6sGfp+v5OI8LwUWsbC7dU7ttn8CP6qbh7NipRrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7uBH0ae; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7uBH0ae"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 666BFC2BCF5;
	Fri, 16 Oct 2026 06:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792132650;
	bh=BnnYdFFWWwOCp+3d1u2NUGSicwuidY4Oh+2ora6rmm4=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=V7uBH0ae19vKw9EKFz+V70/q5WnpRTNmyHOxkHICdNLXdMLdBDRelduklBv8Odu6z
	 5j/FhvWG3tVkN3HlvyLOZUfpqqorYDGZ1jFjOaxKZgeA+7TcmVdUkNBwkSRE4BXVYf
	 bNqi/Glma/UtL0xcqWXZFEh4QzyyO1Ae4vgKRLYNeD65T0JxV1qjOmZ8XopGYr+YDI
	 oREvSV5zBpteWDvw+Y8+84yUcaFOvns/nEFWMybxCgX7D+7QHdlwz1a7EXJqHUVd17
	 U1CCNxxtPXbbInfzEU/olEF2CyWXnuiCVwOTHMfOah3mFFgx0TzbuLuzj6PmkcLgRk
	 N+Fei/NaKmmjw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40568CCA462;
	Fri, 16 Oct 2026 06:37:30 +0000 (UTC)
From: George Neacsu via B4 Relay <devnull+geocausa.gmail.com@kernel.org>
Date: Fri, 16 Oct 2026 07:37:30 +0100
Subject: [PATCH] leds: flash: leds-qcom-flash: Release all V4L2 flash
 devices
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-qcom-flash-v4l2-release-v1-1-0e92aa7c9327@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MTQqAIBBA4avErBtQKaOuEi1EpxywPwciiO6et
 PwW7z0glJkEhuqBTBcL71uBrivw0W0LIYdiMMpYrbTF0+8rzslJxKtJBjMlckLYB9X6vgvaNx2
 U+sg08/2fx+l9Pwh7F4ppAAAA
X-Change-ID: 20261016-qcom-flash-v4l2-release-9d05c97d1c47
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-leds@vger.kernel.org, stable@vger.kernel.org, 
 George Neacsu <geocausa@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792132649; l=2721;
 i=geocausa@gmail.com; s=20261015; h=from:subject:message-id;
 bh=CI6yYCRJ7s3Nt//a396V+HzvBRozRkOc2yI+sV9seYA=;
 b=DE117K+Hxmkt3xq1NNeUAoIn3zCf1lMjMnJNMAANQL01b7nbzwHXfl0Z11u4w79aYj/WJzgHn
 vCp+h0y+s/wDodjhieEW2JemsODWQ23ZCIUI8Eb1lm2RN6QCKkuFsfv
X-Developer-Key: i=geocausa@gmail.com; a=ed25519;
 pk=KyQk/iWbxsikewDBh0SwlHI51RvAqahD3loqmRp9DVI=
X-Endpoint-Received: by B4 Relay for geocausa@gmail.com/20261015 with
 auth_id=1199
X-Original-From: George Neacsu <geocausa@gmail.com>
Reply-To: geocausa@gmail.com

From: George Neacsu <geocausa@gmail.com>

The probe error path and qcom_flash_led_remove() walk the V4L2 flash
array like this:

	while (flash_data->v4l2_flash[flash_data->leds_count] && flash_data->leds_count)
		v4l2_flash_release(flash_data->v4l2_flash[flash_data->leds_count--]);

leds_count is the number of registered LEDs, so the first test reads
one entry past the last registered one. The array holds exactly one
entry per LED child node, so after a full probe that read is out of
bounds. The loop also stops before index 0. With a single LED nothing
is released at all.

The V4L2 flash sub-device then stays registered after the driver is
unbound, still pointing at the driver's freed devm memory. On a Surface
Pro 11 (X1E80100, PM8550 flash, IR LED linked to a sensor through
flash-leds), unloading the module and then setting a flash control on
the sub-device triggered UBSAN shift-out-of-bounds reports and a NULL
pointer dereference in regmap_field_update_bits_base(), called from
update_allowed_flash_current().

Release the registered entries from leds_count - 1 down to 0.

Fixes: 96a2e242a5dc ("leds: flash: Add driver to support flash LED module in QCOM PMICs")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: George Neacsu <geocausa@gmail.com>
---
 drivers/leds/flash/leds-qcom-flash.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/leds/flash/leds-qcom-flash.c b/drivers/leds/flash/leds-qcom-flash.c
index b03a683..c2fefee 100644
--- a/drivers/leds/flash/leds-qcom-flash.c
+++ b/drivers/leds/flash/leds-qcom-flash.c
@@ -953,8 +953,8 @@ static int qcom_flash_led_probe(struct platform_device *pdev)
 
 	return regmap_field_write(flash_data->r_fields[REG_TORCH_CLAMP], flash_data->torch_clamp);
 release:
-	while (flash_data->v4l2_flash[flash_data->leds_count] && flash_data->leds_count)
-		v4l2_flash_release(flash_data->v4l2_flash[flash_data->leds_count--]);
+	while (flash_data->leds_count)
+		v4l2_flash_release(flash_data->v4l2_flash[--flash_data->leds_count]);
 	return rc;
 }
 
@@ -962,8 +962,8 @@ static void qcom_flash_led_remove(struct platform_device *pdev)
 {
 	struct qcom_flash_data *flash_data = platform_get_drvdata(pdev);
 
-	while (flash_data->v4l2_flash[flash_data->leds_count] && flash_data->leds_count)
-		v4l2_flash_release(flash_data->v4l2_flash[flash_data->leds_count--]);
+	while (flash_data->leds_count)
+		v4l2_flash_release(flash_data->v4l2_flash[--flash_data->leds_count]);
 
 	mutex_destroy(&flash_data->lock);
 }

---
base-commit: 62f482ff73bf3ae88b0c899115527752cf9cbf13
change-id: 20261016-qcom-flash-v4l2-release-9d05c97d1c47

Best regards,
-- 
George Neacsu <geocausa@gmail.com>


