Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C41531B0E
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 13:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790171594; cv=none; b=VTkwwPwqNYQ323/UAzLmCox79yOLGZiebjbJfj4p5y+bZWMWxUI51tOv7OUNrhZMIsWAjk3Y34TnUTNX/UvssdQWK8XKjG6l13XF+SWDVvtjMjAT3/zlk2/SE9r56ZZH+jijdgfxqR7hQFQtpwHyIEks2av2m40y2BpJiFk5LfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790171594; c=relaxed/simple;
	bh=pc0FDD6IR7pFOD7noF91D54mnHrzpCH4w/W7A8vQcRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gZp7DtmRcpTGLJl9Snh3NpFYGxQMqXaFvD/CsRIVIHkU3Ow01VV3k7WHkuLgmxVIpBiEg0FAR3y3o6kDhNzc5nDM4wyR1gwrjkD7o7HrLjM2u+nTlJOYX1tYXgcBdMekl5qkiIKx0zwbxUw2iHCNcnP3F2P67Lyh2oCEPzHAGaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFsDq/JH; arc=none smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFsDq/JH"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e7c72bfe9so325869241.2
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 06:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790171591; x=1790776391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2SglU6SsyzFxHFyMmhSwCTOipsWKClut0lOm4koa3sM=;
        b=QFsDq/JHrtEo26ZX9kLZzebgNEJYM1rcVa325fdWYhFm/HLwr0vP7wNfJ15PQDBnuI
         /K5iZLplxUXb7geAgbH8Ilbwftq9fFQ4h2NmJjqiLOQuaL+9NZ148TFZl1NybA2kz673
         hB7RAKFT+5Gh68qsM+H2zXgL8UlazdmF3SaJCQKfvd3YaXX1HD9ZGWaPPUq8AQQ73Ncz
         7AXOXKdfr6A+gkRjTAYJpLvzEJQQP6q8iChyZF/uqYVXLzd9c+/Kht/TO4b91OLnZgFf
         NKxHhL/fW3B3ruplMQ/VfdqcXSE8wddph7IfSbuA7u/KukBXHcY/FRtJwJFSiNctpdWV
         iu9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790171591; x=1790776391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2SglU6SsyzFxHFyMmhSwCTOipsWKClut0lOm4koa3sM=;
        b=HzL4/NiLONmKAhddAPOV+KS9Q3Pj1GUXOQkMy88WAFdWaLCUuGXy7mX0WeOtTrt/2H
         7YykgkNBryhHMO9PwzczvdmJpRW6qI8ItTs4BiVv+7V5aTOGJgvedTTXo2pxqEB2lmFh
         l8rAHP/ZNzAv+nmNsYbxVJCwWLf0iIkOnvuoz5gifOLKX0YieHQGPEBHhB6SmG9vP5Ik
         QcyvK/Fsg9fUaxWhnI+WEYIA428wT/oH9GraeM1QlK2uZsnp68y2yYQr1FIk+YIRKgby
         NiWAMCc6BFOA3WPF3vyVvwdleYxfq61r/meoOCkDA4E/WiSoa5BDto84NKd2w0DwTwnO
         3uEw==
X-Forwarded-Encrypted: i=1; AKwUvBzEpSEEQCxYJH3wHDRmnM2hVqqLxGd99/pFQ6olb0Rm8VKpyb2Y8dDL1m0gPHCp7T27bNxFFwM=@vger.kernel.org
X-Gm-Message-State: AFuF++nET2H/IGy3UPIRc3kQE4L6eA0j2ydIVcgEROp5rjoAwhKMGQ4c
	sRVPM1yVquhamGPC0d+Ge4V0w7fbckQz2ZAaMKGVudbVOL0GTp9sALzv
X-Gm-Gg: AYBFou2Ha+t9Hd0zcCLglXUyzYRXrtG+O6xjMU5ndZ7siQn22wVTixdt6v9z8qaA24V
	IwVat4PNlfIsgM5xrs9az3pj38JJ/g9AJJ4VbrTWCBmIeLdYS/zwBVs2ras+KBKN7s/ODaFi7u5
	Los/3Sut6R0qpbRD/rJLC4ffQANeefoE/oeB//IaU8nGDLc3cvvsy4twj3faSxW/jO6KSYFr0me
	IK2AJvNrIKwwT78UiInI6ValWmifHfoLGIBaynKcwao7y316l44U+KgmbnpchOAZp4mC63HSVns
	RDSz1AuQMt8mGIUWyRy5G/RFKhW1EfCfQuD896BE8SRB0hWkMKtCMC/cqILk7FadAGzKNEOpE8+
	t3st7dbrxzJSAZutQ2M+FBNrpJlYLzyoNIxy0jVrmvhnrfm1eUKcHnm3qm1Qb4wFB9dg48uxrdK
	aKiQTZPGWXinaoM1l3+qx4DE4PvryiLfw85WBC8l8QF6Lj9NLKhHR5EqrnCNd27LY=
X-Received: by 2002:a05:6102:3f8f:b0:7a5:1d50:ac35 with SMTP id ada2fe7eead31-7ac1db3268fmr2130763137.21.1790171591494;
        Wed, 23 Sep 2026 06:53:11 -0700 (PDT)
Received: from beelink.. ([187.13.30.172])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7abf35bdfbcsm3911189137.1.2026.09.23.06.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:53:11 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: vkoul@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH] dmaengine: fsldma: kill the channel tasklet on remove
Date: Wed, 23 Sep 2026 10:53:01 -0300
Message-ID: <20260923135301.2448228-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fsl_dma_chan_remove() frees the fsldma_chan structure without first
quiescing the channel's tasklet. If an IRQ fires just before the
remove and schedules the tasklet, dma_do_tasklet() runs against the
freed channel struct, causing a use-after-free.

Add tasklet_kill() before tearing the channel down.

Fixes: d3f620b2c4fe ("fsldma: simplify IRQ probing and handling")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 drivers/dma/fsldma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 22d62d9..0e2f848 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1205,6 +1205,7 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 
 static void fsl_dma_chan_remove(struct fsldma_chan *chan)
 {
+	tasklet_kill(&chan->tasklet);
 	irq_dispose_mapping(chan->irq);
 	list_del(&chan->common.device_node);
 	iounmap(chan->regs);
-- 
2.43.0
