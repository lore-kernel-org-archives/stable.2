Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794308089;
	b=ZLWep3IHzOmOpsN09ZiYYKO3btZ55VpTQePyoV7pfGRq/F5CzipuM19QfASQXOS6USVZ
	 egWRyWwTVTUSbUb1OPURQqt/ljfuJ1X/qCRKgL1epJV3gGz+JWBvv/Yh9Rk9In/kzCyMV
	 Ltr5ks0fHiWyZqr8XcSwGBeQqrQM/nUfJtBfkQploCuLaF861qUundqZAdwUQnGCC26Qw
	 8/B6xSL0uvZuXWVi+RBi0wVecdga3Qfxiv0SLIH3wSoh4uJuV4jjDk6WXaLOK7K/VzBYk
	 DGuh3+u2HLyPOJ2WzhE/yy4UOcVYQ830QRclaimRJqGxLppKVdjsGnoiiBZUGMFN5RA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794308089;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tepxdS3pjiqx/ESdTVnng/n4oyG1h1s3ol01nQq3JzE=;
	b=uAZYyK6QfrynCFnyjKHq3RilEBXx2Xy4GDJsEmMUgRFKoQ5z8Yw+aOIjtPHiSdLc4KAx
	 dByuUy9UyGw58HLvFk7vhfZxcNK3NISGq762oogVd4HIj3d/M6EDQ/EQ6H6g93Ml+KKjB
	 TgiUHtapydql0j7JjhCDBP7UzhQoQFsmEpkexR9hboY/WIQuFar4/HwkXyxsrb5+RzT1q
	 JoxMfHgKTSKBMmEh9HyQvRGvIuLRnSaVu+NXrx43zBYakR583BPadCvcYyp8moWPNiCRP
	 TFXXFPAwVuhuau6PFERUg3xiCuQItlcd32WwypxY8uj7fo66m25bZhsY65IMTbn5axw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uZityvrN;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5370606A330
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 10:54:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5370606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uZityvrN
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1931ff67a29so1273566c88.1
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 02:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794308088; x=1794912888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tepxdS3pjiqx/ESdTVnng/n4oyG1h1s3ol01nQq3JzE=;
        b=uZityvrN90qVe8O21VXCg0ewFNCIQ1qJWSu4qHqZ4YY5NPvud9xLlK+OKn3kryPYkx
         jQKuNgfP8qoaOksJYR0kS7grG3VMjx0jEXNL783V1G83Gr8vAlTA7UB/MWixiAByKHJW
         YH6zKfuApBxqw/A4Ze2TBZcCu6tqBJkdv1+UDsQDjhoKkuF7J6+MQL+pbpo24+gqFEKC
         e2E7YR9QxQf+BRaXcoSW5EIjhePbk/AH4kOcWd+DqB3MO92bTdZoPfI+ywfDsWpGYMUT
         KRMDeA+pG0K+vWZrs/zteuA4xCEzduYvOkkvn6ZBl+fXmhUcb5ERLtWS83HzGhDMrQFk
         VxBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794308088; x=1794912888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tepxdS3pjiqx/ESdTVnng/n4oyG1h1s3ol01nQq3JzE=;
        b=uuUMuobGu6O7ml+cy8bMVvwee1cFPmPXsLAKSB5lDTkYA+8E/cyELnxDGaR1XjLJNp
         0T46u6ilfWBlTnAiOc4QtNNrlWrCvwMFRFBHMPYMu62NsCR9vkVa+/O/nJM6APConfIW
         3h8xyxk0+YLC9sRBIp/rCjlllvhQQ6hVpWPP7aX3S/Fr3vd342L0QP6rxOG5EdHZLWxV
         qdL+YhZodLs8Y9D77LZsnUNF2QFzf9f+xl4An2wOkimgAvd2awbHCA1GjUcZajH+2SvZ
         aOeuUxCXDGg+9XU0syjiPXVAPItqU4H6FFNQ1yCk8bgT+UQzCRl2yYYgYAAxzyWWxFP8
         sYpA==
X-Forwarded-Encrypted: i=1; AL+hErFwtz59M+i0ivPCStzCMSWbNu3oshGt39vRl3RVSbfSQ7V2s16nP7+I4Gtzg4NfftWHOqLf/Oo=@vger.kernel.org
X-Gm-Message-State: APuU4Z804cvb7MlWKOk5Mu2uTOgkJzFRKmczC068UchfcLLVui5Y0MaS
	liw9DH1XkPTm+OEN2988L7Yf9LaijZlLSKYpRPBmz9PyGsqiCXahr4lU
