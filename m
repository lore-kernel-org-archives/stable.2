Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239615;
	b=N+k6jlyG1lARKHW1kxrSLIcJgkYQ/MJ8NotOYpFbccuXByGTTVUWHEx8sEza+/qeL2d5
	 QrBFW9Mt/sXTGk+oCkosaaHZIniKkAdg6OE4V+HzAhdQ4SkAb3aRJg4czf2SCBFIX+UWA
	 zULmszcuQ6t18sQRgj3kfcNguivsCOrXHdPw+Li4Z12dZHsexY59dO8RZPBfA16rL9lHU
	 p1xd9fYxUyn1+/nRvtRel1iTdME18kKCuUPVSWKoQTIYmO/dfdnVQFkfQHC0b/a/Hkc33
	 JXPWx/gDFNA5WMUMYUPYETILo8ETMyO12Hq3BHCUK5qO+Gaa/FWm2hYfVLTeHIZvyDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239615;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=dYluARUs3puz/gbMHcttxkLAC0H+7s+EE0E5kqzqOfM=;
	b=tTPQfk2Csyt+iV8C6vqYY4cp79JKZvA8637D+P8MOYjfPNlYRSQPDROec2in+PMKtZqr
	 ZlxBXl2U8gpaY30ZVHeKKjCNb9V+1xHwkimkiguMtKPJXQGPHLy2mVj5US+HdKTmGSTut
	 N0/V21821068SLIaYbcm6xsjIt8wSfM2NsdECmANJcX0QrhyQgpdDXwg0o73OD3A/XIp1
	 JadCMW3I9ekWhl+DMazygmew8H9Pt+/xmEmFkEf9sYnCj8+9WyFPVZR8QERBEqgQiwDm9
	 JPziEZ3n8gw7vng59aebOSL9OumWBxV/taodheaze7ezqhlzu/C/xoKHh+XlEQJYHpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hZG0hSjr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1214F606A339
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 15:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hZG0hSjr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B56D31F008A1;
	Mon,  9 Nov 2026 15:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794239614;
	bh=dYluARUs3puz/gbMHcttxkLAC0H+7s+EE0E5kqzqOfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hZG0hSjrmwIvlluTLwLTMpn6i6aj/IO73gmp59g1GltzcmqGC/PnuqK6ShTR1VMku
	 j5qWDH7J5q8cO9W5P1M9BglzJa/8khlUwUlP4L+n2WZpl8Mabp+CDFHEDWCwUkrZ/f
	 01mAZx9XhsUJ2ThAmG/rPEWJUgnvurBbfJt5Q+QZ3Tr8DpuPxiVaTh7ZKHoZ4ol/n/
	 Fb8nQru1Y8ZvHCwknHLxedDYlvyT4leivQDtfVaqadpuqCTdOcGKMWIkBZmVHwf0mF
	 OsL1WwrsvpELiypn+iPB4fsLXWEPCPSoxxXa39ktawhROi6wRJzl0Y9FHXLjYV2jKo
	 nJv9AHsxQZ2DQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Marc Zyngier <maz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH 6.12.y 1/2] PCI: Add enable_device() and disable_device() callbacks for bridges
Date: Mon,  9 Nov 2026 10:52:50 -0500
Message-ID: <2026-11-09-1-daily-reply-0008-rcar-gen4-6.12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108224801.2533200-1-marek.vasut+renesas@mailbox.org>
References: <20261108224801.2533200-1-marek.vasut+renesas@mailbox.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> PCI: Add enable_device() and disable_device() callbacks for bridges

Queued the series for 6.12, thanks.

-- 
Thanks,
Sasha
