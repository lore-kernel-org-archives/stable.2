Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DC941A506;
	Thu,  1 Oct 2026 16:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790873173; cv=none; b=eey1kXo2L5Ljuy62Bhv9lbIii4PBSLqZGnb5V7zLYMiMDvHnTzWo2y3U0v+/XmPszXmRDZm4AgkzG4ExgyriAcLCPusdD2Om5H1WzwC7aRJdUo5MNVMpdXqvZmizTU/nSHYMeEdA7dyVEjM1HK/bOCq3okywIJsQpSAc/zKXkLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790873173; c=relaxed/simple;
	bh=zjxqxU3b4fkrwKTp4/8lY/ybox0FzPWTHeuZcdFJgdM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=e/ZgJ1IfKf0nFlFIu50JRnmg0DUdTbvXXONa2q18RBx143uPAn9WVkVt5O9lYy8w3b3jjymbJ1h3ugGjbgNH8zw3C0AfYDezseejrghQHY2PutbebJYrctL58HTMRSnqhYBrZ3LhJjxBX/MEv0ANaTVfdJZkR2LhuuVG0QG/H4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hadL3l5u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hadL3l5u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63F8A1F000FF;
	Thu,  1 Oct 2026 16:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790873171;
	bh=UxPmE4+Xc2qc1fGHyZtz4MWA24egywYQp7yRavpqEsU=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=hadL3l5uCsw68DMOhWSUyUa/D8PmXUlbzSk+nD6FSMxfTNqYKvrant9OyEc3Y9Lyy
	 k8BNe31SWNeCqmgvwfSO79Pr2JYFnxKncihDAAlp92Hn6GW359KRGMm3ODGQ4VEwGf
	 OpOkODxrmo0Wa/tY4yzcOC0YVHU27F0LUpdzELbCKPR+rQOAjWqU9tMbG9BvLAan5u
	 aG29GHiU+noAv4DEmRveht7qFwaG10CG65bPG5n/KGncqEsh91UUqbZwgm3FXCnqYm
	 8FTG3lkDZw5UhDwL7gk84y5w9EWksAl0vg9jE6zKGF3PNH6NCEUKbTBNlnCJm4Edsl
	 LbC2o5TLwmTEw==
Date: Thu, 1 Oct 2026 11:46:10 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexey Charkov <alchark@flipper.net>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Corentin Labbe <clabbe@baylibre.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 4/4] PCI/pwrctrl: generic: Fix leaking array from
 of_regulator_bulk_get_all()
Message-ID: <20261001164610.GA2695820@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929-regulator-get-all-v1-4-e887c66a47f1@flipper.net>

On Tue, Sep 29, 2026 at 02:05:49PM +0400, Alexey Charkov wrote:
> of_regulator_bulk_get_all() allocates the consumers array and hands it to
> the caller, who is expected to free it at an appropriate time.
> PCI pwrctrl never did, leading to a memory leak.
> 
> Add an explicit kfree() for the consumers array.
> 
> Cc: stable@vger.kernel.org
> Fixes: 75996c92f4de ("PCI/pwrctrl: Add pwrctrl driver for PCI slots")
> Signed-off-by: Alexey Charkov <alchark@flipper.net>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I assume this will be merged via a non-PCI tree.

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
> -- 
> 2.55.0
> 
