Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3703D37F75B;
	Wed,  1 Jul 2026 05:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782884622; cv=none; b=G5IuEN/YiVrT4Jcy/9FbU4Q+rGU68OAjK2w6K+sd63wg5CCIsdePmVGJb6nIZKbEwbr/KqWmJmUkYk4jcolPHkTDDcYvJUBcX5BZTMWGV/N+UN+ghEsH3RdThWvan0+HgWk/1fY2Vn89PmgVMIPNrNB9ph50c3xMgxeALwqFbvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782884622; c=relaxed/simple;
	bh=gRKQ3/hQFEanmmBi+Rz+LeKtfw8kylGgvKZNe6XmuhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITQqd4ruXrTQiJkM6PXvmweCuwkPGUVaDXAHRnGYH4oH2HVwRJgR0DP1GwTS58kH97Z+qIAxNIcXqUtDUJU44hfKjK4GNUoiYrcXZGCv8L6v4WnCSU9ilu0JmmUo0RtJtrLZSQ7ytd9jNtfxxCzphMvjtB30BAb3BHQoX2Xfkmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KmBAFpdy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KmBAFpdy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52FF61F000E9;
	Wed,  1 Jul 2026 05:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782884620;
	bh=KWfvH7ukIpAAnwG0drNrOUeLjPT5WPF+nH/nAIY22J0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KmBAFpdyYekG1ZSySTKNOriNmKusVX4SalkQAXKbuMeZF798AO7q3fcuT2Q81LRq0
	 XoTRUCizmZvyN6qD9RW1ufUGF4+Rs6R4PZubzdVT7JkNjHx2qvqoQdBJC8Bk9XFAOd
	 agxC0UXc8pEc8ZaJDksLmxzvpiKsjt6BssSHWFWc=
Date: Wed, 1 Jul 2026 07:43:35 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "jianing.li" <m13940358460@163.com>
Cc: Sebastian Reichel <sre@kernel.org>, Iskren Chernev <me@iskren.info>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Matheus Castello <matheus@castello.eng.br>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] power: supply: max17040: handle missing status supplier
Message-ID: <2026070115-equate-shimmy-5f19@gregkh>
References: <20260701012101.782-1-m13940358460@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701012101.782-1-m13940358460@163.com>

On Wed, Jul 01, 2026 at 09:21:01AM +0800, jianing.li wrote:
> MAX17040 does not report charger state itself, so the driver forwards
> POWER_SUPPLY_PROP_STATUS to a supplier power supply. If no supplier is
> registered, power_supply_get_property_from_supplier() returns -ENODEV and
> leaves the output value untouched.
> 
> max17040_get_property() currently ignores that error and returns success,
> so userspace can read an uninitialized status value from the battery power
> supply. This happens on systems that use the fuel gauge without a charger
> supplier relationship in firmware.
> 
> Return POWER_SUPPLY_STATUS_UNKNOWN when no supplier provides STATUS, and
> propagate other supplier lookup errors.
> 
> Fixes: f4b782af61ae ("power: max17040: pass status property from supplier")
> Cc: stable@vger.kernel.org # 6.7+
> Signed-off-by: jianing.li <m13940358460@163.com>

Please use your name, not an email alias.

And why send this 3 times?

thanks,

greg k-h
