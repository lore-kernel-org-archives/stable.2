Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623773C1F46
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 05:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787895417; cv=none; b=WgjzVAfFl1UabUitTGmOmaFeBeGfCAxUgZnScy9H4jyca/JdcAafLEnRYutJa6+V1NdS073N1wArbRXkfIswWyENlXiEuBEE3ZkXKqOD3h+P0vRwRWkYAgxceRYqB8VfGIDepWKZHiaTa2o6BmKxb6hwfmKmjCd/e7YFFIwLSdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787895417; c=relaxed/simple;
	bh=to5uV5k5TOrazCBV9YJapntDtlNVOxHcGL/QcW0Vhv0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aBLkwn4Fmcr5Rh9FoMCUPZzveb+sUXg93ns8MYtJ5p1tFeBc/4iYaKPzrAYc3o9RWy6BplOWQmwHF1PpyGnq98+2vlDssZhlP+nlQm4RCLzEIXw2zI8i9hXkdRYBsd5dntZQFvD7ptkWhNBu9JIZSsLRJ9JAiyma0Nqlf4JELcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dmTyhuSi; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dmTyhuSi"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-495590dde14so4856245e9.0
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 22:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787895412; x=1788500212; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vXjynDGOZctwtTH5h5fAKF7NFOdGmTdhhXt2jWPkW3M=;
        b=dmTyhuSiT+XT02yWRXNSzmaOSi06Hf2+xgu5FTnSYYG6I6b8S5dklZtuTs2kKq/EW9
         kBvXan3TPGueSsP3BgEjdKURcrivAYJTvQZRcAa03OAXuYx9SjX4jXOO4zHRCErtFTNt
         Xt0QiSptC513jNB+eIqrMqETzyonpD+dWXZhFDoXDJz4gmy1Ta99Zsr7jM6VXL64c83+
         ynREdnHbU/qd+mR/MZv5Exi+0naLZGEMwPNzPjb66FD8Bvzmib0bCwjwenxqAST/KtTG
         kUbpbGxlF+Y0xFYF3tCrbT0mYwmOd0AyqAa16460asQKoDrXaL2q0CV5uRyRkHvePUkL
         UMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787895412; x=1788500212;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vXjynDGOZctwtTH5h5fAKF7NFOdGmTdhhXt2jWPkW3M=;
        b=jYJjEV/Fw7lHmMOY70Ffqu0yveKbIouJYcqamidP+r3QuWDmbcL1voZmD21oBrKiDd
         yWPeMs/H+eV2t3fcdj0AOCl+elIYlYY0X5agwZ1wvr4zGs6l85CpnSLoKcWn7NBb+pPo
         SQbYr1CSk0WjdGpAF0p3cFXiVO1oAdN5jZkXUpmGZJT+O2/G7yZiqNOGveo6Fsx/fKE7
         1jaWOSpp+EyQ50j6Bw17+5+NgVBuZ8nLG25Ts3wRAosg5KXJm8sV6SBwvsFY8D2TXqdf
         oiurcrhvq+iZ43kCw7hEBHiG330ECop5gomCank5POPuJrcQCkUWsWIKYF9aVYmkVoq7
         IFhA==
X-Forwarded-Encrypted: i=1; AHgh+RrO+nR2+3S5tYJ+YxDw5Kc7z5ri60BfZjzAO4m2R2/7lq2JN9AQechw1byaU/kk02x+OD72sxw=@vger.kernel.org
X-Gm-Message-State: AFuF++nl1VE+eBgE24GrNknJ0bYYgMZdrAgxwIThVi9TaZSkTPMICIVz
	LtwCHXNprH/z+ZhIe+bOxRWXcusLUqIAEG4LyecDRqzry06IiIk88FH8nDXQT4J54HM=
