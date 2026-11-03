Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701751;
	b=Bp9Y8w9PtiCXC20JvONalU1flDJOT8+GyeadlH7zSiYch6dQIu7j7jc1kCHFM66jzWj+
	 3WlvsYBZfSgof/OGbsHdG2BkYFXlqGvOHpME5xKiPTDrqcN1IcS8WcTqZV8ki69GOWOjT
	 4DRTfsaz/LjPO0ubwg4EhkmUmlCIlO727rLDcABGkQA7VKijUJ9rR8hjcpGL3AxIcQRU6
	 Dd+OnnRieGL7XB2qHnh03IzDarU20j4UsTuT8iXWdYBkl5IKUtAE69vCB7w9pNdUU/yX6
	 h20GxP0lQfZPv0s5TWcPo4Z/oLgRpX0elIykBgcTyiwTw86M+UHEt48nqwYoNX6Jh4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701751;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=Sq5pkJ4dDKFfmxxEMlmXLLB6zlzoMLxvzD0Txx7Viqk=;
	b=wmXHKWa9I/2GrPTYLvkCq/Xe51Ty4gkMGwnsHh/x/dzvFChhk/DiUitO5BXlP83gc7Yl
	 o1yCf4I9stvNTW2pDMq1jBeXeUbR3tjXx2I443u9wOKYfIfKuc4lHuDTipH75M33s6ct9
	 SAPUrDNvIpFfaPC+HVgK7M9ut5J5Wb4xp0dOiwWKBclTrhLYIBHmEtM+2DuDL3zY5EzLN
	 nOp5pFOebtVSxqZCe2i7Ue2ldYMYl53sO+TzSQw4qrXxaiIP8izwCknkGoYsCtrzSGFPv
	 DjLBAXcsDSeIjBZgb6M755B/CzAo1Noy2/Ow1cwGdaHgcp0YMz7Enlj+zj6HO7T5F/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9F560784AB;
	Tue,  3 Nov 2026 10:29:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA9F560784AB
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAAXIZJwt+lqT6o7AA--.2753S2;
	Tue, 03 Nov 2026 18:29:04 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH RESEND] net: ethernet: ti: cpts: drop the refclk mux node reference
Date: Tue,  3 Nov 2026 10:29:13 +0000
Message-Id: <20261103102913.1341095-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowAAXIZJwt+lqT6o7AA--.2753S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XFWfGrW5Wr4fZryktrW8Zwb_yoWkuFb_Wr
	1Igw1fta4UGrsYka12yrsruasakFyqqFyxWa1Ikay3t3srGFW0yr15ZF4rA347WrWxGrn8
	Jrnrta13Zw12vjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j
	6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26F4UJVW0obIYCTnIWIevJa73UjIFyTuYvjfU1U
	UUUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAQAA2rpnOFxKQAAst

cpts_of_mux_clk_setup() obtains refclk_np with of_get_child_by_name()
and only drops that reference on the error path.  of_clk_add_hw_provider()
takes its own reference through of_node_get(), which
of_clk_del_provider() releases later, so the reference taken by
of_get_child_by_name() is leaked when the mux clock is registered
successfully.

Drop the caller's reference once the provider has been registered and
its devm cleanup action is in place.

Fixes: a3047a81ba13 ("net: ethernet: ti: cpts: add support for ext rftclk selection")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/ti/cpts.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpts.c b/drivers/net/ethernet/ti/cpts.c
index 2ba4c8795d60..372cef13d81e 100644
--- a/drivers/net/ethernet/ti/cpts.c
+++ b/drivers/net/ethernet/ti/cpts.c
@@ -714,6 +714,8 @@ static int cpts_of_mux_clk_setup(struct cpts *cpts, struct device_node *node)
 		goto mux_fail;
 	}
 
+	of_node_put(refclk_np);
+
 	return ret;
 
 mux_fail:
-- 
2.34.1

