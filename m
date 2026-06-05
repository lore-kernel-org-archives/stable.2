Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F10A44B66B
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 20:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780690754; cv=none; b=cR8iKUX+SlN3k+He4j8ELDqfX0SXAbLDCio1fWtMm4EH8GYV7RyDK5us2bpkWCu/D6KiHpr4471eHI886SflEQWYKjfrf2ZT8P8KK20vSbB5YIj1OLbKleVFnJ9P29VfKFCQaNe6pd+bctCX0aUQ+umt3nemfeyfRCqHokh2+RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780690754; c=relaxed/simple;
	bh=HRCZhVoWK0niODWt+XbH4EjpgqnXLW23jOkUBvgIqgQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tWSR36/5CShQMW/eObCa1UkPAJusqamJK3MaQBocbqiQ9qA4l9gYFRvHVkK31CTC57xv02S/Jh8fObe8Cl1ZbInKDozv4DRMOddnNf1YWW+hoZLb7CGoXRNyUXv2aZwGdNSaslhp7tPKeahuKurx1EwcXeo5FkLT//gM+IazN2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sU5fyK5g; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sU5fyK5g"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490b4a8e28bso19162135e9.1
        for <stable@vger.kernel.org>; Fri, 05 Jun 2026 13:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780690752; x=1781295552; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=POfwTOxPePIR+bzQ/YWTWSHHwFIOZT4YImIC9EJ68WE=;
        b=sU5fyK5gYcSzWubJr35fK1H0jTC4PhI3utTSRW1psYPWa4dMe5GduD5nwK1Vw6zvQZ
         uprW1ahtwIHLn0Dzlbrd14IA3QJzIEnjURC/nvxHizO+rCy8J4hqhk5JEMv/+JH4c9ri
         x9kNPVydvRsiT5nmO8YHbU4RYpwQ7h4HtVfBe+1esqI7J9cQ5cywUrxR/onbnisyJIvx
         hyQGSbLWDkLxKCXkFI0ogXt8gmOWnkuru87iV68P8/y9J8E/e6ojX4rcHSgpPHHW0yJT
         VCRDqtPboZcTLqe4BkIVCXCJNPxgTdUtoeLx1TwXLWH6C53YJZwNtVOOWO1oq3jsPxgv
         WV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780690752; x=1781295552;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=POfwTOxPePIR+bzQ/YWTWSHHwFIOZT4YImIC9EJ68WE=;
        b=BMCy7WImWBozktV47381tM4Dsv9nXKG0XcHVD/La3kJiRinMiW7ake5dy+Nf7BCKe8
         X1qzK4f4r3lmL/vR7Sxvs6stUJOE8gLFoZWQ66O2w4TNTt9rSgWAF66nrhVkOsV25sT8
         Xp4kgtEDEOgPKgcTqNRg7ZQCfvuBnV1rAcIwDhj25+cGuDgN29lRehmucSkO9iTrBiEl
         k/98czoI6almMnVSt+wF1RU7ANZh6ZtHAduORWX/W8XKeNPkONIQA/6dQqZ3wL91bR+l
         710di/Pwt9qiF5QDOgAFuvt+esBjx0OwSkqT612PBDBsWqD5GEHT0end+hm5C9CnkJvt
         WPVg==
X-Forwarded-Encrypted: i=1; AFNElJ+SBQs085fDQcG4WFnYqg5nikCdB6WFhvuVxlFRB0hlM5QEeJm19Bqx4JsLDw2WkP0MduImq0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLuhODI++H1HEyPwFVej9JhW/63Cki2+p+hHyVcNylV+GtTW4G
	gM8DmyoNtkA1kE7LahCDzfUyp9BphnYoWllYy9jhF45m4uwXYj+de5TdSNDIUumpIO4=
