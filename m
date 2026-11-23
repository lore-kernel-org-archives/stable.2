Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795461463;
	b=X33shJVCd8HwjxKOXzLJwtVdiMh4mhx7ez26ff6hT1zlg0vDRq+/KdyZHVNLi8N8ITuP
	 nqRkviNzG5Ih9cc08FTLkZQpqcty14h6VkzYklzEPuG4SuGA5OC8nnaF+RAyXuIaWhxB9
	 YNSP9c2HdhlfEuN6Wg4gq6f5UYvNkK0i0Wp8vqxV/i21QoIc9DzUKqrAun1D03DkkWref
	 HeSc8JI4jtQ0Da60Sb7D/Xw93fA5K7NRedL/OoTiEl9entHHdMh/J1HBNHB62P+M9GHx4
	 QbNU6wKK5FZfoAkY7NJ55RfHW1iuHXvFSJvGd5GNTCVtfU5PMWSXObjbwUgLKTf50QA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795461463;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=WVvrLYe+Hr8XZzmJ9/PJQzMWlXZOpSw+WTvHLUOEJ9U=;
	b=FSbb8OrMFDyVQB+dsT1n7RpGu26aXRZWWn0kTjJAdMkGyavoCvVWAl+cbJbfo42M4Aeg
	 sUAZNAg1mEtsw4zS24S65rNngKklKsUd1LfAQfQkxTUF/1EIcM7SWy5J/6McNh56zW+Py
	 8XzbnDRZOlpdO4L8erVw6n/x8tJSBtM9P2ApGqtYDW+6Yco/EGrZh1d4DDJLLW+l9E7Dk
	 fBlPsG5ZOBSDRylL2H4qpd8o5H2tWZhXzrdQyZqoz3yjerZh7sqSa2Sjvsm7e/JMWDuP4
	 jUcIhyrt8EHEsrBoVvGm5/JUCGEKquL5VmQjSMCFHF/vCg3hsgOb1TnppU84Aofru5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fz9AQfIT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6966606A31A;
	Mon, 23 Nov 2026 19:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fz9AQfIT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85191F000D3;
	Mon, 23 Nov 2026 19:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795461463;
	bh=WVvrLYe+Hr8XZzmJ9/PJQzMWlXZOpSw+WTvHLUOEJ9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fz9AQfIT/8/QaG6nmABuSlqAUbTZXm6LEXBDVBXA6RkbrASFRoIiHKVgM08+JzXea
	 xyvMBsshkORNP4rTv+YBzbY0FpFETyic+n/YGJFZoaNxaEDh6sk97MMAL0s3iGyBtJ
	 sB2kk6Jo9FxjvyKcM61qi1/XCW1IkRnnMH2DsGBDdOWzKu8PS5vLviMCfzPqNv0n3e
	 L7deHmkgf9pxZtsr7NWd6FlG2JlSSaHaa1bWyySoik79Wx0h8advpDDtU7NnljyE6d
	 M4FmvGiOjLcNrQSwOb30qIpnf8UQ3U7wgcPn0ZMB63aGPtV84Q79T4icZPHBSALyPB
	 8YFzlJJTIOeDQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Ritesh Harjani <riteshh@codeaurora.org>,
	Georgi Djakov <djakov@kernel.org>,
	Pramod Gurav <pramod.gurav@linaro.org>,
	linux-mmc@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 03/13] mmc: sdhci-msm: Resume runtime PM before accessing registers on remove
Date: Mon, 23 Nov 2026 19:15:47 +0000
Message-ID: <20261123191703.179283-4-lee@kernel.org>
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

During driver unbind, __device_release_driver() drops its temporary
runtime PM reference via pm_runtime_put_sync() immediately before
invoking sdhci_msm_remove().  If the 50 ms autosuspend delay has already
elapsed, sdhci_msm_runtime_suspend() gates msm_host->bulk_clks before
sdhci_msm_remove() is entered.

sdhci_msm_remove() currently reads SDHCI_INT_STATUS and calls
sdhci_remove_host() before waking the device via pm_runtime_get_sync(),
performing MMIO accesses while the controller interface and core clocks
are disabled and triggering a synchronous external abort on Qualcomm
platforms.

Wake the device with pm_runtime_get_sync() and disable runtime PM prior
to reading SDHCI_INT_STATUS and calling sdhci_remove_host(), matching
other SDHCI platform drivers.

Fixes: 67e6db113c90 ("mmc: sdhci-msm: Add pm_runtime and system PM support")
Closes: https://sashiko.dev/#/bug/linux-5ebb28b3-9cdd-4423-bfe8-361008b2aa89
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/mmc/host/sdhci-msm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index aecd425bf095..f62e942bf9f0 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -2925,15 +2925,15 @@ static void sdhci_msm_remove(struct platform_device *pdev)
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
-	int dead = (readl_relaxed(host->ioaddr + SDHCI_INT_STATUS) ==
-		    0xffffffff);
-
-	sdhci_remove_host(host, dead);
+	int dead;
 
 	pm_runtime_get_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 
+	dead = (readl_relaxed(host->ioaddr + SDHCI_INT_STATUS) == 0xffffffff);
+	sdhci_remove_host(host, dead);
+
 	clk_bulk_disable_unprepare(ARRAY_SIZE(msm_host->bulk_clks),
 				   msm_host->bulk_clks);
 	if (!IS_ERR(msm_host->bus_clk))
-- 
2.56.1.750.gf70dc682cf-goog

