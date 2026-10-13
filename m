Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69DA3EA97A;
	Tue, 13 Oct 2026 09:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791882773; cv=none; b=lmxAXzwq24WsCS2a77wSFOxB/6DKfHWetBVDV0E6W1VpeEE+E/E/HM1gPke2ZfH2zyHf7A8C+KRsJQDCIuPFAf5vyXFN/NLdwQRi2897VXNFL11d7d0eYK0BY3W5XSE3YzP0pmxiMxruy6Ske0GP5RyQsdiY8O4/hdIWb0v7t14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791882773; c=relaxed/simple;
	bh=iEdAtHyoAgF/JwAogsC5AWRVG8ab1A0AY5yjgLhwuBw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UwVf3rZQiPO5ysa3g/KkkJ80DMfV+2cT9zHvMdpDMzVAQn3CxFMGVLX5CkUG0at3Qp31dwUud548+9X8kzPotvObJOglzOI09RF1sTzrcjX3ATvgA5qmlAfX11ogGGSnCyyJIcyRwf/jpthYOtgHeXYhihcEajmBC6lhlJEB5jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tta2kGZR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tta2kGZR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201981F0089B;
	Tue, 13 Oct 2026 09:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791882771;
	bh=lwUaIHGqVU/mDMaKN1BqxXdn7KmucGAcqhYPt6JrRvg=;
	h=From:To:Cc:Subject:Date;
	b=Tta2kGZRZxoosSuZn4qZgHUnwVQtMcZ4CRE53ONr0IhDDteNBFfulo4woKniZXkbE
	 6R6Xl38fRK8lAXSstUkffAjgHuKUIaDQi1J/zvmVMGtYG4oYh3A71y1ysIcA8WL4JM
	 ujVyXVWJieZ8y8cwcjNmwCoooKsK0YTyXh9qM1ZLgFggKFq3lsoIXo7xzbPU6U/Hq3
	 JP30ho27DMeO73ztDMGbb+iEBUK6LyLoePvqXSxWcdT8F2WEJVR/Xhp5paZU73hinq
	 0+iddW/Rhv1ibrzUsPsUCZI2+CjdVZfyuBdr2JAfa0WDmp2jtVMduLaS6NHyI6fGQw
	 FmqsJudA64fkQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Vicki Pfau <vi@endrift.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Subject: [STABLE v5.15-v5.10 1/6] HID: hid-steam: Fix cleanup in probe()
Date: Tue, 13 Oct 2026 09:12:08 +0000
Message-ID: <20261013091215.529531-1-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit a9f1da09c69f13ef471db8b22107a28042d230ca ]

There are a number of issues in this code.  First of all if
steam_create_client_hid() fails then it leads to an error pointer
dereference when we call hid_destroy_device(steam->client_hdev).

Also there are a number of leaks.  hid_hw_stop() is not called if
hid_hw_open() fails for example.  And it doesn't call steam_unregister()
or hid_hw_close().

Fixes: 691ead124a0c ("HID: hid-steam: Clean up locking")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Vicki Pfau <vi@endrift.com>
Link: https://lore.kernel.org/r/1fd87904-dabf-4879-bb89-72d13ebfc91e@moroto.mountain
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
[Lee: Move client_hdev creation after steam_register() and omit
      mode_switch and rumble_work cancellation as 691ead124a0c and
      e133dc99fc07 are not present]
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/hid/hid-steam.c | 43 ++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index fc616db4231b..8832f7987006 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -751,31 +751,20 @@ static int steam_probe(struct hid_device *hdev,
 	INIT_WORK(&steam->work_connect, steam_work_connect_cb);
 	INIT_LIST_HEAD(&steam->list);
 
-	steam->client_hdev = steam_create_client_hid(hdev);
-	if (IS_ERR(steam->client_hdev)) {
-		ret = PTR_ERR(steam->client_hdev);
-		goto client_hdev_fail;
-	}
-	steam->client_hdev->driver_data = steam;
-
 	/*
 	 * With the real steam controller interface, do not connect hidraw.
 	 * Instead, create the client_hid and connect that.
 	 */
 	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT & ~HID_CONNECT_HIDRAW);
 	if (ret)
-		goto hid_hw_start_fail;
-
-	ret = hid_add_device(steam->client_hdev);
-	if (ret)
-		goto client_hdev_add_fail;
+		goto err_cancel_work;
 
 	ret = hid_hw_open(hdev);
 	if (ret) {
 		hid_err(hdev,
 			"%s:hid_hw_open\n",
 			__func__);
-		goto hid_hw_open_fail;
+		goto err_hw_stop;
 	}
 
 	if (steam->quirks & STEAM_QUIRK_WIRELESS) {
@@ -791,19 +780,33 @@ static int steam_probe(struct hid_device *hdev,
 			hid_err(hdev,
 				"%s:steam_register failed with error %d\n",
 				__func__, ret);
-			goto input_register_fail;
+			goto err_hw_close;
 		}
 	}
 
+	steam->client_hdev = steam_create_client_hid(hdev);
+	if (IS_ERR(steam->client_hdev)) {
+		ret = PTR_ERR(steam->client_hdev);
+		goto err_stream_unregister;
+	}
+	steam->client_hdev->driver_data = steam;
+
+	ret = hid_add_device(steam->client_hdev);
+	if (ret)
+		goto err_destroy;
+
 	return 0;
 
-input_register_fail:
-hid_hw_open_fail:
-client_hdev_add_fail:
-	hid_hw_stop(hdev);
-hid_hw_start_fail:
+err_destroy:
 	hid_destroy_device(steam->client_hdev);
-client_hdev_fail:
+err_stream_unregister:
+	if (steam->connected)
+		steam_unregister(steam);
+err_hw_close:
+	hid_hw_close(hdev);
+err_hw_stop:
+	hid_hw_stop(hdev);
+err_cancel_work:
 	cancel_work_sync(&steam->work_connect);
 steam_alloc_fail:
 	hid_err(hdev, "%s: failed with error %d\n",
-- 
2.56.0.385.gd3acb90ef8-goog

