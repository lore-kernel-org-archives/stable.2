Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793790745;
	b=OIwfN5/RH2p76IQqzXzkBtw4ejEXyC9qj+ZpdRG+xHMjfQ31LxTN+22kmGbG6avrm+LT
	 hvFPn8o0YZNUc58meBevgKewI7qWMPIYXBFHbhgHU0paB/ghut/7JEcal6GwV4xGDj9lP
	 01w5DtaR6IxckpRDnadL6n+5w5p1ITgivSOq8DN7jcK0uoK4KUHdHefN0aT7gRw/LkvLs
	 Igb9mBwyIzmh245fcK/VX7YatzU9Dzf4mEOpx8QZprvv9ZTN1dNLo8HHCrD0xURIleA0L
	 LynUK6V/EVXhjHKH/GvxW6MGKK8GbvaMC+SQ4h/WQ4zHcVdYTL7Jo87jZmlYjcWMeMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793790745;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=gyF7dm9FS0Ed8e/c54ZznUYgKNg5Co9xtbwrpOLqJKQ=;
	b=oDKAznUAWT4ut/fvc4IZVfgnzYK69IFWPvUElybsfzwDVq6gJTDlY95OZUsGwQcgwGlE
	 MQOrF18bocPOndUSG6bENqNqq3KV54mKTsvl/mc4n0696HfpvESsNtf7iobS04SS8AXfG
	 tub93oZ/de2WRjfvO0c0SVJm41LepmVIoUAY2ezbMQuAwWpWlfDTpoJLRRpYVq0zLYCa8
	 N+eiRI0G5opICNBy+iQrYYhhmSnTuN6FOFCu6aSN3KpYbg2tlb4rKn2DxLH8GoOT2299C
	 HQcmfd4BebRBgSy7bQnHm61DFAA7jhC+4HPlETzu+scgcU7UvL/RMS4H06jPQfvyL4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GeExwbS7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4517E606A335;
	Wed,  4 Nov 2026 11:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GeExwbS7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7DDC1F0093A;
	Wed,  4 Nov 2026 11:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793790744;
	bh=gyF7dm9FS0Ed8e/c54ZznUYgKNg5Co9xtbwrpOLqJKQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=GeExwbS7o374ZK7sDRGyPrVxoFtqqtf/KzVPfo3JtRcw/vVAclyNmmWzKI0gSgqlt
	 Rit3VzS4pQ3eP7o/fL/+YBDgnU0jrv5a4L25M97rmyELXtGvDCwZCb1y3DLI32pCE/
	 3WzoQgujJEj5wgog5V1QEiuaOuACi6HIVhZscMxMUfKGoTJwV5hDaVGM+KIcuSaGAY
	 nBEzp8po7y3Vii4ZpuTxrpv+GisplKyT7FedZP1mGP9FwUZbcwdhvROioHjUtS/yfk
	 JWWu5f/zXAiCkcrqM9oGMQykcJ9JBVBjJJa3tYveyk87gAxsqSd6ZEDUIR91PFwlZQ
	 4OlZRqQKMzsbw==
From: Lee Jones <lee@kernel.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Orson Zhai <orsonzhai@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Lee Jones <lee@kernel.org>, Weibin Liu <liuwb@xiaopeng.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 linux-spi@vger.kernel.org, Chunyan Zhang <zhang.lyra@gmail.com>, 
 mfd@lists.linux.dev, Guanglei Zhu <zhugl3@xiaopeng.com>, 
 Sashiko <sashiko-bot@kernel.org>
In-Reply-To: <20261026153253.689525-2-liuwb@xiaopeng.com>
References: <20261026153253.689525-2-liuwb@xiaopeng.com>
Subject: Re: (subset) [PATCH v3 1/2] mfd: sprd-sc27xx: Pass byte length to
 spi_read()
Message-Id: <179379074248.1651659.15467348960119051443.b4-ty@b4>
Date: Wed, 04 Nov 2026 11:12:22 +0000
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
X-Mailer: b4 0.16-dev-ad80c

On Mon, 26 Oct 2026 23:32:52 +0800, Weibin Liu wrote:
> sprd_pmic_spi_read() passes 1 as the transfer length to spi_read(),
> but the length parameter is a byte count, and the ADI controller
> consumes a u32 register address from the buffer. The ADI driver
> ignores the transfer length and always operates on the first u32,
> so this happens to work with the 8-byte stack buffer, but the
> advertised length does not describe what the controller actually
> accesses.
> 
> [...]

Applied, thanks!

[1/2] mfd: sprd-sc27xx: Pass byte length to spi_read()
      commit: aa474d0abf753cadb1fce6f1d129eefa39ec223e

--
Lee Jones [李琼斯]

