Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700337;
	b=ANctgZRhj/nAgdo8XHxTdatWUvOFOtGE+dGb7XCoIKCAgjz/njrvj1gFVPl/FtO3VzEi
	 zWhd60aA9zdgMg/TTfLxclC1lx4+ttZ2nj/GYjLJB5T8nNrsILJCUzaf7Mw9cmCWltzBg
	 O13eYeTGdr4wWOeKUTjBniT5UEsoDHuPhvGS3i0rhYLzYaw6UbQB6cXma+xKnL+EbmVU+
	 a0bbjPnC6762ZHLYrmOJmqgQ8XPELgBlDs3R97foZ1e8r5oxMDNPpoJbzh9D5hnavAeSh
	 P+WDqn0PwmHCMZQn4OR88OHlnriRNwY7/py//s3tXnushhwfu2N4PSoBtrg3USYfpeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700337;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=HCukR9YFAOk3lavwPJ7DeboS3Lw+qEhNBmLe1sbsC3o=;
	b=1ZNef7yUvoxkvx66kxU0tExzbhGhTLjncVCQQrxqI+wdHfBg5aFCbJeKRIDXULw4TppT
	 Cal64UQDsZTYf/pG+7aE+ha1yV59aoWCbELPRuAYRu291eV2qUeySt40j9jM+0p8IC8A5
	 AFI16Dtza1s1NylfH76vTCSAB+KQ59Ln5BtieuHjf8TcLYEVDjeh7f+xZ7knfEWBwfASK
	 H57bZGZTgDrAndQOIB4dlmvHvomSId1Dq13zo56OMkEVqCk+ku3w6V1BA9tf36kmcu9QB
	 Crjp6txQVF4fetsD9qCbjX7rgbjjgO9a2yGTMomD3TwkiuN+q871ot/E7IsnElS4e3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F996083637;
	Tue,  3 Nov 2026 10:05:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24F996083637
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAAHGJnjselqfHs7AA--.2489S2;
	Tue, 03 Nov 2026 18:05:23 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Madalin Bucur <madalin.bucur@nxp.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] net: fman: drop the FMan device reference after port probe
Date: Tue,  3 Nov 2026 10:05:32 +0000
Message-Id: <20261103100532.1309969-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:rQCowAAHGJnjselqfHs7AA--.2489S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kry5ZFWUJw47WF15Zr45Awb_yoW8Zr1fpa
	yDGa909rWrG3WY9w1DXa1IvF10kw42y34rWryIyw4SqrsIvryrtrWUZFyvvF43ZFZ7Wa4Y
	yryUArZ7AFs8J3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9I14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26F4UJVW0owAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r
	4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26F4UJVW0ob
	IYCTnIWIevJa73UjIFyTuYvjfU7nmRUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRIAA2rpnIBh+QAAsf

fman_port_probe() looks up the parent FMan platform device with
of_find_device_by_node(), which takes a reference on the embedded
struct device.  The reference is released on the error paths, but not
after a successful probe, and the __devm_request_region() failure path
jumps directly to freeing the port.

As a result the reference is never dropped.  Put the FMan device and
the port node before returning success, and route the failed region
request through the existing cleanup labels as well.

Fixes: 18a6c85fcc78 ("fsl/fman: Add FMan Port Support")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/freescale/fman/fman_port.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman_port.c b/drivers/net/ethernet/freescale/fman/fman_port.c
index 1b8fef69114e..faf1e35399cd 100644
--- a/drivers/net/ethernet/freescale/fman/fman_port.c
+++ b/drivers/net/ethernet/freescale/fman/fman_port.c
@@ -1850,15 +1850,13 @@ static int fman_port_probe(struct platform_device *of_dev)
 
 	port->dts_params.fman = fman;
 
-	of_node_put(port_node);
-
 	dev_res = __devm_request_region(port->dev, &res, res.start,
 					resource_size(&res), "fman-port");
 	if (!dev_res) {
 		dev_err(port->dev, "%s: __devm_request_region() failed\n",
 			__func__);
 		err = -EINVAL;
-		goto free_port;
+		goto put_device;
 	}
 
 	port->dts_params.base_addr = devm_ioremap(port->dev, res.start,
@@ -1868,13 +1866,14 @@ static int fman_port_probe(struct platform_device *of_dev)
 
 	dev_set_drvdata(&of_dev->dev, port);
 
+	of_node_put(port_node);
+	put_device(&fm_pdev->dev);
 	return 0;
 
 put_device:
 	put_device(&fm_pdev->dev);
 return_err:
 	of_node_put(port_node);
-free_port:
 	kfree(port);
 	return err;
 }
-- 
2.34.1

