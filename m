Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794169427;
	b=zxUYvry9gmKRu3ZGEf4DWDWqb+crbx8dVG4pSpIaEN32M/zgpd9E864Da7a4LN3PMXaH
	 GbvRKACpa2v5y4gwkEl1GGZCBYsYWhICyMm9ws3yqFspbfYP5Y6pOsvEvc10hr4PM7CZl
	 8lAUXU9nhV5JyO//HebNom9PtOlNkxufme+ofMFmpGJdCiWAyopzd1zxmPSwOgbFNIPvA
	 jZk+WPmzOWWIj/jjsH4lpr+Jzzo8mkOpXe9URa40KkM0Df252WHA3zS3/sYb8T1i8FEcT
	 tBqWLzvTtuV7npI+AE7CUYqkegkLe1K8dFGxxJPzpjoc3wz/n/QrAQ7A2QIica/t2lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794169427;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=4+ekBbg/Krun9q7nBkvvnEDo6k648SSKR61QJfaqWqw=;
	b=wdrJ1VqAu6TcxCvbhVmYpJZulk3L5YsprF+1E1VpwPaCVq+oo5uzsvuMREK8Cth0KgzX
	 V75U19b/6xaEqLAQOBQSEDAuxXCO42SZuVTGL73O8dLCpfjRJdaXsRAm4aP+Hn1x9X9Ar
	 0mewTKfdHFmu9ilGSFoiPuwng1MV9aaHMO9jCjlOSPexNvIaaWUiWm36majH7NqKIm6nA
	 Zkv2qNkuCriSCrcVV5eBYAs7E4OtPUB6zqikfzCfQ4Uf0cjCBOj7AFgPVtJLcGnIzjjYJ
	 NtS0fR2U2KOihcgchOGFO/TUyFDlDK8F52hWRq8W3FK8RLcnThImdn/anygCyW+r0gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L5V20ZL2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC646073CF8;
	Sun,  8 Nov 2026 20:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L5V20ZL2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53751F008BE;
	Sun,  8 Nov 2026 20:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794169427;
	bh=4+ekBbg/Krun9q7nBkvvnEDo6k648SSKR61QJfaqWqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L5V20ZL2M+Dk6X3w7ZWzh0E+xGbeCkXr7a/3VkjB6jC2jWmJ+HP6xjZiYKvktzLbM
	 HlVyzMB8YgI88LCTOJ92B07/447SxI4IIEB3OItVNOfgYfCWsUEY7P3Y1QgT1xjPyx
	 I597LDXE+NoDjZ+NHalCbDidMaE3e12JMu2f7xvvM4/vf0lBYkZAxkpWUrA1RhvyAJ
	 iDLRd4pefFy/ZNooTzjVJQ+wnHY4txLfKyjEWa7gf5q299WkhMc9BWLNFs1niDrimJ
	 ZdUBdlMW5PR1UtawKaKCoroa5trMSbD9vCzbYcDXdfJQKdwnd7vsWugJBpCIP5GI96
	 UH8AXw7pi1nTQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Srinivas Kandagatla <srini@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>,
	Andy Gross <andy.gross@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: (subset) [PATCH v3 1/3] soc: qcom: apr: Reject packets with header size larger than packet size
Date: Sun,  8 Nov 2026 14:20:28 -0600
Message-ID: <179416929551.628393.10010125445849314508.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103145635.309032-4-krzysztof.kozlowski@oss.qualcomm.com>
References: <20261103145635.309032-4-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 03 Nov 2026 15:56:36 +0100, Krzysztof Kozlowski wrote:
> apr_do_rx_callback() and gpr_do_rx_callback() validate the header size
> and the packet size separately, but never check that the header fits
> within the packet.  Both sizes are u16, so with a malformed packet where
> the header size exceeds the packet size, the subtraction computing
> resp.payload_size gets promoted to int and becomes negative.
> 
> Further check "resp.payload_size > 0" would fail, leading to
> resp.payload left uninitialized (stack value).  Reject such packets as
> having a wrong packet size, although unlikely that firmware would
> produce such packets.
> 
> [...]

Applied, thanks!

[1/3] soc: qcom: apr: Reject packets with header size larger than packet size
      commit: e6f64f9b76d595cdd697dcf345860a8317b09d2f
[2/3] soc: qcom: apr: Fix theoretical use-after-free of GPR port on concurrent RX callback
      commit: a5d51dee5f570362f262301dcdab66ebb6aaf634
[3/3] soc: qcom: apr: Narrow critical section in error path of gpr_alloc_port()
      commit: 85fadab9958b7eb5a70c53887a90c2e6fc26367c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
