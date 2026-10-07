Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FC4448B9D;
	Wed,  7 Oct 2026 12:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791376057; cv=none; b=abH0f4apXQKWgCSDz/twOFoOyKLs8Y+NK3wsGlKaabx74HTnq3NYAxQOEnWJD1KkFc8ew+qzuP05KQdgj+LKdAfAoPgxumHC9Y4AlU70chkC6ytxxzR1sUoQOY+dE7uwJ3qPcM0zzJo986eu46wu8Rd6OaknzhNCKXEW4WeGeds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791376057; c=relaxed/simple;
	bh=U6GyF6lRYjgCEWmvhFJzyWk0fj3jt82DEmRclZ2q0GE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bnB5PsLkTbiGHThmqRnR+PXLoyGEGbCITYqBDjo+UXg1UQJTippX4LbqArh/iZntjwxtB5VxI8caGMfl/kJ0ddsPnkMqixCec1uBsU9+tRUsfcxdaY1yanNYzZKu6p4zqlTRBfMPjp2MffyrRrq1C6zsI8hFJ9fds8+Ym6MNOy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rjbxcm2+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rjbxcm2+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dufBJ1mHa9n28EXq+40OD+8yYER3Wv9RK13RjqUDC34=; b=rjbxcm2+M8g/K9G5qLyXzzB379
	mBG2qOMUB8XtymbdtE/8ricwS3GhO6KFjeOsRkhasqG6ARBerQaBoxHe/7fWOHvRu7U8KQZ6jJ0RI
	JBL1CySC5s5qmEbWJruIEk13OopzQ3rV/YvYsevFmV1E4W9gDgvYmkgX42taSIg1kyo8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xEQk0-009SAY-4M; Wed, 07 Oct 2026 14:27:24 +0200
Date: Wed, 7 Oct 2026 14:27:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aldo Ariel <qwe.aldo@gmail.com>
Cc: wei.fang@nxp.com, frank.li@nxp.com, shenwei.wang@nxp.com,
	imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: Re: Re: [PATCH net v2] net: fec: reject oversized fragments before
 bounce-buffer memcpy
Message-ID: <36643418-851b-4cbf-ab73-8e3fa09f8715@lunn.ch>
References: <a230cd62-db31-4128-acfa-93501d30aa39@lunn.ch>
 <CAP48HfuR9_d2KZ7ygG4fMq5ekSb2zaaiEzo_fq_mOWODN5Os6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP48HfuR9_d2KZ7ygG4fMq5ekSb2zaaiEzo_fq_mOWODN5Os6A@mail.gmail.com>

On Wed, Oct 07, 2026 at 05:17:20AM -0700, Aldo Ariel wrote:
> Hi Andrew, Wei, Shenwei,
> 
> Thank you for the review. Shenwei confirmed that bounce buffers are
> only available on i.MX28 and cannot coexist with jumbo frames. That
> means the overflow path I described (jumbo fragments exceeding
> FEC_ENET_TX_FRSIZE) is not reachable in practice: on i.MX28 the
> max_mtu stays below the bounce buffer capacity.
> 
> Given that, should I respin as a defense-in-depth guard (with the
> goto label fixed per Wei's note), or would you prefer I withdraw the
> patch?

I suggest adding a comment somewhere to explain that jumbo frames and
bounce buffers are mutually exclusive by hardware design.

We don't use defensive code, because that suggests we don't actually
understand the code!

	   Andrew
