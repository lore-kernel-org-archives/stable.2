Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CEE41B8F1;
	Mon,  5 Oct 2026 23:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791242467; cv=none; b=HFD3VKeGI65cQ8PCasnzv56PPyVQ1a32Q4YHXs261gPxcUw07e3Q+yj1pF0gXHL7cR4OvTueXb43F2smjjH3hzdyq+jUEXrG7ps+frNuC4ZAOIzBGOwA36fC9/8hTuzE2lOHVoPttUBlt2xepIglnZU3p5AfRYuCGTfWdfCpsOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791242467; c=relaxed/simple;
	bh=U8H8t6VZUBqJXSoMLg+f3VI8eCbVPhx95bpU8BxAxfA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=t2gHea8vvluhmdGpUbl2KhwrwJaZbyo+c1+S6nhBOcEfhFaT/xLJOmpeYLW5LS5nay06UlpNKSklX23pApKSx61yx8wg72MXjvE59B5gRH1anQShGfF14yrW8kYPMaaRgm0e2HV0mYLtZH+whsqs5OI5dNs7irFaLYW0YXNlfxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AupBNlp4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AupBNlp4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 151C41F000FF;
	Mon,  5 Oct 2026 23:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791242464;
	bh=nKKqPZBUkVLCBCTdKy2DeYWtduq1vHNP7GVzJM1VCuE=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=AupBNlp4cCGhEHQdwVrxFh4v+sUyRJbmVtWvadsZqZWkdfGAyg9y06cle33RAoeLs
	 hZMcTpa1jXe4o2va/7ow9DiwpUiy43Hn8nlkpV4Lb7kxO2PnPk1Auq4QpVzBXwobKU
	 QJZM8hD6B5aE00IAqeTxEljVKE8dIDZ33Ht3ROU2Ms+vUcmEu6kkqMq8rNMdnewqUg
	 Wc6/iEeweK0QkPW+LtKRPzFxKGAsfK+wmvhKAKcCzzL/1sTpTZmZAfJfeXKxLDIgb+
	 +4AD8q8KzLI1CdpkUg0BKyLtKbMisXRi53q/uxny1IFd648Fpzgscg0owP5m9eqXAy
	 MerV4t9yorcSg==
Date: Mon, 5 Oct 2026 18:21:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: bhelgaas@google.com, alistair@alistair23.me, jic23@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] PCI/DOE: Fix double free of a duplicate feature's
 sysfs name
Message-ID: <20261005232103.GA643044@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261003102221.59894-1-donggeunyoo.kernel@gmail.com>

On Sat, Oct 03, 2026 at 07:22:21PM +0900, Donggeun Yoo wrote:
> When a DOE feature is reported twice, sysfs_add_file_to_group() fails
> with -EEXIST for the second copy and pci_doe_sysfs_feature_populate()
> frees that attribute's name, but leaves the pointer in place.
> pci_doe_sysfs_feature_remove() frees every name again when the device
> is removed, or when a later feature fails to register, so the name is
> freed twice:
> 
>   BUG: KASAN: double-free in pci_doe_sysfs_feature_remove+0x117/0x1b0
>   Call Trace:
>    kfree+0x11a/0x420
>    pci_doe_sysfs_feature_remove+0x117/0x1b0
>    pci_doe_sysfs_teardown+0x90/0xf0
>    pci_remove_bus_device+0x128/0x2e0
>    pci_stop_and_remove_bus_device_locked+0x1d/0x30
>    remove_store+0xd2/0xf0
> 
> Clear the pointer after freeing the name.
> 
> Fixes: 2311ab1820fe ("PCI/DOE: Expose DOE features via sysfs")
> Cc: stable@vger.kernel.org
> Suggested-by: Alistair Francis <alistair@alistair23.me>
> Assisted-by: LLM
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

Applied to pci/doe for v7.4, thanks!

> ---
> Changes in v2:
> - Keep freeing the duplicate's name in pci_doe_sysfs_feature_populate()
>   and clear the pointer, instead of leaving it to
>   pci_doe_sysfs_feature_remove() (Alistair Francis)
> 
> v1: https://lore.kernel.org/all/20260928035035.252394-1-donggeunyoo.kernel@gmail.com/
> 
> Tested under QEMU (q35, cxl-type3, KASAN) on 72d3fcf802c4. The device
> reports its CDAT feature once, so a test-only change either registers
> its DOE capability as a second mailbox or inserts the feature N extra
> times into one:
> 
>   case                                   before           after
>   no duplicate, remove                   no report        no report
>   no duplicate, a name fails at probe    no report        no report
>   two mailboxes, remove                  double free      no report
>   two mailboxes, 3 remove/rescan cycles  3 double frees   no report
>   3 duplicates in one mailbox, remove    3 double frees   no report
>   2 duplicates, a later name fails,      2 double frees   no report
>     probed twice
> 
> The doe_features listing is the same before and after in every case.
> 
>  drivers/pci/doe.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index ac95b1d2d9997..6b5d9ba8e9697 100644
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c
> @@ -208,8 +208,9 @@ static int pci_doe_sysfs_feature_populate(struct pci_dev *pdev,
>  				pci_warn(pdev, "Failed adding %s to sysfs group\n",
>  					 attrs[i].attr.name);
>  				goto fail;
> -			} else
> -				kfree(attrs[i].attr.name);
> +			}
> +			kfree(attrs[i].attr.name);
> +			attrs[i].attr.name = NULL;
>  		}
>  	}
>  
> -- 
> 2.53.0
> 
