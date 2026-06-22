Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB86359A68;
	Mon, 22 Jun 2026 09:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782121747; cv=none; b=jomeuNjd72BrpdO8AzSNaI3PgL6xFntDBQJUpKqZYlY8OoypWmz8+LrH9eU+wU1np12DM+EN1Pq7isOuNyEhR3+1ZJxjLGEoZtssGeccXyccHj+UAjG3k343SpoZcwKzVYBE3aBBDy7ryQvM1GJRHf1SxS/mn/cn3DG2+JMcj0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782121747; c=relaxed/simple;
	bh=v2yU6hcM+2EF+mmVxEZQVzwfZuqUJ0ecIg15DVQPsJ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=giAGomPRmivp78TQgItJvVGtDJxg0vq1udZ6xVcKoVFkxOMDdhZyf4lIuKHdwKNpXTENRrbzrdS8Sb75oB6nHhHU2poum66vjgHeBTpBrzMixlnHlGV5Hb18wIJevdlFKKZhNip1RmtBNMmkF3ujbOGivIJxqV3X0B+HqUOyPXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nIslxFQq; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nIslxFQq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=hg
	o7GNE0+Rw0VXOMMZ/9z8erhMb5Ms+UQdAUs2CdoQ0=; b=nIslxFQqID9ANDTwZl
	+Z2+b1vv32aM8YCRHJHwTSBaKalXIrWv4U9kvek/tEg9qw8q109BDNUIfVsKKRwO
	eypeEH/zrpJPjgkH6ZyAwR6b+pouofyUqF457YB52VAHxXxnTO7fBZk9hxMI501O
	ehgYtGlVOFKOdK6zrHH8UhO20=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgC3mfjmBDlqRw3vDA--.63960S2;
	Mon, 22 Jun 2026 17:48:24 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	emillbrandt@dekaresearch.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: fsl: mpc5200-i2s: Free DMA resources on probe failure
Date: Mon, 22 Jun 2026 17:48:22 +0800
Message-Id: <20260622094822.926166-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgC3mfjmBDlqRw3vDA--.63960S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr4fuF1kZrykCF4xJF4kXrb_yoWDGwb_Ww
	10gw48Wr95Ary7KF9xCrWFyr42gF17WFW3Ga1FqF43Gry5Ww4Fyry5ZrsxCFWv9r40ya47
	uws8ZFZxA343JjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRtBT5DUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbCxggkkmo5BOhRtAAA3i

mpc5200_audio_dma_create() creates the DMA resources before registering
the component. If snd_soc_register_component() fails, the function
returns directly and leaves the DMA resources allocated.

Call mpc5200_audio_dma_destroy() before returning from this error path.

Fixes: f515b67381de ("ASoC: fsl: mpc5200 combine psc_dma platform data")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 sound/soc/fsl/mpc5200_psc_i2s.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/mpc5200_psc_i2s.c b/sound/soc/fsl/mpc5200_psc_i2s.c
index 9ad44eeed6ad..7831136f4f12 100644
--- a/sound/soc/fsl/mpc5200_psc_i2s.c
+++ b/sound/soc/fsl/mpc5200_psc_i2s.c
@@ -170,6 +170,7 @@ static int psc_i2s_of_probe(struct platform_device *op)
 					psc_i2s_dai, ARRAY_SIZE(psc_i2s_dai));
 	if (rc != 0) {
 		pr_err("Failed to register DAI\n");
+		mpc5200_audio_dma_destroy(op);
 		return rc;
 	}
 
-- 
2.25.1

