Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A04486436;
	Thu, 24 Sep 2026 16:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790268657; cv=none; b=grpOIFCukoD0Kfgra3yRvdX9ojI2bHGgBHMKlIQ7iWTesEDCJRRTphjGf4XehlVin8HTX0sCHK75SNYAblGvLq8Wun7ZrMnDKlX0u1YU4xeH3baQOWCZzRbxzQP3mVRXs4eEwq776hKcq5ne/Xa0Kf9EsR4zbjEyfQ23vQOh/wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790268657; c=relaxed/simple;
	bh=OlFoWh+rqFJObhbPkokAKVpDfMDKAyT9eixk5CzAgms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltR9T2rnwGFH4HcgeI9YnOFZ2EpJjOrukLypKrAB90SucL2YZP3rTt2rU1Eo+xcCXD914IJMJFug98Y2RvWlD+wEb4+jvPIq8n/Fko/3rEjM2SXYr1m/jLd9mqKT0lBt01aUlYoSAMRXPfwd4qb2CgJmBOjheqe911bWBUq6cLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3Di4o9un; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3Di4o9un"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=N79et7AdBLbnk95bbO75NtebdQjiOKQmwtR8vmsPlWQ=; b=3D
	i4o9un+8ccs8K6Fpxdiyj3JZHTnxlMDZbXsXgAQY1KUkDV31lxr8+XhO3H82CUVJfY6pI8SftsEGt
	gfgWBrkuDZE753deAZVoQnK028ZtHFzvZDvdK6kf1LmpvHuiGiw2m6aWor0/Yy/StxH/gc4hWfKHK
	wt/aR4XpxRsRStk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x9meh-0072Wr-Bv; Thu, 24 Sep 2026 18:50:43 +0200
Date: Thu, 24 Sep 2026 18:50:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?utf-8?B?0JbQsNC80LHQsNC60LjQtdCyINCg0LDQtNC40Lkg0KDQuNC60LDRgNC00Lg=?=
	=?utf-8?B?0L3QvtCy0LjRhw==?= <r.zhambakiev@prosoftsystems.ru>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Denis Benato <benato.denis96@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Petr Machata <petrm@nvidia.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH net 3/3] net: fealnx: allocate the card index from an IDA
Message-ID: <d5a25a0f-67a9-4431-9fa4-24e29730cb26@lunn.ch>
References: <20260924104231.110576-1-r.zhambakiev@prosoftsystems.ru>
 <20260924104231.110576-3-r.zhambakiev@prosoftsystems.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260924104231.110576-3-r.zhambakiev@prosoftsystems.ru>

On Thu, Sep 24, 2026 at 10:44:25AM +0000, Жамбакиев Радий Рикардинович wrote:
> From: Radiy Zhambakiev <r.zhambakiev@prosoftsystems.ru>
> 
> card_idx is a static counter that is incremented on every probe.
> It can overflow and wrap to a negative value, which then indexes
> options[] and full_duplex[] out of bounds. Large values also no
> longer fit in the 12-byte boardname[] buffer.

Seems very theoretical. For something which is never going to happen,
please keep it KISS:

	if (card_idx > 100000) {
      		dev_error(..., "Please stop doing that!");
		return -ENODEV;
	 }

    Andrew

---
pw-bot: cr
