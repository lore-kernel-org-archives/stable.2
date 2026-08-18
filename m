Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D27224B13;
	Tue, 18 Aug 2026 00:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787014440; cv=none; b=WJ5ZNoPsoLwAGP2jtgLwGziYVFdnQQ6WkTuaqgDnM02/V8DuMDKpb8vzkRQrfEjVzi6Rhlh7bhQzXzgdCZYcDUnVYQi2k9LtlM5prpzlxTSWCYDS6a72n3DX/XXVjeM5j4MjlCNjJE7vTYsU8AchMMo+mwKGH5B6Lj9tbjxyQ7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787014440; c=relaxed/simple;
	bh=wOCpkQU7IWEvWq5NJmSVccXJpIMDk4Lf0nwrbBD8OJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHvEDb3zP3jjI9mZoYHn67B5FcDWqwYsbYGd7WkiJzcDLjYZGDIZY3czCyQ6eLVj+kmdBMGnU5gFp68mNzepwxePgkM1ZjOG+9tHxQbQGmtuVj0NsCIjs3E6NZIdlRTcapjmcQiWypm3oQV6BQ5CLMIOR7QYyyAzLy2/G8iYexc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=H1Mml4Hq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="H1Mml4Hq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8QFJ/p1h27E0rbYmZGx77WBf51SQtMNCefM9/aMMHXk=; b=H1Mml4HquhsM2CPxkO7Ms4l4rJ
	pjHk6fSGGu4JlXV2jSBZdY0ytUyK4JYMBwUX9i/y/JruLy+Ba76EVjvQOGcZEkRpWg6vZ4djxkbMZ
	9O3k4x9qMagKNeg5PYLMvcT/IeNhzxvzGuInoFTFlPC3IYsD9lVGp56/mCxtzWVXeR/k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ww85E-000Owx-BN; Tue, 18 Aug 2026 02:53:40 +0200
Date: Tue, 18 Aug 2026 02:53:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Georgi Valkov <gvalkov@gmail.com>
Cc: briannorris@chromium.org, johannes@sipsolutions.net, krzk+dt@kernel.org,
	francesco@dolcini.it, johannes.berg@intel.com, kees@kernel.org,
	miriam.rachel.korenblit@intel.com, wenst@chromium.org,
	rafael.beims@toradex.com, avraham.stern@intel.com,
	error27@gmail.com, s.kerkmann@pengutronix.de,
	gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
	robh@kernel.org, conor+dt@kernel.org, Frank.Li@nxp.com,
	chunfan.chen@gmail.com, linux-arm-kernel@lists.infradead.org,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: net: wireless: add flag
 marvell,ignore-regulatory-hint
Message-ID: <c10c5132-1bac-4bf7-acd5-1319ce072eaa@lunn.ch>
References: <CADOrJmbTyrGGkq+9OJDXCgTa2HvNo8BWxoE6yjafcrOq7WNamw@mail.gmail.com>
 <20260817215428.84740-1-gvalkov@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817215428.84740-1-gvalkov@gmail.com>

> +  marvell,ignore-regulatory-hint:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Ignore an incorrect regulatory hint from ROM,
> +      so userspace can set the correct regulatory domain.
> +

Maybe this has been discussed in a previous version of this patch...

What is Marvell specific here? I assume any vendor can mess up, and
make a US only device, but ship it elsewhere.

     Andrew
