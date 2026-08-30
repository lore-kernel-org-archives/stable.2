Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17683B6BF4;
	Sun, 30 Aug 2026 14:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788099653; cv=none; b=IUXpin8j9WELz9ryJmEBfkBxNKZm0x1TUzIwXiiUjuekYcFfCNNpIF678AX3ebvPzHNyZ4W2CXuYjXIczMCBuG1wv7JM7AmnSAXyYQx7HwZkAH7CE4hkgZu+1vl/eICuGbsnZzm5fs3sEc0iqG8WqKQNL5w48VWlDAaQpwMVfQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788099653; c=relaxed/simple;
	bh=T03PuuoSRa1jWsCZpYBXs4OhFF/fgPSmDr0NaF8p8PE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oQbMOB2FCnRSmbbNfMAQ+DtM5OwodoFCG+B1N+Z5Qf87gyU6g/lhz9XRrF8nGfk9oHZoqjtvqV+0OMsxO8oWuL2BJK68GA5roJIALE33fFK8mpPbznD3LstZVS9KiX5nYsG/96+IJCtEoHDPvk7PbYVIprrkmFFY+feI+E0+VK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=V3MtdQBH; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="V3MtdQBH"
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4bd71cb64;
	Sun, 30 Aug 2026 22:20:37 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: arnaud.pouliquen@foss.st.com
Cc: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	runyu.xiao@seu.edu.cn,
	jianhao.xu@seu.edu.cn,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: sti: initialize IRQ lock before requesting IRQ
Date: Sun, 30 Aug 2026 22:20:26 +0800
Message-Id: <20260830142026.2666914-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0530b321b03a1kunm3934c37810313a
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCHkkfVkoZHR1KHk4ZShgfQ1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=V3MtdQBHO7BeGQxMhnTABEcTnWBxXs1J6W5E7xBKU9FfPg1JgJiE0n7CYsiWB/XqdJ19CyJ0sjHjhNCOqU0JMzBkJ0m5Aekfn0aRyaoR1uK4g7FInxATUS/031LYXwp7R+1FK+nUwyxdE1KVGy/gez5uAZfS3Db5PEtAyheXObc=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=aTWn2c6FB8B9+AnEg+IOIk1k9j/44DH3LogairwFP18=;
	h=date:mime-version:subject:message-id:from;

uni_reader_init() registers the shared IRQ before initializing
reader->irq_lock. A pending interrupt can invoke the handler while the
lock is still uninitialized.

Initialize the lock before registering the IRQ so the interrupt path
always sees valid lock state.

Fixes: d05d862ead8e ("ASoC: STI: Fix null ptr deference in IRQ handler")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 sound/soc/sti/uniperif_reader.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sti/uniperif_reader.c b/sound/soc/sti/uniperif_reader.c
index 45d7613f5..5347f9620 100644
--- a/sound/soc/sti/uniperif_reader.c
+++ b/sound/soc/sti/uniperif_reader.c
@@ -416,6 +416,8 @@ int uni_reader_init(struct platform_device *pdev,
 	else
 		reader->hw = &uni_reader_pcm_hw;
 
+	spin_lock_init(&reader->irq_lock);
+
 	ret = devm_request_irq(&pdev->dev, reader->irq,
 			       uni_reader_irq_handler, IRQF_SHARED,
 			       dev_name(&pdev->dev), reader);
@@ -424,8 +426,6 @@ int uni_reader_init(struct platform_device *pdev,
 		return -EBUSY;
 	}
 
-	spin_lock_init(&reader->irq_lock);
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(uni_reader_init);
-- 
2.34.1
