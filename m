Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794363285;
	b=F15pJ1JCnKR6mSzb/7wCGpHsHJyltPVoslP7m5Ig2/ff3KLmrJI6zS8hTAd07tzpDO6d
	 FwHe3rn5zhMPFQ4vcF+uAnoJmYC1rWf09wJjbcc+ZJyGRyUKccIsLyz4z/enFsTi3msz0
	 z1bUYvKDzwSiMagDHwrF7R7XR7+LOLjOYa8MWz3mU88/FqYgxnc6V5afFbloDY5z90EXi
	 UrceDgvwbFvjApkfsEys4Pp4IW27K2zWwpTLvBvfGmfoVgTVBOXHh2q/0sVHbJ1s8RHL4
	 M+ibtR7mjSRbQ0YyPp8NlJt6oFMUcQuY4lvXIi3t8dM+Tygvnb122me+qPB7zxJwPLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794363285;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=IHtpkSJ4tmv4FmSPwIfp9A69pqYwvlBhguh3T+SGa0c=;
	b=LiFaM3HPdSypbNsIZ2YVurp4/SR2oCHRWxVPkQWKea9GUkPfWwR+zIrW5ffClHjCnyG/
	 vwHDKe5KOrT2t3MoH1Ggm4gJD5NjbW5YkvLn2HzI7TrJ9N6s54WGXXWvoJQvqAti3TV/w
	 ihx/wUSLV9nxyITlV9QaLxu/ei3NBFj6PnSGKljB4Da4UzfTSPXvOzyfHatUi9XM0hXA9
	 XzizilK3ym5qeFJxz55apiwdBplZOiCJP4BE3CH+k1hxdely1SgBfEDgwveWYbVQz9AdX
	 ajiAdDa2euua7g8lhVU7D/zBlLF2pHMi9I91k98XHqs1ZLYDBP1uvOcY+TpH4FvZ0dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LfiT281V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778EF606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LfiT281V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A02E91F0089F;
	Wed, 11 Nov 2026 02:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794363285;
	bh=IHtpkSJ4tmv4FmSPwIfp9A69pqYwvlBhguh3T+SGa0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LfiT281VsKWQzo4uRcesTdxzqWe0MLC7aMjk8W9+Z/qFScImzDX9oYyL4LKvyC+DL
	 9H2bHlw6P0Ur/iOXq8vl/LcIknb3DeXF4gwqjxgux11SzKax4Lj+Q6wwnRploJy2xs
	 NenhrC+C57dDaI500cgye98TXCRBNNCYd6+GC3sS+w1Jt0g5TI+cnDjtH/1j6y+u3K
	 ITXtKgXc5WOrA952F5IuICmrDUOaeOf59oYkP/WsUDFeKjbsBx7qZcrTeTBGjmz3Oq
	 7atuIz58O659VOc7hc7ZI3IjMu3nlFaJ4tNa5Rg6Wf/cvDRskrAA9Y2NDNHnVNIMHQ
	 YzAV8eWeN6Jbw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexey Charkov <alchark@flipper.net>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] nvmem: rockchip-otp: Serialize reads
Date: Tue, 10 Nov 2026 21:14:41 -0500
Message-ID: <20261111021433.580869-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111021433.580869-1-sashal@kernel.org>
References: <20261107054624-failed-6.1-9fc6a1592d84@kernel.org>
 <20261111021433.580869-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvmem/rockchip-otp.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/rockchip-otp.c b/drivers/nvmem/rockchip-otp.c
index aaa044bb231b8..0fb8d6d800bbe 100644
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
@@ -66,6 +67,8 @@ struct rockchip_otp {
 	void __iomem *base;
 	struct reset_control *rst;
 	const struct rockchip_data *data;
+	/* Serializes access to the OTP controller state machine */
+	struct mutex mutex;
 	struct clk_bulk_data clks[];
 };
 
@@ -179,16 +182,21 @@ static int rockchip_otp_read(void *context, unsigned int offset,
 	if (!otp->data || !otp->data->reg_read)
 		return -EINVAL;
 
+	mutex_lock(&otp->mutex);
+
 	ret = clk_bulk_prepare_enable(otp->data->num_clks, otp->clks);
 	if (ret < 0) {
 		dev_err(otp->dev, "failed to prepare/enable clks\n");
-		return ret;
+		goto unlock;
 	}
 
 	ret = otp->data->reg_read(context, offset, val, bytes);
 
 	clk_bulk_disable_unprepare(otp->data->num_clks, otp->clks);
 
+unlock:
+	mutex_unlock(&otp->mutex);
+
 	return ret;
 }
 
@@ -246,6 +254,11 @@ static int rockchip_otp_probe(struct platform_device *pdev)
 
 	otp->data = data;
 	otp->dev = dev;
+
+	ret = devm_mutex_init(dev, &otp->mutex);
+	if (ret)
+		return ret;
+
 	otp->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(otp->base))
 		return PTR_ERR(otp->base);
-- 
2.53.0

