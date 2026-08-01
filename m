Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB2D368D41;
	Sat,  1 Aug 2026 16:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785601607; cv=none; b=Z8hviEoISCZx4pZMs1PhcRvjsI1mfM30J95Z7U+VL4Rup/yGfUW/ZbREgTsE/0IbqejKnfDVk4vpMy0tMJ/2TKNPSBS8OABa31k3UZJ2aJRTqiPwIpd/4i9qo94lGBAYu7k56IpOSaWJPt5im/B9PgD+YkDfoMko/Pxy1kJGaf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785601607; c=relaxed/simple;
	bh=9RF4SvE8w1iYHt8weuXHGjV26JfEzYOERGf1t+c8P1E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=elkgQ8Y9nKodFQdk9CD0WWepe93oXbwldK9t2coCTomlhlgOfIMwVVZbSn7e6qqBpu+g4DIZ6ucYM5yNIVFGYc1rgBclWc2h5KiAxwB6Mdd/gjs47viRSFSFPu6KkwH0X9sgFtPtGZ8yorHBu3LwdUcgPD7swWKt4PVEV++egbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B27A11F00ACA;
	Sat,  1 Aug 2026 16:26:45 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 27156180500; Sat, 01 Aug 2026 18:26:44 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Jianing Li <m13940358460@163.com>
Cc: Iskren Chernev <me@iskren.info>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Matheus Castello <matheus@castello.eng.br>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260731084259.916-1-m13940358460@163.com>
References: <20260731084259.916-1-m13940358460@163.com>
Subject: Re: [PATCH] power: supply: max17040: drop incorrect I2C
 functionality check
Message-Id: <178560160412.8893.8859237111681195871.b4-ty@b4>
Date: Sat, 01 Aug 2026 18:26:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Fri, 31 Jul 2026 16:42:59 +0800, Jianing Li wrote:
> max17040_probe() rejects adapters that do not advertise
> I2C_FUNC_SMBUS_BYTE. The driver does not issue SMBus byte transactions,
> however. Its regmap has 8-bit registers and 16-bit big-endian values, for
> which regmap-i2c supports either raw I2C transfers or SMBus word-data
> transactions.
> 
> Consequently, an adapter providing raw I2C transfers or SMBus word data
> but not SMBus byte transactions is rejected even though regmap can access
> the device. Conversely, the current check can pass an adapter that regmap
> cannot use.
> 
> [...]

Applied, thanks!

[1/1] power: supply: max17040: drop incorrect I2C functionality check
      commit: 4e4b9f5ce9dfb8ed4b8d1262a504b8043ac09d87

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

