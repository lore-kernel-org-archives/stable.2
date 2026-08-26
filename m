Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557032BFC85
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 14:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787756050; cv=none; b=gKZT3y7G/p+vmWxNvWFD7382EULq2eQVoD51+d4y30pCMDLzon1NpyPRcyV3zgATbVlIPCQbfNA9kcGVHfTSjYJ1m/8FD3evI4YJxXq5Aq2YoxbimLHBiZgbddxpoyT0clizmIe+1RRQzziVYTbWccsxaXJxx8J1KJhIshjS0xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787756050; c=relaxed/simple;
	bh=RR3aY1d6vSHbXs0rTYmhVJiWGOYHjmjDZx73n7N5Weg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gcwO0F0MJy0aLJPbqzoM/4hxAIGcIK1ZKecPwgVXKcGKlPmL4e0QpBRqmWqd4C9ZxRrc1KztXQtagGLO7J1VIEOgL4tAW4wwDhUiR1RAfA60RzMgOlCNUhP8Ln1eO6jbf9mDtVxT0E9YYntOgvvncJ2HccCcdtfgGlFoXB2aj0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKTPir3G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKTPir3G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F8931F000E9;
	Wed, 26 Aug 2026 14:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787756039;
	bh=V067F3AZa9Zh8ILJJEyfkOQRjBSr7hmEL08kKx34gp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BKTPir3GSJyOMTIpIC+c/LcVAGLiYSSFupXHNVB2eySpCXIb/gAG9MULHlVmE31ER
	 CQQBNbp2rG3y1xnOTdfNWGJOwzTwOGaJW0V/P08FHApeLi4+g7NsMC/pmrsLNB2rEg
	 TkBgEPsg/oY8o8VTDHPmdhP1foxez0FZedw4Uu5RMiEwc/NA84VGj4X621t8oVCaxi
	 LILHWRFV6PWc+f4wGfMCIP+DT2SckBzJTf34/1rKvqOjmq31cZZNAeaaJUTn0bnika
	 FJpuLM6OtOM7boV+BOzI343mIj01dkaLUDxJuS6p7AEi8xuFmdvuCIoQnlm2uAPWfq
	 HvcKrb2F3cBrQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiangshan Yi <yijiangshan@kylinos.cn>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] HID: nintendo: stop device IO before hid_hw_stop on probe failure
Date: Wed, 26 Aug 2026 10:53:57 -0400
Message-ID: <20260826145357.873394-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082537-drown-acquaint-6edf@gregkh>
References: <2026082537-drown-acquaint-6edf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiangshan Yi <yijiangshan@kylinos.cn>

[ Upstream commit 1f74d3bff6fe04a64e02ab3661d2e0d554565aa6 ]

nintendo_hid_probe() calls hid_device_io_start() before joycon_init()
and joycon_leds_create().  If either fails, the error path jumps to
err_close which calls hid_hw_close()/hid_hw_stop() without first calling
hid_device_io_stop().

hid_hw_stop() does not stop device IO, so hid_input_report() may still
run and access driver data that is being torn down, resulting in a
use-after-free.

Add an err_io_stop label that calls hid_device_io_stop() before
hid_hw_close(), and point the two post-io_start error paths at it.

Fixes: 2af16c1f846b ("HID: nintendo: add nintendo switch controller driver")
Cc: stable@vger.kernel.org
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
[ dropped the absent `err_ida:`/`ida_free()` context and retargeted all five `goto err_close` paths to the new `err_io_stop` label ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-nintendo.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
index 4850e915a57d4..66331f1a86b69 100644
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -2345,34 +2345,34 @@ static int nintendo_hid_probe(struct hid_device *hdev,
 	ret = joycon_init(hdev);
 	if (ret) {
 		hid_err(hdev, "Failed to initialize controller; ret=%d\n", ret);
-		goto err_close;
+		goto err_io_stop;
 	}
 
 	ret = joycon_read_info(ctlr);
 	if (ret) {
 		hid_err(hdev, "Failed to retrieve controller info; ret=%d\n",
 			ret);
-		goto err_close;
+		goto err_io_stop;
 	}
 
 	/* Initialize the leds */
 	ret = joycon_leds_create(ctlr);
 	if (ret) {
 		hid_err(hdev, "Failed to create leds; ret=%d\n", ret);
-		goto err_close;
+		goto err_io_stop;
 	}
 
 	/* Initialize the battery power supply */
 	ret = joycon_power_supply_create(ctlr);
 	if (ret) {
 		hid_err(hdev, "Failed to create power_supply; ret=%d\n", ret);
-		goto err_close;
+		goto err_io_stop;
 	}
 
 	ret = joycon_input_create(ctlr);
 	if (ret) {
 		hid_err(hdev, "Failed to create input device; ret=%d\n", ret);
-		goto err_close;
+		goto err_io_stop;
 	}
 
 	ctlr->ctlr_state = JOYCON_CTLR_STATE_READ;
@@ -2380,7 +2380,8 @@ static int nintendo_hid_probe(struct hid_device *hdev,
 	hid_dbg(hdev, "probe - success\n");
 	return 0;
 
-err_close:
+err_io_stop:
+	hid_device_io_stop(hdev);
 	hid_hw_close(hdev);
 err_stop:
 	hid_hw_stop(hdev);
-- 
2.53.0

