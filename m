Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046660;
	b=mixttBCFB0Lk11AZBYNe5VVc+X/I/jYC/zMRd70szTVZZrUUqjETnEOvvJGZ9CXeVOXQ
	 3ETVPrGREqF1NTf3v8jczIOfhB1zDzvUaQj7lp/T7FZQCgFS7Wu4Xa7prd0EOcPqW9iIo
	 N1I954WSZHp+02g5kOv6a9Ozl/id4tpSJGrXt7DDNKMausP3auWjIkUcuBFJbpmV1qtIq
	 9WYjUr9GQGzCtU1BEe2LqUBfbb5Dk2PNxMX3DL/VJwsKkTv2ehb1Tw/JGapJamG0j88cq
	 FlwioNdvoKWebDAhkyNnNgw7h1lXHp3RvySpQiI8VLl2ebwz4yRxyOJY4Wtxagbmolw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046660;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=JX+dAlogNwvw7Fkix5+F0w9Js9MliAJf79CIXyk4cTQ=;
	b=mYoLOZf+qa2vJcWz6Db5F4S5DEiMT+UZY9bO0UYxpUWF4dDQVJ2cyPINF3qCEneUB4S+
	 tcy2IymiUhjlQ9g9Zoj2vyRxMW0rlJyUdzu6BLq/pKx6q0BKCJS7QVgNmdK6FxRoTdPJ8
	 nCVma/SuKQrPT7pzBfWj8X5y0BXX5dP+zP+54pS3EYNTBBI3hpR0CtqjDRP/Rg1jaRDyo
	 B8jMDn3qTT86kfY5F7kXhr7Kklj+1EbgK0NXpv08+oyNRlyjQvUgrCa/ODqvRshfRSmRy
	 NOINSzFpwS/L0WHdI06JpW8naI6fU36aEVhiThi3do9R7oR+qufSjzXKzX1lNWfjXOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ho5C+7Sy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28525606D820
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ho5C+7Sy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E121F0089F;
	Sat,  7 Nov 2026 10:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046660;
	bh=JX+dAlogNwvw7Fkix5+F0w9Js9MliAJf79CIXyk4cTQ=;
	h=From:To:Cc:Subject:Date;
	b=ho5C+7SytyuScYk08nhOiiwFUTPqqCeKcIO+hqfi0L7K7UjvZ+jhky0nE9Q9oMTAX
	 fBUGnvshOPY/D4guygvwHg1Jd241niDEcZJXa4yPkhz/Rn21SNpZ2VkiOCvT8vTAtA
	 GVM69uEnfaBnrUVyFfcWc4N9U7FGwZryjvM1l+1UjkZhgfr+Z0C4y0Lsl062eeocLZ
	 cY9gmFJppHYMPcEU9ry8c+nXHNfuMatVmyAHocJdZ5GJnA+M57LKHBn0oUF/vots6s
	 jE9du+xvLSryPOfhuXzZqSg3GdkNHX8094jX0VPF4QQzG/sXMKO2wH/FkC/Uuca1Qk
	 c2Pj80QAsaKfQ==
From: Sasha Levin <sashal@kernel.org>
To: lgs201920130244@gmail.com,
	dave.stevenson@raspberrypi.com,
	sakari.ailus@linux.intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: i2c: ov5647: fix power cleanup on remove" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:17:38 -0500
Message-ID: <20261107051738-failed-6.12-6e81cfc38548@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 6e81cfc38548109021ab761b94ecdd01f8753154
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051738-failed-6.12-6e81cfc38548@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




