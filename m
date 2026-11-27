Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795773501;
	b=BANysnpkiAyoWIDU3mbvPUOUGBbZdYszPZqmh9c33MNav9I2OPdeHZ3drPtAXgcznpfC
	 AJ9JSVgvJZAtraH3hD+9njHUU4qsHkIBqU1H6K8ybN2f3je5QXPHyVdb5bGoXNqT+/z/U
	 Qq0MkSVFvbnrLQYSuBvmDqByHFHpQWR3eY7pD82s2xzvVaoAhE3w6KBYDdRZtcLL2z3Mb
	 sLUrF4L9He8kxrCXirULxVkf+zBhqk88IWD2/oFTKOJQ+rHq9e3N6XPW/+P5wLhbsJuVt
	 uhXTtI2KIvSlD//yI4Ujlz+I3qDKQuv90rZWvtvIA6N0wPJN4b3PBcPsYZ2VY2hWGqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795773501;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=wFtcawCZBw06PtvuJYjR3VuN63PM3tHs+W6Jju908aQ=;
	b=OKNKXa5R5hButh77Ev9Vh6esxtC5ttOU0/PdrtVy9LUkCIgH4gVvAjvs1uq8XAzwDjPW
	 NT9gVSa03lRhRwezmT04ckSbp614B3QfXtVtyykLLmUUJeC2Pxdc2j8vI52tqfg5gZRL+
	 9GWJv8biBIrbChb1XME9m0VQktDsCYRf56MjeQFbKkmjatUye5rUVN9DoOY83ArOfAA2X
	 NGJzQUtLJcqAgGd/q5LG4FCnP93TbqenJ/Xk1OXETzJf2apV3FAF0wRrPALqMhF2VwKUq
	 juAL30CE9CGtZjeHG1PAeIZ7x0s4jw6qCC94aSS9gED0vbU745wGojjOyafVHHv3r8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=HyOFWH2+;
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF0F606A697;
	Fri, 27 Nov 2026 09:58:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BF0F606A697
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=HyOFWH2+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1795773493; x=1827309493;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DaXL1DAidTh6X6TkoOGF7Q30/YlnfCIyWWMZ8ExtYdw=;
  b=HyOFWH2+VsTl7Eos7Ki1zdg8ectHbdb+m9kuSJgTCHylORrjpQfJ3gCp
   J+4hYKXqMl+G3KcSY48OkfaqCrpFXgsLKgEW4dMHt/G7UjYjYa0iLk7/L
   0yTDaRPXjN77tq6YGrHnkcARN0HMIRaa3h+GxxGD5NWPPOgLJJHK+BJd4
   ZZBizgqcG/XpL02oWyIMRo4OhtMRsBS2K9bEwzvmpOK2WExfrr8zRaMgM
   0ocb2VXEzu14rp3EsjX70KVjQANvg6OYdrGCJvf5DsSNOjRuMHzWVul6a
   Gvt6RtCIBVbRRTDS2Tb/4qwFDaiSUxhe5LeZD6hr37U4qtNHM+sUh9qfV
   Q==;
X-CSE-ConnectionGUID: +PloVku4Qiuz6CvEN1dupA==
X-CSE-MsgGUID: qa8CNH3lQgqtkX4d3YL/TA==
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="67133839"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 02:58:12 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.57; Fri, 27 Nov 2026 02:58:10 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 27 Nov 2026 02:58:09 -0700
Date: Fri, 27 Nov 2026 10:58:08 +0100
From: Daniel Machon <daniel.machon@microchip.com>
To: Yufeng Gao <yufeng.gao@canonical.com>
CC: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] phy: microchip: build both SerDes drivers when they
 share a config value
Message-ID: <20261127095808.iucj67lrtxzn2zir@DEN-DL-M70577>
References: <20261126140521.237240-1-yufeng.gao@canonical.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261126140521.237240-1-yufeng.gao@canonical.com>

> The Makefile adds the two drivers with ":=" instead of "+=":
> 
>   obj-$(CONFIG_PHY_SPARX5_SERDES) := sparx5_serdes.o
>   obj-$(CONFIG_PHY_LAN966X_SERDES) := lan966x_serdes.o
> 
> When PHY_SPARX5_SERDES and PHY_LAN966X_SERDES are both 'y' or 'm',
> both lines assign the same variable and the second replaces the first:
> 
>   obj-y := sparx5_serdes.o
>   obj-y := lan966x_serdes.o
> 
> In this case, sparx5_serdes is silently not built despite enabled. To
> fix this, use "+=" (for both drivers).
> 
> Fixes: 305524902a00 ("phy: Add lan966x ethernet serdes PHY driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yufeng Gao <yufeng.gao@canonical.com>

The issue is real and the patch fixes it, thanks.

Tested-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
