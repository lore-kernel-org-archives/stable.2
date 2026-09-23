Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6986647FAF3;
	Wed, 23 Sep 2026 10:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790159577; cv=none; b=TQu0ICUynR7GuE5dhEJGjHLQnT7AGcMRFpEe7Q1VcA8Bc5o9CgQae8pCV2p2qUAeLNZP84kgK76OTh1RGIVznuldylCBXXGBuzuNL60Gp+IjWMnsH6PjJUKXSkriFO9QeAGnjLx6LcQzPbZZOT912VtSFJk8QLS2corF9e8IiCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790159577; c=relaxed/simple;
	bh=oNHTzgV7JKpt0LvtNzjrg8OrvNu0MI/d6ZrNFJymLPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHm3COxtmjID8I6WCZwYUAGjFOYzxYGloAz1o+BoxrxfjsIkyG+I4pSRmaorUrPQ9dFwXnfNoPmwhf0FfmO4Tygl2JslUHZFrAkS25fG4LOEt0NBSwQ2CLHw67EzBWn//r1dmn2m8g9MaKLxanHQSBpSO9DIgEuzpjUbEgOqdsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hrDrpkwv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NAQh6+ab; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hrDrpkwv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NAQh6+ab"
Date: Wed, 23 Sep 2026 12:32:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790159559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vZuQXlZdXPnXthUCF5TkgqX+BY9utsNp8eBeJtmM0jU=;
	b=hrDrpkwv4CaTpvpRKJFHddvQxtd/CvRmB0E05rpUU6KE41KYEK20usDKvEVyZLdmz5AHWK
	vLxh/eJqGAZXo5FbjQtmO4M/geoDpQKWRJ4ZRTK7H8UAJFGNh/3EkY1DNo7eZAaGqZ1KaR
	rGkZCbP26d2brM+6w6mG/TiPZV+L4ZYYkqGTALxBlrtv4ZMQXaK3cDecwKTc1PwMHC6swF
	O3QT7z1f2tF1hOV8ahE0JYOuPbcjVm+DFn99+28Uw2UzqHcFqE4gRY11XhwzIPAaLNZOS0
	RzjafNNqto0hIoW3pJTBIASWFVsa1Luw9HIZUeUdTBt4mUdR4NRwl2E2fFTfcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790159559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vZuQXlZdXPnXthUCF5TkgqX+BY9utsNp8eBeJtmM0jU=;
	b=NAQh6+ab/cNNTx3eDnm4YfWSZ8Od+zegTbJQvvyHPhOTnmAffJq4LrCVMFPHxw1oAndhTQ
	xb2RRRkVu/CMoxDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Xin Xie <xiexinet@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, andrew+netdev@lunn.ch, shuah@kernel.org,
	kees@kernel.org, petr.wozniak@gmail.com, qingfang.deng@linux.dev,
	fmaurer@redhat.com, luka.gejak@linux.dev, xiaoliang.yang_1@nxp.com,
	skhawaja@google.com, liuhangbin@gmail.com, stable@vger.kernel.org,
	sdf.kernel@gmail.com
Subject: Re: [PATCH 1/4] net: hsr: fix packet drops caused by GRO superpackets
Message-ID: <20260923103238.cg3tr_40@linutronix.de>
References: <20260809121455.1745-1-xiexinet@gmail.com>
 <20260809121455.1745-2-xiexinet@gmail.com>
 <20260813182111.088aee3d@kernel.org>
 <7c09a44a-19d9-43f5-a852-12f5b6579641@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7c09a44a-19d9-43f5-a852-12f5b6579641@gmail.com>

On 2026-09-19 01:46:34 [+0200], Xin Xie wrote:
> On 14/08/2026 03:21, Jakub Kicinski wrote:
> > 1) could you explain in more detail why GRO is breaking things?
> > GRO shouldn't merge packets with different L2/L2.5 and packets
> > with trailers?
> The reproducer is plain SAN traffic entering a PRP RedBox's
> interlink: matching Ethernet headers, no RCT yet, so GRO can merge it.
> PRP then appends one RCT to the aggregate, using its length for
> LSDU_size and assigning one sequence number. If the aggregate LSDU
> exceeds 4095, the 12-bit field truncates it. Later TCP segmentation
> cannot generate per-segment RCTs. An aggregate left unsegmented may
> instead be dropped for exceeding the lower device's frame-size limit.
> Our wire captures showed segments without RCTs and duplicate delivery
> through the two LANs.Disabling interlink GRO raised single-stream TCP 
> throughput from 27-37 Mbit/s to about 94 Mbit/s on the 100 Mbit/s rig.
> 
> > 2) the code seems inspired by LRO but LRO also has
> > NETIF_F_UPPER_DISABLES. This change looks rather incomplete.
> > Calling it "best effort" seems like an excuse.
> NETIF_F_UPPER_DISABLES prevents a lower's ethtool request from
> overriding an upper's LRO-off policy. GRO is outside that mask and
> remains changeable; extending the global mask would affect other
> stacked devices too. Patch 1 sets the GRO-off default, while patch 3
> segments plain, trailer-free aggregates before tagging, including
> when GRO is re-enabled or GSO arrives directly. GRO_HW can also be
> fixed on, so feature disabling alone cannot exclude all aggregates;
> device-specific hardware-coalesced formats remain outside v6's
> segmentation guarantee. I should have explained this distinction
> from LRO explicitly.

Would adding a NETIF_F_HSR_SLAVE flag to slave device(s) and then filter
invalid flags in netdev_fix_features() fix this? This should help
against enabling and add a warning if a flag can not be removed.

A netdev_change_features() might do the job then.

Sebastian
