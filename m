Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B151F3859DC;
	Wed, 16 Sep 2026 16:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789576770; cv=none; b=MHzMlBVHZc5Z4pbUl6pdEmGp5+xPhLBQB63wrfX4/rVThCLtTalQ2s5uFvy2eHHz0aSSTODpXm9ndXKrTIDiFOZMVoVe3MWUrf8/lSp6OH26DzIs5cl96pU7fGqU67WmvI0X1upzh8Mck4PeiSxBbWGGlK3uxjU9gqsBofWsOtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789576770; c=relaxed/simple;
	bh=B61Ra12zeoK9XG2kSJuOAnLgLOmAa0B5tmcXfFgbSko=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hMs7/7aDWq4+IgWZ3+wLVC1koSL43W8CSD2T8oSuLe9vqY89tDhpdHZ0oWg9c8/nSJPfFVVZe85XjWSGAjye+WwLZwlKT/BFjWjUY0uY2Nu8QEhG/n3+GMO8wpfcdDN17OTl+843bbbpUa+f/t4aLDVW9VBkSF+Du3YvEiColvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAA3pD44xqpq0M5tCA--.21474S2;
	Thu, 17 Sep 2026 00:39:20 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andy@kernel.org
Cc: dlechner@baylibre.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com,
	rajat.khandelwal@linux.intel.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] iio: pressure: mpl115: Fix runtime PM leak in mpl115_read_raw()
Date: Wed, 16 Sep 2026 16:38:52 +0000
Message-Id: <20260916163852.2084375-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAA3pD44xqpq0M5tCA--.21474S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar43Wr43Ww4kGryUKF47twb_yoW8Xry7pr
	W7ZFWYyry8Jr4xJw40yF1DuFy5WayfKrW7JrZ7Wa18Zw45Z3W5tFyUJr1rtF10kF95Zrs8
	X34DtF45CF1SyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
	xVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8
	JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUb
	o5l5UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwgMA2qqpVhOQQAAsy

pm_runtime_get_sync() increments the usage counter even on failure,
so every successful call must be paired with a put. Both sensor read
failures returned early and skipped the paired
pm_runtime_put_autosuspend(), permanently preventing runtime suspend.

Fixes: 0c3a333524a3 ("iio: pressure: mpl115: Implementing low power mode by shutdown gpio")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/iio/pressure/mpl115.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/mpl115.c b/drivers/iio/pressure/mpl115.c
index 830a5065c008..3266b79bdab8 100644
--- a/drivers/iio/pressure/mpl115.c
+++ b/drivers/iio/pressure/mpl115.c
@@ -106,8 +106,10 @@ static int mpl115_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_PROCESSED:
 		pm_runtime_get_sync(data->dev);
 		ret = mpl115_comp_pressure(data, val, val2);
-		if (ret < 0)
+		if (ret < 0) {
+			pm_runtime_put_autosuspend(data->dev);
 			return ret;
+		}
 		pm_runtime_put_autosuspend(data->dev);
 
 		return IIO_VAL_INT_PLUS_MICRO;
@@ -115,8 +117,10 @@ static int mpl115_read_raw(struct iio_dev *indio_dev,
 		pm_runtime_get_sync(data->dev);
 		/* temperature -5.35 C / LSB, 472 LSB is 25 C */
 		ret = mpl115_read_temp(data);
-		if (ret < 0)
+		if (ret < 0) {
+			pm_runtime_put_autosuspend(data->dev);
 			return ret;
+		}
 		pm_runtime_put_autosuspend(data->dev);
 		*val = ret >> 6;
 
-- 
2.34.1

