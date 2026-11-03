Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793699175;
	b=rKda4Gqf8T/9HlkJsZEt0IP5YeIy9LbhchHH5ZLHQde8JIGnpPcV9iS/I0SArDX68tx/
	 8hhi+EAlvWIBylYnyjBwfR4uOa7ZpmvSkOfn941CkhZqSQEeFNW+34s3rIl7nbgrQtb/t
	 5QI/EEQcwLxHYLuiNJlPCuYeAHUlPW/kMsn8FBQRFF7FXQ1IVw4w9TBZYYoUQ42OG9Th3
	 hNr6IJ4K7Ngy3N1knjqtald/GfCpuOwkNB6jtM8S1ky2hkBVJWIMbxg1tAK53gzv7talH
	 Pjf/8sAamQ6am5ec5HALCPWg4MNYT54MOnSmQ9jyWiZdzjQEub1VLkU45kw9rytwbMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699175;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=I0D6QNq8jrZNgvBlJxc9AOsfQCGpmtKCeV5gxEg13BY=;
	b=FjaJrQQpDLVoUMHuOYrOOhC7jD/eD6nPja9e/1eMp2cXvG+jL/Zh2mOe9QlGIIG4SdHN
	 k8H83oct5gv9wg4hcb7fZAH0OW8b4arb5FE+sO570/9wvGZADejsf9UMmsv80KKZNqSpj
	 RE8N5FfDrjcGZwwVi+ylBn3SKTaJbkeu103JZfPHDnskKvklsAwCurnY9dnsiNrgsifdg
	 gyZErwDOQiI8vXU5neXYq/sX7A/DRw5XMXe9PfpFSbl2vfVYGRYd3AO6MENT4+zXTvVYP
	 vK3HxL1OwufjTva1oR+CsxC2ZK+cwKMLBo9qJ/R9OmJGTUvar/LuEXjNQAsSpU9wy3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBF7606A339;
	Tue,  3 Nov 2026 09:46:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EBF7606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAAnN5hgrelq2047AA--.48649S2;
	Tue, 03 Nov 2026 17:46:08 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Devarsh Thakkar <devarsht@ti.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] media: imagination: Release m2m device on probe failure
Date: Tue,  3 Nov 2026 09:46:17 +0000
Message-Id: <20261103094617.1289402-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowAAnN5hgrelq2047AA--.48649S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFWDKrWUGFy8uw15Kr18uFg_yoW8ZFWkpw
	s8Ja9xKFyUKrsrZwsrJF4UZFyYkr4Sk3yFkwn7Cw1xu3sxZr98Jw4rJFyUZw10yrW3K3WY
	qr17ta1rZr4jvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_
	Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUXID
	7UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRIAA2rpnIBRIgACs2

e5010_probe() initializes the mem2mem device after registering the v4l2
device. When mapping the "core" or "mmu" register region, requesting the
IRQ or getting the clock fails, the error path jumps to the
fail_after_v4l2_register label, which only unregisters the v4l2 device.
The v4l2_m2m_dev allocated by v4l2_m2m_init() is not released, so it
leaks on these probe failures.

Release the m2m device from that label as well, so that every error path
taken after v4l2_m2m_init() succeeds frees it. v4l2_m2m_release() accepts
a NULL pointer, so the v4l2_m2m_init() failure path is unaffected.

Fixes: a1e294045885 ("media: imagination: Add E5010 JPEG Encoder driver")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/media/platform/imagination/e5010-jpeg-enc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/imagination/e5010-jpeg-enc.c b/drivers/media/platform/imagination/e5010-jpeg-enc.c
index 420cb8bfdb12..49943bd604da 100644
--- a/drivers/media/platform/imagination/e5010-jpeg-enc.c
+++ b/drivers/media/platform/imagination/e5010-jpeg-enc.c
@@ -1104,7 +1104,7 @@ static int e5010_probe(struct platform_device *pdev)
 	ret = video_register_device(e5010->vdev, VFL_TYPE_VIDEO, 0);
 	if (ret) {
 		dev_err_probe(dev, ret, "failed to register video device\n");
-		goto fail_after_video_register_device;
+		goto fail_after_v4l2_register;
 	}
 
 	v4l2_info(&e5010->v4l2_dev, "Device registered as /dev/video%d\n",
@@ -1112,9 +1112,8 @@ static int e5010_probe(struct platform_device *pdev)
 
 	return 0;
 
-fail_after_video_register_device:
-	v4l2_m2m_release(e5010->m2m_dev);
 fail_after_v4l2_register:
+	v4l2_m2m_release(e5010->m2m_dev);
 	v4l2_device_unregister(&e5010->v4l2_dev);
 fail_after_video_device_alloc:
 	video_device_release(e5010->vdev);
-- 
2.34.1

