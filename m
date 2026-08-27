Received: from mta1.migadu.com (out-168.mta1.migadu.com [95.215.58.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003EE2561A2
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 01:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787793051; cv=none; b=TzTKm+oVzZxufacD37FQhiBW9HctV5EiY2nW2Xz09JZISjARsypZzLyY43E8nxG6vOoBf+b6qH9KA5ROtBGHCTXtRLPFg09Z4sk6yXrpc8JgEQH+Nx/4LRYkb058zjGOSORDDXPML9q+nAd2wWnOIt7S/9GCmLBoEPhgNrbaLlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787793051; c=relaxed/simple;
	bh=x9mUG0OBAFF/8i+baQ7hc8Y4CSODH/aCtPuVKPSWPyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jj4wLRiMG8I7iDk2dmPWcf7tcEes1fPS5WBCVtF3e7fg+rUQr1aHntmR16uDkAzSeLocg8Uy05P/LbVBtWlHytIbk9eH3QVeokSQOgdiepR8XFEQzRQr7tkgREv/xvxwoaOuVUfHoZZCWQ/Iunq+D1RXZWtqZ3x9D2v10tr5ayk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oorDeYpm; arc=none smtp.client-ip=95.215.58.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oorDeYpm"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=x9mUG0OBAFF/8i+baQ7hc8Y4CSODH/aCtPuVKPSWPyA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787793046; v=1; x=1788397846;
 b=oorDeYpm1w7wPkgGMrbMh3Xf8gfONrqv6tV4YBRdLwr411l7wSB8PEesd/xoD1CLzq3hY33q
 5ev3bWxp2bkSyPjaNucBmNiDgTm9zDGN/ai8sHLHhpZOs0I877CVAjttcu33oq5GYr/h0g5BfbV
 Lxsv3YH7zrL6OJmSjlO7w/Mc=
X-Envelope-To: stable@vger.kernel.org
Received: from fedora (203.175.12.242)
	by smtp.migadu.com with ESMTPS id cbfea065c0f6dc9a;
	Thu, 27 Aug 2026 01:10:36 +0000
X-Mizu-Trace-ID: cbfea065c0f6dc9a
X-Migadu-Flow: FLOW_OUT
Date: Thu, 27 Aug 2026 09:10:28 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Qihang <q.h.hack.winter@gmail.com>
Cc: jv@jvosburgh.net, jiri@resnulli.us, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, willemb@google.com, netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] bonding: reject frames with insufficient
 headroom in bond_header_create
Message-ID: <ao-OhAl-Mys6zU25@fedora>
References: <20260824021802.90369-1-q.h.hack.winter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824021802.90369-1-q.h.hack.winter@gmail.com>

Hi Qinghang,

On Mon, Aug 24, 2026 at 10:18:01AM +0800, Qihang wrote:
> From: Qihang Tang <q.h.hack.winter@gmail.com>
> 
> AF_PACKET SOCK_DGRAM sends reserve skb headroom from a snapshot of
> bond_dev->hard_header_len.  A concurrent bond type change can switch the
> active slave to one with a larger hard_header_len between that snapshot
> and bond_header_create(), so the slave's create() pushes or writes past
> skb->head.

How can bonding change its device type while still sending skbs?
Bonding does not allow enslaving devices of different types. We have
to remove all slaves before changing its type.

Thanks
Hangbin
