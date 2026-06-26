Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FB93FCB1C;
	Fri, 26 Jun 2026 16:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490381; cv=none; b=AGqdN3aZ+4RUhAMaZgTnDaPJe8AVr/6YTFf16sZbcHSp7+THzHDSk3LmWx5EESNy+6Na9cbFTKUgXhNY9RMoxnYo2KRaIPlN79yszlCUE/9PdDXjqQVjKO+KQtwOdyUm/WvqMLbzKaXZRZdRLCNoGkJbIOfleXzOuCWlCOB4e3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490381; c=relaxed/simple;
	bh=xF3HrPGp083qdUeM2OV7hUzimRdrJZF7dHbq8z77FXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tuWNY7xGwjGNgx9r6VwaiEnelFm+lXOCIEaRnQ6FQlduWx5TOveKESTu5se47y+0J0qJsR7xtSbWRmjb8EWl7qm3QcQtesm0ofSAJJWUg4bdAoZdafQkHUN+TAhFRVcI7j76Tt4HHN+nYzkSAxeUgycB44uULQ6nrPC9ryZfQX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lRXeUkqi; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lRXeUkqi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nGwr4lXo5Wqpnzr+aOKYM/r+chKEzwjv6CwiudH1p4c=; b=lRXeUkqivNlZY17nLYk69L4/Lu
	8ksK7vXiChUEftTGQYw6AWXgV2EQMCJk5b3dUs7VKPwbSVzqpZxCUP2VhHtUPDPHG8LBbLZSdDpXi
	YqtuoTbhpzkPI5mIeZYxnyLn3hvc9LHhSIVLPG7tHE1UQ16dd9/p+DVA+fPDPeaN6BNw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wd9Ad-009OI3-Bh; Fri, 26 Jun 2026 18:12:47 +0200
Date: Fri, 26 Jun 2026 18:12:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix: net: mediatek: mtk_star_mdio_init: fix double
 of_node_put after   devm_of_mdiobus_register
Message-ID: <1d62a7bc-d0e9-4b76-9e7c-3fd01647d854@lunn.ch>
References: <20260626152009.51599-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626152009.51599-1-vulab@iscas.ac.cn>

On Fri, Jun 26, 2026 at 11:20:09PM +0800, WenTao Liang wrote:
> After devm_of_mdiobus_register succeeds, the mdio_node reference
>   ownership is transferred to the mii_bus device (released via
>   mdiobus_release on device teardown). However, the function
>   unconditionally calls of_node_put(mdio_node) after registration, causing
>   a double put.
> 
> Only call of_node_put when devm_of_mdiobus_register fails (i.e., when
>   ownership was not transferred). On success, the bus driver manages the
>   reference lifecycle.
> 
> Cc: stable@vger.kernel.org
> Fixes: 9ed0a3fac08b ("net: ethernet: mtk-star-emac: use devm_of_mdiobus_register()")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>


    Andrew

---
pw-bot: cr
