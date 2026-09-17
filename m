Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20ACB58FD2D;
	Thu, 17 Sep 2026 14:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789655632; cv=none; b=MK68NLnNTHTN/gL57vKnEYXFwr/+X7L7+PYxOmgAJ6GI9AVQlP5zz7yElvpI19h+v2IRYUAI16nP2tHxWhOtVwLAjkmgOdIpyQ2bmDuQMmqNhBCWoNNnL1FU6GdIhUy28a2JzAy2h2r9nyvm6mSeZDAH2DMH8Cdujw6D0ErkoPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789655632; c=relaxed/simple;
	bh=0CifYHpF4P3lIw7O5N0oKzN9TKKTgUgRGII2NQXFflE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B2WDXgnatNTJYCFrWTUKTkgsEdXjqtphNih3OSb7ugxHN0OhfI87oZ+jnyWT1R2lFY4Dj1HlkCVtGCRbeDMCPS/MKcPnVqEDOw7FkCTnlb/WM/VSW6v5Xigwlmv/09uOjbexN6jTZtasSApQPsVJXOT18Dw7/VPOeiybkkKdVUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACHuEJL+qtqp4+CCA--.4947S2;
	Thu, 17 Sep 2026 22:33:47 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	mathieu.poirier@linaro.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] rpmsg: qcom_smd: Fix edge of_node leak in qcom_smd_edge_release()
Date: Thu, 17 Sep 2026 14:33:47 +0000
Message-Id: <20260917143347.2157055-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACHuEJL+qtqp4+CCA--.4947S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JFWrKFy7WFy5Zw17JrykAFb_yoWftrgEka
	s7uwn3XFyUAr4fAw129FZ8Zr9avF1DXrZ7Zr4qqF4rZFWYqFs2gr9agwsYvrZxCr4Iqry3
	uw1DJr4rAr429jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbS8YjsxI4VWkCwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
	kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
	Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxV
	W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VAI37AI020EjII2zVCS5cI20VAGYxC7MxkF
	7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr43Wr
	1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j6F4UJwCI42IY6I8E87Iv6x
	kF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x07UMq2NUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgQNA2qr888PuAAAsG

qcom_smd_parse_edge() stores an extra reference to the edge's device
node in edge->of_node, and it is used after probe by
qcom_smd_match_channel(). The error path drops that reference, but the
success path does not, and qcom_smd_edge_release() only frees the edge,
so the reference is leaked when the edge is unregistered.

Release the device node when the edge is freed.

Fixes: 53e2822e56c7 ("rpmsg: Introduce Qualcomm SMD backend")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/rpmsg/qcom_smd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rpmsg/qcom_smd.c b/drivers/rpmsg/qcom_smd.c
index 3ac863f400ec..d98e8bbf9bd2 100644
--- a/drivers/rpmsg/qcom_smd.c
+++ b/drivers/rpmsg/qcom_smd.c
@@ -1452,6 +1452,7 @@ static void qcom_smd_edge_release(struct device *dev)
 		kfree(channel);
 	}
 
+	of_node_put(edge->of_node);
 	kfree(edge);
 }
 
-- 
2.34.1

