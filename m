Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793951499;
	b=QMVuXbPpXyoEK3aHmsOT2eZyVBQPSb2Rjt1RS4M5ChMoNSKav2ajIWdcjui7t7hKZ1kL
	 sU+JhIjtkoegtOBiSQzVgLHLdkp9+MfFNCL7eaFcmEBSkz65R+wN9kmuZ4i0PKwCpURVv
	 9ia3Z/K5KisT0Q+K2Q25EL9HhKWxSWORrLTHT0I4mU0QKWo2w64JNkv9B6o0+pUpxYlSi
	 C8EvvTSOH5LmtoYj8o29Pm6hnu6R0iJA2AF2FrKeCAYpTymKqPwVjvV2KT4HxQ99Eubz2
	 SzKXS2jh7KpMqRSfZUqI0p2zYYmnkAwq+qjlQ2wnFVGJjtyyRNKgM8l4KJ8VxzZcCrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793951499;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=X3nxSXG+H2J8k8t3k6poogjxQFJaTHXAguqehE2TWiY=;
	b=W4cQHTbnMn0NwDBruLxGkAt3JN9MZpev8qUFxYsTW0lX/lBet741qs6GuwNG3rL+ZwLS
	 ns0XluXDb8ZpXVG6bRX/odgSlJ8OZs0TFpoz3W3MPsCwCiCIcKkKZGbeYk2FFkwLZcY8+
	 6AxYHrPXvaE8hushfAQ/yci5GioU8W2bxXk0WUEP/bntw9mpUGe8gZB0EYr9oGQYeXUxv
	 yT5t0NgGwYhOzr+mgn8rTeAg6SsJSmYtT5jrGdf5YD021lXtxeXJNq9a9B0z3TDD+vAPD
	 YQjXeweja2MllTmNXxAl37aMhv/PXBvbOSV/JboTBR9pR2+aYbhzsKFdG1p3jAheetg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=EdBOOO5d;
	arc=none smtp.remote-ip=115.124.28.97
Received: from out28-97.mail.aliyun.com (out28-97.mail.aliyun.com [115.124.28.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576A7606A326;
	Fri,  6 Nov 2026 07:51:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 576A7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=EdBOOO5d
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793951489; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=X3nxSXG+H2J8k8t3k6poogjxQFJaTHXAguqehE2TWiY=;
	b=EdBOOO5d/HlK/xdK+U63qbsCipbHTOjNjstrXi49twguHyNCSFWfk4udWTjT++l+gs7f4/JjR6BY1sbl1pNhGqsabFd7UqgnLXopyDkZIJKCx6lqYgei7RSKnt1Kbx0fYVrLo9zU5ulAIWNisZgvIILVcRMU1/NTFOLmymFqTVY=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07707597|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.003847-0.000952075-0.995201;FP=12758894924369871956|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037034254;MF=liuc63@xiaopeng.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.jy77D-U_1793951487;
Received: from localhost(mailfrom:liuc63@xiaopeng.com fp:SMTPD_---.jy77D-U_1793951487 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 06 Nov 2026 15:51:28 +0800
From: Liu Chao <liuc63@xiaopeng.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Juergen Borleis <jbe@pengutronix.de>,
	Denis Carikli <denis@eukrea.com>,
	Lee Jones <lee@kernel.org>,
	fangxy@xiaopeng.com,
	linux-input@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Input: mx25-tcq - clamp the FIFO sample count to the buffer size
Date: Fri,  6 Nov 2026 15:51:27 +0800
Message-ID: <20261106075127.3105907-1-liuc63@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
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

MX25_ADCQ_SR_FDN() reports up to 31 pending samples.  The IRQ thread
aligns the count down to a multiple of the sample count but never
bounds it by the size of sample_buf, so a FIFO backlog larger than
TSC_MAX_SAMPLES overruns the stack buffer.

Clamp the count before the alignment so that the result stays a
multiple of sample_count.

Fixes: 4f7ed234f2a5 ("Input: touchscreen: Add imx25 TCQ driver")
Cc: stable@vger.kernel.org
Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
---
 drivers/input/touchscreen/fsl-imx25-tcq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/fsl-imx25-tcq.c b/drivers/input/touchscreen/fsl-imx25-tcq.c
index ff270b3b8572..fa8d8b736723 100644
--- a/drivers/input/touchscreen/fsl-imx25-tcq.c
+++ b/drivers/input/touchscreen/fsl-imx25-tcq.c
@@ -319,6 +319,7 @@ static irqreturn_t mx25_tcq_irq_thread(int irq, void *dev_id)
 	 */
 	regmap_read(priv->regs, MX25_ADCQ_SR, &stats);
 	samples = MX25_ADCQ_SR_FDN(stats);
+	samples = min_t(unsigned int, samples, TSC_MAX_SAMPLES);
 	samples -= samples % priv->sample_count;
 
 	if (!samples)
-- 
2.50.1

