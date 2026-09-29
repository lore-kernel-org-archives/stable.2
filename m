Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787D04F7CA7
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 23:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790725843; cv=none; b=BuRnzL5BOkpcnjMUteNJ4pDjHCnDVUk4RgW0HUZz2NgjyEAD4xPSaYJ2t2dYMZK4x9he3O6iPVUirRrR15UvZ/J6VeXMAaowcaLkffw5OZ9fQfbxcNXgJGAbslF6v8xdiWjqEsIjh3XuWRNQu4xMFI6HhVHrOqOFnbeeXDqChsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790725843; c=relaxed/simple;
	bh=FhEMzTBiUQH9JEThccYJ2ITzRZ5tAkTBJzPd9jCSaSI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cqcPOyfQSs622u0n3Fwmm36MSGKjZq8aGCv/BCRES4rpdT113mt6NEVbUTc4wkOHyxkBxeBQ5w6F//8rVa/i9fGpUxrdPhF5+SzDQwM4Nq68z+3oYFXOJ+Dy1QtY0y2H8dZwIt6H3TIjH7+Zwds8NJMop0ezpx9fM78s6pBrnbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZH1qa4WA; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZH1qa4WA"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48aef5d66c1so912968f8f.3
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 16:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790725840; x=1791330640; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hWOGcG3v4AgHUs+7mYFR/bdBwHYxuCY2aIESRfZ3+nQ=;
        b=ZH1qa4WAtyMTbNY48jDsb39AqQZZJtjBVx+oqPbUbKt1fEXhAAyPLEohdqY6d7GhX5
         L/PqWj896ESH4qmRt9ocvW2ElS0uDt/DSL6+VrGks3Ulo5nrfiJWJHGN29bBuy97hWlF
         Q2mTMhTrF9wV8Gv/w0MdQwUrQcj2FQeizAGhaj+zDvFagVQBSHvfJBY2mxE+xUdW1PIe
         dTw4kzOKw+tW83/PHGuCpuqQPeI0nDPWh6WeGXXYCZiNksiszJT0lOLZncGT5aeOFTNm
         /ITfTAwx8oU62ZJpicdgFPGSqbuFrAf9QGyCa884V5+2D4gBcXzB8dY29rjgN8TI8v0Q
         SN1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790725840; x=1791330640;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=hWOGcG3v4AgHUs+7mYFR/bdBwHYxuCY2aIESRfZ3+nQ=;
        b=CGHoRFM7Jyq7C7yyh2gRfcbEhwKVjoHd++Z1Zxb5zMi6f9Tv5nCCUv3nBAnuzht/dv
         FKk+uJdcM3JKqDLJq6u4j/IG4m0aRwSbZLghK/Lu/U6y1u8f5A/hkdbmjymjhLOf79bi
         rh+uyzfGeR58Texym6DOKqokTIL45syj/9aUnfyooyOhG8bcxQ9ZfplbRKZZ2tWu2wOR
         hXh4thLckQs/PJA5Vmj2lqpdYhRBd083mkffHJAcNG5QnDcUU56vTYTSjAccjOJDO+JX
         lFPHRkvUmznPjRx5W/xhE28o1kdPfuICVJUC1N1CJS8j6SILRuI3fk/iuT43UP7t+gW4
         UXXA==
X-Forwarded-Encrypted: i=1; AKwUvBwk1o0srIdZGIbSo2HaEd5c6Fxs/NaH1Hh3uVIZzN8GkXma4M/NSmkiM9b5sWU7sF3rXl4Zl4c=@vger.kernel.org
X-Gm-Message-State: AFq9FYJXokj6ZsfFOyR+8VBhDBfVlD1soARu9tmDjpT4VzqOSSfn8Qkc
	t6Rjg9TFgYbbtTLBOO4iIO8QoH6vdaiofYRhdZlMbfn2+MfCqDky8uFNCn/4qHtQ7Xs=
X-Gm-Gg: AYBFou3rvDJlZ/9n4vBkHLy9ICh5Dz9b+EIwAmW9Sum0xFpiAuCMEt81vVRTpgCMj7f
	/9uGVObyXDSbNO2RKgB/Y2DZ6R5M/P+dfCHVPpbCug+3ELAsvhn83iqBpFz6qDngl4KkCCxMWJh
	jtgVhSdwhn8ReNC5YTY7cNtUaVarmp4g3Qjt2gmCIPJl5PEqR4NQnNsWKEVblPRZI7ZfriJ1ESg
	+vblV9kXlGQl/15nmc7sdFlSJLFM7qqxeOIiLjEqu5aCaKHEcnr8ZzlEN7p5L33vBfuiX7KhTDr
	68B0yUKIeLmK0qu7btWgFZCeO/cLLCmoNoSev15Ga51vein53Qntn8PanqSG6WbBk3n4ctKY4hD
	QvSDdW7Jea0kgpnfXZnfEknC8y3Jc4FsibkU+nF3dkyl31qWASrFOnjpU0b8eWIn9fv8yfulvKy
	bofmEmlWbMWinsYQmSfq5Ln1gao/oFbiIijAr38hgEbe+KtfWiboZ5/6hVuYMBKJty7rIPYwIfR
	3NMs++TCHZBX9JWCzmTUH48SyQvCOgFaymPPWq+JcYdDWu/R7wOxkIXHYaB1g==
