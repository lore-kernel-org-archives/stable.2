Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBE63BAD81;
	Wed, 16 Sep 2026 03:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789528413; cv=none; b=hFzYABaloLo0ofxXOYKHO8/AP79lcH3UyiBjIFq0Zs12VZWzZohqgBD3JqiBx8VwnOLdwsaxbblzz8xZzuQafk9gBK7SOLdgT3ljby6QvIZfjvjoQOSmKveHTkDkKvHBUBcMKWrjpZmco8rqPjLWCe1jJN9DPLxORqq2xGd6E+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789528413; c=relaxed/simple;
	bh=SHtokfXkoOPsNYuAqxARc+a8ImsontnaUMSedjeFkL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GYdBKzeWOe4Zvyw/3LMhylJy5DzaBw6BaWUip2uMJUSJmQyhrhwXWF/C9VVvyngSPzq6b9Oyg6FYdCD/JGbUFIDRr4D9RdChFgoyezSmJDhTmoXx58Cs+67ew3e5oSAa6o9G4U1c0lwd2ObYFWwSireQrELULF3dkAGhkeKrRCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YUHkG+03; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YUHkG+03"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789528407; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=3Ad7r9PzlVendAKi3/AUcl8n3hD7fuMAK5N9uhTGEmc=;
	b=YUHkG+03kDjd5isu28js3754eBsdBLNFi9XHwJOklcqCVMFvxubPgbciMXdCPO4P1TXbkfg6M4pbsCqNuQt+XkRTlsdHDlDtkQiU2H9Ck3cuqmMIydZgwhdZGpybXhYF1ZoVgL8E/BVZN//HplQN8lI0JBpMkkpQKrNjzI5lfuA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XB3apYv_1789528406;
Received: from 30.74.144.115(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XB3apYv_1789528406 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 16 Sep 2026 11:13:26 +0800
Message-ID: <8c67c48d-d950-4a63-9444-0f9c2e1e2b87@linux.alibaba.com>
Date: Wed, 16 Sep 2026 11:13:25 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-sprd: disable runtime PM on remove
To: Guangshuo Li <lgs201920130244@gmail.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
 Orson Zhai <orsonzhai@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260915161947.2479111-1-lgs201920130244@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20260915161947.2479111-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/16/26 12:19 AM, Guangshuo Li wrote:
> sdhci_sprd_probe() enables runtime PM, while sdhci_sprd_remove() does
> not perform the corresponding runtime PM cleanup.
> 
> The probe failure path disables runtime PM before disabling the clocks,
> but the normal remove path directly disables clocks that are also
> managed by the runtime PM callbacks. If the device is runtime
> suspended, those clocks may already be disabled.
> 
> Resume the device before removal, disable runtime PM and drop the
> temporary runtime PM reference before disabling the clocks.
> 
> This issue was found by manual code inspection.
> 
> Fixes: fb8bd90f83c4 ("mmc: sdhci-sprd: Add Spreadtrum's initial host controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---

Make sense to me. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
