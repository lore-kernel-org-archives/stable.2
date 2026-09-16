Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7DB221DB6;
	Wed, 16 Sep 2026 17:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789581229; cv=none; b=OMVO0G0deOItNofjMuesxZDellm+O3nHBktSMwxTf3kTxLMOxhg4YjP89DsU5TJpuk5JLXLOmYsgu3BPty5lyPUb99BHeTEjTi9HG5Cl5OHnD5QbiQtVpS5dCowjzh+GfAGjSV6wQhC4PnBXDpc0hSX5rL6O+Q+AfIgM8uq4ChY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789581229; c=relaxed/simple;
	bh=2ccaEYcsnNwWSmFN5mWy8ilIASzw7ooZT/htNLMAG+o=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=CHkPcSrCBdwPnssjW62PEy6+mJXytUZSBJRo5RJ2r1+A3h3l6VeSPaewmnCgNCowV9IjklUx/24w6DaBpka8pHTn8cxra0/V7tbrvd/hQEq4w2o3WsCf2NjZOA/2tJb0kMmo/1NdMoF0hU8vB5PZuDNZS3MJH/la/zmTMRTENVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=Zc9uwMFD; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="Zc9uwMFD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=RZXCKkTsW59RK359kuN92Mf5ZXHo2z0L/eLF2to/jD8=; b=Zc9uwMFDA1wX7Y50kd9Xz41SlW
	TifdUYATwgGGmHbVjqatGkmr5O8FClQQpEBS8Qa4Sn2EB6r+F0M5xCt/Fi8mtkX9wpPA2YRcQxioZ
	3XIoVr6uV6KWj8sOXwrVnZXK1I3H/AMSIkzMzCB98BF+ZS61cJx383WQJhCKjVNNzthVvrG3r5Ibs
	4dWPizGE9CqPKzfZ7pd4NIyOXHmflQ4AReqG2x1K16T1usuIKh0/9yyMhmn9NrM3RLysgc12qTYNZ
	gRYkasIg6Iys17bbOdRkux6XtGtH1AbLldq/a5N83BkzzDvCLztkBHKXlYbuGNdCwl1Yz5a+nhr+q
	4p8cPsBQ==;
Received: from d172-219-145-25.abhsia.telus.net ([172.219.145.25] helo=[192.168.11.155])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1x6toz-0000000BLRk-40qb;
	Wed, 16 Sep 2026 11:53:26 -0600
Message-ID: <e45646cf-0779-4be3-986b-48a5c12557f7@deltatee.com>
Date: Wed, 16 Sep 2026 11:53:23 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Frank Li <Frank.li@oss.nxp.com>, Wentao Liang <vulab@iscas.ac.cn>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, george.ge@microchip.com,
 kelvin.cao@microchip.com, linux-kernel@vger.kernel.org, vkoul@kernel.org,
 stable@vger.kernel.org
References: <20260916093332.2003909-1-vulab@iscas.ac.cn>
 <aqq-SldWxcGqF1Ay@SMW015318>
Content-Language: en-US
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <aqq-SldWxcGqF1Ay@SMW015318>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.219.145.25
X-SA-Exim-Rcpt-To: Frank.li@oss.nxp.com, vulab@iscas.ac.cn, Frank.Li@kernel.org, dmaengine@vger.kernel.org, george.ge@microchip.com, kelvin.cao@microchip.com, linux-kernel@vger.kernel.org, vkoul@kernel.org, stable@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH] dmaengine: switchtec-dma: Fix device reference leak in
 switchtec_dma_create()
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-09-16 10:05, Frank Li wrote:
> On Wed, Sep 16, 2026 at 09:33:32AM +0000, Wentao Liang wrote:
>> switchtec_dma_create() takes a reference on the PCI device with
>> get_device() and stores it in dma->dev. The reference is normally
>> dropped by switchtec_dma_release(), the device_release() callback,
>> which only runs after a successful dma_async_device_register(). If
>> the registration fails, the code frees the dma device directly from
>> the err_chans_release_exit label without ever dropping that extra
>> reference, leaking the reference taken on the PCI device.
>>
>> Drop the reference with put_device() on the error path.
>>
>> Fixes: d9587042b50f ("dmaengine: switchtec-dma: Introduce Switchtec DMA engine skeleton")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
>> ---
>>  drivers/dma/switchtec_dma.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
>> index 3ef928640615..b07bdd0ac540 100644
>> --- a/drivers/dma/switchtec_dma.c
>> +++ b/drivers/dma/switchtec_dma.c
>> @@ -1297,6 +1297,7 @@ static int switchtec_dma_create(struct pci_dev *pdev)
>>
>>  err_chans_release_exit:
>>  	switchtec_dma_chans_release(pdev, swdma_dev);
>> +	put_device(dma->dev);
> 
> Does switchtec_dma_remove() also need put_device()?

No, the release already happens in switchtec_dma_release() after the
device is removed. It can't be done in swtichtec_dma_remove() or it will
be potentially used if the device still exists after
switchtec_dma_remove() completes.

The patch looks correct to me but it will conflict with the patches in
my series waiting for merging:

https://lore.kernel.org/all/20260902062153.31048-1-logang@deltatee.com/T/#u

I'd appreciate it if my series could go in first and this gets rebased
on top of it.

Other than that:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thanks!

Logan



