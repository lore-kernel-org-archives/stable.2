Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794229487;
	b=oi9D0T0xDycswdzWvrayolnMXKKGZBdPgryAmXk3HRYu2kywq3cNFo5gp0uw+vJlWM2g
	 Q8RqGG9CRyu4bw2MBLPo95RtMdUB6UEcxvnl0dcowr3OFcCiq9ePm96D1G80XMotsaoxd
	 1MSeWLwfUkhns0cpFt5m46ifUi+sHrwKTATxqPw8q4uj5V3EapkdAEA3KBIZrxQc2qTqY
	 z4S6pf5odZefPQNKK70kVIf/Z5DdtcAKUk+efXIyOnmNwLZbFjqvV4obqqKM86mf1C+QV
	 Sv58RGsqc9QR1dw2uNsAYShl4IdMF3zVSX4SsQ0yzc3klt7JVB4tO3q+tfoPcQexcEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794229487;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:
	 Organization:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=gD6KUHhyIA5CrSJ0UjiC2lxpJrn69wljFAN5WODknBw=;
	b=DcsROpft5JZrqDYxmTaWdHuAjh1GzH8+qKwR1b/IL2SF3XFg5UbzlVLgzqXAQbicR+lG
	 eOaeyFD4ZAus9j7subl1a05g/P6SQnLZYJ13Fp5IREJoir7E7pbZN8dDcRMaYjVJ8ZIGt
	 +xd9M9ySGLoqzhP+j8wJ47q4RaTJDnDqbx76aQTqTgO6MYJAtob65W/uPTQOp4RsAwQFt
	 vaaEnWRI/WLvmK9ssL2++MRYooURFqw18wInCfF6Gcj35wLfcmiuMvKygoRP7ErMU8IqD
	 EiBRparkrdM4S8nKCVj39i4klFo47PC514T7YqATOHLbpnU0yRBkW8CvNixWSVAF0hA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fNS0BU+Y;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDED606A321;
	Mon,  9 Nov 2026 13:04:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BDED606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fNS0BU+Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794229487; x=1825765487;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M1DootRtlh3ognG0Iqi7B+WiKIFAdgGqBDEVSjzm7IY=;
  b=fNS0BU+YrEGM0QPFpfEdf7QlEMJ2mTZLCai6PT8gcayTjiuENpE9T1vU
   ZxkCXmD4Uh24bRd3p49ggHMW0lF8e8aZaQPYHAkB9QFIHGodxcnyTXi0t
   OhuoEJbdk2XfbLMil6tqiVbDeVlxEQw8UjKiFY8ldKA3LOxI7JsE6p9Qt
   NETup2kOD1GXvTY7894oyFQZFSSe1f/wKRZfIcMVFzp9oZxSmt8YLVqKN
   ZOdLLbUIzAqCwgwx6rqftMDNNzp6AxVM3ytzJPhr0bIojBoyHi1Oi0IzS
   OkBL7MLsS0SsWMpwafbjr7LZx1ZK0ZMwNnXqbn+tRt0dJleWlX/cQNpZi
   A==;
X-CSE-ConnectionGUID: YvUmP/6DS96E6YxtUN7H/g==
X-CSE-MsgGUID: cQ255Kx/QgSL4wJ9emXKng==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2843079"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2843079"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 05:04:46 -0800
X-CSE-ConnectionGUID: ZG/e5ppCQBmbif2Hmxrg9g==
X-CSE-MsgGUID: wTaiDj0SRV2IAM2bDD5Njg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="7682486"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.119])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 05:04:43 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 6486E121B96;
	Mon, 09 Nov 2026 15:04:40 +0200 (EET)
Date: Mon, 9 Nov 2026 15:04:40 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Charles Drolet <linux@cdrolet.dev>
Cc: devnull+b.danias.tutamail.com@kernel.org, b.danias@tutamail.com,
	bod@kernel.org, hansg@kernel.org, kieran.bingham@ideasonboard.com,
	laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, mchehab@kernel.org, rfoss@kernel.org,
	serin.yeh@intel.com, stable@vger.kernel.org
Subject: Re: [PATCH 2/3] media: i2c: ov8856: Enable runtime PM before
 registering the sub-device
Message-ID: <avHE6Mht9eaOrxMJ@kekkonen.localdomain>
References: <20261104-ov8856-pm-fixes-v1-2-1958b730ce66@tutamail.com>
 <20261108234557.12874-1-linux@cdrolet.dev>
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
In-Reply-To: <20261108234557.12874-1-linux@cdrolet.dev>

Hi Charles,

On Sun, Nov 08, 2026 at 06:45:57PM -0500, Charles Drolet wrote:
> This issue occurred on my Dell Latitude 7320 Detachable about one in four
> times I rebooted. After applying this patch, it didn't recur during 10
> reboots. I also ran a very similar patch for a couple of weeks without
> seeing the issue.

I've thought this was only a theoretical issue, while we've been fixing
these it's the first time I've actually heard someone has hit this. Thanks
for testing!

> 
> Tested on Ubuntu 26.04.1 with Linux 7.4-rc1 and a patch for TPS68470
> board data. BIOS: 1.48
> 
> Tested-by: Charles Drolet <linux@cdrolet.dev>

-- 
Kind regards,

Sakari Ailus
