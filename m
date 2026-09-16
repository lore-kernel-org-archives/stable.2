Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D764F30F5;
	Wed, 16 Sep 2026 12:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789560594; cv=none; b=mLjPBc41mdtJ9TNT9Ly1jtXio1AqudumpBRSAR+ZXMrQdvksXNdZ9GDFLF/J7zaMlkgLksqh+CCtpHRMUSUmnZhQo5m1PaVHKYXBqiXM0Y6MAQJ6qosGRL4G1GU9E+aHRZ/8YM5bFJz4LTMYs/Hu1v5z7pG5r4p8yzkE1u77D9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789560594; c=relaxed/simple;
	bh=7bRYibctC4Kme2YeH1wfWbDVCefvtBJ+KeBIy4/qCvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WcKZRR+L+QuBQgcxmYvzXqZG4Me2suqqDBGLqYjU1Tu4cltWiRPcvi2xmlQ7FTQdnHCT7d+V13f3VNi6AKwYhzZ5Af9DIdIau8NIYES1+Lt3EhwIpqDG/ldUa6GpNucLPNtW7A6YnX0J5UTO/vgWHejmcN/26NZEH1ZBtkMlU5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=az1aDV9q; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="az1aDV9q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Z8b5eXfulcZ3iXkTbM1qxaJq4jbfNRDFt2Td7+xHRUs=; b=az1aDV9qFjSo+RiifHDAMYVN1B
	ALjg5VqsnAhTwUu824ks+KF7pkJIOMM3uw/YhXKzKYlLWkeMKeI3RUhtTx+bsDlTvL8j7F/fVOPkC
	b5D2w4gXD/99xVXTUdbtdI4FHo6BeHPUdP9bHl3adc3yrQYFKb6tPH1Ey3QBaVQo1494=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x6oS4-005TOL-DM; Wed, 16 Sep 2026 14:09:24 +0200
Date: Wed, 16 Sep 2026 14:09:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: dsa: mv88e6xxx: fix netdev reference leak on remove
Message-ID: <82aa5f19-767b-4d7f-943f-6a52fa832eab@lunn.ch>
References: <20260916020340.2580417-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916020340.2580417-1-lgs201920130244@gmail.com>

On Wed, Sep 16, 2026 at 10:03:40AM +0800, Guangshuo Li wrote:
> mv88e6xxx_probe() uses the referenced network device provided through
> platform data, but the remove path does not drop the corresponding
> reference.
> 
> The probe failure path correctly calls dev_put() for pdata->netdev.
> However, after a successful probe, mv88e6xxx_remove() tears down the
> switch resources without releasing this reference, leaving the network
> device reference count unbalanced after driver removal.
> 
> Call dev_put() in mv88e6xxx_remove() after the switch resources have
> been torn down.

dev_put() and dev_get() should be used in pairs. Where is the
dev_get()?

	Andrew
