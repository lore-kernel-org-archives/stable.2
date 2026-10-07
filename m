Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F0124886E
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 05:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791351861; cv=none; b=SVMc20IvK3B9rzJKV0Lr9cLZo/VrgNsBRANOpZslACDlC7b2DfnrTUVYp8rN42TqOS5TnlA0CG9qC/X8EsIVVHBq75+OvEWgl/NN7+o6k9xSLfbykQRV2olvZr31ll1H44Qcb5bFDPYfPS43dExrPPCfhaA0Qj6o368LZuN4PoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791351861; c=relaxed/simple;
	bh=u6fIWQ2iFqOiQi2wSDorOcqPrDIjDHKKPddK0ARTJSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TV+AYOH6g3LTArG8ymIbwUHnMFYpcFbt/wVl5Lf6G+I7XlCp/q6Hwhyjmaa22gktWqhOHmBtcGYhkcwjta4WWKFrFpDyx46BInFXczH+BvdFLkNbmEG0ckdHtqA0la9Hafryol/INbUwRjoeO2zcGfwBiCZkTYo+e2ZIVmfoPYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iU7PE7Ck; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iU7PE7Ck"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E061F0089C;
	Wed,  7 Oct 2026 05:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791351860;
	bh=Yum6OdXDzhPiveMw7wl+Jq2kSFTS55U2f5zNQ4kkHkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iU7PE7CkFjqduOXDveRfkCKg93FriS9tWhlW7Ed0eqcObaK92vPqUSlz2w62flESN
	 3UYzEirQyzpmPVl57x/ewuTTJ2Z3MCWz6Z/1bxewJBNVYJ8l3GopZ8XAfUQgAo4A05
	 JgrnP2tf9aQibyEcD/bDkUgEraHFcmI/i44zLUZis/8gUCmhC+Wh0WAWG2To0h/Vig
	 23O2/rnUrHDpDrKlFUbW7sGMW2tGScBf/2IK1Zh8r6TutiqX/wf1e66zG1v+vESSDy
	 UDnkBaeGIeqcjer9MR0qyKg15L3Kvc/DJ3lR10sbrvb76on8I0pWsUcczmRwKp19Qc
	 vsdW5u6qqCcHw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Mehdi Djait <mehdi.djait@linux.intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] iio: accel: kionix-kx022a: Prevent memory leak and fix state
Date: Wed,  7 Oct 2026 01:44:15 -0400
Message-ID: <20261007054404.1487956-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261007054404.1487956-1-sashal@kernel.org>
References: <2026100642-onslaught-extruding-e802@gregkh>
 <20261007054404.1487956-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matti Vaittinen <mazziesaccount@gmail.com>

[ Upstream commit e65e128b51a37dd1a9056ac3d1705d805a5c8bb0 ]

The driver allocates memory for samples at buffer enable path. If regmap
operation fails in the kx022a_fifo_enable() at the buffer enable path, the
allocated memory is never freed. Furthermore, the state information and
previous hardware configuration(s) aren't undone, potentially leaving
WMI interrupts and buffers enabled, or driver state flags wrong.

Free the memory and revert the hardware configuration and state flags on
error path.

Fixes: e7123a4dfcd7 ("iio: accel: kionix-kx022a: Refactor driver and add chip_info structure")
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Mehdi Djait <mehdi.djait@linux.intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/accel/kionix-kx022a.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
index 1e4ba5602dbf4..b1d48369fa216 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -958,26 +958,44 @@ static int kx022a_fifo_enable(struct kx022a_data *data)
 	guard(mutex)(&data->mutex);
 	ret = __kx022a_turn_on_off(data, false);
 	if (ret)
-		return ret;
+		goto err_free_out;
 
 	/* Update watermark to HW */
 	ret = kx022a_fifo_set_wmi(data);
 	if (ret)
-		return ret;
+		goto err_turn_on_out;
 
 	/* Enable buffer */
 	ret = regmap_set_bits(data->regmap, data->chip_info->buf_cntl2,
 			      KX022A_MASK_BUF_EN);
 	if (ret)
-		return ret;
+		goto err_turn_on_out;
 
 	data->state |= KX022A_STATE_FIFO;
 	ret = regmap_set_bits(data->regmap, data->ien_reg,
 			      KX022A_MASK_WMI);
 	if (ret)
-		return ret;
+		goto err_buf_disable_out;
 
-	return __kx022a_turn_on_off(data, true);
+	ret = __kx022a_turn_on_off(data, true);
+	if (ret)
+		goto err_wmi_clear_out;
+
+	return ret;
+
+err_wmi_clear_out:
+	regmap_clear_bits(data->regmap, data->ien_reg,
+			  KX022A_MASK_WMI);
+err_buf_disable_out:
+	regmap_clear_bits(data->regmap, data->chip_info->buf_cntl2,
+			  KX022A_MASK_BUF_EN);
+	data->state &= ~KX022A_STATE_FIFO;
+err_turn_on_out:
+	__kx022a_turn_on_off(data, true);
+err_free_out:
+	kfree(data->fifo_buffer);
+
+	return ret;
 }
 
 static int kx022a_buffer_postenable(struct iio_dev *idev)
-- 
2.53.0

