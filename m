Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701735;
	b=0wkZgjB6nZN1+v4nCu9xHNlg3B/5iIR1doSffY9c+MADCRFCZC2wf6TYAPxOWx+9Zrou
	 kuU9Xq8RarFr+QuDkMBjnNq3kMOoWfnEkBO1i/UFMoLaPkDsv25HfRXDXaB0ZJ15HMjHv
	 YNy1lCZ4j/BmhoeWRDIr2iAJhBarphdd2m/O4NnPXdJc/Ub4hyuAlta/DG2RFdpSaGt5o
	 UqxlCCZ4qFJ+JKGjAXy7O+Bl4DEZ0HSX0hUvcKEJ3Bw+G/Jl+l/B65P7X7ZbJCMA9E1l3
	 MDEIhKKiRsO61eRkbLCjmLlP85mq6X0l3ZoLv5OJbticLMJMbjHTqcOOMMZ2ylGzgMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701735;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=SH6pWyjcaIWCi7EaeIAaLCITGwbCLBmKt3Bf613xvM8=;
	b=QlD3NmHxlBesURXRW1otojxFIkveLzq3homebmWxpN70ZdQ4kqdvnZoKy02xI4zFJSIi
	 9IheMnkilPe9bW1pkR/j1a8EiEBkcwiMJZTUJTBdvdgBR7bYI1GkiUsVBrOuRsx3MpSO9
	 X5+2dFWwGGDE3gLqE38+sEs0N27/r/wHqrx6RNWJv1hOZg7KNhoy0BFEMyqkGuOkl5eWN
	 00w0b+BuDHx4w+ueCnPhCz77sInMZyo2vRfxclc+aubkEObRWrWNPI9orw0BRELvQp/P/
	 OcBV3lBjFte2y72Qlkhg0gP6PkjnTfBnvET/09evHPvL55oRBMugW0saIxhbOiijCEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867C460A6F54;
	Tue,  3 Nov 2026 10:28:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 867C460A6F54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAAHF5hdt+lql6k7AA--.3080S2;
	Tue, 03 Nov 2026 18:28:45 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>
Cc: netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] net: lan969x: fix page pool leak when RX DMA allocation fails
Date: Tue,  3 Nov 2026 10:28:54 +0000
Message-Id: <20261103102854.1340615-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowAAHF5hdt+lql6k7AA--.3080S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJryUArWkuw4rXry8XF15twb_yoW8Xr45pF
	W5K34vk39Fgr43J3WUGrs7A34Uta1FgrWDWF97C3Z5u34rGr45Cr1UAa43Xr1UJrWxGF4S
	yF40ywn5CFnrC37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAIAA2rpnOFw-QAAs+

lan969x_fdma_rx_alloc() creates the RX page pool and then allocates the
FDMA coherent memory. If fdma_alloc_coherent() fails, the function
returns without destroying the page pool.

The failure propagates out of lan969x_fdma_init(), and
sparx5_frame_io_init() then marks the FDMA IRQ as unavailable, so
lan969x_fdma_deinit() is never called on teardown and the page pool is
never released. Destroy it before returning the error.

Fixes: d84ad2c0d80c ("net: lan969x: add FDMA implementation")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c
index 053d125eda65..bc293ba1707d 100644
--- a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c
+++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c
@@ -169,8 +169,10 @@ static int lan969x_fdma_rx_alloc(struct sparx5 *sparx5)
 		return PTR_ERR(rx->page_pool);
 
 	err = fdma_alloc_coherent(sparx5->dev, fdma);
-	if (err)
+	if (err) {
+		page_pool_destroy(rx->page_pool);
 		return err;
+	}
 
 	fdma_dcbs_init(fdma,
 		       FDMA_DCB_INFO_DATAL(fdma->db_size),
-- 
2.34.1

