Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3162E7369;
	Mon,  8 Jun 2026 07:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780903753; cv=none; b=q3waYSeosk0BlWZB55z6/GazuOUhEsdGwEaB9YULDHXKi1wfzb73OMqjEnAWPlUomfkJHUo/bqo82QBmJi41nXa0mYpPwCuSRKwq9S+ED/yVlY6szIQtgwWpQIsQ35BGQNMOkF3YjFZpZEOenR1CtenHvKKpCeqGjOIFw4HLzyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780903753; c=relaxed/simple;
	bh=kpwdAC5hxegt51CkX2VVr2n0lKU9czFn/1BxAOdzNR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5vNX5zs39W6naFMXqfFVblDnK0xB6mmjPRne5V7DvyIf99uJxpcs904qXEbQ9ksrfBjNsLoBD1Kb+jYnji3ecyozx6kIstm3/7JJLhFptd5MX+D4U4P8m+EeTV9CaqoTzTGQh3LhEbTxiVDMmrXJUT8/QerPJJksD/KEdKkLcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=X/5wCyjp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="X/5wCyjp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3UDzfLo/i6wOr04HWyI9GgT+i3OXY0Iu85/jxG0+CcA=; b=X/5wCyjpCw2H7O0aJy7Q+SrovW
	wNxrDVulmme2EHyGZM1PlKkWshRJKjcdMxih44YxQq3d99UEBW08lM3LmCxuPzx8gyYY0OXxEYZvL
	x/vIM4yRV2iCYzH54P4+0sGOFbqOMWxifscSF1DSBBhidH+s2LqLS9bPIuCsMcDiSz5o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wWUPx-006ZvY-MM; Mon, 08 Jun 2026 09:29:05 +0200
Date: Mon, 8 Jun 2026 09:29:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
Cc: Wells Lu <wellslutw@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, stable@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Subject: Re: [PATCH net] net: ethernet: sunplus: spl2sw: fix multiple of_node
 refcount leaks in probe
Message-ID: <5f03cf1b-035d-46d9-a157-f8a7e33fc050@lunn.ch>
References: <20260607193711.601544-1-shitalkumar.gandhi@cambiumnetworks.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607193711.601544-1-shitalkumar.gandhi@cambiumnetworks.com>

> Convert eth_ports_np and port_np to scoped __free(device_node), add

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

    Andrew

---
pw-bot: cr
