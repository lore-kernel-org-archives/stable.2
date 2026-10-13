Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EAC33F59C;
	Tue, 13 Oct 2026 09:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791882768; cv=none; b=iJv5LAPLAoa3NS+iEldaN2t4uiO0717ksNk0K7pJ6eVkRZQ8LRFF5fAp/Hl8OO6UMO7CeswiKv+dC70VUU+1UPif71FFHfgzjC+HiEEZ9YMrUAKvc19gXuW3fnIIANnczIWZoo+wrXEOeiwc2ENW47pvhp+RW4WpLoikxyV3nyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791882768; c=relaxed/simple;
	bh=bQ7AkOeeTpNMzRdh3gFvPQRedk/OlpL5mQzymPXspQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YsHYoe0qCxMbr7ZtjZ3XUrvKZY8MRuVmStla5byoj7eZ+Iv4+cyZ4CNtLn/9pmU9l58J9Q8/47tqL/FrX5j/Vl/ffCvqKKKuZaMAsrCbEqFq4Faf2juSLdZgjDcpGISj/KCsuXzrJ0YDWfbmrAKjQbRl5wWXR6M5zvOWof0moew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRE9jSIv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRE9jSIv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1CD1F00898;
	Tue, 13 Oct 2026 09:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791882767;
	bh=Q6fetEYfn95koieX0ebrxI0oEPwBChp/O5jQGY6Cw2w=;
	h=From:To:Cc:Subject:Date;
	b=fRE9jSIv2GqOzY9wnrECNewLwx/7VumGtfv/cwLcGcANaLOuCP5+FsqSCjZ3hYb31
	 0UmxXFm1VDrrHxnvJrb5eJskixOjM742Dj2GsCoe/KQ4ROWL83/w7N7rMu7G84oNWF
	 yGwcvGejTaU8yEo2bO9bhe5Tu5D3twm/U39j8KHdiA7Hf+8lAXQ4zGHAkffaP7N1Vt
	 taa3Y8gO4ehYvA3mtSkzkzRDJmqjajg4iqrzjPYoSTFDL+SVQC9xL2hzVH9mMCGe8l
	 FgMGCoaISpm5d/CzveX7wJ3TgPyc52z9ymCI5Q7mvLMRjmzwjqU4Orp1HENPbxmdTu
	 P2d8tmD41xjTA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Vicki Pfau <vi@endrift.com>,
	Jiri Kosina <jkosina@suse.com>
Subject: [STABLE v6.6 1/5] HID: hid-steam: Make client_opened a counter
Date: Tue, 13 Oct 2026 09:11:50 +0000
Message-ID: <20261013091156.528734-1-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vicki Pfau <vi@endrift.com>

[ Upstream commit 555b818adb97eca70210a49ba3f1d27882dde092 ]

The client_opened variable was used to track if the hidraw was opened by any
clients to silence keyboard/mouse events while opened. However, there was no
counting of how many clients were opened, so opening two at the same time and
then closing one would fool the driver into thinking it had no remaining opened
clients.

Signed-off-by: Vicki Pfau <vi@endrift.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/hid/hid-steam.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index 29ff4eb5194b..d390ac5aee0d 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -294,7 +294,7 @@ struct steam_device {
 	spinlock_t lock;
 	struct hid_device *hdev, *client_hdev;
 	struct mutex report_mutex;
-	bool client_opened;
+	unsigned long client_opened;
 	struct input_dev __rcu *input;
 	struct input_dev __rcu *sensors;
 	unsigned long quirks;
@@ -952,7 +952,7 @@ static void steam_battery_unregister(struct steam_device *steam)
 static int steam_register(struct steam_device *steam)
 {
 	int ret;
-	bool client_opened;
+	unsigned long client_opened;
 	unsigned long flags;
 
 	/*
@@ -1138,7 +1138,7 @@ static int steam_client_ll_open(struct hid_device *hdev)
 	unsigned long flags;
 
 	spin_lock_irqsave(&steam->lock, flags);
-	steam->client_opened = true;
+	steam->client_opened++;
 	spin_unlock_irqrestore(&steam->lock, flags);
 
 	schedule_work(&steam->unregister_work);
@@ -1154,7 +1154,7 @@ static void steam_client_ll_close(struct hid_device *hdev)
 	bool connected;
 
 	spin_lock_irqsave(&steam->lock, flags);
-	steam->client_opened = false;
+	steam->client_opened--;
 	connected = steam->connected && !steam->client_opened;
 	spin_unlock_irqrestore(&steam->lock, flags);
 
@@ -1331,7 +1331,7 @@ static void steam_remove(struct hid_device *hdev)
 	cancel_work_sync(&steam->rumble_work);
 	cancel_work_sync(&steam->unregister_work);
 	steam->client_hdev = NULL;
-	steam->client_opened = false;
+	steam->client_opened = 0;
 	if (steam->quirks & STEAM_QUIRK_WIRELESS) {
 		hid_info(hdev, "Steam wireless receiver disconnected");
 	}
-- 
2.56.0.385.gd3acb90ef8-goog

