Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC81F48F03B;
	Thu,  1 Oct 2026 16:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790873437; cv=none; b=YrVzNBAZTfJK+subBwEE3Amel71sbFXuUQnlgMJ7BaFqA3kn+2SECihL23lv/I6MgvPlwDuKxvJZv94vmJQ518nDuocIE4YafljbqX2IpaIMiXeQ0izv0xJ5Aqq+qFg1hHIoyRNykzGGhLuqLIFx2MDWK4YgqOWC8iAwiPx+E5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790873437; c=relaxed/simple;
	bh=r8pO6QpQM6dcjnj4TY/yCj0zMb+hk8RoPCR4UJ8xbeE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=p2LeoA1GrLEXzUUz8gumSIx1BZJs7/39IdSXy7QpYAsiSVjIRRKCMLWT3OfEKsql22OJWHVcj8BSSzZs/2aCUt4jHlpEkPJG3t2tnVwhEfpblM6cUV7MoDu5jfGMZ2wGHt0eDJzTScpH9hcdeFtjqT/4NUXwsxrwAn+Ig2dTbAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzllDJMg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzllDJMg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61FBA1F0089A;
	Thu,  1 Oct 2026 16:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790873431;
	bh=VCE70Xqx0B46vnr+CgpB+vq3RwjgwFf7PBue+DNSBOI=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=dzllDJMgP7keums/QpIrPBFbZUgxxJ0pkv9tpS0oRIT3SVNoakktc9eVzcT1SKZxQ
	 OGCWjFvYY44AA2WyPNV5pTxQzchGRXcxF0qETNNBQviKFoK8kUyx2gzvEv4hhNn/jI
	 4EkhvJ41S2KZvR1R2XnpRkZ+Avp3ByMSMBf6lBFzrZ52ljv/BFeuv1J9ou9G2fib0m
	 fTQSGvQ2MDaLZroevT5cRWcmZQDJ5m3XErmD0OJ3ucvqHNMGygh5R45RS7WOr7tKIf
	 xOZGXblMNpYafKj6vcg75NsLx0qqjEFuEU25oifgAwQUufSgJznMqjnZCkjCLX8P5o
	 8XE0o9QTjg9Rg==
Date: Thu, 1 Oct 2026 11:50:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexey Charkov <alchark@flipper.net>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] PCI/pwrctrl: generic: Fix leaking array from
 of_regulator_bulk_get_all()
Message-ID: <20261001165030.GA2699569@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930-pci-pwrctrl-kfree-v1-1-f09bbffd8da3@flipper.net>

On Wed, Sep 30, 2026 at 08:07:45PM +0400, Alexey Charkov wrote:
> of_regulator_bulk_get_all() allocates the consumers array and hands it to
> the caller, who is expected to free it at an appropriate time.
> PCI pwrctrl never did, leading to a memory leak.
> 
> Add an explicit kfree() for the consumers array.
> 
> Cc: stable@vger.kernel.org
> Fixes: 75996c92f4de ("PCI/pwrctrl: Add pwrctrl driver for PCI slots")
> Signed-off-by: Alexey Charkov <alchark@flipper.net>

Applied to pci/pwrctrl for v7.4, thanks!

> ---
> Split out from [1] for easier application per Mark's feedback
> 
> [1] https://lore.kernel.org/all/20260929-regulator-get-all-v1-0-e887c66a47f1@flipper.net/
> ---
>  drivers/pci/pwrctrl/generic.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/pwrctrl/generic.c b/drivers/pci/pwrctrl/generic.c
> index d56171e0ee24..4b6cbbb52248 100644
> --- a/drivers/pci/pwrctrl/generic.c
> +++ b/drivers/pci/pwrctrl/generic.c
> @@ -63,6 +63,7 @@ static void devm_slot_pwrctrl_release(void *data)
>  	struct slot_pwrctrl *slot = data;
>  
>  	regulator_bulk_free(slot->num_supplies, slot->supplies);
> +	kfree(slot->supplies);
>  }
>  
>  static int slot_pwrctrl_probe(struct platform_device *pdev)
> 
> ---
> base-commit: 6c2cb8b8b843d216ab549b678a0d8831c43153e0
> change-id: 20260930-pci-pwrctrl-kfree-b58621738902
> 
> Best regards,
> --  
> Alexey Charkov <alchark@flipper.net>
> 
