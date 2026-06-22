Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFB639A801
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 12:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782130480; cv=none; b=p4xwmKHLwdKtmHSBDoUlgMb+Z261G3NBT6EgKkDeb3SgFa5ubLMYyxBgs/yros7FLJQvh7Wp11sZfvGb0Z3B/wgFHXrXwVETauGsQAL9yvEKZglntVU602XaOpbEfjEA+JGrWQ0ZzQnnMOofaMUXVTWUp5N606uhVgB7HHVzSVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782130480; c=relaxed/simple;
	bh=Je4ATXoR4va71A2ZAIetqA9Orlr2fNUDHK1Gq/4Bdgk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fhe04MIqabP4ltTZw7fKL9hv91dZs2b0ci7Z4YV/1Ts29/u6vkP8GeKhaxEtmPjyMOjOpf6qQmsseV8A4REYIG5WQhi3MQ9U0mqgBlMlZsbqDqjG98FUqSZNajxVvViEl79VKX5sNF2z1YHSdmj5o1U4MrDaw67RQPj7wdnC/rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsNT3tok; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsNT3tok"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84229481d44so1902591b3a.0
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 05:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782130477; x=1782735277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O5sfJNmc1yKWdZTqu3HegJ66XvBTGvbaI9z9chRhIF0=;
        b=YsNT3toklcqnrjz20RrfSZL6/5iYNoLG7wJbdlaM9HUPMpsDRifJ+bn7q0cRTeMTyF
         ieL3++lq8vfJckHuvRNloJWS1nzZYNSjt6m+QZxc/GSVEhplLoWz0YZxAhB21p0SgyKc
         F0bycQ3O/giPHYhPTLc6++WnlQRmEZv5SrztNLh09lPsS2Fyz3mQpK7O7w4DVquuqsgX
         vSWxfHld3XDLu+7O8k0DYN0JMPtK+y7q8o3oLLOJaVUaE3YGNaSJ579HihdqEs3i6X4l
         ZAitQm3r5heFIXo5W1ZS5lo9BuPeizfF4GmXEQ6S7WBgMdFj7T24ybXLGwpIi50sQ41y
         79Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782130477; x=1782735277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5sfJNmc1yKWdZTqu3HegJ66XvBTGvbaI9z9chRhIF0=;
        b=qxEEBefRXIHrh98yA8GNHW354sVf7E5hZJp5BHjiWfMnZ82gUgNcEqnzCiFmtGUQoi
         x3EYkGspLx5CeeokHVTeOjSfC0ZumliW15p1TMl3nENTLMzLK9pH7dX3MdbmumcK/NtQ
         hvLxEZQon19S7iZDcJszGa6V5d6Sag4gqSxegJBDGMBNNrEyXLaIWMnev62azrGfGl5x
         VRkimErwviEXm/ZpHv8Nn45N/e/ZWqGqyOKHUrFdxb7WzE+NHfNSY2NKyG3zZPuJE2kq
         vtZEu0zXmtui4vn7ww7RKJyyNqEbS/agQlEO7aDYHKSXeFJqvdGRrRJi7X7UDJoUBWv+
         E8eQ==
X-Forwarded-Encrypted: i=1; AFNElJ+4n5tELKscE5GzOOJAYv+M1K7uy54pDStrEBoW0tdtwXyJ+UultTlE8Qmnxib3lAD5B1czWbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXwn/1qOFKEp8UWa4nUTrYe7IzIgZODSOcG67LwrsuV11tX++/
	YnAEnNY6mGZkb5/SwQgWVCGkkTNHizRKtK0PL1Qb4OSBTzCSzfJYxwY=
X-Gm-Gg: AfdE7ckc7F77WMY1i9mWOvENeH909TToMRNx9QxE3nBl+IeSCfe8ivjwm53w9HRXw5t
	xUIVIgeji48RroZmgYHmTo1JkU9b/Cfh2II7c9Cs/xZIunhwuqnCRxiWjq7UHsZKYW777In2uWo
	bYJdIuE0JJzdAwaq5pF6SMt8ksJvwTNR5kFhSXNnE+69aWBE1ZTtie0phpxkpB1xao6TxWdP7/b
	HXQlUGGgiwrB6nV/hZiAIG2EJwsCZ2uo9Se5BBOZr6LYR2eOw7RkAB1wsDCbHm2mvtwo5KWq8Hv
	87WlojEUxOhpRNqBp0FJl7d+U/qWUEtpScJ/heDzk1FtJCWmnUdZMI4vynojEmt0+AwwiMNwHcF
	hQPewO3Q6OVHWe12ztqkcV3dDY/vS2OLcC3IU6EZ3BRC9k+qFgV6e3maPxyjGuCGIVewBA0sIGo
	z+7R3MiUMqyEeXkNscD/2UOtAbrwXd7YsztmOmKV9Ci1TGJbMNzAldgcK4Dlf0WQEA
