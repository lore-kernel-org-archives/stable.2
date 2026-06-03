Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAFA3CF69F;
	Wed,  3 Jun 2026 20:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780519623; cv=none; b=S4McqlFdUwEsK7YpOulr+fqIVAqPKqerErsJdQ9G5jq0UAzvLEybXHRr+xx0qC2thNTGODBIzf7QZaAvxKN8rS2S9Ibl/4BudbgloPgfKAegbfULV/eMczy3ksXZ6I11BnP2IEED+fKXgjAs8eJggm7bFhVrSOL8WG3120xpllk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780519623; c=relaxed/simple;
	bh=s8Oq8GTPoa7/lgCetzuhN6bRtr01Ey6YRDcB6+iiDWk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YPM33cFbocIibXlla2+/W4M02s7woQRgrD9GWOQJzqzT85ZgaSkxDGIIUmsBV6kx6PXdLjMR90TOAXFrONwh+ptsSyHTe1hFKnX2jVlt23ErAxUB1rqgyAuL2Gm7BpfLUX6A1xwuFhdDv/ezcbWouiJMfmEk8sm8rZW1vfKAE0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B71C1F00899;
	Wed,  3 Jun 2026 20:47:02 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id D79D7183852; Wed, 03 Jun 2026 22:46:59 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Johan Hovold <johan@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Dzmitry Sankouski <dsankouski@gmail.com>
In-Reply-To: <20260407123338.2677375-1-johan@kernel.org>
References: <20260407123338.2677375-1-johan@kernel.org>
Subject: Re: [PATCH v2] power: supply: max17042: fix OF node reference
 imbalance
Message-Id: <178051961986.2666348.4424045423863997346.b4-ty@collabora.com>
Date: Wed, 03 Jun 2026 22:46:59 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 07 Apr 2026 14:33:38 +0200, Johan Hovold wrote:
> The driver reuses the OF node of the parent multi-function device but
> fails to take another reference to balance the one dropped by the
> platform bus code when unbinding the MFD and deregistering the child
> devices.
> 
> Fix this by using the intended helper for reusing OF nodes.
> 
> [...]

Applied, thanks!

[1/1] power: supply: max17042: fix OF node reference imbalance
      commit: 68d234144b7dffd1f50b07ba74d0d6e833ef43a4

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