X-Gm-Gg: AYBFou3oVDNpuEgjqI4jFPtsRY6O3d5bBBSZJPChvOwkw/57GauIC4QAnD16sJE3O7T
	veqF2KANX/jtZOi6a3QMsdqt7jxT/RTGcW7btsQEOBOA0nu8cPvSTG0xViqsEdOpMWnxg4Ryni1
	j2zM/CJmDiZbXHvYPKjWZpwcRDDaQl+LlOtmjSMzG58HxOXVHGALFiPCx//hIZgRyZbaIittyJ2
	mE1TfVePk0G6W6JaNd97BIJw8lgzFrxHpltPAlnqqPZOI543SNawp4UIWE9jMEM3Hh5HAKPQTaS
	N75fmiYyI9y1leeqW/PXlmsvIZqU7U2VB6Cur2QKiWE3LdJZwwIHpdQT+Lvg4jeVhQCfAyxzod2
	bZs0ORnrg+E1WvWjKN37Jt5+pSKgJRn8PIl1tMgDhwd036RvgoTg26nit9L3hGkfF1piKgmJZYZ
	cNCdswufubTpj8lTfPFII6PgzpXt8FZkNgjw2zF7Vx/woxNE2IydoB2cF9ph8QSAenibMpn4ekq
	gTYkY+JFSlHM/CzXv5t7ieqCbfyGMnfLEluMsrwHOwEaF7amW1HVtiUX0MQ+O6ExWdMvq0RRQ60
	jx9MxDwccPFigTdl2b/MG+L60AftVIZs6P6B1YjNfzD8UNfM
X-Received: by 2002:a05:7022:f50a:b0:1b3:a9c6:b293 with SMTP id a92af1059eb24-1b3b6077440mr2856751c88.25.1794308087698;
        Tue, 10 Nov 2026 02:54:47 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11435sm6996923c88.4.2026.11.10.02.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 02:54:47 -0800 (PST)
From: Hyunjung Ko <hj351016@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-remoteproc@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH] remoteproc: imx_dsp_rproc: drain the vq work before freeing the mailbox
Date: Tue, 10 Nov 2026 19:54:36 +0900
Message-ID: <20261110105436.2487822-1-hj351016@gmail.com>
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
Content-Transfer-Encoding: 8bit

The mailbox rx callback schedules priv->rproc_work (imx_dsp_rproc_vq_work),
whose handler takes rproc->lock and calls rproc_vq_interrupt(). The work is
never cancelled: imx_dsp_rproc_free_mbox() frees the mailbox channels (which
stops new rx callbacks) but does not drain a work the callback has already
queued.

free_irq()-like teardown of the mailbox does not wait for an already-queued
work item, so a rproc_work still pending when the rproc is torn down runs
after the rproc has been freed and dereferences freed memory (rproc->lock) --
a use-after-free.

Cancel the work in imx_dsp_rproc_free_mbox(), after the channels are freed so
it cannot be re-queued, before the rproc it dereferences is released.

Found by static analysis; not runtime-reproduced (needs an i.MX DSP with a
mailbox message racing teardown).

Fixes: ec0e5549f358 ("remoteproc: imx_dsp_rproc: Add remoteproc driver for DSP on i.MX")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/remoteproc/imx_dsp_rproc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
index 96d619d..89c72d9 100644
--- a/drivers/remoteproc/imx_dsp_rproc.c
+++ b/drivers/remoteproc/imx_dsp_rproc.c
@@ -642,6 +642,13 @@ static void imx_dsp_rproc_free_mbox(struct imx_dsp_rproc *priv)
 	mbox_free_channel(priv->tx_ch);
 	mbox_free_channel(priv->rx_ch);
 	mbox_free_channel(priv->rxdb_ch);
+
+	/*
+	 * The mailbox rx callback schedules rproc_work; the channels are now
+	 * freed, so no new work can be queued. Drain any pending work before
+	 * the rproc (which the work dereferences) can be freed.
+	 */
+	cancel_work_sync(&priv->rproc_work);
 }

 /**
--
2.43.0
