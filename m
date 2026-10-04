Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E41A3C3F58;
	Sun,  4 Oct 2026 16:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791130507; cv=none; b=vEvzs+i2WZjguwgqDg2Az/1zuhbsM7jZ/1l3P6ozonpoFXUUG2neOHd5ZeLYghkdj4mUyDe4S9Fq8Nn9WBTJPlUXUxI1f2ncvMVJ2UkTNxB5oeDxaZtW3ipS5QSiDT6OenGFTlSgSgWs6dPhAHnU0NzYaGf17kbhwBfSlWa80PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791130507; c=relaxed/simple;
	bh=/yGUGyC3n9bAKXHBC260Zvhh5Il0MXZUZkwKdT2YcHg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PSc9pM7hnIaVS2SjgijsmsFxg6e7vkJnmj4K3/hHR/7dTT8yx2R/v/8E4schWFTnjMXercQZoKaS3dsc49ZrzaXbM25u1w3C35jcWrcbY9fjiCCgWVMs5g4IFRoLjZ0i5UjTIEALD3Yna3C1sTMIwkMR6vyV73y3zp4b9ovD4AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UACW3ZXp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UACW3ZXp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CFC21F000FF;
	Sun,  4 Oct 2026 16:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791130505;
	bh=xwilz9F0BDYfB9INM/Mvr1+p43J++RbCj0DvXe+hqfQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UACW3ZXptEAw4xKmFMNeTan7/0xU3c7FM0fD+MbLrZF9gtl0SicNbm2UERQwkBVtr
	 tzohNYjF1AjlooksDosn06J7QPYjMYTt7PfMjnbYv7nv4hjDr7N6YzV8CytN/KKTy6
	 vBxdj+Db9pZ93tbyJiFC8zrmYku6GAPRzYe3J/U0EerafzbbARq8hWCdIR2uPzZN5e
	 e3cmqzsI5u5oxiFnCWnfFSBnqlV0SFO+Xv7xps4XP2gUMg49WGxjDdYX60UC7OqHwB
	 ClbEvKOHfO0KdkrmAUHMKXKbIux6o/x+PoEAsrYpplvrb3LOsgMyHVmAH7HHXyedEN
	 /rVVb2Vqvf+bw==
Date: Sun, 4 Oct 2026 17:14:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: bhelgaas@google.com, alistair@alistair23.me, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] PCI/DOE: Fix double free of a duplicate feature's
 sysfs name
Message-ID: <20261004171459.706c8e0d@jic23-hlaptop>
In-Reply-To: <20261003102221.59894-1-donggeunyoo.kernel@gmail.com>
References: <20261003102221.59894-1-donggeunyoo.kernel@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  3 Oct 2026 19:22:21 +0900
Donggeun Yoo <donggeunyoo.kernel@gmail.com> wrote:

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

This one and related are valid cases that real hardware might well do.

>   two mailboxes, 3 remove/rescan cycles  3 double frees   no report
>   3 duplicates in one mailbox, remove    3 double frees   no report
>   2 duplicates, a later name fails,      2 double frees   no report
>     probed twice
So this one is a hardware bug I think.  I guess maybe the DOE spec
may not strictly say you can't do this (I'm on wrong computer
so haven't checked) but it would be very odd.

Overall I'm never keen on code that relies on an error path to smooth
over a valid condition.  We can't deduplicate in the xarrays for the
multimailbox case unless we do a combine of the xarrays and use
that instead for the registration.

That route would be a rather heavy weight fix though so I guess I don't mind
this one that much.

So argued myself around to this approach.
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>




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

