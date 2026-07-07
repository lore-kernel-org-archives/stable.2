Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B693B841B;
	Tue,  7 Jul 2026 19:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783453489; cv=none; b=DlzSBQaJ9kcNk0GOjp28qEYFisLWlBbJjGixfAJQROZGs+GZVwwEQzC0NTYO4WTIWQPIymKyIhKQ+gZMW6pjQ2cUEP+iX2JPR6pIVEOeYSTW+JkBD2ghBxWpALvQKJ8RpOtjxJ97Rom5s8gBup7UxXl+EF5ZK4O8VZh4I1fiECo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783453489; c=relaxed/simple;
	bh=1knhvM8IOBr5QjIcxkmuQMAyIfHmJUmUxzQvdkljKsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W5b0HEY8K6HytDQzOueLIkqCWlgZo+OquxwaYA+npxljX2Se/zp6DTR//6/cvHQjyJh8ofPxWxd8cuswbo27EMRi3WcIS8XfQLJ2Orq5+pNAc8TKLMxpQ2WTjrV8fJaNO+EnW0UN/6MgYfA5wI85rMWefAwxeVYfc0XOj5vA9C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=0SreCQZ4; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="0SreCQZ4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=uPIFmf4gi/tHeUmRTlNHk2NPJBJwT3A0d8KvxPUdG/8=; b=0SreCQZ4n0F9Ek7P0cJ/2XseCr
	4LWaRJTXNrKp9xx4AT+egjLzTulRlqU+94jVpH5pDRO/+Iq4jv/OkL4cV0LUDQ7uoHCEvNmcyBHUR
	Easvn+jjAeL7MIAGzfp2NHWOeAo5apguGvXPAIJ7sSdYmQDPWJJOYpVTA2EMsAprGzwK6IQ8Bp7Ce
	jK3/Q+Uz4XRWzSRUlU40KMVf+MxjY4FPKpqJfO+BswoRcXnr0npYaNkR2n8ydagMUgQ/n3fxygA+8
	knOl4+f3Q/HxymN7Wt80aBSLhvDMjwWpM24VLeYcgD3mKwHOEJ2C+hr1ZCVVYho/wvsLKjmHZNyGL
	7C3SlJpQ==;
From: Heiko Stuebner <heiko@sntech.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Fabio Estevam <festevam@nabladev.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Fix rk3588s-roc-pc audio description
Date: Tue,  7 Jul 2026 21:44:31 +0200
Message-ID: <178345345847.664858.7864543249465975825.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260703025648.180135-1-festevam@gmail.com>
References: <20260703025648.180135-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 02 Jul 2026 23:56:48 -0300, Fabio Estevam wrote:
> The rk3588s-roc-pc ES8388 codec is connected to the i2s0_8ch audio
> interface.  Use the matching I2S0 MCLK output for the codec clock
> instead of I2S1.
> 
> Using the I2S1 MCLK can leave the ALSA PCM running while the codec has
> no usable master clock for the active audio path, resulting in silent
> headphone output.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Fix rk3588s-roc-pc audio description
      commit: 3354976953e1bcbec4ff1135b8ec08631a9fac3a

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
