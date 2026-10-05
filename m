Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3F031AA92;
	Mon,  5 Oct 2026 06:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791181493; cv=none; b=FV23n/SZlsAcnBUgqMH0VVDNbsO+L52uD3LfFk02Myu6ilxnR5XKcfIDHRm9U/2SAHV+5kT4XjiTO06EFgZM82sQejIJFk2ZIea67tdT1w4FSr8GYYanIjBoxV4DnANw3NjtjIkpxDUQvfYeMoWywRClml9JISyZQMXPVKfC4YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791181493; c=relaxed/simple;
	bh=RC4OwZ7ZaEBF9P4eLnxhVzqJAdpccCosy3AcdFlcdco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=po2rITecrsaU7Zn4kXJ+OfiHBPQCChSoj5KuuYjlRj002Z5dGJ6c5z66dRG9wFWZAnlfvnQqijXdzsi7+zjg9UnVModuCMQPI6HH4idw8H6vPKH1nj66SWym16f5pekF5A9aug76PgPGQwLoGy8pTI75dcoa7DRQg4T2qHrSFWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWD4htRX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWD4htRX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 483481F00893;
	Mon,  5 Oct 2026 06:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791181492;
	bh=11wT2lLDb34axa7W/ud0mXtdsFwrKpKNkMXKWRKs/O8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZWD4htRX9YeeS8j+g+3SS/z8e7BsFxEGYxOiYrFz99cWkSbdSm76IOO7RlHyAHnnt
	 D9RBo8g+xeYsOmAQ+vVy5R4y+usk2c2DKGi9l4b2JRHY/daA29+KPBzMEgLR8qxjng
	 g5LoADq9M5RAI8nlPrzvo/s+GVqi5twwhgZraELnlHaHT+EJWgrPEdLHcyO8E5q8lN
	 pULDL3z3Sd5fXq/7iJap+gvR5uHRX6gbAoMqM2nnYfQl8YctGnsyG3/vGWi5gM89Hv
	 ft9Nl6pqgXvUahqFm+MD1TWq8+NWKNZ6pcAZ6lntJS+NBCWYw3yi+Lya8U0VDx1hMi
	 TOS2AXfyD9f8g==
Date: Mon, 5 Oct 2026 06:24:48 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Andrew Pam <andrew@fastmailteam.com>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Sebastian Reichel <sre@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Matt DeVillier <matt.devillier@gmail.com>,
	chrome-platform@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] power: supply: cros_charge-control: restore EC state
 on resume
Message-ID: <asNCsCTIzzFMwOPX@google.com>
References: <20261004225606.30577-1-andrew@fastmailteam.com>
 <20261005043418.243937-1-andrew@fastmailteam.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005043418.243937-1-andrew@fastmailteam.com>

On Mon, Oct 05, 2026 at 03:34:18PM +1100, Andrew Pam wrote:
> The EC resets its charge control configuration when the AP powers off,
> so configured sustainer thresholds and charge behaviour are lost across
> hibernation.
> 
> Nothing notices the reset. Commit 4fc88ba435da ("power: supply:
> cros_charge-control: adopt EC charge state on probe"), in the
> power-supply tree, made the driver adopt the EC's charge state, but only
> at probe, and a resume is not a probe. Sysfs therefore keeps reporting
> the configured values while the EC charges the battery to full. On a
> Framework Laptop 16 (Ryzen AI 300, charge control command version 3)
> with charge_control_end_threshold set to 80, a hibernate and resume
> cycle leaves the attribute still reading 80 while the battery charges
> past it to 100%.
> 
> Add a system sleep resume hook that reprograms the EC from the cached
> state. The same EC behaviour and the same fix already exist for another
> driver, see commit 2643187ccb86 ("platform/x86: ayaneo-ec: Add suspend
> hook").
> 
> Reprogramming the EC is only strictly required after hibernation, but it
> is cheap and idempotent, so hook every resume path rather than rely on
> the EC preserving its state across each kind of sleep transition.
> 
> Note that re-reading the state from the EC on resume, by reusing
> cros_chctl_init_state() or otherwise, would be wrong even on the command
> versions that support GET: the EC has been reset to its defaults by the
> time the hook runs, so adopting that state would silently discard the
> configuration the user asked for. The driver's cached state is the only
> remaining record of it, which is why it is pushed to the EC rather than
> refreshed from it.
> 
> Fixes: c6ed48ef5259 ("power: supply: add ChromeOS EC based charge control driver")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Andrew Pam <andrew@fastmailteam.com>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

You should send new versions (e.g., v2) independently next time, instead of
replying to your previous versions (e.g., v1).
