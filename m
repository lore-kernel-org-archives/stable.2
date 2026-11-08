Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794169423;
	b=sBZmBqeegukGNvCFrPbUGJiuDA3QZ8XB5TnUSBWcCYx8ENgyvNq9afc9VWIMWEpG8+de
	 RcnMOsPN8A+dvukf7FELE9r7n6adHmuq3uUsLTK254/U8sBycQEjlL17Yqa8v59CvI4Ha
	 h/k3ITSkGgW+k0lDLFZ0RP0/dAQT7frl0MEWGuwO/jBw5A7cBbbvO/bqtaZnDQRCD4jMo
	 KHIVxVGcKMlhHrxdydUin0/TPyC6EP1mCvDRyAG57urYTcKbB8u2co9btbyM+HIQKCBaq
	 50bGZcd9nsMvKRvYXolSz2AdqluU39ZnKbLOoZ4Hj3EztOJkbHiussvOc4sKtBVXkGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794169423;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=TYyy7nmPCHM39Lr/N2xStjZOHbUaxX+2SRFBUq1o/BY=;
	b=oCbfYNwbq0DMiVngruHxiv0Sy9ky/TmnlvSd6jLnCifCywmZql5xv6LO84hZJt7HKDJe
	 niXTuUVECyeIBGAfDgZUE2lU/MLgAGIb8ALOc4ZLgAY2SPVPWgoypssVGXgWrmdYedIcY
	 xFXBv3e4Y+66VqbV4S1ud8wfGIdPOG89SHGuXvTEvT1Go54Ej8GDSyBKNbGPAYjre0lqA
	 utWSdKKb32V1vP56/m757+AR11ewPFBjykRss0lgztcfj+9IU20b2YQPD1J2yizD0C3IN
	 e9NqsIYurC7eRWY5luJscjlz8f0yB1ebamz3GV7cexGMocY+aiB39A0+mNPhuTNtzrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BO64tI9S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1186073CC3;
	Sun,  8 Nov 2026 20:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BO64tI9S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C49101F008A1;
	Sun,  8 Nov 2026 20:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794169422;
	bh=TYyy7nmPCHM39Lr/N2xStjZOHbUaxX+2SRFBUq1o/BY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BO64tI9SSg8GSyHDab+n3+2jwAQmYpUcGOHqpK7jgcWWdTnNDOqkIq08ZoNrpJ7GB
	 JQRwd8R8yc82iTYrQJu1xgTYN1LWjPBAahN11x6Tpra/mN2IhLua2detLL3gKe7pLe
	 4FiOdEYLTtifgHID/m4FaV/DNmbT2OKJoPOu91NjLDP4rw7XTA6ZqMtAdYbYaLKZpk
	 dgwthjdevV8piTV8nMPRyNWc/B9BFP3WXYcE8OfzPQts1w/5p+J1mATAk/izNfFQeh
	 N50elk71RMsFCLBGXIS0iM6u4+nJ8GTgCDA5GpaaBW7DBgVEH6IAyPbn+7B0yW0udn
	 CaIPscLfx1gXQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>,
	Haotian Zhang <vulab@iscas.ac.cn>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: cmd-db: Fix probe race with possible ERR_PTR dereference
Date: Sun,  8 Nov 2026 14:20:25 -0600
Message-ID: <179416929567.628393.17956187622252412553.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104151550.215604-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20261104151550.215604-2-krzysztof.kozlowski@oss.qualcomm.com>
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


On Wed, 04 Nov 2026 16:15:51 +0100, Krzysztof Kozlowski wrote:
> cmd_db_dev_probe() stores the result of devm_memremap() directly in the
> global "cmd_db_header" variable and only afterwards validates it, which
> opens a very short window where a concurrent thread could access and
> dereference stored ERR_PTR.
> 
> Theoretical (not reproduced) race condition could look like:
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: cmd-db: Fix probe race with possible ERR_PTR dereference
      commit: 12e45556d58ffddfa34e3bdbf65646b5fab06113

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
