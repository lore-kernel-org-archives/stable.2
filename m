Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF45352007;
	Wed, 17 Jun 2026 20:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781728910; cv=none; b=qzBnY4f9vlBPFpvD5zezxrW6JUrZzzsazfjCHA17/FwEa9pZluUpUndMLRnA9dbMHZRNn0gQvhDHzQjDT8eLkksbPojf4wpkxydyKXiD7VEQMwPPu+5f6GUU/qyuwfBK7/wJmPkcJgBn1HkhG+nVstvOv3T40X8yn+/pUHRSIpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781728910; c=relaxed/simple;
	bh=37sp+mqdire77H0TpjdwV2wSbtzaX415p8TqSJZDxoA=;
	h=MIME-Version:Content-Type:Subject:From:To:CC:In-Reply-To:
	 References:Date:Message-ID; b=efcKp5Ibvsfptw7LOr4+ewkgJI0E+DLtcPlEm0m0gS0XNy38nMgz8zjMKXTcMIPIwD1Xw4UJup4TYEWehmP9Uy4sYRzzCyY/tcU3wkMDSeAIbaCGt5PcmimKmI3dy19xpIZV5Q0UbNgdxJjmv1E5pabhNonrg2fHlsu/1ov0zGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=KvGbkplz; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="KvGbkplz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1781728909; x=1813264909;
  h=mime-version:content-transfer-encoding:subject:from:to:
   cc:in-reply-to:references:date:message-id;
  bh=7sqvCZHOhWh8gMKbuIiW0+jhIvHImEa2MaoNyK8zT5w=;
  b=KvGbkplzCaaCTBOWBYJJX08AFwRI/LE3dyuhwV0vDhUUv5B2opvop/Rz
   PjFu3u9X946bXMf/QO+aO36HZmEDz93HeHyPh1wz76rPQwYyzV/wGcIEC
   UyG8HjmjL/4jviYtVtle1PEqL+w2l2jh14ufBq3jWeYlYaoasHXEZhu8p
   /SKwL+LVHepXZ1hQleHzACUUxrFUnkeGqhKb4+g3H4X3SziTDgE8Unh7F
   XxfYXOoZn2dBWeM9t8VB3egx5cnPKriGHd9jmflAjtoW0npxjALdsS6+Q
   vY/UhVr16P2CPKmsnCvedlcAei+qBPTghoiubCQEsvxNqhB3HW2w2UxPt
   w==;
X-CSE-ConnectionGUID: 4VOTJyskRLSyJiGXlqHeRQ==
X-CSE-MsgGUID: /Xh0y5hqR+GfC2/pGAzbmg==
X-IronPort-AV: E=Sophos;i="6.24,210,1774310400"; 
   d="scan'208";a="21848292"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 20:41:46 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:7808]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.143:2525] with esmtp (Farcaster)
 id 6615f163-784c-4ed9-b861-dc0450f2aa41; Wed, 17 Jun 2026 20:41:46 +0000 (UTC)
X-Farcaster-Flow-ID: 6615f163-784c-4ed9-b861-dc0450f2aa41
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 17 Jun 2026 20:41:45 +0000
Received: from dev-dsk-akiyano-1c-2138b29d.eu-west-1.amazon.com (172.19.83.6)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 17 Jun 2026 20:41:43 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ena: clean up XDP TX queues when regular TX
 setup fails
From: Arthur Kiyanovski <akiyano@amazon.com>
To: Dawei Feng <dawei.feng@seu.edu.cn>
CC: <akiyano@amazon.com>, <darinzon@amazon.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <sdf@fomichev.me>,
	<sameehj@amazon.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<jianhao.xu@seu.edu.cn>, <stable@vger.kernel.org>
In-Reply-To: <20260616142424.4005130-1-dawei.feng@seu.edu.cn>
References: <20260616142424.4005130-1-dawei.feng@seu.edu.cn>
Date: Wed, 17 Jun 2026 20:41:30 +0000
Message-ID: <178172889048.5594.1035759951040148062.b4-review@b4>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: EX19D045UWA004.ant.amazon.com (10.13.139.91) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Tue, 16 Jun 2026 22:24:24 +0800, Dawei Feng <dawei.feng@seu.edu.cn> wrote:
> diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> index 92d149d4f091..5d05020a6d05 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> @@ -2078,14 +2090,21 @@ static int create_queues_with_size_backoff(struct ena_adapter *adapter)
> [ ... skip 17 lines ... ]
> +			ena_destroy_xdp_tx_queues(adapter);
>  			goto err_create_tx_queues;
> +		}
>  
>  		rc = ena_setup_all_rx_resources(adapter);
>  		if (rc)

Thank you for submitting the fix.

I verified it on AWS.

The inline cleanup before goto is slightly non-idiomatic — kernel
style typically prefers label-based unwinding. Splitting
ena_destroy_all_tx_queues() into regular-only and XDP-only variants
would allow a clean label chain without special-case code at each call
site. But that's a larger refactor better suited for net-next; for a
targeted bug fix this is fine.

Reviewed-by: Arthur Kiyanovski <akiyano@amazon.com>
Tested-by: Arthur Kiyanovski <akiyano@amazon.com>

-- 
Arthur Kiyanovski <akiyano@amazon.com>
