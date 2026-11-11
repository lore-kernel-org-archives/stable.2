Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794363553;
	b=UTpz6drL6IpQaaoSuM6jwpI9ETUvunR1kp56+A5D37Sde9e5DFOYNaXqtik5r1tXoSLk
	 HXGH4sFZjRri/d/K0aV8w3+EpO7E3+srPBZemz1AiFb0mHBKUV1mTF77nA0eORIqAZX/4
	 Jj9QCxAxy0p+BAz5PL0oBxqUHx3GG4OAneIgSNpv/kmJYNMY8fNjjZsC3PF8GwkF49WY4
	 NJw6Gk2xOKoUHk4dAi8TODNlVDhFG6ddbaxqBMqHQLtDtr09EdEI8fCWESxVOdeJCc7DV
	 zUS8GtXpLn0vizmE+CXwl/9Huec+fnMrYKHxO5390i1v1k34084STacLTOiyXpU8wPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794363553;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=IHtpkSJ4tmv4FmSPwIfp9A69pqYwvlBhguh3T+SGa0c=;
	b=gIflofH3YIGKNL1QwYyAlj+zOnZosoktbUGGT4Wvr6rrY62wudKyr/lHB1MxHNHSH3Fc
	 szh9KnLL96KDIOaZ2jK/6Gc278pAAdKJ/TlmOLj+gbbaFmogADWJwvWf/sOW280nzxoF7
	 vBthM9t8ebJyM2Qs6hgptrve4BpfgE0SBzf8rZY1zM5u834vJwxcYwSDYNB3RhAl1/6Co
	 W+DJulEBlpcuwDBb8TGF716iw2l6NF0Gbdw+RTKLfP1vFpR6afoFqrNpdJG6WAxSdTR2k
	 E+AnVWxQ2YYxoOcO8Bjv2pN3yr4F9mAC8Se4TWuf+g4iEGJ0+mIfSkKgQlopSjQeKtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W2Oz6ZWl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB20D606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W2Oz6ZWl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B571F00A00;
	Wed, 11 Nov 2026 02:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794363553;
	bh=IHtpkSJ4tmv4FmSPwIfp9A69pqYwvlBhguh3T+SGa0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W2Oz6ZWlLZNlOuRJEKfcTldtHiMwNSstoEw70Xs/3YHJWhgas5rXFxfh+A3EdjQE+
	 NYtIDaj1+xf8X5JG3yXLpwTIwxR0Zq4pIA2/Puk1PYQ9oL6FKRIVa8gRDzhWOWq50K
	 Vf1DMcmGHxBG7y+u1Hz6ZvmAcR0737DZsRcjINjnaloC8S94n45Fe7wTUg4PlNwwgw
	 5qyckMd7PDdDGRnxXY3yZu3Ux0IYzF3E+XxXs10W8orERaLh4ivcQWiwtmYrSjWoSN
	 x/8hSQ6BQwLd+gNgSMoi32jZwVwgV2DF5Szlg1ptB6qWNZfzpdcs427jMCByMpeT0v
	 fK/zP7msGNnDw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexey Charkov <alchark@flipper.net>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] nvmem: rockchip-otp: Serialize reads
Date: Tue, 10 Nov 2026 21:19:09 -0500
Message-ID: <20261111021904.642613-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111021904.642613-1-sashal@kernel.org>
References: <20261107060352-failed-5.15-9fc6a1592d84@kernel.org>
 <20261111021904.642613-1-sashal@kernel.org>
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

