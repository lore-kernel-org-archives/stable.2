Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE7A34D394
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 20:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780690751; cv=none; b=jBC8+XoTGFXt8KbvSyzvBkCY1pADJ/ZJ+pb83IHSWPk+4QK1nrA61LBaXGUVbcd7agtjKl6eJM7NXxu4UZ92vt0nll7KGYO5vhGUKioBLZuSG8CC2PLaIyGT9FfBaDTsVoNbHitN9e1xrhEXth5VychNiDZPazfW0SDOmLLtnI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780690751; c=relaxed/simple;
	bh=i/hR1lgYvHPPw5OPf+wLO0gns47TKhXDAvO92AjK7uI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QuNmqdl9maSG4TZdILRYN1CVHFIkVl1rW9o2gJRrRVMN2CqcqCmphw3/dfCOvRaOWDfQGI3sSe0zH6xk1EkeVJkPO6jxUXVPrxanhQoTwZzHKCsFRZrPIP2vTUnT/o6k8lDFrdbBGEnWtW4slTJ1PM3EQmbvdePmIVilN4YYK4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TkXvAbFe; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TkXvAbFe"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490be03d47bso19334165e9.0
        for <stable@vger.kernel.org>; Fri, 05 Jun 2026 13:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780690748; x=1781295548; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l0yxG0zXdk7r1+vfGjZGqqrFGTovMPDmklAlD/sL2QA=;
        b=TkXvAbFeHWMdhfNM4Z+6MVi+bcHQfYTeoFNgsekLaEWSBp4UN3tq3u6mp1CsSz/xNq
         nII5/FfIbO7lOr3kdq0dVVvic6DqrI9gnUphap4AEjZTxDpqqA63K5wClsBP4SQHl20V
         aEmOvfv2c6hpqTud5m7UpUgeduu+y2uMCMYPl/ZXOMzLGSPnEZ4zwH4Ca82V7+cT0Kts
         psvZ5XXmX9OZ9IwfzmAi8YOpi0pserHH3kBEqxbL2FP+XMg1rwr1p9SR7W0wUBSk0f0O
         gU5laXzD7+44+bH6aBC4ZrNtG3ujI1XHuwPofzxzkW0mJpa2JAXHjdmqMweVQTQTSIxe
         pcAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780690748; x=1781295548;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l0yxG0zXdk7r1+vfGjZGqqrFGTovMPDmklAlD/sL2QA=;
        b=L0h8E1psoYLy84qIzpApeRTkPBpgkkHHEGRujChR+02oZk1BWU3EeBdQQM8nUD9vz/
         i7wqMcb0VmvLe1H25Y4Zt4+KnP0QPHfZjO4vR8vquyLqLpUJyH9aYOAYmZhRDc+9jcG9
         N51I/ESf6cmgrST4QRIgFirRTP7N/0UIegAiDAW6iqtMdCNTJ456HfP7B0QIu0hxPj5L
         Wmaayus6gM+38zVoT3HhqF6AtoaesNfJIC27iG0OOl7Zg4daoc2Lu5BNawOde52UAVS/
         ifqOTSX0bsFMjqNgnYIrWif6YLbhMDFc0bTUfv0Bg4y+f8SrCowt8lyV56ipO6YgA+yu
         jMDw==
X-Forwarded-Encrypted: i=1; AFNElJ/fv+eLCFRKMJH81HGbqDFbB7nCv5qiu3Rk1qY2Y3HmwBAxi2bynWsqoflziQJuYnEtLXEf/XY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuwetQxx2BpgBnUa1+FXluulmJVgdXGQfSJ10cegUmgIdfVJPH
	o8z/h0m94FSyurIDos2SxFWIaeryV6uRmJjHSn5PmTpZbLtGalQBDjucBaL5mbTpqeo=
