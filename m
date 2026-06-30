Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E4C3502A8
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 02:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782785601; cv=none; b=Sueh7f1NIBJxNejDR+Y0hD1l7U2aSyXJQDVh99wZNRS7vVYRuCWP5Z25/k+jkQ6A74USpjnlj+g7vgi4THCHnNDeqqZnWY5vqq0vbFbOecfhzbUKXxldhUz7Iru4VvjOpPFEh/jJWplVfPfI4AhUOdZnpi3ZsER7EG4U8AYmuW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782785601; c=relaxed/simple;
	bh=qLzTEG0vAb1fVHHleYCIHVSPJN5rRtgS8VUpHiPqUss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cD/S8X1NDn1eF0vIfR1U1pNO3+/yRaF8L+Gp25r5HOF4nokY6vNdlU6/sSpZLs0KUQVzHWBzgYBmm2g67WI8MZ2eUthCNz8O3bVpnXvxSuffFcHeyMdGeNcD1M9Ktb5CRUICGT89bsBmKvhncW1Kc+q+XKklmNkeM+nI3+ulLE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=XUE+hG7g; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="XUE+hG7g"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-13981833e13so4844671c88.1
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 19:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1782785597; x=1783390397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHXvlgwhzgwaNu3wblp/hnWeWlO47iBmvx2wTGsjZzQ=;
        b=XUE+hG7gXFDxPMdTtrPy+a/YBJLdF1Faeso1sX5Hy40XnTaydijuoClKaHzQLaiZH8
         CAcGQCBsr++uBwaWnlacj5l4zLJJZYdPCMj2lFz4DAM2QidXqcjpldwueb9J/Vkxpj9J
         Orr05ndHlbaopQuE6Z+U7Hrv2XZu0JLddQXfgVxkoQO7hwWiEXc64Qu7Vpr34OUzchiY
         gSzC2opMqz8GAex0rCnIVmMJixEFQybEFE29x5WcoIirvVf+gtl7vGYOlMQHU9eskRtu
         mz7di3+KwJ1nTyerPVgkqzyDiZUtBgw5qfqTZ3SvUrX51bZAjsFZCQQqmo5ld/iT88nc
         bGLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782785597; x=1783390397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uHXvlgwhzgwaNu3wblp/hnWeWlO47iBmvx2wTGsjZzQ=;
        b=ccgn4upZlcUicS7R+sSPTRQFpsajLe9DeET/2zULVSWuPrj0bzk4XGsgU457JSAyEX
         4zM3h6ds0BRq6mttwc8T7VFe8bnWwXQL+U+e9A611p+MbqL0cbq1rqTjE5hxZ9FljYO3
         Q/pcJkDxdnOjYrW1AGDMAWB9JPykQ79ZGc5UgjX0+ygbyjx98esnBSb0Pp1J53giZrH0
         9UrApz4RPIew+CKQrDFUx/20JIn7uT8xUg63Jr9yH+VAAuaRnuDsJXfu5g9cz56lv7TW
         YNxviYDfBJtyClYc6qA8/0J1oP/OKJhgXHOy/NWtNCeAcHJmyVIj9AIRan6+6x+3fkDX
         AaqQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro0mKBSGDZbli9R/XEyPAnCHt9nv7K4JrzZB7oShnkwk3eeFFxRfR+38hl4KCKae/fKs9kWpJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoLwRj+5xOMwmwqTDDrNRpXQ1JX+gQzr7ZqMVI+cfNlEk+zjXs
	2JmXEdyzUvsO/qCXy2XXAMR+6tQaZ7ikelwYpFUFL5IyECWag7t+jcHaLjuc0KVQDiI=
