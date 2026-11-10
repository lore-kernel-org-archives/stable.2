Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794318393;
	b=Zt/hN948FP5tdzd2s/fZTmJv+hTb4RXW/pHduR3nQoT1n822ba2hNVjNXt6zhh++o717
	 jq9u9eRipye/Ftuop+KCCLqGuOTh1Yvf9rR/wz1XreDCUJKsma2kEQXnviiQ4arpWCl0m
	 8S1+YoSo96Xrp0DCnoKjYAXTBIxttHKibLhAHhSIwx+xBNTxhSu5Iyf6Cg+lZEeOiFRBR
	 skYbH3zcC87fvlnYgJSKb2/tkhvrF9Z0Omx1TW4UHvmcs7Zq03d03oRqznxFDLZtZvhFm
	 rnqYaZhNwtxvnihB9OulqKYxJDlOOG0MVvUEJHlneRBEtHdJ0lB6BsJn6wSx/b7++vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794318393;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=yWeDY9VYwgPfEbXEy7Zdvw4BJDsiSPyphSf6j55Fulw=;
	b=kuF+oqMuj2jedcv1JZE0sKjwhpziOAWX+wd3QZvOcPYz0qtw1tGXnLixIHzzVApz62Mt
	 cbDqkhrbQCWEEPmCOFMEhS7bHkr6k3+6Br8LYVxaB4kZiFCq+UsAwZatdXqQHZ3dX650Y
	 j0yKidsHEpyGadl1qMbhqzutQFP1+kzZK/74OTstyncf33yD/dlzDpxm5mHV0aajIqq3L
	 k5SCge+eX0YDb8aiucseYaj8mezv13W90KEwPNdcESnAMna2hYu0qPYoShN3vf/HuTTeT
	 cgbZHRoWuYeP1MDKoZUvQViE2uLvlszBZnaBTYG2yszKg3GDgrT9GifmTIsMgnqspBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Af+u/+iA";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BB1606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Af+u/+iA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8EFE1F008A1;
	Tue, 10 Nov 2026 13:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794318392;
	bh=yWeDY9VYwgPfEbXEy7Zdvw4BJDsiSPyphSf6j55Fulw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Af+u/+iA2uOZLx1rhRmoi6a1o7ZR84quMloeskS/7Wb41nVnxFUlVXVRSy83L2wSz
	 GjGNhC0PnKp08kXmLN3rsJasuEAx3z0vTk0bKktZ3JVavzbtAN/Ba/v/JSN7b6WqCZ
	 dGnpYSU4UulmwW5U7Ov0zNXQfqdXdQBrDirtO+VIfaooayS0LIrfI902UPPNBrnro6
	 Rd+Q/Jp4pAEdd97IwtJmq+nES0odJ1QF0wQxxIruptHtZRLlgGv3E0RpTHZ498H1yX
	 BLW3KZeAZTk22RgZALvW6xtlV6L+uxwYmcHQUrtyEwUqr6uO7g04cYmv5rYKMvdfFD
	 oozLr7bzaZCBA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] media: vpif_capture: Fix i2c adapter reference leak in vpif_probe()
Date: Tue, 10 Nov 2026 08:46:29 -0500
Message-ID: <20261110134623.1784694-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110134623.1784694-1-sashal@kernel.org>
References: <20261107054244-failed-6.1-b00fbdad64d4@kernel.org>
 <20261110134623.1784694-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/ti/davinci/vpif_capture.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/ti/davinci/vpif_capture.c b/drivers/media/platform/ti/davinci/vpif_capture.c
index 7592216177b50..b32d008586755 100644
--- a/drivers/media/platform/ti/davinci/vpif_capture.c
+++ b/drivers/media/platform/ti/davinci/vpif_capture.c
@@ -1604,7 +1604,7 @@ vpif_capture_get_pdata(struct platform_device *pdev)
 static int vpif_probe(struct platform_device *pdev)
 {
 	struct vpif_subdev_info *subdevdata;
-	struct i2c_adapter *i2c_adap;
+	struct i2c_adapter *i2c_adap = NULL;
 	int subdev_count;
 	int res_idx = 0;
 	int i, err;
@@ -1693,9 +1693,12 @@ static int vpif_probe(struct platform_device *pdev)
 		}
 	}
 
+	i2c_put_adapter(i2c_adap);
+
 	return 0;
 
 probe_subdev_out:
+	i2c_put_adapter(i2c_adap);
 	v4l2_async_nf_cleanup(&vpif_obj.notifier);
 	/* free sub devices memory */
 	kfree(vpif_obj.sd);
-- 
2.53.0

