Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794450604;
	b=BcFAECUcZj5lXi3momivgXKtoV0hQzsIRYm3ljExwUbWnRWleT79EQZETSOBenwWK7cS
	 EcdI1tfxKs/DmpCqhsfG3rcBHDje3rVC5kogGHYNVobSbOFLykXNwaJswGrxUgvBPcrG/
	 9wm0bx6x/xQlskZh9s66C6G/es9kU4ALb7v2RPgELdgLoom5qOxma/yxojPR2Vcg53X2s
	 AaB8F7JK8knzW/1nInhM/KkXKVpaOrOybkjnNJ01SlWTXL0Oes+RzNvW+eYrvXCa6GdRq
	 kiW2EGcaA+cTyD84De1K5zZkFkmLYvbJKYnOmx1T65RQNw8cSYkjwDsHkSO3GmACsvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794450604;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZBRlQut3mwF1KjSJZBxJE4prR1XigP7CCRTm+ueBhko=;
	b=BeZpDRKhBU5isnexX99WmwgkYYcZy93VRVlcWx72JMdm0mKO4pfoJZY74bpYNdOXgRel
	 z16138V4vlyyCyThPXtQv89iUIlI1/C5en+xK9gApqw3PgGHLO5RITdYi6ZkjHh0SbsoH
	 +wr4Ot+jAcz6NgvFRlYGG7OZp2tNZ+aRn8dvvOVmb+LzD9vBeQw44hcl1hBNtTrQaNWCh
	 7ATjsgXf2u1F1A3E/eJGRkMyPP5uk8M0GMwSltjPNJ3vmV8tt5OUUrHwzvevU4ZqHPWsg
	 ufSoU7ATXqk4r9+IgBsV9Ki504nyklWvhtF1K+oh+hFL9h7kQE9wd41z9UTKaz3WkOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TNHSzffA;
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C051D606A330
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:30:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C051D606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TNHSzffA
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8b6399ebb41so3301400b3a.0
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 18:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794450603; x=1795055403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZBRlQut3mwF1KjSJZBxJE4prR1XigP7CCRTm+ueBhko=;
        b=TNHSzffAV6ipZ5QX7ZX4YFi9fGrwRUHdpVvZFzGQ8XIZlthyl8sKXz6T8aRZibxLlZ
         OmNxh7ZDMsCqFBR9SnKwYceVyIC+skfHPkXeeUfs8XwDGaJoGaxg8htKhW/agv8fYQUN
         XkfoP1zwvdyV/aMvmSmO5Vj5SnUd+SYFrcrdKB8TaLZkpZeS3C/C+0K+KZp1p8/eQk0T
         mOp7/Ihkk17c+Ewu/bvb6RYdcr/TTZ/PKIY0UFWJiJRPb/gNfDA3MNb+zbmGqnLGsODV
         4gF9d1ccHhi7ATbzsGJVAo8M9zBQ1/jRoORr89hYxcvwFzktv8L9WnEU00GJfB9GNXz5
         J4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794450603; x=1795055403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZBRlQut3mwF1KjSJZBxJE4prR1XigP7CCRTm+ueBhko=;
        b=1PRBA7KCtB2lk0Fjphx+/PQWc+iZVeRknBJVyt6CLyPHHs9muWDlT3MuXeXwTk4BHd
         U7EZ4iKPfO4gqPcGKZS74SVemqCrDW9xA537tBuu1QX/1SHF07E9WO4EbhyYqMqJI6GS
         z65L12FpR0dRpxoT5Y8RIOLUgGPZA0uHxZ55eJnYKyfS9Gi2nznegyy4/6WyFZURpOLz
         M7U4hPIPMEvbkJdtu6H9qhtC60LAO3rMAtpyviq3H5+C8eBMU7hKDRwSSUD0QQEpF/Sl
         S86BC57dkREM0ULefmz1ovDgq80bJDJZapylGIMFabowE4WUiwrYlZYrWjx2B0uFZ5IZ
         MUqA==
X-Forwarded-Encrypted: i=1; AL+hErFxK4SqA3oDaEaMa+7hOwsxoowzK7+t2oXo5WjfRgmG2ODvyHJ2BRdlkj0VASsuEZxVnhwvobc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ikUDRyhHaw+mgkXUJJa8F8i8fl21ovUlYYg4fkUo6/Hsivt0k
	FbeISEGUi9c7IqkLnJL8sk0NzI5S3/lRKzyis8M2Rp0xDnvcTXc9y425
X-Gm-Gg: AYBFou3ShgRn4TA0W7zqcU0+hQPrmg7FVg/n4YOC3ZB+sa7mswP89YJmCvyaoyrwydN
	MIHBVzotr1dD7kg2t0kFTllsmra+HmCqV7akZIUixppyIGvA35QuHpmFAfEGnBF6DVaOm/Sf7NF
	Amle5V3heIE171z9fbAehhCYzK8vReqlPWAk9nFhtescuqhjZoiBhZ98We8s/7IVHqG3AFht/wf
	eIYsiWMXg6UCKfgFYhjtT1STqdTWVaPo4aom/X6NJSPXnKgZ6t12FH6s487cHHJpgto00PIAPLA
	mlwsRWj6x3lQOYgiWFhDKx9oLPd08KP4327fz+EY2/J/5s2HoPGUG1VBAx+pH/vbNILL7DCi23Y
	drq29cCpndmR765vKfjHUkn97lYbh4cU3djSow75d68T7rgRDdwKR8Qaq8nvNRcrhrIaJ4FgERm
	wfW2vWo0nP4T1+62CoBq0R1iHg2dFaSXwntkSB65kPDQVa6vbPvMloUIXUQbiyV1flRGRDN/gyV
	bHWV4oPcZmZkTiG5BPdwwQWznRG3JJeDbwv7MxdGers+gNY6hE4QyjDdVFFAlv917EMBw+bS7Vy
	w0QVnMNT74As7lKQ9hIaL9jta9yseN5Cx+jJcgX7elm1Xw4N
X-Received: by 2002:a05:6a00:3693:b0:8b5:7fc8:8679 with SMTP id d2e1a72fcca58-8bc1cd5fb7fmr4228562b3a.21.1794450603001;
        Wed, 11 Nov 2026 18:30:03 -0800 (PST)
Received: from ubuntu24.vpn.host.chaitin.net ([124.77.124.144])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baab1226e6sm2618017b3a.43.2026.11.11.18.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 18:30:02 -0800 (PST)
From: Yuansheng Yang <0xbeac@gmail.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH RESEND] mmc: tmio: disable dma_issue work before releasing DMA
Date: Thu, 12 Nov 2026 10:29:54 +0800
Message-ID: <20261112022954.7473-1-0xbeac@gmail.com>
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
Signed-off-by: Yuansheng Yang <0xbeac@gmail.com>
---
Resending with the real name in From/Signed-off-by only; no code changes.

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

