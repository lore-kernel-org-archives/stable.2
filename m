Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD024BB26E
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 14:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051877; cv=none; b=MLwhgKvcoU8v0v/bAwOBvf/vNoV8QaDm9LdSvC7LEqres4s1ag2VIe8bWxwCnpYUC6V4JC5QrCLHSXFzFESZu+s28nDFBmns6l2mti23co+Y+AahQ+iRXL6nnC6sLrzNGamyp0Qbo7eh/BUcCaboassSHGih88CeHuO7kxWfLuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051877; c=relaxed/simple;
	bh=MhddNrmrZwmeTvC1OhCTLgh7ZbHYoDZbylqC1X1rPIs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZCqGaohTUsmhGh5gfINmB2s67udbPB+TKfeFncUny8f20MSHKDU9ZHWnMboyOvjDElAYOFz/89kP4XbiXIiVQD1C80gPKnpqc9xBZ7xZhbQ3gpea1YBnuUazqIxq0oF54CrK4HoFg8pgYBIplMGhIAt6ENx7Sea/5OTk9ogBfAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MoQ+DEU4; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MoQ+DEU4"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cfc52ddc55so102785205ad.3
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 07:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789051874; x=1789656674; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iPR+8RLWsIHJc9acjgG1g7ANa3O2x38Ojpgbt/bpoPQ=;
        b=MoQ+DEU4FAs/1fNcUWcgR3MLmbR+34wnAYv8cAcWL285060C1YuLyKv1byMxoDnuvh
         LYHHNjMtVZ8cXrZrMQFS1ztDVON+9VeCIeMZABivZGQiaY/gCzzNBJG2B1lrjNUoB7KN
         dyZpLPgGD/p9tRIZMjct9l1+rKghMaWLVMLNEArkV1MMm18hry5FGFcUy4ToFqTS7h2D
         CHcXUg8A+Reuq8JMqxhqIMam0pCEZhpawVf1xzmsdgHgTG73ei27+CohTN1nZmwxqvkJ
         UdZTMSPUQHGJ1sNeXJSCrIZnsDb8cEh399Q7jP82RMGuTN2OkJ8hk5NffS+tpGdXZWZv
         BpQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789051874; x=1789656674;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iPR+8RLWsIHJc9acjgG1g7ANa3O2x38Ojpgbt/bpoPQ=;
        b=UjsZ16xCZc363jOd+DrqsTfMaz+STbwpV6oKF2SXm3POs7C7OFwR+TiPC60tX5MHQ/
         oye1S5iah57GcrIbhxqwUzK4NnnhC5ByPvawmVZkjoVzGekyw0vE36mhRdqi8MA5BYh8
         YcnUQ13OLjdeg/8hkNpC7nuLKYhpJGxnfJTsQjEczUiexKYH1zhuQEoVY8ijztbzw0f8
         81x9wFlkMF81knZWjpXDNsho9f2MdPEC1g1lsJlYl5ZuN/KfGC3AUNL6cTuHIrHhFLwo
         dU7+tb2MHydQY5/XMkhuG0axjx5BEIefqrbm1zAKJYKIz4IE8GNDNrmuUmi+PvAdg9a3
         7mUQ==
X-Forwarded-Encrypted: i=1; AKwUvBygehd/UF0mfto5UfJP9Y4s1KGq5HMCwphOfjjHcv4HjCHpYSHPl5TqDz/+TYg2v2xyRAGB9F0=@vger.kernel.org
X-Gm-Message-State: AFuF++mUAMxoLoXMK26rCG2oB/z3AdEtByooqsi/7IBQECu9jky0Na68
	oWVRp19iLZdaB/YDKIHqB1vDFSbj7OCgZpABuBPHFrzWITcWfTLXRZWcEa3MszgiI5hIOwpHaLf
	qf7lg/ddQvzA/Uh0g87qFFA==
X-Received: from plw20.prod.google.com ([2002:a17:903:45d4:b0:2ca:f1f8:ea00])
 (user=ericchancf job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:3804:b0:2cf:9347:f445 with SMTP id d9443c01a7336-2db126d8a54mr668494555ad.10.1789051873909;
 Thu, 10 Sep 2026 07:51:13 -0700 (PDT)
Date: Thu, 10 Sep 2026 14:51:07 +0000
In-Reply-To: <20260910145107.3640991-1-ericchancf@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260910145107.3640991-1-ericchancf@google.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260910145107.3640991-3-ericchancf@google.com>
Subject: [PATCH 2/2] coresight: Switch to DEFINE_RUNTIME_DEV_PM_OPS()
From: Eric Chan <ericchancf@google.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
	Leo Yan <leo.yan@arm.com>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	Sudeep Holla <sudeep.holla@kernel.org>, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Eric Chan <ericchancf@google.com>
Content-Type: text/plain; charset="UTF-8"

According to Documentation/power/runtime_pm.rst and
include/linux/pm_runtime.h, modern drivers are encouraged to use
DEFINE_RUNTIME_DEV_PM_OPS() and pm_ptr() to simplify runtime PM ops
definitions and eliminate unnecessary #ifdef CONFIG_PM guards.

Convert the CoreSight TMC, CATU, and ETM4x drivers to use
DEFINE_RUNTIME_DEV_PM_OPS() and replace direct references to their
dev_pm_ops structures with pm_ptr(). This removes the #ifdef CONFIG_PM
blocks around the runtime suspend and resume callbacks, allowing the
compiler to always validate them regardless of CONFIG_PM.

Signed-off-by: Eric Chan <ericchancf@google.com>
---
 drivers/hwtracing/coresight/coresight-catu.c       | 12 +++++-------
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 11 ++++-------
 drivers/hwtracing/coresight/coresight-tmc-core.c   | 12 ++++--------
 3 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
index d9a12d5e48fa..e3bbfb707f73 100644
--- a/drivers/hwtracing/coresight/coresight-catu.c
+++ b/drivers/hwtracing/coresight/coresight-catu.c
@@ -14,6 +14,7 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 
 #include "coresight-catu.h"
@@ -640,7 +641,6 @@ static void catu_platform_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 }
 
