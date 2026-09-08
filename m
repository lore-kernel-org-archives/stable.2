Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B9E23394D
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 00:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788827967; cv=none; b=rCLNhWTTl361UYTswh6yrdgvPmdDVB2Pvhn1QcQSPsGvk4SWyad48TfX1kg0T9OeR+lhpqPWE1fmP0xgwaMJVl9miXZ5zXte9jyzwwbpc8ZPKhusLmlVDDf/pvjXblOY8wJT2820ZiBBsZViiHU8sstd3SNwh610XZbKSmA7jo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788827967; c=relaxed/simple;
	bh=wHGNhUcS9Yre3DeYBhY0wWrXDhzjqHdjN+oXt3yvj7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BSAw72ZMv3iOtdOvFbZuSS8VGK2GM/fyOHg8eH7i7DHY9uLlMFEKPdIyF5rpfUsSEJjZOxHujEHb2TbwlKzAcEdntMHAKNUZRhzyr96B7A3vaRQ5wZstvoJVLW4YH2QZen9j8Mghw1Os8DvqUnkd1lCKFVHC7MP0cre371XLKOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=momL8LTv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="momL8LTv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADDB1F00A3D;
	Tue,  8 Sep 2026 00:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788827965;
	bh=rBKH1KVKZHZMRiW14XkhWGb9i1yYF+C6LljN+6zFkrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=momL8LTvU8vlV1mWZSoYgUKGpv6Bbdb7uU/nzIbEumV0BNo9LPG13TC7ubUkYEofE
	 SvkVU1s8QdepjmWEqaSbFTHtW+2i4aoz4474hMyuIW1Rl4j1WvpU88bTMlKZqzjtju
	 PPOYKQ8ToxsUkjj4vzH1RkXOIa4osS5tKD80iTqvxnW6V3dkTiNvFc8rUW8G9Kjq6l
	 IYghN6z+jH5SR5ueJMsfWMhGiW2NySdKiPN7CNoT/Rqt4DInDOQWaLRbj/64uZi27x
	 xVpRhPAMWHgFCDSMs+OTN5ldEXQG9fhtD6jqwCfGbLTr74q/EBHafCMMtxgr+pbEs9
	 bjn26M1Udz4lQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Colin Ian King <colin.i.king@gmail.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/5] HID: sony: remove redundant assignment
Date: Mon,  7 Sep 2026 20:39:19 -0400
Message-ID: <20260908003921.1609143-3-sashal@kernel.org>
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

From: Colin Ian King <colin.i.king@gmail.com>

[ Upstream commit 4e124ed0da2939dcd27849a3d6f41fbc537a20be ]

The variable ret is being assigned a value that is never read
afterwards. The assignment is redundant and can be removed.

Cleans up clang scan build warning:
drivers/hid/hid-sony.c:2020:3: warning: Value stored to 'ret'
is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Stable-dep-of: 7c65699a3a31 ("HID: sony: clean up device list on probe failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-sony.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 621624c1e41b2..182dcd7705862 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1928,8 +1928,6 @@ static int sony_input_configured(struct hid_device *hdev,
 
 	} else if (sc->quirks & MOTION_CONTROLLER) {
 		sony_init_output_report(sc, motion_send_output_report);
-	} else {
-		ret = 0;
 	}
 
 	if (sc->quirks & SONY_LED_SUPPORT) {
-- 
2.53.0