X-Gm-Gg: Acq92OGlHNerfZfpVDa/R0aFZ1glaVJyllMuv8w4sWO7QizPIAgRxSQKKYRuPvV8lj7
	nIwmC7CG6/AG4bZLzQUy9gpHMN5bkKwQYQsh/dzZ37x/jxCNxjNWjBgCnz1lkuHPYNon41r1xBO
	Hvkokz3ZwAqidetSwzFph7h71grrcobXreEtCEd9p0/XU4nenJj6R4EUPWwxdpEoVCYRl3kyUGa
	6Am81enZFsjDkpFBH13NWD5DJAd0ifk2Da0ghOYIOAdT9lxEqJnUJk3Swn7UUsAFO7vh+VxxIMm
	v5b/zFsJxuQEI+9JOS60GDgUSGQAzTnWQe87ZmBnFYKli3d23lwYD5mt3ow3oiJ8UH4qQ8wok/n
	dtXsY0xsaYgKt/yyP1FLPAFd2eQsKPzMNY6ltVun3n6DIwQW9S1mkdgAn2uJslgp5zaQoo7VyX2
	KOInc4pU49blVDxa/9MLbUbZ+Q7Br9JI3EF3bK5lIaEFoNWSmpYe8OujHuljE4qSxOpWDS/GH1i
	IqnG9QX2wejOu9q5NoX5kr+Pm0=
X-Received: by 2002:a05:600c:8705:b0:488:ac01:72de with SMTP id 5b1f17b1804b1-490c25898efmr107486035e9.5.1780690751755;
        Fri, 05 Jun 2026 13:19:11 -0700 (PDT)
Received: from [127.0.1.1] ([94.4.195.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc413541sm190533895e9.14.2026.06.05.13.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 13:19:10 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
Date: Fri, 05 Jun 2026 21:18:52 +0100
Subject: [PATCH 3/3] soc: samsung: exynos-pmu: fix error paths in
 cpuhotplug/idle states setup
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-exynos-pmu-cpuhp-idle-fixes-v1-3-0cd05c81a82d@linaro.org>
References: <20260605-exynos-pmu-cpuhp-idle-fixes-v1-0-0cd05c81a82d@linaro.org>
In-Reply-To: <20260605-exynos-pmu-cpuhp-idle-fixes-v1-0-0cd05c81a82d@linaro.org>
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
 drivers/soc/samsung/exynos-pmu.c | 57 ++++++++++++++++++++++++++++++++++------
 1 file changed, 49 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
index 9636287f6794..846313a28e9a 100644
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
@@ -404,6 +406,17 @@ static struct notifier_block exynos_cpupm_reboot_nb = {
 	.notifier_call = exynos_cpupm_reboot_notifier,
 };
 
+static void destroy_cpuhp_and_cpuidle(void)
+{
+	cpu_pm_unregister_notifier(&gs101_cpu_pm_notifier);
+	unregister_reboot_notifier(&exynos_cpupm_reboot_nb);
+
+	if (pmu_context->cpuhp_prepare_state != CPUHP_INVALID)
+		cpuhp_remove_state(pmu_context->cpuhp_prepare_state);
+	if (pmu_context->cpuhp_online_state != CPUHP_INVALID)
+		cpuhp_remove_state(pmu_context->cpuhp_online_state);
+}
+
 static int setup_cpuhp_and_cpuidle(struct device *dev)
 {
 	struct device_node *intr_gen_node;
@@ -465,16 +478,42 @@ static int setup_cpuhp_and_cpuidle(struct device *dev)
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
+		goto clean_cpuhp_states;
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
+	if (pmu_context->cpuhp_prepare_state != CPUHP_INVALID)
+		cpuhp_remove_state(pmu_context->cpuhp_prepare_state);
+	if (pmu_context->cpuhp_online_state != CPUHP_INVALID)
+		cpuhp_remove_state(pmu_context->cpuhp_online_state);
+
+	return ret;
 }
 
 static int exynos_pmu_probe(struct platform_device *pdev)
@@ -548,8 +587,10 @@ static int exynos_pmu_probe(struct platform_device *pdev)
 
 	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE, exynos_pmu_devs,
 				   ARRAY_SIZE(exynos_pmu_devs), NULL, 0, NULL);
-	if (ret)
+	if (ret) {
+		destroy_cpuhp_and_cpuidle();
 		return ret;
+	}
 
 	if (devm_of_platform_populate(dev))
 		dev_err(dev, "Error populating children, reboot and poweroff might not work properly\n");

-- 
2.51.0

