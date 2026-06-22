Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A693A543A
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 10:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782124075; cv=none; b=PUSUguVDCa2FMVDAZ1eFxfF+WaqEfSK4EaC35qqu4e73tjrY85bodFQpwRe7VDIFrv17+amCyJzbkAhnIPvYcVZSgm0I1dndg9WHGanZ6DRaN1OzksxmbaQEQPAyEGnt4gR2XzXuUXGim7RBY928SwVWsp8L1bsJ7FPsr0nepsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782124075; c=relaxed/simple;
	bh=WKHcFZO2rpkCa8F4CHPzSqRTrUd2TU9dM7KkXClfL+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DeLfKrUtRay1KlxeIM68frjOjTVm09RXD7kBWF2qdy4ASGc/eXQGG3KtpAa4DijaLrOhRkz4FnCOcmeub9m0uMetgDnptj99/PFuRsEpLti1YmjWu8ZSwMiNJ4vz01Lxh8XW9ajlk5tEDVRbeSICDW43DzDNNQwXT9l2BK2K9fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KS17N/yh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CtJOklFL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KS17N/yh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CtJOklFL"
Date: Mon, 22 Jun 2026 12:27:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782124072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s038YWIfUpBDCuiGtkkXVvM91k1d45bdU4KObnsKNTM=;
	b=KS17N/yhtGlAEzPY9GYkkf37vknNhhW/F4aOPJHWgOO5QoLg+Kdo+kjJ5n5Vdi01oQlScr
	vX7gqadVQ3DEg+5XdP94bR8t8CJNC36bS0fRSWzsFQ6sYN51nYqDbGu9eUeQX/wgUHp2CO
	8uT3cSFOtNUHxYwocsmkSsqxLsOpLtsFbGGh8XMfT9PGeZr6t6XQoVMOYfme5BoGn/RtSx
	Zrw5tX1gmbVle0UJzWlHKMLHdHM3SOTvs7gXQGS3PORnGEttpAuLeplqHsL0mdffDLw+gu
	fsgaveR8CX/gNkN4xiPB0wjhoihotdaCLGsx7nMqf02q7wl6LCFnnHt0f1bvwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782124072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s038YWIfUpBDCuiGtkkXVvM91k1d45bdU4KObnsKNTM=;
	b=CtJOklFLBivk0B4Szp5IZIQwhXTnQ6X1hJ/ZPE87NOUsHtUfJijYI+aG+93ou1PfVlhwov
	IVlTRAp3ySHzTsBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Bryan Brattlof <bb@ti.com>,
	Daniel Wagner <daniel.wagner@monom.org>,
	Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
	nobuhiro.iwamatsu.x90@mail.toshiba, pavel@nabladev.com,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH 0/4] ARM: stable backports
Message-ID: <20260622102750.RMAlQTxT@linutronix.de>
References: <20260511135357.2786242-1-bigeasy@linutronix.de>
 <20260608082818.LZiPJ9ot@linutronix.de>
 <2026060832-extortion-cattail-2467@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2026060832-extortion-cattail-2467@gregkh>

On 2026-06-08 16:12:05 [+0200], Greg KH wrote:
> We have hundreds of patches in the backlog right now, these are way down
> the list, sorry.  Hope to catch up "soon"...

No need to be sorry. Thank you (two) for doing the work.

> thanks,
> 
> greg k-h

Sebastian
