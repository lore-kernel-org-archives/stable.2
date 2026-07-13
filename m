Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD522DC32C
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 19:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783972448; cv=none; b=LKVD1mOKlG8T+THzkrSO7MmOQeMxd7Ovkt1B209zg2f/c95A396WSlVEfA67orYeg9fZqE08iexm1wszFITlDGs09wDZHSwIQod3xm/YWzoZyfgE6l1uE0jWHvJdOgEELa8+RZJtVPmxpkUkGVxvv8zrkwNZLW48YsSIMXT8a8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783972448; c=relaxed/simple;
	bh=WsysDYKlmNIi1GeaMYZNzj3eo5Jd1cfgBO4xygxqFM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EL3pruiGIFJ5hZkE1S92nyzHst/7Ffmce9vOM8Ng81mwnIE5jFgr/+LxYINunUf5fkOPwTV0u4hTBsF1XgxYzZEnoksr4aGxX4tzeP6SChLMg5FhTE4ayBiUt6hhko4c/pH5p81uUiD/cW6NoKNHuLG65y2Od1DhRBN1K9N3Y40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3aaEzJE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3aaEzJE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 381EA1F000E9;
	Mon, 13 Jul 2026 19:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783972447;
	bh=xg6cJ7Emy56zQk35qGT2BR2rdqy14HcsQeCTzOrDaOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b3aaEzJEBwH0JnPbTdbwXWzS/XcsO6VUnn1LDCqbUXiKeUqoWIv7aGU3o73+1VL5b
	 jvIELKZWsuipK/vr8u5TMS/d9se0ou1GAan+vBgTUlyIVj0UeHzNbHCapztG4mSNYs
	 XnAmdd6V+yy4GdbVB1ds6c7HskWc9Krff3uxQOXThUKAZ5+QdqBl2YpoB3NyC7Uypw
	 ovZmX7bEyLJglgeFF9/z0ZE/5MRNzDHLeA/1hDeqlX/8wGYjL7g3jZrml2FBIAfsST
	 cImq0dhkDCdhnO713FZoEbrTDgVBtWKnySZMPSLalfP3r2Vw/RCl+OyrZo5gNf12KM
	 Nt5u54oyozJUA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Biren Pandya <birenpandya@gmail.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] iio: pressure: mpl115: fix runtime PM leak on read error
Date: Mon, 13 Jul 2026 15:54:05 -0400
Message-ID: <20260713195406.2114930-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071315-browbeat-obnoxious-e1ef@gregkh>
References: <2026071315-browbeat-obnoxious-e1ef@gregkh>
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

