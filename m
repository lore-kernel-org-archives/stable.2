Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794281600;
	b=D3J5kkGCz1HM6diWKJ6S3iwXMGBGB+CFf1RB8q+cHU7r0SYqVd9qRfg92tTz0QpxV4Aa
	 PJT6GkGqSjBc+BRnLxwe58KCaAR+nZAGOcbyY5L9kyUXzNxPIsKRUqUBf0C5vdL93e426
	 KHSlk9+JSt6douwNtE3E4ZpSG9faO0JO4zQxTWzCk2cGWibgjF8RD1fB3dpit+zy+OvH4
	 Gn57Fsn0eOuXNCZ8sDhoAbtq+wQMJrq/b9xpfv2UBcEo2IkgPcHtYT+EjGLzVONTjdfA2
	 YJAM11fhqF9sRcNZ8FRPujr6iYM9rnuizd3ppChIVeo62yVOHlOej4qIJ6Y3EKAa3iQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794281600;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent;
	bh=kfbmkjBdoEh5ewRFInba/TAV+0T3Coi2aeXdNdpvI28=;
	b=TdyPtWWmHOjbxRmbxuFBF6/hBcQqZu3oV0//XoXaP0qH/S66Oenkq3hylPWdCYbHokIL
	 iTnV5KUh9A1mcUr+/4KbF6ujsDlfvozyp/Ayuw+7V3aw7nC8eWrkkP+HB+vbcvGb7uiry
	 M4Xlvglsw40z8P1Th19tBpUAvCe8S7c1VLYttVO1r9Wyou6yswQycwMcs0uVN2lfqm+L9
	 cOKI7mag1ymgUsU9fn6nOtYSa+K1LvwYcJIZWHENapjs5u4Ut9oX/aeW5IX246ENB4Klw
	 IEt4iGwTRG+8eLcKSH4CTYgBFM+gN+hcgias5okgMULSHBTHe6PIZOvm2LdHZoL5Vng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=A6mT2Fmh;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926C3606A32A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 03:33:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 926C3606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=A6mT2Fmh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794281600; x=1825817600;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p9CZmrCNUuAvo1LP2e4mt5qxrYlLdgtlb4R21F8Stj0=;
  b=A6mT2FmhTtIv5SQof+DupuVBpe3BinONR3ahxL+OQbsDkJlYWBOgmTYr
   Av+HAnrZ3NLvuZNh5ICSedJq7FVISzClqM7dR1DfiBJ01aUBfZTVbtP3+
   f/NIARqIzL1CexrCOe74SGvwF1kaVCpFCarMGkerWczwdB19wG24FigH5
   iX2UlU29VFHI0JFA7m5GFJj1d5O4V/gEHFiUQTIrVCGq41v03WocSMGU1
   RiuE4W+amf3/DHfbD+SvvToxxB8BX2Xohs4v37YzkUlO+gLeTv57zAdRh
   lmQZ54oSpHwEpVuWSdXCmoLwizcMkEurtR1D73eiacc/t8j5rpQxwhZi8
   Q==;
X-CSE-ConnectionGUID: knuyhEIcSjy7PAuJffKy7g==
X-CSE-MsgGUID: uJyLFtHUTgCw3Zxp7sRt8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2898407"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="2898407"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 19:33:19 -0800
X-CSE-ConnectionGUID: lF+OxWekQYePcC31GPV2zg==
X-CSE-MsgGUID: 5miIn7VGSP+nkuG7Y9VD6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="8362544"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 19:33:19 -0800
Date: Mon, 9 Nov 2026 19:41:24 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Ximing Zhang <xzhangjr@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] hwmon: (coretemp) Return -ENODATA for
 invalid temperature readings" failed to apply to 6.6-stable tree
Message-ID: <20261110034124.GB26452@ranerica-svr.sc.intel.com>
References: <20261107053626-failed-6.6-f63aaa529cbc@kernel.org>
 <20261107155229.30955-1-xzhangjr@gmail.com>
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
In-Reply-To: <20261107155229.30955-1-xzhangjr@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Sat, Nov 07, 2026 at 07:52:29PM +0400, Ximing Zhang wrote:
> Hi Ricardo,
> 
> I'm considering preparing a 6.6.y backport of this fix, including checking
> its prerequisites and coverage in newer stable trees. Are you already
> working on these backports?

Hi Ximing,

I am not currently working on a backport of this patch. So you
can take over if you so wish.

Best,
Ricardo
