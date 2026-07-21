Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769EC3382DE;
	Tue, 21 Jul 2026 10:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784631204; cv=none; b=eWuEvcGIN1gxwa9Kw1wxhSropzrUoO3sr1ClTi5wlX+JF7p/UhF5THhtpWpDT0DpEt7RrQ5Y1MB8YWZ7CBIFSCDgeJbWQgzCPnBIQI6piAeJZsgW2vcnb+BellWYBIyC6bW+M3+Sjnw/OGeLbVamV5YzfCu9v3suoc7kiQMfK4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784631204; c=relaxed/simple;
	bh=QMGS7lx3vu8AaoPDefBrGoqx/yvSgRVo5uIAQgLhrn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCkAOiWPB9hxjaqYppg3b63rIn646/8QewB61A28FSFi+3upd6iBTFaeGhkZVG/OxXziKCbmtmHxWOfUm3Z5fQ4Fs/bwelA9u2NF3hjVrBE0BFaWLGYHq22f7QK7UmfQMy7CxmJjDe3lIZUUe6yDapKO1RTDPontrvrvB28ySYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZEJcpgly; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZEJcpgly"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784631203; x=1816167203;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QMGS7lx3vu8AaoPDefBrGoqx/yvSgRVo5uIAQgLhrn8=;
  b=ZEJcpglyQSKLunW2gpVKAopLJbpweCJQh5rMl6nd+XE2v+H5iwo3lBjK
   04sF4h7pqmRJGbh65KoFahCaukqc6YkqcOvyh6Mzqrmj7Z1RATu0a3LI2
   uo2KVV82KSerykAh9Z02DczcLhBMFchZYB4KYpeZxKhyKIwnKkHAdZSMF
   tcNn4r/2mBnLrH3/zDpgindTsRMfd0SaY6KI0ZlYdIrrG23l9FKKkwInb
   0aKPSo9BZJqqiqPUGg4kUQV8oNKBoa1ZeyYZcD+q58/y5LZQI5qcTdK6R
   cHw1bhlzYDUTHHBVDsm6rY2waj0XfNHuDgTwGyHa8BUS6lF4qFM7y5WTF
   w==;
X-CSE-ConnectionGUID: kM0Gn2PaQkedZEaGe8H+mg==
X-CSE-MsgGUID: q5O17zHXTMqVifDWFVt1Vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="102775977"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="102775977"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 03:53:22 -0700
X-CSE-ConnectionGUID: ypSbHRg9RdmixMtd2ng8XQ==
X-CSE-MsgGUID: rs7/BOhST8yYqfzqZX1f2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="256526220"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa010.jf.intel.com with ESMTP; 21 Jul 2026 03:53:18 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 94FF895; Tue, 21 Jul 2026 12:53:17 +0200 (CEST)
Date: Tue, 21 Jul 2026 13:53:16 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: jens.glathe@oldschoolsolutions.biz
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, stable@vger.kernel.org,
	"Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH 4/5] usb: typec: mux: ps883x: add a delay after writing
 config regs
Message-ID: <al9PnLOTW-1OoR6G@kuha>
References: <20260718-ps883x-disable-usb4-v1-0-cec86d0b909e@oldschoolsolutions.biz>
 <20260718-ps883x-disable-usb4-v1-4-cec86d0b909e@oldschoolsolutions.biz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260718-ps883x-disable-usb4-v1-4-cec86d0b909e@oldschoolsolutions.biz>

Hi,

On Sat, Jul 18, 2026 at 07:06:32PM +0200, Jens Glathe via B4 Relay wrote:
> From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> 
> The config regs seem to need a few ms to propagate the changes through the
> system (like, PLLs). This improves the hotplug dp altmode success rate
> on the Lenovo 40B0 dock to 100%.

20ms - 30ms is a bit more than a few ms.

> Tested with T14s G6 and 40B0 dock on the HDMI port with a type-c host cable.
> 
> Assisted-by: Gemini:3
> Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> ---
>  drivers/usb/typec/mux/ps883x.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/typec/mux/ps883x.c b/drivers/usb/typec/mux/ps883x.c
> index 3533d4f363286..3ca2952e6a0a3 100644
> --- a/drivers/usb/typec/mux/ps883x.c
> +++ b/drivers/usb/typec/mux/ps883x.c
> @@ -185,6 +185,8 @@ static int ps883x_configure(struct ps883x_retimer *retimer, int cfg0,
>  		return ret;
>  	}
>  
> +	usleep_range(20000, 30000);

/* <explanation why is the delay is necessary> */
fsleep(20000);

>  	return 0;
>  }

thanks,

-- 
heikki
