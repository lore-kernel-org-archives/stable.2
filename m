Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047407;
	b=mH/tkp1MYCQux94wgi3mtb05bDr9ST9Hr0Ag1CukXUAyufycP1F0W5ujrJz5PjH9g9LW
	 n7+JN2qutlSqz+1lqIizffQSMmCthzOXOy75zTOrU3cAlYP7yNUHHvb2L7o1xAhMvn1hE
	 0We3xNdxcxnUJaicTpDkzW4xOJb35mPCBDUE6oxyPrvGpKJ92XOCWwvGVW1FY0ML5fd1K
	 yrxytjyH+51ky+mCxr2mW5DWkMp2wz2/Z9twsK+IWymW48/MjAWjm6IZnd86EMsf13+rs
	 oCmp+Qdw5vAQhEaokzyI7NNB5kHqzFMPA6vfGPERA6AE0IWIXmqjnTgUTcpxnJlkMDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047407;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=p6XXMiz7tKyOnOT0Jn3K5ZMP61I9oIOFDX+GyFp2+jk=;
	b=VJo6fcx2FgEzciDRzy3FCE4Xe5fcppXl3e7cC55erTEiXut6iJCttGQlf2cct/+ZvacX
	 gsiRgwSEUGkOthC4cT9K8AxSGQj3VR97bx1XicIT5Ua1LQhAW4ON3J+/R93dkZnSKCQNK
	 WYmLzUQgST/mTtXqwSYNy9NODAomjSU6eSCxYrM20SFuXXaWBGDwqcigWndhaTLf8TPqO
	 dNS0rgB95GHOCg4MMeyzAZTTpZdo8DMKIWxUw4hEe/Wn1isuR3REVxpDgaoPjlunoUo4l
	 M690VNBNHi9n9I76SNBpToD0I8IqCA83Y5guXG0zun19ix+lZ0ubwKOkcihWjN5QiYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BMyYSkva;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57798606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BMyYSkva
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3AF1F008A1;
	Sat,  7 Nov 2026 10:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047407;
	bh=p6XXMiz7tKyOnOT0Jn3K5ZMP61I9oIOFDX+GyFp2+jk=;
	h=From:To:Cc:Subject:Date;
	b=BMyYSkva8j1yzCzjvhtSyCGlUlwBQh/ks/O/Ehfg3gmRDKCcct6EE4XfHraACXyKv
	 hsXpMD08fk7lGHmbAL6NDpNBxtsXXrADHJSwVQ38GVS3EkODTMrGhR3lYjtFeMLlFw
	 P9PcAwGuNJJtdO1Xzoq1F++6F9kxuVj4y0BQ9batx8kgmHQhzQc4IABmDpfHFxibaV
	 mS9pmWCGMICsiXUe0TLmWIA6G13eECgT5wLkuGiGUBsV+oLkINqszcaJ9ii4j3YkgI
	 1labBppP3Cb0CsWN5mAUC1dVakhmiLu18ltfDMewlxf0mcjr6ScZu5nt9CuFbZ4uG6
	 wbt5CIxgKhaKA==
From: Sasha Levin <sashal@kernel.org>
To: lgs201920130244@gmail.com,
	dave.stevenson@raspberrypi.com,
	sakari.ailus@linux.intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: i2c: ov5647: fix power cleanup on remove" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:30:05 -0500
Message-ID: <20261107053005-failed-6.6-6e81cfc38548@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 6e81cfc38548109021ab761b94ecdd01f8753154
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053005-failed-6.6-6e81cfc38548@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




