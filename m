Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A474DAFAF;
	Thu, 17 Sep 2026 11:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789645288; cv=none; b=oTUFl8ssGuQP996nK6buORQ/wy/Zk59U4rXe0O9+G9uAkAoUzsomcxVeCnUJY7gEUnn+jwAQmI8d6HYuj3IiAIwpXcpb2LcPU/nWywzPjMoKdwv8qTvX7qTfqs9QRWrqOnlycV911VBef5DCxICCv3cjBXo+3AC1+Ljv3/uNbos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789645288; c=relaxed/simple;
	bh=G4tBU2xwzzN7nP3tiN75K2XSOzpLIfR7AQF2wau8C6M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RMs11XE5JXClteDPjwqpAsDCirrIfQqHYFy/3v37bTZ2x40XZyODaEH7/uYrVPxzqHHBUIQs12YcL6zK+xlnOWtwPO1PlqR9rAUzSoBOSoWmWd83vOMQG9JckFvUUeguxBTQCMZp46yP3CqDyo9ox10GEF0HSTtlZT11Lcpxd7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAC3Hzre0atqzcJ_CA--.1971S2;
	Thu, 17 Sep 2026 19:41:19 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andrew+netdev@lunn.ch
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	wellslutw@gmail.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] net: ethernet: sunplus: Fix ethernet-ports node leak in spl2sw_probe()
Date: Thu, 17 Sep 2026 11:41:18 +0000
Message-Id: <20260917114118.2149439-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAC3Hzre0atqzcJ_CA--.1971S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Jr4UZw17XF1kJryDtr4fKrg_yoW8Jr1Dpa
	1UG3yYkrZ7KrsrG3Z29F48AF98Ca4Dt3yUuF18twnY93s5Zry3Jr4jvF4j9r43ArW0gFW7
	tryqyr98AFZ8A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPmb7Iv0xC_tr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI
	0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4
	AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq62Iq12xI8VA0II8E6IAqYI8I648v4I1l
	FIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr4
	1l42xK82IY6x8ErcxFaVAv8VW8GFyrJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw
	0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVW8Jr0_Cr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_GcCE3sUvcSsGvfC2KfnxnUUI43ZE
	Xa7IU878n5UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAANA2qrrJpz6AAAsu

spl2sw_probe() gets a reference on the "ethernet-ports" child node but
never releases it, neither on the error paths that go to out_free_mdio
and out_unregister_dev nor on the successful return. Release the
reference automatically by declaring the node with __free(device_node).

Fixes: fd3040b9394c ("net: ethernet: Add driver for Sunplus SP7021")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/sunplus/spl2sw_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sunplus/spl2sw_driver.c b/drivers/net/ethernet/sunplus/spl2sw_driver.c
index 5e0e4c9ecbb0..fdc9c3196738 100644
--- a/drivers/net/ethernet/sunplus/spl2sw_driver.c
+++ b/drivers/net/ethernet/sunplus/spl2sw_driver.c
@@ -319,7 +319,7 @@ static struct device_node *spl2sw_get_eth_child_node(struct device_node *ether_n
 
 static int spl2sw_probe(struct platform_device *pdev)
 {
-	struct device_node *eth_ports_np;
+	struct device_node *eth_ports_np __free(device_node) = NULL;
 	struct device_node *port_np;
 	struct spl2sw_common *comm;
 	struct device_node *phy_np;
-- 
2.34.1

