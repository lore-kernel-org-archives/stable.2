Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4123D9DBA;
	Wed, 16 Sep 2026 17:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789581178; cv=none; b=cMr+GgU6EXNGQvGa2PTQYsmMf9YkGwvUZ5q5hM0gnRYZJCLLPgQTT4fHISoudyvkZzRALVkoEaa+XG5VkT+mTqOhtFXQ42bEOWXKIYb2pIpelLH3Vx2YhEClNkiIp4NDc70Lc0rXlNTIwcmuwfm0hXpB7YikdWO1iqKDm511xdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789581178; c=relaxed/simple;
	bh=6zeoML6bAETakMCWlyOIj5/pOqwuK+LF7dIdA+EmfGU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FDLh/xUTNycr/4CjdyjXMg/ylkk7sl2//n9FpQ/1GV5R7/sFtbPgVyB8UhsdvZy9owYQ8QS9L6LjM5Iz0vEoTl20VrN0tLigANcM6Iw1siypwQRYT2DyCTaOfAezxC926siOqw/6dqDfkk+FHl275hC/nHAtH5DnK/dqqBmqvfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pfZrC1S2; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pfZrC1S2"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id ABEDAC5CD6C;
	Wed, 16 Sep 2026 17:53:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A075F60337;
	Wed, 16 Sep 2026 17:52:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 42A9511C7B00D;
	Wed, 16 Sep 2026 19:52:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789581159; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=I6pfsw/MvwDowDozZ8Afzk9PULdspfiFODztGSFhnlk=;
	b=pfZrC1S2Pz+nDCHC0MRQePHXLvvEygZMbLDEhsqYWTcLLVYc605J1I+X5K3Mw+eMROwfOy
	K9bEroV7LZFKYK00ArVEmP7P+Q0frdLORsmHCfI57V/3yDITi/hqgs+t/JpduFOM6h4VWJ
	Yu3rIhL2CpXHamoJJY8iEIFdWuTGgwNG6Zt487kg8Yfsye3B5GnXEr+0WAbrnV/9IX/pUN
	+5FgZmSGwAZ4k2hakefDU5N/fTW/8BWW+4BCZqy9UhhVLev181H5sGDMJk8Nbw1+0njVlG
	D0mHasiNu6vigN/QOs3N/JE2uPA5UVO9e87uh3B7TdMAJVoMbL22SqhzMFSV+A==
Date: Wed, 16 Sep 2026 19:52:33 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
 "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>, Frank Li
 <Frank.li@oss.nxp.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, Linus Walleij
 <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Leonardo Costa <leonardo.costa@toradex.com>, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Ernest Van Hoecke
 <ernest.vanhoecke@toradex.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 4/7] of: property: fw_devlink: Follow PWM nexus maps
Message-ID: <20260916195233.6812ef66@bootlin.com>
In-Reply-To: <20260910-fw-devlink-nexus-ready-v2-4-17ac82dbe226@toradex.com>
References: <20260910-fw-devlink-nexus-ready-v2-0-17ac82dbe226@toradex.com>
	<20260910-fw-devlink-nexus-ready-v2-4-17ac82dbe226@toradex.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Ernest,

On Thu, 10 Sep 2026 16:16:45 +0200
Ernest Van Hoecke <ernestvanhoecke@gmail.com> wrote:

> From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> 
> PWM consumers use of_parse_phandle_with_args_map() to resolve specifiers
> through pwm-map properties. fw_devlink instead parses the pwms property
> as a direct phandle reference, so it records the nexus node as the
> supplier rather than the mapped PWM provider.
> 
> A nexus is a translation node, not the PWM provider, and need not be
> populated as a device. The resulting fwnode link can therefore remain
> unresolved and indefinitely defer the consumer while
> device_links_check_suppliers() waits for the nexus.
> 
> Use the map-aware parser for pwms so fw_devlink resolves the same
> provider as the PWM consumer API. Direct PWM references continue to work
> because the map-aware parser returns the original provider when no
> pwm-map property is present.
> 
> Fixes: e71e46a6f19c ("pwm: Add support for pwm nexus dt bindings")
> Reported-by: Leonardo Costa <leonardo.costa@toradex.com>
> Link: https://lore.kernel.org/all/juuc4af7ndbajcl7gzf4tg5qz2q2j5tt3rvql4jbauradujrre@gc5nbdhhixaf/
> Tested-by: Leonardo Costa <leonardo.costa@toradex.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> ---
>  drivers/of/property.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 

Reviewed-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé
