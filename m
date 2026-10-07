Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5B337E30C;
	Wed,  7 Oct 2026 23:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791416653; cv=none; b=a5YL6R0zNAIGMsp+lPStmZbozITCikMi5HAOuKpRDu5ysxHDMLIUnyerXi3p05EpILKt84I8PNKp3rl1gzewqgA8aYjuPh6Zy2tAPQ8VO/ecZ/Ygiv/Hjw0jfDweAKpk3nuxfUfAiKDBCx4kdUXSRfcIGM7kq3OgoyKBTjRuO5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791416653; c=relaxed/simple;
	bh=ePbHZ49lsSWAcQYJZZsxzKKJ20eeToD4G1EnF1IT7AE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SPqXsE2NlrHmdohkSnXTA6JUi7VRW68ccbco6ggULjzrzBX0FIWVl4bVofk+bgzy969VysByudoFEENSlLWjPjm0r13efqajvmrZOjOQiaSdMCNL9qXu5RvBd13Wc5tYySdeq5zCvSxHypBl1FrVkvgVe/NUK/UMnYUIfQ/SP+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbQJ9Mh0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbQJ9Mh0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9DDB1F000FF;
	Wed,  7 Oct 2026 23:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791416652;
	bh=ePbHZ49lsSWAcQYJZZsxzKKJ20eeToD4G1EnF1IT7AE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RbQJ9Mh0EMtaVqH3xM2Wq6GnkvpqVOUZ29XcEsuWF/3V4l+XuywwGtJ2leu4d5D/S
	 0IvyR01AAmV5VTt1fhvD4aZf5rYr3scxKomKowy/sP6pGWUtl9JnL2UcEzuPwA6wV/
	 wjvRJ3+kf7RlRc3yB95ssG0ph6xdb5po3zY7Qls2t8pI31Kaz6aRLgCWSlTrVCExxC
	 cOOpiYYkXLNrXjy/ANc4eDk3B8msL+UribH4uuIaqBj/f1snX64HR53Rt6GOBvjAEU
	 zge3dTCD7daMVjb+1qtVM/xzztc6bYZennq5PP5B2AQ5dqs2DAP1sHmZPqt74kCw2p
	 nj/J7HnDE7FMg==
Date: Wed, 7 Oct 2026 16:44:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fredrik Nyberg via B4 Relay
 <devnull+fredrik.nyberg.volvocars.com@kernel.org>
Cc: fredrik.nyberg@volvocars.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, Jose Alonso
 <joalonsof@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH net] net: usb: ax88179_178a: fix rx frame length for
 non-last packets
Message-ID: <20261007164411.28506f68@kernel.org>
In-Reply-To: <20261002-ax88179-rx-len-v1-1-f01a2a295079@volvocars.com>
References: <20261002-ax88179-rx-len-v1-1-f01a2a295079@volvocars.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 02 Oct 2026 14:28:57 +0200 Fredrik Nyberg via B4 Relay wrote:
> With the patch every received frame was identical to the sent one.
> ax88179_rx_fixup() is the same in 6.8.0-138 and in net, and the patch
> builds on net with W=1 without warnings.

I don't get it - why don't you just test net?
