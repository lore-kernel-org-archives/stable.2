Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1185208C1;
	Wed, 30 Sep 2026 21:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790804862; cv=none; b=UM7JlQODINGpJLNExd4pR9XUXPyjnEK1V0ua1cUOO49xdWgjEKrsVocLebFAInqMfDTDdismFf4/28T9NN+b6U2SjHj7DmIdtROSOpW5q0CsnInCC+TMsD7eCsr60flPgxCb+I+7PJ2olf+/b41v0iwfTCmfd2SOS/J/vW3tXXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790804862; c=relaxed/simple;
	bh=bCf7ZNO2y8bqccvARZZRRweH5vkTmKrqmfVlT9305RY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3U/H0PPgW43xnfON8VMb0EyYI2vUxsbdbFrJRslKEMYGLDTvhZMGRUO84xTA51tWk36YOBUup97F6LIkLuKwSZhjQM4+6nPOgIEtFGIi9pQIrNu54bGbQL9EMI5W40O0eAFfmNcGmvq97mGLFgyKHeMD5xTwbVGR5z6uKo6j9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NWehXtEf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NWehXtEf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JrO/Q5uWPByzNMo9tdMpSb7dTKrD8QsmrdPHM5UmOnY=; b=NWehXtEfsrqzAAzLqOQnaM0zsB
	XnqJOeIG8Fjfi4ciuU8OaNbrLlDFWrau/jH2OrEUtfaVVbtrhrzeNS8YZyClz/JMBITZRZsNubfXv
	4ZgEZDjX66chJ4pdGBFvNzRkPl7xmB0TNvAavJJof/n1LVQAKKsgfFXyiLNWHrHVrAbs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xC29E-008FIW-1s; Wed, 30 Sep 2026 23:47:32 +0200
Date: Wed, 30 Sep 2026 23:47:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Linmao Li <lilinmao@kylinos.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Xiangqian Zhang <zhangxiangqian@kylinos.cn>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net: mii: Fix unknown speed after link up
Message-ID: <e31a9b2c-2f65-4767-b66a-85676d5a0d5c@lunn.ch>
References: <20260930113842.2640928-1-lilinmao@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930113842.2640928-1-lilinmao@kylinos.cn>

On Wed, Sep 30, 2026 at 07:38:42PM +0800, Linmao Li wrote:
> mii_ethtool_get_link_ksettings() reads BMSR only once. Since
> BMSR_LSTATUS is latched low, the first query after link up can
> report SPEED_UNKNOWN even though the link is already up.
> 
> This is seen with r8152, which detects carrier using a MAC register
> without clearing the BMSR latch. NetworkManager can then keep
> reporting 0 Mb/s until the next carrier change.
> 
> Read BMSR twice to obtain the current link status, as mii_link_ok()
> already does.

There is a reason for this latch behaviour, so you should not ignore
it. It ensures a link down is reported, even if it is for a short
period.

I suggest you change the code to detect link based on BMSR, not a MAC
register. Better still, throw away all the mii code and port it to
phylink. A lot of code will go away because phylink/phylib and PHY
drivers will implement it.

    Andrew

---
pw-bot: cr
