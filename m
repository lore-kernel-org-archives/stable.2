Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7912E17C203;
	Sat,  3 Oct 2026 13:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791035222; cv=none; b=VXWtVNQL5e7VLnqV9TesVW59DX6U+GhxTTRq9fCiD+Jn0xXLlTyu3KCK5U9Nk79kXFVBwH1wYmleZXJ3xGuSYNa+hbkNhhXlNcRW3V8xIlqBUR0phw5fPkmjmedu4cxWTi5ROVyRSmAf3WpHV0i9bbyKj+Z6MF1dveYPlKQwqHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791035222; c=relaxed/simple;
	bh=nd/ehcJvpp3XA3RM4s0itTllX+iZG1J44if+X3HPqhI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hSmdD1y5Y59VvDlyBD+8sSnr9zB3j0HFmRH4XSwMvNqSt/pVu3gt4ktaLA74f4UoUV7XQFSsjV3whi23Vp1LQch4PaAeQv5R75O5iKPQPhWyy5tkFDlwkTTIf6ltYGn3sF2ygZDxMQ/Plo4l0axbp5L2oV4QrXuI//8S2BWjEXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKj/UHbM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKj/UHbM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 128061F0089B;
	Sat,  3 Oct 2026 13:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791035221;
	bh=lT5VAqVxR7PF2pTcLLyyEAU4ZLvTK6F8FroUmVYH3Wo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=lKj/UHbMzJwltpJAMI0y8f8w80V9bm1QR5NZOm55IupS366qaMJVDaHcKFWqe9YU1
	 KhovnU3M9d0qMf0JRdyIY13I0JdxM7s96CI0Pp/ZEgwJs++d92ATBh3sifiAwUDAof
	 fRsXTwQ4Qih3fZEqtS4Iw4W9pyAmttSoUlZ+4L/ttp4ESRHt9SOCu9VZ5u4t8++0iz
	 XT6xBuyidX534AF5KGx09dvBiz12RPEvR01S2T9sUFiFmOMEzgj/d1tcxHwzM5BE17
	 Ftehro2PHWaZAwhAiD+MGtbidwcBM3w512hfqguXaDpjyDkiNWkSHngS/YzuCvwPV5
	 4yCveh2HdLolQ==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alim Akhtar <alim.akhtar@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alexey Klimov <alexey.klimov@linaro.org>
Cc: Sam Protsenko <semen.protsenko@linaro.org>, 
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>
In-Reply-To: <20260930-exynos-pmu-cpuhp-idle-fixes-v3-1-4269d8425978@linaro.org>
References: <20260930-exynos-pmu-cpuhp-idle-fixes-v3-1-4269d8425978@linaro.org>
Subject: Re: [PATCH v3] soc: samsung: exynos-pmu: fix error paths in
 cpuhotplug/idle states setup
Message-Id: <179103521882.13392.16561640308024902589.b4-ty@b4>
Date: Sat, 03 Oct 2026 15:46:58 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Wed, 30 Sep 2026 00:50:31 +0100, Alexey Klimov wrote:
> The setup_cpuhp_and_cpuidle() initialisation sequence currently ignores
> the return values of cpuhp_setup_state(), cpu_pm_register_notifier(), and
> register_reboot_notifier(). If any of these registrations fail during
> probe() routine, the driver returns 0, leaving the driver partially
> configured.
> 
> Furthermore, if anything after setup_cpuhp_and_cpuidle() fails in probe()
> routine, for instance devm_mfd_add_devices(), the probe() lacks an error
> path and leaves notifiers and cpu hotplug states registered.
> 
> [...]

Applied, thanks!

[1/1] soc: samsung: exynos-pmu: fix error paths in cpuhotplug/idle states setup
      https://git.kernel.org/krzk/linux/c/f7b2b6acf658be412b0c4746d07d210a9e18f13b

Best regards,
-- 
Krzysztof Kozlowski <krzk@kernel.org>

