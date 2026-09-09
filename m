Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F1953ED07
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953275; cv=none; b=LU8bWIeIUuIbConOHB3ULStHoSDd4o8BnZdJUWfVcJqEzd1Vu5104jB0VU4yPGmyMk3T+d2EjITBYRECQk0puoQLRjShsTLDhTbP6KDsTLOFefmOriDBnNO+MDSqgDLIK162i+AQ0q+sXnSJhxnTo8MAfpzLZLxtNRhNWoValB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953275; c=relaxed/simple;
	bh=JJBgofp2pe9RCsL65EmLQklp4DEK1h2O8rEip2QGCW4=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TI9CkwV7k5/YAGPR0B8ft17zfUl3h9rPg9fQJnZvGpZvxze2eLlgeQTckVIN1CzDj8d5pwWL9AtKfXHFIEBOHgX/uvIgWJISerVcDLVEz77CC9cm63iHXL79biDrwhKJNabL0+QRpJfySqKuIujeTvAgis8pk7cEkiZ0CYgZwMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjiZ8XBd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjiZ8XBd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94AE41F0155B
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788953273;
	bh=3jiQyn42rIxemPjlFRLmdJmNQuLfss1eu61probES9o=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=fjiZ8XBdNPsN183InFRv0uIGqWcQgVMgWYF8Nz1i3uO8x3JtYZ027bGAYG6OmYwHS
	 B34buxTmhnZs5QLlUGSuvQETka0bRRRQv1m3KwCA8AWUTmrPJ8skJDaxUfIMvGKZFE
	 nisCHiXVdzZ3WopzUcXJ6LKJ04IuduKPvjfXxRXGS1T0OpbPIynxC/1IcjgUFquYPc
	 9xWVH6oC6JVqyoYTgb1B6b2EBuWsioHAOP6Sc/C7+BpJqMhysnGtpfgiRtCCovCaDz
	 51P2TvYfiwAP0lpTJT/MK/tMFl0mr181rUwldfJvyj2QkhLa6b4mTnX3VjPFFLH+IB
	 30j4Slq3fgQSg==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5b808456308so325366e87.0
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 04:27:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzW0dnMB7vMyaJiL89B4Yg9y1dZGWB2xnH8Knz85JxGONdLBBfzs61nhiPDWQ9OczwxjqrctMk=@vger.kernel.org
X-Gm-Message-State: AFuF++nNufCjO/R89U00SozNUE4eBFbOTPtyoYC+th+Iwoxe1PRUB4nJ
	IMAYRp25pY4AnV3WVPnlguociz5KcZJKhKP3CtUylEM7VcTZqi5g8tRUXVF8IVn09kxF+NlCtho
	q41u23RCfyApwjCBW5QLagiFUaNqWI8onkhju8HQ8Gg==
X-Received: by 2002:a05:6512:3a8d:b0:5b4:a836:13f3 with SMTP id
 2adb3069b0e04-5b6170525c5mr5848674e87.19.1788953272225; Wed, 09 Sep 2026
 04:27:52 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Sep 2026 04:27:50 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Sep 2026 04:27:49 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260909080114.591938-7-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909080114.591938-1-herve.codina@bootlin.com> <20260909080114.591938-7-herve.codina@bootlin.com>
Date: Wed, 9 Sep 2026 04:27:49 -0700
X-Gmail-Original-Message-ID: <CAMRc=MeUtCK1SnOk7aAQrnpmZrSxQ1kK-hrw97TH5TBwFR04MQ@mail.gmail.com>
X-Gm-Features: AcwNN1XgkJRIkWr-Q-vmNlBTGGna2wUXbTKL0GfXX3gNNSE-nKv4XSkZWRFV2s4
Message-ID: <CAMRc=MeUtCK1SnOk7aAQrnpmZrSxQ1kK-hrw97TH5TBwFR04MQ@mail.gmail.com>
Subject: Re: [PATCH v11 06/10] PCI: of: Use fw_devlink_set_device()
To: Herve Codina <herve.codina@bootlin.com>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org, 
	Allan Nielsen <allan.nielsen@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Daniel Machon <daniel.machon@microchip.com>, Steen Hegelund <steen.hegelund@microchip.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	stable@vger.kernel.org, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, Richard Cheng <icheng@nvidia.com>, 
	Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Charles Keepax <ckeepax@opensource.cirrus.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, David Rhodes <david.rhodes@cirrus.com>, 
	Linus Walleij <linusw@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Len Brown <lenb@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>, 
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, 
	Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, Lizhi Hou <lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Sep 2026 10:01:05 +0200, Herve Codina <herve.codina@bootlin.com> said:
> The code set directly fwnode.dev field.
>
> Use the dedicated fw_devlink_set_device() helper to perform this
> operation.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Richard Cheng <icheng@nvidia.com>
> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
> Cc stable because used by other patches with Fixes + Cc stable
> ---
>  drivers/pci/of.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index a51dff91b196..0f45c5b72458 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -882,7 +882,7 @@ void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge)
>  	 * bus. Avoid any new device creation.
>  	 */
>  	of_node_set_flag(np, OF_POPULATED);
> -	np->fwnode.dev = &bridge->dev;
> +	fw_devlink_set_device(&np->fwnode, &bridge->dev);
>  	fwnode_dev_initialized(&np->fwnode, true);
>
>  	ret = of_changeset_apply(cset);
> --
> 2.55.0
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
