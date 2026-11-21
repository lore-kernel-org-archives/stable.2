Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795264383;
	b=m+m05zcRg6e+tpkyxkR81sCyHFwmz88A7nbE5Gl468TOBcF2prAuRhgGA7ZWidUAFS6i
	 5/8NrXqYk2TgurDrboVOI1g5EXfeCVwb1TWM/tfSZ4Fvz9cRH+sYcgzi4cUF3N2bHtqke
	 Vl37zjlcFxdvgQUFT2dWHP50+mWGH+elvFZMhKBP45Ak16TBnDNwHlAxcve470DakMBf7
	 LdWqWfeZQyv0pglxVb2WTmi4g5QlSCo+xNw/rvgMUu1R4rHFzgD27MaP0NX6x2VJp73Uu
	 YoOmo4dhl8lz1u5+uaAdd+EeAfbk950gw725FusOpUKyTOXQ2XJ6JxPrqnx3UJwsnog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795264383;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=cNTODI7JrIIu1DnD7iwwKJNOM2aZnndQZB/sdyIkwEI=;
	b=QgJiK5vjpVFBXIBO6UbUilxXkPPO94XlFj6OkewsdQyNZ0lFk4hkgJyDrSkBuPuNAonZ
	 Taas0l/6gpRFTfuHIBGo91uDqdpTYcDMhUV/Q2rDWzEt1JHpqOU1Pxf9LSKCcNaPFYmxN
	 W3mTgYy+RFiQwhOQoc2rlaDcRcqFUa2snezBpWZQ7kuxXVaMN1zFXZoRj/6BSezJMrrOu
	 cOyI701juIYrAcVIv6vHQCrI9XyP5jwc86Iqsx8SmqnHm7l1Z0T4BwD4sKTOhECHgPrV/
	 qMfjlOOe9Hg4G69Mx890VlzF7AkVC5jJqDqfUqyNJdR1n7q8eiGTaWZylcD5Q0KTZ7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=o6Kux1qO;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C02606A320;
	Sat, 21 Nov 2026 12:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5C02606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=o6Kux1qO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=cN
	TODI7JrIIu1DnD7iwwKJNOM2aZnndQZB/sdyIkwEI=; b=o6Kux1qOJa9aLU1HqZ
	i408TbCIsl5Ud1udoRSLaNquOo8R2uGjqDk+/ZwUGI+JolE05YZKdvQ327DwLqk/
	Tu5rfoHkibw8PbxKr+ofgzVygTeCzGEP6C6OHiGHjB6Lm5fKMLimej8bEKrqchrI
	IhByvHzlqZEcfzEzvuz6iKYaU=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD31BBejwFroa+1JA--.58410S2;
	Sat, 21 Nov 2026 20:32:30 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: mchehab@kernel.org,
	hverkuil+cisco@kernel.org,
	atharvd440@gmail.com,
	u.kleine-koenig@baylibre.com
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] media: cx25821: Fix a potential leak in snd_cx25821_hw_params()
Date: Sat, 21 Nov 2026 20:32:16 +0800
Message-Id: <20261121123216.535327-1-haoxiang_li2024@163.com>
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
X-CM-TRANSID:_____wD31BBejwFroa+1JA--.58410S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFy3XF13Jr4rKFW7Cw45Jrb_yoW8Xr47pa
	yavwn5GF4xJF48W3W8Gw109a98JwsYgryIgFWDZwnxZFnIqr4rtFyFqas5Wr1Yk3yfZFnx
	XFs8uw45Gr1rJFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEQJ5UUUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7R8WhGsBj18-WwAA3+

Add an error path to free the memory allocated by cx25821_alsa_dma_init().
Also move cx25821_alsa_dma_unmap() to the goto label to unify the error
handling.

Fixes: 8d8e6d6005de ("[media] cx28521: drop videobuf abuse in cx25821-alsa")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/media/pci/cx25821/cx25821-alsa.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/media/pci/cx25821/cx25821-alsa.c b/drivers/media/pci/cx25821/cx25821-alsa.c
index f963ae79f685..1bf4fb96db1c 100644
--- a/drivers/media/pci/cx25821/cx25821-alsa.c
+++ b/drivers/media/pci/cx25821/cx25821-alsa.c
@@ -529,14 +529,13 @@ static int snd_cx25821_hw_params(struct snd_pcm_substream *substream,
 
 	ret = cx25821_alsa_dma_map(chip);
 	if (ret < 0)
-		goto error;
+		goto error_free;
 
 	ret = cx25821_risc_databuffer_audio(chip->pci, &buf->risc, buf->sglist,
 			chip->period_size, chip->num_periods, 1);
 	if (ret < 0) {
 		pr_info("DEBUG: ERROR after cx25821_risc_databuffer_audio()\n");
-		cx25821_alsa_dma_unmap(chip);
-		goto error;
+		goto err_unmap;
 	}
 
 	/* Loop back to start of program */
@@ -550,6 +549,10 @@ static int snd_cx25821_hw_params(struct snd_pcm_substream *substream,
 
 	return 0;
 
+err_unmap:
+	cx25821_alsa_dma_unmap(chip);
+error_free:
+	cx25821_alsa_dma_free(buf);
 error:
 	chip->buf = NULL;
 	kfree(buf);
-- 
2.25.1