X-Gm-Gg: AfdE7cmSYxKXJXVtXknI1dZSUYDdztC2pS0PeH7an7XkOJ62/ezU3Sl5xKkspfpFU8U
	K91IZg9pjdEcGDglPy44E3xFD5EnKrJvzmvOmt4Cy5JB9ueZ4bF7SnLuA6+WGoO1NS8oaOnFrf/
	SI8sCUhSxA1wo5+uUCfKfkoewX0JYXWdSP/Ju+UzLCdXwDwUpev3b/WyajmhGHV1ToD9TUqfrrb
	sy239oapze3lal79gU5MmMuJhIc06OLXw8QQkZ5uXFvz3Q2GUUoSGqeNs1425v3kqjjlUFW5XFu
	oYPsGqSCqp+5aF4HV5izZxdD9fFLRJ4S2oPd7hDF9hb/+mksSVpGf/GYIhUR2u+vdd+zYqqi4ID
	xiicDpNesybQ7ahkzHKJ9KqjzWkh3VOvAfVt+C7mOAnqBoSu4DXJhUfyFYMb5vyegK1eAbbphZS
	nMrQ2fT9JYVc9xCd+6JSYJsl3NujIOdQs7NNHc
X-Received: by 2002:a05:7300:7245:b0:30e:c30f:fc53 with SMTP id 5a478bee46e88-30ee11ad71emr1226622eec.3.1782785597430;
        Mon, 29 Jun 2026 19:13:17 -0700 (PDT)
Received: from localhost ([2804:1b3:aa80:ec21:865b:5eb9:80c:c4c8])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-30ee32519aesm2311203eec.27.2026.06.29.19.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 19:13:16 -0700 (PDT)
From: Erick Henrique <erick.henrique.rodrigues@usp.br>
To: jic23@kernel.org
Cc: andriy.shevchenko@intel.com,
	andy@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	joshua.crofts1@gmail.com,
	linux-iio@vger.kernel.org,
	Erick Henrique <erick.henrique.rodrigues@usp.br>,
	stable@vger.kernel.org
Subject: [PATCH v1 1/1] iio: dac: m62332: Fix regulator reference count imbalance
Date: Mon, 29 Jun 2026 23:13:09 -0300
Message-ID: <20260630021309.36636-2-erick.henrique.rodrigues@usp.br>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260630021309.36636-1-erick.henrique.rodrigues@usp.br>
References: <20260630021309.36636-1-erick.henrique.rodrigues@usp.br>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

m62332_set_value() enables the Vcc regulator on every write of a
non-zero value and disables it on every write of zero, without tracking
the channel's current state. Because the regulator is reference counted,
changing a channel directly from one non-zero value to another enables
it more than once, while a later write of zero disables it only once.
The reference count never returns to zero and the regulator is left
enabled indefinitely.

Only enable the regulator on the transition from zero to non-zero, and
only disable it on the transition from non-zero to zero, using the
previously stored channel value to detect the edge. Balance the
regulator on the I2C error path so the reference count stays consistent
if the write fails.

Fixes: b87b0c0f81e8 ("iio: add m62332 DAC driver")
Reported-by: Jonathan Cameron <jic23@kernel.org>
Closes: https://lore.kernel.org/r/20260419144958.03394ed5@jic23-huawei
Cc: stable@vger.kernel.org
Signed-off-by: Erick Henrique <erick.henrique.rodrigues@usp.br>
---
 drivers/iio/dac/m62332.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/dac/m62332.c b/drivers/iio/dac/m62332.c
index 3497513854d7..b66b4c28859a 100644
--- a/drivers/iio/dac/m62332.c
+++ b/drivers/iio/dac/m62332.c
@@ -43,7 +43,7 @@ static int m62332_set_value(struct iio_dev *indio_dev, u8 val, int channel)
 
 	mutex_lock(&data->mutex);
 
-	if (val) {
+	if (val && !data->raw[channel]) {
 		res = regulator_enable(data->vcc);
 		if (res)
 			goto out;
@@ -52,14 +52,17 @@ static int m62332_set_value(struct iio_dev *indio_dev, u8 val, int channel)
 	res = i2c_master_send(client, outbuf, ARRAY_SIZE(outbuf));
 	if (res >= 0 && res != ARRAY_SIZE(outbuf))
 		res = -EIO;
-	if (res < 0)
+	if (res < 0) {
+		if (val && !data->raw[channel])
+			regulator_disable(data->vcc);
 		goto out;
+	}
 
-	data->raw[channel] = val;
-
-	if (!val)
+	if (!val && data->raw[channel])
 		regulator_disable(data->vcc);
 
+	data->raw[channel] = val;
+
 	mutex_unlock(&data->mutex);
 
 	return 0;
-- 
2.51.0

