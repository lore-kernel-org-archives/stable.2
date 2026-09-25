Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393B04FB9C4;
	Fri, 25 Sep 2026 22:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790376444; cv=none; b=D2h+k/o+TaV0GQo6JklkT21HsDTGpyAIgwo9AyymSdZr0fadQ5lhqSDRVYPGS4QhuPyt5S+wXWOV4xSumJgD2XJo2ljHFoJmD2sOo4a4R4NS1WAzTvjEN+Ipvz7A/54/5qdmsWabwISk4kjVuSHtrdOX3hoyw9A8wrmYAP0KCJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790376444; c=relaxed/simple;
	bh=Rgf8udR+rQjJzAqykPz3wFMIa3epGbIJWetZmofNUFU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gQ1V9JaEsW51lDZSFif8gwfZpb+EcRqTfMlJJUh5K1q9VXt08chimSGxUjI8FdhEgUzFsvBoUaOeWrQnlfYZYq/IvkvB6z8MAOaqNwTd8R+UsaeVvDN0fye32UcBrUHlUhzfQ37XeZ4oYDAZYo7YIb5z/c5NNl0/cfggnVNUqUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+W0FEql; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+W0FEql"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8358C1F00893;
	Fri, 25 Sep 2026 22:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790376441;
	bh=WV+hFf4p0LF2j1rjEGjSxXXM4uBQ5tn19LUpagYhO8U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=G+W0FEqlsV5CI1tI6dz67kTLugYVNUu43SODlzX8KrmfdIKQxkwI0+q+4KdGy4ghN
	 XOTvMe4oJNJjiMRC7ggVT5ZnpzUQyXgyH64N/TjXGPUCThL0YaMhfEiex2vmlLuV7g
	 qd5e1eyksAQP4+1h403U1leMZvRpGxs42BKyPseZXgWr0IP53msb1eo2lRcI6IY+fo
	 qHZXtaX6yVGtwCUQQcOUQcARBB52+k+vLV0XWS0/EpEcuIiFxGoWiGnUtKgTNecRuW
	 ZW8IIahdMtH0acJqQD7vs7eS2ydgwIEJPeGmHvgDYB+PflXwo1mQI7s5Gp0cuS1Anr
	 KJ6MqUoYej0kQ==
Date: Fri, 25 Sep 2026 23:47:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jiale Yao <yaojiale02@163.com>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, Ira Weiny
 <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] cxl/acpi: Check ACPI companion before use
Message-ID: <20260925234718.37fdcc56@jic23-hlaptop>
In-Reply-To: <20260924164247.rsb4h7qjx5bvrthg@offworld>
References: <20260924125404.923551-1-yaojiale02@163.com>
	<20260924164247.rsb4h7qjx5bvrthg@offworld>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Sep 2026 09:42:47 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> On Thu, 24 Sep 2026, Jiale Yao wrote:
> 
> >Platform drivers can be forced to match devices outside their ID tables
> >through driver_override.  cxl_acpi_probe() assumes that every bound device
> >has an ACPI companion and dereferences adev->dev.bus without checking the
> >result of ACPI_COMPANION().  Force-binding cxl_acpi to a platform device
> >without a companion therefore causes a NULL pointer dereference.
> >
> >This was reproduced by setting the driver override for the pcspkr platform
> >device to cxl_acpi and binding it through sysfs:
> >
> >  BUG: kernel NULL pointer dereference, address: 0000000000000280
> >  #PF: supervisor read access in kernel mode
> >  RIP: cxl_acpi_probe+0xf4/0x220
> >  Call Trace:
> >   platform_probe+0x4d/0x80
> >   really_probe+0x106/0x370
> >   device_driver_attach+0x4c/0xa0
> >   bind_store+0xd0/0x100
> >
> >Commit 2b3a5dabe89e ("platform/surface: acpi-notify: Check ACPI
> >companion before use") fixed the same force-binding issue in another
> >platform driver.  Check the companion before setting up the CXL root and
> >return -ENODEV when it is absent.
> >
> >Fixes: 7d4b5ca2e2cb ("cxl/acpi: Add downstream port data to cxl_port instances")
> >Cc: stable@vger.kernel.org
> >Signed-off-by: Jiale Yao <yaojiale02@163.com>  
> 
> With Dave's comment,
> 
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Andy Shevchenko was looking at ways to have drivers set a flag to 
disable matches on driver_override. Not sure if that is still ongoing.

+CC Andy

Jonathan

