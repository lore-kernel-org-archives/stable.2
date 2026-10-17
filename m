Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1743246E8
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 13:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792242501; cv=none; b=Z+aXgBUWYPv+DmbG6dTp9ZjE5iOWm8xBJEJ76EM817TDLtX2XzHr1ZD65dnW89AmvgEeSwxuYfIw/RlhSQfkse4kpFQiHrhpcfzBKcjQ5f8/bVaQQAIlNcS256K5kutEpodvDYzD+n+UephumT3qX46DQW0+5wuWjQxx56VjmeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792242501; c=relaxed/simple;
	bh=Z/5JBeqwPxSZ0TpSsf5O+k1fvGG7B04vtfTOruv2JxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NyE52d9aOGw02y8IN/efvm6xiKHyOIw8p1KGQykyaD4wf+IhmMPq60pJ/93JcD5XCk25fLL89C0R/kXJ0wUetz+a6v8sChiolYmpAjp+ZthpPFijDWu5yT8wuAoTvywfvSt4T6CF/v0oleheYmDr8J3Vjr5g/38uPJIFRjOCqZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXl2HU6b; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXl2HU6b"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-15943c9be84so48366c88.3
        for <stable@vger.kernel.org>; Sat, 17 Oct 2026 06:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792242498; x=1792847298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z/5JBeqwPxSZ0TpSsf5O+k1fvGG7B04vtfTOruv2JxA=;
        b=VXl2HU6bjknN1IMUfwiSPFCo4VVowwrSEmRotFX6qrdkgbsozOl3Sgewo2O/cYYsXg
         Pkc55EjKirp/4gxCfW7/bybcVFjy/TgoKYkAKf1yvgMlb2Ir8ikM85CcQInSJwJ52Ckw
         gHWUDuLm8EdyOQTVT6oM2XaqeKWqBK3Eusu+kBT0D9jWULFuVqhAvjf4AMFJCVjm3cJz
         9O6oO9PfUW8EK9WwFnQZHdvfq68nOFTWlL0Xx3ZRGePCm2uKpj/QEiu7qAn5mZvLV89A
         VqZ7tpokdg3y4NHKeIXL5h7ZQ+YTV6kBu4k6EAtGzUYxAFjXZxmERJea60rAaaKFh1LN
         WGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792242498; x=1792847298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z/5JBeqwPxSZ0TpSsf5O+k1fvGG7B04vtfTOruv2JxA=;
        b=yMgCw5j/rEgVnL3mS+g5O9XQ3/XXxxBCFcNexcjq9Wy/h85vml5j5mMV3QkPc7wPM2
         BzaxIB2g+UW7hdEuYt/BmG9vW0PGi4HwZcXCz2DyCTlBELKQXdeTQUq0OKUQ8udrhmMw
         nCDN4LcbJvvLr7Bbj1wb2W6lzOq0n0rO1xaykwmLLDvfILd/s8Zbj3uGimYnDLBHNOkH
         +LOv5YrTjDDsZmpPwq7L/yabOu4NWzJ4j6I8Nmx7LXv7Dnpfpp6CSs1QTvE9HX26YpXf
         rflUvTHI21EXF+2Xr33UinCL7LRpD35IaFhzyINv7jnNVvRGWnd0/h7QCqnehVOzwZfr
         Lfww==
X-Forwarded-Encrypted: i=1; AKwUvBx8p+NvKDNpYu/d2Qn8vNBsJTR9bRSPNMZMullChG6+WK8ZeUqe5olkfx9XqLq1V/T88xYtLio=@vger.kernel.org
X-Gm-Message-State: AFq9FYJv+RaoDNRgZs/2uH2hGUXfXKMMVl7av4eZUMRsC9OkYOVKdSWu
	JU/w5d5RPQEwTbzbi/I0GOHXLEm7vf/9ngD8k7uyi9RKJROhDfq5Bp+BhIpSjlaCkpQ=
X-Gm-Gg: AYBFou1cyjP7S31pBSIFLjPyjOGYYsANZp7V9VMloOtdN5XCiqNiCmaSupEvcLaD4dl
	Y2nin8KLAh12PO0ZDvb4vEEDdDGMeUh7nQwmzj+Qk75yJ7Lks0eX9d09ny+Xm55z8XiNfPFzMlV
	UIHCiZcMud8JAqS/vSDhUnyzHQu2TXKMcaeOsupvbcjsjW3RQK4MipaNayJcJB//XvIPjXzpk3i
	HZs4KRKxsA6c5ldoghPb1httEAX6aOvzj0hI/qLaOmHcsxDAQAKq8leQHR7CrcQIPrvYBtQCQCc
	sS81FkrJrEnnPgMCk60JDq/mZDGiPRHBKiTnqt1yHu/MdnrI5g/WLiKK1RX53jZJg9jabkKYjym
	2q4ICZXvKDqmGcadTnII+rCcXR2pROEV6JKGaoH0hMqthBEIFwKqRk5TIc6dekpKDbjlRgu8EMU
	Gvbmy3T1JPXcQuJT2AzwaXR2fq5H6nGcRZz/E+pP40wQzDQghts961JFFtmmPo91cr8D85ZBSyF
	5QA3NESjq3AbfWyu6ScORFzbJtL7LgxqsTrPlWOp809ZdM2X42s8OajENaFdy7zFVODy68qBkwE
	TQaOw4M1+WA7BsvR/A==
X-Received: by 2002:a05:7023:a5c:10b0:183:d275:cf76 with SMTP id a92af1059eb24-18511adbd46mr5910454c88.2.1792242497725;
        Sat, 17 Oct 2026 06:08:17 -0700 (PDT)
Received: from cachyos-aura ([45.112.151.53])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831b75be5esm18903260c88.16.2026.10.17.06.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 06:08:17 -0700 (PDT)
From: Navon John Lukose <navonjohnlukose@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Mario Limonciello <Mario.Limonciello@amd.com>,
	=?UTF-8?q?Francisco=20Beltr=C3=A1n=20Millal=C3=A9n?= <fbeltranmillalen@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Skip the suspend_noirq config save if runtime-suspended
Date: Sat, 17 Oct 2026 18:38:06 +0530
Message-ID: <20261017130806.305673-1-navonjohnlukose@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016214123.GA1884818@bhelgaas>
References: <20261016214123.GA1884818@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Oct 16, 2026 at 04:41:23PM -0500, Bjorn Helgaas wrote:
> pci_pm_freeze() doesn't call pci_save_state() itself, so I guess it's
> the combination of pci_pm_freeze() and pci_pm_freeze_noirq(), where if
> not runtime-suspended, pci_pm_freeze() clears dev->state_saved so
> pci_pm_freeze_noirq() will call pci_save_state()?

Yes, that's what I meant.

Thanks,
Navon
