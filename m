Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793515068;
	b=NgbGNIxpU8p1Rj6YU1JXD+MZX6O3a/6qdUumOpdUVMioBXqsUCIl4torFGKWdNfcMkfQ
	 qguUu6j/8qa9qGC6R2nqNmoQvOOrqhpXXciyMqmsTyPu0gEtFXWJa7a04zzdsIBNE2Kou
	 X1E82erLa0SyrmDXxvsu93Vwd/E5aD/yTC0AkBz1zBgvbxwDIeeJL3bnLOr5nqZOZMns/
	 hDRuqfXjqTsBitgpjmo2r/QDQe4Ug6B2vovF4dc77hqCvOuj+lDs7eGEgT50iI6jUsnqH
	 1dZCmFMQAm73YVFrhNVYcGPeprjI52Qckp1XepO1Oz73xpk93vaWMLZSAgnuRrxvyjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793515068;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jk+Iv7E50Op3JEPwALwZ9u6FV2ftF6XFRcZ7NgdVWFo=;
	b=sQ6jWyMtIvqsPoV6CmQ6ht++e5Wo5WPsrqyylHgW6VwFPGDSoyp8pLTcZ1EiWntaQEb6
	 ZGTwWgB3cswpkR1OV7oa2+nhpOING8Bawh3kU/7bB7lS9luGGvmPy320SFts05/Gtypnr
	 qgSAxS7WTCztvIUpSelNNYHWw0vaw/KCykYi6e+X76oGI5s/fSTBq4C7JepvZHI7xNB0i
	 vc07TgN4wjzGr8ux4+iFa97vQuI84LF8eTIlV+Z/w8DV0TxKUbS26l600eixp+stkHOgJ
	 gVb3j2JEoUff42wLg07P6r2FMNeJDKi0YpxUh/8dwiyRRCuZ1bBapbrSp6lFsyC4KeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zhQPQbUU;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D73F606A325
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 06:37:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D73F606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zhQPQbUU
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ac77270fbfso941743a91.2
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 23:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793515067; x=1794119867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jk+Iv7E50Op3JEPwALwZ9u6FV2ftF6XFRcZ7NgdVWFo=;
        b=zhQPQbUUhCYQFoTxvL8ZHBMO96oNrXROIr4p5ptS2/BMhHSy7+unGTDNoxZL7y+CpH
         aCUMkZFs7uwjg0LU+wIt3SSdjhm8qYaGqv0zLKFbrJGofDnBPFWyhuMUxc0FQUF3kuml
         xj8Sj1Fh6y/iEh2p+nPAHb3FwgaGz2tn28dSbOa6vpG5PO87zXCa49pBhgmZlCtPpA4f
         yrSliOz1yG+L5b7v1F4hCkn9eb266rcddg6ryjPhDkvjodoODsQXtNEVyHG9aOsVAXP7
         5a5VVJXFl5HRFanN5VzsV2jvfh1v7uJ4zF5DXFuGhUhpr9LjSxdNx5ALv+7TNOazvy4V
         ZX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793515067; x=1794119867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jk+Iv7E50Op3JEPwALwZ9u6FV2ftF6XFRcZ7NgdVWFo=;
        b=i9qilecItf4pYwr31E3SFgE34gPGmCo++etyfiQ3Rl06HcV/7Tow89/Y4QPXsuVMDV
         mD1KCDXDtw/pMlVGbOjdCWS8js9ZV1T4cehtm1eNr14V4g/ocLyLXFUlFGu2US5GS3UO
         /Nmy7ab+KItV8V/6JTT0osJsaY0mFiIw/Zffk7gfJkBwHkW9eyyPSIoZ3o+YPtt2jK0Q
         eV77d9v5xxo+AV0zTn82L+EiO+PWRF+ytci9i3HW3aWXGS/oYA4/kB4h92/Rf31KQm59
         YucVVh0EyfjsIRfwYvX8JDkpArJygISnqeMZwL5atQK6H+02yQc4f1fMfGcED4p0pPzC
         lQ5A==
X-Forwarded-Encrypted: i=1; AKwUvBxncTYcFAyXa0gHq8sOsoX0I6I5WPBJiTi6uaj/TcoAOlAnaVQe6sCIIAuvVluG7IVJanqe8Jo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+IsBne7JsvcYufP39iLr7JtEgnwDvDJ6zZLC0vQLyMEEZAuh6K
	V9F+/bCGGT/Bo3HWhZUe5S+7w/Idi9G/9WNYVcxBpiRzlrJ4hLtMgqCu
X-Gm-Gg: AYBFou0S+JqGCajksZTwF+rJQdlkFwrEiSDwYjxIBCujgWJu5Xkit3g2wDn+bHgPPZx
	c3Tl7gvdfG5O5b4Dvl2qcGlulp8EY37guOawhYYy0sZcUe/ErVq3YpfEKJMABbzKtcEWYzDhY82
	wkJ9MIOsGh1ogkuHCkq3tv9FOn/uRk9cNv6V3EwGcwsJnTJqtp/bJ6b06iLQ8OfujrqO7aLBf/Y
	FqK+TnYhImt/X9eH5vnbCZMxMiTiZKOVYLP4YRgRrpooW9GVratcIHD3MKW1tVtaj+s3Kkdc7y/
	48YQgYNtDbUtbzhetbjo7vcR97RU9/nocaiZ1jaknq/CbS4u6jqqv83lHol1D7i7cSWJ5NYk3n7
	XwhcRACO+Cl9tekYfW4aVD8m0Uz07MLUi4e1j68/5R+vlHP6LXsp54FHZtAAjRYnN97AlFbvGD/
	htJXrF/UDYnxVrnPGj2TE4n7l7IuFhUvqKQvpr0IUb2HuKwtoTb7566YOZkrzNtXEJzTz5aNEQD
	/pA/9WkD/xTJqtlVYwC3k0kl3K5qKDOy2JNtP9Y+c3SQklyLYpDhiYU9DIo9kfWa2GFOualWDgt
	xMktvvkQP+Z0aP5G9f2fIdTc/EpEy2QIrYs8dwuzdVS6TNoQ1IUZvEPNobbxvA1QN+TO
