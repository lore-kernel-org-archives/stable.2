Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84C03F210B
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 15:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787757083; cv=none; b=HufAAZ5hHP7/lEBVDoj1oRsPHY8d19oNGrjV0aurGrN7/8u48OklatlINlPG9xvtOiFEQL0s6Um4tVi/D90M4JbAaea0mXX6OEtZtiZYdn576zUuellSchZKQI7yTFMS6F+XzJSN5u/AH3dGd5skBDD01pZQ67Gs8N8SDYETPLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787757083; c=relaxed/simple;
	bh=cYR2ZrygMNlrw0A9OHhntoOZPehm2nJNUSnOivMxMas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=prL4KnWmbDsM1WiTjJINmDGVV1wgnsQbbSAq19/iUCivfVo1B3U2YTnXKDZSeEWTcXI8eDWCUWGPIPgFHC3GkNqhKxJmBRsY0Zujis4lzVc771bE7/LfCMJ/xNKQGbcZ4fSR7bdvWjKaaZcH+55XO6ju6V1JOmbCFSEfIyh9wwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUeC1IEV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUeC1IEV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26CB01F000E9;
	Wed, 26 Aug 2026 15:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787757081;
	bh=nsto0A9RVKdUaqYffiT6Pzp4zL1MGgEsnepuwVf1pK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mUeC1IEVq677bTO33PTnkbyJ/Vm5PlG+drwqe7xSD8YIEdUXFzUYZ+dNOohR331Bn
	 rN6jchaQy1NxaOrecoxw+NtpY5TtxaFpxZkkEHY8OJD7rvQv8A9UMD5xPbiyeyjHm+
	 j4R4b7WAs0PmcA0EZ3NWwIGy78ULHpiOwDXrsWp7Qy/uVnFVGDAZFIniNqfVmUnWJX
	 HN2bwIY7fZneYsGgeVWn5aIdJntKjyAI9UGY/Dx0OU/5d4Z7sDwKUsM3Z3dQ5rrIbj
	 Hl7n/JeEr51RU7KeS8CE3KClztVsSJS8n7CD8ESMKPuP6PXR6Dzqb+6N/3NaGy7hVg
	 VoLmk+LbOtSsQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiangshan Yi <yijiangshan@kylinos.cn>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] HID: nintendo: stop device IO before hid_hw_stop on probe failure
Date: Wed, 26 Aug 2026 11:11:18 -0400
Message-ID: <20260826151119.985095-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082538-busboy-cannabis-7578@gregkh>
References: <2026082538-busboy-cannabis-7578@gregkh>
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
index df07e3ae0ffb4..7a47bf8685938 100644
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -2268,34 +2268,34 @@ static int nintendo_hid_probe(struct hid_device *hdev,
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
@@ -2303,7 +2303,8 @@ static int nintendo_hid_probe(struct hid_device *hdev,
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

