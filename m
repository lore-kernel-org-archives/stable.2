Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889393CB2EF;
	Thu,  2 Jul 2026 11:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782991453; cv=none; b=DU1oFSOTsf3FuII3vuit6Ps6kMkc0wdbvln9AXtXYsb2W1YgwGBPS191qfd0ve6BTt8OJaEe6EHJdWtDYtwJJQGcC5qJwrIiSL1J6yHduEL2ibus/hCwwDWU8m2vDboKwDpfWdeZc+FZHTh6WzpXIA/flCdMZYDvJzbtNKNLDRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782991453; c=relaxed/simple;
	bh=qkoV9s2y6x4yNdhq0hTzUvepfbsJFBQynC64lFxnuaw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RM6ybe1GF3NeZkBE7sV/SYhnZCPE/gSdoTuKsoVCZTPi6wn/CpSkhJaGyMjO37/98DB0V5fCZMrUnFySS1fC4LR2GxcVveFZMFC+avIPJDi+M0ZW4KcfQHmfWH+SP/etmpDFWwy3X3gnKUXAWRkv1QaEWd3suX0faxIvKaJmDCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gRKPHQdn; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gRKPHQdn"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0F44C1A0DDF;
	Thu,  2 Jul 2026 11:24:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C2EE85FF03;
	Thu,  2 Jul 2026 11:24:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EEBBF104C9625;
	Thu,  2 Jul 2026 13:23:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782991441; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=UhZPL9qBPAYg4jDprXnZJkURUAU98LtK2IDx/RRjPVY=;
	b=gRKPHQdndkfSqFS49JzsIHQw2aOVyEHrPo49N6M5vahEK4abVvfiNdgAcQZ85BqTYrDYa7
	bgLIWbFxIEkSIFB0swC6iE9XJv8Ex/UNCwCUK2VH602vIVMKlgsgkVCB0kMkLUyVlXGAwh
	WrlKxRi9YwfmHOoRW6XGCBIo2DbY76dKZcM2qU5WCc/tgL8G73urX+4WNs4mRzBaqFyTms
	wzbg1YIUbmzkq/tLQjIDWEDm3GV8tSD7knUa16eYfGis9bnzsGsQnl51p65DzPCBQGMT2K
	5finRL11wVel1S/u3qrLN6S4dAT3WZZiydzHKCLvRx/mUD38ag2hi2cYxOCn9w==
Date: Thu, 2 Jul 2026 13:23:48 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Richard Cheng <icheng@nvidia.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, Saravana
 Kannan <saravanak@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 David Rhodes <david.rhodes@cirrus.com>, Richard Fitzgerald
 <rf@opensource.cirrus.com>, Charles Keepax <ckeepax@opensource.cirrus.com>,
 Linus Walleij <linusw@kernel.org>, Len Brown <lenb@kernel.org>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally
 <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>, Dave Jiang
 <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, Lizhi Hou
 <lizhi.hou@amd.com>, driver-core@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-sound@vger.kernel.org, patches@opensource.cirrus.com,
 linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-cxl@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, Daniel Machon
 <daniel.machon@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, stable@vger.kernel.org
Subject: Re: [PATCH v8 7/8] PCI: of: Set fwnode device of newly created PCI
 device nodes
Message-ID: <20260702132348.034264b6@bootlin.com>
In-Reply-To: <akXg4G4ksietvkwE@MWDK4CY14F>
References: <20260630102804.413563-1-herve.codina@bootlin.com>
	<20260630102804.413563-8-herve.codina@bootlin.com>
	<akXg4G4ksietvkwE@MWDK4CY14F>
Organization: Bootlin
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Richard,

On Thu, 2 Jul 2026 12:02:35 +0800
Richard Cheng <icheng@nvidia.com> wrote:

> > @@ -709,6 +709,13 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
> >  	if (ret)
> >  		goto out_free_node;
> >  
> > +	/*
> > +	 * Set the fwnode device in order to have fw_devlink creating links
> > +	 * pointing to this PCI device instead of walking up to the PCI host
> > +	 * bridge.
> > +	 */
> > +	fw_devlink_set_device(&np->fwnode, &pdev->dev);
> > +
> >  	ret = of_changeset_apply(cset);
> >  	if (ret)
> >  		goto out_free_node;
> > -- 
> > 2.54.0
> > 
> >  
> 
> Hi Herve,
> 
> I wonder if this part has some issue, it sets np->fwnode.dev = &pdev->dev,
> but I don't see am matching clear on removal path, I doubt the back-pointer
> can outlive the pci_dev.
> 
> device_del() do the check
> """
> if (dev->fwnode && dev->fwnode->dev == dev)
>     fw_devlink_set_device(dev->fwnode, NULL);
> """
> 
> On removal, pci_stop_dev() calls of_pci_remove_node() before pci_destroy_dev()
> calls device_del(), and of_pci_remove_node() -> device_remove_of_node() has already NULLed pdev->dev.fwnode by then, so the "dev->fwnode" guard is false, and
> of_pci_remove_node() itself never clears np->fwnode.dev
> 
> If something holds an extra ref on np past removal, e.g. a DT overlay applied via configfs that pins np through its gragment targets,
> np survives, the pci_dev is freed, and np->fwnode.dev dnalges into freed memory.
> Then fw_devlink walker that resolve it via get_dev_from_fwnode() -> get_device() would hit a use-after-free .
> 
> I think of_pci_remove_node() should cleaer the back-pointer it set,
> before dropping the node's ref, e.g.
> 
> """
> np = pci_device_to_OF_node(pdev);
> if (!np || !of_node_check_flag(np, OF_DYNAMIC))
>     return;
> 
> fw_devlink_set_device(&np->fwnode, NULL);
> device_remove_of_node(&pdev->dev);
> of_changeset_revert(np->data);
> """
> 
> Does that make sense to you ?
> 

Thanks for pointed out this issue.

I am not sure that the scenario you proposed using configfs which can lead
to the use-after-free is relevant but anyway this use-after-free is possible.

The fwnode->dev is set by of_pci_make_dev_node() and so it is consistent 
to unset it (set to NULL) in of_pci_remove_node().

I will update this patch to add the fw_devlink_set_device(&np->fwnode, NULL);
call in the next iteration.

Also I will had a new patch in the next iteration to perform same operation
for PCI root bridge. Same kind of code path, and so same issue but with
of_pci_make_host_bridge_node() and of_pci_remove_host_bridge_node().

Best regards,
Hervé
