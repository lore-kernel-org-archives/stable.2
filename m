Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795102406;
	b=TeiuctPPMUYwxRMwmkAitmHonFVSRmne2dm31nbvF6h5WiAPWajeK5ZuzuOL+DoGDOH1
	 2qnYJ9g+Zwl0oA7VVCpQ5kcbMpP3HYjN/PTzrIeQrsQvHA3tDl6boDaxpupv6zZUEN68N
	 vH+dL9bgWc2CKh5xBcM1oItFxznys/z0kKNJn4mRe2+qXHPL3jJMLXfGKjS9Mr/S/w6gD
	 8QhZA/YYzDfPbdpGTJH560rts+l/sjWPnVgAq21Ld6iIVBwy/55Aviltp5WYLAJgwmvYX
	 MhzZcR56mWUrcPGNmSVMeEQs5knva4525ly52abTAXzJzqCcfzeKW5u7fRRSmqYrhtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795102406;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=j1EROtOJFsCl7lrxArOZcwIAI8DW7epYlHFI5KPYdyE=;
	b=j32FVhnwRJSf4v9GArWdR7EFOvFww/e2laosUpvw+Q/FO6pbAVlQ4/oq9q5X0JRFS19M
	 v26FP0+Tx7pPiPTqaASWRuL1frJc2Ax4fpw+zQy7jkUxhtLPnSa0QdXBUR60ExaUYznPN
	 CkZRqQlhv9HjU/16d8QKHaQrG8/sDtxWjc3n3UfBHlEz86e7dOB+OPF7RvCLWiba/erGW
	 lXlMC0wLE/w+Kwofzxjl/Uv8Px48JlJUVtBKZc3RlWRpNUcSI3VECHXu3R7VnbNmXgLSK
	 29jMGaJQJXp/AV9uesuEre1/TWUDWFg6djOdI3jSyQXXBlwjbpai+pOYJtI61m5LlzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KH2VXIY7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915B3606A320;
	Thu, 19 Nov 2026 15:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KH2VXIY7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC1F1F000CB;
	Thu, 19 Nov 2026 15:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795102406;
	bh=j1EROtOJFsCl7lrxArOZcwIAI8DW7epYlHFI5KPYdyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KH2VXIY7q2IAFFVj6+1hwfHb6duUc6WUVCWWQ89mjCWo9eXOvKtyeo6pc9PrDPW89
	 DTg8xCUBXPEF/jvN+nWxcPw56JB7rsFgmreFQ7IGFSyeT75PTeEDmGeIlX8f7zsDnM
	 5YinfWhCFs4oGTQhvazbBvRdSN+04p+3ffZgq0ztWs5A+VVP3h2HWqAI4M6ykHHeBH
	 /yV8z8H0OYYzgeul8f0D03mjrEVM4EP0NbCZdRPtHBYJ5ZXRi6LmuHRdOUJ+0kjKdr
	 6U2x0XnNw45ZtB2RE0tgiC9Es9pnz8gq8IjWzZVtYaGB1KYTMS5LHY1z2dzjiTbT3Z
	 JLsAVbX79eahg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joe Sandom <joe.g.sandom@gmail.com>,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 10/10] iio: light: tsl2591: Prevent infinite recursion on threshold boundaries
Date: Thu, 19 Nov 2026 15:30:43 +0000
Message-ID: <20261119153151.1397003-11-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
In-Reply-To: <20261119153151.1397003-1-lee@kernel.org>
References: <20261119153151.1397003-1-lee@kernel.org>
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

tsl2591_set_als_lower_threshold() adjusts the upper threshold to
als_lower_threshold + 1 whenever the new lower threshold is greater than
or equal to the current upper threshold, and
tsl2591_set_als_upper_threshold() symmetrically adjusts the lower
threshold to als_upper_threshold - 1.

Writing 65535 (TSL2591_ALS_MAX_VALUE) to the falling threshold wraps the
16-bit addition to 0 and calls tsl2591_set_als_upper_threshold(chip, 0),
which then wraps 0 - 1 back to 65535 and calls
tsl2591_set_als_lower_threshold(chip, 65535) in an infinite mutual
recursion until the kernel stack overflows.  Writing 0 to the rising
threshold triggers the same cycle whenever the lower threshold is
non-zero.