X-Gm-Gg: AR+sD11ifXEL2VMeK17GttBwHSOPE0lEhG3Qcgf2ymxCy8KPVona7WL5SJxExNaLaYE
	6zPGU/AsW/1W7A4pvdoHOmTDr48wBXFpP48YDuPhurU7MhDNDLG8RHu4vKZF/2mS4RtxXeKOdSe
	p5/EyGqh1NqfaFvYPP+Uu0h2GRkGj5MI8yjqJAEp3sSoN7Nd4m7G2ogo6fFANafgF6tB0lOS8ay
	3O7FuG371FT+py2HKTnrL/nXngLMdam09rLMK3zi0Na8nmFAq6xpXyoPWD90EQtmla+kTKwQaEF
	rH3bkDf7/LDelkiER057onCb4gwM8ccP2SCmgXKiGajkoTf7mFoBuYFqG9BclsY2PvfPiBpWrO1
	1XbJQE7dt73L1/8HFsPeqr74yYslotobiwlCS4sovziLAQdRVAflOctXgyWyphtgQ6A4HT4+yi3
	o11yS2SJER2Mcq3W6222qGwNiuHJa6mf/U2M0vfmuNJn3YXU9KL/BeEzrgQjNRDPknUefVBzfFb
	N/Lyw/Nd9LdmcMGLQCn/+Et5923vOerQlg/pgOvlR7+7EWUQcwfn7JZlghiaqU=
X-Received: by 2002:a05:6000:41d0:b0:482:f344:5325 with SMTP id ffacd0b85a97d-482f79cc0c0mr6024207f8f.3.1787895411715;
        Thu, 27 Aug 2026 22:36:51 -0700 (PDT)
Received: from [127.0.1.1] ([94.4.85.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbac4d0asm1410402f8f.10.2026.08.27.22.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 22:36:51 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
Subject: [PATCH v2 0/2] Exynos PMU fixes for cpu hotplug and cpuidle
 routines
Date: Fri, 28 Aug 2026 06:36:45 +0100
Message-Id: <20260828-exynos-pmu-cpuhp-idle-fixes-v2-0-06bce6107bd6@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG0ekWoC/42NQQqDMBBFryKz7pSYEqtd9R7FhSSjDtgkJDUok
 rs39QRdvv/g/QMiBaYIj+qAQIkjO1tAXirQ82AnQjaFQQrZiEYopG23LqJ/r6j9OvviF8KRN4p
 4k6Mic9dd041QCj7QKUrg1ReeOX5c2M+zVP/W/7qpRoFCG6F0Ww+tNM+F7RDc1YUJ+pzzF+gkC
 5nHAAAA
X-Change-ID: 20260605-exynos-pmu-cpuhp-idle-fixes-32f5ed7c969f
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>
Cc: Sam Protsenko <semen.protsenko@linaro.org>, 
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.14.3

This was reported by Sashiko here:
https://sashiko.dev/#/patchset/20260513-exynos850-cpuhotplug-v4-0-54fec5f65362@linaro.org?part=3
and was mainly introduced by enabling cpu hotplug
support and cpuidle for gs101-based SoCs.

In this second version one patch was dropped to keep things consistent with
downstream implementation and due to lack of information. Other patches
deal with a few missing error paths issues here and there in
setup_cpuhp_and_cpuidle() and around. They were updated per discussions.

Tested on exynos850 e850-96 board with sequential series that implements
hotplug. I don't see any regressions but testing from others will be
appreciated.

Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
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
Alexey Klimov (2):
      soc: samsung: exynos-pmu: fix use-after-free of interrupt generator node
      soc: samsung: exynos-pmu: fix error paths in cpuhotplug/idle states setup

 drivers/soc/samsung/exynos-pmu.c | 70 ++++++++++++++++++++++++++++++++--------
 1 file changed, 57 insertions(+), 13 deletions(-)
---
base-commit: 3d83758432b5e6ed9507500a57efb0f3af41ee7d
change-id: 20260605-exynos-pmu-cpuhp-idle-fixes-32f5ed7c969f

Best regards,
-- 
Alexey Klimov <alexey.klimov@linaro.org>

