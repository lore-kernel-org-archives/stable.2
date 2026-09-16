Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F40B364934;
	Wed, 16 Sep 2026 05:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.26.1.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789537456; cv=none; b=ZXU9Wlfgz+AgemtDuD2giaZrXfMpgnqVIHFKLii864/AFzzFVAE5C05CEV6qPT0Ovd7ND1FqC5AtUxwUiEstT8tOTsQiCxLj7I9wKKZulp/p/2yhdNmLrVg4QKvi8s/iGK8opN2FOqBaORo5T7iROvx8LQymmV3VPeTEsqVTaZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789537456; c=relaxed/simple;
	bh=2GAP0TSdQjwy3Iz5z9+xG0FChzdAkaPelMGPuWjJl1s=;
	h=MIME-Version:Content-Type:Subject:From:To:CC:In-Reply-To:
	 References:Date:Message-ID; b=GwQET+g5z25Bo2jNVa/IJyUS+LKlNF6+pMfSSoMdduWbIsYhDQq/ktlv5NekemIb6fbaVt85iSoL7N846UJgut0CDFl2UqSCCUzIlP22wM/R44V+vzCWxRtZmJDK7ChyJh7R1L0O90GAihsDzO9ynh3ZoeEA9rCkEJoT2JPn9b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=t4kTDsK2; arc=none smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="t4kTDsK2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1789537455; x=1821073455;
  h=mime-version:content-transfer-encoding:subject:from:to:
   cc:in-reply-to:references:date:message-id;
  bh=lMly06yvXJw368HvsLkeEKdmRrbzT1Mb+UvQ7yEb718=;
  b=t4kTDsK2ab1UgD0bynVBpF6X5WA82pTUUthKsZq6iZ3w6M/qrgimtQWA
   HUsoVy+IcGBxLG72J8vuCssFf3UBY2EjpwNV/vV9/ry+bXNtOMBT65Egl
   0PIBxHPnGTA8DfeNUdaNrwELd9VxZLQKFOWjfOxs1vPN6Fs+qbR1kUIYh
   g/wV/juEpfTPIs/ShvM4y/RCDB9phXNL265jeHKewIbw8jB8PrtAXsidx
   ObLuUbTxxL6SgtRYEgYZ4oCmbl5nuXKg9EHypopNQ9K6S5rzP8+sE1KBz
   Vs2oErTOFrSrU7LiNV89JlGldFBll/OZTOaWVNt9YXaNBXIEWinmCBPQ3
   Q==;
X-CSE-ConnectionGUID: MEiWN9uLRICXJUjhMSoeng==
X-CSE-MsgGUID: 46+o4USfTQm+e5ExoXzW/w==
X-IronPort-AV: E=Sophos;i="6.27,103,1787011200"; 
   d="scan'208";a="28830891"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 05:44:12 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:11501]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.113:2525] with esmtp (Farcaster)
 id 280a168c-da7d-476c-a87a-4478e80f6ebb; Wed, 16 Sep 2026 05:44:12 +0000 (UTC)
X-Farcaster-Flow-ID: 280a168c-da7d-476c-a87a-4478e80f6ebb
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46;
 Wed, 16 Sep 2026 05:44:12 +0000
Received: from dev-dsk-akiyano-1c-2138b29d.eu-west-1.amazon.com (172.19.83.6)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46;
 Wed, 16 Sep 2026 05:44:10 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] net: ena: fix PHC cleanup on probe failure
From: Arthur Kiyanovski <akiyano@amazon.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
CC: Arthur Kiyanovski <akiyano@amazon.com>, David Arinzon
	<darinzon@amazon.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Sang-Heon Jeon
	<ekffu200098@gmail.com>, =?utf-8?q?Niklas_S=C3=B6derlund?=
	<niklas.soderlund+renesas@ragnatech.se>, Dawei Feng <dawei.feng@seu.edu.cn>,
	Amit Bernstein <amitbern@amazon.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
In-Reply-To: <20260916022954.2690322-1-lgs201920130244@gmail.com>
References: <20260916022954.2690322-1-lgs201920130244@gmail.com>
Date: Wed, 16 Sep 2026 05:44:00 +0000
Message-ID: <178953744017.13037.8123570146284827976.b4-review@b4>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: EX19D039UWB001.ant.amazon.com (10.13.138.119) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Wed, 16 Sep 2026 10:29:54 +0800, Guangshuo Li <lgs201920130244@gmail.com> wrote:
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

Thank you for the patch.
It looks correct.

Please resend this together with "net: ena: fix MMIO read buffer leak on
probe failure" as one two-patch series - both insert a line into the same
hunk, so they conflict with each other.

-- 
Arthur Kiyanovski <akiyano@amazon.com>
