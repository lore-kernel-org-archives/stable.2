Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794318960;
	b=jamBdk4io99haBA3e4rnUJpa532mfbRz0KMZ0ocW6Rc1JDUNpV479ViyKvgbLWnJD+Um
	 XUyWFnN/IN95Ax1pESbCdylwqxIdsj722TCBu0B2SS0A8ZXHlklQIPu7KGkp4+sFj5xwh
	 UgGLQSoWKmdmw/qL/v017AIHmTAE/C1Qq2z/oYELp2L7WL/yL1f3u500AE9CrHxGHBaC9
	 sFwMxJLncDKBbMS9OiIBzh2zWYrZECIscADk+NaIR9b6Gb9sCCfj/7GEXvF59qQzROzbg
	 wlvnIylAWkjggBd+tyVjmuqvYhQr8vHiYSCxzOjGaUan4OPQmBZ6HfakLv3RIekrtqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794318960;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uwKq65j8PiUhLB+Ff1X7tZk8pqfZNShCGdXAOCOwasQ=;
	b=uP2fwrMzD6WzenhoBGC1Y3zxj+3++PLmSDd0ZNffx80cMvtfdHhllmDJ442Ffg/BqV5M
	 oSn7a+WFktTe+Q0Sx89Ih0L08Wz4Xef2JHMtMGWa41MS11ZKWQrkGsFgnC8wvCel686Bx
	 V8F/E3r/ZLGU8mK9LgBSzWvzGRtCMvn20rla1BahXr8YSA+IudBoPbtAwBMjtsWzwe3ip
	 qkWDv6YRdxZqsyY/Fj1Z/5/E74IY3s7/Zgdbywwo8khly/8lloakv80B+NU4CBRqpJj0+
	 XvMnPBeZW9oynluHP3q4QxnPbXTzFjISi0F9hOt9qzO9O2bj2phZT3Ux3nqj9aQlRzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kD1dOuzP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B39606A326
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kD1dOuzP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237271F008A1;
	Tue, 10 Nov 2026 13:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794318959;
	bh=uwKq65j8PiUhLB+Ff1X7tZk8pqfZNShCGdXAOCOwasQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kD1dOuzPnukdww7uakuQR0ZMB7eLi1D6h6Io1l9Me+nFJw8WA8b17uk0p1gkBuUNi
	 fJwQPInpioGZM1Tsr5T/BUB6jQQtkfX11akmuuCmxBBlwHs7FyqmjyajAf0t3m6Dwo
	 aWBbd4brxkll5q9c81zZxzkDLRzWUz27R345P7GhQ4cAIAMBWPbayPQcr0+t1sd0Wc
	 lvkNgSQ7AupNYjXVRn4+erMfg9IT00glIGo9QLAUTTFuRxTlE8TNL6JrF2Pae2CFJu
	 oPXV+hXWCcQWJ19o14QI7mVtVHivjl2+2IR4P1mkFjCiGq3hSXGxR0UN/AioURu5X5
	 1KMlYgP017VvQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] media: vpif_capture: Fix i2c adapter reference leak in vpif_probe()
Date: Tue, 10 Nov 2026 08:55:57 -0500
Message-ID: <20261110135534.1796626-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055952-failed-5.15-b00fbdad64d4@kernel.org>
References: <20261107055952-failed-5.15-b00fbdad64d4@kernel.org>
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

From: Wentao Liang <vulab@iscas.ac.cn>

[ Upstream commit b00fbdad64d4ea7d594bc67988c1722fe5b3be50 ]

vpif_probe() takes a reference to the i2c adapter with
i2c_get_adapter() and passes it to v4l2_i2c_new_subdev_board(),
which does not consume it, but the reference is never released, so
it is leaked both when the probe succeeds and when it fails after
the adapter has been acquired.

Release the reference with i2c_put_adapter() on the success path
and in the probe_subdev_out cleanup, and initialise i2c_adap so
that the cleanup is a no-op when the adapter was never acquired.

Fixes: 6ffefff5a9e7 ("V4L/DVB (12906c): V4L : vpif capture driver for DM6467")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
[ sashal: Adjusted patch context to retain the existing resource declaration and older notifier cleanup sequence. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/davinci/vpif_capture.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/davinci/vpif_capture.c b/drivers/media/platform/davinci/vpif_capture.c
index 164d287c293ed..619952ac1a6b6 100644
--- a/drivers/media/platform/davinci/vpif_capture.c
+++ b/drivers/media/platform/davinci/vpif_capture.c
@@ -1617,7 +1617,7 @@ vpif_capture_get_pdata(struct platform_device *pdev)
 static int vpif_probe(struct platform_device *pdev)
 {
 	struct vpif_subdev_info *subdevdata;
-	struct i2c_adapter *i2c_adap;
+	struct i2c_adapter *i2c_adap = NULL;
 	struct resource *res;
 	int subdev_count;
 	int res_idx = 0;
@@ -1701,9 +1701,12 @@ static int vpif_probe(struct platform_device *pdev)
 		}
 	}
 
+	i2c_put_adapter(i2c_adap);
+
 	return 0;
 
 probe_subdev_out:
+	i2c_put_adapter(i2c_adap);
 	/* free sub devices memory */
 	kfree(vpif_obj.sd);
 vpif_unregister:
-- 
2.53.0

