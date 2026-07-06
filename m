Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161C5380FEB;
	Mon,  6 Jul 2026 15:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783350356; cv=none; b=NNFcA2QgHQwEAV5PqbSlgoIlbbi/FNdPlg1QPpt0j7IDZZ65C2feFM6UaRnV5qi7MJXGUKVfPCA9jN1spofaN6ozFj1sRdRkmthR5UKo4atdWMeZgyzg5uuJ3ylZDO6Mym6x0H9ppQFsF+2PB9kPC1lLhFlAnZl31iAkadmSitI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783350356; c=relaxed/simple;
	bh=3yi8neAEE9rEq0mxmjpaiKYd96ZV5xiHUgR7phnh+HY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hYM/DW9RSycYeJlFYD8ppb84oLsdsuhw8D9niByrc7Owp90mLOfJM64am8Si85j2ICrdAlwgz0Dh+ggiNnE5c3EpGFnaqB9xx9TRMRQN7b0ZOyPMBZfatdGWzbyUv6QVTR1L/Ke6vcWsxR6AO4PK4zFTApUbW/a2Tp9m1xJSnYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VTBiBrwE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P9d7GLAb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VTBiBrwE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P9d7GLAb"
Date: Mon, 6 Jul 2026 17:05:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783350353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NB9C1tjmGRHLySf+l2Zt8ileBtf+TYUJy39INOr86Rg=;
	b=VTBiBrwEo17Mp0HQTuYwb3bfzd/zrFr8t8ZTDKDypENitm0+Tnkk2+H68X4nS0AayUt6HM
	zxCU0OHI8K1adKE2YYCFU5nJdq3/Sl1nH1nw9pd5xwiFndFn3hhg/AGZu/1ftTLRmTVfMK
	bd46WKl2tO4PyLyDznw4dUxapNUGv9Y/1NHNDGcEgOSp8DcAvTHmXD3Qw0v+iD+Lfv5CuK
	SE3yVClhbRdjccY12f5szI5t+OE8fEc/4fk7povRHWvuphZ7x35kgVb/R59ZmswD2eJgWP
	yqJD4h9T1WdoNY26uR0LRwgmlzamqE5Gb3U7jPzq1hFTxVqX+gRDN+Nbk9QKfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783350353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NB9C1tjmGRHLySf+l2Zt8ileBtf+TYUJy39INOr86Rg=;
	b=P9d7GLAbFTnLUHFuMicc7kn2osB9FQ+NuT3a7SjkC6F/47wbb8306piJiBgy8MPLHY9rIJ
	kk/YwkP3tYClXWDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: christian.taedcke@weidmueller.com
Cc: christian.taedcke-oss@weidmueller.com,
	=?utf-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kevin Hao <haokexin@gmail.com>, Simon Horman <horms@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Robert Hancock <robert.hancock@calian.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: macb: mask TXUBR during TX NAPI poll to
 prevent IRQ storms
Message-ID: <20260706150552.EomovsBn@linutronix.de>
References: <20260706-upstreaming-macb-irq-storm-v1-0-ab3115b5a13a@weidmueller.com>
 <20260706-upstreaming-macb-irq-storm-v1-2-ab3115b5a13a@weidmueller.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260706-upstreaming-macb-irq-storm-v1-2-ab3115b5a13a@weidmueller.com>

On 2026-07-06 16:02:15 [+0200], Christian Taedcke via B4 Relay wrote:
> From: Christian Taedcke <christian.taedcke@weidmueller.com>
> 
> macb_interrupt() defers TX completion handling to NAPI, but when it
> schedules the poll it only masks TCOMP, even though TXUBR is enabled
> alongside it (both are part of MACB_TX_INT_FLAGS). macb_tx_poll() is
> asymmetric in the same way and only re-enables TCOMP. TXUBR is thus
> left unmasked while responsibility for handling it has been deferred
> to NAPI.

So this is not a race condition, this is always a failure?

Sebastian
