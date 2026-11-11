Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794367417;
	b=HhDL12LTUs/hmaaPDGN+IQDUIpvW3IgbhBYsA+WJc57fOwFAXzVVo+UVVvTdlhsKT668
	 ioFHDolAl90BKPifgu72AJ7cZlc0+PH5E40QE4FxqQLJo3iaPgum7WNtZYMIDTR8Ndhj0
	 XFXI1kqVYiHqsG0T9VSsNVPf+c3sRmlALZMwWY6k/3cwlwILGwja9sPB1wSnBAGTaYWUF
	 ipgAYdtpeMfEje0wDr8enI3uot3+OGwX+rUkwN329l3eNZtePldb4ixEt0jeis1R9PKeN
	 6IlU9qN/Nq+AWob36w7ZnSI7oI3q+zLI9iXJL4jLElgnjQWO/UpM4BrdAK/dSw2EPPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794367417;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=InCabWyNcaFOT+2V6bBtWvKsnMZvHo5u//wlbdNKNhc=;
	b=ZjzzjvWt4cCYWkhaxcCe+99jfahGLU1pY8SrA3J25kpacffdAH/dpcD5ozirj94cYAvV
	 TLhH60Y8lQxJ+idzuA8vvs4NLABS5rpqghvFZm3AuZCozOTAQp3oz6mKaUviiRdKgHzdN
	 ZuR/4nDjRlmIu8T1q3m4YJhGJsx+tDguiDryFKEqKOtLLOT/gXFLFrmiIXnYdqMqpxvS5
	 8y7gcVXNYSmstqXCr87M3hSOfMG4rnKhVoID6lP5BP18C6U6TNZuANmswCv7twpCFn2Bv
	 KItM297WcYTWB5gYIvfxjqn2n7jocPkO1+grcVz7BfOcOiYe3t9Prl55YdgpSAi3h+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AngI2+Bs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF6F606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AngI2+Bs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF0E1F00A06;
	Wed, 11 Nov 2026 03:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794367417;
	bh=InCabWyNcaFOT+2V6bBtWvKsnMZvHo5u//wlbdNKNhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AngI2+BsGFyua16swcasGJAuMYnlIMRgT43GVbxxoOki5EGvkSJblWdeU33w+yRdi
	 Xj8BFT0pSkSQZlfVWUWz75g8a6Cl8diAvgfGVC22sz52eO4zy2+V+/eMIMYPlmFtn7
	 3dDqIEZpejeahBG+mDs3mW/uwLrixAck8brvO4FUNbXtKXiR5xvl1SntT8A7vn8n22
	 8LprztGhIsU1AmNldi+2X17VJfWoVqgDPS7cNvdk2B/Yi6YeneGcoVs4V+AK9xGwbD
	 extONqo0XtsU0u2Lnk8pxhheSt+PQpgEad+WT1wkkw1cNfaWwZa0HyNLqPZuMd51cC
	 WCDMTrD9waFcQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexey Charkov <alchark@flipper.net>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] nvmem: rockchip-otp: Serialize reads
Date: Tue, 10 Nov 2026 22:23:34 -0500
Message-ID: <20261111032200.685592-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062035-failed-5.10-9fc6a1592d84@kernel.org>
References: <20261107062035-failed-5.10-9fc6a1592d84@kernel.org>
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

From: Alexey Charkov <alchark@flipper.net>

[ Upstream commit 9fc6a1592d844c0397f115ee8cbd935169b9a71e ]

The OTP controller is driven through a single set of registers holding a
state machine which has to be stepped through for every word read, yet
nothing keeps two readers out of each other's way. Concurrent reads
interleave, and the outcome is either a reader bailing out:

  rockchip-otp 2a580000.otp: timeout during read setup

or, worse, one of them silently taking delivery of the other's data.

Reading two cells in parallel from userspace on RK3576 reproduces both
within 150 iterations - 53 read errors and 9 corrupted results, the latter
either losing their first word or, in one case, ending in the two bytes
which belong to the other reader's cell - whereas the same reads issued
sequentially never fail. Concurrency is not hypothetical here, as six
thermal sensors source their trim values from the OTP and reach the driver
straight from asynchronous driver probing.

Guard the read path with a mutex. Reads are the only way into the hardware,
as the driver registers no write callback, and they always run in process
context, so a plain mutex spanning the whole clock-enable, read,
clock-disable sequence is enough.

Fixes: 755864feb729 ("nvmem: add Rockchip OTP driver")
Cc: stable@vger.kernel.org
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
Link: https://patch.msgid.link/20261002101329.1084348-2-srini@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ sashal: replaced unavailable devm_mutex_init() and its error check with mutex_init() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvmem/rockchip-otp.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/rockchip-otp.c b/drivers/nvmem/rockchip-otp.c
index 9f53bcce2f877..f1eea1f5b1f50 100644
--- a/drivers/nvmem/rockchip-otp.c
+++ b/drivers/nvmem/rockchip-otp.c
@@ -12,6 +12,7 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/nvmem-provider.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
@@ -60,6 +61,8 @@ struct rockchip_otp {
 	struct clk_bulk_data	*clks;
 	int num_clks;
 	struct reset_control *rst;
+	/* Serializes access to the OTP controller state machine */
+	struct mutex mutex;
 };
 
 /* list of required clocks */
@@ -139,10 +142,12 @@ static int rockchip_otp_read(void *context, unsigned int offset,
 	u8 *buf = val;
 	int ret = 0;
 
+	mutex_lock(&otp->mutex);
+
 	ret = clk_bulk_prepare_enable(otp->num_clks, otp->clks);
 	if (ret < 0) {
 		dev_err(otp->dev, "failed to prepare/enable clks\n");
-		return ret;
+		goto unlock;
 	}
 
 	ret = rockchip_otp_reset(otp);
@@ -177,6 +182,9 @@ static int rockchip_otp_read(void *context, unsigned int offset,
 disable_clks:
 	clk_bulk_disable_unprepare(otp->num_clks, otp->clks);
 
+unlock:
+	mutex_unlock(&otp->mutex);
+
 	return ret;
 }
 
@@ -226,6 +234,9 @@ static int rockchip_otp_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	otp->dev = dev;
+
+	mutex_init(&otp->mutex);
+
 	otp->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(otp->base))
 		return PTR_ERR(otp->base);
-- 
2.53.0