X-Gm-Gg: Acq92OF1vVYWpwfavQtyEPhCO4UNudD9G4pWphmf2bNRQ7w/ZbXntMq+T/NX6Ib17fj
	TDAERG+hqXL2xUyY8uGLlaXhQQ2ceeP1vEZYCVrCQ/d4lu2OTnWcti3h0GLwtsAZuEuXqoH1bh/
	SDBjndlOPl6rPiRwJcLMiVU37k2uHrsxF/t0iuxs/Na3DdIQE3arpnFbt8ZChFsqT44GV3KPPpo
	TrtFJCqPfSjimA5FeRw4pNILyRGRlm0hol2AdCnLDu4GBkWXUweGc2QCu4/EhRtJT67/kzAwQwB
	j40EyJgF0la30Eb8gJsKW+k0pFYm/ETSIJOVjAPctc9D6ZVzPtXpSXZ0XqRl1mYfkknaYBeJbD4
	Krr8VSYZbZLcXyUoQpvyxCi4v+NxvaHINkxPP7L6GvfbHzIxLV9sAdpSWi182+7HBVUMLRHLpR0
	aKrdG48ImBOOZzc/EXUxv8XxZgnXZv0Y0/u2LNCnAOno0m6Rrh2VA8SVNkSc9j6SOcei74Cj3C6
	p1JJrRGG0SqQIFQKzJQLEzuGyQ=
X-Received: by 2002:a05:600c:8b68:b0:490:bad7:3634 with SMTP id 5b1f17b1804b1-490c25e1104mr89266485e9.19.1780690748518;
        Fri, 05 Jun 2026 13:19:08 -0700 (PDT)
Received: from [127.0.1.1] ([94.4.195.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc413541sm190533895e9.14.2026.06.05.13.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 13:19:08 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
Date: Fri, 05 Jun 2026 21:18:50 +0100
Subject: [PATCH 1/3] soc: samsung: exynos-pmu: use target cpu ID in hotplug
 callbacks
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-exynos-pmu-cpuhp-idle-fixes-v1-1-0cd05c81a82d@linaro.org>
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

The CPU hotplug state callbacks __gs101_cpu_pmu_online() and
__gs101_cpu_pmu_offline() currently partially use smp_processor_id() to
determine the target register offset for the CPU inform hints. This may
be fine for cpuidle flow but broken for cpu hotplug where the target
cpu is passed as an argument and could be different from cpu where
that is executing (e.g. CPU 0 offlining CPU 1), meaning that
smp_processor_id() returns the id of local CPU but hotplug flow
deals with another CPU core undergoing the transition.

This causes the pmu driver to write power down and power on configuration
hints to the wrong hardware registers, messing up the power state of active
cores and failing to configure the target core. Fix this by removing the
cpuhint variable entirely and utilizing the target 'cpu' argument passed
to the callbacks by the hotplug core infrastructure.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260513-exynos850-cpuhotplug-v4-0-54fec5f65362@linaro.org?part=3
Fixes: 598995027b91 ("soc: samsung: exynos-pmu: enable CPU hotplug support for gs101")
Cc: stable@vger.kernel.org
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 drivers/soc/samsung/exynos-pmu.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
index d58376c38179..6e635872247a 100644
--- a/drivers/soc/samsung/exynos-pmu.c
+++ b/drivers/soc/samsung/exynos-pmu.c
@@ -235,11 +235,10 @@ EXPORT_SYMBOL_GPL(exynos_get_pmu_regmap_by_phandle);
 static int __gs101_cpu_pmu_online(unsigned int cpu)
 	__must_hold(&pmu_context->cpupm_lock)
 {
-	unsigned int cpuhint = smp_processor_id();
 	u32 reg, mask;
 
 	/* clear cpu inform hint */
-	regmap_write(pmu_context->pmureg, GS101_CPU_INFORM(cpuhint),
+	regmap_write(pmu_context->pmureg, GS101_CPU_INFORM(cpu),
 		     CPU_INFORM_CLEAR);
 
 	mask = BIT(cpu);
@@ -296,12 +295,10 @@ static int gs101_cpuhp_pmu_online(unsigned int cpu)
 static int __gs101_cpu_pmu_offline(unsigned int cpu)
 	__must_hold(&pmu_context->cpupm_lock)
 {
-	unsigned int cpuhint = smp_processor_id();
 	u32 reg, mask;
 
 	/* set cpu inform hint */
-	regmap_write(pmu_context->pmureg, GS101_CPU_INFORM(cpuhint),
-		     CPU_INFORM_C2);
+	regmap_write(pmu_context->pmureg, GS101_CPU_INFORM(cpu), CPU_INFORM_C2);
 
 	mask = BIT(cpu);
 	regmap_update_bits(pmu_context->pmuintrgen, GS101_GRP2_INTR_BID_ENABLE,

-- 
2.51.0