X-Received: by 2002:a05:6a00:94ee:b0:842:2419:6c0b with SMTP id d2e1a72fcca58-845507bac4fmr14675413b3a.10.1782130477449;
        Mon, 22 Jun 2026 05:14:37 -0700 (PDT)
Received: from localhost.localdomain ([14.5.152.27])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564d8ee89sm7046238b3a.20.2026.06.22.05.14.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 22 Jun 2026 05:14:36 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
	Sylvain Petinot <sylvain.petinot@foss.st.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>
Subject: [PATCH v3] media: i2c: vd56g3: Clean up subdev state on init failure
Date: Mon, 22 Jun 2026 21:14:29 +0900
Message-ID: <20260622121429.47765-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vd56g3_subdev_init() calls v4l2_subdev_init_finalize(), which allocates
the subdev active state and requires v4l2_subdev_cleanup() to release it.

If vd56g3_update_controls() fails after finalize succeeds, the probe error
path currently skips v4l2_subdev_cleanup() and returns an error. The driver
.remove() callback is not called after a failed probe, so the active state
is leaked.

Move the control update to vd56g3_probe() after vd56g3_subdev_init()
succeeds, and route failures through the existing err_subdev path. This
keeps v4l2_subdev_cleanup() in the common vd56g3_subdev_cleanup() helper.

Fixes: 87aa97fc3157 ("media: i2c: Add driver for ST VD56G3 camera sensor")
Cc: stable@vger.kernel.org
Assisted-by: OpenAI:GPT-5.4
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Changes in v3:
- Restore the capitalized subject summary.
- Route vd56g3_update_controls() failures through the probe-side subdev
  cleanup path instead of adding a second v4l2_subdev_cleanup() call.
- Add the Assisted-by trailer.

Changes in v2:
- Use a lowercase subject summary.

 drivers/media/i2c/vd56g3.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/media/i2c/vd56g3.c b/drivers/media/i2c/vd56g3.c
index 157acea9e2..39fb14bab5 100644
--- a/drivers/media/i2c/vd56g3.c
+++ b/drivers/media/i2c/vd56g3.c
@@ -1388,7 +1388,6 @@ static int vd56g3_detect(struct vd56g3 *sensor)
 
 static int vd56g3_subdev_init(struct vd56g3 *sensor)
 {
-	struct v4l2_subdev_state *state;
 	int ret;
 
 	/* Init remaining sub device ops */
@@ -1421,15 +1420,6 @@ static int vd56g3_subdev_init(struct vd56g3 *sensor)
 		goto err_ctrls;
 	}
 
-	/* Update controls according to the resolution set */
-	state = v4l2_subdev_lock_and_get_active_state(&sensor->sd);
-	ret = vd56g3_update_controls(sensor);
-	v4l2_subdev_unlock_state(state);
-	if (ret) {
-		dev_err(sensor->dev, "Controls update failed: %d\n", ret);
-		goto err_ctrls;
-	}
-
 	return 0;
 
 err_ctrls:
@@ -1452,6 +1442,7 @@ static void vd56g3_subdev_cleanup(struct vd56g3 *sensor)
 static int vd56g3_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
+	struct v4l2_subdev_state *state;
 	struct vd56g3 *sensor;
 	int ret;
 
@@ -1517,6 +1508,15 @@ static int vd56g3_probe(struct i2c_client *client)
 		goto err_power_off;
 	}
 
+	/* Update controls according to the resolution set */
+	state = v4l2_subdev_lock_and_get_active_state(&sensor->sd);
+	ret = vd56g3_update_controls(sensor);
+	v4l2_subdev_unlock_state(state);
+	if (ret) {
+		dev_err(sensor->dev, "Controls update failed: %d\n", ret);
+		goto err_subdev;
+	}
+
 	ret = v4l2_async_register_subdev(&sensor->sd);
 	if (ret) {
 		dev_err(dev, "Async subdev register failed: %d\n", ret);
-- 
2.50.1

