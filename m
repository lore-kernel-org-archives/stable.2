Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460B93C1D65
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 05:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787894113; cv=none; b=WxgL/xx1IhH7/S3w0inUN9xyMsNSXiEQe+qmFUy5cjcphsieujQMJc8mmwNrX3B4mkQUwONv3Pc7kqlbQa9XNG8YWmnPKfcVHS8tFhd9OyPcF30haqkXStPivF827KyO9jkc3xDqRYkJohHRARPjCjc+lElFfG8T7JlU30CRSJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787894113; c=relaxed/simple;
	bh=ooNpW8JTLerSSYS5oKKFbYXh2GfP0xI8kf0/srn2Jwk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=txSg9524hVaZitwQv3BYWeM8FvMzBaDoLslEUvYSy7VkZyOyUG2vRaOmurCkmr+BJQzfq4n1VzytYR+53jR+kIF/TU7GZzZWVYEtQ6YpnrE68GGRszZShm43RzwHGBP9dvTIXuHIToTcc3hr+wcRp46b9QON35rNNcAFadpM/Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3KyARQy; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3KyARQy"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso7165655ad.3
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 22:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787894111; x=1788498911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+L5wETtDoWmts2CARQJ7hOgr0xkLRcjESgYRsPtYLoQ=;
        b=l3KyARQyiN+u1Fz8oz2XgzBL6Qf0xLXmeR5XlXvTIrGSoiNiSdIx9/0ovPsRrBnidk
         xykJNABvXAuuRjTaQCptZpTvChoEriNaEf/CL05QUOM5myRqRCVSh27AVW6HZnKY4zIs
         lbDqa3vzoTN88W7BlfNWEuVAizhBdWTn2RRFfNgMspzPwnezFqjgpXu0sBlKdQJUJUoc
         47Vas6x9BVH6QLxRjhYDZE8ZU9hy1kDDkqx/YRUOe9FXmef32e/pQpwwEz/qermqNzi/
         BIo5AVx2nbOGoEZdLL0fATKDEUtUIMWvZ/vz4+JMb9lqLdUyrOLSznTMVPuWgZ0HNWeP
         jBTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787894111; x=1788498911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+L5wETtDoWmts2CARQJ7hOgr0xkLRcjESgYRsPtYLoQ=;
        b=I08A+M1xw0c0hmwwazG7KlUk5QanOkNaIifL/0D7h2Dux81VJK7jzIWoUKdAmoNxQ7
         N6b1vCycxS/Ubug3YGszb5xX4Xc5AgGT39tOivlji+QxyI5FwsWUgVwWxLxwrqmvoCOH
         YhOKrtqgVlyUSEqDUi88E5nQsRJUUzQ7dR06LVPYBuqzTwZ59HQogmcXiHyJRDS2fVc9
         rMq9kFui+j5lZ9MnF1W5oKbXeyx7GzaAdVEzXw9K8T6u4gC752c/WXsFSUaiFDfamKZi
         FMr1m7Jz1lhO0af4nczE/AK7DFabbxVmAlsk8qdCL3HoGjeV1VSAk38IxVRibSaOQ7yd
         w3+w==
X-Forwarded-Encrypted: i=1; AHgh+RpgCmDC9WdTCcL8RIkDgdOYPW8UIxhLcUpqzOcD9hz8MK8/aSnxSa+R+z0HfOts8EIrW1scy2M=@vger.kernel.org
X-Gm-Message-State: AFuF++m+ilPU+luWvnsjRGhZiU/nTL9AIIN1WBho+ZUAQe0YWBD226sd
	jqVWBYTO0lW2msAFqlGoiAlxkRqu+L95l51KAcWbLwVGwqYVUPXTFmwB
X-Gm-Gg: AR+sD12wmcPVyaCIFYfdRJZPBUUM5bjQrOZM+m3FtdKYp2HXg2aKRn1cl3BW7YXPu7A
	HlgoTj1EPYPWDNPNHl6MuhYOfg15f8c1uByC3kpF7yswqWMWSMRqfCR29ljCE90Hfg5T4aq1b3m
	2Q4RzoT47PapahN34AwzIpy1hPqdIskpmZF9MQhcnUh+OM4y+tK+Pmi6JSmK7hmmhMfvNEuXTSs
	z63PMOIcaNeDW9ZTM9GDN+lRdxFmJW6l6NR5YZzGoxaGjTvnwhilPP6I2Nn45YFEsmshlhP0WEV
	yKeN9MzemW1d8CvYrN0aiB8ZmI7HAMlDpGVLJHTQMlNW9ux8wwQarJL8ExvJl/foUsLNVVWBS3G
	JrE1/QF5KVEUoCCV7EmdCqW8qNZFxjVUTpgnms9nMkmvc3DOGfzmjCa2z0kl4qSeiRmESZtrVPq
	KlTT8Qb4Hf24HN/N3opjlYEhx58iYF0RG/QW9I6e3xWznxAmR00MnuFA45dt+UgAOatJ3yLFllB
	gtir2AkiJl/ozWG+AN89Hc3RfZJ32xqfiMPdR/2s/k=
X-Received: by 2002:a17:902:cf0d:b0:2cf:ca89:499d with SMTP id d9443c01a7336-2d74def3ffcmr81309995ad.7.1787894111223;
        Thu, 27 Aug 2026 22:15:11 -0700 (PDT)
Received: from hnkz-ubuntu-vm1.mshome.net (flh4-125-195-69-140.tky.mesh.ad.jp. [125.195.69.140])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d75952ea6fsm2011745ad.21.2026.08.27.22.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 22:15:10 -0700 (PDT)
From: Kazuki Hanai <hnkz.64@gmail.com>
To: Mirela Rabulea <mirela.rabulea@nxp.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Ming Qian <ming.qian@nxp.com>,
	Hans Verkuil <hverkuil@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	imx@lists.linux.dev,
	linux-media@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kazuki Hanai <hnkz.64@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] media: imx-jpeg: Cancel timeout work on release
Date: Fri, 28 Aug 2026 14:14:52 +0900
Message-ID: <20260828051452.1940559-1-hnkz.64@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mxc_jpeg_device_run_timeout() signals job completion through
v4l2_m2m_job_finish(). This clears TRANS_RUNNING and allows a concurrent
v4l2_m2m_ctx_release() to continue. The timeout handler then accesses
ctx->mxc_jpeg once more while releasing hw_lock, but the release path may
already have freed ctx, resulting in a use-after-free.

Synchronously cancel the timeout work after v4l2_m2m_ctx_release() and
before freeing ctx. The cancellation must remain after the mem2mem release
because the timeout is the only completion path for a hung hardware job.

Fixes: cfed9632ca8e ("media: imx-jpeg: Add a timeout mechanism for each frame")
Cc: stable@vger.kernel.org
Signed-off-by: Kazuki Hanai <hnkz.64@gmail.com>
---
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index 725e94152884..dfe3b1ea6bb4 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -2805,6 +2805,7 @@ static int mxc_jpeg_release(struct file *file)
 			ctx->slot);
 	v4l2_ctrl_handler_free(&ctx->ctrl_handler);
 	v4l2_m2m_ctx_release(ctx->fh.m2m_ctx);
+	cancel_delayed_work_sync(&ctx->task_timer);
 	v4l2_fh_del(&ctx->fh, file);
 	v4l2_fh_exit(&ctx->fh);
 	kfree(ctx);
-- 
2.53.0

