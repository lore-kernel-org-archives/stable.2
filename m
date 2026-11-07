Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049201;
	b=unsODUT22ZWtRSGg0oLp/H+YsXdhgo6HvK2ckjwG1Dn9rzVvNSuajm3s8dJRoABqwXZA
	 TwC8N1gVUtyylqPmo16mqch4NliNZxdJ+2RYMCcygY12QhEeiAheIdsuBdgB6m4NztLOj
	 jsuQEg/dVEBNIrFl5eoMKJWgtFwWnP/1p1miNp19B00+Er8G2GLEx5Q9mUTFUun/3jIM2
	 OBToxVjtS5riidFhO2wHWVKE2P69q8yK11vvuSDxIGQ96v0TYVgWH54qTQ8Ajzq8jqff/
	 noc6+Il4HLMz+E7viOjKVnCPyzC/ytUNO3yspFn6EhVoWvVqsawhKcLO6nfF2ygk35A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049201;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=A25EProh8+PwIb7grCzoga5hNlMdugUHzHQ8OEhxNa8=;
	b=E50+QZ61tiCrk9EGbyY6CP3ULXSUw84iGbINcvCbTOYz4T1sGLOQhqdM7+l74AFRif2x
	 TPpMEWzRofT4Jp7BQ/JPYXPQocLh7o5yW9GhmCh4FQxSACX4rygTdulRbNhOY0p3Sz+Jj
	 zTXyjvzBUYE9d4Mhto5Fz6en9ZbFIxFDNtsFJDabJg/cWUhJ2TZ+CIqOIEVbMZCGxoGqE
	 lQAdvu0RNChIrqoSK5wlB3SWoyxMljJHhoLGI4jBDwkBrDNCePma0quch9wqw+aG8DFpC
	 p8u+jia6IYJQZsxFbd0p9Dlzy4NFw83YUo7rWMxCHBpKZRL+3wzkb+lJuEY86I9ZDBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qyy3HbEx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1FC606D80B
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qyy3HbEx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0BF1F008A2;
	Sat,  7 Nov 2026 10:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049200;
	bh=A25EProh8+PwIb7grCzoga5hNlMdugUHzHQ8OEhxNa8=;
	h=From:To:Cc:Subject:Date;
	b=Qyy3HbExug4f+P6VaP3mP0x36kM6nWhVJXmtcnHD4QARdaswD0jCS2QH234aFZfQN
	 AG1makZkXqpzFiSJaCHkQ60/nAqzcE0eERVpsJmHMx7MYDI0QLMld7iRAzUoHj1bPM
	 NJV4qZpdIiJgXrUU3JinwWgoiJxXP5fr04HyY4Oq/36nybmvIq7wb9NU25osgwNzvB
	 +72816zK48nDSgpX8HADjHtBinKWivi5WLLSt5lUP1H8l/8FpAh4EyAFmWza6Isj5O
	 oTv9ojJOoEvfwD1QyCxk434rUKmYVnGkEb4OdJXZ1PrtdTTzkvJRmk9c/1Fl8+XcW5
	 VYBoSr6P1IHTg==
From: Sasha Levin <sashal@kernel.org>
To: lgs201920130244@gmail.com,
	dave.stevenson@raspberrypi.com,
	sakari.ailus@linux.intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: i2c: ov5647: fix power cleanup on remove" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 05:59:58 -0500
Message-ID: <20261107055958-failed-5.15-6e81cfc38548@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 6e81cfc38548109021ab761b94ecdd01f8753154
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055958-failed-5.15-6e81cfc38548@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 6e81cfc38548109021ab761b94ecdd01f8753154 Mon Sep 17 00:00:00 2001
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Tue, 22 Sep 2026 16:40:09 +0800
Subject: [PATCH] media: i2c: ov5647: fix power cleanup on remove

ov5647_remove() disables runtime PM without powering off the sensor if
it is still runtime active. pm_runtime_disable() does not invoke the
runtime suspend callback, so the sensor can remain powered on.

If the device is not already runtime suspended, call ov5647_power_off()
and mark the runtime PM state as suspended.

This issue was found by manual code inspection.

Fixes: 089b7c70f0d8 ("media: ov5647: Use pm_runtime infrastructure")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/i2c/ov5647.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/i2c/ov5647.c b/drivers/media/i2c/ov5647.c
index 4824013454f59..e1120ca688283 100644
--- a/drivers/media/i2c/ov5647.c
+++ b/drivers/media/i2c/ov5647.c
@@ -1273,6 +1273,10 @@ static void ov5647_remove(struct i2c_client *client)
 	v4l2_ctrl_handler_free(&sensor->ctrls);
 	v4l2_device_unregister_subdev(sd);
 	pm_runtime_disable(&client->dev);
+	if (!pm_runtime_status_suspended(&client->dev)) {
+		ov5647_power_off(&client->dev);
+		pm_runtime_set_suspended(&client->dev);
+	}
 }
 
 static const struct dev_pm_ops ov5647_pm_ops = {
-- 
2.53.0