Reject als_lower_threshold == TSL2591_ALS_MAX_VALUE and
als_upper_threshold == 0 with -EINVAL, propagate errors from the
cross-calls, and only update chip->als_settings once the I2C writes
succeed.

Fixes: 2335f0d7c790 ("iio: light: Added AMS tsl2591 driver implementation")
Closes: https://sashiko.dev/#/bug/linux-29f0f993-c799-4717-9daa-d0ad367f4e6d
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/iio/light/tsl2591.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/light/tsl2591.c b/drivers/iio/light/tsl2591.c
index 8cfce720efb9..e0c2b67c7dd4 100644
--- a/drivers/iio/light/tsl2591.c
+++ b/drivers/iio/light/tsl2591.c
@@ -466,23 +466,25 @@ static int tsl2591_set_als_gain_int_time(struct tsl2591_chip *chip)
 static int tsl2591_set_als_lower_threshold(struct tsl2591_chip *chip,
 					   u16 als_lower_threshold)
 {
-	struct tsl2591_als_settings als_settings = chip->als_settings;
 	struct i2c_client *client = chip->client;
 	u16 als_upper_threshold;
 	u8 als_lower_l;
 	u8 als_lower_h;
 	int ret;
 
-	chip->als_settings.als_lower_thresh = als_lower_threshold;
+	if (als_lower_threshold == TSL2591_ALS_MAX_VALUE)
+		return -EINVAL;
 
 	/*
 	 * Lower threshold should not be greater or equal to upper.
 	 * If this is the case, then assert upper threshold to new lower
 	 * threshold + 1 to avoid ordering issues when setting thresholds.
 	 */
-	if (als_lower_threshold >= als_settings.als_upper_thresh) {
+	if (als_lower_threshold >= chip->als_settings.als_upper_thresh) {
 		als_upper_threshold = als_lower_threshold + 1;
-		tsl2591_set_als_upper_threshold(chip, als_upper_threshold);
+		ret = tsl2591_set_als_upper_threshold(chip, als_upper_threshold);
+		if (ret)
+			return ret;
 	}
 
 	als_lower_l = als_lower_threshold;
@@ -504,32 +506,33 @@ static int tsl2591_set_als_lower_threshold(struct tsl2591_chip *chip,
 		return ret;
 	}
 
+	chip->als_settings.als_lower_thresh = als_lower_threshold;
+
 	return 0;
 }
 
 static int tsl2591_set_als_upper_threshold(struct tsl2591_chip *chip,
 					   u16 als_upper_threshold)
 {
-	struct tsl2591_als_settings als_settings = chip->als_settings;
 	struct i2c_client *client = chip->client;
 	u16 als_lower_threshold;
 	u8 als_upper_l;
 	u8 als_upper_h;
 	int ret;
 
-	if (als_upper_threshold > TSL2591_ALS_MAX_VALUE)
+	if (!als_upper_threshold)
 		return -EINVAL;
 
-	chip->als_settings.als_upper_thresh = als_upper_threshold;
-
 	/*
 	 * Upper threshold should not be less than lower. If this
 	 * is the case, then assert lower threshold to new upper
 	 * threshold - 1 to avoid ordering issues when setting thresholds.
 	 */
-	if (als_upper_threshold < als_settings.als_lower_thresh) {
+	if (als_upper_threshold < chip->als_settings.als_lower_thresh) {
 		als_lower_threshold = als_upper_threshold - 1;
-		tsl2591_set_als_lower_threshold(chip, als_lower_threshold);
+		ret = tsl2591_set_als_lower_threshold(chip, als_lower_threshold);
+		if (ret)
+			return ret;
 	}
 
 	als_upper_l = als_upper_threshold;
@@ -551,6 +554,8 @@ static int tsl2591_set_als_upper_threshold(struct tsl2591_chip *chip,
 		return ret;
 	}
 
+	chip->als_settings.als_upper_thresh = als_upper_threshold;
+
 	return 0;
 }
 
-- 
2.56.1.708.g77570a6a1d-goog

