Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7753320125F;
	Tue, 18 Aug 2026 06:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787032850; cv=none; b=Rw4tMNAuGYssK4u1hN18F8gGDoyXEnBIW9/AsYpaLcuaJPfU0xIGh/0EDAcu/zclh5jLWtpYX8mvumT6sgHeHM4jWFMXsctXJ/bMSeLb2jIgmr91t5gxHhERrrP0ufi5tJkYNtx5a1j+r9hQR0sGXMqohSy97Uuaq+1d5tqFvfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787032850; c=relaxed/simple;
	bh=+cXZ0FpmHhcKsrJEyZoUFWUHKywMp8sR4JiIH0Muxy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KlzMYlq8RQutkZudz4WnhggQZTEjzYEFGxh+VOVJwXpwKfeR37K/4qpNcgq/SrmdQcSMA0WNGplPtLDC524/nORihLiSd52AuXsmCopex8K+CjSrOhTL+2VvQLasCVTerRAfIrLrupaXYeL8Ef84gvmNj4FIaES5I/KeYsYSuf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TP1H/D/y; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TP1H/D/y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787032848; x=1818568848;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+cXZ0FpmHhcKsrJEyZoUFWUHKywMp8sR4JiIH0Muxy4=;
  b=TP1H/D/ygoGwbkSl8DvQgTW7/J/J5E4dPkqSRsEJtAXr1WGzZencLHUV
   +29b7ibvRpMGvwgoLBou7Ho/+4u+wKde/E5sHTa54+g3sZC6y42oTXQ9s
   cjuXPezOirxNOL1wZa1SS/RFBLpZzexUsPpCvLV4ee5JboiSDoM9MTDBN
   cs21i2vbUBvRJCzPZX0TMqA/WzfKEaYGCKZ1MQN9PVOCIQXfoniVv4sE4
   k3TW74s9l2sPrszOf3aJP3267+qh0KOwpuAdqsTzIit2pvHWh1HYSyVqz
   C9HrhZ97EpuFH7cHeWXy+sn9j5EfNTtwcRDiJd+5iQXfsVnxXb+NIK/nO
   w==;
X-CSE-ConnectionGUID: DbB3wiysQ1qvoERHo0gagA==
X-CSE-MsgGUID: nUA/zDaIQL2WX8TddsRecA==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="97852408"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="97852408"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 23:00:47 -0700
X-CSE-ConnectionGUID: tGshTIw1ROGZa0dEfYH5jA==
X-CSE-MsgGUID: BVpIiZuLRB6xL2XJ1tKfAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="303357934"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa001.jf.intel.com with ESMTP; 17 Aug 2026 23:00:45 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 0778B99; Tue, 18 Aug 2026 08:00:44 +0200 (CEST)
Date: Tue, 18 Aug 2026 08:00:44 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Sven Peter <sven@kernel.org>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>, asahi@lists.linux.dev,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Konrad Dybcio <konradybcio@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 1/5] thunderbolt: Fix tunnel reference leak when the DPRX
 work is not started
Message-ID: <20260818060044.GT893316@black.igk.intel.com>
References: <20260817-b4-tbt-fixes-v1-0-eded2461f5fc@kernel.org>
 <20260817-b4-tbt-fixes-v1-1-eded2461f5fc@kernel.org>
 <20260818044232.GS893316@black.igk.intel.com>
 <b9100abf-b284-4e56-a4e7-9dfbf96734a8@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b9100abf-b284-4e56-a4e7-9dfbf96734a8@kernel.org>

Hi,

On Tue, Aug 18, 2026 at 07:44:35AM +0200, Sven Peter wrote:
> 
> Hi,
> 
> On 8/18/26 06:42, Mika Westerberg wrote:
> > Hi,
> > 
> > On Mon, Aug 17, 2026 at 09:53:58PM +0200, Sven Peter wrote:
> > > tb_dp_dprx_start always takes a tunnel reference which is only dropped
> > > by dprx_work eventually. Tunnels that have no callback don't ever queue
> > > that work and tb_dp_dprx_stop then has nothing to cancel. It however only
> > > releases the reference if cancel_delayed_work returned true and the
> > > reference is leaked then.
> > Okay but we always actually pass that callback there so I guess you are
> > hitting this because you have modified the caller in tb.c not to pass the
> > callback, right? If that's the case then I suggest mention how you actually
> > reproduced this whole issue.
> > 
> > I'm thinking we should make the callback mandatory instead as we always
> > need it for DP tunnels anyway. It should work the same also in Apple
> > silicon (one you have the DP tunneling in place).
> 
> As mentioned a few lines below,
> > ---
> > I didn't actually hit this on hardware but found it while fixing a domain
> > leak in the same area and that fix depends on this one.
> > ---

Hehe, sorry missed that one.

> ^-- there, I didn't actually hit this. It's just that there's also a
> tb_domain leak here (see patch 3) and when fixing that one the asymmetry
> here just jumps out. There's nothing special my code does to tb.c , the only
> reason DP tunnels don't work yet is because they need two separate MMIO
> blocks (what macOS calls "DP IN PHY" and "display crossbar") and possibly
> also the display co-processor to be up. Once that's done they should come up
> normally.
>
> Tunnels discovered in tb_tunnel_discover_dp setup a DP tunnel with callback
> = NULL but also never start the dptx_work there and I'm not familiar enough
> with the code to know if it's possible to ever have those end up in the
> "normal" paths which queue the dprx_work then.
> I'm happy to also just make the callback mandatory though and just bail if
> it's not set.

For the discovery (happens when the boot firmware/kexec sets up the
tunnels) DPRX negotiation is already done so we never need to do that for
those. I think it simplifies this if we just make it mandatory.

BTW, is this bringup stuff available somewhere already? I have M1 Mac here
so perhaps I can at least help testing things (assuming setting these up is
not super complex).
