Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5108A4D0CC6;
	Thu, 17 Sep 2026 11:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789643177; cv=none; b=K2z8VMclJbGCn3IX3Ntm7QxKBwlDjqBkmpEFVWXpaFzYvqokXhQDeTWwnfxFV+IGc5L6fCwIEFyFJhZeEWhdkHPr30x6LRm0NrQxTkhW+yzNPoAD1e6yCQDN1rWwXj7NVu+WAG9/P0vnH26lzrKsHOYnLXuoonVSeTPQR0+4RC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789643177; c=relaxed/simple;
	bh=gSClzTFNpD/qCzeEwfCnrVD1VXkso6K+4DyfErUMGTM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jHT9Fr927/esw7MijW9QT1JE29FUZWZgKpgCScF73lZlV+vRW3fR+ABgNMQvL8Z1GwqaJ4rrFlwJrMJsGgWA0OVsUmZwjoAz9ZofIo6WwluaktGHTbH8znCAT7svUfjGL4UtNQj7FwspnIYdbZ+plPr582Y5nnDIhECGfkU3yhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACnFD+SyatqLjR_CA--.1286S2;
	Thu, 17 Sep 2026 19:05:55 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andrew+netdev@lunn.ch
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	madalin.bucur@nxp.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sean.anderson@linux.dev,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] net: dpaa: Fix tbidev reference leak in dtsec_initialization()
Date: Thu, 17 Sep 2026 11:05:54 +0000
Message-Id: <20260917110554.2148240-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACnFD+SyatqLjR_CA--.1286S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr4kCFy3JFWUXw1kCw1fXrb_yoW8GrWfpa
	yUCFW7AF18Jw1rCa1DXw40gryY9a1Iy34rGrySyws3Wr1Fkry2vrWUXay8Wr42vFWkCFW2
	vw17Aa1rZrn8t3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPmb7Iv0xC_KF4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI
	0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4
	AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq62Iq12xI8VA0II8E6IAqYI8I648v4I1l
	FIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr4
	1l42xK82IY6x8ErcxFaVAv8VW8GFyrJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw
	0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVW8Jr0_Cr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_GcCE3sUvcSsGvfC2KfnxnUUI43ZE
	Xa7IU8rR65UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRMNA2qrq01npgAAsy

dtsec_initialization() takes a reference on the PCS mdio device with
of_mdio_find_device(), but only releases it in dtsec_free(), which is
called from the error paths. The successful path returns without
dropping it, leaking the reference.

Release the reference once the PCS has been set up. The device stays
registered for as long as the FMan device, which mac_dev holds a
reference to.

Fixes: 5d93cfcf7360 ("net: dpaa: Convert to phylink")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/freescale/fman/fman_dtsec.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fman/fman_dtsec.c b/drivers/net/ethernet/freescale/fman/fman_dtsec.c
index fe35703c509e..2a503bc5bc28 100644
--- a/drivers/net/ethernet/freescale/fman/fman_dtsec.c
+++ b/drivers/net/ethernet/freescale/fman/fman_dtsec.c
@@ -1492,6 +1492,12 @@ int dtsec_initialization(struct mac_device *mac_dev,
 	dev_info(mac_dev->dev, "FMan dTSEC version: 0x%08x\n",
 		 ioread32be(&dtsec->regs->tsec_id));
 
+	/* The PCS device is registered as long as the FMan device, of which
+	 * mac_dev holds a reference, so the reference taken above is not
+	 * needed anymore.
+	 */
+	put_device(&dtsec->tbidev->dev);
+
 	goto _return;
 
 _return_fm_mac_free:
-- 
2.34.1

