Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BD533A9C1;
	Sat, 19 Sep 2026 05:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789796201; cv=none; b=pJ0vaWXf2PuhOyhz1qFUwazYCefPb9XaM/Op5tLAgITYmvvPShefaxHigOFD2sNBqmNoo+LQl526Yu/52z/m9/WfZ+LlKO0UNBuWHRUBQnMcM2Z1NYCHu45o8gYCOv0Aj6Own3QcgjDzCChX3gmERNt6Q6MPcQJH8Vonr7thtAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789796201; c=relaxed/simple;
	bh=xK570UFZdihpw1tBM0MxTq3ebSrcsTZQAI+gE4dee98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPI7b28sb+dBayIaiD4+UGCnW0MdUvGdkM7xGcaT4+2F+ARXFOm6UuXzY1shpOWTFMdfcdEDlFDdbzvs6cG4wM2TCEjkMdDUgGMxxiaapbW9DKfk7Y0DIwl7BWeoHRzJNtV2F85WtHYZGEysDX5MYo8WrQi56zh8kfgAW0kzst8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=IYgasbZ/; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="IYgasbZ/"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0D5D940E015B;
	Sat, 19 Sep 2026 05:36:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id hcQukOco_kdK; Sat, 19 Sep 2026 05:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1789796186; bh=IwNQnUniYJhW9bemEAzNT904n7U6MDt2FIn6/vuc80c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IYgasbZ/5DgDU556WulY8aF3T2Cx4vk4oe9aQbBbt87Q1MiU3x/ZsHu7e3WHwyXfj
	 VECAlFTZxitoH5ZyChcvqPJWeU6P8WuSoBHECbbrCeqea1FmQcr8w3P3MnqOqNCnDC
	 LUolrlw2jN4yVJ7KqQ9A+SE1tyL6XsnvJWkgGJG5EXYIe0v5qeQOwh9QWfCnN8pDt3
	 KLz/EJnvwWYooMwv4fyzfBVbh7KKDdOhgbgleish2SuDX1PFCKLs4FXsnxKR1qlWly
	 pPfJ65SFxC3GbYJFvGKZtmbpdiWUT7t9wqCs+HUXuqISRoIAE51y0UhNNI3ACcpXj5
	 y4704SM9VGiIooZnmRY660PBLVGzy6S0Wt0M8reiyOMvC4XykQqNSp25Mycjk79Je+
	 740WZ9Y2CLOcXYrjxQNgzjOrOrRpxvAW25KMeyTUotC35dhhYkotYpNg8c1CpSZxH9
	 nA8pmZgHjhlPLz2FAfIO6Qt14g4OP9ZGSa2mz0ZvhmNsohKnPepnDQs70j7BD5t5sy
	 KkDKP8KbZukuq5xCPTokhZG8sfeqsvnJkQffgSgQlB+SUMh+CiMIT0D0ZTnP+xlBjb
	 6rivAXFfBu1v++srSzWuG65H6PaEoyuLnANbIyXGOVcwcOcZv9Wlzsz+3GvnN9oT8L
	 1NjOCkkA1mwM+DJUlLJm5K/A=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1C9BF40E00B9;
	Sat, 19 Sep 2026 05:36:16 +0000 (UTC)
Date: Fri, 18 Sep 2026 22:36:14 -0700
From: Borislav Petkov <bp@alien8.de>
To: Leo Zhuo <qzhuo@nvidia.com>
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"dougthompson@xmission.com" <dougthompson@xmission.com>,
	"juhlenko@akamai.com" <juhlenko@akamai.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tony.luck@intel.com" <tony.luck@intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] EDAC/i3000: Fix mci_pdev reference leak in
 i3000_init_one()
Message-ID: <20260919053614.GFaq4fTt4vElAM_4p6@fat_crate.local>
References: <20260916091415.1997923-1-vulab@iscas.ac.cn>
 <CY8PR12MB7290DC961329B90C7A836907D1B92@CY8PR12MB7290.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CY8PR12MB7290DC961329B90C7A836907D1B92@CY8PR12MB7290.namprd12.prod.outlook.com>

On Wed, Sep 16, 2026 at 02:53:02PM +0000, Leo Zhuo wrote:
> > From: Wentao Liang <vulab@iscas.ac.cn>
> > Sent: Wednesday, September 16, 2026 5:14 PM
> > To: akpm@linux-foundation.org
> > Cc: bp@alien8.de; dougthompson@xmission.com; juhlenko@akamai.com; linux-
> > edac@vger.kernel.org; linux-kernel@vger.kernel.org; tony.luck@intel.com; Wentao
> > Liang <vulab@iscas.ac.cn>; stable@vger.kernel.org
> > Subject: [PATCH] EDAC/i3000: Fix mci_pdev reference leak in i3000_init_one()
> > 
> > 
> > In i3000_init_one(), a reference to the PCI device is taken with
> > pci_dev_get() and stored in the global mci_pdev even when
> > i3000_probe1() fails.  On that path i3000_registered keeps its initial value of 1, so
> > i3000_exit() skips the pci_dev_put() and the reference is leaked.
> > 
> > Only take the reference after i3000_probe1() succeeds.
> > 
> > Fixes: 535c6a53035d ("drivers/edac: new inte 30x0 MC driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> > ---
> >  drivers/edac/i3000_edac.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/edac/i3000_edac.c b/drivers/edac/i3000_edac.c index
> > 9065bc4386ff..d4ee6e185c80 100644
> > --- a/drivers/edac/i3000_edac.c
> > +++ b/drivers/edac/i3000_edac.c
> > @@ -461,10 +461,13 @@ static int i3000_init_one(struct pci_dev *pdev, const
> > struct pci_device_id *ent)
> >                 return -EIO;
> > 
> >         rc = i3000_probe1(pdev, ent->driver_data);
> > +       if (rc)
> > +               return rc;
> > +
> >         if (!mci_pdev)
> >                 mci_pdev = pci_dev_get(pdev);
> > 
> > -       return rc;
> > +       return 0;
> 
> For a successful normal probe() and exit() path, 
> the extra mci_pdev reference is not released because i3200_exit() skips pci_dev_put().
> How about the following fix:
> 
> diff --git a/drivers/edac/i3200_edac.c b/drivers/edac/i3200_edac.c
> index d600b6c05217..ddfbbbbf8147 100644
> --- a/drivers/edac/i3200_edac.c
> +++ b/drivers/edac/i3200_edac.c
> @@ -439,10 +439,13 @@ static int i3200_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>                 return -EIO;
> 
>         rc = i3200_probe1(pdev, ent->driver_data);
> +       if (rc)
> +               return rc;
> +
>         if (!mci_pdev)
>                 mci_pdev = pci_dev_get(pdev);
> 
> -       return rc;
> +       return 0;
>  }
> 
>  static void i3200_remove_one(struct pci_dev *pdev)
> @@ -529,10 +532,10 @@ static void __exit i3200_exit(void)
>         edac_dbg(3, "MC:\n");
> 
>         pci_unregister_driver(&i3200_driver);
> -       if (!i3200_registered) {
> +       if (!i3200_registered)
>                 i3200_remove_one(mci_pdev);
> -               pci_dev_put(mci_pdev);
> -       }
> +
> +       pci_dev_put(mci_pdev);
>  }
> 
>  module_init(i3200_init);

$ ./scripts/get_maintainer.pl -f drivers/edac/i3000_edac.c
...
EDAC-I3000 status: Orphan

No need to fix anything here.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
