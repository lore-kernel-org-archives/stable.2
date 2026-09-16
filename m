Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B9D245008;
	Wed, 16 Sep 2026 05:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.35.192.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789537612; cv=none; b=HtC2LWWJZ+fINVgiqNjM8Iw+7LH2D1kXPWxDQaT0oAYxU61SJOahRLtlY9u+aFI0pNd81Logwb/C6mjAfxAWgxs1AHl7nFuQx0h7a6iMtlPkoY/fYU0BqadQ0cf8clU5kdinY/gjxV1ZXZw5vUBAT1L7QN3tL/EduLBAhwM/D0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789537612; c=relaxed/simple;
	bh=V71zknTjjc0/AFN7cSoQJKS2ZFhZvv2UTsbhYGt6+6I=;
	h=MIME-Version:Content-Type:Subject:From:To:CC:In-Reply-To:
	 References:Date:Message-ID; b=rxBlYH/sVw1CCv17PlW0gFSX7G4BLop0JAF+4q6otnWqfg3eTvCWvW9UZNaLND/ChWsS4yxjsBCQAUx2XYUTKTzBDFYarA6G5TeyBOsQZvPlIW/cRW8MyMHxor+1azRTQcVkXQtyb1A4g6+Ft+/aJ808LLTg3uUoPhZLXSrVjoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=ZW76GtF3; arc=none smtp.client-ip=52.35.192.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZW76GtF3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1789537611; x=1821073611;
  h=mime-version:content-transfer-encoding:subject:from:to:
   cc:in-reply-to:references:date:message-id;
  bh=LjntV4clxqs01pd4q8+YvGuFFqj4kcVrW5fuxIhBJF4=;
  b=ZW76GtF3IbYe3+JOR09YXSUJSQbjRfNuYbOeqd498x0JBcjiSMhf3M4t
   wmSfGoCZQqa8qsT6/tTmM2OE0PSandUJGamACAwzwR5zSx4i6mF+HjFeU
   c9bheeA/M3vA0Vtec8tgEv7qrltkj3V9LTw2QBtC/Vv5ahRnViVdjSSwt
   XHjpwCE2RMICo5CGlTvRFafk05c8x7DiMk5bIB4QJUJ4gMIfq6vkMiMMU
   ntI7odfbSSTEx/f+T037aELAwXJjSCJxLX2H0org4U+4Je7r9qN7RrXUO
   Jpt5eng2pc/hpRdXHnDKvxTzB9XfcEC4u/p+sgA/u/m/F8EzuIsmwbnbH
   A==;
X-CSE-ConnectionGUID: Z1jkcwMqSuKh7dfLKOlQdw==
X-CSE-MsgGUID: W9TQbBBNTge/6/VLdJkMQA==
X-IronPort-AV: E=Sophos;i="6.27,103,1787011200"; 
   d="scan'208";a="28559862"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 05:46:49 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:15604]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.113:2525] with esmtp (Farcaster)
 id 1e8e5993-2308-4821-b0fa-4fd521eedd06; Wed, 16 Sep 2026 05:46:48 +0000 (UTC)
X-Farcaster-Flow-ID: 1e8e5993-2308-4821-b0fa-4fd521eedd06
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46;
 Wed, 16 Sep 2026 05:46:48 +0000
Received: from dev-dsk-akiyano-1c-2138b29d.eu-west-1.amazon.com (172.19.83.6)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46;
 Wed, 16 Sep 2026 05:46:46 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] net: ena: fix MMIO read buffer leak on probe failure
From: Arthur Kiyanovski <akiyano@amazon.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
CC: Arthur Kiyanovski <akiyano@amazon.com>, David Arinzon
	<darinzon@amazon.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Sang-Heon Jeon
	<ekffu200098@gmail.com>, =?utf-8?q?Niklas_S=C3=B6derlund?=
	<niklas.soderlund+renesas@ragnatech.se>, Ioana Ciornei
	<ioana.ciornei@nxp.com>, Dawei Feng <dawei.feng@seu.edu.cn>, Netanel Belgazal
	<netanel@annapurnalabs.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
In-Reply-To: <20260916023236.2701485-1-lgs201920130244@gmail.com>
References: <20260916023236.2701485-1-lgs201920130244@gmail.com>
Date: Wed, 16 Sep 2026 05:46:36 +0000
Message-ID: <178953759637.13037.3443162844703526798.b4-review@b4>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: EX19D032UWB002.ant.amazon.com (10.13.139.190) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Wed, 16 Sep 2026 10:32:36 +0800, Guangshuo Li <lgs201920130244@gmail.com> wrote:
> diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> index ea89619039d8..86ffda1c8632 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> @@ -4122,6 +4122,7 @@ static int ena_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  err_device_destroy:
>  	ena_com_delete_host_info(ena_dev);
>  	ena_com_admin_destroy(ena_dev);
> +	ena_com_mmio_reg_read_request_destroy(ena_dev);
>  ena_devlink_destroy:
>  	ena_devlink_free(devlink);
>  err_metrics_destroy:

Thank you for the patch.
It looks correct.

The netdev/contest failure isn't a tree problem - it applies fine to net
and net-next. It conflicts with your own "net: ena: fix PHC cleanup on
probe failure", which touches the same hunk and was posted first. Please
resend both as one series, PHC as 1/2 and this as 2/2.

-- 
Arthur Kiyanovski <akiyano@amazon.com>
