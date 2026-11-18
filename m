Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795027447;
	b=oXbchHcVtesILpJPrkCJCz4NRHsC+MIsejsZjQOMZjZfng1i2pR8/GZbaV14r3dzHRnV
	 SA4EJX2fNkPzsE3BTXps70lzBwgKfMJkCG5RaG//BadKeiO3/uAg/b6wWjFrnEgh7cfNl
	 zTGTj/B2KRsDe4YC9y+ldzd6uo0MQGjKEJdUpIyIUTtGG1LD6eDopdikBwgOtJ6DWgpz+
	 LKkgFweR9VQpymFWNlFENkVd9wzkEHzaGDPZ6XkiCk5t7g5/x2+/H0jwliATGO5Anry6W
	 GdVXEumxXJRfCgNz9hTL3rreM4fzQKKrSxuH2t6KM/4S7Spvy4dE3F0BOyZWUHFAHhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795027447;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=Exh67LGpxykc1JGTN+in07YExIL4rUDgMV0oj2/L/Eg=;
	b=tw4wEh2PZghhB4mNAgtBkIMMjbPqT5uBsw2V6GCxlioe20z5KlzVzKB5PCRQOGzoglXd
	 z2ske3ug9zkMyYuIfmqjCRlPJX1Tn3TSzwoDYn9kMQSFKzJonIByhoqb62MlEeWT9VfJb
	 ta+yXBnGV0uEYHCViXXRY1FqO1vJ++mVn71VHgneBP7Wq2+51ExBp1f05nuQBPKH+LqIx
	 iOq2X2vPK3kcGc9kNy6HYz5jXbhSzzdiVExkstEAO/CadaDNx5tbxiMELTJg3ORDbC0nm
	 1fHtxExBrGU8WYR9C7XGLVhYYiLQ5LMHrq64OvayzeaaTLWHKdP5ah9Gjs6Y2J3iMGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=bVwK3gIB;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA2B606A331;
	Wed, 18 Nov 2026 18:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CA2B606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=bVwK3gIB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Exh67LGpxykc1JGTN+in07YExIL4rUDgMV0oj2/L/Eg=; b=bVwK3gIBoh1JAh+xKxY1vWJ8OO
	fHzZaF3l9M7ah8N5eVTQJFCwbBiZQBD82LzWGm0pYXrIwvcHdC0lMR3LHPXUeGqMSl0hjvNF7/mp9
	YPfqAc+xiEcNAUfTuvs8xcP/6EwHqs9MAfT9ZZsqL3I9bCOAFhvu2B5qosMnOXbToLnE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xTkdP-00HUdI-IX; Wed, 18 Nov 2026 19:43:55 +0100
Date: Wed, 18 Nov 2026 19:43:55 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Zhao Li <enderaoelyther@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	=?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
	"Lucien . Jheng" <lucienzx159@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net: phy: air_en8811h: check PBUS register read
 errors
Message-ID: <31de7b62-098a-425a-bf0e-38064b3a42d3@lunn.ch>
References: <20261118182436.32455-1-enderaoelyther@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118182436.32455-1-enderaoelyther@gmail.com>

On Thu, Nov 19, 2026 at 02:24:36AM +0800, Zhao Li wrote:
> an8811hb_check_crc() ignores the return value of its PBUS reads. When
> the status read fails, the loop tests a stale or uninitialized
> pbus_value and can stop waiting before the check has finished. When the
> result read fails, the PASS or FAIL message tests the status value.
> 
> en8811h_print_fw_version() also ignores a failed read, which leaves
> priv->firmware_version at 0 on the first firmware load.
> en8811h_read_status() then handles it as firmware older than 24011202
> and guesses the link partner's 2.5GBASE-T ability from the link speed.
> 
> Return the error from each of these reads. A failed version read now
> fails the firmware load or the probe, as the other PBUS errors there
> do.
> 
> Found by an AI code review agent; not triggered. Compile-tested with W=1.
> 
> Fixes: 71e79430117d ("net: phy: air_en8811h: Add the Airoha EN8811H PHY driver")
> Fixes: 5afda1d734ed ("net: phy: air_en8811h: add Airoha AN8811HB support")
> Cc: stable@vger.kernel.org # needs adjustments for <= 7.1

Does this bother anybody?

https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

MDIO pretty much never returns an error.

Please repost for net-next.

    Andrew

---
pw-bot: cr
