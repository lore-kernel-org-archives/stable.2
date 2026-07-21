Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB258419307
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 09:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784627199; cv=none; b=SsU9+pyu86i4FH+ePk/ZeuAIGEWHBM+psLX+i5hrXBzz8dvY8m5L1bC7RbMJz4DBY0npfghgsecjaNUU2+p6CNLn8eNXKy7gmRRyUGBFi5cuLNFG5SE5PIvoOz7twk+TdgeQMlP53NCJR/LGd7yJC/KqTI/hnYGOu2nsUgdAvw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784627199; c=relaxed/simple;
	bh=PlGEc4c4DSjEEez9OrkoqyBKa2bPynUKN8BpbZRIMcI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HcAGi4KfT9n9BOwbQFe6jJ2gNndKDo4c1V1TdIC/Tz14KppJ0P/wMG97BquE8SBcjhrjfDR+ZfV9DOemlUmY0hGsI9rj8UHo+L+Qo/Dp9UyYHQQjn0FdebW2quvLckxNof7l7VRS+574EcZbZGHyMxtQQBtyW95JO0idfHkZWdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VdMe2Qzg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VdMe2Qzg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F10F91F000E9;
	Tue, 21 Jul 2026 09:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784627197;
	bh=l2tQFnLUf3rzCAjhF1A7Lre1DuB08DRChpReFyGNtZc=;
	h=Subject:To:Cc:From:Date;
	b=VdMe2Qzgm+xa2cTk7k+NYnLYP5FNzguu0IdyVwPG2qmu+HPGL1bggoaOt489s1Dr+
	 Xcu/SA0sG8rIfStgFYTVKFmQssv9TB1Ys2Jqzm7HnjiKkxh4HQJH6x9QO0XWy4IRkL
	 vgG3z3zt+Tuyk/UAM1xzBcn0p1Ikkw9NMUq0m8WU=
Subject: FAILED: patch "[PATCH] mmc: sdhci-of-dwcmshc: check bus clock enable result in the" failed to apply to 6.6-stable tree
To: s.shtylyov@auroraos.dev,adrian.hunter@intel.com,ulfh@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 21 Jul 2026 11:46:28 +0200
Message-ID: <2026072128-occupier-diaphragm-350d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 521f39ca93cc43ce1b3eae8d44201f8f55dd9151
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072128-occupier-diaphragm-350d@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 521f39ca93cc43ce1b3eae8d44201f8f55dd9151 Mon Sep 17 00:00:00 2001
From: Sergey Shtylyov <s.shtylyov@auroraos.dev>
Date: Mon, 1 Jun 2026 17:49:01 +0300
Subject: [PATCH] mmc: sdhci-of-dwcmshc: check bus clock enable result in the
 probe() method

In the driver's probe() method, clk_disable_unprepare() for the bus clock
is called on the error path even if the prior clk_prepare_enable() call has
failed (and the same thing happens in the remove() method as well) -- that
would cause the prepare/enable counter imbalance.  Also, the same problem
can happen in the driver's suspend() method; note that the resume() method
does check the clk_prepare_enable()'s result -- let's be consistent and do
that in probe() method as well.  BTW, I don't know for sure what does the
bus clock control -- if it affects the register accesses, the driver will
likely cause (e.g. on ARM) a kernel oops if it fails to prepare/enable the
bus clock in the probe() method...

Found by Linux Verification Center (linuxtesting.org) with the Svace static
analysis tool.

Fixes: e438cf49b305 ("mmc: sdhci-of-dwcmshc: add SDHCI OF Synopsys DWC MSHC driver")
Fixes: bccce2ec7790 ("mmc: sdhci-of-dwcmshc: add suspend/resume support")
Signed-off-by: Sergey Shtylyov <s.shtylyov@auroraos.dev>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulfh@kernel.org>

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index eef53455b8ee..c688f3eaf468 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -2433,13 +2433,16 @@ static int dwcmshc_probe(struct platform_device *pdev)
 			return err;
 
 		priv->bus_clk = devm_clk_get(dev, "bus");
-		if (!IS_ERR(priv->bus_clk))
-			clk_prepare_enable(priv->bus_clk);
+		if (!IS_ERR(priv->bus_clk)) {
+			err = clk_prepare_enable(priv->bus_clk);
+			if (err)
+				goto err_clk;
+		}
 	}
 
 	err = mmc_of_parse(host->mmc);
 	if (err)
-		goto err_clk;
+		goto err_bus_clk;
 
 	sdhci_get_of_property(pdev);
 
@@ -2453,7 +2456,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
 	if (pltfm_data->init) {
 		err = pltfm_data->init(&pdev->dev, host, priv);
 		if (err)
-			goto err_clk;
+			goto err_bus_clk;
 	}
 
 #ifdef CONFIG_ACPI
@@ -2499,9 +2502,10 @@ static int dwcmshc_probe(struct platform_device *pdev)
 err_rpm:
 	pm_runtime_disable(dev);
 	pm_runtime_put_noidle(dev);
+err_bus_clk:
+	clk_disable_unprepare(priv->bus_clk);
 err_clk:
 	clk_disable_unprepare(pltfm_host->clk);
-	clk_disable_unprepare(priv->bus_clk);
 	clk_bulk_disable_unprepare(priv->num_other_clks, priv->other_clks);
 	return err;
 }

