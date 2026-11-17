Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910950;
	b=XhiVo4APL3KNW9vrsqMdais/VEU9RtBWnIA+/xyzjeX5tbcApGRqQsrhDoKBaRtAVWPg
	 jZpFT+EEZZJAc3qAPXMYtAyZE2FHFbk3x5KQbkYYPSWoy/MuETHf/xy1k+uDrBZBbR0sO
	 9SH1aqF4mRUmzfbl6V/08TKzwqW9DlRT15pca+fN3zdjKvU+o4ruVe1n+14YczCOGN2UR
	 E15oPWysLN5k5RLhW6RkAZjgtOaoGireMRFRKLPl5+UdiSYO8InUU8Uyi+fBmV8OKk7C9
	 IJSQl0i7FHyxtyGaNuIhYYf0U4uTZQy+u5pziHQ/0doL6SYaolpF0qvtS9gAG3RCsBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910950;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=sf5Sh65zq2acGOrMjamVGnM7ymgHN2EwSdw/7NNkbB8=;
	b=g4J7q3qPzaYscLj5UOv760xbXpFb+utWFr1uIG9U9qZk5krGlHt6QgPSAzfMWDccv+rx
	 l5gxY2VznfgUynjI58DKv8+tZhIZwBILLjtS1FPkWy/LQtvDqlKqI4GDa+PfSoZZQAYUx
	 OVU0sz5jDKJ2b4SbsaiAsNTfZDOsyLWc/ldTmdhAjY8ji+aHJAn3f+iDvhu0Fj8jwTr75
	 zZSjk1UYKuEgeojKeTqnQVblImos6HBDsy7L6jlUggHjxlwd8U3m600k4/5khYiOTIY/w
	 tFC1PyaMwooytRkxBri8NGK7yQIz8m4KeM9gI4jOSNSofGb4HWHT/L+4doe1j/3rWmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VuZz1tUB;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03E0606A31C;
	Tue, 17 Nov 2026 10:22:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C03E0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VuZz1tUB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794910950; x=1826446950;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hkHQpO+CLu7A2P5tBnRfhW7K2EIYel+F14HpvaLCAFk=;
  b=VuZz1tUBufjkPXX/maueruN+y4ZwPBmkBWNM/XZ3iG8WRWhxPGKZDJql
   MdlkM90PTSV1kr+5hIwMkCoTibxY1xEx0MFBQopnjIXxM0uWLxVGjQ9D0
   3AT2/srKUI1Xz5VFUogNeD/ERHCEC75Duzr8Wt93joqNWCYgk8EvaPrD9
   Q+UO3yCkbBwBUY3I+hRi/hLRILHcxwT37F/QbXMBRFg3J+bP4ZKD5/Low
   yZb1Ivbz9Wu5oj6PE++ntRZCvobIcr+IoHv6JyqZDnJvTaeEVegTQ1uHb
   ITTLBweEwf1Z3/c1hBaKX6PBSCO8HotRmBceJrypOLALL3Z57nMIP4tzB
   w==;
X-CSE-ConnectionGUID: vRBH0e1/SQGRWssW1tZEDg==
X-CSE-MsgGUID: cLRKqzdeTuCq6CFY8evklQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3559519"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3559519"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 02:22:28 -0800
X-CSE-ConnectionGUID: 7GjPDgIISHOXKABYY5OO8Q==
X-CSE-MsgGUID: Ewm78kIoSeODcDTEQE2elA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="10164062"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa001.fm.intel.com with ESMTP; 17 Nov 2026 02:22:25 -0800
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 3FC5D99; Tue, 17 Nov 2026 11:22:24 +0100 (CET)
Date: Tue, 17 Nov 2026 11:22:24 +0100
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Amelie Delaunay <amelie.delaunay@foss.st.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: stusb160x: disable the interrupt before
 tearing down
Message-ID: <avwq4Iau0iA_TmQ7@black.igk.intel.com>
References: <20261112065620.34269-1-mhun512@gmail.com>
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
In-Reply-To: <20261112065620.34269-1-mhun512@gmail.com>

On Thu, Nov 12, 2026 at 01:56:20AM -0500, Myeonghun Pak wrote:
> The devm-managed IRQ remains active while stusb160x_remove() tears down
> the partner, VBUS, role switch and Type-C port. An attach or detach event
> can race with partner removal or access the port and role switch after
> they are released.
> 
> Disable and synchronize the IRQ at the start of remove(), before any of
> these resources are torn down.
> 
> Found by a static analysis tool under development.
> Not tested on hardware.

The same question here. Why still use the devm_* to request the irq?

Thanks,

> Fixes: da0cb6310094 ("usb: typec: add support for STUSB160x Type-C controller family")
> Cc: stable@vger.kernel.org
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
> 
>  drivers/usb/typec/stusb160x.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/typec/stusb160x.c b/drivers/usb/typec/stusb160x.c
> index a2ec0565bd85..ec2f4d7f7ed3 100644
> --- a/drivers/usb/typec/stusb160x.c
> +++ b/drivers/usb/typec/stusb160x.c
> @@ -801,6 +801,9 @@ static void stusb160x_remove(struct i2c_client *client)
>  {
>  	struct stusb160x *chip = i2c_get_clientdata(client);
>  
> +	if (client->irq)
> +		disable_irq(client->irq);
> +
>  	if (chip->partner) {
>  		typec_unregister_partner(chip->partner);
>  		chip->partner = NULL;
> 
> base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
> -- 
> 2.43.0

-- 
heikki