X-Received: by 2002:a05:6000:2206:b0:487:9a9:6d24 with SMTP id ffacd0b85a97d-48afe799017mr1378259f8f.19.1790725839746;
        Tue, 29 Sep 2026 16:50:39 -0700 (PDT)
Received: from [127.0.1.1] ([94.4.85.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48afe68056dsm1939443f8f.13.2026.09.29.16.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 16:50:38 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
Date: Wed, 30 Sep 2026 00:50:31 +0100
Subject: [PATCH v3] soc: samsung: exynos-pmu: fix error paths in
 cpuhotplug/idle states setup
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-exynos-pmu-cpuhp-idle-fixes-v3-1-4269d8425978@linaro.org>
X-B4-Tracking: v=1; b=H4sIAMZOvGoC/43NQQ6DIBCF4as0rDsNYETsqvdoulAYlcQCgUo0x
 rsX3TTdNF3+85JvVhIxGIzkelpJwGSicTZHcT4RNTS2RzA6N+GUCypoCTgv1kXwzwmUnwaf9xG
 hMzNGKHhXoq5ULeqOZMEHPIYM3B+5BxNfLizHs8T2639uYkCBKk1LJVkjub6NxjbBXVzoyQ4n/
 sEkl78xvmOiVSgYrVotvrBt2949j/A4FAEAAA==
X-Change-ID: 20260605-exynos-pmu-cpuhp-idle-fixes-32f5ed7c969f
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>
Cc: Sam Protsenko <semen.protsenko@linaro.org>, 
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.14.3

The setup_cpuhp_and_cpuidle() initialisation sequence currently ignores
the return values of cpuhp_setup_state(), cpu_pm_register_notifier(), and
register_reboot_notifier(). If any of these registrations fail during
probe() routine, the driver returns 0, leaving the driver partially
configured.

Furthermore, if anything after setup_cpuhp_and_cpuidle() fails in probe()
routine, for instance devm_mfd_add_devices(), the probe() lacks an error
path and leaves notifiers and cpu hotplug states registered.

Introduce variables for the cpu hotplug state IDs in exynos_pmu_context
struct, that should be initialised to CPUHP_INVALID by default. Check all
return codes in setup_cpuhp_and_cpuidle(), and add an error path to remove
registered states on failure. Finally, add destroy_cpuhp_and_cpuidle()
helper to safely tear down notifiers and cpu hotplug states.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260513-exynos850-cpuhotplug-v4-0-54fec5f65362@linaro.org?part=3
Fixes: 78b72897a5c8 ("soc: samsung: exynos-pmu: Enable CPU Idle for gs101")
Cc: stable@vger.kernel.org
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
This was reported by Sashiko here:
https://sashiko.dev/#/patchset/20260513-exynos850-cpuhotplug-v4-0-54fec5f65362@linaro.org?part=3
and was mainly introduced by enabling cpu hotplug support and cpuidle for
gs101-based SoCs.

In this third version only one patch remains and it was reworked according
Krzysztof suggestions.
Tested on exynos850 e850-96 board with sequential series that implements
hotplug. I don't see any regressions but testing from others will be
appreciated.
---
Changes in v3:
- drop the patch 1/2 that was accepted;
- moved destroy_cpuhp_and_cpuidle() after setup_cpuhp_and_cpuidle()
  as suggested by Krzysztof;
- reworked error path as suggested by Krzysztof, added label
  clean_cpuhp_state_prepare to clean only one hotplug state;
- re-tested;
- Link to v2: https://lore.kernel.org/r/20260828-exynos-pmu-cpuhp-idle-fixes-v2-0-06bce6107bd6@linaro.org

Changes in v2:
- destroy_cpuhp_and_cpuidle() is called only if
  (pmu_context->pmu_data && pmu_context->pmu_data->pmu_cpuhp) == true
  (as suggested by Peter) (second patch in this series);
- in clean_cpuhp_states error path the cpuhp states variables are now
  reset to CPUHP_INVALID;
- re-implemented "soc: samsung: exynos-pmu: fix use-after-free of interrupt
  generator node" -- used __free(device_node) at declaration;
  (as suggested by Peter);
- drop "[PATCH 1/3] soc: samsung: exynos-pmu: use target cpu ID in hotplug
  callbacks". If we get some information about CPUx_INFORM registers usage
  then we may fix it later, but for now it was decided to keep it
  consistent with downstream implementation;
- Link to v1: https://lore.kernel.org/r/20260605-exynos-pmu-cpuhp-idle-fixes-v1-0-0cd05c81a82d@linaro.org
---
 drivers/soc/samsung/exynos-pmu.c | 61 ++++++++++++++++++++++++++++++++++------
 1 file changed, 53 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
index efccdd63e40e..c764f35fbfc2 100644
--- a/drivers/soc/samsung/exynos-pmu.c
+++ b/drivers/soc/samsung/exynos-pmu.c
@@ -38,6 +38,8 @@ struct exynos_pmu_context {
 	unsigned long *in_cpuhp;
 	bool sys_insuspend;
 	bool sys_inreboot;
+	int cpuhp_prepare_state;
+	int cpuhp_online_state;
 };
 
 void __iomem *pmu_base_addr;
@@ -458,16 +460,55 @@ static int setup_cpuhp_and_cpuidle(struct device *dev)
 		gs101_cpuhp_pmu_online(cpu);
 
 	/* register CPU hotplug callbacks */
-	cpuhp_setup_state(CPUHP_BP_PREPARE_DYN,	"soc/exynos-pmu:prepare",
-			  gs101_cpuhp_pmu_online, NULL);
+	pmu_context->cpuhp_prepare_state = CPUHP_INVALID;
+	pmu_context->cpuhp_online_state = CPUHP_INVALID;
 
-	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "soc/exynos-pmu:online",
-			  NULL, gs101_cpuhp_pmu_offline);
+	ret = cpuhp_setup_state(CPUHP_BP_PREPARE_DYN, "soc/exynos-pmu:prepare",
+				gs101_cpuhp_pmu_online, NULL);
+	if (ret < 0)
+		return ret;
+
+	pmu_context->cpuhp_prepare_state = ret;
+
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "soc/exynos-pmu:online",
+				NULL, gs101_cpuhp_pmu_offline);
+	if (ret < 0)
+		goto clean_cpuhp_state_prepare;
+
+	pmu_context->cpuhp_online_state = ret;
 
 	/* register CPU PM notifiers for cpuidle */
