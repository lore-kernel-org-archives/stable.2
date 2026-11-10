Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311453;
	b=5CwKbonPYcgnFElt5QORm6wk4kpY/XCxICt56M4gyi2vulcDBqHMaM+uUlC8aC+sm196
	 /6u4Rv+D7+15kD72dEUBbDMOK5h6aK2wklshvA7m4lPNs0fppZ1KaK4V8IIZlRQQN7ptT
	 p0we7NbdmzBjaqdxVGCw2w39fUu7wAF1JNbPiLrRnLnW/HuJcBT3oRaBfTm+/bKs7AECF
	 opl80V0seO4ltJoabrYwmjI0MdzqArFrJpWmYB09Gdf2CbnTlQUhcrlAF8X5xaY3x3jzh
	 KHCTiH5guk29iUjEVkGugVBJWBWfIsp1JO8rA3dBfl9Lf2obddX59XPsloEXUJ77FZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311453;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Cn/vYW8PTJ1H7zZY2cQ6KQyBPITXLpl4KZYPJi+O9Dk=;
	b=0w01k6bAEH5VGmbEFGHHiAhNQ5ywmbkpxvRfpS6Sg90q09rVUV7FlrzTPH7m5OVv0QFJ
	 RjVtapjBPDjdHG1j3Nq1MBxoaywnDX1RKQoFe/jWxSY8nO3Hw87+SkwHEwHBpL6mogRZk
	 4A4AjFrDyNWkx98xTr4J76FEnIC1SSHXf8qKuWLZiakojFarGMz4dzM2Z2c73Lp5Ixp9n
	 uwdNAxzZXR4QE4naBVO7eLSLAKTSdEOfCQ1ix53oTMO/Mvmf5Cg0wwdX2FIsQGrMahOKe
	 ZRHyZL2gFGDevQEwXIAzl0ydDfjHjgACcV3fsnBwrgpDl6zYXqHW0Rr3VpqD537yaIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DwMb7lqX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFEB606A338
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 11:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DwMb7lqX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7102C1F008A1;
	Tue, 10 Nov 2026 11:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794311453;
	bh=Cn/vYW8PTJ1H7zZY2cQ6KQyBPITXLpl4KZYPJi+O9Dk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DwMb7lqXDY4pjdgOtE0B6xLzBdA/HU+hV1uHTA1Idahaqjsc1cOnuOj6S1D+IbKPU
	 0Lf7opcEje+YBuzh9ta+KdhmQsCSNXMazgYlzxpcE4w3gT2PZ+wUQ0/LNmcNJ0LH8w
	 TuagRmCoOuqjGnzSM49CwQ1KDQHutNUpMXNj6CX+17VXDczxQhPnAv6hj8utj03RA8
	 G53NYwQabngIXE4HdEpEsizEvJcX3pqXe4BQ5Wj5mpjTXq0nfN8iE9rfMStywmsifG
	 iOVm+EVE0R2uB+wJYZ1OdL556YvtE7guMVu7Cs2N1lynhH94FuEzLcHrSG+CMXdIyg
	 XySPJOe+zeZ0g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] media: i2c: ov5647: fix power cleanup on remove
Date: Tue, 10 Nov 2026 06:50:51 -0500
Message-ID: <20261110115030.864441-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051738-failed-6.12-6e81cfc38548@kernel.org>
References: <20261107051738-failed-6.12-6e81cfc38548@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guangshuo Li <lgs201920130244@gmail.com>

[ Upstream commit 6e81cfc38548109021ab761b94ecdd01f8753154 ]

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
[ sashal: adjusted context to account for the existing mutex_destroy() call ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/ov5647.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/i2c/ov5647.c b/drivers/media/i2c/ov5647.c
index 305677913a0c3..3e7fd8f28df3a 100644
--- a/drivers/media/i2c/ov5647.c
+++ b/drivers/media/i2c/ov5647.c
@@ -1481,6 +1481,10 @@ static void ov5647_remove(struct i2c_client *client)
 	v4l2_ctrl_handler_free(&sensor->ctrls);
 	v4l2_device_unregister_subdev(sd);
 	pm_runtime_disable(&client->dev);
+	if (!pm_runtime_status_suspended(&client->dev)) {
+		ov5647_power_off(&client->dev);
+		pm_runtime_set_suspended(&client->dev);
+	}
 	mutex_destroy(&sensor->lock);
 }
 
-- 
2.53.0

