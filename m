Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700324;
	b=27e9auQJ8qVJuKyiM4YkvCYAOhk7NG/FRXVgnG8dh0FbuU8VLEtMJPAIuIrlNXJRQxWt
	 JHt5Xs7rGMUzihbMQdAlyU99uLfoWvm0lfuhzqAvCRWStQHjyPO+dFUN0orapu9fiueGX
	 w8ooovH1qqc0jp9QaW6rQSvtZ36Ea+h3u+qf0HPWn/4Nc0aUhPbQmiiZrnXjFRc5Grc/5
	 EXj6Vlzp7b4Z9jT1cEFaxDXTMbuarz8MiERp5VA3JsZ1wRaKFwvfA+94YX2TNqdmV7iUb
	 qJdYX3sDb56xGpftsOjdhUI6JxI09MU2WEvE1jZ4ohd7geKoEjzkZlzS5zzBTgNCwKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700324;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=YlNlVAcPWUNRtsNR7hk0+HPeva5tIE0ce70Ma2ooFWU=;
	b=0ET0Dqps8adg7gNgWpH5u7u3bYhgZobXE0WfrncZGWsk9FDV7M6GXQFBgVkN2CxlGEDv
	 QeX2IEdf9jrFeLnv6GDGU8r16FvYlAM+ATEbbhko71c/R+th2SVIu5TGnct5DOd8zeSuO
	 HfTV/VYbPB9k7CJR9ePJJddAi9K8skDCBGrN6HQDLPk0qkT2nfYc6cztwUvadTDySuteH
	 LNaGCzTfTBTPi01T3Plw5XLW3FZpl61Cbu3rK1RuHBpk1ZoGiKm3dX9A+wBgrXCTisF3n
	 AhAupJtb7VvxKJjFJQNsjGAtHonulHpprh5Uz4KR9ghEmNtZSi6UtiKMSRI2hsBQMvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC304606A800;
	Tue,  3 Nov 2026 10:05:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC304606A800
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAAnOJndselqQns7AA--.2828S2;
	Tue, 03 Nov 2026 18:05:17 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] can: flexcan: fix device node reference leak in stop mode setup
Date: Tue,  3 Nov 2026 10:05:26 +0000
Message-Id: <20261103100526.1309829-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowAAnOJndselqQns7AA--.2828S2
X-Coremail-Antispam: 1UD129KBjvdXoWruw13Gr17Jw1DZr43Ar47urg_yoWkArc_Gr
	92vFZrWw1UCrnFkw4ktr43ur9a9F1DXrZ5Xw4xta98GasxXr18Jry5Zr45WwnrJF4rZFyr
	GasrXry8Kw4UXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWxJr0_GcWlOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4U
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VU1K9aJ
	UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwUAA2rpnO5fMwABsd

of_find_node_by_phandle() returns a device node with an incremented
reference count. flexcan_setup_stop_mode_gpr() drops it only when
syscon_node_to_regmap() fails, so a successful probe of a controller
using the GPR stop mode leaks one reference on the GPR node.

Release the reference on the success path as well.

Fixes: de3578c198c6 ("can: flexcan: add self wakeup support")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/can/flexcan/flexcan-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index 86b40abe9e76..30ae7c344a05 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -1986,6 +1986,7 @@ static int flexcan_setup_stop_mode_gpr(struct platform_device *pdev)
 		"gpr %s req_gpr=0x02%x req_bit=%u\n",
 		gpr_np->full_name, priv->stm.req_gpr, priv->stm.req_bit);
 
+	of_node_put(gpr_np);
 	return 0;
 
 out_put_node:
-- 
2.34.1