-	cpu_pm_register_notifier(&gs101_cpu_pm_notifier);
-	register_reboot_notifier(&exynos_cpupm_reboot_nb);
-	return 0;
+	ret = cpu_pm_register_notifier(&gs101_cpu_pm_notifier);
+	if (ret)
+		goto clean_cpuhp_states;
+
+	ret = register_reboot_notifier(&exynos_cpupm_reboot_nb);
+	if (!ret)
+		/* Success */
+		return ret;
+
+	cpu_pm_unregister_notifier(&gs101_cpu_pm_notifier);
+
+clean_cpuhp_states:
+	cpuhp_remove_state(pmu_context->cpuhp_online_state);
+	pmu_context->cpuhp_online_state = CPUHP_INVALID;
+
+clean_cpuhp_state_prepare:
+	cpuhp_remove_state(pmu_context->cpuhp_prepare_state);
+	pmu_context->cpuhp_prepare_state = CPUHP_INVALID;
+
+	return ret;
+}
+
+static void destroy_cpuhp_and_cpuidle(void)
+{
+	cpu_pm_unregister_notifier(&gs101_cpu_pm_notifier);
+	unregister_reboot_notifier(&exynos_cpupm_reboot_nb);
+
+	if (pmu_context->cpuhp_prepare_state != CPUHP_INVALID)
+		cpuhp_remove_state(pmu_context->cpuhp_prepare_state);
+	if (pmu_context->cpuhp_online_state != CPUHP_INVALID)
+		cpuhp_remove_state(pmu_context->cpuhp_online_state);
 }
 
 static int exynos_pmu_probe(struct platform_device *pdev)
@@ -541,8 +582,12 @@ static int exynos_pmu_probe(struct platform_device *pdev)
 
 	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE, exynos_pmu_devs,
 				   ARRAY_SIZE(exynos_pmu_devs), NULL, 0, NULL);
-	if (ret)
+	if (ret) {
+		if (pmu_context->pmu_data && pmu_context->pmu_data->pmu_cpuhp)
+			destroy_cpuhp_and_cpuidle();
+
 		return ret;
+	}
 
 	if (devm_of_platform_populate(dev))
 		dev_err(dev, "Error populating children, reboot and poweroff might not work properly\n");

---
base-commit: 6375e61c01e93e35ee7acd336a689ac1fae4b509
change-id: 20260605-exynos-pmu-cpuhp-idle-fixes-32f5ed7c969f

Best regards,
-- 
Alexey Klimov <alexey.klimov@linaro.org>

