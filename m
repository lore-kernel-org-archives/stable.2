Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FCD48C8C5
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 17:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781024836; cv=none; b=DkzycANWjVRAK365nLmDKuxjRGoIvO6aeGjrkyeWtCxbkPr86+GYdW30wmqLOjIxV3Sz5Bozinc6x2iHku1iaVrsgz65wOBO6pUuCTSdQRM1RO7EFwxch61uLlLTJpS0sgB3LCUVSoN9brEvcpgVM8dcs24CD5i4bsYWhxzNh30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781024836; c=relaxed/simple;
	bh=RFvWghnlKdtFZoSnaeTAwrwguE/F1fpnRlI47Dca2n8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtLWsyQESGueDrve9lexaH5qm7OwEKxgc49GybI+YbQrEutLCFXExoKFgC8kpMNqlmVEXNtTQFjCM6RuwsUOPsCh8LACrpUeiYwWWoJCUITaecfAxO7yuw1G2tFzyDZoTeGwauBgKMGax89kWD0tKP2pR3zvJNhDI6+2Qp0IEQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=AtnKYQ0J; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AtnKYQ0J"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5177b9a02bdso83371341cf.1
        for <stable@vger.kernel.org>; Tue, 09 Jun 2026 10:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781024834; x=1781629634; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/g68/vwtxQJn0VXkFA+3HliWO9dvMA4L/BKpylMlbCs=;
        b=AtnKYQ0JOO+B+Uqo0NmWA3RffLLn9PZDBRJNN4z8BI6AEW9HUQERGotFB5GRFosydd
         Z/HNGDPrVyduZBBOcERVKds4x1yfYO8UkTddvthvLzeeV7rlzCuxK/q50fOrcT6XOYZG
         RUUKnky5ddg7b6El0caHR7zEUE3BDwF6WEn1JhzzZXxoSYurYAi37Zu+Kh9Et79mOx8F
         na00X8sgEnHoE9c1/vhH+dcSn7keZ1JFF8h4SHE/6P6FhiS8lShOsgmjodBYuSTGXbQB
         zJ/9OumFz+d8F0V9CbA5wuyBf35Q4cSGBUrKtWl6qXGkiSfz/raIM46Vw8Pii+PE4VlU
         BCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781024834; x=1781629634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/g68/vwtxQJn0VXkFA+3HliWO9dvMA4L/BKpylMlbCs=;
        b=XiXkrxppUPi5QQloN3VsUQyhNnLR8DmDTkz3opcOB1LcY4xwgurXVwfDT9Lt4tVyrb
         FuKyne7SRv47O5b6baTZw2pTRGHjgExstOlH3MxC++FqY4Okgw5ndO3vQZUNieaWDis6
         W5UztdBjo42CMaZYbqN+0UYck+TM/3fiuePpy+uPUzer4zNYd9ZB8i8g92TTWnTYgvAW
         +PV8a20mAK0tbOO3H/NinIUMj3Qt+3oUIcnsY4Z1c8lAFigQs2mr2BOUP1yQKX1C8PZJ
         FwUrjw5ZPQwtQZlllnlmmMyrUbILf+lnh5HaTh0d5u5Euu5/oDq/31VBMYsj1j56Te8Y
         6rNg==
X-Forwarded-Encrypted: i=1; AFNElJ9VjrPTg+Ej595FLPb3gzwAgdhUHDRzOUnGCUOb16/d1632eGpfEL/AQc431JKw5H6qoBAP70Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8lTseg92SCHyecs29XncV+0zvakLBAvRtRfut6LuizBsYa4Fj
	a7CcPLP6/rpY/aMYq9OALpUdyR9K7YZ0BHPnYYFSZCHytC3ezJ59OzjjTKZdSugaW2jEOZSQiWk
	xdD+p
X-Gm-Gg: Acq92OEMDhciXv8jEJXZb3sS/4INCuzPa5l/zoN4y+WHGGYpwTODPhcZMFaKMAzMIgD
	B+tY8A+EKV/M0dhrsUP3s1zk7gwD/YNIKjkkGmwW5ir2IFOMaCNmhkY/A9NYIG2zoYVQthkINoN
	9HZ0BmGAE5JQDmwisn8z4yuEG7G0PCun8OBYoP5JqxnvHZ/HuBPVtWMh34u03aZqXhxE2M0BALL
	lycDIdTfOSZNkuwAhfzsb3jv9gjo5b89R0zwoRPoMir7pO6NplzhOCUhn8lOKN795XJxa2sU74p
	r1zOKkLLgHCpUYK4nI7X5lYJNqM+68zlE5Z7Fvv9zolBQrPxTXnMYbsRiO2PdjKei10ohEej+eP
	StKyiR1qbGpExxrbP6kQcb0m2aOBBLFC+9A6a0OpBf1XXisOxQmsbZDeVYQ5LHdZV6nyrvKQEZO
	Gtb1dhVKRPCy+Kvx4Gog12ia42c5C3X81eVV7bGjiqnvB5UVMzRi6fE/3W5aPddQBk8cTZTSMRv
	xkiQRG1ImokF3mE
X-Received: by 2002:a05:622a:114c:b0:517:1481:54a with SMTP id d75a77b69052e-51795ca0588mr328689211cf.53.1781024834216;
        Tue, 09 Jun 2026 10:07:14 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51789407da8sm162209711cf.19.2026.06.09.10.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 10:07:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wWzuz-00000002IEI-0OsB;
	Tue, 09 Jun 2026 14:07:13 -0300
Date: Tue, 9 Jun 2026 14:07:13 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: kevin.tian@intel.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iommufd: fix refcount leak in iommufd_object_remove()
Message-ID: <20260609170713.GM2764304@ziepe.ca>
References: <20260609032243.182433-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609032243.182433-1-vulab@iscas.ac.cn>

On Tue, Jun 09, 2026 at 03:22:43AM +0000, Wentao Liang wrote:

> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> index 8c6d43601afb..2fe790c2c69e 100644
> --- a/drivers/iommu/iommufd/main.c
> +++ b/drivers/iommu/iommufd/main.c
> @@ -266,8 +266,10 @@ int iommufd_object_remove(struct iommufd_ctx *ictx,
>  	 */
>  	if (!zerod_wait_cnt) {
>  		ret = iommufd_object_dec_wait(ictx, obj);
> -		if (WARN_ON(ret))
> +		if (WARN_ON(ret)) {
> +			refcount_dec(&obj->wait_cnt);
>  			return ret;
> +		}

The WARN_ON is a big clue here that the leak was intentional. If we
free the memory we know is still in use something worse will happen.

Jason
