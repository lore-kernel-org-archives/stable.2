Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792424701;
	b=CA2s0MphEcrj4Vsne1pf3i3jpcnZjqEv3svfqtFul4uwrUOREjeWWNjT6PJT9YOUQIXJ
	 KUBf6bVkMEtE9RF5LqKhqcxC/UcqKOuAFzKj3jozaOZE16Jn4wjayh7YZNmIaQcKZuHur
	 32lQj/mwZXuJPj80ghiUFML9jHSj1suMDs1HpHaWMfY+FEzphkXkG57g2yWr5UAdeg5lO
	 p8cUocleS9KBv2TxnMdTveqmpCVboAvKb2CKBnbDQw5RFt2CaTUkKfdVRaI9GugTiPTKB
	 QkpLIy4CgroSl5Ehw+dXVdUfd7mqFcMZ5V014/2k0Kra0F+vWFQYde7GdCO1c/ZVRWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792424701;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=2/KqPHWMJtxr+eU4TpVW3vSWE/l2xmxPbMEQQS6rOUo=;
	b=jZ01/Gi0Gq+cLWmXHGyuriibarUCFyjTICGdBbfsuu8miWGlWnF3YvA6b49gFm9aYLc0
	 4TIYSzR6VS5Jv5jEDxtFEhx04ynxwNiPYhx4b/fldUtEg/nkxcUO1MUP8FPYI/GUHE2zg
	 L0urT+zTIm+qbFfdTUHydHDIhx98QpdKGZRIapBSz5jxVqVOW6ROY38AAbNzTOFXldWJP
	 CZ3Ef/1sth842v2Vy402QTaKqdp+b09+O76APcmj7SvSY0kN1IVRjGbxOka+djdrPdhqH
	 cvf58FOKCH1N7nkQx4M/4+LvPi0H4Frak9fP1kHEs1MOsSp1Nknl5A7s66ktvR0hJ+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=elJMJNar;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6DE6078851;
	Mon, 19 Oct 2026 15:44:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E6DE6078851
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=elJMJNar
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=2/KqPHWMJtxr+eU4TpVW3vSWE/l2xmxPbMEQQS6rOUo=; b=el
	JMJNar/XesgXBaWwOT8aAJ40p21n4qmOTgqbjbBQ4/qRDQ9Wb7JhxXtlJ6jnUgqSGpVOWKfCyKQBV
	WLyOU2OUA8AaJLXLUV4eXRJFU3ZyRRWNmTd41XVC6pOB2kvPo30wuwoAImS22EsQGukfKUdgis0Hq
	EFTwMoAaA5lWZX8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xIpXC-00BfEW-Vl; Mon, 19 Oct 2026 17:44:22 +0200
Date: Mon, 19 Oct 2026 17:44:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?utf-8?B?0JbQsNC80LHQsNC60LjQtdCyINCg0LDQtNC40Lkg0KDQuNC60LDRgNC00Lg=?=
	=?utf-8?B?0L3QvtCy0LjRhw==?= <r.zhambakiev@prosoftsystems.ru>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michael Grzeschik <mgr@kernel.org>,
	Jijie Shao <shaojijie@huawei.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Denis Benato <benato.denis96@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH net v3 1/3] net: fealnx: fix teardown order in remove
Message-ID: <4d14a974-8789-4be4-82a5-b3d095432826@lunn.ch>
References: <20261019134136.104932-1-r.zhambakiev@prosoftsystems.ru>
 <20261019134136.104932-2-r.zhambakiev@prosoftsystems.ru>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261019134136.104932-2-r.zhambakiev@prosoftsystems.ru>

On Mon, Oct 19, 2026 at 01:42:49PM +0000, Жамбакиев Радий Рикардинович wrote:
> From: Radiy Zhambakiev <r.zhambakiev@prosoftsystems.ru>
> 
> fealnx_remove_one() frees the DMA rings before unregistering the
> netdev, while the interface may still be up, which leaves a
> window where freed memory can be accessed.
> 
> Call unregister_netdev() first so dev_close() completes before
> the rings are freed.
> 
> Found by Linux Verification Center (linuxtesting.org)
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

Seems unlikely this bothers anybody if you are referencing this
commit. Please submit to net-next, in three weeks time when the merge
window closes.

	Andrew
