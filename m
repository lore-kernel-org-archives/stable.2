Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2119135677E
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 19:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971435; cv=none; b=RKzU+FrMPtlT8fWLeULgPtDryzQwUgr3GSsXGeB9mK+n8UqKTVB6JR9gCVeTIriISt6XqqI81k5XamJfxk9qfdfxetalAg7s3qs7jvyoa7IPQPK+Ar6UOM4jLk+bG2BfHKY5R0d5d7/MVQnhxcrmxvyP1pdU0wDSA5t8ijaTjrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971435; c=relaxed/simple;
	bh=WsysDYKlmNIi1GeaMYZNzj3eo5Jd1cfgBO4xygxqFM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fo/QWtuwFibuUtuyARfun7xIB5XxiBk5DkqKzfjUzgleyDE8YcfrnhyISQTVHZDqqYDzLpmkKhEYIEuPn4zqjaNFSFKNF4FW4bLEoDRBPHcPoYxD9We3tvIBzLG2cDSbwpKN4q0UOTxlAsA8ENAXMxkgEkOSfDNZSypNESnMnLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mg/sfdm8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mg/sfdm8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C821F00A3A;
	Mon, 13 Jul 2026 19:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783971433;
	bh=xg6cJ7Emy56zQk35qGT2BR2rdqy14HcsQeCTzOrDaOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mg/sfdm8It94SargUh4HyPm6l9acImKVa/VhD+sRwzOEaI4l3E8ixUw9cMIxBMYvJ
	 phDlk4a6X18uEuhg69458btFsidXOYxklaVTVtS5yTiOvb+vdr/z25r8fhMJD5h62r
	 UV8BDZhXf64uGFOe/B0q6/Yp4otQw8tNqIunPrzRUFDeVy6hHWqS4PUFkfGsDVTkAH
	 4Q1kqFaysPtCCji+I/K1ANmO3uwfa/nsQJjB7zJRTkqfxmtJ/tbXA+9hn51OryOmSS
	 eJ67uAdoO+sal9+LBA9PulYON3Do3I+cKlBjrKwRHCYv5q395AqjTfd6Stje6QQa+5
	 +M8sAX+iED8Iw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Biren Pandya <birenpandya@gmail.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] iio: pressure: mpl115: fix runtime PM leak on read error
Date: Mon, 13 Jul 2026 15:37:11 -0400
Message-ID: <20260713193711.2054758-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071315-trespass-legible-97d4@gregkh>
References: <2026071315-trespass-legible-97d4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biren Pandya <birenpandya@gmail.com>

[ Upstream commit fbe67ff37a6fd855a6c097f84f3738bd13d0a898 ]

mpl115_read_raw() takes a runtime PM reference with pm_runtime_get_sync()
before reading the processed pressure or raw temperature, but on the read
error path it returns without calling pm_runtime_put_autosuspend(). Each
failed read therefore leaks a runtime PM reference and prevents the device
from autosuspending.

Drop the reference before checking the return value so both the success
and error paths are balanced.

Fixes: 0c3a333524a3 ("iio: pressure: mpl115: Implementing low power mode by shutdown gpio")
Signed-off-by: Biren Pandya <birenpandya@gmail.com>
Assisted-by: Claude:claude-opus-4-8 coccinelle
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
[ moved pm_runtime_mark_last_busy() together with pm_runtime_put_autosuspend() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/pressure/mpl115.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/pressure/mpl115.c b/drivers/iio/pressure/mpl115.c
index 02ea38c8a3e431..e3eb154feb5fde 100644
--- a/drivers/iio/pressure/mpl115.c
+++ b/drivers/iio/pressure/mpl115.c
@@ -106,20 +106,20 @@ static int mpl115_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_PROCESSED:
 		pm_runtime_get_sync(data->dev);
 		ret = mpl115_comp_pressure(data, val, val2);
-		if (ret < 0)
-			return ret;
 		pm_runtime_mark_last_busy(data->dev);
 		pm_runtime_put_autosuspend(data->dev);
+		if (ret < 0)
+			return ret;
 
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_RAW:
 		pm_runtime_get_sync(data->dev);
 		/* temperature -5.35 C / LSB, 472 LSB is 25 C */
 		ret = mpl115_read_temp(data);
-		if (ret < 0)
-			return ret;
 		pm_runtime_mark_last_busy(data->dev);
 		pm_runtime_put_autosuspend(data->dev);
+		if (ret < 0)
+			return ret;
 		*val = ret >> 6;
 
 		return IIO_VAL_INT;
-- 
2.53.0

