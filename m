Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793699175;
	b=WHC9Yq+rQFkbIp4nj1sxHGuDsl5IVD3Qe8alm+uGpqCjYgtZr8bm4muRpi8Ox0FSMP6R
	 NCmjEIqouU0H+ZJz3/avmBVSTWKGdIghrviHNig62Obc6fvOm19o11P53FFMCrMNsr3Gd
	 pXEwFPrr5dVkuF6oaMlaWhRis36aYPJy4RsGgZ9w30RP+xY0qYNcAPh3pm/PQJfFo+IVf
	 V+RLUNo004jy+luyPvctJOhXn3JJqKVBOQe97m8bOHXSocPMXfPJC20J/VdnKR9/LuwmN
	 F8iRp5aWRXSxY7zDDajmmxSiZLlYfTHqiC4xqMU9dZt9gcYsH/CblNl60ylZPjZZosA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699175;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=gY7p33z2v7FszyDj0lPlEERYt/49l6YR3NM7eQ0xMIM=;
	b=hKUCta7CuOrwxvG7iXn5HPSLQzLL3Iy7hAMSZJJ0tPw2fosve/lfLbEtmJjMpDHOIAuN
	 kfXm0bDsa4KtKeQXbA4VfxakvHLgRKro5/hZm6f2D3C3DqUZ/AERQEDNk9uJ0S1UeNGF7
	 /M1gDLQS5PaUZIFJ4EmPnOheZD3m1FX2T4h86WaD+iwi/H5tHhTTud0RDYSTumzqYZ1J3
	 YFWGMiGJF92L9CHeYlx3tRAE3GG4mYHGIVu7dgiNnbQDP1i1mopqYLiw0zUHUg85GM3v0
	 rCVZtAJjcgBhmyJona1hA1luq9C+HHVXvZQFDbcW2SG7Mnfq5j+NbrcAeUho6YleW+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F77606EE88;
	Tue,  3 Nov 2026 09:46:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92F77606EE88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACXaZpgrelq1U47AA--.64265S2;
	Tue, 03 Nov 2026 17:46:08 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-media@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] media: exynos4-is: Free control handler if fimc-lite subdev init fails
Date: Tue,  3 Nov 2026 09:46:17 +0000
Message-Id: <20261103094617.1289377-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowACXaZpgrelq1U47AA--.64265S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFyxGw1fKw4rAw13ZF1DWrg_yoW8GFWUpr
	4xt3srAFWUGayxta1UA3W29FW3Aw13WrW5WrZru348JrZakFnrA34a93WrZFyDAr1xZasx
	Zw1UXFW3uF4YvrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr
	1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JjU-B_UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAMAA2rpnOFO+QAAsF

fimc_lite_create_capture_subdev() initializes fimc->ctrl_handler and adds
a control to it. If the control cannot be created, handler->error is set
and the function returns after cleaning up the media entity only. The
control handler still owns the memory allocated for its buckets and for
any control created before the failure, and fimc_lite_probe() does not
call fimc_lite_unregister_capture_subdev() on this error, so that memory
is leaked.

Free the control handler before returning the error.

Fixes: 4af813108b88 ("[media] s5p-fimc: Add support for Exynos4x12 FIMC-LITE")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/media/platform/samsung/exynos4-is/fimc-lite.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-lite.c b/drivers/media/platform/samsung/exynos4-is/fimc-lite.c
index 90599c82fd35..103c542a85b0 100644
--- a/drivers/media/platform/samsung/exynos4-is/fimc-lite.c
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-lite.c
@@ -1402,6 +1402,7 @@ static int fimc_lite_create_capture_subdev(struct fimc_lite *fimc)
 						  NULL);
 	if (handler->error) {
 		media_entity_cleanup(&sd->entity);
+		v4l2_ctrl_handler_free(handler);
 		return handler->error;
 	}
 
-- 
2.34.1

