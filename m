Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464B043E488;
	Mon,  7 Sep 2026 10:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788775809; cv=none; b=hHSDMtO08AkHzyP1RDHymAnN9244PDiqHnTPlZ2V1z9r40D4pHYnZs13alUicxnL8r24KA1RcorDeNiKNc46eWG7IMjXBLA/ZBUu4IyMRki3h7DX4pWWWMSymLfAeJtGboIcnxnJL4BiHzEFDezYYbuYPhvDeurM40UsXVbDvU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788775809; c=relaxed/simple;
	bh=zEkgG3YDWOHUAp0/rjeJLBU0OexSfgFoyqHiv0NgW54=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mEXgiXEI6S92jxZAg9qm9Vkk9UwMrGe44TQYefVTiqWAlvTC97xsr0nyo38Pxg0EzZMpuMv2DBpx2wMeVr+dRy5OL7WtRux5BTPm8pZzoLozUNt4Qry5qkMTmT/mzrCWJTSJ8Vgj87wL3DvLd5yXT0ABnf9+rMgsPP1j3/IgayI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBvzSdKn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBvzSdKn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFEC31F00A3A;
	Mon,  7 Sep 2026 10:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788775807;
	bh=p0wXLyUa1TwSBmuzh8NevtI2afeWnZRT+jWRYMt7at8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=hBvzSdKn8WjnewtGNbglwtT7c1Bjxiycup7wyUCDyFt/phnuRMOBtb5kwIEo6sQqf
	 urtyqrCgz6i9b1B2H3G6iGe7/laomZTzacAn+QOZIiH52M4e1S9c3Qe5M/xqg8we0j
	 uZcBMpzQHrwwRdEOw/zvXFZlPkld6u2uRRXyyESIoQSBjvphpX5DMohmFzE22BPnbY
	 3BIHFeDCSxvJXqYXiH2jqEf/ZkAkzUL1W1u00ekq0tVFqyjHtuc822yYJYjkZZW9h8
	 eSZ76BJH99kAVwiIC/Fsk+oQrTYnRv19CdFepB4VZVewTUzbUeMLndZGjkflJeK5K0
	 rrqciS1JiIxiA==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alim Akhtar <alim.akhtar@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alexey Klimov <alexey.klimov@linaro.org>
Cc: Sam Protsenko <semen.protsenko@linaro.org>, 
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>
In-Reply-To: <20260828-exynos-pmu-cpuhp-idle-fixes-v2-0-06bce6107bd6@linaro.org>
References: <20260828-exynos-pmu-cpuhp-idle-fixes-v2-0-06bce6107bd6@linaro.org>
Subject: Re: (subset) [PATCH v2 0/2] Exynos PMU fixes for cpu hotplug and
 cpuidle routines
Message-Id: <178877580432.239288.6322757955792613582.b4-ty@b4>
Date: Mon, 07 Sep 2026 12:10:04 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Fri, 28 Aug 2026 06:36:45 +0100, Alexey Klimov wrote:
> This was reported by Sashiko here:
> https://sashiko.dev/#/patchset/20260513-exynos850-cpuhotplug-v4-0-54fec5f65362@linaro.org?part=3
> and was mainly introduced by enabling cpu hotplug
> support and cpuidle for gs101-based SoCs.
> 
> In this second version one patch was dropped to keep things consistent with
> downstream implementation and due to lack of information. Other patches
> deal with a few missing error paths issues here and there in
> setup_cpuhp_and_cpuidle() and around. They were updated per discussions.
> 
> [...]

Applied, thanks!

[1/2] soc: samsung: exynos-pmu: fix use-after-free of interrupt generator node
      https://git.kernel.org/krzk/linux/c/48f344b3e83211025763ca9bc1c5f3dc544b9613

Best regards,
-- 
Krzysztof Kozlowski <krzk@kernel.org>

