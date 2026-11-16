Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794839479;
	b=A66Km1VbwyvZjYOS+UADGZWaIGTTNhIrvBccOV87apIxFPsScrtgbPEP7JXsPbUG9f41
	 9GxqultE7tGQWvgsFI4BWE3TOrb8kJyIV5JrymNQ+tRjZYyDPyIoFj96zdw+K8xsJbAE2
	 DJ1zgVvXIkKo7oLjMjL1FwiV+J9msnvZOeeJrWnRcA8lRqgX4V29ee5DR2/fYZyqXhVHb
	 H4qlvZy0qnskLBuJlh9lwah+jnoqokNZrzb1ed7+qc/A4QFTx7B2AJzqqPyDbukkHsuj9
	 k+edKnj+MZjtfupoE55VsLgI/+q7eYLMAh6X/pESqhDjQ7Sgl08DchGHbM1fgeKEafw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794839479;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=XJlLoU6E+9fOO/EOjyE+4yhFdqoHhddsHt6doKlqKsM=;
	b=hOcqrkuO3g9WZS0n39jeT1oDSqX/Tcj2L9ZLHmuSU9SRJBe4R3lsuiBi8IRBoGowAlb2
	 dL+zEopRuhqsJmcGceE86vaVSVTdRhZ1Fc9KysfJJOaW4h7Z2UPFOmzHRYk3CWLVMOG1u
	 /R9b/pApaK/e/Kr8d031HId/2VragcTgQOnDMFy1uKp5WCMz9b53qFXlrb2lDV/isq298
	 R2rQSs3dY69FovxCYE32cK/eTB0X3lUyLLGFZqV41yhRXl0vBGG2ov3U5VF5wNO+SOdsi
	 lQZmWxGoj8bFrfxyFmSKjRWXkQ0g3Vc5V9Zm/sj8sMJ+5ieej2WNVD0yS/m1t+N4AuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=E33JlIVN;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C74606A323;
	Mon, 16 Nov 2026 14:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12C74606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=E33JlIVN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794839479; x=1826375479;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RluHToA0n2Uv7zh1LziASXx+m8ZDEfvA6K1KXGytIBg=;
  b=E33JlIVNMADpwn3y6d/bK0M5fle4RMsDmh4sM3tKx1u9vrXQwvEaP3Ov
   oAFQGTQlYVrxkQS/2ZLt7DGfnHe5Cu2cniowsagAScbADz4AxjFr/3gT+
   c2Y3ZDNt2hOKn1VqzpJX2wmwvTok+dd5b3DiuEOZ/KTlqilahxkCDLgrX
   3CZt/skPHZYr6ygbBXLi/jkS27YJkDyrpEEJv5W0Lyr+gADq7Zpw+1rPg
   PaTztswhqKLqn1eDQMsoFBeahe57N137hEXFuAlmjL/tf/u2R1lHtS0ag
   zOevtkLqRfo8CB+TZojBXscMArae3EXlCeQBthYoIiAg1EmJsANFzbvl4
   w==;
X-CSE-ConnectionGUID: IFZKNHQHTcWwDJnxKvCO2w==
X-CSE-MsgGUID: lX95pa1cSweYzXLBvPxZ8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3567372"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3567372"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 06:30:29 -0800
X-CSE-ConnectionGUID: 4QPSCljFSiuoYlVqF3lnTg==
X-CSE-MsgGUID: 2EA/vbiESXyLWrSqaU8bJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9725435"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO mdjait-mobl) ([10.245.245.190])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 06:30:27 -0800
Date: Mon, 16 Nov 2026 15:30:19 +0100
From: Mehdi Djait <mehdi.djait@linux.intel.com>
To: Michael Riesch <michael.riesch@collabora.com>
Cc: linux-media@vger.kernel.org, paul.elder@ideasonboard.com, 
	daniel@makrotopia.org, linux-rockchip@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH v1 1/2] media: rockchip: rkcif: Don't reset the hardware
 in runtime suspend
Message-ID: <avsBed-E2RPJnZ6k@mdjait-mobl>
References: <20261112183208.2688580-1-mehdi.djait@linux.intel.com>
 <20261112183208.2688580-2-mehdi.djait@linux.intel.com>
 <df61d7d2-7ad8-4b68-b3a0-7a03513ab5b7@collabora.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df61d7d2-7ad8-4b68-b3a0-7a03513ab5b7@collabora.com>

Hi Michael,

On Mon, Nov 16, 2026 at 11:58:35AM +0100, Michael Riesch wrote:
> Hi Mehdi,
> 
> On 11/12/26 19:32, Mehdi Djait wrote:
> > The reset in the runtime suspend also resets the VICAP IOMMU.
> > 
> > When the IOMMU driver accesses the IOMMU registers inside the delay window
> > between the assert and deassert, e.g. in rk_iommu_zap_lines() to shootdown
> > IOTLB entries, the system hangs.
> > 
> > Drop the reset and the now unused reset control.
> 
> I agree that the current situation is nothing more than a crude hack
> that happened to work in most cases. But I doubt simply removing the
> reset is the correct solution. Recently, I saw some downstream patch
> that makes the reset a shared one, which seems like the right thing to
> do here. What would you think about that?

Do you have a link for these patches ?

I also agree that this patch will not be the solution that will go in
but the situation needs to change.

The VICAP_GLB_CTRL register does expose this:
reset the VICAP(except MMU/AXI MASTER/REG FILE)

The Rockchip-bsp kernel exports the disable and enable functions of the
iommu driver and calls them in the rkcif driver, see:
https://github.com/rockchip-linux/kernel/blob/develop-6.1/drivers/media/platform/rockchip/cif/capture.c#L7269

--
Kind regards
Mehdi Djait
