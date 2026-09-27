Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E533C3EA97A;
	Sun, 27 Sep 2026 22:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790549410; cv=none; b=DypliISdELAWUXrNxBV36DLNO9wSqaOsATdanEFjeC/MwJ98kWG2PEZ1pDJRT8DNp+3kweMjHwYRuitYuYX005IBhr+js0gahwSMsZTC8Rdb2FJnso0i5Ke+S4SQ8Ueqy2HrUhJ7Uey/OEnIiBGPjf0mR14Td2pkuwdnAkdXXGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790549410; c=relaxed/simple;
	bh=/aCovl8RC0lzVIS7AQKYGh0WIGySO+B7ueAYz7HP4Bw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k92WMvP+YzvfLKu5WkQp4+7JQ1arMM9HJ2WNWJ5UGxFI+3OXNWHbzhXJ4Mz+lF6hLG6lYPYWdWTo3vkjDJI/mKIOVDgZgKsVG9r5hz81qj2BZSSzIPxBJRt3HxetPSXkM1niNIi8SGWFGX/dOD5kpjE7cA+effdSAGkeSOQf5pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRh1OBiB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRh1OBiB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5991F000FF;
	Sun, 27 Sep 2026 22:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790549408;
	bh=MmIw28LazQjnyo5PLms13QRbrvuqaROTWE9kzh5dsd0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eRh1OBiBveklXrJl07N/c1ijew76Eo2PYq39QJthaynDmuL48HN4EPJe86y/ZWlBP
	 Sp1qZpVNdoe0/FNFoL9wJnU1WETWNGNm/vR9U5JALoul5sq9EKDqGD5V3Ay0vTKLXs
	 IY3tK92ncocacEEGTqT47cVCNSKPRDDNTL75WlUstw2uwOpMay0nY4IORU/M1jlKu3
	 keLUBFwd7C1Cp8H86ngIRwKWcspvZ39M6raFXABEYFZVRgNHoVcN1KYpRqtlVmYCqq
	 Qco8zEvFb89/kBE99c52EkFvkqFJtoo4bazwiHRs3JLdxWZr+w76BUp5Q71IZjydex
	 0u/9vWMww6fiw==
Date: Sun, 27 Sep 2026 23:50:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jiale Yao <yaojiale02@163.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, Ira Weiny
 <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] cxl/acpi: Check ACPI companion before use
Message-ID: <20260927235001.01316b18@jic23-hlaptop>
In-Reply-To: <20260926071605.3013893-1-yaojiale02@163.com>
References: <20260926071605.3013893-1-yaojiale02@163.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 26 Sep 2026 15:16:05 +0800
Jiale Yao <yaojiale02@163.com> wrote:

> Platform drivers can be forced to match devices outside their ID tables
> through driver_override.  cxl_acpi_probe() assumes that every bound device
> has an ACPI companion and dereferences adev->dev.bus without checking the
> result of ACPI_COMPANION().  Force-binding cxl_acpi to a platform device
> without a companion therefore causes a NULL pointer dereference.
> 
Given I had this drawn to my attention earlier (thanks to Uwe)
let me draw attention to an attempt to add a flag to remove the need
for this sort of defense by blocking driver_override.

https://lore.kernel.org/lkml/20260922-driver-override-opt-out-v1-0-58c35ded3b83@nvidia.com/

So maybe we can replace what we do here once that lands.
In the meantime it's a valid bug so 

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> This was reproduced by setting the driver override for the pcspkr platform
> device to cxl_acpi and binding it through sysfs:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000280
>   #PF: supervisor read access in kernel mode
>   RIP: cxl_acpi_probe+0xf4/0x220
>   Call Trace:
>    platform_probe+0x4d/0x80
>    really_probe+0x106/0x370
>    device_driver_attach+0x4c/0xa0
>    bind_store+0xd0/0x100
> 
> Commit 2b3a5dabe89e ("platform/surface: acpi-notify: Check ACPI
> companion before use") fixed the same force-binding issue in another
> platform driver.  Check the companion before setting up the CXL root and
> return -ENODEV when it is absent.
> 
> Fixes: 7d4b5ca2e2cb ("cxl/acpi: Add downstream port data to cxl_port instances")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiale Yao <yaojiale02@163.com>
> ---
> 
> Notes:
>     Changes in v2:
>     - Move the ACPI companion assignment immediately before its NULL check.
>     - Reorder local declarations in reverse Christmas tree order.
> 
>  drivers/cxl/acpi.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 3b818adbd38b..fb09a5ff48c1 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -885,13 +885,17 @@ static int pair_cxl_resource(struct device *dev, void *data)
>  
>  static int cxl_acpi_probe(struct platform_device *pdev)
>  {
> -	int rc;
> +	struct cxl_cfmws_context ctx;
> +	struct acpi_device *adev;
>  	struct resource *cxl_res;
>  	struct cxl_root *cxl_root;
>  	struct cxl_port *root_port;
>  	struct device *host = &pdev->dev;
> -	struct acpi_device *adev = ACPI_COMPANION(host);
> -	struct cxl_cfmws_context ctx;
> +	int rc;
> +
> +	adev = ACPI_COMPANION(host);
> +	if (!adev)
> +		return -ENODEV;
>  
>  	device_lock_set_class(&pdev->dev, &cxl_root_key);
>  	rc = devm_add_action_or_reset(&pdev->dev, cxl_acpi_lock_reset_class,

