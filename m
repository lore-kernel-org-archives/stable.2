Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795461505;
	b=lxujKCC+cx7cQZoDl2KV0rwRYhvz/gujWnfnVzeSh3RkR6Qa2vb4yK4vfxsKu/7BkC92
	 T/baC1kVvWtgKhzEFKdCEenfb8yltX4XvgxJmS1rM/Q4DAFsxCgDiarwmIevoXVwBN+is
	 Nhz+l8/RawquOoqu3s44aRA5jWdhGPLrzMmie+cBPR1PNu0J4ZigRKJb9H49B3NbZ2b9A
	 tMn58g9kg71rwKHraMky+TTVdWg5TpanegLD4y0AkLbnGPeHt5lhWlmOTM5/6raNLzjIL
	 6HDEdEyV8GMqYi+7YV4/6l37Mi7Jd9Hwgy9rZxRLDdc0Crsg7MEa6bymO5sglq4UnmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795461505;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=b3WVxtz/88X1RVJ9PTGEgJQnMhtoTvetL6yUGrJg25g=;
	b=tidreoERO+Txn0dyq/G7DPtdeiJcn5Th7Tn1DThXCBiz1oVWnr1LB9wzXF5GP96Iq4da
	 ZKwDYdJE+70+yNaenLr2yIyYh9y5ntGZ1zVmXlaYuqtIUdzXEBwF3/YbdqgmdYFQlZeYm
	 GWYK+K6+d4MVHbfaICBlZ85XIIC6cxADzkgioYGhD93XacdbWGOws/vWoS9Hnl8rKPqCa
	 T43ZcKXacZUpmP/X1LD6NRCssxhFlcvJPhrm0rpqRlCbiTA8cl08uvi4IrnIsSOLJU3eT
	 k0ziN38xsxv8hQOQB3kGX9zVNnpkVwoDSxa7nejbqa8W5Eqw7/lxQ1yv8lEoI0rYbcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nFe+OPUD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA48A606A32A;
	Mon, 23 Nov 2026 19:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nFe+OPUD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B48CC1F000C6;
	Mon, 23 Nov 2026 19:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795461505;
	bh=b3WVxtz/88X1RVJ9PTGEgJQnMhtoTvetL6yUGrJg25g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nFe+OPUDWPVRj2xrIBs7zECOU9mBV6Vg14mghm5y/KcSCQQkRjRsT5OYVM+dm9JW0
	 jaMj2SVmsiFRTQ013XvoKv4oyySrkpAm//luYjLm0Wr+4ovi/oK9aerbhNiOZKfiQV
	 xxNE9pns5zRn6ZGF7zI2psIz5a6f5jWjL1VFB2btKpCekbhdbATSp7JoyJ96xhLc+p
	 Qq/ZAT5MYDWbhPlTlK8pRdB3fbG7/nkGt/g0Pb66k++2469NeH8iCVmPhDUa7GDtvy
	 ErMG9fBzBM8t8bYtcbbIpbSKUYKaoMcAhCSjjh82uNkJ5L0GmYkVA/N3dMk83cNLgo
	 KnxISNxG8STjA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Allen Pais <allen.lkml@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 09/13] mmc: renesas_sdhi: Disable internal DMAC BH work items on release
Date: Mon, 23 Nov 2026 19:15:53 +0000
Message-ID: <20261123191703.179283-10-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
In-Reply-To: <20261123191703.179283-1-lee@kernel.org>
References: <20261123191703.179283-1-lee@kernel.org>
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

renesas_sdhi_internal_dmac_request_dma() initialises both
host->dma_issue and priv->dma_priv.dma_complete, which are queued onto
system_bh_wq during DMA transfers and error handling.  However,
renesas_sdhi_internal_dmac_release_dma() only clears host->chan_rx and
host->chan_tx without disabling or draining either work item, allowing a
pending execution of renesas_sdhi_internal_dmac_complete_work_fn() or
renesas_sdhi_internal_dmac_issue_work_fn() to run after controller
clocks are disabled and the host structures are freed.

Disable and drain both work items with disable_work_sync() in
renesas_sdhi_internal_dmac_release_dma().

Fixes: 85683fb39d9b ("mmc: sdhi: Convert from tasklet to BH workqueue")
Closes: https://sashiko.dev/#/bug/linux-e1bb7b26-9b96-4c86-b680-6ce4e6a73315
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 6831fc34cd22..a88946bdb567 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -573,6 +573,11 @@ renesas_sdhi_internal_dmac_request_dma(struct tmio_mmc_host *host,
 static void
 renesas_sdhi_internal_dmac_release_dma(struct tmio_mmc_host *host)
 {
+	struct renesas_sdhi *priv = host_to_priv(host);
+
+	disable_work_sync(&host->dma_issue);
+	disable_work_sync(&priv->dma_priv.dma_complete);
+
 	/* Each value is set to zero to assume "disabling" each DMA */
 	host->chan_rx = host->chan_tx = NULL;
 }
-- 
2.56.1.750.gf70dc682cf-goog

