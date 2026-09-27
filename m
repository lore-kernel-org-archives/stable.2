Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA7E364EB8;
	Sun, 27 Sep 2026 15:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790521514; cv=none; b=ousnOiARgjNPXarsn6438Je0unmRGT7Rryc6ymwsvuGCRFZM/IrCJfN/JLLAuN0VCYGU6DJctIqBre9lQgG+O/yiqefnGtfXwLCdo87lonfod9a+o1Uce2rlcU36hJrKKsZUlqtCuu8o045+FmOgdvgk5IXTu3a5+ee5r5M2EQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790521514; c=relaxed/simple;
	bh=d8n0dahZXSre6Ant2KvgpLmUvD5kjC8kzxX7CCgmZlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8it8wyLd6DFwErhU6UDa4cEB/tS8AxIVxDo1JRTa3bZH83DINZZeRUmjIc0KCc5482ebgGNwbumqRbi+O87AygXey2IUuePjHH38m3phg5lyq/98huoYZSXh06IPOMSvS6f4MzXjh0PPXuMP04O7tCWfgV65gxcFiU5d1Hmcyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0oZOW0xu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0oZOW0xu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3KCsFglgv22Ag7CUE2/ra0LJO3mHKeeFWfGfSUJv+n8=; b=0oZOW0xuHTnX4lfxfHWbQf2Vkx
	LAMUjDEGtHnpDs7Dm4r1OB8jMWLdQ7GmtqwqjVScDReP1DMQJyFQQOoJhXNqcw0rEJiQMeRmE9OId
	9c2RCNdCc3YkzUYZQNC7qdqgmVw2Gy39oYFCnWCmAzj4/LHWZJU13btAyv02UBIH+/iA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xAqR7-007Wg3-Da; Sun, 27 Sep 2026 17:05:05 +0200
Date: Sun, 27 Sep 2026 17:05:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: linux-leds@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Kees Cook <kees@kernel.org>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/4] leds: trigger: netdev: Access net_dev under
 trigger_data->lock in the worker
Message-ID: <c8b59891-9eac-47f8-97c7-f4ee9f835970@lunn.ch>
References: <20260921093249.3481413-1-alexander.sverdlin@siemens.com>
 <20260921093249.3481413-3-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921093249.3481413-3-alexander.sverdlin@siemens.com>

> +	guard(mutex)(&trigger_data->lock);
> +

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

There is a dislike for the magically guard() construct.

      Andrew
