Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC3140BCDF;
	Wed, 16 Sep 2026 09:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789550621; cv=none; b=HDr3h8U7h4lspZU5IkhrdWodEgyqAtQhn9oYYBA5pCVc/a3bQLF4p21UW3HKURKlKAsOmX9zgV0fAbS5uo+W8x8j3lKF1BXGQyhx2iTEp9OvV51ft5+Sw/GKOi//H/boo5O4aLM2X/qvT4NJ+77HIrVPP7YA8T9etxF2De91f6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789550621; c=relaxed/simple;
	bh=0JwYYUnY0GbSNQJ5HjMh+8QQ58Sjj8//KwvqlvMvPrI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ixKYR/FjDgR/HcGRXtfvcSZn6NSWPmusbYjd/9B163poM8i9Sij8gxBmyn68499YSOjDJ5pPS7KusMT8ImR1ghZQ6LJmhYRLbapEv3c+5wc4HK4RyzhPr9Q26FG88x2aI5aArjgIQTambT5BZBRkj+Je62sUYBUbuILZ8xKoW0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAC3wD7+X6pquUXgBw--.25084S2;
	Wed, 16 Sep 2026 17:23:10 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: biju.das.jz@bp.renesas.com
Cc: lee@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	wbg@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] counter: rz-mtu3-cnt: Fix runtime PM leak in rz_mtu3_count_enable_write()
Date: Wed, 16 Sep 2026 09:22:42 +0000
Message-Id: <20260916092242.2001358-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAC3wD7+X6pquUXgBw--.25084S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFWUZF4rCw47JF18Ww4UJwb_yoW8Ar1fpa
	1jqryFyrWxZrZ2kan7J34DXFyagw4SyFZ5GFy8G3W8Z3WrAwn0va4DWF4YqF10yrykJF1j
	grn7Ww1UCFWjyr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8
	JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUb
	khL5UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRIMA2qqP4eK5wAAsB

When enabling a counter, the runtime PM reference taken by
pm_runtime_get_sync() is never dropped if rz_mtu3_initialize_counter()
fails and returns an error, e.g. -EBUSY when the channel is already
requested. Because priv->count_is_enabled[] is left false, a subsequent
disable write also takes the early exit path, so the reference is never
recovered. Additionally, if pm_runtime_get_sync() itself fails the
device usage count is left incremented while the hardware is still
accessed with runtime PM suspended.

Use pm_runtime_resume_and_get() to resume the device and bail out if it
fails, and drop the runtime PM reference when
rz_mtu3_initialize_counter() fails.

Fixes: 0be8907359df ("counter: Add Renesas RZ/G2L MTU3a counter driver")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/counter/rz-mtu3-cnt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index 7bfb6979193c..2bfc92bea757 100644
--- a/drivers/counter/rz-mtu3-cnt.c
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -504,10 +504,15 @@ static int rz_mtu3_count_enable_write(struct counter_device *counter,
 		goto exit;
 
 	if (enable) {
-		pm_runtime_get_sync(counter->parent);
+		ret = pm_runtime_resume_and_get(counter->parent);
+		if (ret)
+			goto exit;
+
 		ret = rz_mtu3_initialize_counter(counter, count->id);
 		if (ret == 0)
 			priv->count_is_enabled[count->id] = true;
+		else
+			pm_runtime_put(counter->parent);
 	} else {
 		rz_mtu3_terminate_counter(counter, count->id);
 		priv->count_is_enabled[count->id] = false;
-- 
2.34.1

