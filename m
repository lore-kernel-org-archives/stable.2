Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130974A1DE6;
	Thu, 17 Sep 2026 10:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789642181; cv=none; b=Zk2zd8f+hP0YHDEzaksjdhbJQ6zmBrxhaD58n3Iw5dqkHfSjE5uo1tbDt+S8JBGEjod8FwLJs72jR/iWyh5IFRPak0wzSKrEI8Q48qGYIngzieIvfO0zjYiJ5OupfrqAq4+wPTf8EMYwe1w7F1GLu7U+pQ+qWwTu/cc+KDz+/2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789642181; c=relaxed/simple;
	bh=iSQaqQpju7/eJCnj3v12vexOzggjQmqb57hg0K4Bnps=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HjEjPfl10UcmZdc90Ab3bCyZle4rNjjNDINxhirYt+9Fy4gvLCU/5RphDWMyPUD3pEBexM6an5lzb47GiUF9uiEzcoagp/6RqJRUACCuqD5AJhpHhtCB+bCvW4QxsN1gGa3JDtB4zB48asxcLmdkgzqSCyo2VkXgmUx9NGNQaiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAD3J0KwxatqjfR+CA--.42028S2;
	Thu, 17 Sep 2026 18:49:20 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andrew@lunn.ch
Cc: davem@davemloft.net,
	edumazet@google.com,
	f.fainelli@gmail.com,
	kuba@kernel.org,
	linusw@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	olteanv@gmail.com,
	pabeni@redhat.com,
	paweldembicki@gmail.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] net: dsa: vitesse-vsc73xx: Fix SPI device reference leak in vsc73xx_spi_probe()
Date: Thu, 17 Sep 2026 10:49:20 +0000
Message-Id: <20260917104920.2147568-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAD3J0KwxatqjfR+CA--.42028S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw1fXFy3KF18KFy5Xr4kCrg_yoW8GFW8pF
	WUXFZ5CF98Gr4DGa1xJws5W3W3Ga18ZFyS939xG3Wru3yrZFyUJFyUXayj9F45GFW8Ka1r
	CasFvr1rur4fZr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI
	0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4
	AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq62Iq12xI8VA0II8E6IAqYI8I648v4I1l
	FIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr4
	1l42xK82IY6x8ErcxFaVAv8VW8GFyrJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw
	0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r4UJVWxJr1lIxAIcVC2z280aVCY1x0267AKxVW0oVCq3bIYCTnIWIevJa73UjIFyTuY
	vjxUqdHjUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgkNA2qrq3ZcCQAAsI

spi_dev_get() takes a reference on the SPI device, but neither the
probe error paths nor vsc73xx_spi_remove() ever release it, so the
spi_device can never be freed after the driver has been unbound.

Release the reference on both probe error paths and in remove().

Fixes: 95711cd5f0b4 ("net: dsa: vsc73xx: Split vsc73xx driver")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/dsa/vitesse-vsc73xx-spi.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-spi.c b/drivers/net/dsa/vitesse-vsc73xx-spi.c
index 85b9a0f51dd8..7b784320c41e 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-spi.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-spi.c
@@ -153,10 +153,15 @@ static int vsc73xx_spi_probe(struct spi_device *spi)
 	ret = spi_setup(spi);
 	if (ret < 0) {
 		dev_err(dev, "spi setup failed.\n");
+		spi_dev_put(vsc_spi->spi);
 		return ret;
 	}
 
-	return vsc73xx_probe(&vsc_spi->vsc);
+	ret = vsc73xx_probe(&vsc_spi->vsc);
+	if (ret)
+		spi_dev_put(vsc_spi->spi);
+
+	return ret;
 }
 
 static void vsc73xx_spi_remove(struct spi_device *spi)
@@ -167,6 +172,8 @@ static void vsc73xx_spi_remove(struct spi_device *spi)
 		return;
 
 	vsc73xx_remove(&vsc_spi->vsc);
+
+	spi_dev_put(vsc_spi->spi);
 }
 
 static void vsc73xx_spi_shutdown(struct spi_device *spi)
-- 
2.34.1