X-Received: by 2002:a17:90b:5807:b0:3ab:be66:ddbf with SMTP id 98e67ed59e1d1-3ae8981dd4dmr5417304a91.54.1793515066743;
        Sat, 31 Oct 2026 23:37:46 -0700 (PDT)
Received: from ubuntu24.vpn.host.chaitin.net ([124.77.157.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e2a703esm14120742a91.0.2026.10.31.23.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 23:37:46 -0700 (PDT)
From: BeaCox <0xbeac@gmail.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [RFC PATCH] mmc: tmio: disable dma_issue work before releasing DMA
Date: Sun,  1 Nov 2026 14:37:39 +0800
Message-ID: <20261101063739.89331-1-0xbeac@gmail.com>
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

tmio_mmc_host_remove() drains done and delayed_reset_work, but leaves
dma_issue pending or running when it releases the DMA resources. Its
backend callback accesses the host, controller registers and DMA state.

Disable dma_issue synchronously before releasing DMA. This also rejects
late queue attempts from an interrupt handler that is still running;
cancel_work_sync() alone does not provide that guarantee.

Some DMA backends fall back to PIO before initializing dma_issue. Move
their work initialization ahead of the fallible setup so the work is
always initialized when a DMA backend is present. Skip the disable call
when no DMA backend is configured.

The analysis, patch and validation were assisted by OpenAI Codex.

Fixes: 85683fb39d9b ("mmc: sdhi: Convert from tasklet to BH workqueue")
Cc: stable@vger.kernel.org
Signed-off-by: BeaCox <0xbeac@gmail.com>
---
Testing: x86_64 COMPILE_TEST object builds with gcc 13.3 and W=1 for
tmio_mmc_core, renesas_sdhi_core, both Renesas DMA backends and
uniphier-sd. A userspace model of the extracted remove function checks
the no-DMA case and modeled late queue attempts before DMA release.
It does not simulate real IRQ/DMA concurrency or backend hardware.

No matching hardware, kernel crash trace or demonstrated unprivileged
trigger is available. Please review DMA-to-PIO fallback, probe failure
and teardown on Renesas and UniPhier. The initialization changes cover
backends that can return before setting up DMA. Other work items and
the wider IRQ teardown remain outside this patch.

 drivers/mmc/host/renesas_sdhi_sys_dmac.c | 4 ++--
 drivers/mmc/host/tmio_mmc_core.c         | 2 ++
 drivers/mmc/host/uniphier-sd.c           | 4 ++--
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
index 426308b73b..45e34d57ab 100644
--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -340,6 +340,8 @@ static void renesas_sdhi_sys_dmac_request_dma(struct tmio_mmc_host *host,
 {
 	struct renesas_sdhi *priv = host_to_priv(host);
 
+	INIT_WORK(&host->dma_issue, renesas_sdhi_sys_dmac_issue_work_fn);
+
 	/* We can only either use DMA for both Tx and Rx or not use it at all */
 	if (!host->pdev->dev.of_node &&
 	    (!pdata->chan_priv_tx || !pdata->chan_priv_rx))
@@ -402,8 +404,6 @@ static void renesas_sdhi_sys_dmac_request_dma(struct tmio_mmc_host *host,
 			goto ebouncebuf;
 
 		init_completion(&priv->dma_priv.dma_dataend);
-		INIT_WORK(&host->dma_issue,
-			  renesas_sdhi_sys_dmac_issue_work_fn);
 	}
 
 	renesas_sdhi_sys_dmac_enable_dma(host, true);
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 775e0d9353..d0d3dd05a0 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1272,6 +1272,8 @@ void tmio_mmc_host_remove(struct tmio_mmc_host *host)
 	dev_pm_qos_hide_latency_limit(&pdev->dev);
 
 	mmc_remove_host(mmc);
+	if (host->dma_ops)
+		disable_work_sync(&host->dma_issue);
 	cancel_work_sync(&host->done);
 	cancel_delayed_work_sync(&host->delayed_reset_work);
 	tmio_mmc_release_dma(host);
diff --git a/drivers/mmc/host/uniphier-sd.c b/drivers/mmc/host/uniphier-sd.c
index 1eae2f4b6c..cd0fdffa30 100644
--- a/drivers/mmc/host/uniphier-sd.c
+++ b/drivers/mmc/host/uniphier-sd.c
@@ -187,6 +187,8 @@ static void uniphier_sd_external_dma_request(struct tmio_mmc_host *host,
 	struct uniphier_sd_priv *priv = uniphier_sd_priv(host);
 	struct dma_chan *chan;
 
+	INIT_WORK(&host->dma_issue, uniphier_sd_external_dma_issue);
+
 	chan = dma_request_chan(mmc_dev(host->mmc), "rx-tx");
 	if (IS_ERR(chan)) {
 		dev_warn(mmc_dev(host->mmc),
@@ -198,8 +200,6 @@ static void uniphier_sd_external_dma_request(struct tmio_mmc_host *host,
 	priv->chan = chan;
 	host->chan_rx = chan;
 	host->chan_tx = chan;
-
-	INIT_WORK(&host->dma_issue, uniphier_sd_external_dma_issue);
 }
 
 static void uniphier_sd_external_dma_release(struct tmio_mmc_host *host)

base-commit: cbbddb6b08cc9900a87cccaa9b22bbe06aa4f50a
-- 
2.43.0

