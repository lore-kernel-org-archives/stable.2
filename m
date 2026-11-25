Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795592672;
	b=gt+AW2GZ1K0uk6FjnO6bcXAWqhgspSUdfyXN1Bc5XAVewsqYmiCdIItuiR3zdO85uCzs
	 QWgJMYxDCi3bd/lPpIU67pjqDrRHS29as0xwS7ELlaWbXD1eBaeEmiJeN3rnMbsuS7esW
	 bG0/xVX8VUeO0s3B6o0VIQd9oOzftwTB24Qyi4ft3pzwsUwLFs5U4hu4JHbnhsuzLZtP6
	 e2C1Eg9MVbpxXiKY49tUrNxhJcQH3zuDUNjyfiwF6WrQrpPQL4Tr0PP1GNzh6JMv6NPMd
	 ux5LNCnn516OxNNH+rp/BVUfjDUnd7dzBWbb6em80K9TcnTONv0MyeP8+zuejOOCAYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795592672;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=vnz5Nky15Lyd/J+B0zjHTXxMyYh0lgT65b7QeGlPThQ=;
	b=uR76jdRdRDLUx+rfhRbPxjmsBBcypIkrp3tQRGmjqka9ukWWj20LOdS0ilt8dhSuZmHE
	 lLJ6PcFwlWJN66ILtmrA65Et8Ps15hGEwZbG+/lQS0C5kzxWsMaBq9IcjciTDQSCYQPeb
	 /2wt0ZT+MHBAdks/KalarRhLJ4z+pfy23vxf6S9xdHOgE8IUy4BlMH6YfKS+WV6zhAXPN
	 KF5X65O7llvvG0FsS2iNjrl8Md2FpUK5+IhwMQ57Dim/1FOf+fi16g14DqTuBKGSgEktO
	 ww0rVNtuGEu/cjVc/UvK2Li6q4Dk2gISkIxcXBPJinih0iQv5sNItTosKrhUKwxAGOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MOnbzhhK;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F101E606A323;
	Wed, 25 Nov 2026 07:44:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F101E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MOnbzhhK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795592672; x=1827128672;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UXNO/LZ09Iyfnm+ymAlG4P2a1RxXacGQZKc0ObM/XnY=;
  b=MOnbzhhKXnmW7rN6Fk2NNqiJT7EqEiQjmKtuXxJVASE6KaeBOC44vI7E
   LgnwCW3qBAph1r+snGwm0VZzXM9oJGbAP5vDUiNdAaUTJygtl71xXJH7G
   d6iswfZ391LoGArsgTtym8SYdx0ns7rv/3Vl/TtZBnozt0PZaMSknVSqN
   hsBMH0jiwnABo6I1xHa0PId3kMmqe+lUXATJnf7HJqbMjyUmACZVAXb0g
   PgRzQegoTkTux4SAobRnVN9c5JfyTMtQlD4YS4VcetvuatN99ODKW58ys
   wasVOOU+UfVCyT4JcfQ/4H06snUFh0m6ZvKhhvBcSbWeXt4VqsbsqYkto
   Q==;
X-CSE-ConnectionGUID: WPsemKGaSNGAC3nkg+oizw==
X-CSE-MsgGUID: SmHKv3ogQk+PFbfUwCzzfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4435635"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4435635"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 23:44:31 -0800
X-CSE-ConnectionGUID: s9w+15noRw2HjH59TOL58Q==
X-CSE-MsgGUID: Vm+NhJ+AT8CeiUU1ZefKkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="11906096"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa001.jf.intel.com with ESMTP; 24 Nov 2026 23:44:30 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 9D38498; Wed, 25 Nov 2026 08:44:28 +0100 (CET)
Date: Wed, 25 Nov 2026 08:44:28 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Alfonso Villalobos <alfonsocvu@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, westeri@kernel.org,
	linux-usb@vger.kernel.org, andreas.noever@gmail.com,
	YehezkelShB@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: Re-add host router DP IN adapters after
 DPRX failure
Message-ID: <20261125074428.GB191152@black.igk.intel.com>
References: <20261121070804.26185-1-alfonsocvu@gmail.com>
 <sashiko-outbox-226770@kernel.org>
 <CAJ=mrFowQNahOjD-NQzcuJCjPE=efvDK85kMpseRUrqYBwX3Sw@mail.gmail.com>
 <20261123054042.GL229695@black.igk.intel.com>
 <CAJ=mrFqe1ujyq5oX==HQ8MsBRNb_64dPZz7aHg5LYBYtKVOGvg@mail.gmail.com>
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
In-Reply-To: <CAJ=mrFqe1ujyq5oX==HQ8MsBRNb_64dPZz7aHg5LYBYtKVOGvg@mail.gmail.com>

Hi,

On Tue, Nov 24, 2026 at 07:22:37PM -0600, Alfonso Villalobos wrote:
> Thanks for the details.
> 
> > Does the RX 9070 driver poll for a new connections periodically like the
> > i915/xe or it supports PME?
> 
> It doesn't poll. When I looked into adding it, the GPU had no way to
> check the connectors without taking the core out of suspend. After a
> wake it stays on for about 5s, so polling every 10s would eat most of
> the savings BACO is supposed to give. I haven't actually measured it.
> 
> The card does support PME, but in my testing a hotplug on the TB side
> doesn't wake it up. From the amdgpu code, PME seems to be used for the
> audio function and only while the card is active.
> 
> So I think the problem has two parts. On the GPU side, PME wake on DP
> hotplug looks like a firmware limitation. I'll share my findings with
> AMD and see what can be done there, but I'm not sure how much I can do
> from here. On the TB side, the host router never sent a new hotplug
> for 0:10 after the DPRX failure, so I still think the patch is useful.

It should send hotplug when the domain is resumed and the host router is
re-enumerated. However, that requires the domain actually be runtime
suspended as well. In this case I think setting dprx_timeout=-1 or
something like that works it around at least.

What we could do to improve this is that we put the DP IN to "penalty" list
then once we get new DP OUT hotplug/unplug we prioritize the DP INs that
are available but if there are no available ones we take one from that list
then or so. Note this needs to work with DP INs on any router not just the
host router.
