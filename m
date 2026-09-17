Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A229E45C6E3;
	Thu, 17 Sep 2026 11:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789645449; cv=none; b=hA3KqcOtZIUUGwvbN1S9UYnNLAc/AIWSWzVmwedNIIx5gDLGST64vRh5KE/Aygxn00UfPJmGjntV0BWC8zfoYNiLB/PIddIKSjc2AlmClcW9+IHyqcONDtoK5B0Fkl0T6Oo5PREz0rQXdfdaXoIHklhDE2FuowvEOyhrZFrZ4/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789645449; c=relaxed/simple;
	bh=2R4/mAlxNzoxBJLYHba8qKjPuoWKlotG7O16qtL9keI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ADSdLFEB7hmT32Vn3f18I6Frvm/juHctMRNtDNPWu14rW4RIrlMoArLm2sccYA0wOlTPeFWtBCb+5Rv+jV72kRKeOJUSUoqYZ5ayRIyUDJUBkY9jota/UQjG9/WG61ZHfmX/Gvkm3/3zlXCj9d0TlsLtoyBgO0p8sOemx4aqZDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABHsTty0qtqls1_CA--.1875S2;
	Thu, 17 Sep 2026 19:43:47 +0800 (CST)
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
Subject: [PATCH] net: ethernet: sunplus: Fix port node leak in spl2sw_probe()
Date: Thu, 17 Sep 2026 11:43:47 +0000
Message-Id: <20260917114347.2149525-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABHsTty0qtqls1_CA--.1875S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFyUWFyDXF1rCr1xKryxGrg_yoW8WrWUpa
	1UCayYkrZ7GFsrW3Z2vr18AF98uw1DK3y09F48CwsY93s5Zry3Jw4jvFyY9r45ArW8KFW3
	tr1qyas8JF4DC3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPlb7Iv0xC_tr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
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
	c7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
	AFwI0_Gr1j6F4UJwCI42IY6I8E87Iv6xkF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZF
	pf9x07j8jjgUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAENA2qrrJp1WgAAsb

spl2sw_get_eth_child_node() returns a child node with a reference held,
but spl2sw_probe() never releases it: the node is leaked on the
"failed to get phy-mode" and "failed to get phy-handle" continue paths,
on the out_unregister_dev error paths and when the loop ends. Declare
the node inside the loop with __free(device_node) so the reference is
released on every iteration exit.

Fixes: fd3040b9394c ("net: ethernet: Add driver for Sunplus SP7021")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/sunplus/spl2sw_driver.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sunplus/spl2sw_driver.c b/drivers/net/ethernet/sunplus/spl2sw_driver.c
index fdc9c3196738..c124e5ef3588 100644
--- a/drivers/net/ethernet/sunplus/spl2sw_driver.c
+++ b/drivers/net/ethernet/sunplus/spl2sw_driver.c
@@ -320,7 +320,6 @@ static struct device_node *spl2sw_get_eth_child_node(struct device_node *ether_n
 static int spl2sw_probe(struct platform_device *pdev)
 {
 	struct device_node *eth_ports_np __free(device_node) = NULL;
-	struct device_node *port_np;
 	struct spl2sw_common *comm;
 	struct device_node *phy_np;
 	phy_interface_t phy_mode;
@@ -418,6 +417,8 @@ static int spl2sw_probe(struct platform_device *pdev)
 	}
 
 	for (i = 0; i < MAX_NETDEV_NUM; i++) {
+		struct device_node *port_np __free(device_node) = NULL;
+
 		/* Get port@i of node ethernet-ports. */
 		port_np = spl2sw_get_eth_child_node(eth_ports_np, i);
 		if (!port_np)
-- 
2.34.1

