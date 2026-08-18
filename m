Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EC0392C56;
	Tue, 18 Aug 2026 16:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787070125; cv=none; b=fc4SMIUQDFc/oaWD1+gAFMOETp7PXpozwn6ZST2kTrziAfkzbdFDHBtZP3EniqUAY2+hb9qMqxwFji5PklwjgSyLTkWiSekAjQ/7FjZ6eysmtdVq15mfXGaVV1bIvbMXz5R3k39/f70hkmmGzSwwL+myB++iSy1mmFdd/wH96R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787070125; c=relaxed/simple;
	bh=MHuo5CCg5FPgnXwZaXG7MDvuz4t39Kg+ZeD1Nl+DRT0=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=aBLQN2xYEnbPBLW+hDFOh6KCFa7Ckz0pyR1m9XfmbGmmOdXb6iXh9aX2YAjUV6L9CZDA9HKsGjgp8nffPXxuLIQ8X2mAwaDCzc7WV0CL9i4iMjOb7jCS6ppaUsLXeup8zf6hE2+VIVcVXmOYIL4JcmSvlEk9M/P1bAHZIMvOmlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=p8Hocy0m; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="p8Hocy0m"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=NCpNajcjLcKhB50ECJ7NOsUtAJuVK2tIlFJWyWHXWJQ=; b=p8Hocy0mI2ANMtc1ZYGcuSUp/N
	n7E/5SvgMicWEMlf57SNQAX8VSwNSgOv26/XYK6iSHdGuC9Z5+cY7VES/i354ObEJAyoyZqqXZLvc
	E9GaUvpquRWvFeQTCHWf0ks6tbc1GmsD1sc4nw2Bn7dLRMP/XmbcJsi/DpkFDtkixi5p7GCzMThg4
	GTDr6a4tPjKA5WH1Pp9Vg52907Utmf2nc+OIfAA1alzE0CZnF2kP4SQRY0IXI9/VYkXlz0pQzuSVq
	5jTNMjQ/lCO05mxedLpX2fZE9pqzX3ALJe9rlGCCX3z3/arnZUHagxG9IuZ0DkuzizdQUZ95rEXJg
	50Un9nxg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wwMZZ-00000000q31-1Eso;
	Tue, 18 Aug 2026 10:21:57 -0600
Message-ID: <c9e8b7e6-6a3b-4443-8632-81f2a2a4f79d@deltatee.com>
Date: Tue, 18 Aug 2026 10:21:56 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Shivank Garg <shivankg@amd.com>, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: stable@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
 Frank Li <Frank.Li@nxp.com>
References: <20260818-dmaengine-kref-fix-v4-0-c6ef991462a0@amd.com>
 <20260818-dmaengine-kref-fix-v4-4-c6ef991462a0@amd.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260818-dmaengine-kref-fix-v4-4-c6ef991462a0@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: shivankg@amd.com, vkoul@kernel.org, Frank.Li@kernel.org, akpm@linux-foundation.org, stable@vger.kernel.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, sashiko-bot@kernel.org, Frank.Li@nxp.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v4 4/4] dmaengine: wait for RCU readers before releasing
 dma_device
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-08-17 21:43, Shivank Garg wrote:
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index d075051dd187..604c9af19936 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -429,6 +429,12 @@ static void dma_device_release(struct kref *ref)
>  	list_del_rcu(&device->global_node);
>  	dma_channel_rebalance();
>  
> +	/*
> +	 * Wait for RCU readers (e.g. dma_issue_pending_all()) that may still
> +	 * be traversing dma_device_list before the device is freed.
> +	 */
> +	synchronize_rcu();
> +
>  	if (device->device_release)
>  		device->device_release(device);
>  }
> 

A couple minor points on this:

1. I think the comment, as is, isn't useful. It's pretty clear the
synchronize_rcu() call is paired with the list_del_rcu() call above it.

2. The new synchronize_rcu() call will delay for a grace period with the
dma_list_mutex lock held. Is that okay? It might be, but if so, it could
use a note in the commit message.

Besides that, these are minor points and the patch does fix a real issue so:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thanks,

Logan



