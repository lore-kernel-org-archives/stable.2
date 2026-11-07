Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046037;
	b=oUWXtrPczucZEp3Rb8TqgAGXtzLqaxGbomwEUwGzGLy1rWPv6z7HgaNBQMK0bn7uajlq
	 zGrR03Uf6VN8gcNAPG44PuYIjkeG3BksE/oYSCez2idbRlk2Rf7ebKHO85xCvxtshmRdL
	 8msBuX6QoY5yUU86I5zG+cv0UhsRBmqPp0IpXS7ZhxKNJ3lqxq7JqUlNscsA1LkJrFs6U
	 yOq+a0yEukSfVS9zpzkJmAv3IkZPPUoTejEGIQIbTkc5U4TBLxMTcG0FoAMm4wg9u1cFV
	 GWicZ4bocly5gEmuPlDVLztL71ey096L8UwnTSdD8vl1HH1L6KU+dGZxCN02sVM+tqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046037;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ycqvDzp2i/IUESNV0DNwGgBLGOArU1uPDD6Bv6mkqkI=;
	b=5NcC1Q8glye24Ae4Sjzi2OEsjbDtiNx8Ioz9hpLuUUpQ9AID45rtEeQlc8O+ToJ84OrM
	 ZdGlQN8uv1Dk5mkvnRK+lDvOtgPekzn9G7qjc5Erllkrdwmq+1efh4CfuBpxsgzEOmNU9
	 Q/xO3c7aUIApMKgJ0bQDemR71jyHujb0dDigixtmqIMtrKFsaJDKd3xiRVMP/NZ2U06Ek
	 6NR/jpipFIroJ8lJeWMaIe8vTbLMqZxm/sEc8Akf7WTdKLAaBfgEqk18gKe3sVywImQlS
	 Co7KU+v+IZY5g85lZXYXrhqlwW43AW7x0DBELhoQAAXMGczRYIIpM3rrU5rCTkadnMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LkYBftur;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF18606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LkYBftur
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D581F0089F;
	Sat,  7 Nov 2026 10:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046036;
	bh=ycqvDzp2i/IUESNV0DNwGgBLGOArU1uPDD6Bv6mkqkI=;
	h=From:To:Cc:Subject:Date;
	b=LkYBfturdIxivQoVoaXsk2L4zhhALMJ3zQR3dyFKeFYfT7xc3KNNB4CbJcfj1A+/z
	 FACnrErhRrgGpw2FQx/wG/FgEkmRAE+dUnD8WmkHHn1OaTu9Cd5upKHhW7BCfyPF1k
	 wQK8O7QjoLGflv/bW9fj5+66kqEYFnenCjkhu7/7hLDJWjzBV8KEkhe97UqbMG4uZO
	 Cnr77+ha1Kx53C2l0p53rxJcH7wQmhjPK+PduouI8yw4Ygsqu7FPbdvQUOFLzaBRDa
	 FVo5rEHUzY0hVArkwr1orxY3hp4inInEG0JXLRzlgwOFwtmaHXemrurIkg0DKsD0fk
	 btBx6dxC79+iA==
From: Sasha Levin <sashal@kernel.org>
To: lgs201920130244@gmail.com,
	dave.stevenson@raspberrypi.com,
	sakari.ailus@linux.intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: i2c: ov5647: fix power cleanup on remove" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:07:15 -0500
Message-ID: <20261107050714-failed-6.18-6e81cfc38548@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 6e81cfc38548109021ab761b94ecdd01f8753154
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050714-failed-6.18-6e81cfc38548@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




