Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794169419;
	b=r/+OKBY4IzrMav/ZwlgQYDKesesixPbY4UAdB08/pc0Ye49O66wcvwQjYe33HZbOhhAe
	 f3dHyPQF8whHqpSvNxS3V+ub2MQ2iWcygtS7SeU8mf05cqLR6NaCOcDX3GpvQQe2yTzw8
	 Rgc5NBxqQjDaGy46ixqI2Cjvgh94+ZU7M7YYQdhSA335465VWY84kshXyLFdOFK/j/e5P
	 hyJKonolTfIIfCU71wrFsx6MZ5WLqQhci85M21xcmLJOc2IyS+QzagH+e8LQYHZSlt63O
	 vU3YDHdc16RX+h1LK4RS/hkLiacdRFwXWwfthfR5krxUrIwDBgLCQUNkB5sVUTuOALw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794169419;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=u3ZMURJNpbYFcV2Y5xdX0I+rDVR7jG025CGYOanOMx4=;
	b=Px/GNd/KbdcG1z69dG+PZxX5lXrcgZ/+rqVyQmDNa5XN3qWi6tzeRCMmS2LupKqKwLUp
	 bFXcOzE9PZON9/pMMMDpYcHYwep00NdYXvt2xXLf5LjHuFRq7v6NdHmmJ3dal37Txd/6q
	 E9cQ6j5CHgTgt9lnfdya0E0jw0pOv9DtBaGgX2WobNEBCWm4NJabn1QM63qPDqXvcvkO+
	 sMOlETTvgWVW0nEvG7GAlTbKpqhyfJuaqCDhev1VvFTkFQHlhVEg9tqaB9LNUf0JUyqjm
	 a8LhaL++Z/7wk6UP9LjryZRzXXgzvTwLNfLTPgHx93KrcyET231xlsDuDh/T8TElQUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KShyPfc2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6880F6073405;
	Sun,  8 Nov 2026 20:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KShyPfc2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6AA31F008A3;
	Sun,  8 Nov 2026 20:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794169419;
	bh=u3ZMURJNpbYFcV2Y5xdX0I+rDVR7jG025CGYOanOMx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KShyPfc2PF26C2K7Ew89GIB8NQ13mprlFkbTF/4K9iiVYa3g+xEcR3atnioMGaCO5
	 nbQEU7cwQwc1mm5rWvztbuk4O+sFHmrtCeH1ICXmjs15i3zLUMUxAENsW5qxE9kGqV
	 aXBw9AkWchwuIXu6GwwErWmrF2XweXaU637sa1v73jWeUR2D6wI31OLeSq43MFntzW
	 pzE60dXq+qQdb0TGgtMqMZXmlCYfEvhgYUGQIxlLzBMnrT2GgngTFBrWzITo3PDtnZ
	 Z7FgsoNAKka9VwzF5i9ZwdEX9JdmuZl+3KjNZPYEBPqhooRw+Caqb7g3aAKzwMdHtd
	 l4M1k7hqBG6Sg==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Gustave Monce <gustave.monce@outlook.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: Re: (subset) [PATCH 1/2] arm64: dts: qcom: msm8994-octagon: Fix side touch interrupts
Date: Sun,  8 Nov 2026 14:20:22 -0600
Message-ID: <179416929570.628393.9836822327200913178.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104191700.676773-3-krzysztof.kozlowski@oss.qualcomm.com>
References: <20261104191700.676773-3-krzysztof.kozlowski@oss.qualcomm.com>
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


On Wed, 04 Nov 2026 20:17:01 +0100, Krzysztof Kozlowski wrote:
> Interrupts property takes a number, not a phandle.  Passing the TLMM
> phandle made most likely the interrupt as broken, which could affect
> touch operation.

Applied, thanks!

[2/2] arm64: dts: qcom: eliza: Correct number of TLMM pins in gpio-ranges
      commit: 9ad33b312eb123e9a2e4e86f8849fa59db290226

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
