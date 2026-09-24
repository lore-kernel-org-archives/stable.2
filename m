Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B721EFF93
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 00:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790209274; cv=none; b=CZ0D8NeNhKv1FxdIih4tn9C2GiyjDD4UXEGdPmUKGu1UOjLTiXgbSECrfJlhjgbX08I2tt+9XSVX9OYZVnkGAMokSx1wyFjtB8xgCysN49m8Lf7pBZj0Dmf2gSPt8pD6K/UalSi1WsCA4eDT7w83UjgHqNPERlKppQFA9Nm5F0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790209274; c=relaxed/simple;
	bh=6xZ1W8G8ZzkCWSzyMqumgwIEy37y1yNPIuA01k9VzO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j3tY7NyowdP7MdNx7ncLGqiUqeQVHCugz+yL37XEklpJnx4gopzsxnzb3cbqoEkOGzEsoSHS+tNlDbZvufyUXhmND+QN2CaUBg2+2Qk7yhoaTVof/HHQtsC0hwjlUlLdPRfo0Tk4q8y4/KBDnEVI8Cr8I+FyEKX8hRXjfHBiyNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOR8jV4/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOR8jV4/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8051A1F00893;
	Thu, 24 Sep 2026 00:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790209273;
	bh=5nsQP7bzfrFw1N9j3a/VgevWt9QwaNzjj2AQxegb19Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HOR8jV4/2VHzqcUAjo1adgQ2D+CZgoDAYwM8+BvMAXML0LIuzIZsG93SFqD35CLXn
	 yTqxkBW4as6VY8l/q+8eFzQFgNio9ynrGNsqed3YCOCFPQg5ya3HiaHghXBC9wuo6+
	 yrbtx18F1iv5WW+3D94qasn8Imzg0T71fsK5PH8K1xIxvQmWrQ6jTDJcxwqKoO5eDP
	 14Y+XGll/Ch3DD7/9LcZQHJPZx4IUIICjXfOZ7dzUeAvQhpfjeuCVfi6fmiB7FxH95
	 hnZ1Uv1loqTA3i73YZeb7/InF1Z6GxVj/UcYKV5tseEdE/v/wb/vZrvXXuTwavIBhq
	 U03ZplJHpPgsw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Itai Handler <itai.handler@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5.10.y] spi: spi-zynqmp-gqspi: stop the controller on shutdown
Date: Wed, 23 Sep 2026 20:20:57 -0400
Message-ID: <2026-09-23-daily-reply-0008-re-spi-zynqmp-gqspi-shutdown-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922140318.668429-1-itai.handler@gmail.com>
References: <20260922140318.668429-1-itai.handler@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> +	ret = pm_runtime_get_if_in_use(&pdev->dev);
> +	if (!ret)
> +		return;
> +
> +	zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, 0x0);

On 5.10 with CONFIG_PM=y this check always returns early, so GQSPI_EN is
never cleared and the kexec DMA corruption is not fixed there.

5.10 picked up 58eaa7b2d07d ("spi: spi-zynqmp-gqspi: Fix runtime PM imbalance
in zynqmp_qspi_probe") and then reverted it in 5.10.199 with 1ceaf0d3a883
("Revert "spi: spi-zynqmp-gqspi: Fix runtime PM imbalance in
zynqmp_qspi_probe""). Probe therefore ends with a pm_runtime_put_autosuspend()
that has no matching get, leaving usage_count at -1. device_shutdown()'s
pm_runtime_get_noresume() brings it back to 0, and pm_runtime_get_if_in_use()
then returns 0 whether the controller is active or runtime suspended.

Could you send a 5.10 v2 that clears GQSPI_EN unconditionally, as 5.10's
zynqmp_qspi_remove() and zynqmp_qspi_suspend() already do?

-- 
Thanks,
Sasha
