Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6B7355F4E;
	Fri, 28 Aug 2026 05:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787893709; cv=none; b=cMPB7wTCVhjrBoG8au1BzOM3wtEEwlAnOr78uQ4z4ooAJVe+S59qs6emVmEh5GbCdiVLFiwQm1gwH0NoNznP9AooYG0A1ynWrSNIpDcSUjZ+N0SQIKM8MlNWfx+HMPq3wMfRJVpCeYKxtJahY2XBT7rW/n98GnI+SvEtQrdJy/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787893709; c=relaxed/simple;
	bh=X0Gep0btEjJu/T+EyYd0jpqhvft7cu7/20fyUne6dDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O3UCvgptLcOIJNY4ZwoOmAVAvLkXHd9oBf1SNDf8W1VaCGfSJ+4xzTRdc1CceCN0rKyixPzL0sl+nhrdvVcQFqOCq/PGIThFodI9QOOmypnx6y1tlJhkqk2UeIIUzzSksItmlrXcFDVTjJoBYvPFPZUpMBtC/PkBeEBKoVrFWNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=whut.edu.cn; spf=pass smtp.mailfrom=whut.edu.cn; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=whut.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=whut.edu.cn
Received: from Mogu.localdomain (unknown [223.73.65.69])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4ba72fe23;
	Fri, 28 Aug 2026 13:08:22 +0800 (GMT+08:00)
From: MoGGuU <Naixumogu@whut.edu.cn>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Oded Gabbay <ogabbay@kernel.org>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Sidong Yang <sidong.yang@furiosa.ai>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 3/3] accel/rocket: Propagate job submission errors
Date: Fri, 28 Aug 2026 13:08:05 +0800
Message-ID: <20260828050805.38548-4-Naixumogu@whut.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828050805.38548-1-Naixumogu@whut.edu.cn>
References: <20260828050805.38548-1-Naixumogu@whut.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa046c4e09203a1kunma5b4953488371
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZH09IVk5NGh1CHkpJSRkYSlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVTEhVTU5VTUJZV1kWGg8SFR0UWUFZS1VLVUtVS1kG

rocket_ioctl_submit() discards each job's return value and reports success
even when every job fails.

Return the first error and stop submitting the remaining jobs. Jobs queued
before an error remain queued, giving the ioctl ordered partial-submit
semantics.

Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
Cc: stable@vger.kernel.org
Tested-by: Sidong Yang <sidong.yang@furiosa.ai>
Signed-off-by: MoGGuU <Naixumogu@whut.edu.cn>
---
 drivers/accel/rocket/rocket_job.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index b55e12aecfe64..8f1bdf4a57f20 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -646,8 +646,11 @@ int rocket_ioctl_submit(struct drm_device *dev, void *data, struct drm_file *fil
 	}
 
 
-	for (i = 0; i < args->job_count; i++)
-		rocket_ioctl_submit_job(dev, file, &jobs[i]);
+	for (i = 0; i < args->job_count; i++) {
+		ret = rocket_ioctl_submit_job(dev, file, &jobs[i]);
+		if (ret)
+			goto exit;
+	}
 
 exit:
 	kvfree(jobs);
-- 
2.43.0

