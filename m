Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048168;
	b=ThQbckfJJKR8o1+2yasFd2KBS1bXbpKZ9kc5XIYT+NNdJzfLGktzqA9HchKm3M1HEdPc
	 m3nXYNqrZ7X/O5P5q8XP3oHC4BxynjV3F9oUc47LOopR9YZRR7s+0FoPBz4ZBY4a75Rky
	 mchWASD5fZlI9w0m+VZFm8hDSBUw7tboA64S2VbHm148ZFarYLWLSe4Zs4ak6Hzssmrg4
	 I9rbbhftSF3cCx9wHxIXFpbuQ6aAznHYUBh4ottpktLC6btTbcjYtkA3PiLNZXZS3g/zZ
	 1aR8kGbKZm4iU8h3DwWTKZuhJ/MZnWztt9GvQpnTJg79n1IOO32jfDRmhSyRI5D66ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048168;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=9hxXrdhGyHrOTjGH1r1aJdPZY5Cg5ZAu7DmTKnzyqlI=;
	b=1k2CEOUQQTB1zg3fdbUGkTUkRwxFWV2XAAcjGMD8jZ1HYGOidZK0imOctMAk9BFbtjBI
	 y9esEgCApbBnvWYfPBoBHedti61TkYUU5pssU2uWwnwEEvAN2jcVRv3iTuhSThTGyi8CW
	 hq6ka/3C2v9bXRBYIY/69xQwB5KFt6oNuHFzXcUGiHQDnxIZHfOzhDeafSBKdfkVo4nWP
	 +nP0dKdk5E21Fd4Vb7FvbVrKAhWrq0Hbz4wxxArD0nZp7rBvR17enMk/8YbAw7GT3Ne8v
	 hkNSIFB0BMUhlwdtnNez0vc/qznM779f+Tw/CP1vkZtDFG9IXmaPDAy2fvJ9jDsqIhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OkgfQQHT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C21A606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OkgfQQHT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728011F0089F;
	Sat,  7 Nov 2026 10:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048168;
	bh=9hxXrdhGyHrOTjGH1r1aJdPZY5Cg5ZAu7DmTKnzyqlI=;
	h=From:To:Cc:Subject:Date;
	b=OkgfQQHTqyOkjsZiF0boqzMQJ9kPkr6vfXtB1zM1y3C7J7XSlSePxseIkceWTw1HF
	 LYRmETQCScbCNWIKrKVyULa2L0LmdAtMzxFhYNdVE4Xg+zkB5W7+9AjXqtNlhcpqsM
	 mKkkmGYka28QnSSEd0HGvgb73wBEcO2trr1CcrnZ1+6DhDoIqMEDPR6a0I/xtIhuZW
	 8eso9IQb0vrTIIFyleKm9xNnDDBc4G7GYCVVz4mLxA9RpzY3vS4g6I0Xko38EMN7HW
	 /XN1Gfkl5BNh4CUhLAOcO1k1by6Z5zOdy6J8gufitl/1jvOzNKRdnrPLYJJjwNSbF3
	 8n33Y+LfdK2aA==
From: Sasha Levin <sashal@kernel.org>
To: lgs201920130244@gmail.com,
	dave.stevenson@raspberrypi.com,
	sakari.ailus@linux.intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: i2c: ov5647: fix power cleanup on remove" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:42:46 -0500
Message-ID: <20261107054246-failed-6.1-6e81cfc38548@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 6e81cfc38548109021ab761b94ecdd01f8753154
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054246-failed-6.1-6e81cfc38548@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




