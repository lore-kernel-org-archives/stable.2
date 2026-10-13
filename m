Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552AD3955CA;
	Tue, 13 Oct 2026 09:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791882769; cv=none; b=bWqtNUuTANZBZNFnu06lD+Df1BVUwrAIlYKZBf9X1KVWn3x5lc1MVXHHEOCt9QX4Ynr0dslX1QGfIfUkrkz/xJZvbmbLtxB85VMQjeS5RmcTuCgCSG/4jC8XVvPkRASLVIIwYLDU/YHvOapbJiUTgYQdYhQ6PVaPvKlVYC1G+ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791882769; c=relaxed/simple;
	bh=VGsC1pkFr6TuVjLyHHC4MY7jEl0m1+ipTTf04hHDpEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N4MUY9ZqzBDD3PZUzC2oQnhRETj5ANIgh+VlMQn051Ub7oqFbyubODiulchQQvGF7S9VpUcqfRl2UC2v9PW9apPYYWCY3Jzr+mt4ZCwBnX1BttNF2hzgEQahTdAfNS9I0t8RazCcHzVPyOLFJgZkwpdovYZI+NrfIX5PhLxNMhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hflUxaft; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hflUxaft"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D9A1F00899;
	Tue, 13 Oct 2026 09:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791882768;
	bh=GAVkkbDixS3zF+vYm9B07Td8goJRmsfYZ5179ZGoqEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hflUxaftBMiu/nG6bUxw+E/wEBWEIQpL1ok3DZf8y5zoJpGGwFR4+D4oVRLZe0MPq
	 Ia24U+iuPayfq+8o7LWZz8WLjSMkpbmEA7KSgPALEoJQaOLwg37doVELJkrx4gsiwc
	 HYPgTDhy6lB9aixR2V4r8V45jXUeZMEc9pnGPqAgQGgFO67g5ruFDtz3+IgtfuQzi3
	 0aPV19JrEABJlJjkJreVftKp29QRqDMVrgueWcVW47lH+6B4ZQJfukoK05q2OJQQYu
	 rZeveZAt+xKwLQtT4OhrVnIdR+L/gsi8p+MKmqnqCZJRLsdfWxBCIv2stASBgLo3oI
	 1ODOXUTdU6rjg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Vicki Pfau <vi@endrift.com>,
	Jiri Kosina <jkosina@suse.com>
Subject: [STABLE v6.12 2/4] HID: steam: Rearrange teardown sequence
Date: Tue, 13 Oct 2026 09:11:41 +0000
Message-ID: <20261013091146.527985-2-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261013091146.527985-1-lee@kernel.org>
References: <20261013091146.527985-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vicki Pfau <vi@endrift.com>

[ Upstream commit ddce9641ce924ed91ec8304577e463823a29ffaf ]

This fixes a narrow window during the teardown sequence where callbacks
could still be scheduled during cleanup that would then have a dangling
pointer to the now-freed steam struct.

This also puts work canceling for rumble and mode switch in
steam_unregister, as that shouldn't persist while the client hdev is open.

Signed-off-by: Vicki Pfau <vi@endrift.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
[Lee: Omit coalesce_rumble_work cancellation as 1d4549fd1115 ("HID:
      steam: Coalesce rumble packets") is not present]
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/hid/hid-steam.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index 3302f2f0ab43..b66b70e7467c 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -1022,6 +1022,8 @@ static void steam_unregister(struct steam_device *steam)
 	steam_battery_unregister(steam);
 	steam_sensors_unregister(steam);
 	steam_input_unregister(steam);
+	cancel_work_sync(&steam->rumble_work);
+	cancel_delayed_work_sync(&steam->mode_switch);
 	mutex_lock(&steam_devices_lock);
 	list_del_init(&steam->list);
 	mutex_unlock(&steam_devices_lock);
@@ -1303,24 +1305,24 @@ static int steam_probe(struct hid_device *hdev,
 static void steam_remove(struct hid_device *hdev)
 {
 	struct steam_device *steam = hid_get_drvdata(hdev);
+	unsigned long flags;
 
 	if (!steam || hdev->group == HID_GROUP_STEAM) {
 		hid_hw_stop(hdev);
 		return;
 	}
 
+	hid_hw_close(hdev);
 	hid_destroy_device(steam->client_hdev);
-	cancel_delayed_work_sync(&steam->mode_switch);
-	cancel_work_sync(&steam->work_connect);
-	cancel_work_sync(&steam->rumble_work);
-	steam->client_hdev = NULL;
+	spin_lock_irqsave(&steam->lock, flags);
 	steam->client_opened = 0;
+	spin_unlock_irqrestore(&steam->lock, flags);
+	cancel_work_sync(&steam->work_connect);
 	if (steam->quirks & STEAM_QUIRK_WIRELESS) {
 		hid_info(hdev, "Steam wireless receiver disconnected");
 	}
-	hid_hw_close(hdev);
-	hid_hw_stop(hdev);
 	steam_unregister(steam);
+	hid_hw_stop(hdev);
 }
 
 static void steam_do_connect_event(struct steam_device *steam, bool connected)
-- 
2.56.0.385.gd3acb90ef8-goog

