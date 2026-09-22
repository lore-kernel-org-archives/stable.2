Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5636B541E42;
	Tue, 22 Sep 2026 12:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790079436; cv=none; b=WWEoW4vDbmg+CTwkKcMakTdGBmFhhzcGMP6wksgP7LxbbpqKcrTM4H5ibGtExFwmp0F/zkICT76gfLb4bq4gzeKG9ZsIk5ky+Ub8O2G3C2OwP/swewW+TfqvgPY1EJZFQYcbBrLUObtqZsvXOitpXRuWXH023pEUc784olqRI58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790079436; c=relaxed/simple;
	bh=vAGkHJAT4YAHlnMS65LNAskLm76RVTb7K2UUJK8sAEg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LL3/pXSvl9uRZX0s0+W5qCEx6YE/9hoJMQWyGgDk/UCLcbLC8fgKEuFQGu2JEG9+L9qUYjM+xIEfFsWKuORmrMD0qiws626+A+uF+LTPOXDt8ByMQkAb+spomHsEpuquSzR9YS1aQ/AAmbXkcnMKG4DvRxpPlJrifPQzeB/BW1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEpIInvu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEpIInvu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCFAF1F00898;
	Tue, 22 Sep 2026 12:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790079435;
	bh=UTwoRtCxpyQiRt2als02TMCSop+AZzjECQZjdXtydjA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=OEpIInvuY1mahfAEh/Fiz5LrBFaLDMGcCv99xqGfQ0r/52aDoKPCpYUDfDy2sdgiP
	 yTCU1YH+H0y/2XwsQ6bpsKkDq08ciJmBd3ANeWhIZHMNuxqFVN5DjcS/gLYm6u2PrP
	 3qmW9MUD1sp4h1H/jiVbj0uwk3YPAry0qxx8WBPFQsAyPo7A6eaaBrk2kyRuxVFAk8
	 Nf8nff0+aNUYMP3tCoMB2EpQqxRn3n1DMjQQHClUFkyfjl5bQ2+ae8ZCDPIe+srsRG
	 BFN7PpMDtdepZZs5Jl6NvZo8jWJmc/k54hK2chB8+DhvhNKdLAO3Yiq6BJS1Dy15Tg
	 1dLKE4a99+myg==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Myeonghun Pak <mhun512@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 linux-omap@vger.kernel.org, mfd@lists.linux.dev, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Ijae Kim <ae878000@gmail.com>
In-Reply-To: <20260913205013.54777-1-mhun512@gmail.com>
References: <20260913205013.54777-1-mhun512@gmail.com>
Subject: Re: (subset) [PATCH] mfd: twl-core: unregister the auxiliary
 platform device on unbind
Message-Id: <179007943265.3347426.8815239247412852464.b4-ty@b4>
Date: Tue, 22 Sep 2026 13:17:12 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Sun, 13 Sep 2026 16:50:12 -0400, Myeonghun Pak wrote:
> twl_probe() registers a standalone platform device named "twl", but keeps
> its pointer only in a local variable. Probe errors unregister the device,
> while successful probe leaves no way for twl_remove() to release it. The
> platform device therefore remains registered after the I2C driver unbinds.
> 
> Register a managed action on the I2C device immediately after adding the
> platform device. This unregisters it on probe failure and driver unbind,
> and also handles failure to register the action itself. Remove the manual
> error-path unregister to avoid releasing the device twice.
> 
> [...]

Applied, thanks!

[1/1] mfd: twl-core: unregister the auxiliary platform device on unbind
      commit: 62d519c24f8373772d4fb390ba5926ebc8c17509

--
Lee Jones [李琼斯]

