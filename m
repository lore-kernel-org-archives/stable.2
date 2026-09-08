Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DE65CDF1
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 00:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788827966; cv=none; b=HotmEqAPhpOPA73sPQ8U/jd3XCBVSYALRjvzJAoFEZSGwf2zBAy3hHv07RkGicTzuucfj+R3oGdzKaGNCC37D9M4BEAWaqye8dE+V7SbC4kbwIlvN+VnVYwltwxnunjD6XxVgzDC/Lgv8bj5FyEn92z0Lc6xXtcB45AEEbsj2Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788827966; c=relaxed/simple;
	bh=x9tY5NrTGTdOUVqdZch24HkgkI261eqdG0zvp1MxLjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pTNkO2gMM0hMwVt3G1BMgaDG/VuSNL6gj4xb/goIUv9yWmw1+OjHBGzK55CEnOAcnVBN38dQNomNNRNIbgeQmLRCKKgZCDMxK/ovuk0QX2MLx7U8b9221TSZKIhUjTlAyBgf+KstASYej16fiIr17seLiiPKhpZTVYhdFSLkE2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFbjlqck; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFbjlqck"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593A61F00A3E;
	Tue,  8 Sep 2026 00:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788827964;
	bh=IB8TjTu51zZi5+A+o/Ci3RTBNi2I1Rg8Vn+qokimzlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EFbjlqckjWwHRy7sAg3tFjliAYP1XIJn9M9++0iG0574mWbTG4gVGJVT5EY4oAlnv
	 35ZRoXGvUXs7yyzv7q4+YTdHTfKA2SPwEKTUh3m/+Pv6pYn/mcMsDAZhXIlLWCdfq9
	 8uRPdm+nzOsQ7mGidDGXJ7ZskD1WxPoIjjpmbRgeYuErefG/FkiHT1pDWEfXBxXLJN
	 VKj/eNOnTNHR4U7JSi75j4GRnb4s8IJY6ZL4hl0sBtEbiT+TQ3QdscmotFwTegTVCh
	 KV877teSaxIpRhorAammnMnKEmBV3zRW5FD6RKg8HEKQOpCOABok7EJBkgvOvlqSLx
	 LLEEri2woMprA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>,
	kernel test robot <lkp@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/5] HID: sony: remove duplicate NULL check before calling usb_free_urb()
Date: Mon,  7 Sep 2026 20:39:18 -0400
Message-ID: <20260908003921.1609143-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908003921.1609143-1-sashal@kernel.org>
References: <2026090345-sizably-halves-2b7f@gregkh>
 <20260908003921.1609143-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Kosina <jkosina@suse.cz>

[ Upstream commit b328dd02e19cb9d3b35de4322f5363516a20ac8c ]

usb_free_urb() does the NULL check itself, so there is no need to duplicate
it prior to calling.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: e1cd4004cde7c9 ("HID: sony: Fix a potential memory leak in sony_probe()")
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Stable-dep-of: 7c65699a3a31 ("HID: sony: clean up device list on probe failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-sony.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 130237cd11306..621624c1e41b2 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1981,10 +1981,8 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		quirks |= SHANWAN_GAMEPAD;
 
 	sc = devm_kzalloc(&hdev->dev, sizeof(*sc), GFP_KERNEL);
-	if (sc == NULL) {
-		hid_err(hdev, "can't alloc sony descriptor\n");
+	if (!sc)
 		return -ENOMEM;
-	}
 
 	spin_lock_init(&sc->lock);
 
@@ -2045,6 +2043,10 @@ static void sony_remove(struct hid_device *hdev)
 {
 	struct sony_sc *sc = hid_get_drvdata(hdev);
 
+	if (sc->ghl_urb) {
+		usb_free_urb(sc->ghl_urb);
+	}
+
 	hid_hw_close(hdev);
 
 	sony_cancel_work_sync(sc);
-- 
2.53.0

