Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B7E3E00B6;
	Wed, 19 Aug 2026 09:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787132420; cv=none; b=dYQnpAcw0pn7REipD5KDjTDUi34RVU1xB69AFUDWoZo+2BPHsqk4RuzL8vxIKUL3UfBseQVfzqGAO912u988vpQRGiJ+9qUq39p7krtTzmOkuLz+YB7RWxVNhqvGD/exBtsbbShk2Te548k6nUerJnNE8DYoqfRg7bo2cL5sVzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787132420; c=relaxed/simple;
	bh=keG+Ob7UYFoZ/3lSG8krXrI9HNusptPSdD9AFND/1RQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFVYhNQFH6Sxup/dRKsy6qBP8jlvumJAy5b/nzpvFBmu+qMU79dkvH7f+wyjl7EWX0O9AoTkLVH7WjDkF+gCSSXk9/Eop0qVaHjsFPeMbwbrt4P+lxp1XjS7K4nz1y1qOwl0dSaBRNa/wdr04uPESgreMVBTZm5Z08NPxzLfv88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TlmnRACD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TlmnRACD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC461F000E9;
	Wed, 19 Aug 2026 09:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787132415;
	bh=NIiYPq1vcnLnFm+K0IBpegZpaRy0riQEBHbOf+BbH1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TlmnRACDndhz9vBW0wumZcoY3Euv8VCbT2RxROlWtWwE+8tkLc3lQqPN6hme6dMas
	 LAYWCI1Uy11yKpitp3AeFZ3Iz7nx1Be04YFju4xY9PGBFjs1rHpVHNrPS5F7EHOzLS
	 0jNq8Mk2VUFZawzZe6ZbDglTVT37atQOTZthQjCZZbxAOB574qXmVo7bITeUO0TF3t
	 pQS9cGqWMNfy7Z9nRro3sSy+Wssi5qbiP8NMhsBxY3fI+moSlOozKJKclswHkc94/t
	 wq+vsE+Ptyvl3QYIPGnPXp5g7+CVh04JEStoKyFkF2aTNWGua8FkTxMbHqp1HVTWXX
	 hxPqlxGSdgymQ==
Date: Wed, 19 Aug 2026 11:40:12 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Georgi Valkov <gvalkov@gmail.com>
Cc: briannorris@chromium.org, johannes@sipsolutions.net, andrew@lunn.ch, 
	krzk+dt@kernel.org, francesco@dolcini.it, johannes.berg@intel.com, kees@kernel.org, 
	miriam.rachel.korenblit@intel.com, wenst@chromium.org, rafael.beims@toradex.com, 
	avraham.stern@intel.com, error27@gmail.com, s.kerkmann@pengutronix.de, 
	gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com, robh@kernel.org, 
	conor+dt@kernel.org, Frank.Li@nxp.com, chunfan.chen@gmail.com, 
	linux-arm-kernel@lists.infradead.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: net: wireless: add flag
 marvell,ignore-regulatory-hint
Message-ID: <20260819-fervent-rich-saiga-be15fa@quoll>
References: <CADOrJmbTyrGGkq+9OJDXCgTa2HvNo8BWxoE6yjafcrOq7WNamw@mail.gmail.com>
 <20260817215428.84740-1-gvalkov@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260817215428.84740-1-gvalkov@gmail.com>

On Tue, Aug 18, 2026 at 12:54:26AM +0300, Georgi Valkov wrote:
> WRT3200ACM and WRT32x routers always report a fixed US regulatory domain
> from the mwifiex ROM, which conflicts with the platform regulatory
> configuration on units sold outside the US market. For example:
> - phy0 mwlwifi 5 GHz, hard-coded region 98 EU mapped to FR
> - phy1 mwlwifi 2.4 GHz, hard-coded region 98 EU mapped to FR
> - phy2 mwifiex 2.4 and 5 GHz, hard-coded region US
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
> Cc: stable@vger.kernel.org
> Signed-off-by: Georgi Valkov <gvalkov@gmail.com>

How did you fix the threading problem I mentioned in v3?

Best regards,
Krzysztof