-#ifdef CONFIG_PM
 static int catu_runtime_suspend(struct device *dev)
 {
 	struct catu_drvdata *drvdata = dev_get_drvdata(dev);
@@ -666,11 +666,9 @@ static int catu_runtime_resume(struct device *dev)
 
 	return ret;
 }
-#endif
 
-static const struct dev_pm_ops catu_dev_pm_ops = {
-	SET_RUNTIME_PM_OPS(catu_runtime_suspend, catu_runtime_resume, NULL)
-};
+static DEFINE_RUNTIME_DEV_PM_OPS(catu_dev_pm_ops,
+				 catu_runtime_suspend, catu_runtime_resume, NULL);
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id catu_acpi_ids[] = {
@@ -688,14 +686,14 @@ static struct platform_driver catu_platform_driver = {
 		.name			= "coresight-catu-platform",
 		.acpi_match_table	= ACPI_PTR(catu_acpi_ids),
 		.suppress_bind_attrs	= true,
-		.pm			= &catu_dev_pm_ops,
+		.pm			= pm_ptr(&catu_dev_pm_ops),
 	},
 };
 
 static struct amba_driver catu_driver = {
 	.drv = {
 		.name			= "coresight-catu",
-		.pm			= &catu_dev_pm_ops,
+		.pm			= pm_ptr(&catu_dev_pm_ops),
 		.suppress_bind_attrs	= true,
 	},
 	.probe				= catu_probe,
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index ace5e077a10c..ef664a84120f 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -2460,7 +2460,6 @@ static const struct amba_id etm4_ids[] = {
 
 MODULE_DEVICE_TABLE(amba, etm4_ids);
 
-#ifdef CONFIG_PM
 static int etm4_runtime_suspend(struct device *dev)
 {
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev);
@@ -2486,11 +2485,9 @@ static int etm4_runtime_resume(struct device *dev)
 
 	return ret;
 }
-#endif
 
-static const struct dev_pm_ops etm4_dev_pm_ops = {
-	SET_RUNTIME_PM_OPS(etm4_runtime_suspend, etm4_runtime_resume, NULL)
-};
+static DEFINE_RUNTIME_DEV_PM_OPS(etm4_dev_pm_ops,
+				 etm4_runtime_suspend, etm4_runtime_resume, NULL);
 
 static const struct of_device_id etm4_sysreg_match[] = {
 	{ .compatible	= "arm,coresight-etm4x-sysreg" },
@@ -2514,14 +2511,14 @@ static struct platform_driver etm4_platform_driver = {
 		.of_match_table		= etm4_sysreg_match,
 		.acpi_match_table	= ACPI_PTR(etm4x_acpi_ids),
 		.suppress_bind_attrs	= true,
-		.pm			= &etm4_dev_pm_ops,
+		.pm			= pm_ptr(&etm4_dev_pm_ops),
 	},
 };
 
 static struct amba_driver etm4x_amba_driver = {
 	.drv = {
 		.name   = "coresight-etm4x",
-		.pm	= &etm4_dev_pm_ops,
+		.pm	= pm_ptr(&etm4_dev_pm_ops),
 		.suppress_bind_attrs = true,
 	},
 	.probe		= etm4_probe_amba,
diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index ece2e8c9be26..77588d53e1b0 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -980,8 +980,6 @@ static void tmc_platform_remove(struct platform_device *pdev)
 	__tmc_remove(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 }
-
-#ifdef CONFIG_PM
 static int tmc_runtime_suspend(struct device *dev)
 {
 	struct tmc_drvdata *drvdata = dev_get_drvdata(dev);
@@ -1007,11 +1005,9 @@ static int tmc_runtime_resume(struct device *dev)
 
 	return ret;
 }
-#endif
 
-static const struct dev_pm_ops tmc_dev_pm_ops = {
-	SET_RUNTIME_PM_OPS(tmc_runtime_suspend, tmc_runtime_resume, NULL)
-};
+static DEFINE_RUNTIME_DEV_PM_OPS(tmc_dev_pm_ops,
+				 tmc_runtime_suspend, tmc_runtime_resume, NULL);
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id tmc_acpi_ids[] = {
@@ -1029,14 +1025,14 @@ static struct platform_driver tmc_platform_driver = {
 		.name			= "coresight-tmc-platform",
 		.acpi_match_table	= ACPI_PTR(tmc_acpi_ids),
 		.suppress_bind_attrs	= true,
-		.pm			= &tmc_dev_pm_ops,
+		.pm			= pm_ptr(&tmc_dev_pm_ops),
 	},
 };
 
 static struct amba_driver tmc_driver = {
 	.drv = {
 		.name   = "coresight-tmc",
-		.pm	= &tmc_dev_pm_ops,
+		.pm	= pm_ptr(&tmc_dev_pm_ops),
 		.suppress_bind_attrs = true,
 	},
 	.probe		= tmc_probe,
-- 
2.55.0.1003.g10538fe699-goog

