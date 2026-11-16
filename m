Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794838536;
	b=0WeWf09n3ZNkq3VwPJZCzWb554/qf89NFlw0fkkjDPQsDtKN85t3slRGd5dShD+x76ky
	 eR3n2p6ljdureXDiV1+WYAbd+ftbjceaC5RdHqBK6vAQzVkAV0RYwJvW8qzRyBRJ1DaF/
	 sJGcq+9Vu+tIZxLSd7eF6sp0pxFyMKEUNNYSSOKjSa71qVhNJvW9Si5a2YNPl9Umn4TlN
	 8couZYUgFyoZ8BldK6esB59RqRLI72H9Ibp7B/ZHNl+FeWSF+4yYVedLo145iyu59P5zt
	 82SIreFFmPFPiD7Bs4PUUddzmldFbf2okulXKuANqHoiUYv3lEn8X3FlPhkyEdqQd8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794838536;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=YhJiqIC2CQYxKyjK89PKRm2NdKGhD1jQabLgnETqdAo=;
	b=1BrcIkic4HU5/4DoUP8JUnDXBvnoTtqoaK1YXgBBpIJ8ygxypCNBTkL7cB+Lq+wBaDyx
	 hJFUGTFhoQbqqZKLFfzbcEysbx+faYjN9nTwKE1xxUZVwTqZFWSVbvqqH0D9gVRHioqpy
	 xxIe27atBuaJu0giKnwAW9EuBunDoZkPi7nzTuRvIiS+8DjgO/OsmBd9V3lxl2HZFeEWQ
	 Sg4i6n2YcE6E8HaXbduehvatk4n2aTnk0FEdykf3AETAwzZDXr5IgU4Yb9S+rS/ApTdz7
	 eqrF+b377M/ZwSDPP7zV2DQhQLS4eMGfAxuLHyTC+SzwZ+j7wPW+KkbYPeYOVOXBdRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=P53w9KOT;
	arc=none smtp.remote-ip=45.254.49.198
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666BB606A33E;
	Mon, 16 Nov 2026 14:15:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 666BB606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=P53w9KOT
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 54db44753;
	Mon, 16 Nov 2026 22:15:25 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] media: ngene: Fix potential stale I2C adapter on initialization failure
Date: Mon, 16 Nov 2026 22:15:24 +0800
Message-ID: <20261116-c29ba55625-media-ngene@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1e4b6752903a1kunm077e66c010de6d
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaS0xDVh8YGEhMGh4dTxkYQlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=P53w9KOTdo7CHUuw9cvfLzxr1VqsmQCISo3LJzZEiVSZiJP4m8zgfAtcQzMMlfySstG+fy0RUnYSeKdbssvJQuu8PCOUYexOdrv2s1m00S5Vo3fYRkoVhfZJ/6wW70in2gLxEqw2hqgzEfkPVboOJYaBwCzLunag+z9kPfAMLY0=; c=relaxed/relaxed; s=default; d=mail.sdu.edu.cn; v=1;
	bh=YhJiqIC2CQYxKyjK89PKRm2NdKGhD1jQabLgnETqdAo=;
	h=date:mime-version:subject:message-id:from;

If the second I2C adapter fails to register, ngene_start() leaves the
first adapter registered. Probe subsequently frees the device that
contains that adapter.

Unregister the first adapter before shutting down interrupts on this
error path.

This issue was found by our static analysis tool under development.

Fixes: dae52d009fc9 ("V4L/DVB: ngene: Initial check-in")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
 drivers/media/pci/ngene/ngene-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/pci/ngene/ngene-core.c b/drivers/media/pci/ngene/ngene-core.c
index db6796240bce..b2864abe4b81 100644
--- a/drivers/media/pci/ngene/ngene-core.c
+++ b/drivers/media/pci/ngene/ngene-core.c
@@ -1368,10 +1368,12 @@ static int ngene_start(struct ngene *dev)
 
 	stat = ngene_i2c_init(dev, 1);
 	if (stat < 0)
-		goto fail;
+		goto fail_i2c;
 
 	return 0;
 
+fail_i2c:
+	i2c_del_adapter(&dev->channel[0].i2c_adapter);
 fail:
 	ngwritel(0, NGENE_INT_ENABLE);
 	free_irq(dev->pci_dev->irq, dev);

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
