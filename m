Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1683A440A07;
	Thu, 17 Sep 2026 09:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789637823; cv=none; b=n+/KoIJ/aPfri8oSakXmApW6f2sl6mR6FiwEYK5mjcmdRMqzjt9rkLzM8lYtRVfNDbJ3B+xQPt/v0RcS8zKKuugcIHT28pPRlL3jk3sZQ2FInTtmxCF7SkEI/X+hkQp9/GZHZ8HVRqdAfaBhs0Wi8RcQwsf1HT5HUFEFtsBDRDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789637823; c=relaxed/simple;
	bh=Ef2hvkf7vwnpshLd3Fy/dachfnpC6W2xudbHwBNL/5k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kOdcFxlVf9jZ9+lhE0YDAWWbpsxTi1hNLGBE3j7BVUXhHe7IOLNY35OFvsxzDCfX/B3Lnx9tMGwhc6c+mLhq9Of6hRAphkR81LDW/9gtSimrpogxN7D21OlgA213TAsg4tAArcKs51hrjNDpnEUIXrKF1U7NntqOTb29l30IqQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABnmEKptKtqGcd9CA--.40725S2;
	Thu, 17 Sep 2026 17:36:41 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: lee@kernel.org
Cc: linusw@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	pavel@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] leds: netxbig: Fix platform device reference leak on successful probe
Date: Thu, 17 Sep 2026 09:36:41 +0000
Message-Id: <20260917093641.2144866-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABnmEKptKtqGcd9CA--.40725S2
X-Coremail-Antispam: 1UD129KBjvdXoWrurW5Cw1DXr4rGr45tr47Jwb_yoWDXwb_ur
	yIg3s7XFW8XF40yw15Zr1YvryfCFsrXF48ursFvas5JrW3XrW3WrWq9r98Cr1DZa1xAFn8
	CFnruF15Aw17WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbsxFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
	wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
	vE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280
	aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07
	x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17
	McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij
	64vIr41l42xK82IY6x8ErcxFaVAv8VW8GFyrJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0x
	ZFpf9x0JUdKsbUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgINA2qrq3Yp0AAAsv

of_find_device_by_node() returns the GPIO extension device with an
elevated reference count.  The error paths release it through the
put_device label, but the success path returns directly, so the
reference is leaked whenever the LED driver probes successfully.

Let the success path fall through to the put_device label.

Fixes: 9af512e81964 ("leds: netxbig: Convert to use GPIO descriptors")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/leds/leds-netxbig.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/leds/leds-netxbig.c b/drivers/leds/leds-netxbig.c
index 99df46f2d9f5..d79fee1d9143 100644
--- a/drivers/leds/leds-netxbig.c
+++ b/drivers/leds/leds-netxbig.c
@@ -597,8 +597,7 @@ static int netxbig_leds_get_of_pdata(struct device *dev,
 	pdata->leds = leds;
 	pdata->num_leds = num_leds;
 
-	return 0;
-
+	ret = 0;
 put_device:
 	put_device(gpio_ext_dev);
 	return ret;
-- 
2.34.1

