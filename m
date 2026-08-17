Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0823C65F0;
	Mon, 17 Aug 2026 08:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786956901; cv=none; b=VykX1PJ9LNaCyTgfAOq0GnDfmbZ/J9iwPXdHr8XfqTwWMcL2uSuSgGzPyaOO+XMyKdoGfoVzBNbc0bACkleB3/y7/5rTRtpz4el5zk0pEql+84Mzg7OWZH1/Ug9+Jw+oKMaY6OYzqoYVHzQQYHhEOtoA28PIzJgVcSraM/CRS9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786956901; c=relaxed/simple;
	bh=vBekskIkyI4+2weTZERUJj6fK+DFXgfdivpKIuatXcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQI+JJkhFXxQi39lPyf4u5kUD+owMfpH1JH4gnH2M7HL3R8EhzqKK1GcLQrR7xE7jMjPYk4aQx90IErSZc9RNEJQwu19qPm4KmPy9ODbz4BuohTpMMDabLF/fm1xtNBDvODrKfLGgUioqRO8RlAi7JQYxUvCtbddKmWX3PADW2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQ/JVP2y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQ/JVP2y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 704311F00A3A;
	Mon, 17 Aug 2026 08:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786956898;
	bh=06ePaNIYtV1D2TYd+VS2xlZSCHGC67xKGkcgI5yu8VA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IQ/JVP2yUPtirEQ/ELjYnVfs4z+GjTJFLfUVnJbVIZ2dwPrFhPQn+6EqNJE8E4/vI
	 VwXtqG10OV+/zCyPLKgAM29Z+2e48BiAnepIMwUvqx3trdU0Cpqk78BMbn6qI34AEu
	 zfrvKAr6CCS4FG/4TQRUX/UnYtQwv5j1YwIBKEAFcC2WE9dr+zYPA0l3itOXwIsNnE
	 h5A+7rsjczQR2qxrcsOG/bMl499wczxgeGfjHnYKsgN4PmPgIJU+TxV3olfTtOHs/W
	 cUvFEeySVsh7ecJqltMidKyBoGARQqUudhyPzPuHX9aO16SFwzflj9sVE7r4taGQbr
	 XJ8WGSFErD3PQ==
Date: Mon, 17 Aug 2026 10:54:54 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Georgi Valkov <gvalkov@gmail.com>
Cc: briannorris@chromium.org, johannes@sipsolutions.net, andrew@lunn.ch, 
	francesco@dolcini.it, johannes.berg@intel.com, kees@kernel.org, 
	miriam.rachel.korenblit@intel.com, wenst@chromium.org, rafael.beims@toradex.com, 
	avraham.stern@intel.com, error27@gmail.com, s.kerkmann@pengutronix.de, 
	gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, Frank.Li@nxp.com, chunfan.chen@gmail.com, 
	linux-arm-kernel@lists.infradead.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: net: wireless: add flag
 marvell,ignore-regulatory-hint
Message-ID: <20260817-hairy-serval-of-refinement-49039a@quoll>
References: <anoYr9H4KojJv-aZ@google.com>
 <20260814125025.90522-1-gvalkov@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260814125025.90522-1-gvalkov@gmail.com>

On Fri, Aug 14, 2026 at 03:50:23PM +0300, Georgi Valkov wrote:
> WRT3200ACM and WRT32x routers always report a fixed US regulatory domain
> from the mwifiex ROM, which conflicts with the platform regulatory
> configuration on units sold outside the US market. For example:
> - phy0 mwlwifi 5 GHz, hard-coded region 98 EU mapped to FR
> - phy1 mwlwifi 2.4 GHz, hard-coded region 98 EU mapped to FR
> - phy2 mwifiex 2.4 and 5 GHz, hard-coded region US

v1 as reply to v3 in big thread. How tools can parse that?

Does b4 diff work?

b4 diff '20260814125025.90522-1-gvalkov@gmail.com'


> 
> When the system boots, it detects a conflict between the user selected
> region and the radios, e.g. BG FR US, and applies extreme restrictions,
> preventing use of 5 GHz and DFS channels. This also affects phy0.
> 
> Add a device-tree flag, which allows affected platforms to ignore
> an incorrect regulatory hint from ROM, so userspace can set the
> correct platform regulatory domain.
> 
> [1] https://github.com/kaloz/mwlwifi/issues/173#issuecomment-307879699
> [2] https://github.com/openwrt/openwrt/issues/9956
> 
> Tested-on: WRT3200ACM, OpenWrt

Not a valid tag, drop. And you cannot even do that, otherwise explain me
how did your device execute THIS (exactly THIS) code?

> Cc: stable@vger.kernel.org

Drop, what is the bug being fixed here?

Anyway, property looks like SW choice. You must describe hardware
instead.

Best regards,
Krzysztof

