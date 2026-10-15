Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F46747F79B;
	Thu, 15 Oct 2026 08:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792051298; cv=none; b=DrRWtHmcxCyd5ucYjXasuEpKUkAqoUpOi1dWx3VJpQu4KCJXcKivjXsBWL7KpaAHVDCFuxNv6sm25KNhwMt/NfS8doejdcZ6KcnlIPydSEBkcr1rD0F6ezME7tNFrXCNfymIwrtq1fM5/m8G8w3ddedyNBaDr+wK6x7fAocK6ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792051298; c=relaxed/simple;
	bh=9HlY+Eghclz8LKK+TVIuzbxJB6VCUObil/5RKf7SCtI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lE1fBJeqpEwCLgq3lfB7QGtrtDkgvf9yxvD09Si9X34o8QVGt9I3CAIGemnWrAOrmgVBU9Ye2eV5cwu/oJ/2vSQmZ+FJPwXWtVwT7dl0ttegkzoHnVPoUgrdrHmmqju7ZunCDhSqBLm+bOiuVsz8kr6EAUSIkLjY84muzTpL+Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ysThyNSK; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ysThyNSK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1792051297; x=1823587297;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9HlY+Eghclz8LKK+TVIuzbxJB6VCUObil/5RKf7SCtI=;
  b=ysThyNSK6NVSmZjHtzrYbNcGucee1aH8cDSBhnGCDI4K8Hm77NCCqycj
   ItgyT2kaQ/XVndL5YtOG3laggml73s2R+ZMAJ5Z69prF+Tiifw3oCvPfU
   dLGxP9CQYMQAuOCQgO5Av66IB9h27WIU1iG6NTky8kk1OStLiphUCChqO
   c+LJ+WD+18r7rBD1EqRvrTbZoeH4tX2QN31hYehe5mEadQ/yntdKUUJF8
   RdKYogAARDbtdsxECC2llNxfqPP1meRj6gSPI711QZ3PF3ckYIUp8MwUI
   RMDELvP+lnDvmP6B1va9ZmYs4N1Y6uzWczdxPI2vO3TylYTSoBHbuhL3P
   w==;
X-CSE-ConnectionGUID: /K0D+vSNS2Ol1fiinBjLmg==
X-CSE-MsgGUID: ZQ/EFtswR3uU1l5NhzZTIA==
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="75465529"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Oct 2026 01:01:36 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 15 Oct 2026 01:01:35 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 15 Oct 2026 01:01:34 -0700
Date: Thu, 15 Oct 2026 10:01:33 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Jiacheng Xu <stitch@zju.edu.cn>
CC: <kuba@kernel.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <jiri@resnulli.us>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH net] netdevsim: avoid NULL dereference after failed probe
Message-ID: <20261015080133.lv4rnnyuontntlkb@DEN-DL-M70577.microsemi.net>
References: <20261012135941.78329-1-stitch@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261012135941.78329-1-stitch@zju.edu.cn>

Hi,

> device_register() reports whether device registration succeeded, not
> whether the matching driver's probe succeeded. If nsim_drv_probe()
> fails, the driver core leaves the nsim_bus_dev registered while the probe
> error path clears its driver data.
> 
> new_device_store() subsequently marks the nsim_bus_dev initialized. A
> write to its new_port or del_port attribute therefore passes the init
> check and calls nsim_drv_port_add() or nsim_drv_port_del() with no valid
> nsim_dev. Both helpers pass the NULL driver data to priv_to_devlink(),
> leading to a NULL pointer dereference.
> 
> This can be reproduced by creating a netdevsim device for which
> nsim_drv_probe() fails and then writing to the new_port or del_port
> attribute of the registered device.
> 
> Serialize the driver data check and the port operation with the device
> lock, and reject the operation with -ENODEV when no driver data is
> present. This also prevents driver unbind from freeing nsim_dev between
> the check and its use, and follows the locking used by sriov_numvfs.

I agree with Hangbin that unregistering after a failed probe seems like a better
solution, but since  you already explored that, lets not go there.

There might be another approach though. Did you explore nsim_driver.dev_groups?
Adding nsim_bus_dev_new_port_attr/nsim_bus_dev_del_port_attr there might work,
and the fix will be simpler. I cant claim to be an expert in this area, but it
might be wort investigating.

/Daniel

