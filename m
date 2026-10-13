Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69E93FC5A1;
	Tue, 13 Oct 2026 09:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791882775; cv=none; b=HSvXPdFgFQublS+mwlaqz4vJd7bAndWtzT4uy5tM2P+BHygwrt8odMd/S0JTNSVp7ZqIJwZktn1dZVXN9ovIS2ofNt7FsX3THjNV6c/AVIVQA2jSrXE8/iINsqwGcj6WkWTujoxS8ebwfLJxX3kt0NX0qEJj8hDEeCQziyoOZsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791882775; c=relaxed/simple;
	bh=k3JUhnLG/fEVL6MTdbgwQ1bJfZA6Hqew1SjN5dTjac8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K5+47t+f76Cr8UMBsRtCi6PQzCir2IM2fnpWHgzRePpMqLRLIBh3GzWbDp2aVNGK5bOo87lMxOCjjm7qxGxBkjbMFXX7zAM2zQCDMB9DnvKVzimwqO1o9HAHc/XJ8vMSZnRgw0FsALjn5WjrCg16hhwWWj6unaHj65qKwiIlxrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGfDJ6Oe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGfDJ6Oe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 633C31F000FF;
	Tue, 13 Oct 2026 09:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791882773;
	bh=XvRme1wLbfEnG39mQIRuWu8cnZGIYE7/pah4420ffqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KGfDJ6OeDham0hGAnWltw1syXNEalG8SLMQyEnNpuQTH4tYz8grKfuKmWH6kELTXm
	 55w8TAY5ZqlKHhZka5DCEdEhjEUWAYSgU+iEvX67Id2OGsgz2wu+veOXp4S6YrCxyy
	 knhQkd8mkNi2dhAM5E+tQKNHi8gbanMiPibKcudrMCeJNMee0WVBCH6SoIE0+YbCoe
	 k8j4yHh8R/oMv89jzzeSGmEb2rXerqZ0Eo25JMe+PgKnOnO5giq1RHjL6rru/+a9wH
	 2DVKEezeKCo7nhCWHgL+6ruJTdumb4xiZoCqTlYbd2GeUkoXijWfmTPt49XPydlRVb
	 Kb96RB1aMNQLg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Vicki Pfau <vi@endrift.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Jiri Kosina <jkosina@suse.com>
Subject: [STABLE v5.15-v5.10 2/6] HID: hid-steam: Make client_opened a counter
Date: Tue, 13 Oct 2026 09:12:09 +0000
Message-ID: <20261013091215.529531-2-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261013091215.529531-1-lee@kernel.org>
References: <20261013091215.529531-1-lee@kernel.org>
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
[Lee: Adapt steam_client_ll_open() and steam_client_ll_close() as
      691ead124a0c and e1147961b214 are not present]
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/hid/hid-steam.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index 8832f7987006..159b55dff799 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -114,7 +114,7 @@ struct steam_device {
 	spinlock_t lock;
 	struct hid_device *hdev, *client_hdev;
 	struct mutex mutex;
-	bool client_opened;
+	unsigned long client_opened;
 	struct input_dev __rcu *input;
 	unsigned long quirks;
 	struct work_struct work_connect;
@@ -509,7 +509,7 @@ static void steam_battery_unregister(struct steam_device *steam)
 static int steam_register(struct steam_device *steam)
 {
 	int ret;
-	bool client_opened;
+	unsigned long client_opened;
 
 	/*
 	 * This function can be called several times in a row with the
@@ -634,7 +634,7 @@ static int steam_client_ll_open(struct hid_device *hdev)
 	struct steam_device *steam = hdev->driver_data;
 
 	mutex_lock(&steam->mutex);
-	steam->client_opened = true;
+	steam->client_opened++;
 	mutex_unlock(&steam->mutex);
 
 	steam_input_unregister(steam);
@@ -654,12 +654,12 @@ static void steam_client_ll_close(struct hid_device *hdev)
 	spin_unlock_irqrestore(&steam->lock, flags);
 
 	mutex_lock(&steam->mutex);
-	steam->client_opened = false;
-	if (connected)
+	steam->client_opened--;
+	if (connected && !steam->client_opened)
 		steam_set_lizard_mode(steam, lizard_mode);
 	mutex_unlock(&steam->mutex);
 
-	if (connected)
+	if (connected && !steam->client_opened)
 		steam_input_register(steam);
 }
 
@@ -824,7 +824,7 @@ static void steam_remove(struct hid_device *hdev)
 	}
 
 	hid_destroy_device(steam->client_hdev);
-	steam->client_opened = false;
+	steam->client_opened = 0;
 	cancel_work_sync(&steam->work_connect);
 	if (steam->quirks & STEAM_QUIRK_WIRELESS) {
 		hid_info(hdev, "Steam wireless receiver disconnected");
-- 
2.56.0.385.gd3acb90ef8-goog

