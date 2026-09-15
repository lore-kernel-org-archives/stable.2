Received: from mta0.migadu.com (out-35.mta0.migadu.com [91.218.175.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDF936C582
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 01:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437492; cv=none; b=q7oPHFGex3cKg+myP+nTNLdlIYkiWMCXH+sMCQ4Adiss7aYwV+sBtTdrS+cjM7oPh1r2Ykn1+pYNjgAwS2Bh4YrMUvv0+Znt5ODmCIJdO2wLLjCqDdEIGXZgTOrxF898XKYgDp47y1DUHw+inM/hB+J9kRXXpF5CgaJFYyzg8y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437492; c=relaxed/simple;
	bh=Q2gKk3krjTO7mbSLwubKXWsyFHaxIvXbTqFF7KVa8w4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tSuE6jF4vgQIoa/RHH/AoyQmdBKoWqWZwJQcEgbbB6DL9uYdecW0SvzfPpbR2ozwu27YtPsd+brN1mpOUcAaEMw+1jYs03EWqC0/jl1c/wBLCDGkC3ApwsWVlvIAkb8cEAHEY1STUPO+FBx/b4cD9Dmcn1fANNahYqN5Y4xjlqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j9ddE8xv; arc=none smtp.client-ip=91.218.175.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j9ddE8xv"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Q2gKk3krjTO7mbSLwubKXWsyFHaxIvXbTqFF7KVa8w4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789437489; v=1; x=1790042289;
 b=j9ddE8xvYFsRKYkACjolv3aQ3UAitMonmy98KYKFnm1vXh3U5puXAZo+H4/XBGorjFGa4G5n
 7AbfL+Xv0LeXLLMdmyGu8lDofvefP+bj3yViFO6Nz8PxujLKFF6fZZEATvrBD9j03hxcpDBEjM0
 /+vfqMzCaV+GSKdiA1nmbRDQ=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 27f3aa2e7672e207;
	Tue, 15 Sep 2026 01:58:08 +0000
X-Mizu-Trace-ID: 27f3aa2e7672e207
X-Migadu-Flow: FLOW_OUT
Date: Tue, 15 Sep 2026 09:58:02 +0800
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Denis Kirjanov <kirjanov@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: sundance: balance PCI enable on cleanup
Message-ID: <20260915015802.GA95173@pc>
References: <20260915010849.54718-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915010849.54718-1-mhun512@gmail.com>

On Mon, Sep 14, 2026 at 09:08:49PM -0400, Myeonghun Pak wrote:
> sundance_probe1() enables the PCI device, but subsequent failure paths
> and sundance_remove1() never release the enable reference.
> 
> Use pcim_enable_device() to disable the device after existing network,
> DMA, mapping and region cleanup on probe failure or driver detach.
> 
> The imbalance is already present in the initial Git import.
> 
> This issue was identified during our ongoing static-analysis research
> while reviewing kernel code.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
>  drivers/net/ethernet/dlink/sundance.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/dlink/sundance.c b/drivers/net/ethernet/dlink/sundance.c
> --- a/drivers/net/ethernet/dlink/sundance.c
> +++ b/drivers/net/ethernet/dlink/sundance.c
> @@ -510,7 +510,7 @@
>  	int phy, phy_end, phy_idx = 0;
>  	__le16 addr[ETH_ALEN / 2];
>  
> -	if (pci_enable_device(pdev))
> +	if (pcim_enable_device(pdev))
>  		return -EIO;
>  	pci_set_master(pdev);
>  

Reviewed-by: Chenguang Zhao <zhaochenguang@kylinos.cn>

Thanks
