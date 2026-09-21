Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA0E4FC343;
	Mon, 21 Sep 2026 19:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790017580; cv=none; b=YedvIjJ5kDMdvuwxQiZXSJwcdh4rv3EUHSuq6XLYLszJwxjjW02yZWAZfXfSh5EsuGEn0WP7DbwwIgRiLsw34Mpsb5Yza4L0Pga/EE9UKHgOV8GQ10hwLS2mAL1l1b9Y3M/J3xJ5a/5umFjio7TJxruW1j/msQxf4cH6ry4mVsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790017580; c=relaxed/simple;
	bh=qzz7XnPrw2VN/hLIGszjeEct3tY2LRf2xEHYe6n5keM=;
	h=MIME-Version:Content-Type:Subject:From:To:CC:In-Reply-To:
	 References:Date:Message-ID; b=tGTJcDLQr29lcRu56hr9NWmFM8XeFd1NpJ3hfV5xSBwTs9I8l5hIAHQV5IeF9SrRCvgALdNXNBk3r+IY5k4M3xzvIK5XfOb7Dapeb2XxBmBAQ5JOXN8kE2OojPYCWrYxoLHKLFGDaLd0SShduoaC933IEa8LOLZ9/LnfUGq/i+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=rn3sOAmw; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="rn3sOAmw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790017579; x=1821553579;
  h=mime-version:content-transfer-encoding:subject:from:to:
   cc:in-reply-to:references:date:message-id;
  bh=5d1fPjV9fe1FfCtfOIKGBQ2v/+atEidlljUyxF6je9U=;
  b=rn3sOAmwKFu6qIKGrBdAp5kmAFVZ+0bdMOSeS1j/tn2kDdhm3zcEd/we
   CXyv90OEYj9w9etCyylNaKLbJYTY+u/SGc2A9+2g0PT6z4qADhLxZO56u
   yYRAXPFeKc64+3selhWA85wZJn9BFnhMxkKal7a2Kr3Nj616kBEp6dKhQ
   8lVJJg+FrVJ9vaIWOV7/FKWRdDQb+QN4tD/v7Skxxfq9z7MDB226+Orjl
   4YQy++XAU3meZ7RsOi10C9X755V7Y8nRu4cYDvnoJJPhVwChAPpKmCV6V
   u/N5GUZgXmZLin3z1ARsXWktDelKP8kOwa/l99E/bqbLcTuyYCZvcga7J
   Q==;
X-CSE-ConnectionGUID: 9Rii6w+CT5uGVI5t6oSXKg==
X-CSE-MsgGUID: SjaWV+LkRxakxPqN1r2Uvg==
X-IronPort-AV: E=Sophos;i="6.27,115,1787011200"; 
   d="scan'208";a="29308397"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 19:06:16 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:23680]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.70:2525] with esmtp (Farcaster)
 id 5849dd9a-7d05-4b67-9d2d-f3bbb6ade12f; Mon, 21 Sep 2026 19:06:15 +0000 (UTC)
X-Farcaster-Flow-ID: 5849dd9a-7d05-4b67-9d2d-f3bbb6ade12f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Mon, 21 Sep 2026 19:06:15 +0000
Received: from dev-dsk-akiyano-1c-2138b29d.eu-west-1.amazon.com (172.19.83.6)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Mon, 21 Sep 2026 19:06:13 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/2] net: ena: fix PHC cleanup on probe failure
From: Arthur Kiyanovski <akiyano@amazon.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
CC: Arthur Kiyanovski <akiyano@amazon.com>, David Arinzon
	<darinzon@amazon.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ioana Ciornei
	<ioana.ciornei@nxp.com>, Sang-Heon Jeon <ekffu200098@gmail.com>, Dawei Feng
	<dawei.feng@seu.edu.cn>, Amit Bernstein <amitbern@amazon.com>, "Netanel
 Belgazal" <netanel@annapurnalabs.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
In-Reply-To: <20260921154202.471662-2-lgs201920130244@gmail.com>
References: <20260921154202.471662-1-lgs201920130244@gmail.com>
 <20260921154202.471662-2-lgs201920130244@gmail.com>
Date: Mon, 21 Sep 2026 19:06:02 +0000
Message-ID: <179001756287.8372.475254242129499819.b4-review@b4>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: EX19D039UWB004.ant.amazon.com (10.13.138.57) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Mon, 21 Sep 2026 23:42:01 +0800, Guangshuo Li <lgs201920130244@gmail.com> wrote:
> ena_probe() initializes the PHC as part of ena_device_init(), but the
> probe failure path does not destroy it before freeing the PHC private
> data.
> 
> The normal removal path calls ena_phc_destroy() through
> ena_destroy_device() before ena_phc_free(). However, if probe fails
> after ena_device_init() succeeds, the error path reaches ena_phc_free()

This part:

> without unregistering the PTP clock or destroying the device PHC
> resources.

is inaccurate, see my explanation bellow.

>
>
> diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> index ea89619039d8..5f0864d16dd3 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> @@ -4122,6 +4122,7 @@ static int ena_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  err_device_destroy:
>  	ena_com_delete_host_info(ena_dev);
>  	ena_com_admin_destroy(ena_dev);
> +	ena_phc_destroy(adapter);
>  ena_devlink_destroy:
>  	ena_devlink_free(devlink);
>  err_metrics_destroy:

Thanks for resending as a series - the split and the ordering are what I
asked for.

But v2 doesn't address Sashiko's review of v1.

PHC is off during an initial probe. It only turns on if the user enables
it via devlink, and devlink is registered at the very end of a successful
ena_probe(). So on this error path phc_info->clock and
ena_dev->phc.virt_addr are both NULL and ena_phc_destroy() does nothing.

I still want the call - it keeps the probe unwind symmetric with
ena_destroy_device() - but it is a robustness change, not a fix. Please
drop Fixes: and Cc: stable, and say so in the commit message, for
example:

  No functional change: PHC is always disabled during an initial probe,
  so this only keeps the probe unwind symmetric.

Since net is for fixes, that means splitting after all - sorry for the
extra round trip:

 - the MMIO read buffer fix goes to net on its own, keeping Fixes: and
 - this patch goes to net-next, without Fixes: or Cc: stable

The MMIO fix has to land in net and propagate into net-next before you
post this one, otherwise you hit the same hunk conflict again.

Also please use --subject-prefix='PATCH net-next v3';
netdev/series_format is still warning that the target tree isn't
specified in the subject.

Thank you.

Cc: stable

Cc: stable

-- 
Arthur Kiyanovski <akiyano@amazon.com>
