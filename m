Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311121;
	b=lSBfAQx057W3Cdg3UoGIstp7qwKP4ba9SgCQep9fPLeZQlWDEhzqdowqPJ9OirJSWaGE
	 kklucbnaH4NMvuOOWCYlrgW72lV3tkNMhsdOqO/uKr1U+KhWMtf5bRQAG5tfxejsJzhSy
	 f9y9xpRwRn254xgb+OWNDuswRglshq6nq4kY11oqQWINAi7cwhzMDj1ruO509cgclPN/Z
	 bB9D92A9ybbeTzEIkV0icABKqPZ/oy4mx0GNFh/QcAXq/6PEzGt9WpghWwDbYEjGoCnn5
	 vh39zU3g5VQ5jMKTq0wlUzjO+cM1vUCcQaTtns8+6yPveHTRL91W/ea5/YCUXzkKuPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311121;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BrE6qmTA91PqUcEQjPc3eucEoExxFQUIv8JuA9TmqvY=;
	b=Ab9ztPW+ilfzZCvITkBrNpYbz//R3rXqgQRIwl+rSf58MIbUnwLsya12080Qze+tcTZb
	 cmSnAS9pl9lSX6MqSmCMVdpaw1u0eQJ75Und2MGDG74Gkw6TJKjHnPETY2zjhkobsFRmR
	 67LkLJkLMcRzRvs39PBlnvwxKpbouHUQwCNsoGt8Jt1dXLlzWRZwFEDgwGUvdxMJ8S0K9
	 C5jCliAGBuu5ks/zfWGvx7Q9vTQefuCbFUNEp5eRwo3axHq0iHkpzDh84LGbBZuUzZFaX
	 lCB7J+1CZFqJTf/84+wW3Ej6+pKoqFXebvrO2OG9nNHuwPMQYq64TFvEpcZh4fzJgIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZphZAeAt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450E8606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 11:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZphZAeAt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0319C1F0089F;
	Tue, 10 Nov 2026 11:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794311120;
	bh=BrE6qmTA91PqUcEQjPc3eucEoExxFQUIv8JuA9TmqvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZphZAeAt9UwgYZdBitIGwwt5c6hfkFd3hEKiqgEqnYrFPVqLUB3biJJ0jwkUEVI7l
	 G4iYPpqu5m0Fd0hBDD3Z+wsjy0M/sbiW2W/QO9Ye4vdfp6kaKUrvOVaDMdHq59ePsk
	 +3vU9ho2OQjo+d+t3qiBoIA+QPwFa4ldwLdvFxZCorZGNbzpWWtu1nJiyYMiQwfxrV
	 qBN0uMSkRm9DIcpXLXAMk0nNQaeyZr0kDsX6Gl/7sdKYJ8SSvhY8AeLjnLpofB0o64
	 sOyujuwRLppKeRHE8emZHLkCJw+CBJvjSnM0xaIDDleztzlVCFQhdqCr8Hk7pmRY48
	 GfxYJGampbALw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sang-Heon Jeon <ekffu200098@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] iio: light: isl29028: remove isl29028_set_pm_runtime_busy() helper
Date: Tue, 10 Nov 2026 06:45:17 -0500
Message-ID: <20261110114512.606630-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050644-failed-6.18-0e30d15b1564@kernel.org>
References: <20261107050644-failed-6.18-0e30d15b1564@kernel.org>
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

From: Sang-Heon Jeon <ekffu200098@gmail.com>

[ Upstream commit 7f61f41a3f5e8f9aa6c264833504995c89712cfc ]

isl29028_set_pm_runtime_busy() just calls pm_runtime_resume_and_get()
or pm_runtime_put_autosuspend() depending on its bool argument. Call
them directly and remove the helper.

No functional change.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
Reviewed-by: Brian Masney <bmasney@redhat.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Stable-dep-of: 0e30d15b1564 ("iio: light: isl29028: fix runtime PM reference leak on error paths")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/light/isl29028.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/light/isl29028.c b/drivers/iio/light/isl29028.c
index f89c5d9ee5240..7590efcf8dedb 100644
--- a/drivers/iio/light/isl29028.c
+++ b/drivers/iio/light/isl29028.c
@@ -333,16 +333,6 @@ static int isl29028_ir_get(struct isl29028_chip *chip, int *ir_data)
 	return isl29028_read_als_ir(chip, ir_data);
 }
 
-static int isl29028_set_pm_runtime_busy(struct isl29028_chip *chip, bool on)
-{
-	struct device *dev = regmap_get_device(chip->regmap);
-
-	if (on)
-		return pm_runtime_resume_and_get(dev);
-
-	return pm_runtime_put_autosuspend(dev);
-}
-
 /* Channel IO */
 static int isl29028_write_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
@@ -352,7 +342,7 @@ static int isl29028_write_raw(struct iio_dev *indio_dev,
 	struct device *dev = regmap_get_device(chip->regmap);
 	int ret;
 
-	ret = isl29028_set_pm_runtime_busy(chip, true);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0)
 		return ret;
 
@@ -405,7 +395,7 @@ static int isl29028_write_raw(struct iio_dev *indio_dev,
 	if (ret < 0)
 		return ret;
 
-	ret = isl29028_set_pm_runtime_busy(chip, false);
+	ret = pm_runtime_put_autosuspend(dev);
 	if (ret < 0)
 		return ret;
 
@@ -420,7 +410,7 @@ static int isl29028_read_raw(struct iio_dev *indio_dev,
 	struct device *dev = regmap_get_device(chip->regmap);
 	int ret, pm_ret;
 
-	ret = isl29028_set_pm_runtime_busy(chip, true);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0)
 		return ret;
 
@@ -476,10 +466,10 @@ static int isl29028_read_raw(struct iio_dev *indio_dev,
 
 	/**
 	 * Preserve the ret variable if the call to
-	 * isl29028_set_pm_runtime_busy() is successful so the reading
+	 * pm_runtime_put_autosuspend() is successful so the reading
 	 * (if applicable) is returned to user space.
 	 */
-	pm_ret = isl29028_set_pm_runtime_busy(chip, false);
+	pm_ret = pm_runtime_put_autosuspend(dev);
 	if (pm_ret < 0)
 		return pm_ret;
 
-- 
2.53.0

