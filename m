Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208111A682C;
	Fri, 17 Jul 2026 12:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784292607; cv=none; b=grYheyh/9lO3Vl16bhnDz/SC7I1caNeZUzahtqf3GiXrWLQ0X0DPsFs+8swxTNgg9dHKrsiY3HqPawOzTY8tIQxGNjQfJs/SO4hZK/ZgeHgTsRBP5WCEdkBS3baJEKuyIHDvN4XyXJJdus3TobyQ+BtI9eQVhkkZqQBMM8ntbAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784292607; c=relaxed/simple;
	bh=6scq252vzFDkB2k3uZHAg5SRUTMs03L4Dbo/38R9CIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEr1d+pRHDS7bsszFBBiEzRYYFWt+Znbh0riJfeGMFhsIInlj3yuSn1fCuX92FgDA4N8f5BX0hlNTHQLQoNrkJ801syoIIetMtgAsPYsM+DGLNfxbUDp5Amz4LCPV+TKzy9KHqUeD8q9Qcd+kxm2SKIjiGyqaaz+xBAACD4TMxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MgUFcW61; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MgUFcW61"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6D51F000E9;
	Fri, 17 Jul 2026 12:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784292605;
	bh=olHHvZCnmhaWSaX05tv7HnV+bxUdsut9cITZkP03SJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MgUFcW61wGbEX20NDUpR5EtTRuE1PwVfuQocg8IQag9Gh/yrSbIOvKdO1GZC8ja3R
	 iKXrO09tMkT5o6/ADOWDqprnLtJCxlKyrj7PxH/YiDf+ZgoMxh0WBWnHxtJDtLeRzB
	 yM+cQRx8w4l9tKf4JYo06ENVLc2iOQgIXf5DhYHE=
Date: Fri, 17 Jul 2026 14:49:58 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Yaxing Guo <guoyaxing@bosc.ac.cn>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] uio: fix IRQ vector leak on probe failure and remove
Message-ID: <2026071752-morbidity-mourner-a2f9@gregkh>
References: <20260524064201.1177225-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260524064201.1177225-1-lgs201920130244@gmail.com>

On Sun, May 24, 2026 at 02:42:01PM +0800, Guangshuo Li wrote:
> probe() allocates MSI/MSI-X vectors with pci_alloc_irq_vectors(), but
> neither the error path nor remove() releases them with
> pci_free_irq_vectors().
> 
> Unlike drivers using pcim_enable_device(), this driver uses
> pci_enable_device(), so the IRQ vectors are not managed automatically
> and must be freed explicitly.
> 
> Add pci_free_irq_vectors() to the probe error path after successful
> vector allocation and to remove(). The issue was identified by a
> static analysis tool I developed.
> 
> Fixes: 3397c3cd859a ("uio: Add SVA support for PCI devices via uio_pci_generic_sva.c")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
> v2:
>   - Change have_irq_vectors from int to bool.
>   - Set have_irq_vectors immediately after successful IRQ vector allocation.
> 
>  drivers/uio/uio_pci_generic_sva.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/uio/uio_pci_generic_sva.c b/drivers/uio/uio_pci_generic_sva.c
> index 4a46acd994a8..e216436c9116 100644
> --- a/drivers/uio/uio_pci_generic_sva.c
> +++ b/drivers/uio/uio_pci_generic_sva.c
> @@ -63,6 +63,7 @@ static int probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct uio_pci_sva_dev *udev;
>  	int ret, i, irq = 0;
> +	bool have_irq_vectors = false;
>  
>  	ret = pci_enable_device(pdev);
>  	if (ret) {
> @@ -78,6 +79,8 @@ static int probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX | PCI_IRQ_MSI);
>  	if (ret > 0) {
> +		have_irq_vectors = true;
> +
>  		irq = pci_irq_vector(pdev, 0);
>  		if (irq < 0) {
>  			dev_err(&pdev->dev, "Failed to get MSI vector\n");
> @@ -139,6 +142,8 @@ static int probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  out_free:
>  	kfree(udev);
>  out_disable:
> +	if (have_irq_vectors)
> +		pci_free_irq_vectors(pdev);
>  	pci_disable_device(pdev);
>  
>  	return ret;
> @@ -148,6 +153,7 @@ static void remove(struct pci_dev *pdev)
>  {
>  	struct uio_pci_sva_dev *udev = pci_get_drvdata(pdev);
>  
> +	pci_free_irq_vectors(pdev);
>  	pci_release_regions(pdev);
>  	pci_disable_device(pdev);
>  	kfree(udev);
> -- 
> 2.43.0
> 
> 

Does not apply to linux-next :(
