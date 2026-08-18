Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A101DED5C;
	Tue, 18 Aug 2026 06:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787033980; cv=none; b=UCYyUe0JeX4Qv9U/ug8NcPGMis62L2OZ8cQ/QBSdsqv+s2zBinsSj0MfQHeR7M8CokxxH7gWXM66WRpH5DolC7X0DPwjNfLwtgxwM6StAnLapf91pUmhU/XzPfhtLxShtMqr3CrcHqZqoGETxWEtxbjhL2muajIfkzwsBby7jG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787033980; c=relaxed/simple;
	bh=nsNY88etWZbJyWM+AugejWA/5xf1KAag4dQxaNnDAkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilcrApN9M4R6d+p1C1Jj3zkzrRDswuUIo00nEdKKV/Q9kGwIGzy6N9OPixOxgQ4KNzWGLy0lfPPXZklaoDjrg7PDUsFaxdCIxwnLQLO1k8HpzSYCw/1V7WuaOyr7IQPz8ntq25xl3lsphESb3103Y45p1cGq64KCrieR1UXVJQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NcvcYfKJ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NcvcYfKJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787033979; x=1818569979;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nsNY88etWZbJyWM+AugejWA/5xf1KAag4dQxaNnDAkw=;
  b=NcvcYfKJvzSeO55E26WAFdMICqd/VLAaA57TlSGtHiK+C7suuQVOvmJE
   HXZ5ddS/XfvWiL9XOYpY1SQ3e9c8uQj1T52w+OM4ME3Kam4l9EMCDGPCi
   6hMS+pgSoQCVL9wEFduSIEYSwcwt7kHA5DbvK/i+j4N7nXkmfXuVNyWDp
   HBc5Gd07oB1Yu5p3LvnQKeFckp+qjkVJd+GHI/ECk/Ce5ber+q8pE6iju
   ECd50p9ICLTkh5iAzkKNWWnIRGB0EUerDHV2sPQN5lOTZjVv/lW5xdOU5
   HYGGpo9a6HkMx+WNG6xIx1JkkniTTvv52zdrwsqC8S73avDsopor/cjyA
   Q==;
X-CSE-ConnectionGUID: treaO2lIShG11I72Yg2jFQ==
X-CSE-MsgGUID: //HsH7ALTPWHeaEWhQIXwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87532693"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="87532693"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 23:19:38 -0700
X-CSE-ConnectionGUID: qOLhjh8NRq2nb/Ql8lh6hA==
X-CSE-MsgGUID: 4tgv/tYoTqO2HcB/imOs3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="267095741"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa004.fm.intel.com with ESMTP; 17 Aug 2026 23:19:36 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id A3B7399; Tue, 18 Aug 2026 08:19:35 +0200 (CEST)
Date: Tue, 18 Aug 2026 08:19:35 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Sven Peter <sven@kernel.org>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>, asahi@lists.linux.dev,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Konrad Dybcio <konradybcio@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 1/5] thunderbolt: Fix tunnel reference leak when the DPRX
 work is not started
Message-ID: <20260818061935.GX893316@black.igk.intel.com>
References: <20260817-b4-tbt-fixes-v1-0-eded2461f5fc@kernel.org>
 <20260817-b4-tbt-fixes-v1-1-eded2461f5fc@kernel.org>
 <20260818044232.GS893316@black.igk.intel.com>
 <b9100abf-b284-4e56-a4e7-9dfbf96734a8@kernel.org>
 <20260818060044.GT893316@black.igk.intel.com>
 <da48977c-071f-4671-8f19-e22d14aa3105@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <da48977c-071f-4671-8f19-e22d14aa3105@kernel.org>

Hi,

On Tue, Aug 18, 2026 at 08:11:09AM +0200, Sven Peter wrote:
> Hi,
> 
> On 8/18/26 08:00, Mika Westerberg wrote:
> > Hi,
> > 
> > On Tue, Aug 18, 2026 at 07:44:35AM +0200, Sven Peter wrote:
> > > Hi,
> > > 
> > > On 8/18/26 06:42, Mika Westerberg wrote:
> > > > Hi,
> > > > 
> > > > On Mon, Aug 17, 2026 at 09:53:58PM +0200, Sven Peter wrote:
> > > > > tb_dp_dprx_start always takes a tunnel reference which is only dropped
> > > > > by dprx_work eventually. Tunnels that have no callback don't ever queue
> > > > > that work and tb_dp_dprx_stop then has nothing to cancel. It however only
> > > > > releases the reference if cancel_delayed_work returned true and the
> > > > > reference is leaked then.
> > > > Okay but we always actually pass that callback there so I guess you are
> > > > hitting this because you have modified the caller in tb.c not to pass the
> > > > callback, right? If that's the case then I suggest mention how you actually
> > > > reproduced this whole issue.
> > > > 
> > > > I'm thinking we should make the callback mandatory instead as we always
> > > > need it for DP tunnels anyway. It should work the same also in Apple
> > > > silicon (one you have the DP tunneling in place).
> > > As mentioned a few lines below,
> > > > ---
> > > > I didn't actually hit this on hardware but found it while fixing a domain
> > > > leak in the same area and that fix depends on this one.
> > > > ---
> > Hehe, sorry missed that one.
> 
> No worries, maybe I should've put it into the commit message and/or cover
> letter as well!
> > 
> > > ^-- there, I didn't actually hit this. It's just that there's also a
> > > tb_domain leak here (see patch 3) and when fixing that one the asymmetry
> > > here just jumps out. There's nothing special my code does to tb.c , the only
> > > reason DP tunnels don't work yet is because they need two separate MMIO
> > > blocks (what macOS calls "DP IN PHY" and "display crossbar") and possibly
> > > also the display co-processor to be up. Once that's done they should come up
> > > normally.
> > > 
> > > Tunnels discovered in tb_tunnel_discover_dp setup a DP tunnel with callback
> > > = NULL but also never start the dptx_work there and I'm not familiar enough
> > > with the code to know if it's possible to ever have those end up in the
> > > "normal" paths which queue the dprx_work then.
> > > I'm happy to also just make the callback mandatory though and just bail if
> > > it's not set.
> > For the discovery (happens when the boot firmware/kexec sets up the
> > tunnels) DPRX negotiation is already done so we never need to do that for
> > those. I think it simplifies this if we just make it mandatory.
> 
> Okay, great, I'll look into making it mandatory for v2 then.
> 
> > 
> > BTW, is this bringup stuff available somewhere already? I have M1 Mac here
> > so perhaps I can at least help testing things (assuming setting these up is
> > not super complex).
> 
> Sure, the current WIP code is in
> https://github.com/AsahiLinux/linux/commits/tbt-reset-wip/.

Cool! Thanks for sharing.

> It's not quite in a good shape yet and I have a few improvements in my local
> tree that I can push this evening after $work. Right now only XDomain works
> since pcie, dp and usb3 tunnels need more bringup work and not all cables
> work because I'm not forwarding the information like Apple's NHI expects
> them just yet.

Understood.
