Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793014694;
	b=uXckSiWe5wcmR/xsJxe3syhxoz/QfknAj27BYmLauwrWmKYD34mOFiwr6xBP23N+93Kv
	 dvzHdndjpIhyxf9hhnFL1/tKVKVHjYpXh18dcyzO0v3nCDVarzGZeQ158ivwca0DpH9g9
	 64fB3OQ+ezj//MvA1Z122XB/92+6QjmTlJDJvpMqNXL7nbB1A+TK62BJDH4Vo70NQoeLu
	 A5nVU0tLWYKvf0Le0FLrElrZj7LzFScpgJuJ9M7jrjSHQpRTXAe/Wlc8HJyHDkv5IWB4d
	 zM6FqrpqxsK1MANtQBDevWArqZWjuiiPeSTv22QKxdphFA1zMSPNZwII2x8kVRi1f9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793014694;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:
	 Organization:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=mtbkHLyLx7LcOh+A7KslU4wawsJM8dxmmN1AIFQt2H0=;
	b=dzPjWIw1cW/IuiyWx37ln+7yPWDrzODz+WK+2WYQ+pIagEORj/LmDHWUNPpYjt2uCfmZ
	 9Wpc1nLY6MSEis6xrmEJx/Y3mm1A/CLBfqEhE+Dmy9v5mDm7bKswwVmGhTMKfmfr7swZA
	 ksl/GMyj+8LbCDV09DCRxSYcmGnWvC1OJ8+S8OUO1LLnf3V3rpkOhFyhRJrh4c9fBpiir
	 vaRbfEPmqkw+NWR+3ynoTb9iiry/dMOOWt4ut5N22F2YbHP506XAcqZf2j960EHB5F223
	 Q2Y1fvjxRrgax2iLThPDkRGClUZbGjw+//Y+9FIelEItK3YmZMlWRxMpZpHsugmyGXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mdm8DdGQ;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F55606A31B;
	Mon, 26 Oct 2026 11:38:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1F55606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mdm8DdGQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793014693; x=1824550693;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IMx7894hdT3mSGNRtWtt4HOo96/VimL3nvLTtuMGKiE=;
  b=mdm8DdGQoEtrYgSoA0KrH77da2jKcmnOQTpU0k0R9xRUnn+3YnheLnzy
   Ad4YvKmPqOKzEX06dLvJDNHbe7USwDKFXJPnIRRYcbs7xKn9WbmsXFddZ
   FxNZb0Ba87sxYAN4Ucpd8anfuLFMcTCT1yELB5DKJY5KDyiOGXALczHxM
   wQyFu7OZmHTWepzRLyxWhK9z0lTM4h16aKFqyF7woFq98R0uhThRX2t8G
   04ysZfDyRU/jmIPkw+JgDOfHl5Emku/cgD8UxS9MndeeTPIv/juSf6SHc
   af96jKh5U4nF+sz31ViN8e2rpsGVAlqXCjUo9oZ1vVU5abPy8L9evuIhy
   A==;
X-CSE-ConnectionGUID: C2DjShdlSremA/Zghdl3rQ==
X-CSE-MsgGUID: 80aYu1PaTwGJLnjgpYjUpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1708378"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1708378"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 04:38:13 -0700
X-CSE-ConnectionGUID: FFvmLkIlQ7CAb16X7Ag8kQ==
X-CSE-MsgGUID: RYutKIzPSeOCmoJq9Ufafw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="5996839"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.73])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 04:38:11 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 1BC4E121CBF;
	Mon, 26 Oct 2026 13:38:13 +0200 (EET)
Date: Mon, 26 Oct 2026 13:38:13 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Praveen Puglia <praveenpuglia@gmail.com>
Cc: Antti Laakso <antti.laakso@linux.intel.com>,
	Miguel Vadillo <miguel.vadillo@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Mehdi Djait <mehdi.djait@linux.intel.com>,
	Marco Nenciarini <mnencia@kcore.it>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] media: i2c: cvs: Leave the privacy LED to firmware on
 Synaptics SVP7xxx
Message-ID: <at87pYBHz3YNLGsF@kekkonen.localdomain>
References: <20261008-cvs-privacy-led-v1-1-b78d5c512cba@gmail.com>
 <asjE_UdsewYa4kjz@alaakso-desk>
 <CANfatsqw=XxmJvbCPxD9T-=FBwd_h-e4KaEf+Mz5dgtGoK+pRw@mail.gmail.com>
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
In-Reply-To: <CANfatsqw=XxmJvbCPxD9T-=FBwd_h-e4KaEf+Mz5dgtGoK+pRw@mail.gmail.com>

Hi Praveen,

On Mon, Oct 26, 2026 at 04:29:07PM +0530, Praveen Puglia wrote:
> Hi Sakari,
> 
> Gentle ping on this one. It has Tested-by tags from Marco and Antti,
> and no review comments so far.
> 
> Anything you'd like me to change?

Basically this waits for having rc1 in the media committers tree now. The
patch is fine and all is well. :-)

-- 
Regards,

Sakari Ailus
