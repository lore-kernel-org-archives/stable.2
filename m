Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700332;
	b=EtDUEc98ZzKL59lt6zodEKjnTEcpow9dIo8nMS2C8lC4MrtqUrK7lNWy9eI8R88JMMBd
	 ViRFM3nj6+xlNHOAQ04YNlTCzcoFy6HfBKyb94QgsdmqkAsZeRW1EZdDCJgpzaKfc9wrx
	 p1iSMweIj4l+4rw2t7bw5000Rji0XZsE2++sidezN35auNzBkbEZqdx8De/zP3blh2qiB
	 aexD9X2KmfjEOXJ7/3E2sCdjFgeoP+S5qcdhBgLy70MADF1x9BKf9M+hNKSSFIKNcUJ4M
	 MbFDm7nFoXlv3MKbcFmzcaN+bSHGtc9zbbI2kdHsbvobMR9SViAdnY3OtTgO5ivcT5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700332;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=o8k6JoI68x+KJ7olmaL8VyaizwY+3r59nNSZdwwjQLI=;
	b=3K500+1KkiamJf6U8Ewg/xNnD6y0USUvqqRCOeCagjos9ID256QXF7Xgk8+nDztwWnGL
	 We+uivpsonY54rZOQvVDQSuwVZTdMlP/z2HM6rgO6+EyQR8Am4u5gwJXx4/Y2loPZVcyH
	 x+uQfpPUTWqSaw2NSmqIDBTIWtgdQxE4PyVHd2XxtjXh7bupZPmTAQx7gfPNqbdr/NZ9X
	 1HUoKKNbuuNh3VCRmNRt6LZZhrXiDFVHXgEkI1IlaVG3M8SwcfrFV2UWkS+dmEgBPHelV
	 1A99NwxSjWMOVrwpk50edEr/tUb/NHRylVr25WBlqrDbCRNAuVEF/asOQUF/BVy3fFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC58E606FAE7;
	Tue,  3 Nov 2026 10:05:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC58E606FAE7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACHkpPjselqhns7AA--.2931S2;
	Tue, 03 Nov 2026 18:05:24 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Elad Nachman <enachman@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] net: prestera: release the ruleset in prestera_flower_prio_get
Date: Tue,  3 Nov 2026 10:05:32 +0000
Message-Id: <20261103100532.1309990-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowACHkpPjselqhns7AA--.2931S2
X-Coremail-Antispam: 1UD129KBjvJXoW7GFWftryUtrWruF1kJw17GFg_yoW8JF18pr
	W8CrWY9r18JF48ta9rGw18ZFn09ayaq3srKrs5CwnY9r4rGrZ7CryDWw4IgrnrAr4rXFyf
	Xr45Cw1UuFn8WaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRQAA2rpnIBh+wAAsb

prestera_flower_prio_get() looks up the ruleset with
prestera_acl_ruleset_lookup(), which increments its reference count,
but returns without calling prestera_acl_ruleset_put().

The ruleset reference is leaked on every successful priority query.
Release it after the priority range has been copied out.

Fixes: 44af95718fed ("net: prestera: manage matchall and flower priorities")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/marvell/prestera/prestera_flower.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/marvell/prestera/prestera_flower.c b/drivers/net/ethernet/marvell/prestera/prestera_flower.c
index 58b116cabd48..10d7e149822b 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_flower.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_flower.c
@@ -411,6 +411,8 @@ int prestera_flower_prio_get(struct prestera_flow_block *block, u32 chain_index,
 		return PTR_ERR(ruleset);
 
 	prestera_acl_ruleset_prio_get(ruleset, prio_min, prio_max);
+	prestera_acl_ruleset_put(ruleset);
+
 	return 0;
 }
 
-- 
2.34.1

