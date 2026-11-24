Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795533099;
	b=CXJrBUQhfNNz2RjS8lw0lrdtuAjOaQboAF/v7vLUZFJF7rSAE3ULEqKtx0N17/3pJwI+
	 38JlnwX9mmbxwmRK3Qjumi5Kr3ry0X50vtqC92Xp7+uOAbzX543URBmqrbrcf8a5i1hP7
	 AVAC7eLjKGQnQz1lukK3VwRqpoy+yXKhubuyetZfExvpAOrfbwPMTKKVubaW+8ibJs38y
	 jo76tPHSsA14ILqH0JGUxyS8pX8y/ePVHQd+qVjFh5wuP/34xQliq62WdzprgEM1PPF7e
	 71IBr78LLiy8sJ2bOvUCtxDd1OlsprCSzvsmX+jSxt7d+mAlBsfbUy/E1sU0+lipm+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795533099;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=nz7bMj8MwknJebIKhkCH9EdK+BY8e67kPk3N9NyL7w8=;
	b=OpJXqrjDc9p7GMSwxdyetYI/4jJx90WWsJGzGlFK+5hpuai06P+k89R8H74VMTpGmXlz
	 weplyZM9IZn/3gAuK2tWGdudFFVq4EUkso90Y8ZzZI4UjpRWfpC3gQnU9r1coHt19VjQI
	 /ajgwyhKMLv6wYtxe++Eq+NeYvYqEAYlJI7Q/9AYXlw3AfFcuoVFY4+NUaC2+ZtCk74I0
	 Y9tis+xoTgBaNhZCwBB1osXCgAiW4x1RQNCVyz+V7Svn7370WP89VlacDrsuDLR+tWxua
	 GKUZ6H9JyBm8aChtxQYDqamUdCjFdDrM6Rx0ThzdG7EHDX+E9IU62GH19k1tbikjSEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=dIYIu7ib;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE16606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=dIYIu7ib
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C491F000C4;
	Tue, 24 Nov 2026 15:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795533098;
	bh=nz7bMj8MwknJebIKhkCH9EdK+BY8e67kPk3N9NyL7w8=;
	h=Subject:To:Cc:From:Date;
	b=dIYIu7ib3R7tzhrTqxJUwaNjNq4dTVVdEv6UFDuLtyuGII819+NEKhYO7piRmVE7q
	 Ju3jopa3Ax8yXQi3/aDZejQOQC7GG+vNPXXYfdKqYk4jfre2wCKNo5Cm6bBO74y3A7
	 PU7H2CgRwBnmeNVpUWXHnJ1MEh3CFQ9RV5AX6RGM=
Subject: FAILED: patch "[PATCH] mmc: sdhci-esdhc-imx: map unsupported driver type to Type B" failed to apply to 6.1-stable tree
To: ian.ray@gehealthcare.com,adrian.hunter@intel.com,haibo.chen@nxp.com,ulfh@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Nov 2026 16:11:45 +0100
Message-ID: <2026112445-preoccupy-capped-e0f2@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x d35d93c2902592a84347a15deac4d67a323694c9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112445-preoccupy-capped-e0f2@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d35d93c2902592a84347a15deac4d67a323694c9 Mon Sep 17 00:00:00 2001
From: Ian Ray <ian.ray@gehealthcare.com>
Date: Wed, 7 Oct 2026 10:03:12 +0300
Subject: [PATCH] mmc: sdhci-esdhc-imx: map unsupported driver type to Type B

Since commit 5a52c5701a67 ("mmc: core: Fix host controller programming
for fixed driver type"), the eMMC driver strength is passed directly to
mmc_set_driver_type(), which propagates the value through ios.drv_type
all the way to sdhci_set_ios().  For value 4, SDHCI correctly warns:

  mmc2: invalid driver type, default to driver type B

The host driver type has no effect on this controller: esdhc_writew_le()
never programs the driver-type field of SDHCI_HOST_CONTROL2.  Hook
set_ios() and force drv_type to the always-valid Type B, so that SDHCI
never sees an unsupported value.

Tested on i.MX8MP (usdhc3, eMMC in HS400) with
`fixed-emmc-driver-type = <4>`: the warning is gone and the HS_TIMING
register contains 0x43 as expected.

Fixes: 5a52c5701a67 ("mmc: core: Fix host controller programming for fixed driver type")
Link: https://lore.kernel.org/all/20260926122908.866-1-ian.ray@gehealthcare.com/
Cc: stable@vger.kernel.org
Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Ulf Hansson <ulfh@kernel.org>

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 6ab59d3e346f..931e383748a9 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1142,6 +1142,20 @@ static void esdhc_reset_tuning(struct sdhci_host *host)
 	}
 }
 
+static void sdhci_esdhc_imx_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	/*
+	 * This controller has no driver-type control: esdhc_writew_le()
+	 * discards the driver-type field when writing SDHCI_HOST_CONTROL2.
+	 * The programmed value is therefore irrelevant, but SDHCI rejects
+	 * non-SD values such as 4 (eMMC 40 ohm, from fixed-emmc-driver-type).
+	 * Force an always-valid Type B.
+	 */
+	ios->drv_type = MMC_SET_DRIVER_TYPE_B;
+
+	sdhci_set_ios(mmc, ios);
+}
+
 static void usdhc_init_card(struct mmc_host *mmc, struct mmc_card *card)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
@@ -1952,6 +1966,9 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		host->max_timeout_count = 0xF;
 	}
 
+	/* No SDHCI driver type control */
+	host->mmc_host_ops.set_ios = sdhci_esdhc_imx_set_ios;
+
 	if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING)
 		sdhci_esdhc_ops.platform_execute_tuning =
 					esdhc_executing_tuning;

