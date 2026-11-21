Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795263554;
	b=H6Qyj3s4vAA+eJGvmIWoyXsOHSFwoNDQnYlvqZ4mbbzkihv7isMqsPI16t22Uq3hemao
	 DMvgQJbjKXIhOwiEfYpCF2DWzXUM4Q4xvtCDJASa+g8mVNu0WM0kEMhGnNG0qryG73JdZ
	 I7guYx5I8N9mcwiuWkkPheQLFPfChY6BaPNV3PsrOeUKRv1WBKNsVp5eYe3ldQVt+YnmK
	 F4A6zpceO9rULisALnXn64GFGAiJCCg/V8i3ZpgEkIwJdEb+KpOPeOhp9K63b6262Df0G
	 M1Bd2MgoVXzedPW/+h6kjyt3v8Se4X3ZmMLjrnPoV7a59nIUZuWP8OdkZgWT9iYt8kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795263554;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=CNOgHxo5rImaeobDkKQY9LyeNIWGKW6ZbfIQZ7DKocM=;
	b=BVINzN9FbPcnQkv5bgj+3JF3bRh9SuYGT47tzIpMVbA6O0JETh9uxtV5/cp2aYvmk8jL
	 0QrkkX/4JUky8Y52xQtELNlQacN1EaFTaRWIfhXzwSnl3qwsGex0nX25VtVuWZGfTduw7
	 gx1Ex2EyTK6IIOl1KOls7P3P1axcCBZFCYj6f3Phyh/xoHIJcl6Ns2/TZ8uDSAQ+67Ej5
	 IspDlyVnIm0W7myo+VNdXrNlfbFz6fScbUmhvgfzguBoM7eHt9Q4UtlC4WaWFlUyeLNOv
	 uNBWRr4dFFIu2qQBTzfPECuZA+i7GAeA8+gFJBy16wiS7UCMY+oRtYJZxhazYwj6Hgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=cq1CjJDR;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC50F606A320;
	Sat, 21 Nov 2026 12:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC50F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=cq1CjJDR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=CN
	OgHxo5rImaeobDkKQY9LyeNIWGKW6ZbfIQZ7DKocM=; b=cq1CjJDRaAWnm0XYWy
	a8fJsL9VvGAWc6zkse02fxZ5WzLuz7/NPiwfXqYfuAUCXnLnDW+DLB3QfTfhjDAy
	PoHv8Z+2YxE8IJVsZLBCsk2h5VahD6isI/qUf7FoN0G1u7sXmaQAUmYT4yt7DVaJ
	AUWuzK4hze13VlA+bhpcv4FCU=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDnH3EujAFrIwoWIg--.17676S2;
	Sat, 21 Nov 2026 20:18:56 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: mchehab@kernel.org,
	hverkuil+cisco@kernel.org
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] media: cx23885: Fix a potential leak in snd_cx23885_hw_params()
Date: Sat, 21 Nov 2026 20:18:10 +0800
Message-Id: <20261121121810.523554-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
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
X-CM-TRANSID:_____wDnH3EujAFrIwoWIg--.17676S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ArWfAF1xWw1rXr18GF13twb_yoW8XrWUpF
	43Ar98WFWxJF4rAas5Jw12kas8Gws5tayIgFW3Gwnav3WY9F18tFWIq34UWr4UGFW0vrW5
	WF4DZw17Kr1FkrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pir-BtUUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7RBKuGsBjDDb0QAA3T

Add an error path to free the memory allocated by cx23885_alsa_dma_init().
Also move cx23885_alsa_dma_unmap() to the goto label to unify the error
handling.

Fixes: 9529a4b0cf49 ("[media] cx23885: drop videobuf abuse in cx23885-alsa")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/media/pci/cx23885/cx23885-alsa.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/media/pci/cx23885/cx23885-alsa.c b/drivers/media/pci/cx23885/cx23885-alsa.c
index 29f6df0e6de4..515aba9fb384 100644
--- a/drivers/media/pci/cx23885/cx23885-alsa.c
+++ b/drivers/media/pci/cx23885/cx23885-alsa.c
@@ -388,14 +388,12 @@ static int snd_cx23885_hw_params(struct snd_pcm_substream *substream,
 
 	ret = cx23885_alsa_dma_map(chip);
 	if (ret < 0)
-		goto error;
+		goto error_free;
 
 	ret = cx23885_risc_databuffer(chip->pci, &buf->risc, buf->sglist,
 				   chip->period_size, chip->num_periods, 1);
-	if (ret < 0) {
-		cx23885_alsa_dma_unmap(chip);
-		goto error;
-	}
+	if (ret < 0)
+		goto error_unmap;
 
 	/* Loop back to start of program */
 	buf->risc.jmp[0] = cpu_to_le32(RISC_JUMP|RISC_IRQ1|RISC_CNT_INC);
@@ -408,6 +406,10 @@ static int snd_cx23885_hw_params(struct snd_pcm_substream *substream,
 
 	return 0;
 
+error_unmap:
+	cx23885_alsa_dma_unmap(chip);
+error_free:
+	cx23885_alsa_dma_free(buf);
 error:
 	kfree(buf);
 	chip->buf = NULL;
-- 
2.25.1

