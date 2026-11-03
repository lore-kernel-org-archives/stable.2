Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793699172;
	b=nJ+MVE2jQ4/S9sRvwEkRy8NNMpCemDEBrstBVhPJCP2eWdlSVYPMqtMrAFlm1/4l71ur
	 TddewK1K691jxVZIxUAmNbzjMwlNz6h4xDwcsodeBpAB5v68qWOIe3LTYPq3AOM3QQrFE
	 6YtRR5koyzMDNDs9YY6SxFwyXkmXe4NwSklpCULRVCqdgjrrHrv+elzg7qmQ4edPCasDl
	 GMGstEcCOLlth3IKB68aJIS1An2Rm5XCVc7NcODSOcqgdqfw67qds1DrZ9WsMAqZwKVgb
	 VNEHrAS8HmMLdYIt39q5u73DIcvurmHHfF2xVMovUGthsVmD0Ke1fVL0kdksVcnA1aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699172;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=lv/56oXPRXQPRp6JeV1O5YcHVayyCW8jY8QcD0pgPIM=;
	b=Rlg5KV7eemdViO425tijXPHtztwThxBJqCJOCIntXB+tyCs3+ylbRtpaHS9IW3M5KL0l
	 Swn8UBCXmdX5lb99unG7azB7jUcikCdCPaoxl5b46JJxnIaZu8fk2LqmtXbNIXeML425h
	 fPgFMmPH4tLrro4QYw61o/FQoUJy9O3RSLrpoP3oV2bShlJGQfqlTYxVHSFo9TQrEpF4a
	 s5UXiZ1jSnzFMYU4jB1ye5+vzfUK/3+gPcvgBFb4AM/fmHfUOfU7fCQM1l5zjv0KMp61Y
	 s+uGyKdB9ljBcitAyzwicMjD+dW9PZy3geFJl8Efxg8VYHOB4ygx1OePAka6z8Rw8SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9916A606A331;
	Tue,  3 Nov 2026 09:46:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9916A606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAAnOJlarelqh047AA--.2594S2;
	Tue, 03 Nov 2026 17:46:03 +0800 (CST)
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
Subject: [PATCH] media: exynos4-is: Free the control handler if fimc_ctrls_create() fails
Date: Tue,  3 Nov 2026 09:46:12 +0000
Message-Id: <20261103094612.1289226-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowAAnOJlarelqh047AA--.2594S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WrWkGF1kKF4kGw1kWF4DJwb_yoW8GF47pr
	Z3X3s3ArZ8Wa1qvayUG342kay3C3WrGrWDWrZxuw13Awsaqa1fAw18Ga1UuFZrAr1xK3W5
	Xr18JFy3CFs0vwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWxJr0_GcWlOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCT
	nIWIevJa73UjIFyTuYvjfU7TmhDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAIAA2rpnOFIXQABsn

v4l2_ctrl_handler_init() allocates the handler's bucket array, and each
subsequent v4l2_ctrl_new_std() call allocates a control.  When one of
those calls fails it only records the error in handler->error.
fimc_ctrls_create() returns that error with ctrls->ready left false, so
neither caller calls fimc_ctrls_delete(), and that function would not
free the handler in that state anyway.  The bucket array and the
controls created so far are leaked.

Free the handler before returning the error.

Fixes: 9448ab7dec30 ("[media] s5p-fimc: Add color effect control")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/media/platform/samsung/exynos4-is/fimc-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-core.c b/drivers/media/platform/samsung/exynos4-is/fimc-core.c
index b36812ad25c0..8e6dd602aa79 100644
--- a/drivers/media/platform/samsung/exynos4-is/fimc-core.c
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-core.c
@@ -606,6 +606,8 @@ int fimc_ctrls_create(struct fimc_ctx *ctx)
 	if (!handler->error) {
 		v4l2_ctrl_cluster(2, &ctrls->colorfx);
 		ctrls->ready = true;
+	} else {
+		v4l2_ctrl_handler_free(handler);
 	}
 
 	return handler->error;
-- 
2.34.1

