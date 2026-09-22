Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7811A38B130
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089807; cv=none; b=DtrHLbznN7wusptlfdB1FPhGYUfFDPYl+GLUu84qjvHaR6j2Bq/CD+mWYB/dkRLI3sK1q5HwK/gm5CwbGIrvRvSq8jajpXbfp9An0yfc4WMprIIdUwJp1+PNyVS8MnsnOpKnNKOIiPDLtCC0xsfpD3PFwlsjVKE3eUKY9Pvpr3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089807; c=relaxed/simple;
	bh=KksFKxDbIXuOiK3CPpGz62LPwLjIXJCUX6sNnpXSXAU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aG6nxad4C5MceSfDHk96CL5t0Ph5fFLraR+rhZb4z1YscwJnuTjbzdRvmpjWkmnrtO/A0IXlGRJ6rMdJvWl93Fz4vyB2Zyl1wkcuDRURaRc+aVuvyiO2wWeGz3THWKah+uW1ujn/lE3JUo3JPEeM2jW9wZZxAE5E8PmaZLTwGhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tmrXXGFl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tmrXXGFl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21CD21F00893;
	Tue, 22 Sep 2026 15:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790089805;
	bh=n4vm14b8e7QD+SViHflz0pgoMD6lHtXq+/jYLgVv8cc=;
	h=Subject:To:Cc:From:Date;
	b=tmrXXGFlsGXZvM++kGaL31PWeWlRKNxOA5qZiRyQRCCgRMeQRdem9X2JRrFIcDjTn
	 TD1NYqczL+pAhletUj9ns7ii+RPBDnjuUe6O7oL8H9vA6QTITGNJ9Dm6ya6uCoAaly
	 BIoecdjfya0B5KYdNZewVK2TeSdodIcHZ98McEs4=
Subject: FAILED: patch "[PATCH] mmc: sdhci_am654: Move tuning_loop to local variable" failed to apply to 6.1-stable tree
To: diogo.ivo@bootlin.com,adrian.hunter@intel.com,jm@ti.com,ulfh@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 16:51:37 +0200
Message-ID: <2026092237-unquote-heroics-2d07@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x ff894dced1a7ad7523f9c65dbdb53d02474cca0f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092237-unquote-heroics-2d07@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ff894dced1a7ad7523f9c65dbdb53d02474cca0f Mon Sep 17 00:00:00 2001
From: "Diogo Ivo (Schneider Electric)" <diogo.ivo@bootlin.com>
Date: Fri, 7 Aug 2026 13:06:57 +0200
Subject: [PATCH] mmc: sdhci_am654: Move tuning_loop to local variable

The tuning_loop field in struct sdhci_am654_data is only used within
sdhci_am654_platform_execute_tuning() as a loop counter that is
initialized to 0 in sdhci_am654_init(). Since it shouldn't persist across
function calls, otherwise every failure expends its "budget", move it to a
local variable and remove the struct field along with the now-unnecessary
initialization.

Signed-off-by: Diogo Ivo (Schneider Electric) <diogo.ivo@bootlin.com>
Reviewed-by: Judith Mendez <jm@ti.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Fixes: de31f6ab68a3 ("mmc: sdhci_am654: Reset Command and Data line after tuning")
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulfh@kernel.org>

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 2a27db2f558b..4b74a4115509 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -151,7 +151,6 @@ struct sdhci_am654_data {
 	u32 flags;
 	u32 quirks;
 	bool dll_enable;
-	u32 tuning_loop;
 
 #define SDHCI_AM654_QUIRK_FORCE_CDTEST BIT(0)
 #define SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA BIT(1)
@@ -576,13 +575,14 @@ static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
 	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
 	unsigned char timing = host->mmc->ios.timing;
 	struct device *dev = mmc_dev(host->mmc);
+	unsigned int tuning_loop = 0;
 	int itapdly;
 
 	do {
 		itapdly = sdhci_am654_do_tuning(host, opcode);
 		if (itapdly >= 0)
 			break;
-	} while (++sdhci_am654->tuning_loop < RETRY_TUNING_MAX);
+	} while (++tuning_loop < RETRY_TUNING_MAX);
 
 	if (itapdly < 0) {
 		dev_err(dev, "Failed to find itapdly, fail tuning\n");
@@ -806,9 +806,6 @@ static int sdhci_am654_init(struct sdhci_host *host)
 	regmap_update_bits(sdhci_am654->base, CTL_CFG_3, TUNINGFORSDR50_MASK,
 			   TUNINGFORSDR50_MASK);
 
-	/* Use to re-execute tuning */
-	sdhci_am654->tuning_loop = 0;
-
 	ret = sdhci_setup_host(host);
 	if (ret)
 		return ret;

