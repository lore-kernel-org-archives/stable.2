Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793699174;
	b=dKkaAOqH7pqCmyo1Qh90v47MUUyy5ylaRbT15e+3qU9gD42I0Nv53G4ry1YM1aKXQuwF
	 F9ggu5ZJ+ZjmGq9WD4WvnzREABJVq6UaxCFdO9rueY44JhEE6+snWQcbclBOnCCEH/F0b
	 YoDVnjCvjwk9HU/zx1YSQXGDWh9W+kLu7BuWHDU9/kddjRfuNqdYJsJYJWv8hGhdlzl/B
	 I2mdWNlD2hEsBtyC8d0upYr5O7GB6sPagImp81DtjlW/w4BUUvDSfyVZq6e5M7sAhvvGg
	 /Vm6MPbe1xZMqYRZ7HekTZu6f7Q09hPn0zS/8JNwDepRdy+4FmNe1qgB7pM0o+xSuoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699174;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=Ot6CzOZAn1GOQoPIqCwwJChn4IeZFkB52U4Nrf4WrVU=;
	b=CP/gwWXyUjSjWWtI2yZYYTPn4/wtOMaUPjlYSWyGUSXINhY9zQjczLfODknKRc7UfYJF
	 5PKeUDJHfqDPHSW2jOtkL3mRAT006isZxf3RKhJTApPcR1oZs/goPxj/DDLwAx2TXIpp1
	 MYlRKq4th9QUtUVKMzAWf6vfDDyvMvMAmqMktUOjXNxE7oFhFK5IVaNiAuROcq53ywLXc
	 /tFxSTzBew0VHs8W5b3aJOREvwIsPsRfWu5EyMZGlH4oAmFQOuyrNY/0rNFNDVnEYXqO+
	 wim4Lmg/moJCDxzp6kX8KSIOqVMvnu7HRu7j5RnqAP+cCQPzHWI/ysqlqKyqePe0/6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0727A606D82F;
	Tue,  3 Nov 2026 09:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0727A606D82F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAC3xZZfrelqzk47AA--.2329S2;
	Tue, 03 Nov 2026 17:46:07 +0800 (CST)
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
Subject: [PATCH] media: exynos4-is: Free control handler if ISP subdev init fails
Date: Tue,  3 Nov 2026 09:46:16 +0000
Message-Id: <20261103094616.1289357-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowAC3xZZfrelqzk47AA--.2329S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww4xCFyDGF4DKFWUKrWDtwb_yoW8GrWkpr
	s7X3s7ArZ8GF1Uta1UAw1a9FW3C3WfWFWDWrZ7u348Zws0qFn3A34xGa1ruFnxAr18Z3W3
	XF10qFy3CF4Yvr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcS
	sGvfC2KfnxnUUI43ZEXa7VU8jQ6JUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwIAA2rpnO5OKgABsS

fimc_isp_subdev_create() initializes isp->ctrls.handler and creates a
number of standard controls. If any of them cannot be created,
handler->error is set and the function returns after cleaning up the
media entity only. The control handler still owns the memory allocated
for its buckets and for the controls created before the failure, and
neither fimc_isp_subdev_destroy() nor the caller's cleanup runs on this
error path, so that memory is leaked.

Free the control handler before returning the error.

Fixes: 9a761e436843 ("[media] exynos4-is: Add Exynos4x12 FIMC-IS driver")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/media/platform/samsung/exynos4-is/fimc-isp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-isp.c b/drivers/media/platform/samsung/exynos4-is/fimc-isp.c
index a0a9093081dd..7790541a2a7a 100644
--- a/drivers/media/platform/samsung/exynos4-is/fimc-isp.c
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-isp.c
@@ -761,6 +761,7 @@ int fimc_isp_subdev_create(struct fimc_isp *isp)
 
 	if (handler->error) {
 		media_entity_cleanup(&sd->entity);
+		v4l2_ctrl_handler_free(handler);
 		return handler->error;
 	}
 
-- 
2.34.1

