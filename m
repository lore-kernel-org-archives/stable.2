Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BCB238C16;
	Mon, 20 Jul 2026 22:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784586764; cv=none; b=pZPfZMaEn7fT3JvKeFntfky3LLblEqoVZnLJfHaFmeVzMHTfGDPZi5S9kzK/lbE95rj+qo1zXKtfgDWV/paw4eyLA2pf5bkeUtklacasfoAn1I1cDZ0WrlxMPsVOYLKojvavlriNWtoFhcoQTE5V0G8q9xamrwrbP2zR8R3IJOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784586764; c=relaxed/simple;
	bh=q7Cszih/kkw4t3DmzwqZbXh+kz2+HE0qWeK1XllyzUU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KY2FqxYWZCXlVWlHMx+Rz9YMlbDeHALAmsU2kk7BNHb1wbn6TW02dFNXnNXWJS5cvKT7iQtFRe6e+tpghzVfMr2gnM34gCkjNtVEQBjv4L+a6eePoo7ZHKPdnlX/j1wlMCHXrYM/dK3I321xofioM0z2+/suDZ3MM+9mucbwZIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA57D1F000E9;
	Mon, 20 Jul 2026 22:32:42 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 4FF51180A25; Tue, 21 Jul 2026 00:32:41 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Jianing Li <m13940358460@163.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Iskren Chernev <me@iskren.info>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Matheus Castello <matheus@castello.eng.br>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260701061042.1008-1-m13940358460@163.com>
References: <2026070115-equate-shimmy-5f19@gregkh>
 <20260701061042.1008-1-m13940358460@163.com>
Subject: Re: [PATCH v2] power: supply: max17040: handle missing status
 supplier
Message-Id: <178458676130.353413.14998578200231351929.b4-ty@collabora.com>
Date: Tue, 21 Jul 2026 00:32:41 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 01 Jul 2026 14:10:42 +0800, Jianing Li wrote:
> MAX17040 does not report charger state itself, so the driver forwards
> POWER_SUPPLY_PROP_STATUS to a supplier power supply. If no supplier is
> registered, power_supply_get_property_from_supplier() returns -ENODEV and
> leaves the output value untouched.
> 
> max17040_get_property() currently ignores that error and returns success,
> so userspace can read an uninitialized status value from the battery power
> supply. This happens on systems that use the fuel gauge without a charger
> supplier relationship in firmware.
> 
> [...]

Applied, thanks!

[1/1] power: supply: max17040: handle missing status supplier
      commit: 725668c6b6aa3971fe850659102c250d0d676e18

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

