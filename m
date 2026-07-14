Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99795370D57
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 15:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784043942; cv=none; b=EV3K0WTRmq0ZBCDKthbJsTPDFruKOaI4jcuBoBJZcFv4U1yFwk18eodLnfJZAvnZPwdHsOYsFkyVk01JIsMoBObZE2JsmqWVNLDn0foSI/aw7/HKZ1bQ2cBlxawCIunfSe+nqfJo7MhjM4/DMqKJEP4rVMtEBe5gmXh9tgcMWuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784043942; c=relaxed/simple;
	bh=Zlbztg6yiHPnkiE4IG2I/j2f7aZ060OxX5TItitbtV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sR853VSJuX0y8u+HDnNkcSxWCz4ODpyk6JSAEYwzgJPTrs1k55qGgHBWUuyeGzR7PL03HhN5rUp5/BEqvQitqLMRJS9a0cauVV4kj+Vxcpp0XRYt3nWLK4U09vUK2am5pscVgOHyh2G4evYkMAoTFD9XFBdjxzPLvJYa3mb1A+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=GRPBhngk; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="GRPBhngk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=Zlbz
	tg6yiHPnkiE4IG2I/j2f7aZ060OxX5TItitbtV0=; b=GRPBhngk5B7vXiKudUsU
	dSmlpTkEFwT9K5LvAcpwF+FcoE3Oa03IIyu9rGjZZVOY4LpetxduTNW64buNDxPV
	jtASd5YPg6BF0WfuxBUGn5WisjrF2e5rESA67Xm8kqp3Kfdc8Jy0qtjSdBW7Mbdm
	CBm+UD1fq9Vb+mothDffuyFmbHkfa0+sX1tv9PcWcBFnzyfDjS3QsxXXFUfuyJO3
	1bijkbclwNqLEo9hHBTj8++NiFmg2R4nUA3JEAGycF8lEeNs7Yj6dCKWnLKQ28vM
	h4lZAFpa1kJApspP3PgTg6zj9U0TXv+i8LhXwPWQdYRNH9FKputuIYtiqPcP/25/
	Wg==
Received: (qmail 330099 invoked from network); 14 Jul 2026 17:45:35 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 14 Jul 2026 17:45:35 +0200
X-UD-Smtp-Session: l3s3148p1@e5ADGZRWdoAujnsO
Date: Tue, 14 Jul 2026 17:45:31 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Andi Shyti <andi.shyti@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Wolfram Sang <wsa@kernel.org>,
	Kaushal Butala <kaushalkernelmailinglist@gmail.com>,
	Shawn Guo <shawn.guo@freescale.com>,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>,
	linux-i2c@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Carlos Song <carlos.song@nxp.com>,
	Stefan Eichenberger <eichest@gmail.com>
Subject: Re: [PATCH v3 0/2] i2c: imx: fix SMBus block-read of 0 locking the
 bus
Message-ID: <alZZmzQrnBptGEMQ@shikoro>
References: <20260713-for-upstream-i2c-lx2160-fix-v1-v3-0-073ac9e103a5@free.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713-for-upstream-i2c-lx2160-fix-v1-v3-0-073ac9e103a5@free.fr>

On Mon, Jul 13, 2026 at 08:11:58PM +0200, Vincent Jardin wrote:
> i2c-imx rejects an SMBus Block Read byte count of 0 (valid per SMBus 3.1
> 6.5.7) as -EPROTO and returns without emitting a NACK + STOP, leaving the
> target holding SDA so the bus stays stuck until a power cycle.

Bigger picture: Linux does not support SMBus3 which also allows byte
counts of up to 255. I started sketching support for all that but could
never implement it.

That being said, despite no SMBus3 support, it should not hang the bus
like here.

