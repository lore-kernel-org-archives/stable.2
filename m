Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A53C3EC6BE
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 09:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785144966; cv=none; b=YafslYsjvL/D0V58LnDRbIw9MoGCMGeChGjbeHzfpzy03yMzHUnPoYu8r3b7a6dfVZ4J/JPTkBs5M/FpNZtJkrdCXBdoAaczeoU1FprSjKINmL9khWSPAsvuAbRBOl/EjbIf0r0rSlMp2/FeUOZefu8CqkyOO3agawdL6ss4NyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785144966; c=relaxed/simple;
	bh=EsLaqCTH3yj/zPfNexvBXOoNc+S/fHhmvdiDzcTnYl4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z0PtgQfCNyNVBq1F1BBXMiva1kc9o2PU+3lCqr0KQpQc/lpFnQMa5yq589zGKHVROc6VSv/Lft5Y18t+Kow/F3KBfKPvvuTp24wo/nVIWxRv/PEfdVb2EoCe0NrQGuLqUdeHprtO4WYCNYwVGnHVWQ6QaylG3C/qy8225fhlp1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=DAS9QJUN; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="DAS9QJUN"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-ca00f126b7eso1427519a12.2
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 02:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1785144962; x=1785749762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ELWN7U27SFkZyrD+z5RrldDItBA7BRjMuvttsGL2v4s=;
        b=DAS9QJUNk5CNs20TgRUc3+ga8pl4Xbr3i+B2EcWGO5R1ZH2P9zKyO79F/sdxMBGcEC
         3jVhOhh9BZbweVKyiFCY/WTuWu4vZkuWcGs8TY677z0atiZxCS0Zy745NyQTX/up40uV
         D/SbVW51/D9r0Xm2Oz+kyXmc7btKKjPpuClG1jIgnPzT5vu8wjp0ub2eS1xZ1DtZmqef
         v7MEvmoou9av5M3Qv839U9XEFO0CIOavaxyJErmgJAo69vBDiH8fhSXeUDNOsGsFISe1
         ezLeipuYBax0lrhzVnzE23F3OCpumiCfdy330gDKyCDVh8BotpFwrykHvh6qdDG3VI+K
         rK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785144962; x=1785749762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ELWN7U27SFkZyrD+z5RrldDItBA7BRjMuvttsGL2v4s=;
        b=LV5zHIJ7a5dDfnDolVLMvuV6ePBRKiThZYyYjaw7ylq1u9fkQN9l4cDWAprc4ZS3EE
         F3S61fAmlsUZUB67VTvNsxq1GL21o25CU/7dpgU66HKMd91DRZQEPaRacm09rl1iHp8Y
         dM2Dxawi9g/rgnuI3556qkD6PhZaJmBz3fxHSd9uJ0nF5ouDvCBApEKaGpMbU3LaN6SI
         1Tfh2Gm5NZbT6UKNdGzVEMxDx9rIDqouFQvx86SnxiU4YrYzZzU0nSHjXX/mmHUMjIJv
         FyA10B9H+hBDlmjLlqx9LUIT7mSqfA/bTQXZ7kr97oPdvezaKcrTrpT+G0wjdu7rRtnY
         pWdg==
X-Forwarded-Encrypted: i=1; AHgh+RqKaxRpHf+yYliqGreLOP5R4Z+DGg0AVWdtf3qMQbKNZt+BrWHjJSnHv00DjhYJ+tRK8cJVS/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSPdRACcG/uJni2FX8OUJxyCzkSupvG7WxJSI1uPNqZusYYUNi
	9hmQQfvGeCvSAgvovFAoGUJbCbAtmR1EyZ5dsDNKYhnqMgtLdLJzVhQzKuJXD6j0v2s=
X-Gm-Gg: AR+sD11YxgdsRyNBujDSjtykrEH+kUIvmQzee1JCdk9zE3WIeEY7up0RJ0Q8gvlsYO9
	KUMw3QxOHoNy1AAWCz0l5Xzy6tG0NuCGyCyP9gmIBFkQsM/hjNAY325pwrKjYgiqT6rX21ZOKBN
	KTO6gqTFK2paUYaue1RAK3z9HfXmB673T4UChUihzv4yPoHucOksLG+fRyNT1ulbKv93htxA8YK
	OlE84HLPeSmQrTa+gAed6OGkV+qjWjgyO7XDTUNSFb64XJ9bu74DNTrbRlSGwGxv7Ep26fuaE/6
	j7fzsRErK6gaupfAX4ckWVZkwvZVX2hB1rSOuOsVka8p93g09UDVafHr1o6NUc9Rlf9Zy6EFIxi
	b8hSmst2zbqPk7ljGK5dv1N99BLLcqTgoEwgHYy5iU6JhO8kvDRC1IRDrljsnPS/Nd0H46VpnI4
	Tm6UInd2FV8RKpxawoVBPOOCs4nIeffCVShwR/7Ct+HWt8YKQbEcQ3uyKUSnDirXejAJeszkAsE
	1aXzbRQg8Cvlt+XRheuGpQW5CVLLlwg
X-Received: by 2002:a05:6300:86:b0:3c0:9c19:65a4 with SMTP id adf61e73a8af0-3c67e027636mr7353187637.76.1785144962163;
        Mon, 27 Jul 2026 02:36:02 -0700 (PDT)
Received: from Metius.iitm.ac.in ([103.158.43.43])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-314bc44cb92sm48567410eec.13.2026.07.27.02.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 02:36:01 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: rafael@kernel.org
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	viresh.kumar@linaro.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] cpufreq: powernow-k8: Fix possible memory leak in powernowk8_cpu_init()
Date: Mon, 27 Jul 2026 15:05:51 +0530
Message-ID: <20260727093553.98246-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory allocated for data->powernow_table inside
powernow_k8_cpu_init_acpi() or find_psb_table() is not freed in one of
the error paths in powernowk8_cpu_init(). Fix that by adding a kfree().

Fixes: 1ff6e97f1d99 ("[CPUFREQ] cpumask: avoid playing with cpus_allowed in powernow-k8.c")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Issue found using static analysis.

 drivers/cpufreq/powernow-k8.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
index fe1f499b4fc0..c9bcc6f0ab7b 100644
--- a/drivers/cpufreq/powernow-k8.c
+++ b/drivers/cpufreq/powernow-k8.c
@@ -1085,6 +1085,7 @@ static int powernowk8_cpu_init(struct cpufreq_policy *pol)
 
 err_out_exit_acpi:
 	powernow_k8_cpu_exit_acpi(data);
+	kfree(data->powernow_table);
 
 err_out:
 	kfree(data);
-- 
2.43.0

