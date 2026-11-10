Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320351;
	b=F+1Z0pxJXQKTSyG2mrACSKeUcQmw8zc708V4mGN5HFF+5C86icOM36qU8+nxJkG3PV/K
	 lvcERLcbvPLGVZg2xgS1QgkBBcjvTsktUcSyWBUJ6SwcNa3qarRmKkvfTS4yYyzK9RmYM
	 LAM8TBMfCvFk0rDr4bVYx+c9j6xV5aM0lM6xNAY2Ffo1PCUPW+ZKXJPuvhJDkqzv2X1LU
	 YCPLBmq8aAGejBPVxZal9ncRMy7wsPFdu9j4dLcLikS50/80m9b1xOJ1b1E3J6OUV09U4
	 9FsxsZ5ebPn3LQU/2Z07wBPGPxxs0qWeNbbxIvoxIixX4qp8F4aNu54t5Ujqkz5ywmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320351;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pg97OCrpkJS9LSUPJcj0YFkNALLUlobFtFywno4pXMI=;
	b=CX7xGpVQpJ+V4u6/ySoW8q/vgtLVvKS1flpnpsSJ1Ca0As/kPRGmf9e6X5Fd4QWAyNfD
	 KZDtzAxCUtKnnYws1CP9owSx6cLR9V3PpAqP9HOTwwnj4OnTR5WcMQ3ftIwx+zTQybUpZ
	 Rn3NNG9HOPR45yDJoQgEBZJRUgYOVz0FoUKUFkncH4ZOhHCOiENQuCq9TyiccPLA1L1oM
	 3AuMTI0FTe+tBnM6cGb/lC/JqwC1xtCJfnmHyBo+HQD8Z/DW0yorgukzmGi/i7WjLl4Nh
	 BWRrAcR3Wj2lai+hHBfHrqerQHjJQpKtZib9uo6rtL7BA0gmGy7zdJFmosVVcqhuHDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X5V3bqLj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34CC606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X5V3bqLj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 438AA1F0089F;
	Tue, 10 Nov 2026 14:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794320350;
	bh=pg97OCrpkJS9LSUPJcj0YFkNALLUlobFtFywno4pXMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X5V3bqLjEMnMvCYAdhD8lA/4pKqzJpcXY8AwYZoHJody2B+jDVv+lWUBObMyQs8Gv
	 2h8UGVJdYoiw7NkjFsL1rGExs+wH+z4NbTAiG9Cvv9tz6ylceo8BM7JkYyWIeIbSKU
	 THx8supB2d2sUgR6PzfH46BdkVTzsfppgPZFKFuvqH/7IR6cCaX9PBskHn9dJPZr6l
	 c86Ji0pTeLz4UfoWZzqTSxWssISoYX1VWSdy/tZnPIwnrIKAfzJc9cueqtrm2/OORE
	 cd7At5l72CAlj+xyK2dwbgwvbriE2VzY+Ntzlcg23lLi1uQnOjgiu8wGyj4QPbR2Uy
	 wn4fhwagUELUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Robert Marko <robert.marko@sartura.hr>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] spi: atmel-quadspi: add controller init callback
Date: Tue, 10 Nov 2026 09:19:07 -0500
Message-ID: <20261110141901.1859701-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050822-failed-6.18-717e45f97246@kernel.org>
References: <20261107050822-failed-6.18-717e45f97246@kernel.org>
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

From: Robert Marko <robert.marko@sartura.hr>

[ Upstream commit cbbd5a945e85e7835ac5792d855d85c20e40d1e3 ]

Allow controller variants to provide a custom initialization callback
through their capability data.

This prepares the driver for variants which require a different hardware
initialization sequence without adding SoC checks to the common path.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Link: https://patch.msgid.link/20260709112006.390742-3-robert.marko@sartura.hr
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 717e45f97246 ("spi: atmel-quadspi: balance runtime PM and pclk across system sleep")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/atmel-quadspi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index d7a3d85d00c2f..6c2d3c00409bb 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -256,8 +256,11 @@ static const struct atmel_qspi_pcal pcal[ATMEL_QSPI_PCAL_ARRAY_SIZE] = {
 	{200000000, 7},
 };
 
+struct atmel_qspi;
+
 struct atmel_qspi_caps {
 	u32 max_speed_hz;
+	int (*init)(struct atmel_qspi *aq);
 	bool has_qspick;
 	bool has_gclk;
 	bool has_ricr;
@@ -1156,6 +1159,9 @@ static int atmel_qspi_sama7g5_setup(struct spi_device *spi)
 	/* The controller can communicate with a single peripheral device (target). */
 	aq->target_max_speed_hz = spi->max_speed_hz;
 
+	if (aq->caps->init)
+		return aq->caps->init(aq);
+
 	return atmel_qspi_sama7g5_init(aq);
 }
 
@@ -1571,6 +1577,9 @@ static int __maybe_unused atmel_qspi_resume(struct device *dev)
 		return ret;
 	}
 
+	if (aq->caps->init)
+		return aq->caps->init(aq);
+
 	if (aq->caps->has_gclk)
 		return atmel_qspi_sama7g5_init(aq);
 
-- 
2.53.0

