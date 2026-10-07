Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0931A42A14C;
	Wed,  7 Oct 2026 08:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791360097; cv=none; b=RqQkPnL/pEAbOh2PtYvtWUmqnbJgdrLlfD211U1hVuqZbS2vd/KLu8A7t/L3M9cvTwgSCBsS9t21oO9nHv1XZLf05D++NO0uXDRQJJRUWe/WkvA0WgYmpFbnZ3+4TnE6VTSoght4o9OOfiok5G5L8IodwIqPfTe0xwi3qAMukJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791360097; c=relaxed/simple;
	bh=+EyMe0hHKlcHVM3iar8QUgOM0lw1C/O0j3clnza0WB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tvsTgytlAobaJTDN21ZzOKRae1T4p/xI7JBkY6k7WNZqkYE+G5xK2x4v9qlutBQ1sk5miximQ2ALZ06Q9MUfxKmu04MEJZitZdapqz96Da6u4DP4h/aTT4Bi123LXHjVQ5S5FdaRgJdWiTez1ie719MSoSw8qLZWVyEHW/3kCBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ccOV8byq; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ccOV8byq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1791360067;
	bh=+EyMe0hHKlcHVM3iar8QUgOM0lw1C/O0j3clnza0WB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ccOV8byq9rSXaUH2DWX0Vz/UoA08Vcu6JjPxFP3ChneXlZ+HjNZSsTI9Zt9lrQSwu
	 DezT0nIFvWaeB3yCeP35mUihRXDUOXEl1QRNTgKOQgCLZc7KJHJ2pYm1Hbm2VKdg4c
	 R5Ghnq3mmtktc+LdHn1nW+9a9jsCr22Ff0p76Mo8=
Date: Wed, 7 Oct 2026 10:01:05 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Andrew Pam <andrew@fastmailteam.com>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
	Matt DeVillier <matt.devillier@gmail.com>, chrome-platform@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] power: supply: cros_charge-control: restore EC state
 on resume
Message-ID: <0d30381b-c39b-463c-bb25-d8701afdb4cc@t-8ch.de>
References: <20261004225606.30577-1-andrew@fastmailteam.com>
 <20261005043418.243937-1-andrew@fastmailteam.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261005043418.243937-1-andrew@fastmailteam.com>

On 2026-10-05 15:34:18+1100, Andrew Pam wrote:
> The EC resets its charge control configuration when the AP powers off,
> so configured sustainer thresholds and charge behaviour are lost across
> hibernation.

(...)

> Fixes: c6ed48ef5259 ("power: supply: add ChromeOS EC based charge control driver")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Andrew Pam <andrew@fastmailteam.com>

Acked-by: Thomas Weißschuh <linux@weissschuh.net>

(...)

>  drivers/power/supply/cros_charge-control.c | 29 +++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)

(...)
