Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D96255E43;
	Fri,  9 Oct 2026 01:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791510296; cv=none; b=NbAnX2Rf9GuXZMzkM/GC3vrHcwklfwHdEGprSZyz5HgfWeThHvAaQJxhqkToAeKpncUnwB9y568AS9/fsjZPRG2HBFKykKJOZGGQadi6f+wbrWy6GnwavfHO0WGVQ9+cQ+D+V6VoSz2DkqJoWFddesb82Hiom52WkHnLlNGx2QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791510296; c=relaxed/simple;
	bh=55/5YhVNQxZtPJigtWRe3PX9lLJsWU5+e8dtINtf1Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CrnV1oHLVf52YU6E/2ptHuIbavU3yB1PgTO2rBKdmMBiVg3+75xHcaHG1AI2++MNv85n2T6ikWz58Ux3UvCpnD2+5+0hABQorbSJysZH9GAxzZJ8va85pEgtuozOSR2wNmCb5dsqvqFfG/eRndoRFfwrGuJzKieXZQusiBUTQfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYQ+eMiH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYQ+eMiH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1751F00893;
	Fri,  9 Oct 2026 01:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791510295;
	bh=1/A3KblgG7O04DY5iw4QbfZJttJjRBoisFvTrrWGsRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cYQ+eMiHoXmcf4WXd2UL3ryIK4DVGq7mEtGfPIWBrgSb16LXVAbiQp9vWRdVHHCsl
	 Hl/JPKhJOvYrgSCkZVS0b/qg2j/EsRmrwVhTH2UuAsaTrA+/UBvdNkqLVkOWO5Kb/G
	 TbIchySizIAO6xqm4MVXiFLvXV7hnXNvXfym3FbJb/bElmPwPkBvTMsMphoLYpvQ9o
	 Ci8kyFaeanZG9Aj9t1+6/scueHNNwvW/WSxX4oumuLerfq7N4uxG00948/wXdxleU/
	 eU9CG0UI23pZ0M8BhK71v/bbsm7jdgKo8L4cat07HBvWkxg/+aeypzkNr7+fmSQy1n
	 3g86bsq6kq8lg==
Date: Thu, 8 Oct 2026 18:44:54 -0700
From: "Peter Chen (Qualcomm)" <peter.chen@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: felipe.balbi@linux.intel.com, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	pawell@cadence.com, rogerq@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb: cdns3: Fix PCI function reference leak in
 cdns3_pci_remove()
Message-ID: <ashHFv7l3XWrqYzY@hu-petche-lv.qualcomm.com>
References: <20260917160622.2161638-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917160622.2161638-1-vulab@iscas.ac.cn>

On 26-09-17 16:06:22, Wentao Liang wrote:
> cdns3_get_second_fun() returns a device obtained with pci_get_device(),
> which takes a reference to it. cdns3_pci_remove() uses the device only
> to check whether the second function is enabled and then returns without
> dropping the reference.
> 
> Release it before returning.
> 
> Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Acked-by: Peter Chen <peter.chen@kernel.org>

Peter
> ---
>  drivers/usb/cdns3/cdns3-pci-wrap.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/cdns3/cdns3-pci-wrap.c b/drivers/usb/cdns3/cdns3-pci-wrap.c
> index 1ad722e7704d..6639751ab22f 100644
> --- a/drivers/usb/cdns3/cdns3-pci-wrap.c
> +++ b/drivers/usb/cdns3/cdns3-pci-wrap.c
> @@ -188,6 +188,8 @@ static void cdns3_pci_remove(struct pci_dev *pdev)
>  
>  	if (!pci_is_enabled(func))
>  		kfree(wrap);
> +
> +	pci_dev_put(func);
>  }
>  
>  static const struct pci_device_id cdns3_pci_ids[] = {
> -- 
> 2.34.1
> 

-- 

Thanks,
Peter Chen
