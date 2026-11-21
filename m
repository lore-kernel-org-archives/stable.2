Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795264761;
	b=k5gchtf8Nng0BFsnNuFCL43SdaulyyWG4b+E4e7h8Y6NczPxv+wqdFB+LmQMPcyw4Pq4
	 jsSYdM41KQ3PkQZi+2BFqhRWhjClM0Sld+GrwAq8mU+zo/XkyImAFG8RyiB0XDr4KRXQJ
	 4446Uf6B5IEocdOjzeU+zB+NTAss2tRS1qPvlziYv5H+CS/hok9gcOX42OoOWmT0jbgcF
	 vQMCFr1ABeLbkc+wOXrzX4Pm/GMoVdVAOJUfmfhvw23hme1L1cvGtAQ8Sxv/SpsdcELJu
	 cFIyOQMJYdqDB0cULmB3bz0HHF+ycUfIfs1xWuRMia3pcx+s3XmPrP3TBWdcaofPpVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795264761;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=GMSn4VqarpU8f2bhtfD5L1Nc2EEF6E1BJP8fXxFEG68=;
	b=PklVbluvFxX4rQkplsS3DN9xs4JpVMkkVJcUUphMA9WiYfBPajlkkFFDca0nGTS4Vu1j
	 Ir+8riBZZ2bzV+y+t2+rklNtTb93SG6pSdgmfrDzb94lNW1CvmG55FVWSzZOQiFHeKcI9
	 HmcIw4woBZqXE3+R+oCk48wdmfEcwEimXvsTuxrMDVmbKVCgm7rh7vy7KWv5h1zclBOK8
	 ANWrE8QAd16FL6OII4wVBdJoS2ooyJldkeCxQIh4Qs32bGaChE1lSBZEtDtSnScHvqpBz
	 KK0f7ftBy20QEQCSKBpTwcTqO9cxe6iTmnawj7kg9MaSR8OpUVS3waBSr8/fJ6WCMBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=GuGDgM2J;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52524606A331;
	Sat, 21 Nov 2026 12:39:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52524606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=GuGDgM2J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=GM
	Sn4VqarpU8f2bhtfD5L1Nc2EEF6E1BJP8fXxFEG68=; b=GuGDgM2JBlZfVKrG+B
	JwTPqOvYaEiq6JdLnyIrO9y/pj29RpZvyXbXOKpdF6QlpuJg3pjs+nPgzU3bhNpk
	JvcDQq09iVr7PlgfWuyBMlWtGwPvokU/0Pi8pQpp/w/rSfOmn+Rl2f6T1vOYvHqM
	dzTL4RFI/w551bVlW5JL0/zxs=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD394HikAFrrDGaIw--.8735S2;
	Sat, 21 Nov 2026 20:39:00 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: mchehab@kernel.org,
	hverkuil+cisco@kernel.org,
	u.kleine-koenig@baylibre.com
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] media: cx88: Fix a potetial leak in snd_cx88_hw_params()
Date: Sat, 21 Nov 2026 20:38:58 +0800
Message-Id: <20261121123858.540201-1-haoxiang_li2024@163.com>
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
X-CM-TRANSID:_____wD394HikAFrrDGaIw--.8735S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aryrtw1UCrWUKryDKr48WFg_yoW8Gw4rpF
	4Yv3sakF1fJFW8Xr98A34jka45A393K340gFW7Zwn2vw13Xw18JFWvva48Wr1jkr48Zw13
	Xrs5Ca43Wr15ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p__-BDUUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7gR45msBkOR5NwAA3k

Add an error path to free the memory allocated by cx88_alsa_dma_init().
Also move cx88_alsa_dma_unmap() to the goto label to unify the error
handling.

Fixes: b2c75abde0de ("[media] cx88: drop videobuf abuse in cx88-alsa")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/media/pci/cx88/cx88-alsa.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/media/pci/cx88/cx88-alsa.c b/drivers/media/pci/cx88/cx88-alsa.c
index d2534f90cfba..609409e259a9 100644
--- a/drivers/media/pci/cx88/cx88-alsa.c
+++ b/drivers/media/pci/cx88/cx88-alsa.c
@@ -479,14 +479,12 @@ static int snd_cx88_hw_params(struct snd_pcm_substream *substream,
 
 	ret = cx88_alsa_dma_map(chip);
 	if (ret < 0)
-		goto error;
+		goto error_free;
 
 	ret = cx88_risc_databuffer(chip->pci, &buf->risc, buf->sglist,
 				   chip->period_size, chip->num_periods, 1);
-	if (ret < 0) {
-		cx88_alsa_dma_unmap(chip);
-		goto error;
-	}
+	if (ret < 0)
+		goto error_unmap;
 
 	/* Loop back to start of program */
 	buf->risc.jmp[0] = cpu_to_le32(RISC_JUMP | RISC_IRQ1 | RISC_CNT_INC);
@@ -497,6 +495,10 @@ static int snd_cx88_hw_params(struct snd_pcm_substream *substream,
 	substream->runtime->dma_addr = 0;
 	return 0;
 
+error_unmap:
+	cx88_alsa_dma_unmap(chip);
+error_free:
+	cx88_alsa_dma_free(buf);
 error:
 	kfree(buf);
 	return ret;
-- 
2.25.1

